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

//----------------------------------------------------------------------------------------------------------------------------------

#include "database/database.h"

#include "frames/frame_bit_mapping.h"

#include "database/lqfp144_io_pads.h"

//----------------------------------------------------------------------------------------------------------------------------------

typedef unsigned char  uchar;
typedef unsigned int   uint;

typedef unsigned char  uint8;
typedef unsigned short uint16;
typedef unsigned int   uint32;

typedef struct tagBITDATAPOINTERS  BITDATAPOINTERS,  *pBITDATAPOINTERS;
typedef struct tagBITNAMES         BITNAMES,         *pBITNAMES;

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

struct tagROUTEINFOITEM
{
  pROUTEINFOITEM prev;              //Linked list pointers
  pROUTEINFOITEM next;
  
  pTILEGRIDDATA  tiledata;          //Info about the tile the bit belongs to
  pCONFIGBITDATA bitdata;           //Info about what the bit means
  pTILEPADPINMAP paddata;           //Info about the IO pad the bit possibly belongs to

  pROUTEINFOITEM matingrouteitem;   //When a connection pair is found the other bit is linked here
  
  int            netnumber;         //Net this bit belongs to
  int            netsignal;         //Type of signal
  
  int            routetype;         //Route type for this bit that signals for instance a start or end point 
  int            routestartentity;  //The ARCVAL entity that is used in the match with the mating bit
  int            routeconnected;    //A flag to signal a connection to the next node has been made
  
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

//#define FILENAME   "fpgas/Original_1013D_fpga"

#define FILENAME         "/home/peter/Data/Anlogic_projects/pin_test/pin_test"


//#define FILENAME   "fpgas/pin_test_23-112"

//#define FILENAME   "pin_test_old_p23-p112"

//#define FILENAME   "pin_test"

//#define FILENAME   "Scope12"
//#define FILENAME   "/home/peter/Data/Anlogic_projects/Scope15/Scope15"

//#define FILENAME   "fpgas/Original_1014D_fpga"

//----------------------------------------------------------------------------------------------------------------------------------

//Array for gathering the routing bits in a tile
pROUTEINFOITEM tileroutearray[COLUMNS][ROWS];

//Counters to keep track of the number of route bits
int tileroutecountarray[COLUMNS][ROWS];
int tileroutecount;

//A sorted route list is made in this list
pNETLISTITEM  routelist = 0;

//A sorted and filtered net list is made in this list
pNETLISTITEM  netlist = 0;
ppNETLISTITEM netlistlast  = 0;

//----------------------------------------------------------------------------------------------------------------------------------

void additemtofinalnetlist(pROUTEINFOITEM item)
{
  //Get memory for the net list item for this bit
  pNETLISTITEM netitem = malloc(sizeof(pNETLISTITEM));

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
  pNETLISTITEM netitem = malloc(sizeof(pNETLISTITEM));
  
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
            //See if it is a ground point or not
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

    //Check if a ground net is found
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

int getnumberfromitem(pNAMEITEM item)
{
  int count = item->length;
  int number = -1;
  
  char *ptr = item->name;
  
  //skip characters until a digit is found
  while(count)
  {
    //A route entity only has a single digit from 0 to max 7
    if((*ptr >= '0') && (*ptr <= '7'))
    {
      //COnvert the digit into a number
      number = *ptr - '0';
      
      //Found it so done
      break;
    }
    
    //Skip to next character until done
    ptr++;
    count--;
  }
  
  return(number);
}

//----------------------------------------------------------------------------------------------------------------------------------

const pTILEPADPINMAP getpinmapfortile(pROUTEINFOITEM routeitem)
{
  int iol = -1;
  int i;
  
  int x = routeitem->tiledata->x;
  int y = routeitem->tiledata->y;
  
  pTILEGRIDDATA  tiledata = routeitem->tiledata;
  pCONFIGBITDATA bitdata  = routeitem->bitdata;

  //A bit of a problem here is that the bits connection to the IO pads are
  //in the first tile of three per io section??
  
  
  //An IO pin is only situated in pib tiles
  if(strncmp(tiledata->type, "pib", 3) == 0)
  {
    //Take action based on the signal type
    if(routeitem->netsignal == SIGNAL_OUTPUT)
    {
      //For an output the data to check is in the start points
      iol = getnumberfromitem(&routeitem->startpoints[routeitem->routestartentity]);
    }
    else
    {
      //For an input the data to check is in the end points
      iol = getnumberfromitem(&routeitem->endpoints[routeitem->routestartentity]);
    }
  }  
  
  //Check if a pad number has been found
  if(iol != -1)
  {
    //pad numbers can only be 0 to max 3
    if(iol > 3)
    {
      //Any number above is a mirror to the complementary items
      iol -= 4;
    }
    
    //Try to match the found pad number to an actual pin number
    for(i=0;i<sizeof(tilepadmap)/sizeof(TILEPADPINMAP);i++)
    {
      //Match the numbers to the table for the 144 pin variant the FNIRSI uses
      if((x == tilepadmap[i].x) && (y == tilepadmap[i].y) && (iol == tilepadmap[i].iol))
      {
        //When found return the info to the caller
        return((const pTILEPADPINMAP)&tilepadmap[i]);
      }
    }
  }  

  //Nothing found so signal this
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

void filterroutelist()
{
  pNETLISTITEM  fromlist = routelist;
  
  pROUTEINFOITEM routeitem;
  
  //Also needed is mapping of the data onto IO pins and logic slices or other embedded logic. tiledata provides information here.
  
  
  char *name;
  int  length;
  
  int netnumber = 0;  
  
  while(fromlist)
  {
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
        
        //Try to match the output to a pin output or a slice output or whatever is possible
        routeitem->paddata = getpinmapfortile(routeitem);

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
        
        //Check if there is a matching pair for this route bit
        if(routeitem->matingrouteitem)
        {
          //If so flag it as input signal too so it will be filtered from the list
          routeitem->matingrouteitem->netsignal = SIGNAL_INPUT;
        }
        
        //Try to match the input to a pin input or a slice input or whatever is possible 
        routeitem->paddata = getpinmapfortile(routeitem);
        
        //Add it to the net list
        additemtofinalnetlist(routeitem);
      }
    }
    
    fromlist = fromlist->next;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

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

void printnetlist()
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

  pNETLISTITEM   netfree;
  
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
    }
  }
  
  //Free the memory used in the route list
  while(routelist)
  {
    //Same setup as for the bitlist freeing
    netfree = routelist;
    routelist = routelist->next;
    free(netfree);
  }

  //Free the memory used in the net list
  while(netlist)
  {
    //Same setup as for the bitlist freeing
    netfree = netlist;
    netlist = netlist->next;
    free(netfree);
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
  
  pTILEGRIDDATA tilegriddata;
  
  pCONFIGBITDATA bitdata;
  
  pFRAMEBITMAPPING framebitdata;

  uchar *sptr = bitstreamdata;
  
  //Clear the needed lists
  memset(tileroutearray, 0, sizeof(tileroutearray));
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

          if(bitdata)
          {
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

                  //No need to check the remaining items so quit
                  break;
                }
              }
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

    //Filter the route list into a net list
    filterroutelist();
    
    //Print the net list
    printnetlist();
    
    //Memory cleanup
    freeallmemory();
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

