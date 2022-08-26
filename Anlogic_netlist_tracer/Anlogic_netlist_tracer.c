//----------------------------------------------------------------------------------------------------------------------------------

//This is experimental software to try to reverse engineer a specific Anlogic FPGA design
//and is not written with security and reliability in mind.
//There are no checks on if memory is actually allocated!!!

//----------------------------------------------------------------------------------------------------------------------------------

#include <stdio.h>      // standard input / output functions
#include <stdlib.h>
#include <string.h>

//----------------------------------------------------------------------------------------------------------------------------------

#define BITSPERCOLUMN            31
#define BITSPERROW               54

#define COLUMNS                  35      //x last is 34
#define ROWS                     38      //y last is 37

#define LAST_COLUMN            (COLUMNS - 1)  
#define LAST_ROW               (ROWS - 1)  

#define FRAMES                 1075
#define BITS_PER_FRAME         2056
#define DB_BITS_PER_FRAME      2052
#define BRAM_BITS_PER_FRAME    9216
#define GAP                      64

#define MAXENTITIES              32

#define TYPE_ERROR               -1
#define TYPE_NONE                 0
#define TYPE_STARTPOINT           1    //Start of a net which has an output as start point
#define TYPE_ENDPOINT             2    //End of a net which has an input as endpoint
#define TYPE_NET                  3    //A single net that has an output as start point and an input as endpoint
#define TYPE_ROUTEPOINT           4    //In between point which has an interconnect entity as start and end point

#define SIGNAL_NONE               0
#define SIGNAL_GND                1
#define SIGNAL_GCLK               2
#define SIGNAL_OUTPUT             3
#define SIGNAL_INPUT              4

#define BLOCK_NONE                0
#define BLOCK_PAD                 1
#define BLOCK_MSLICE              2
#define BLOCK_LSLICE              3
#define BLOCK_FIFO                4
#define BLOCK_EMB                 5
#define BLOCK_EMB_32K             6
#define BLOCK_DSP                 7
#define BLOCK_CLKDIV              8
#define BLOCK_OSC                 9
#define BLOCK_PLL                10
#define BLOCK_GCLK_CSB           11
#define BLOCK_GCLK_PREMUX        12
#define BLOCK_GCLK_CTMUX         13
#define BLOCK_GCLK_SPINE         14
#define BLOCK_CONFIG             15
#define BLOCK_OTHER              16

//----------------------------------------------------------------------------------------------------------------------------------

#include "database/database.h"

#include "frames/frame_bit_mapping.h"

#include "database/lqfp144_io_pads.h"

#include "database/al3_10_tile_signal_map.h"

//----------------------------------------------------------------------------------------------------------------------------------

typedef unsigned char  uchar;
typedef unsigned int   uint;

typedef unsigned char  uint8;
typedef unsigned short uint16;
typedef unsigned int   uint32;

typedef struct tagBITDATAPOINTERS  BITDATAPOINTERS,  *pBITDATAPOINTERS;
typedef struct tagBITNAMES         BITNAMES,         *pBITNAMES;

typedef struct tagBITLISTITEM      BITLISTITEM,      *pBITLISTITEM;

typedef struct tagBLOCKINFOITEM    BLOCKINFOITEM,    *pBLOCKINFOITEM,    **ppBLOCKINFOITEM;

typedef struct tagNAMEITEM         NAMEITEM,         *pNAMEITEM;
typedef struct tagROUTEINFOITEM    ROUTEINFOITEM,    *pROUTEINFOITEM;

typedef struct tagNETLISTITEM      NETLISTITEM,      *pNETLISTITEM,      **ppNETLISTITEM;

//----------------------------------------------------------------------------------------------------------------------------------

struct tagBITDATAPOINTERS
{
  int             count;
  pCONFIGBITDATA  data;
};

struct tagBITNAMES
{
  char *name;
  int   length;
  int   divider;
};

struct tagNAMEITEM
{
  char *name;
  int   length;
};

struct tagBITLISTITEM
{
  //This one is for the linking of the tile array list entries
  pBITLISTITEM   link;
  
  //These are for the sorted list
  pBITLISTITEM   prev;
  pBITLISTITEM   next;
  
  pTILEGRIDDATA  tiledata;
  pCONFIGBITDATA bitdata;
  pTILEPADPINMAP paddata;
  
  int            blocknumber;
};

struct tagBLOCKINFOITEM
{
  pBLOCKINFOITEM  next;
  
  int             x;
  int             y;
  
  int             blocknumber;
  int             blocktype;
  
  int             lutid;
  int             sliceid;
  int             padid;
  int             pinnumber;
  int             embid;
  int             pllid;
  
  char           *tiletype;
};


struct tagROUTEINFOITEM
{
  pROUTEINFOITEM prev;              //Linked list pointers
  pROUTEINFOITEM next;
  
  pTILEGRIDDATA  tiledata;          //Info about the tile the bit belongs to
  pCONFIGBITDATA bitdata;           //Info about what the bit means
  pTILEPADPINMAP paddata;           //Info about the IO pad the bit possibly belongs to

  pROUTEINFOITEM matingrouteitem;   //When a connection pair is found the other bit is linked here
  
  int            toptilex;          //Coordinates of the tile a block belongs to
  int            toptiley;          //For pad and emb slices these can differ from the signal coordinates
  
  int            netnumber;         //Net this bit belongs to
  int            netsignal;         //Type of signal
  
  int            blocknumber;       //Id of the block this route point connects to
  int            blocktype;         //The type of the block this route point connects to

  int            lutid;
  int            sliceid;
  int            padid;
  int            pinnumber;
  int            embid;
  int            pllid;
  
  int            routetype;         //Route type for this bit that signals for instance a start or end point 
  int            routestartentity;  //The ARCVAL entity that is used in the match with the mating bit
  int            routeconnected;    //A flag to signal a connection to the next node has been made
  
  pSIGNALNAMEMAP signalname;        //Pointer to the translated signal name
  pTILESIGNALMAP signalprefix;      //Pointer to the signal prefix
  
  int            nofentities;       //The number of entities to check
  
  NAMEITEM       startpoints[MAXENTITIES];
  NAMEITEM       endpoints[MAXENTITIES];
  NAMEITEM       pointpairs[MAXENTITIES];
};

struct tagNETLISTITEM
{
  pNETLISTITEM prev;
  pNETLISTITEM next;

  pROUTEINFOITEM routebit;
};

//----------------------------------------------------------------------------------------------------------------------------------

uchar fpga_frames[FRAMES][BITS_PER_FRAME / 8];

uchar bitstreamdata[2097152];

uchar fpga_tiles[COLUMNS][ROWS];

//----------------------------------------------------------------------------------------------------------------------------------

#define DESIGN 1

#if DESIGN == 1
#include "pin_assignments/1013D_pin_assignment.h"

#define FILENAME   "fpgas/Original_1013D_fpga"
#elif DESIGN == 2
#include "pin_assignments/1014D_pin_assignment.h"

#define FILENAME   "fpgas/Original_1014D_fpga"
#elif DESIGN == 3
#include "pin_assignments/pin_test_pin_assignment.h"

#define FILENAME   "/home/peter/Data/Anlogic_projects/pin_test/pin_test"
#elif DESIGN == 4
#include "pin_assignments/1013D_pin_assignment.h"

#define FILENAME   "/home/peter/Data/Anlogic_projects/Scope15/Scope15"
#endif

//----------------------------------------------------------------------------------------------------------------------------------

//Array for gathering the routing bits in a tile
pROUTEINFOITEM tileroutearray[COLUMNS][ROWS];

//Counters to keep track of the number of route bits
int tileroutecountarray[COLUMNS][ROWS];
int tileroutecount;

//Array for gathering settings bits for the tiles
pBITLISTITEM tilesetuparray[COLUMNS][ROWS];

//A sorted list of the blocks
pBLOCKINFOITEM  blocklist = 0;
ppBLOCKINFOITEM blocklistlast = 0;

//A sorted list of setup bits
pBITLISTITEM    blocksetuplist = 0;

//A sorted route list is made in this list
pNETLISTITEM  routelist = 0;

//A sorted and filtered net list is made in this list
pNETLISTITEM  netlist = 0;
ppNETLISTITEM netlistlast  = 0;

//----------------------------------------------------------------------------------------------------------------------------------

int strnicmp(char *str1, char *str2, int length)
{
  char c1,c2;

  while(*str1 && *str2 && length)
  {
    c1 = *str1 & 0x5F;
    c2 = *str2 & 0x5F;

    if(c1 < c2)
      return(-1);

    if(c1 > c2)
      return(1);

    str1++;
    str2++;
    length--;
  }
  
  if(length == 0)
    return(0);

  if(*str1)
    return(1);

  if(*str2)
    return(-1);

  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------
//Table with bit names that are related to IO pads

const BITNAMES bitnames[] =
{
  { "MC1_DIS_GSR_",     12, 1 },
  { "MC1_DO_SET_",      11, 1 },
  { "MC1_IDDR_",         9, 1 },
  { "MC1_IN_SET_",      11, 1 },
  { "MC1_INCE_EN_",     12, 1 },
  { "MC1_INCLK_EN_",    13, 1 },
  { "MC1_INCLK_INV_",   14, 1 },
  { "MC1_INDLY_EN_",    13, 1 },
  { "MC1_INRST_EN_",    13, 1 },
  { "MC1_ISE_EN_",      11, 1 },
  { "MC1_ODDR_",         9, 1 },
  { "MC1_ODFF_",         9, 1 },
  { "MC1_OUTCE_EN_",    13, 1 },
  { "MC1_OUTCLK_EN_",   14, 1 },
  { "MC1_OUTCLK_INV_",  15, 1 },
  { "MC1_OUTRST_EN_",   14, 1 },
  { "MC1_RST_ASYN_",    13, 1 },
  { "MC1_TRI_",          8, 1 },
  { "MC1_TS_SET_",      11, 1 },
  { "MC1_TSDFF_",       10, 1 },
  { "MC1_TSINV_",       10, 1 },
  { "MC1_DEDCLKO_EN_",  15, 1 },
  { "MC12_CLAMP_",      11, 1 },
  { "MC12_ENIND_",      11, 1 },
  { "MC12_ENINR_",      11, 1 },
  { "MC12_ENINS_N_",    13, 1 },
  { "MC12_ENLVDS_",     12, 1 },
  { "MC12_PWRGURD_EN_", 16, 1 },
  { "MC12_RDIFF_",      11, 1 },
  { "MC12_USR_PD_",     12, 1 },
  { "MC12_USR_PU_N_",   14, 1 },
  { "MC1_CLK_SRC_",     12, 2 },
  { "MC12_ENVR_",       10, 2 },
  { "MC12_H2L_",         9, 2 },
  { "MC12_INSBT_",      11, 2 },
  { "MC12_SLEW_",       10, 2 },
  { "MC12_VRDRV_",      11, 2 },
  { "MC1_LATCHMD_N_",   14, 3 },
  { "MC1_INDLY_SEL_",   14, 5 },
  { "MC12_ENSNK_",      11, 5 },
  { "MC12_ENSRC_",      11, 5 }
};

//----------------------------------------------------------------------------------------------------------------------------------

void getpinmapfortile(pBITLISTITEM item, pBLOCKINFOITEM block)
{
  int iol = -1;
  int i;
  
  pCONFIGBITDATA bitdata = item->bitdata;
  
  int x = item->tiledata->x;
  int y = item->tiledata->y;
  
  //Check the items that have a relation with a pad
  for(i=0;i<sizeof(bitnames) / sizeof(BITNAMES);i++)
  {
    //Compare the name to see if it matches with the current bit name
    if(strncmp(bitdata->name, bitnames[i].name, bitnames[i].length) == 0)
    {
      //When found calculate the pad number
      //The names are followed by a number that can be a multiple of the pad number and have a relation to the actual pad based on it.
      iol = atoi(&bitdata->name[bitnames[i].length]) / bitnames[i].divider;
      break;
    }
  }
  
  //When no bit name matches check if it is a mux select
  if((iol == -1) && (strncmp(bitdata->name, "TOP.", 4) == 0))
  {
    //For XI numbers from 300 and above it could be an IO route
    if(atoi(&bitdata->name[6]) >= 300)
    {
      //To check if it is a IO mux the first data item can be checked
      if(bitdata->datacount)
      {
        //This property seems to be a correct indicator for a pad number
        if(strncmp(bitdata->bitdata[0].data, "PROPERTY(IOL", 12) == 0)
        {
          iol = atoi(&bitdata->bitdata[0].data[12]);
        }
      }
    }
  }  
  
  //Check if a pad number has been found
  if(iol != -1)
  {
    //Set the pad id for this bit
    block->padid = iol;
    
    //See if it has a pin connected to it
    for(i=0;i<sizeof(tilepadmap)/sizeof(TILEPADPINMAP);i++)
    {
      if((x == tilepadmap[i].x) && (y == tilepadmap[i].y) && (iol == tilepadmap[i].iol))
      {
        item->paddata = (const pTILEPADPINMAP)&tilepadmap[i];
        
        block->pinnumber = item->paddata->pin;
      }
    }
  }  
}

//----------------------------------------------------------------------------------------------------------------------------------

void addtotilesetuplist(pTILEGRIDDATA tiledata, pCONFIGBITDATA bitdata)
{
  pBITLISTITEM bitlistitem;
  
  //Get memory for the bit list item for this bit
  bitlistitem = malloc(sizeof(BITLISTITEM));

  //Clear the linked list items for sorting
  bitlistitem->prev = 0;
  bitlistitem->next = 0;
  
  //Set the source information
  bitlistitem->tiledata = tiledata;
  bitlistitem->bitdata  = bitdata;
  bitlistitem->paddata  = 0;
  
  //Signal not assigned yet
  bitlistitem->blocknumber = -1;
  
  //Check if the route info list for this tile is not already started
  if(tilesetuparray[tiledata->x][tiledata->y] == 0)
  {
    //First item in the list, so no previous and next
    bitlistitem->link = 0;
    
    //Set it as the first item of the list
    tilesetuparray[tiledata->x][tiledata->y] = bitlistitem;
  }
  else
  {
    //Not the first item so add it to the start of the list since it is quicker then looping to the end
    bitlistitem->link = tilesetuparray[tiledata->x][tiledata->y];

    //Set it as the first item of the list
    tilesetuparray[tiledata->x][tiledata->y] = bitlistitem;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void additemtoblocklist(pBLOCKINFOITEM item)
{
  //Add the route point to the net list
  if(blocklist == 0)
  {
    //No items added yet so start with this one
    blocklist = item;
  }
  else
  {
    //List exists so add to it
    *blocklistlast = item;
  }
    
  //Point to where the next item needs to be added
  blocklistlast = &item->next;
}

//----------------------------------------------------------------------------------------------------------------------------------

void additemtofinalnetlist(pROUTEINFOITEM item)
{
  //Get memory for the net list item for this bit
  pNETLISTITEM netitem = malloc(sizeof(NETLISTITEM));

  //Setup the net list item
  netitem->routebit= item;
  netitem->next = 0;

  //Add the route point to the net list
  if(netlist == 0)
  {
    //No items added yet so start with this one
    netlist = netitem;
  }
  else
  {
    //List exists so add to it
    *netlistlast = netitem;
  }
    
  //Point to where the next item needs to be added
  netlistlast = &netitem->next;
}

//----------------------------------------------------------------------------------------------------------------------------------

void insertitembeforenetlist(pNETLISTITEM current, pNETLISTITEM new)
{
  //Do an insert
  //Check if first item of the list
  if(current->prev == 0)
  {
    //If so make this one the first item in the list, so no previous
    new->prev = 0;
    new->next = current;

    //Set the back track connection
    current->prev = new;

    //Set it as the first item of the list
    routelist = new;
  }
  else
  {
    //Insert it in the list
    //Link the new item to the previous item
    new->prev = current->prev;
    current->prev->next = new;

    //Link the item to insert before to the new item
    new->next = current;
    current->prev = new;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void additemtonetlist(pROUTEINFOITEM routebit)
{
  pNETLISTITEM  addlist;
  
  //Get memory for the net list item for this bit
  pNETLISTITEM netitem = malloc(sizeof(NETLISTITEM));
  
  //Setup the net list item
  netitem->routebit = routebit;
  
  //Add the route point to the net list
  if(routelist == 0)
  {
    //First item in the list, so no previous and next
    netitem->prev = 0;
    netitem->next = 0;
    
    //No items added yet so start with this one
    routelist = netitem;
  }
  else
  {
    //Need to loop through to make a sorted list
    addlist = routelist;
    
    //Look for where the data needs to be inserted or replaced
    while(addlist)
    {
      //Sort on net number
      if(routebit->netnumber < addlist->routebit->netnumber)
      {
        //Insert the item before the current one
        insertitembeforenetlist(addlist, netitem);
        break;
      }
    
      //Point to the next item if there is one
      if(addlist->next)
      {
        //Select the next item
        addlist = addlist->next;
      }
      else
      {
        //Append to the list when this is the last item
        netitem->prev = addlist;
        netitem->next = 0;
        addlist->next = netitem;

        //Done so quit
        break;
      }
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void addtotileroutearray(pTILEGRIDDATA tiledata, pCONFIGBITDATA bitdata)
{
  pROUTEINFOITEM routinfoitem;

  char *name;
  char *end;
  int   count;

  //Add the item to the tile route array based on the tile it belongs to
  //Need to create a route info item to dissect the data into.
  routinfoitem = malloc(sizeof(ROUTEINFOITEM));
  
  //Check if the route info list for this tile is not already started
  if(tileroutearray[tiledata->x][tiledata->y] == 0)
  {
    //First item in the list, so no previous and next
    routinfoitem->prev = 0;
    routinfoitem->next = 0;
    
    //Set it as the first item of the list
    tileroutearray[tiledata->x][tiledata->y] = routinfoitem;
  }
  else
  {
    //Not the first item so add it to the start of the list since it is quicker then looping to the end
    routinfoitem->prev = 0;
    routinfoitem->next = tileroutearray[tiledata->x][tiledata->y];

    //Set the back track connection
    tileroutearray[tiledata->x][tiledata->y]->prev = routinfoitem;

    //Set it as the first item of the list
    tileroutearray[tiledata->x][tiledata->y] = routinfoitem;
  }

  //Adjust the counters for later checking if all route bits have been handled
  tileroutecountarray[tiledata->x][tiledata->y]++;
  tileroutecount++;
  
  //Set the data for later use
  routinfoitem->tiledata = tiledata;
  routinfoitem->bitdata  = bitdata;
  
  //No type determined yet
  routinfoitem->routetype = TYPE_NONE;
  
  //No start entity found yet
  routinfoitem->routestartentity = 0;
  
  //No connection yet
  routinfoitem->routeconnected = 0;
  
  //No net number assigned yet
  routinfoitem->netnumber = 0;
  
  //No mating bit found yet
  routinfoitem->matingrouteitem = 0;
  
  //Need to dissect the data into start and end points
  //Set the count for limiting searching through only the actual data
  routinfoitem->nofentities = bitdata->datacount;
  
  //Walk through all the data items
  for(count=0;count<bitdata->datacount;count++)
  {
    //The data has the following format
    //ARCVAL(S6BEG0,E1END0)

    //Need to make sure the data is an ARCVAL item
    if(strncmp(bitdata->bitdata[count].data, "ARCVAL(", 7) == 0)
    {
      //Point to the first entity in the array
      name = &bitdata->bitdata[count].data[7];

      //Set the name in the point pair for matching complete pairs
      routinfoitem->pointpairs[count].name = name;
      
      //Find the end of it
      end = strstr(name, ",");

      //First entity is an end point
      routinfoitem->endpoints[count].name   = name;
      routinfoitem->endpoints[count].length = end - name;

      //Point to the next entity in the array
      name = &end[1];

      //Find the end of it
      end = strstr(name, ")");
      
      //Second entity is a start point
      routinfoitem->startpoints[count].name   = name;
      routinfoitem->startpoints[count].length = end - name;
      
      //Set the length in the point pair for matching complete pairs
      routinfoitem->pointpairs[count].length = end - routinfoitem->pointpairs[count].name;
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------
//This function checks if there are multiple connections made to a block output or an incoming wire

int findmatchingpoints(pROUTEINFOITEM routeinfoitem, int netnumber, int routetype)
{
  int item = routeinfoitem->routestartentity;
  int pair;
  
  char *name;
  int   length;
  
  pTILEGRIDDATA  tiledata = routeinfoitem->tiledata;
  
  pROUTEINFOITEM tileroutelist;
  
  pROUTEINFOITEM matchitem;
  pROUTEINFOITEM matchlist;
  
  //Get the current start point entity to check
  name   = routeinfoitem->startpoints[item].name;
  length = routeinfoitem->startpoints[item].length;

#if 0
  if((tiledata->x == 25) && (tiledata->y == 17) && ((strncmp(name, "N2END1", 6) == 0)))
  {
    pair = 0;
  }
#endif

  //Get the route list for the tile the original route belongs to
  tileroutelist = tileroutearray[tiledata->x][tiledata->y];
  
  //Check the other route bits in this tile for a matching start point
  while(tileroutelist)
  {
#if 0
    if((tileroutelist->tiledata->x == 25) && (tileroutelist->tiledata->y == 17) && ((strcmp(tileroutelist->bitdata->name, "TOP.XI1.MC17") == 0) || (strcmp(tileroutelist->bitdata->name, "TOP.XI1.MC12") == 0)))
    {
      pair = 0;
    }
#endif
    
    //Make sure this is not the original item and that it is not yet assigned
    if((tileroutelist != routeinfoitem) && (tileroutelist->routetype == TYPE_NONE))
    {
      //Check the items for this bit to see if it matches the start point
      for(item=0;item<tileroutelist->nofentities;item++)
      {
        //Check if the lengths match before comparing the strings
        if(tileroutelist->startpoints[item].length == length)
        {
          //See if it matches the current start point with the to test one
          if(strncmp(tileroutelist->startpoints[item].name, name, length) == 0)
          {
            //For a CLK wire it is a single bit connection when the end point is a CLK_S
            if((length == 4) && (tileroutelist->endpoints[item].length == 6) && (strncmp(name, "CLK", 3) == 0) && (strncmp(tileroutelist->endpoints[item].name, "CLK_S", 5) == 0))
            {
              //Set the index for the entity that matches for this route item
              tileroutelist->routestartentity = item;
              
              //Set the net number for this route item
              tileroutelist->netnumber = netnumber;
              
              //Make this a either a single point or an endpoint
              tileroutelist->routetype = TYPE_ENDPOINT;

              //Signal the bits as connected
              tileroutelist->routeconnected = 1;

              //This means one bit is done so adjust the counters
              tileroutecountarray[tileroutelist->tiledata->x][tileroutelist->tiledata->y]--;
              tileroutecount--;

              //Add this item to the net list
              additemtonetlist(tileroutelist);

              //Signal that a connection has been found
              return(1);
            }
            
            //Set the found one as the one to match with
            matchitem = tileroutelist;

            //Get the route list for the tile the original route belongs to again
            matchlist = tileroutearray[tiledata->x][tiledata->y];

            //Check the other route bits in this tile
            while(matchlist)
            {
              //Make sure this is not the original item
              if(matchlist != matchitem)
              {
                //Need a for loop to check the pairs here
                for(pair=0;pair<matchlist->nofentities;pair++)
                {
                  //Check if the lengths match before comparing the strings
                  if(matchitem->pointpairs[item].length == matchlist->pointpairs[pair].length)
                  {
                    //match the current pair with the to test one
                    if(strncmp(matchitem->pointpairs[item].name, matchlist->pointpairs[pair].name, matchitem->pointpairs[item].length) == 0)
                    {
                      //Set the index for the entity that matches for these route items
                      matchitem->routestartentity = item;
                      matchlist->routestartentity = pair;

                      //Get the current endpoint specifics
                      name   = matchitem->endpoints[item].name;
                      length = matchitem->endpoints[item].length;

                      //Determine if this is an end point for this net
                      //Check if the endpoint is a logic or io block input signal A, B, C, D, E, MI, CE, SR, CLKN_S
                      if(((length == 2) && ((name[0] == 'A') || (name[0] == 'B')  || (name[0] == 'C')  || (name[0] == 'D') || (name[0] == 'E'))) ||
                         ((length == 3) &&  (name[0] == 'M') && (name[1] == 'I')) ||
                         ((length == 3) &&  (name[0] == 'C') && (name[1] == 'E')) ||
                         ((length == 3) &&  (name[0] == 'S') && (name[1] == 'R')) ||
                         ((length == 7) &&  (name[0] == 'C') && (name[1] == 'L')  && (name[2] == 'K')  && (name[3] == 'N') && (name[4] == '_') && (name[5] == 'S')))                        
                      {
                        //Mark both route items as a net or endpoint depending on the source
                        matchitem->routetype = routetype;
                        matchlist->routetype = routetype;
                        
                        //Flag both route items as connected
                        matchitem->routeconnected = 1;
                        matchlist->routeconnected = 1;
                        
                        //This means two bits are done so adjust the counters
                        tileroutecountarray[tiledata->x][tiledata->y] -= 2;
                        tileroutecount -= 2;
                      }
                      else if((strncmp(&name[2], "BEG", 3) == 0) || (strncmp(name, "LOCAL", 5) == 0) || (strncmp(name, "CLK", 3) == 0))
                      {
                        //Mark both route items as a route point
                        matchitem->routetype = TYPE_ROUTEPOINT;
                        matchlist->routetype = TYPE_ROUTEPOINT;
                      }
                      else
                      {
                        //Mark both route items as a start point
                        matchitem->routetype = TYPE_STARTPOINT;
                        matchlist->routetype = TYPE_STARTPOINT;
                      }

                      //Set the net number for both items
                      matchitem->netnumber = netnumber;
                      matchlist->netnumber = netnumber;

                      //Add both items to the net list
                      additemtonetlist(matchitem);
                      additemtonetlist(matchlist);

                      //Link the two bits together
                      matchitem->matingrouteitem = matchlist;
                      matchlist->matingrouteitem = matchitem;

                      //Signal that a starting route has been found
                      return(1);
                    }
                  }              
                }
              }

              //Get the next item for pair matching
              matchlist = matchlist->next;
            }
          }
        }              
      }
    }

    //Select the next item to check for the starting point
    tileroutelist = tileroutelist->next;
  }
  
  //No matching start point found so also done
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

int checkstartingpoint(pROUTEINFOITEM routeinfoitem, int netnumber)
{
  int item;
  int pair;
  
  char *name;
  int   length;
  
  pTILEGRIDDATA  tiledata = routeinfoitem->tiledata;
  
  pROUTEINFOITEM tileroutelist;
  
  //Check all the arcval start point entities to see if it is an output (starting with F, FX or Q)
  for(item=0;item<routeinfoitem->nofentities;item++)
  {
    //Get the current start point entity to check
    name   = routeinfoitem->startpoints[item].name;
    length = routeinfoitem->startpoints[item].length;
    
    //When separate scanning is done for GND and GCLK nets then this can be simplified
    
#if 0    
    if((tiledata->x == 25) && (tiledata->y == 15) && (strcmp(routeinfoitem->bitdata->name, "TOP.XI20.MC10") == 0))
    {
      pair = 0;
    }
#endif
    
    //CE, SR can be both a start or an end point, but seeing them as start point is basically wrong so needs attention
    
    //The question is if CLK0 and CLK1 can be seen as a start point. It might be that they are local clock wires and as such part of bigger nets
    //For now they will be used as starting points too
    
    //Maybe a more dedicated matching can be done with strncmp and per type signal this in the route to know if it is a global clock or any of the other signals
    
    //See if the current start point matches an output entity
    if(((length == 2) && ((name[0] == 'F') || (name[0] == 'Q'))) ||
       ((length == 3) &&  (name[0] == 'F') && (name[1] == 'X'))  ||
       ((length == 3) &&  (name[0] == 'C') && (name[1] == 'E'))  ||
       ((length == 3) &&  (name[0] == 'S') && (name[1] == 'R')))
    {
      //Get the route list for the tile the original route belongs to
      tileroutelist = tileroutearray[tiledata->x][tiledata->y];

      //Check the other route bits in this tile
      while(tileroutelist)
      {
        //Make sure this is not the original item
        if(tileroutelist != routeinfoitem)
        {
          //Need a for loop to check the pairs here
          for(pair=0;pair<tileroutelist->nofentities;pair++)
          {
            //Check if the lengths match before comparing the strings
            if(routeinfoitem->pointpairs[item].length == tileroutelist->pointpairs[pair].length)
            {
              //match the current pair with the to test one
              if(strncmp(routeinfoitem->pointpairs[item].name, tileroutelist->pointpairs[pair].name, routeinfoitem->pointpairs[item].length) == 0)
              {
                //Set the index for the entity that matches for these route items
                routeinfoitem->routestartentity = item;
                tileroutelist->routestartentity = pair;
                
                //Get the current endpoint specifics
                name   = routeinfoitem->endpoints[item].name;
                length = routeinfoitem->endpoints[item].length;

                //Determine if this is an end point for this net
                //Check if the endpoint is a logic or io block input signal A, B, C, D, E, MI, CE, SR, CLKN_S
                //Clock nets also need to be set as single route nets
                if(((length == 2) && ((name[0] == 'A') || (name[0] == 'B')  || (name[0] == 'C')  || (name[0] == 'D') || (name[0] == 'E'))) ||
                   ((length == 3) &&  (name[0] == 'M') && (name[1] == 'I')) ||
                   ((length == 3) &&  (name[0] == 'C') && (name[1] == 'E')) ||
                   ((length == 3) &&  (name[0] == 'S') && (name[1] == 'R')) ||
                   ((length == 7) &&  (name[0] == 'C') && (name[1] == 'L')  && (name[2] == 'K')  && (name[3] == 'N')  && (name[4] == '_') && (name[5] == 'S')))
                {
                  //Mark both route items as a net since it is in the same tile as the start point
                  routeinfoitem->routetype = TYPE_NET;
                  tileroutelist->routetype = TYPE_NET;
                        
                  //Flag both route items as connected
                  routeinfoitem->routeconnected = 1;
                  tileroutelist->routeconnected = 1;

                  //This means two bits are done so adjust the counters
                  tileroutecountarray[tiledata->x][tiledata->y] -= 2;
                  tileroutecount -= 2;
                }
                else
                {
                  //Mark both route items as a start point
                  routeinfoitem->routetype = TYPE_STARTPOINT;
                  tileroutelist->routetype = TYPE_STARTPOINT;
                }
                
                //Set the net number for both items
                routeinfoitem->netnumber = netnumber;
                tileroutelist->netnumber = netnumber;

                //Add both items to the net list
                additemtonetlist(routeinfoitem);
                additemtonetlist(tileroutelist);
                
                //Link the two bits together
                routeinfoitem->matingrouteitem = tileroutelist;
                tileroutelist->matingrouteitem = routeinfoitem;
                
                //Signal that a starting route has been found
                return(1);
              }
            }              
          }
        }

        tileroutelist = tileroutelist->next;
      }
    }
  }
  
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

int findgndpoint(pROUTEINFOITEM routeinfoitem, int netnumber)
{
  int item;
  int pair;
  
  char *name;
  int   length;
  
  pTILEGRIDDATA  tiledata = routeinfoitem->tiledata;
  
  pROUTEINFOITEM tileroutelist;
  
  //Check all the arcval start point entities to see if it is a GND
  for(item=0;item<routeinfoitem->nofentities;item++)
  {
    //Get the current start point entity to check
    name   = routeinfoitem->startpoints[item].name;
    length = routeinfoitem->startpoints[item].length;
    
    //See if the current start point matches a  GND entity
    if((length == 3) &&  (strncmp(name, "GND", 3) == 0))
    {
      //Get the route list for the tile the original route belongs to
      tileroutelist = tileroutearray[tiledata->x][tiledata->y];

      //Check the other route bits in this tile
      while(tileroutelist)
      {
        //Make sure this is not the original item
        if(tileroutelist != routeinfoitem)
        {
          //Need a for loop to check the pairs here
          for(pair=0;pair<tileroutelist->nofentities;pair++)
          {
            //Check if the lengths match before comparing the strings
            if(routeinfoitem->pointpairs[item].length == tileroutelist->pointpairs[pair].length)
            {
              //match the current pair with the to test one
              if(strncmp(routeinfoitem->pointpairs[item].name, tileroutelist->pointpairs[pair].name, routeinfoitem->pointpairs[item].length) == 0)
              {
                //A GND route is always onto an signal input, so no need to check on it
                //Set the index for the entity that matches for these route items
                routeinfoitem->routestartentity = item;
                tileroutelist->routestartentity = pair;
                
                //Mark both route items as a net since it is in the same tile as the start point
                routeinfoitem->routetype = TYPE_NET;
                tileroutelist->routetype = TYPE_NET;

                //Flag both route items as connected
                routeinfoitem->routeconnected = 1;
                tileroutelist->routeconnected = 1;

                //This means two bits are done so adjust the counters
                tileroutecountarray[tiledata->x][tiledata->y] -= 2;
                tileroutecount -= 2;
                
                //Set the net number for both items
                routeinfoitem->netnumber = netnumber;
                tileroutelist->netnumber = netnumber;

                //Add both items to the net list
                additemtonetlist(routeinfoitem);
                additemtonetlist(tileroutelist);
                
                //Link the two bits together
                routeinfoitem->matingrouteitem = tileroutelist;
                tileroutelist->matingrouteitem = routeinfoitem;
                
                //Signal that a starting route has been found
                return(1);
              }
            }              
          }
        }

        tileroutelist = tileroutelist->next;
      }
    }
  }
  
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------



int findgclkpoint(pROUTEINFOITEM routeinfoitem, int netnumber, char *clkname, int clklength)
{
  int item;
  int pair;
  
  char *name;
  int   length;
  
  pTILEGRIDDATA  tiledata = routeinfoitem->tiledata;
  
  pROUTEINFOITEM tileroutelist;
  
  //Check all the arcval start point entities to see if it is a GND
  for(item=0;item<routeinfoitem->nofentities;item++)
  {
    //Get the current start point entity to check
    name   = routeinfoitem->startpoints[item].name;
    length = routeinfoitem->startpoints[item].length;
    
    //See if the current start point matches a GCLK entity
    if((length == clklength) &&  (strncmp(name, clkname, clklength) == 0))
    {
      //Get the route list for the tile the original route belongs to
      tileroutelist = tileroutearray[tiledata->x][tiledata->y];

      //Check the other route bits in this tile
      while(tileroutelist)
      {
        //Make sure this is not the original item
        if(tileroutelist != routeinfoitem)
        {
          //Need a for loop to check the pairs here
          for(pair=0;pair<tileroutelist->nofentities;pair++)
          {
            //Check if the lengths match before comparing the strings
            if(routeinfoitem->pointpairs[item].length == tileroutelist->pointpairs[pair].length)
            {
              //match the current pair with the to test one
              if(strncmp(routeinfoitem->pointpairs[item].name, tileroutelist->pointpairs[pair].name, routeinfoitem->pointpairs[item].length) == 0)
              {
                //A GCLK route is either onto an signal input or onto a local clock wire
                if((routeinfoitem->endpoints[item].length == 4) && (strncmp(routeinfoitem->endpoints[item].name, "CLK", 3) == 0))
                {
                  //Mark both route items as a route point since to allow connecting it to the destination
                  routeinfoitem->routetype = TYPE_ROUTEPOINT;
                  tileroutelist->routetype = TYPE_ROUTEPOINT;
                }
                else
                {
                  //Mark both route items as a net since it is in the same tile as the start point
                  routeinfoitem->routetype = TYPE_NET;
                  tileroutelist->routetype = TYPE_NET;

                  //Flag both route items as connected
                  routeinfoitem->routeconnected = 1;
                  tileroutelist->routeconnected = 1;

                  //This means two bits are done so adjust the counters
                  tileroutecountarray[tiledata->x][tiledata->y] -= 2;
                  tileroutecount -= 2;
                }
                
                //Set the index for the entity that matches for these route items
                routeinfoitem->routestartentity = item;
                tileroutelist->routestartentity = pair;
                
                //Set the net number for both items
                routeinfoitem->netnumber = netnumber;
                tileroutelist->netnumber = netnumber;

                //Add both items to the net list
                additemtonetlist(routeinfoitem);
                additemtonetlist(tileroutelist);
                
                //Link the two bits together
                routeinfoitem->matingrouteitem = tileroutelist;
                tileroutelist->matingrouteitem = routeinfoitem;
                
                //Signal that a starting route has been found
                return(1);
              }
            }              
          }
        }

        tileroutelist = tileroutelist->next;
      }
    }
  }
  
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------
//This function is for finding multiple route bit pairs for the given entity

pROUTEINFOITEM findrouteconnection(pROUTEINFOITEM searchlist, char *entity, int length, int netnumber)
{
  int item;
  int pair;
  
  pNAMEITEM      arcvalentity;
  
  pROUTEINFOITEM tileroutelist = searchlist;
  pROUTEINFOITEM matchlist;
  
  //Check the other route bits in this tile to find a matching pair
  while(tileroutelist)
  {
    //First check if the current route is not assigned yet. Have to figure out if this is correct.
    if(tileroutelist->routetype == TYPE_NONE)
    {
      //Next search through the start points to find the matching entity
      for(item=0;item<tileroutelist->nofentities;item++)
      {
        //Get the current start point entity to check
        arcvalentity = &tileroutelist->startpoints[item];
        
        //String check only needed when the lengths match
        if(length == arcvalentity->length)
        {
          //When the names match there is a possible connection
          if(strncmp(entity, arcvalentity->name, length) == 0)
          {
            //For a CLK wire it is a single bit connection when the end point is a CLK_S
            if((length == 4) && (tileroutelist->endpoints[item].length == 6) && (strncmp(entity, "CLK", 3) == 0) && (strncmp(tileroutelist->endpoints[item].name, "CLK_S", 5) == 0))
            {
              //Set the index for the entity that matches for this route item
              tileroutelist->routestartentity = item;
              
              //Set the net number for this route item
              tileroutelist->netnumber = netnumber;
              
              //Make this a either a single point or an endpoint
              tileroutelist->routetype = TYPE_ENDPOINT;

              //Signal the bits as connected
              tileroutelist->routeconnected = 1;

              //This means one bit is done so adjust the counters
              tileroutecountarray[tileroutelist->tiledata->x][tileroutelist->tiledata->y]--;
              tileroutecount--;

              //Add this item to the net list
              additemtonetlist(tileroutelist);

              //Signal that a connection has been found
              return(tileroutelist);
            }
            
            //Setup the list to search a match in
            matchlist = searchlist;

            //Check the other route bits in this tile
            while(matchlist)
            {
              //Make sure this is not the original item
              if(matchlist != tileroutelist)
              {
                //Check each arcval pair of this item to see if it matches
                for(pair=0;pair<matchlist->nofentities;pair++)
                {
                  //Check if the lengths match before comparing the strings
                  if(tileroutelist->pointpairs[item].length == matchlist->pointpairs[pair].length)
                  {
                    //Try to match the current pair with the to test one
                    if(strncmp(tileroutelist->pointpairs[item].name, matchlist->pointpairs[pair].name, tileroutelist->pointpairs[item].length) == 0)
                    {
                      //Set the index for the entity that matches for these route items
                      tileroutelist->routestartentity = item;
                      matchlist->routestartentity = pair;

                      //Get the current endpoint specifics
                      arcvalentity = &tileroutelist->endpoints[item];

                      //Determine if this is an end point for this net
                      //For the first entry it can be a single route net (only two route bits set for it) runs from an output to an input without an inter or local connect
                      //For the next entries it can be the end point
                      //Check if the endpoint is a logic or io block input signal A, B, C, D, E, MI, CE, SR, CLKN_S
                      if(((arcvalentity->length == 2) && ((arcvalentity->name[0] == 'A') || (arcvalentity->name[0] == 'B')  || (arcvalentity->name[0] == 'C')  || (arcvalentity->name[0] == 'D') || (arcvalentity->name[0] == 'E'))) ||
                         ((arcvalentity->length == 3) &&  (arcvalentity->name[0] == 'M') && (arcvalentity->name[1] == 'I')) ||
                         ((arcvalentity->length == 3) &&  (arcvalentity->name[0] == 'C') && (arcvalentity->name[1] == 'E')) ||
                         ((arcvalentity->length == 3) &&  (arcvalentity->name[0] == 'S') && (arcvalentity->name[1] == 'R')) ||
                         ((arcvalentity->length == 7) &&  (arcvalentity->name[0] == 'C') && (arcvalentity->name[1] == 'L')  && (arcvalentity->name[2] == 'K')  && (arcvalentity->name[3] == 'N') && (arcvalentity->name[4] == '_') && (arcvalentity->name[5] == 'S')))
                      {
                        //Make this a either a single point or an endpoint
                        tileroutelist->routetype = TYPE_ENDPOINT;
                        matchlist->routetype = TYPE_ENDPOINT;
                        
                        //Signal the bits as connected
                        tileroutelist->routeconnected = 1;
                        matchlist->routeconnected = 1;
                        
                        //This means two bits are done so adjust the counters
                        tileroutecountarray[tileroutelist->tiledata->x][tileroutelist->tiledata->y] -= 2;
                        tileroutecount -= 2;
                      }
                      else
                      {
                        //Mark both route items as route point
                        tileroutelist->routetype = TYPE_ROUTEPOINT;
                        matchlist->routetype = TYPE_ROUTEPOINT;
                      }
                      
                      //Set the net number for both items
                      tileroutelist->netnumber = netnumber;
                      matchlist->netnumber = netnumber;

                      //Add both items to the net list
                      additemtonetlist(tileroutelist);
                      additemtonetlist(matchlist);

                      //Link the pair to each other
                      tileroutelist->matingrouteitem = matchlist;
                      matchlist->matingrouteitem = tileroutelist;
                      
                      //Signal that a connection has been found
                      return(tileroutelist);
                    }
                  }              
                }
              }

              //Next item to match a pair with
              matchlist = matchlist->next;
            }
          }
        }
      }
    }

    //Next item to find a starting point in
    tileroutelist = tileroutelist->next;
  }
  
  //No match found so signal this. When on the last hop this needs to be considered an error
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

int findconnectionpoint(pROUTEINFOITEM routeinfoitem)
{
  char *name;
  int   length;
  
  int x;
  int y;

  char direction;
  char wire;
  
  char entity[12];
  
  int hop;
  int hops;
  int nexthop;
  
  int foundconnection = 0;
  
  pTILEGRIDDATA  tiledata = routeinfoitem->tiledata;
  
  pROUTEINFOITEM tileroutelist;
  pROUTEINFOITEM foundrouteitem = 0;

#if 1
  if((tiledata->x == 6) && (tiledata->y == 18) && (strcmp(routeinfoitem->bitdata->name, "TOP.XI280.MC11") == 0))
  {
    hop = 0;
  }
#endif
  
  //Get the endpoint entity to search for
  name   = routeinfoitem->endpoints[routeinfoitem->routestartentity].name;
  length = routeinfoitem->endpoints[routeinfoitem->routestartentity].length;
  
  //LOCAL connect wires are only driven from interconnect wires, and only drive local inputs
  //CE, SR and CLK are similar to local wires
  if((strncmp(name, "LOCAL", 5) == 0) || (strncmp(name, "CE", 2) == 0) || (strncmp(name, "SR", 2) == 0) || (strncmp(name, "CLK", 3) == 0))
  {
    //Get the route list to search, which is the current tile for a LOCAL route
    tileroutelist = tileroutearray[tiledata->x][tiledata->y];

    //Go and try to find a matching route set
    foundrouteitem = findrouteconnection(tileroutelist, name, length, routeinfoitem->netnumber);

    //Check if no match has been found
    if(foundrouteitem == 0)
    {
      //For a local connection a match should have been found
      //So when not, there is an error. Mark the bit pair as such
      //Might need a check on matingrouteitem being a valid pointer
      routeinfoitem->routetype = TYPE_ERROR;
      routeinfoitem->matingrouteitem->routetype = TYPE_ERROR;
    }
    else
    {
      //For a connection point see if there are more matches in the same tile for this specific one
      //Done here because for the interconnect there can be multiple connections on both the mid and the end point
      while(findmatchingpoints(foundrouteitem, foundrouteitem->netnumber, TYPE_ENDPOINT) == 1);
      
      //Signal a connection has been found
      foundconnection = 1;
    }
  }
  else if(strncmp(&name[2], "BEG", 3) == 0)
  {
    //Following an interconnect start point (BEG) E, W, N, S with a hop number and a wire number needs dissection of it
    //Get the direction, hop count and wire number
    //Based on the hop count and the direction, tile coordinates need to be calculated

    //The found tile route list needs to be searched for the matching connection
    //For a single hop look for a matching END
    //For a two or a six hop the MID connection needs to be checked too

    //Get the tile grid coordinates for the starting point
    x = tiledata->x;
    y = tiledata->y;

#if 0
    if((routeinfoitem->tiledata->x == 1) && (routeinfoitem->tiledata->y == 35) && ((strcmp(routeinfoitem->bitdata->name, "TOP.XI32.MC17") == 0) || (strcmp(routeinfoitem->bitdata->name, "TOP.XI32.MC10") == 0)))
    {
      direction = 'A';
    }
#endif

    //Get the parameters for this interconnect wire
    hops = name[1] - '0';
    wire = name[5];

    //Determine the next hop to check. 2 and 6 have a MID entity so need half the hop size for these.
    nexthop = (hops + 1) / 2;

    //Handle the needed hops
    for(hop=nexthop;hop<=hops;hop+=nexthop)
    {
      //Need to restore the originating direction in case it was changed for a border tile flip
      direction = name[0];

      //Select the next tile based on the direction
      switch(direction)
      {
        case 'E':
          //East is right so add to the x coordinate
          x = tiledata->x + hop;

          //When x flows over the side the direction changes and a new tile coordinate needs to be calculated
          if(x > LAST_COLUMN)
          {
            //Need to look for a MID or END point in the west
            direction = 'W';

            //When flipping, the other side of the tile counts for 1 too
            x = LAST_COLUMN - ((x - LAST_COLUMN) - 1);
          }
          break;

        case 'W':
          //West is left so subtract from the x coordinate
          x = tiledata->x - hop;

          //When x flows over the side the direction changes and a new tile coordinate needs to be calculated
          if(x < 0)
          {
            //Need to look for a MID or END point in the west
            direction = 'E';

            //When flipping, the other side of the tile counts for 1 too
            x = 0 - (x + 1);
          }
          break;

        case 'N':
          //North is up so add to the y coordinate
          y = tiledata->y + hop;

          //When y flows over the side the direction changes and a new tile coordinate needs to be calculated
          if(y > LAST_ROW)
          {
            //Need to look for a MID or END point in the south
            direction = 'S';

            //When flipping, the other side of the tile counts for 1 too
            y = LAST_ROW - ((y - LAST_ROW) - 1);
          }
          break;

        case 'S':
          //South is down so subtract from the y coordinate
          y = tiledata->y - hop;

          //When y flows over the side the direction changes and a new tile coordinate needs to be calculated
          if(y < 0)
          {
            //Need to look for a MID or END point in the north
            direction = 'N';

            //When flipping, the other side of the tile counts for 1 too
            y = 0 - (y + 1);
          }
          break;
      }

      //Determine what to look for MID or END
      if(hop != hops)
      {
        //Setup a MID entity
        length = snprintf(entity, sizeof(entity), "%c%dMID%c", direction, hops, wire);
      }
      else
      {
        //Setup an END entity
        length = snprintf(entity, sizeof(entity), "%c%dEND%c", direction, hops, wire);
      }

      //Get the route list to search
      tileroutelist = tileroutearray[x][y];

      //Go and try to find a matching route set
      foundrouteitem = findrouteconnection(tileroutelist, entity, length, routeinfoitem->netnumber);

      //Check if a match has been found
      if(foundrouteitem)
      {
        //For a connection point see if there are more matches in the same tile for this specific one
        //Done here because for the interconnect there can be multiple connections on both the mid and the end point
        while(findmatchingpoints(foundrouteitem, foundrouteitem->netnumber, TYPE_ENDPOINT) == 1);
        
        //Signal at least one connection has been found
        foundconnection = 1;
      }
    }
    
    //At this point nothing found means an error so mark the originating route as such
    if(foundconnection == 0)
    {
#if 0
      if((routeinfoitem->tiledata->x == 1) && (routeinfoitem->tiledata->y == 35) && ((strcmp(routeinfoitem->bitdata->name, "TOP.XI32.MC17") == 0) || (strcmp(routeinfoitem->bitdata->name, "TOP.XI32.MC10") == 0)))
      {
        direction = 'A';
      }
#endif
      
      //Mark the originating bit pair with an error
      //Might need a check on matingrouteitem being a valid pointer
      routeinfoitem->routetype = TYPE_ERROR;
      routeinfoitem->matingrouteitem->routetype = TYPE_ERROR;
    }
  }
  else
  {
    //At this point the originating route bit should have had either a LOCAL or an interconnect destination
    //Mark the originating bit pair with an error
    //Might need a check on matingrouteitem being a valid pointer
    routeinfoitem->routetype = TYPE_ERROR;
    routeinfoitem->matingrouteitem->routetype = TYPE_ERROR;
  }
  
  return(foundconnection);
}

//----------------------------------------------------------------------------------------------------------------------------------

void identifynetstarts(int *netnumber)
{
  int x;
  int y;
  
  pROUTEINFOITEM bitlist;
  
  //Scan the tiles to find the starting points (block outputs)
  
  //When a starting point is found (matching bit pair) then use the starting point to see if there are more.
  //If not then check for other starting points
  
  //Walk through the tile array to search for the starting points
  for(x=0;x<COLUMNS;x++)
  {
    for(y=0;y<ROWS;y++)
    {
      //Get the first bit for this tile
      bitlist = tileroutearray[x][y];
      
      //Only process when there are bits
      while(bitlist)
      {
        //Check if the current route bit is not typed already
        if(bitlist->routetype == TYPE_NONE)
        {
          //See if it is a starting point or not
          if(checkstartingpoint(bitlist, *netnumber) == 1)
          {
            //For a starting point see if there are more matches for this specific one
            while(findmatchingpoints(bitlist, *netnumber, TYPE_NET) == 1);
            
            //Last match found then up to the next net
            (*netnumber)++;
          }
        }
        
        //Select the next bit to check
        bitlist = bitlist->next;
      }
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void buildgndnet(int *netnumber)
{
  int x;
  int y;

  int found = 0;
  
  pROUTEINFOITEM bitlist;
  
  //Walk through the tile array to search for the GND starting points
  for(x=0;x<COLUMNS;x++)
  {
    for(y=0;y<ROWS;y++)
    {
      //Get the first bit for this tile
      bitlist = tileroutearray[x][y];
      
      //Only process when there are bits
      while(bitlist)
      {
        //Check if the current route bit is not typed already
        if(bitlist->routetype == TYPE_NONE)
        {
          //See if it is a ground point or not
          if(findgndpoint(bitlist, *netnumber) == 1)
          {
            found = 1;
          }
        }
        
        //Select the next bit to check
        bitlist = bitlist->next;
      }
    }
  }
  
  //Check if a ground net is found
  if(found)
  {
    //Found a ground net then select next net number
    (*netnumber)++;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void buildgclknets(int *netnumber)
{
  int x;
  int y;

  int found;
  int clkid;

  char  clkname[12];
  int   clklength;
  
  pROUTEINFOITEM bitlist;

  for(clkid=0;clkid<16;clkid++)
  {
    //No item found yet at the start of each new global clock signal
    found = 0;
    
    //There is no GCLK1 net so skip it
    if(clkid == 1)
    {
      clkid++;
    }
  
    clklength = snprintf(clkname, sizeof(clkname), "GCLK%d", clkid);
    
    //Walk through the tile array to search for the GND starting points
    for(x=0;x<COLUMNS;x++)
    {
      for(y=0;y<ROWS;y++)
      {
        //Get the first bit for this tile
        bitlist = tileroutearray[x][y];

        //Only process when there are bits
        while(bitlist)
        {
          //Check if the current route bit is not typed already
          if(bitlist->routetype == TYPE_NONE)
          {
            //See if it is a clock route or not
            if(findgclkpoint(bitlist, *netnumber, clkname, clklength) == 1)
            {
              found = 1;
            }
          }

          //Select the next bit to check
          bitlist = bitlist->next;
        }
      }
    }

    //Check if a clock net is found
    if(found)
    {
      //Found a ground net then select next net number
      (*netnumber)++;
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void traceroutelist()
{
  int x;
  int y;
  
  int routefound = 1;
  
  pROUTEINFOITEM bitlist;

  //Need to walk through the tile route array and trace all the identified nets down to the endpoints
  //To catch them all the tree is scanned multiple times until all the bits have been processed

  //Search until the last bit has been done or no more matches have been found, which is an error condition
  while(tileroutecount && routefound)
  {
    //When no more routes are found the loop will break
    routefound = 0;
    
    //Walk through the tile array to trace the nets for the identified starting points
    for(x=0;x<COLUMNS;x++)
    {
      for(y=0;y<ROWS;y++)
      {
        //Get the first bit for this tile
        bitlist = tileroutearray[x][y];

        //Only process when there are bits to handle
        while((bitlist) && (tileroutecountarray[x][y]))
        {
#if 0
          if((x == 7) && (y == 30) && (strcmp(bitlist->bitdata->name, "TOP.XI5.MC03") == 0))
          {
            routefound = 0;
          }
#endif
          
          //Check if the current route bit is a starting or a route point and not connected yet
          if((bitlist->routeconnected == 0) && ((bitlist->routetype == TYPE_STARTPOINT) || (bitlist->routetype == TYPE_ROUTEPOINT)))
          {
            //Could have this function return the number of bits tagged to cope with the single bit clock routes
            
            //Try to find a connection for this route bit
            if(findconnectionpoint(bitlist))
            {
              //Signal a route has been found, so good for another run
              routefound = 1;
              
              //Mark originating route bits as connected
              //Might need a check on matingrouteitem being a valid pointer
              bitlist->routeconnected = 1;
              bitlist->matingrouteitem->routeconnected = 1;

              //This means two bits are done so adjust the counters
              tileroutecountarray[x][y] -= 2;
              tileroutecount -= 2;
            }
          }

          //Select the next bit to investigate
          bitlist = bitlist->next;
        }
      }
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

pROUTEINFOITEM findmatchingpair(pROUTEINFOITEM routeinfoitem, int netnumber)
{
  int item;
  int pair;
  
  pTILEGRIDDATA  tiledata = routeinfoitem->tiledata;
  
  pROUTEINFOITEM tileroutelist;
  
  //Check all the arcval pairs on having a match in another route bit within this tile
  for(item=0;item<routeinfoitem->nofentities;item++)
  {
    //Get the route list for the tile the original route belongs to
    tileroutelist = tileroutearray[tiledata->x][tiledata->y];

    //Check the other route bits in this tile
    while(tileroutelist)
    {
      //Make sure this is not the original item
      if((tileroutelist != routeinfoitem) && (tileroutelist->routetype == TYPE_NONE))
      {
        //Need a for loop to check the pairs here
        for(pair=0;pair<tileroutelist->nofentities;pair++)
        {
          //Check if the lengths match before comparing the strings
          if(routeinfoitem->pointpairs[item].length == tileroutelist->pointpairs[pair].length)
          {
            //match the current pair with the to test one
            if(strncmp(routeinfoitem->pointpairs[item].name, tileroutelist->pointpairs[pair].name, routeinfoitem->pointpairs[item].length) == 0)
            {
              //Set the index for the entity that matches for these route items
              routeinfoitem->routestartentity = item;
              tileroutelist->routestartentity = pair;

              //Mark both route items as a start point
              routeinfoitem->routetype = TYPE_ROUTEPOINT;
              tileroutelist->routetype = TYPE_ROUTEPOINT;

              //Set the net number for both items
              routeinfoitem->netnumber = netnumber;
              tileroutelist->netnumber = netnumber;

              //Link the two bits together
              routeinfoitem->matingrouteitem = tileroutelist;
              tileroutelist->matingrouteitem = routeinfoitem;

              //Signal that a starting route has been found
              return(routeinfoitem);
            }
          }              
        }
      }

      tileroutelist = tileroutelist->next;
    }
  }
  
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

void getsignalproperties(pROUTEINFOITEM item)
{
  int blocktype = BLOCK_OTHER;
  
  int length;
  
  char *dptr;
  
 char *type;
  
  //The block type depends on several things. For instance the tile type for slices is plb in which mslices and lslices sit
  //These depend on the numbers in the bit name
  
  //An emb block can be a fifo which can only be determined by checking more then one bit
  
  //Not sure if the tile type pib is used here because io is situated in dedicated tile types
  
  //Need to look into what is actually needed here to make it work
  
  
  item->sliceid   = -1;
  item->lutid     = -1;
  item->padid     = -1;
  item->pinnumber = -1;
  item->embid     = -1;
  item->pllid     = -1;
  
  //The signal properties are found in the signal name
  if(item->signalprefix)
  {
    type = item->signalprefix->tiletype;
    
    if(strncmp(type, "plb", 3) == 0)
    {
      //signalname->hdl_name for lut determination
      //signalprefix->signalprefix for slice determination
      
      item->sliceid = item->signalprefix->signalprefix[6] - '0';
      
      //The lut id is either 0 or 1 and can be found in the hdl name where either the second or third character is an _
      if(dptr = strstr(item->signalname->hdl_name, "_"))
      {
        //There are signal names that do not have a lut id after the first _ so need to make sure it is a lut id
        if(dptr[1] == '0')
        {
          item->lutid = 0;
        }
        else if(dptr[1] == '1')
        {
          item->lutid = 1;
        }
      }
      
      //Evaluate the slice number. 0 and 1 are for mslice and 2 and 3 are for lslice
      if(item->sliceid < 2)
      {
        blocktype = BLOCK_MSLICE;
      }
      else
      {
        blocktype = BLOCK_LSLICE;
      }
    }
    else if(strncmp(type, "iol_", 4) == 0)
    {
      if(item->paddata)
      {
        item->padid = item->paddata->iol;
      }
      else
      {
        item->padid = item->signalprefix->signalprefix[3] - '0';
      }
      
      blocktype = BLOCK_PAD;
    }
    else if(strncmp(type, "emb_slice", 9) == 0)
    {
      item->embid = item->signalprefix->signalprefix[3] - '0';

      //Have to see how to make sure this is correct
      blocktype = BLOCK_EMB;
    }
    else if(strncmp(type, "mult", 4) == 0)
    {
      blocktype = BLOCK_DSP;
    }
    else if(strncmp(type, "emb32k_b", 8) == 0)
    {
      blocktype = BLOCK_EMB_32K;
    }
    else if(strncmp(type, "clkdiv", 6) == 0)
    {
      blocktype = BLOCK_CLKDIV;
    }
    else if(strncmp(type, "gclk_csb", 8) == 0)
    {
      blocktype = BLOCK_GCLK_CSB;
    }
    else if(strncmp(type, "gclk_ctmux", 10) == 0)
    {
      blocktype = BLOCK_GCLK_CTMUX;
    }
    else if(strncmp(type, "gclk_premux", 11) == 0)
    {
      blocktype = BLOCK_GCLK_PREMUX;
    }
    else if(strncmp(type, "gclk_spine", 10) == 0)
    {
      blocktype = BLOCK_GCLK_SPINE;
    }
    else if(strncmp(type, "ioclk", 5) == 0)
    {
      blocktype = BLOCK_OTHER;
    }
    else if(strncmp(type, "ios_", 4) == 0)
    {
      blocktype = BLOCK_OTHER;
    }
    else if(strncmp(type, "pll", 3) == 0)
    {
      item->pllid = type[3] - '0';

      blocktype = BLOCK_PLL;
    }
    else if(strncmp(type, "osc", 3) == 0)
    {
      blocktype = BLOCK_OSC;
    }
    else if(strncmp(type, "na", 2) == 0)
    {
      blocktype = BLOCK_CONFIG;
    }
  }
  
  //Set the found block type
  item->blocktype = blocktype;
}

//----------------------------------------------------------------------------------------------------------------------------------

void mapsignalname(pROUTEINFOITEM routeitem)
{
  int iol = -1;
  int i;
  
  int found = 0;
  
  pTILEGRIDDATA  tiledata = routeitem->tiledata;

  int x = tiledata->x;
  int y = tiledata->y;
  
  pNAMEITEM signalname;
  
  pTILESIGNALMAP tilesignalmapptr;
  pSIGNALNAMEMAP signalsearchtable;
  
  char **typemap;

  //Take action based on the signal type
  if(routeitem->netsignal == SIGNAL_OUTPUT)
  {
    //For an output the data to check is in the start points
    signalname = &routeitem->startpoints[routeitem->routestartentity];
  }
  else
  {
    //For an input the data to check is in the end points
    signalname = &routeitem->endpoints[routeitem->routestartentity];
  }

  //Get a pointer to the list with signal maps for this tile
  tilesignalmapptr = tilesignalmap[x][y];

  //A bit of an issue is when a block can have different modes where the signals map differently
  //One block that has this is emb, which can also be a fifo
  //Needs a bit of investigation on how to check and use this
  
  //The above seems not to be used in the FNIRSI-1013D FPGA so skipped for now
  
  //What needs to be done here is map a signal to a block in the block list
  //Have to see if IO pads can be mapped correctly because in the net list there is a difference between the coordinates
  //of a signal name and the coordinates of a pad. Same problem for emb slices.
  
  //In the block map the tile coordinates are those for the top level tile. For example emb_slice 2 has its configuration done if 8,0 while the signals connect in 8,5 or 8,6
  //So for the mapping the top level coordinates are needed. This is also done below to verify the type!
  
  
  
  //Only do mapping when there is an actual translation table available
  if(tilesignalmapptr)
  {
    //Check if this tile has emb logic in it. prefixes in range are emb0 - emb3. emb32K_b0 and emb32K_b1 are not valid because they don't have fifo capability.
    if((strncmp(tilesignalmapptr->signalprefix, "emb", 3) == 0) && (tilesignalmapptr->signalprefix[3] >= '0') && (tilesignalmapptr->signalprefix[3] <= '3') && (tilesignalmapptr->signalprefix[4] == 0))
    {
      //If so there might be a need to skip to a fifo based table
      //Needs looping through the table to find the first fifo map
      
      //Check the block type which should be used. But for this it should be mapped to a block first
    }
    
    //Search the lists until the matching signal is found
    while(tilesignalmapptr->signaltable && (found == 0))
    {
      //Need the actual signal mapping table for searching
      signalsearchtable = tilesignalmapptr->signaltable;

      //Check all the signal names to get the hdl name
      while(signalsearchtable->hdl_name && (found == 0))
      {
        //Need case insensitive searching because the ARCVAL entities are upper case and the mapping names are lower case
        if(strnicmp(signalname->name, signalsearchtable->signal_name, signalname->length) == 0)
        {
          routeitem->toptilex = x - signalsearchtable->xoff;
          routeitem->toptiley = y - signalsearchtable->yoff;
          
          //Check the tile that this match is offset from, on the correct type to make sure the match is correct
          typemap = tiletypemap[routeitem->toptilex][routeitem->toptiley];
          
          //Only if the originating tile has a typemap check it there is a match
          if(typemap)
          {
            //Check all the entries in this type map
            while(*typemap && (found == 0))
            {
              //The type of th originating tile has to match with the one found in the signal translation map for the current tile
              if(strcmp(*typemap, tilesignalmapptr->tiletype) == 0)
              {
                //When a match is found set both the name and the prefix pointer for printing
                routeitem->signalname   = signalsearchtable;
                routeitem->signalprefix = tilesignalmapptr;

                //Done so break out all the loops
                found = 1;
              }
              
              //Select the next type string to check
              typemap++;
            }
          }
        }

        //Select next signal to check
        signalsearchtable++;
      }

      //Select the next map to check
      tilesignalmapptr++;
    }
  }
  
  //When a name is found see if it could be an IO pin which are only situated in pib tiles and have a prefix name starting with pad
  if((found == 1) && (strncmp(routeitem->signalprefix->signalprefix, "pad", 3) == 0))
  {
    //Get the pad number
    iol = routeitem->signalprefix->signalprefix[3] - '0';
    
    //Calculate the coordinates of the tile the pad belongs to based on the found offsets
    x -= routeitem->signalname->xoff;
    y -= routeitem->signalname->yoff;
    
    //Try to match the found pad number to an actual pin number
    for(i=0;i<sizeof(tilepadmap)/sizeof(TILEPADPINMAP);i++)
    {
      //Match the numbers to the table for the 144 pin variant the FNIRSI uses
      if((x == tilepadmap[i].x) && (y == tilepadmap[i].y) && (iol == tilepadmap[i].iol))
      {
        //When found set it in the route info item for printing
        routeitem->paddata = (const pTILEPADPINMAP)&tilepadmap[i];
      }
    }
  }  

  //When there is a signal match try to match it to a block
  if(found == 1)
  {
    pBLOCKINFOITEM searchlist = blocklist;
    //Search the block list for a matching block this signal connects to
    //Need more info like slice and pad id's
    
    //Need to compare the type strings
    //routeitem->signalprefix->tiletype
    //blocklist->tiletype
    
    //When they match it is type dependent what needs to be checked next
    
    //First get the needed properties for this bit
    getsignalproperties(routeitem);
    
    found = 0;
    
    //Just search the block list to find a match
    while(searchlist && (found == 0))
    {
      found = 0;
      
      if((searchlist->x == routeitem->toptilex) && (searchlist->y == routeitem->toptiley) && (searchlist->blocktype == routeitem->blocktype))
      {
        //For the moment only the blocks used in the FNIRSI FPGA are checked
        
        switch(routeitem->blocktype)
        {
          case BLOCK_PAD:
            if(searchlist->padid == routeitem->padid)
            {
              found = 1;
            }
            break;
            
          case BLOCK_MSLICE:
          case BLOCK_LSLICE:
            if(searchlist->sliceid == routeitem->sliceid)
            {
              found = 1;
            }
            break;

          case BLOCK_EMB:
            if(searchlist->embid == routeitem->embid)
            {
              found = 1;
            }
            break;
            
          case BLOCK_PLL:
            if(searchlist->pllid == routeitem->pllid)
            {
              found = 1;
            }
            break;
            
          case BLOCK_GCLK_CSB:
          case BLOCK_GCLK_PREMUX:
          case BLOCK_GCLK_CTMUX:
          case BLOCK_GCLK_SPINE:
            found = 1;
            break;
        }
      }
      
      if(found == 1)
      {
        routeitem->blocknumber = searchlist->blocknumber;
      }
      
      searchlist = searchlist->next;
    }
    
    
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void filterroutelist()
{
  pNETLISTITEM  fromlist = routelist;
  
  pROUTEINFOITEM routeitem;
  
  char *name;
  int  length;
  
  int netnumber = 0;  
  
  //Within this function code should be added to identify a block based on a signal name
  //For the found block the settings data needs to be retrieved
  //Could be coded in the mapsignalname function. This way it is also possible to select the correct type to match the signal names
  //It does require a bitlist per tile with the remainder of the bits
  
  
  //Process all the items in the route list
  while(fromlist)
  {
    //Get the current item to process
    routeitem = fromlist->routebit;
    
    //Detect switch to new net
    if(netnumber != fromlist->routebit->netnumber)
    {
      //Get the start point for typing the signal
      name   = routeitem->startpoints[routeitem->routestartentity].name;
      length = routeitem->startpoints[routeitem->routestartentity].length;
      
      //Check the first entry of this net on what it is
      if((length == 3) && (strncmp(name, "GND", 3) == 0))
      {
        //For a ground item mark the first one as ground signal
        routeitem->netsignal = SIGNAL_GND;
      }
      else if(((length == 5) || (length == 6)) && (strncmp(name, "GCLK", 4) == 0))
      {
        //For a global clock mark it as a global clock signal
        routeitem->netsignal = SIGNAL_GCLK;
      }
      else
      {
        //Not a ground or a global clock means it is an output signal
        routeitem->netsignal = SIGNAL_OUTPUT;
        
        //Translate the signal name to a hdl name and see if it has a connection with a pin
        mapsignalname(routeitem);
      }
      
      //Add it to the net list
      additemtofinalnetlist(routeitem);
      
      netnumber++;
    }
    else
    {
      //Check on the route type if it needs to be added
      //For TYPE_NET and TYPE_ENDPOINT the net type is SIGNAL_INPUT and the matching pair needs to be marked so it is skipped
      if((routeitem->netsignal == 0) && ((routeitem->routetype == TYPE_NET) || (routeitem->routetype == TYPE_ENDPOINT)))
      {
        //Signal it as an input
        routeitem->netsignal = SIGNAL_INPUT;
        
        //Check if there is a matching pair for this route bit, which is not already marked
        if((routeitem->matingrouteitem) && (routeitem->matingrouteitem->netsignal == 0))
        {
          //If so flag it as input signal too so it will be filtered from the list
          routeitem->matingrouteitem->netsignal = SIGNAL_INPUT;
        }
        
        //Translate the signal name to a hdl name and see if it has a connection with a pin
        mapsignalname(routeitem);
        
        //Add it to the net list
        additemtofinalnetlist(routeitem);
      }
    }
    
    //Get the next item to process
    fromlist = fromlist->next;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void insertitembeforesetuplist(pBITLISTITEM current, pBITLISTITEM new)
{
  //Do an insert
  //Check if first item of the list
  if(current->prev == 0)
  {
    //If so make this one the first item in the list, so no previous
    new->prev = 0;
    new->next = current;

    //Set the back track connection
    current->prev = new;

    //Set it as the first item of the list
    blocksetuplist = new;
  }
  else
  {
    //Insert it in the list
    //Link the new item to the previous item
    new->prev = current->prev;
    current->prev->next = new;

    //Link the item to insert before to the new item
    new->next = current;
    current->prev = new;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void additemtosetuplist(pBITLISTITEM item)
{
  pBITLISTITEM addlist;
  
  //Add the route point to the net list
  if(blocksetuplist == 0)
  {
    //No items added yet so start with this one
    blocksetuplist = item;
  }
  else
  {
    //Need to loop through to make a sorted list
    addlist = blocksetuplist;
    
    //Look for where the data needs to be inserted or replaced
    while(addlist)
    {
      //Sort on block number
      if(item->blocknumber < addlist->blocknumber)
      {
        //Insert the item before the current one
        insertitembeforesetuplist(addlist, item);
        break;
      }
      
      if(item->blocknumber == addlist->blocknumber)
      {
        //Need sorting on bit name here
        if(strcmp(item->bitdata->name, addlist->bitdata->name) < 0)
        {
          //Insert the item before the current one
          insertitembeforesetuplist(addlist, item);
          break;
        }
      }
    
      //Point to the next item if there is one
      if(addlist->next)
      {
        //Select the next item
        addlist = addlist->next;
      }
      else
      {
        //Append to the list when this is the last item
        item->prev = addlist;
        item->next = 0;
        addlist->next = item;

        //Done so quit
        break;
      }
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void findblocktype(pBITLISTITEM item, pBLOCKINFOITEM block)
{
  int blocktype = BLOCK_OTHER;
  
  int length;
  
  char *dptr;
  //The block type depends on several things. For instance the tile type for slices is plb in which mslices and lslices sit
  //These depend on the numbers in the bit name
  
  //An emb block can be a fifo which can only be determined by checking more then one bit
  
  //Not sure if the tile type pib is used here because io is situated in dedicated tile types
  
  block->sliceid   = -1;
  block->lutid     = -1;
  block->padid     = -1;
  block->pinnumber = -1;
  block->embid     = -1;
  block->pllid     = -1;
  
  if(strncmp(item->tiledata->type, "plb", 3) == 0)
  {
    //Need to check on the bit name to determine mslice or lslice
    if(strncmp(item->bitdata->name, "LUT", 3) == 0)
    {
      //LUT name has three possibilities
      //LUT0_S0_0, LUTF0_S0_0 or LUTG0_S0_0
      //The digit after the _S is the slice id
      //The digit directly after LUT, LUTF or LUTG is the lut id
      dptr = strstr(item->bitdata->name, "S");
      
      //So find the S and convert the digit to a number
      block->sliceid = dptr[1] - '0';
      
      //See what type of LUT it is
      if((item->bitdata->name[3] == 'F') || (item->bitdata->name[3] == 'G'))
      {
        //A lslice LUT so convert the digit after the F or G to a number
        block->lutid = item->bitdata->name[4] - '0';
      }
      else
      {
        //A mslice LUT so convert the digit directly after LUT to a number.
        block->lutid = item->bitdata->name[3] - '0';
      }
    }
    else if(strncmp(item->bitdata->name, "MC1", 3) == 0)
    {
      //MC1 setup items are slice settings only where the slice id is at the end of the string
      length = strlen(item->bitdata->name);

      block->sliceid = item->bitdata->name[length - 1] - '0';
    }
    else if(strncmp(item->bitdata->name, "TOP.", 4) == 0)
    {
      //Topology bits have the slice id in the property data
      if(item->bitdata->datacount)
      {
        //This property seems to be a correct indicator for a pad number
        if(strncmp(item->bitdata->bitdata[0].data, "PROPERTY(SLICE", 14) == 0)
        {
          block->sliceid = item->bitdata->bitdata[0].data[14] - '0';
        }
      }
    }

    //Evaluate the slice number. 0 and 1 are for mslice and 2 and 3 are for lslice
    if(block->sliceid < 2)
    {
      blocktype = BLOCK_MSLICE;
    }
    else
    {
      blocktype = BLOCK_LSLICE;
    }
  }
  else if(strncmp(item->tiledata->type, "iol_", 4) == 0)
  {
    //Get the pad/pin information for this bit
    getpinmapfortile(item, block);
    
    blocktype = BLOCK_PAD;
  }
  else if(strncmp(item->tiledata->type, "emb_slice", 9) == 0)
  {
    //For emb type a check is needed to see if it is fifo or emb. Maybe a separate function to do the check since it requires multiple bits that need checking
    //Further more the emb section needs to be identified. There are 4 emb sections for the tile with type emb
    //Bits starting with F_  or NET have the emb id at the end of the string
    if(strncmp(item->bitdata->name, "F_", 2) == 0)
    {
      //For these bits the emb id is at the end of the string
      length = strlen(item->bitdata->name);

      block->embid = item->bitdata->name[length - 1] - '0';
    }
    else if((strncmp(item->bitdata->name, "TOP.", 4) == 0) || (strncmp(item->bitdata->name, "MC1_", 4) == 0))
    {
      //Topology and MC1 bits have the emb id in the property data
      //To check if it is a IO mux the first data item can be checked
      if(item->bitdata->datacount)
      {
        //This property seems to be a correct indicator for a pad number
        if(strncmp(item->bitdata->bitdata[0].data, "PROPERTY(EMB", 12) == 0)
        {
          block->embid = item->bitdata->bitdata[0].data[12] - '0';
        }
      }
    }
    
    //Have to see how to make sure this is correct
    blocktype = BLOCK_EMB;
  }
  else if(strncmp(item->tiledata->type, "mult", 4) == 0)
  {
    blocktype = BLOCK_DSP;
  }
  else if(strncmp(item->tiledata->type, "emb32k_b", 8) == 0)
  {
    blocktype = BLOCK_EMB_32K;
  }
  else if(strncmp(item->tiledata->type, "clkdiv", 6) == 0)
  {
    blocktype = BLOCK_CLKDIV;
  }
  else if(strncmp(item->tiledata->type, "gclk_csb", 8) == 0)
  {
    blocktype = BLOCK_GCLK_CSB;
  }
  else if(strncmp(item->tiledata->type, "gclk_ctmux", 10) == 0)
  {
    blocktype = BLOCK_GCLK_CTMUX;
  }
  else if(strncmp(item->tiledata->type, "gclk_premux", 11) == 0)
  {
    blocktype = BLOCK_GCLK_PREMUX;
  }
  else if(strncmp(item->tiledata->type, "gclk_spine", 10) == 0)
  {
    blocktype = BLOCK_GCLK_SPINE;
  }
  else if(strncmp(item->tiledata->type, "ioclk", 5) == 0)
  {
    blocktype = BLOCK_OTHER;
  }
  else if(strncmp(item->tiledata->type, "ios_", 4) == 0)
  {
    blocktype = BLOCK_OTHER;
  }
  else if(strncmp(item->tiledata->type, "pll", 3) == 0)
  {
    block->pllid = item->tiledata->type[3] - '0';
    
    blocktype = BLOCK_PLL;
  }
  else if(strncmp(item->tiledata->type, "osc", 3) == 0)
  {
    blocktype = BLOCK_OSC;
  }
  else if(strncmp(item->tiledata->type, "na", 2) == 0)
  {
    blocktype = BLOCK_CONFIG;
  }
  
  //Set the found block type
  block->blocktype = blocktype;
}

//----------------------------------------------------------------------------------------------------------------------------------

void makeblocksetuplist()
{
  int x;
  int y;
  
  int bitfound;
  int bitmatch;
  
  int blocknumber = 1;
  
  pBITLISTITEM bitlist;
  
  pBLOCKINFOITEM currentblock = 0;
  
  BLOCKINFOITEM checkblock;

  //Need to walk through the tile setup array and mark all the used blocks
  //To catch them all the tree is scanned multiple times until all the bits have been processed

  //Walk through the tile array to trace the nets for the identified starting points
  for(x=0;x<COLUMNS;x++)
  {
    for(y=0;y<ROWS;y++)
    {
      //Make sure every tile gets checked
      bitfound = 1;
      
      //Search until the last bit has been done or no more matches have been found, which is an error condition
      while(bitfound)
      {
        //When no more routes are found the loop will break
        bitfound = 0;

        //Get the first bit for this tile
        bitlist = tilesetuparray[x][y];

        //Only process when there are bits to handle
        while(bitlist)
        {
#if 0
          if((x == 7) && (y == 30) && (strcmp(bitlist->bitdata->name, "TOP.XI5.MC03") == 0))
          {
            bitfound = 0;
          }
#endif
          
          //Need to check if a setup bit belongs to the same block as the current one
          //For this there needs to be information about the current one
          
          
          //Check if the current setup bit is not assigned yet
          if(bitlist->blocknumber == -1)
          {
            //Check if there is a current block or not
            if(currentblock == 0)
            {
              //When not make one
              currentblock = malloc(sizeof(BLOCKINFOITEM));
              
              //No next block yet
              currentblock->next = 0;
              
              //Set the coordinates this block belongs to
              currentblock->x = x;
              currentblock->y = y;
              
              //Set the schematic block type and other properties for this block
              findblocktype(bitlist, currentblock);
              
              //Set the tile type of this block
              currentblock->tiletype = bitlist->tiledata->type;
              
              //Set the block number used for these bits
              currentblock->blocknumber = blocknumber;

              //Set the block number in this bit
              bitlist->blocknumber = currentblock->blocknumber;
              
              //Select the next id for the next block
              blocknumber++;
              
              //Add this block to the list
              additemtoblocklist(currentblock);
              
              //Make a sorted settings list
              additemtosetuplist(bitlist);
            }
            else
            {
              //No match yet
              bitmatch = 0;
              
              //At this point a check is needed to see if the current bit is part of the same block
              //Use a dummy block to get the type and compare the two
              findblocktype(bitlist, &checkblock);
              
              //The block type only is part of the block identification
              if(checkblock.blocktype == currentblock->blocktype)
              {
                //For some reason empty plb's show up in the list????
                
                //Need to check other properties too, but these depend on the type of block
                switch(checkblock.blocktype)
                {
                  case BLOCK_PAD:
                    if(checkblock.padid == currentblock->padid)
                    {
                      bitmatch = 1;
                    }
                    break;
                    
                  case BLOCK_MSLICE:
                  case BLOCK_LSLICE:
                    //Both luts in a block share the block number due to some signals being global to the slice
                    if(checkblock.sliceid == currentblock->sliceid)
                    {
                      bitmatch = 1;
                    }
                    break;
                    
                  case BLOCK_EMB:
                    //Make sure the bits are for the same memory block
                    if(checkblock.embid == currentblock->embid)
                    {
                      bitmatch = 1;
                    }
                    break;
 
                  case BLOCK_PLL:
                  case BLOCK_GCLK_CSB:
                  case BLOCK_GCLK_PREMUX:
                  case BLOCK_GCLK_CTMUX:
                  case BLOCK_GCLK_SPINE:
                    //The pll is identified by the tile type alone
                    bitmatch = 1;
                    break;
                }
              }
              
              //A match is needed to assign this bit to the same block
              if(bitmatch)
              {
                //Set the block number in this bit when a match is made
                bitlist->blocknumber = currentblock->blocknumber;
                
                //Make a sorted settings list
                additemtosetuplist(bitlist);
              }
            }
            
            //Signal a bit has been found, so good for another run
            bitfound = 1;
          }
          
          //Select the next bit to investigate
          bitlist = bitlist->link;
        }

        //Reset for the next block to be detected
        currentblock = 0;
      }
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void printblocklist()
{
  char filename[255];

  pBLOCKINFOITEM printlist;
  
  FILE *fo;
  
  snprintf(filename, sizeof(filename), "%s_block_list.csv", FILENAME);
  
  fo = fopen(filename, "w");  
  
  if(fo)
  {
    fprintf(fo, "block number,x,y,,block type,emb,slice,lut,pad,pin\n");
    
    printlist = blocklist;
    
    while(printlist)
    {
        
      fprintf(fo, "%d,%d,%d,,\"%s\"", printlist->blocknumber, printlist->x, printlist->y, printlist->tiletype);

      if(printlist->embid != -1)
      {
        fprintf(fo, ",%d", printlist->embid);
      }
      else
      {
        fprintf(fo, ",");
      }
      
      if(printlist->sliceid != -1)
      {
        fprintf(fo, ",%d", printlist->sliceid);
      }
      else
      {
        fprintf(fo, ",");
      }

      if(printlist->lutid != -1)
      {
        fprintf(fo, ",%d", printlist->lutid);
      }
      else
      {
        fprintf(fo, ",");
      }

      if(printlist->padid != -1)
      {
        fprintf(fo, ",%d", printlist->padid);
      }
      else
      {
        fprintf(fo, ",");
      }
      
      if(printlist->pinnumber != -1)
      {
        fprintf(fo, ",P%d", printlist->pinnumber);
      }
      else
      {
        fprintf(fo, ",");
      }
      
      fprintf(fo, "\n");
      
      //Select the next item
      printlist = printlist->next;
    }
    
    fclose(fo);
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void printbititem(FILE *fo, pBITLISTITEM bitlist)
{
  int count;
  
  //Print the net info
  fprintf(fo, "%d,,", bitlist->blocknumber);

  //Print the data for this item
  fprintf(fo, "%s,%s,%d,%d,,", bitlist->tiledata->name, bitlist->tiledata->type, bitlist->tiledata->x, bitlist->tiledata->y);

  if(bitlist->paddata)
  {
    fprintf(fo, "P%d,,", bitlist->paddata->pin);
  }
  else
  {
    fprintf(fo, ",,");
  }

  fprintf(fo, "%s,%s,%d,%d,%d,%d,,\"", bitlist->bitdata->name, bitlist->bitdata->type, bitlist->bitdata->x, bitlist->bitdata->y, bitlist->bitdata->xoff, bitlist->bitdata->yoff);

  //Walk through all the expression items
  for(count=0;count<bitlist->bitdata->exprcount;count++)
  {
    fprintf(fo, "%s", bitlist->bitdata->expr[count]);
  }

  fprintf(fo, "\",\"");

  //Walk through all the reverse polar notation items
  for(count=0;count<bitlist->bitdata->rpncount;count++)
  {
    fprintf(fo, "%s", bitlist->bitdata->rpn[count]);
  }

  fprintf(fo, "\",%d,,", bitlist->bitdata->datacount);

  //Walk through all the data items
  for(count=0;count<bitlist->bitdata->datacount;count++)
  {
    //Output them to the file
    fprintf(fo, "\"%s\"", bitlist->bitdata->bitdata[count].data);

    //Check if not the last item
    if(count < (bitlist->bitdata->datacount - 1))
    {
      //Add a separator if so
      fprintf(fo, ",");
    }
  }

  fprintf(fo, "\n");
}

//----------------------------------------------------------------------------------------------------------------------------------

void printsetuplist()
{
  char filename[255];

  int blocknumber = 1;
  
  pBITLISTITEM printlist;
  
  FILE *fo;
  
  snprintf(filename, sizeof(filename), "%s_block_setup_list.csv", FILENAME);
  
  fo = fopen(filename, "w");  
  
  if(fo)
  {
    fprintf(fo, "Block,,Tile,,,,,Pin,,Bit\n");
    fprintf(fo, "number,,name,type,x,y,,pin,,name,type,x,y,xoff,yoff,,expression,rpn,count,,data\n");
    
    printlist = blocksetuplist;
    
    while(printlist)
    {
      //Check if next block is found
      if(printlist->blocknumber != blocknumber)
      {
        //Separate the nets with a blank line
        fprintf(fo, "\n");
        
        //Set the new number for change check
        blocknumber = printlist->blocknumber;
      }
      
      printbititem(fo, printlist);
      
      //Select the next item
      printlist = printlist->next;
    }
    
    fclose(fo);
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

#if 0

void printroutebititem(FILE *fo, pROUTEINFOITEM bitlist)
{
  int count;
  
  //Print the net info
  fprintf(fo, "%d,%d,\"%s\",,", bitlist->netnumber, bitlist->routetype, bitlist->bitdata->bitdata[bitlist->routestartentity].data);

  //Print the data for this item
  fprintf(fo, "%s,%s,%d,%d,,", bitlist->tiledata->name, bitlist->tiledata->type, bitlist->tiledata->x, bitlist->tiledata->y);

  if(bitlist->paddata)
  {
    fprintf(fo, "P%d,,", bitlist->paddata->pin);
  }
  else
  {
    fprintf(fo, ",,");
  }

  fprintf(fo, "%s,%s,%d,%d,%d,%d,,\"", bitlist->bitdata->name, bitlist->bitdata->type, bitlist->bitdata->x, bitlist->bitdata->y, bitlist->bitdata->xoff, bitlist->bitdata->yoff);

  //Walk through all the expression items
  for(count=0;count<bitlist->bitdata->exprcount;count++)
  {
    fprintf(fo, "%s", bitlist->bitdata->expr[count]);
  }

  fprintf(fo, "\",\"");

  //Walk through all the reverse polar notation items
  for(count=0;count<bitlist->bitdata->rpncount;count++)
  {
    fprintf(fo, "%s", bitlist->bitdata->rpn[count]);
  }

  fprintf(fo, "\",%d,,", bitlist->bitdata->datacount);

  //Walk through all the data items
  for(count=0;count<bitlist->bitdata->datacount;count++)
  {
    //Output them to the file
    fprintf(fo, "\"%s\"", bitlist->bitdata->bitdata[count].data);

    //Check if not the last item
    if(count < (bitlist->bitdata->datacount - 1))
    {
      //Add a separator if so
      fprintf(fo, ",");
    }
  }

  fprintf(fo, "\n");
}

//----------------------------------------------------------------------------------------------------------------------------------

void printroutelist()
{
  char filename[255];

  int count;
  int lines = 0;
  
  int netnumber = 1;

  int x;
  int y;

  pROUTEINFOITEM bitlist;
  
  pNETLISTITEM printlist;
  
  FILE *fo;
  
  snprintf(filename, sizeof(filename), "%s_net_list.csv", FILENAME);
  
  fo = fopen(filename, "w");  
  
  if(fo)
  {
    fprintf(fo, "Net,,,,Tile,,,,,Pin,,Bit\n");
    fprintf(fo, "number,type,match,,name,type,x,y,,pin,,name,type,x,y,xoff,yoff,,expression,rpn,count,,data\n");
    
    printlist = netlist;
    
    netnumber = 1;
    
    while(printlist)
    {
      bitlist = printlist->routebit;

      //Check if next net is found
      if(bitlist->netnumber != netnumber)
      {
        //Separate the nets with a blank line
        fprintf(fo, "\n");
        
        //Set the new number for change check
        netnumber = bitlist->netnumber;
      }
      
      printroutebititem(fo, bitlist);
      
      lines++;
      
      //Select the next item
      printlist = printlist->next;
    }

    fprintf(fo, "\n%d\n\n", lines);

    //Check if there are unmatched bits
    if(tileroutecount)
    {
      pROUTEINFOITEM foundrouteitem;
      
      int netnumber = 1;
      
      lines = 0;
      
      //Walk through the tile array to trace the nets for the identified starting points
      for(x=0;x<COLUMNS;x++)
      {
        for(y=0;y<ROWS;y++)
        {
          //Get the first bit for this tile
          bitlist = tileroutearray[x][y];

          while(bitlist)
          {
            if(bitlist->routetype == TYPE_NONE)
            {
              //Need to match the loose bits
              
              //Try to find a connection for this route bit
              if(foundrouteitem = findmatchingpair(bitlist, netnumber))
              {
                printroutebititem(fo, foundrouteitem);
                printroutebititem(fo, foundrouteitem->matingrouteitem);
                fprintf(fo, "\n");
                
                lines += 2;
                
                netnumber++;
              }
              else
              {
                printroutebititem(fo, bitlist);
                fprintf(fo, "\n");
                
                lines++;
              }

            }

            //Select the next item
            bitlist = bitlist->next;
          }
        }
      }

      fprintf(fo, "\n%d\n", lines);
    }
    
    fclose(fo);
  }
}

#else

void printnetlist()
{
  char filename[255];

  char namebuffer[32];
  
  int netnumber = 1;

  pROUTEINFOITEM bitlist;
  
  pNETLISTITEM printlist;
  
  FILE *fo;
  
  snprintf(filename, sizeof(filename), "%s_net_list.csv", FILENAME);
  
  fo = fopen(filename, "w");  
  
  if(fo)
  {
    fprintf(fo, "net number,block number,,signal name,pin\n");
    
    printlist = netlist;
    
    netnumber = 1;
    
    while(printlist)
    {
      bitlist = printlist->routebit;

      //Check if next net is found
      if(bitlist->netnumber != netnumber)
      {
        //Separate the nets with a blank line
        fprintf(fo, "\n");
        
        //Set the new number for change check
        netnumber = bitlist->netnumber;
      }
        
      fprintf(fo, "%d,%d,,", bitlist->netnumber, bitlist->blocknumber);
      
      if(bitlist->netsignal == SIGNAL_GND)
      {
        fprintf(fo, "gnd");
      }
      else if(bitlist->netsignal == SIGNAL_GCLK)
      {
        memcpy(namebuffer, bitlist->startpoints[bitlist->routestartentity].name, bitlist->startpoints[bitlist->routestartentity].length);
        namebuffer[bitlist->startpoints[bitlist->routestartentity].length] = 0;
        
        fprintf(fo, "\"%s\"", namebuffer);
      }
      else
      {
        fprintf(fo, "\"x%d_y%d_", bitlist->tiledata->x, bitlist->tiledata->y);
        
        if(bitlist->signalprefix && bitlist->signalname)
        {
          fprintf(fo, "%s_%s\"", bitlist->signalprefix->signalprefix, bitlist->signalname->hdl_name);
        }
        else
        {
          if(bitlist->netsignal == SIGNAL_OUTPUT)
          {
            memcpy(namebuffer, bitlist->startpoints[bitlist->routestartentity].name, bitlist->startpoints[bitlist->routestartentity].length);
            namebuffer[bitlist->startpoints[bitlist->routestartentity].length] = 0;
          }
          else
          {
            memcpy(namebuffer, bitlist->endpoints[bitlist->routestartentity].name, bitlist->endpoints[bitlist->routestartentity].length);
            namebuffer[bitlist->endpoints[bitlist->routestartentity].length] = 0;
          }
          
          fprintf(fo, "%s\"", namebuffer);
        }

        if(bitlist->paddata)
        {
          fprintf(fo, ",P%d", bitlist->paddata->pin);
          
#ifdef PIN_ASSIGNMENTS
          //try to find a hdl name assigned to the pin
          pPINASSIGNMENTS pinlist = pin_assignments;
          
          while(pinlist->hdl_name)
          {
            if(bitlist->paddata->pin == pinlist->pinnumber)
            {
              fprintf(fo, ",\"%s\"", pinlist->hdl_name);
            }
            
            pinlist++;
          }
#endif
        }
      }
        
      fprintf(fo, "\n");
      
      //Select the next item
      printlist = printlist->next;
    }
    
    fclose(fo);
  }
}

#endif

//----------------------------------------------------------------------------------------------------------------------------------

pTILEGRIDDATA gettileforbit(int frame, int bitindex)
{
  int i;
  int endframe;
  int endbit;
  
  for(i=0;i<TILEGRIDCOUNT;i++)
  {
    if(TileGridData[i].flag == -1)
    {
      endframe = TileGridData[i].startframe + TileGridData[i].rows;
      endbit = TileGridData[i].startbit + TileGridData[i].columns;
      
      if((frame >= TileGridData[i].startframe) && (frame < endframe))
      {
        if((bitindex >= TileGridData[i].startbit) && (bitindex < endbit))
        {
          return(&TileGridData[i]);
        }
      }
    }
  }
  
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

BITDATAPOINTERS bitdatapointers[] = 
{
  { clkdiv_bk1_COUNT, clkdiv_bk1_Data },
  { clkdiv_bk2_COUNT, clkdiv_bk2_Data },
  { clkdiv_bk3_COUNT, clkdiv_bk3_Data },
  { clkdiv_bk4_COUNT, clkdiv_bk4_Data },
  { clkdiv_bk5_COUNT, clkdiv_bk5_Data },
  { clkdiv_bk6_COUNT, clkdiv_bk6_Data },
  { clkdiv_bk7_COUNT, clkdiv_bk7_Data },
  { clkdiv_bk8_COUNT, clkdiv_bk8_Data },
  
  { emb32k_b0_COUNT, emb32k_b0_Data },
  { emb32k_b1_COUNT, emb32k_b1_Data },
  
  { emb_slice_COUNT, emb_slice_Data },
  
  { gclk_csb_COUNT,      gclk_csb_Data },
  { gclk_ctmux_l_COUNT,  gclk_ctmux_l_Data },
  { gclk_ctmux_u_COUNT,  gclk_ctmux_u_Data },
  { gclk_premux_b_COUNT, gclk_premux_b_Data },
  { gclk_premux_l_COUNT, gclk_premux_l_Data },
  { gclk_premux_r_COUNT, gclk_premux_r_Data },
  { gclk_premux_t_COUNT, gclk_premux_t_Data },
  { gclk_spine_COUNT,    gclk_spine_Data },

  { ioclk_bk1_COUNT, ioclk_bk1_Data },
  { ioclk_bk2_COUNT, ioclk_bk2_Data },
  { ioclk_bk3_COUNT, ioclk_bk3_Data },
  { ioclk_bk4_COUNT, ioclk_bk4_Data },
  { ioclk_bk5_COUNT, ioclk_bk5_Data },
  { ioclk_bk6_COUNT, ioclk_bk6_Data },
  { ioclk_bk7_COUNT, ioclk_bk7_Data },
  { ioclk_bk8_COUNT, ioclk_bk8_Data },

  { iol_pair_l_COUNT, iol_pair_l_Data },
  { iol_pair_r_COUNT, iol_pair_r_Data },

  { iol_quad_b_COUNT, iol_quad_b_Data },
  { iol_quad_l_COUNT, iol_quad_l_Data },
  { iol_quad_r_COUNT, iol_quad_r_Data },
  { iol_quad_t_COUNT, iol_quad_t_Data },

  { ios_bankref_bl_COUNT, ios_bankref_bl_Data },
  { ios_bankref_br_COUNT, ios_bankref_br_Data },
  { ios_bankref_l_COUNT,  ios_bankref_l_Data },
  { ios_bankref_r_COUNT,  ios_bankref_r_Data },
  { ios_bankref_tl_COUNT, ios_bankref_tl_Data },
  { ios_bankref_tr_COUNT, ios_bankref_tr_Data },

  { mult_COUNT, mult_Data },
  { osc_COUNT,  osc_Data },
  { pib_COUNT,  pib_Data },
  { plb_COUNT,  plb_Data },
  { pll0_COUNT, pll0_Data },
  { pll2_COUNT, pll2_Data },
};

pCONFIGBITDATA getbitforbitsearchall(int x, int y)
{
  int i;
  int bitdata;
  
  for(bitdata=0;bitdata<(sizeof(bitdatapointers)/sizeof(BITDATAPOINTERS));bitdata++)
  {
    for(i=0;i<bitdatapointers[bitdata].count;i++)
    {
      if((x == bitdatapointers[bitdata].data[i].x) && (y == bitdatapointers[bitdata].data[i].y))
      {
        return(&bitdatapointers[bitdata].data[i]);
      }
    }
  }
  
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

pCONFIGBITDATA getbitforbit(int x, int y, int xoff, pCONFIGBITDATA data, int count)
{
  int i;
  
  for(i=0;i<count;i++)
  {
    if((x == data[i].x) && (y == data[i].y) && (xoff == data[i].xoff))
    {
      return(&data[i]);
    }
  }
  
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

pTILEGRIDDATA gettileforxy(int x, int y, pTILEGRIDDATA starttile)
{
  int i;
  
  for(;starttile < &TileGridData[TILEGRIDCOUNT]; starttile++)
  {
    if((starttile->flag == -1) && (x == starttile->x) && (y == starttile->y))
    {
      return(starttile);
    }
  }
  
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

void freeallmemory()
{
  int x;
  int y;
  
  pROUTEINFOITEM bitlist;
  pROUTEINFOITEM bitfree;

  pBITLISTITEM   setuplist;
  pBITLISTITEM   setupfree;
  
  pNETLISTITEM   netfree;
  
  pBLOCKINFOITEM blockfree;
  
  //Free all the route info data
  for(x=0;x<COLUMNS;x++)
  {
    for(y=0;y<ROWS;y++)
    {
      //Get the list for this tile
      bitlist = tileroutearray[x][y];
      
      //Free all the items in the list
      while(bitlist)
      {
        //Save guard for freeing
        bitfree = bitlist;
        
        //Select the next item in the list before freeing the current one so the trail is not lost
        bitlist = bitlist->next;
        
        //Release this one back into the wild
        free(bitfree);
      }
      
      //Clear the setup lists too
      setuplist = tilesetuparray[x][y];

      //Free all the items in the list
      while(setuplist)
      {
        //Save guard for freeing
        setupfree = setuplist;
        
        //Select the next item in the list before freeing the current one so the trail is not lost
        setuplist = setuplist->link;
        
        //Release this one back into the wild
        free(setupfree);
      }
    }
  }
  
  //Free the memory used in the route list
  //This is the list that holds all the routing items used to form a net
  while(routelist)
  {
    //Same setup as for the bitlist freeing
    netfree = routelist;
    routelist = routelist->next;
    free(netfree);
  }

  //Free the memory used in the net list
  //This is the list that holds the single begin and end items from a net
  while(netlist)
  {
    //Same setup as for the bitlist freeing
    netfree = netlist;
    netlist = netlist->next;
    free(netfree);
  }

  //Free the memory used in the block list
  //This is the list that holds the block numbers and types
  while(blocklist)
  {
    //Same setup as for the bitlist freeing
    blockfree = blocklist;
    blocklist = blocklist->next;
    free(blockfree);
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

int main(int argc, char** argv)
{
  int length;
  int size;
  int frames;
  int b,i,j;
  
  char filename[255];
  
  uchar bit;
  
  int item;
  
  int netnumber = 1;
  
  int routebit;
  
  pTILEGRIDDATA tilegriddata;
  
  pCONFIGBITDATA bitdata;
  
  pFRAMEBITMAPPING framebitdata;

  uchar *sptr = bitstreamdata;
  
  //Clear the needed lists
  memset(tileroutearray, 0, sizeof(tileroutearray));
  memset(tilesetuparray, 0, sizeof(tilesetuparray));
  memset(fpga_tiles, 0, sizeof(fpga_tiles));
  
  //Print the input file name. Expect it to be .bit
  snprintf(filename, sizeof(filename), "%s.bit", FILENAME);
  
  FILE *fin = fopen(filename, "rb");

  if(fin)
  {
    //Load the bitstream data
    length = fread(&bitstreamdata, 1, sizeof(bitstreamdata), fin);
    
    fclose(fin);
    
    //Find the preamble
    while(length)
    {
      if((sptr[0] == 0xCC) && (sptr[1] == 0x55) && (sptr[2] == 0xAA) && (sptr[3] == 0x33))
      {
        //Skip it when found
        sptr += 4;
        break;
      }
      
      //Point to the next character range to check
      sptr++;
      
      //One character done
      length--;
    }
    
    //Go through the block data until the 0xEC tag is found
    while(length)
    {
      //Get the length based on MSB first (big endian) and divide by 8 since it is given in number of bits. Add two for the length field
      //Could do with error handling but nah
      size = (((sptr[0] << 8) | sptr[1]) / 8) + 2;
      
      //Check the tag
      if(sptr[2] == 0xEC)
      {
        //Skip to the number of frames data
        sptr += 4;
        break;
      }
      
      //Skip to the next block size
      sptr += size;
      
      //Take of the bytes done
      length -= size;
    }
    
    //Get the number of frames to load
    frames = (sptr[0] << 8) | sptr[1];
    sptr += 2;
    
    //Load the frame data
    for(i=0;i<frames;i++)
    {
      //Could do a CRC check but the data is trusted to be good
      size = (((sptr[0] << 8) | sptr[1]) / 8);
      sptr += 2;
      
      //The data is known to be 257 bytes for the actual frame data.
      memcpy(fpga_frames[i], sptr, 257);
      
      //Skip to the next block
      sptr += size;
    }
    
    for(i=0;i<FRAMES;i++)
    {
      for(j=0;j<DB_BITS_PER_FRAME;j++)
      {
        //Actual data starts 4 bits into the frame
        b = j + 4;

        //Get the current bit from the frame data
        bit = (fpga_frames[i][b / 8]) << (b % 8);

        //Check if it is active
        if(bit & 0x80)
        {
          //Get the data for this bit based on frame and bit indexes
          framebitdata = &frame_bit_mapping[i][j];

          //This points to a tile and a bit data structure. From these it is possible to list the bit's information
          //A second step is to use the tilepadmap[] (TILEPADPINMAP) to find the pin the bit is connected to

          //Get the tile it belongs to
          tilegriddata = framebitdata->tile;
          bitdata = framebitdata->bit;

          //Check if a tile has not been found via frame-bit mapping
          if(tilegriddata == 0)
          {
            //Try to get the tile it belongs to via tile mapping
            tilegriddata = gettileforbit(i, j);
          }

          //For io routing bits the listed tile is the originating tile for the pad and not perse the tile the routing bits belong to
          //To accommodate for this the bit data needs to be checked first on having x or y offset info

          //Need to create a setup bits list per tile
          //Better yet a list per logic block with per type sorted lists.
          
          
          if(bitdata)
          {
            //Since not all TOP. bits are for routing, this flag is for signaling a bit is used for routing and does not need to be added to the block setup list
            routebit = 0;
            
            //Make a route list
            //Only bits with TOP. in the name indicate routing
            if(strncmp(bitdata->name, "TOP.", 4) == 0)
            {
              //Filter non connection bits
              //These are bits that don't have ARCVAL entities in the data sets
              for(item=0;item<bitdata->datacount;item++)
              {
                //Check if there is at least one ARCVAL item in the list
                if(strncmp(bitdata->bitdata[item].data, "ARCVAL", 6) == 0)
                {
                  //If so this is a proper connection item and the bit needs to be added to the list
                  addtotileroutearray(tilegriddata, bitdata);
                  
                  //Signal this bit is used for routing
                  routebit = 1;

                  //No need to check the remaining items so quit
                  break;
                }
              }
            }
            
            //Only non route bits need to be checked for setup data
            if(routebit == 0)
            {
              //Add it to the tile block array lists
              addtotilesetuplist(tilegriddata, bitdata);
            }            
          }
        }
      }
    }

    //Create a single ground net
    buildgndnet(&netnumber);

    //Create single global clock nets
    buildgclknets(&netnumber);
    
    //Walk through the tile array and mark all the starting points of the routes
    identifynetstarts(&netnumber);

    //Trace the identified nets down to the endpoints
    traceroutelist();

    //Need to make a list of blocks used in the design holding the setup bits
    //sorted on block number and bit name/type
    makeblocksetuplist();
    
    //Print the block list
    printblocklist();

    //Print the setup list
    printsetuplist();
    
    //Filter the route list into a net list
    filterroutelist();
    
    //Print the net list
    printnetlist();
    
    //Memory cleanup
    freeallmemory();
  }
}

//----------------------------------------------------------------------------------------------------------------------------------
