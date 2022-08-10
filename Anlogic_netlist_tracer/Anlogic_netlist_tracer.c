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
#define TYPE_MULTIPOINT           5    //No idea yet if it is needed


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
typedef struct tagBITLISTITEM      BITLISTITEM,      *pBITLISTITEM;

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

struct tagBITLISTITEM
{
  pBITLISTITEM   prev;
  pBITLISTITEM   next;
  pTILEGRIDDATA  tiledata;
  pCONFIGBITDATA bitdata;
  pTILEPADPINMAP paddata;
  
  int            currentbit;        //Flag to signal this is the bit a matching pair is being searched for, so needs to be skipped if set.
  
  int            routetype;
  int            routenumber;
  int            routestartentity;
    
  pROUTEINFOITEM routeitem;
  
  pBITLISTITEM   matingrouteitem;
};

struct tagNAMEITEM
{
  char *name;
  int   length;
};

struct tagROUTEINFOITEM
{
  pROUTEINFOITEM prev;
  pROUTEINFOITEM next;
  
  pBITLISTITEM   bitlistitem;
  
  int            nofentities;
  
  NAMEITEM       startpoints[MAXENTITIES];
  NAMEITEM       endpoints[MAXENTITIES];
  NAMEITEM       pointpairs[MAXENTITIES];
};

struct tagNETLISTITEM
{
  pNETLISTITEM next;

  pBITLISTITEM bitlistitem;
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

pBITLISTITEM iolist = 0;
pBITLISTITEM routelist = 0;

//Array for gathering the routing bits in a tile
pROUTEINFOITEM tileroutearray[COLUMNS][ROWS];

//Pointers for a net list with adding to the end of the list
pNETLISTITEM  netliststart = 0;
ppNETLISTITEM netlistlast  = 0;

//----------------------------------------------------------------------------------------------------------------------------------

void additemtonetlist(pBITLISTITEM item)
{
  //Get memory for the net list item for this bit
  pNETLISTITEM netitem = malloc(sizeof(pNETLISTITEM));

  //Setup the net list item
  netitem->bitlistitem = item;
  netitem->next = 0;
  
  //Add the route point to the net list
  if(netliststart == 0)
  {
    //No items added yet so start with this one
    netliststart = netitem;
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

void insertitembeforeroutelist(pBITLISTITEM current, pBITLISTITEM new)
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

pBITLISTITEM addtoroutelist(pTILEGRIDDATA tiledata, pCONFIGBITDATA bitdata, pTILEPADPINMAP paddata)
{
  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;

  //Get memory for the bit list item for this bit
  bitlistitem = malloc(sizeof(BITLISTITEM));

  //Set the source information
  bitlistitem->tiledata = tiledata;
  bitlistitem->bitdata  = bitdata;
  bitlistitem->paddata  = paddata;
  
  bitlistitem->routetype   = TYPE_NONE;
  bitlistitem->routenumber = 0;
  
  //Add this route bit in the route list
  if(routelist == 0)
  {
    //First item in the list, so no previous and next
    bitlistitem->prev = 0;
    bitlistitem->next = 0;

    //Set it as the first item of the list
    routelist = bitlistitem;
  }
  else
  {
    //Get the first list item
    bitlist = routelist;

    //Look for where the data needs to be inserted or replaced
    while(bitlist)
    {
      //Sort on tile x,y and then XI properties
      if(tiledata->x < bitlist->tiledata->x)
      {
        //Insert the item before the current one
        insertitembeforeroutelist(bitlist, bitlistitem);
        break;
      }

      //On equal x check the next property
      if(tiledata->x == bitlist->tiledata->x)
      {
        //Next in the sort is y
        if(tiledata->y < bitlist->tiledata->y)
        {
          //Insert the item before the current one
          insertitembeforeroutelist(bitlist, bitlistitem);
          break;
        }      
        
        //On equal y check the next property
        if(tiledata->y == bitlist->tiledata->y)
        {
          //Sort on the bit name next
          if(strcmp(bitdata->name, bitlist->bitdata->name) < 0)
          {
            //Insert the item before the current one
            insertitembeforeroutelist(bitlist, bitlistitem);
            break;
          }
        }
      }      

      //Point to the next item if there is one
      if(bitlist->next)
      {
        //Select the next item
        bitlist = bitlist->next;
      }
      else
      {
        //Append to the list when this is the last item
        bitlistitem->prev = bitlist;
        bitlistitem->next = 0;
        bitlist->next = bitlistitem;

        //Done so quit
        break;
      }
    }
  }
  
  return(bitlistitem);
}

//----------------------------------------------------------------------------------------------------------------------------------

void addtotileroutearray(pBITLISTITEM bitlistitem)
{
  pROUTEINFOITEM routinfoitem;

  pTILEGRIDDATA  tiledata = bitlistitem->tiledata;
  pCONFIGBITDATA bitdata  = bitlistitem->bitdata;

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

  //Set the route data for later use
  routinfoitem->bitlistitem = bitlistitem;
  
  //Link for access from sorted route list
  bitlistitem->routeitem = routinfoitem;
  
  //Need to dissect the data into start and end points
  //Set the count for limiting searching through not set data
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

int checkstartingpoint(pBITLISTITEM bitlistitem, int netnumber)
{
  int item;
  int pair;
  
  pROUTEINFOITEM routeinfoitem = bitlistitem->routeitem;
  pNAMEITEM      arcvalentity;
  
  pROUTEINFOITEM tileroutelist;
  
  //Check all the arcval start point entities to see if it is an output (starting with F, FX or Q)
  for(item=0;item<routeinfoitem->nofentities;item++)
  {
    //Get the current start point entity to check
    arcvalentity = &routeinfoitem->startpoints[item];
    
    //GND and GCLK can also be a start point
    //CE, SR, CLK can be both a start or an end point
    //The question is if CLK0 and CLK1 can be seen as a start point. It might be that they are local clock wires and as such part of bigger nets
    //For now they will be used as starting points too
    
    //Maybe a more dedicated matching can be done with strncmp and per type signal this in the route to know if it is a global clock or any of the other signals
    
    //See if the current start point matches an output entity
    if(((arcvalentity->length == 2) && ((arcvalentity->name[0] == 'F') || (arcvalentity->name[0] == 'Q'))) ||
       ((arcvalentity->length == 3) &&  (arcvalentity->name[0] == 'F') && (arcvalentity->name[1] == 'X'))  ||
       ((arcvalentity->length == 3) &&  (arcvalentity->name[0] == 'C') && (arcvalentity->name[1] == 'E'))  ||
       ((arcvalentity->length == 3) &&  (arcvalentity->name[0] == 'S') && (arcvalentity->name[1] == 'R'))  ||
       ((arcvalentity->length == 3) &&  (arcvalentity->name[0] == 'G') && (arcvalentity->name[1] == 'N')   && (arcvalentity->name[2] == 'D')) ||
       ((arcvalentity->length == 4) &&  (arcvalentity->name[0] == 'C') && (arcvalentity->name[1] == 'L')   && (arcvalentity->name[2] == 'K')) ||
      (((arcvalentity->length == 5) ||  (arcvalentity->length == 6))   && (arcvalentity->name[0] == 'G')   && (arcvalentity->name[1] == 'C') && (arcvalentity->name[2] == 'L') && (arcvalentity->name[3] == 'K')))
    {
      //Flag this bit as the original one so it can be skipped
      bitlistitem->currentbit = 1;
      
      //Get the route list for the tile the original route belongs to
      tileroutelist = tileroutearray[bitlistitem->tiledata->x][bitlistitem->tiledata->y];

      //Check the other route bits in this tile
      while(tileroutelist)
      {
        //Make sure this is not the original item
        if(tileroutelist->bitlistitem->currentbit == 0)
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
                bitlistitem->routestartentity = item;
                tileroutelist->bitlistitem->routestartentity = pair;

                //Mark both route items as start point
                bitlistitem->routetype = TYPE_STARTPOINT;
                tileroutelist->bitlistitem->routetype = TYPE_STARTPOINT;

                //Set the net number for both items
                bitlistitem->routenumber = netnumber;
                tileroutelist->bitlistitem->routenumber = netnumber;

                //Add both items to the net list
                additemtonetlist(bitlistitem);
                additemtonetlist(tileroutelist->bitlistitem);
                
                //Link the two bits together
                bitlistitem->matingrouteitem = tileroutelist->bitlistitem;
                tileroutelist->bitlistitem->matingrouteitem = bitlistitem;
                
                //Clear the current bit
                bitlistitem->currentbit = 0;
                
                //Signal that a starting route has been found
                return(1);
              }
            }              
          }
        }

        tileroutelist = tileroutelist->next;
      }
      
      //No matching pair found then clear the current bit
      bitlistitem->currentbit = 0;
    }
  }
  
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

pBITLISTITEM findrouteconnection(pROUTEINFOITEM searchlist, char *entity, int length, int netnumber)
{
  int item;
  int pair;
  
  pNAMEITEM      arcvalentity;
  
  pROUTEINFOITEM tileroutelist = searchlist;
  pROUTEINFOITEM matchlist;

  pBITLISTITEM   bitlistitem;
  
  //Loop through the tileroutelist to find a matching pair
  
  //First check if current route is not already used for a net (question is what to do for multipoint routes, no idea if a start point can exist of more than one connection)

  //Check the other route bits in this tile
  while(tileroutelist)
  {
    //First check if the current route is not assigned yet. Have to figure out if this is correct.
    if(tileroutelist->bitlistitem->routetype == TYPE_NONE)
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
            //At this point a matching pair needs to be found. When that fails the remainder of the items needs to be checked
            bitlistitem = tileroutelist->bitlistitem;

            //Flag this bit as the original one so it can be skipped
            bitlistitem->currentbit = 1;
            
            //Setup the list to search a match in
            matchlist = searchlist;

            //Check the other route bits in this tile
            while(matchlist)
            {
              //Make sure this is not the original item
              if(matchlist->bitlistitem->currentbit == 0)
              {
                //Need a for loop to check the pairs here
                for(pair=0;pair<matchlist->nofentities;pair++)
                {
                  //Check if the lengths match before comparing the strings
                  if(tileroutelist->pointpairs[item].length == matchlist->pointpairs[pair].length)
                  {
                    //match the current pair with the to test one
                    if(strncmp(tileroutelist->pointpairs[item].name, matchlist->pointpairs[pair].name, tileroutelist->pointpairs[item].length) == 0)
                    {
                      //Set the index for the entity that matches for these route items
                      bitlistitem->routestartentity = item;
                      matchlist->bitlistitem->routestartentity = pair;

                      //Maybe do a check here to see if it is an end point
                      //Also have to figure out how an output is routed onto multiple inputs
                      
                      
                      //Mark both route items as route point
                      bitlistitem->routetype = TYPE_ROUTEPOINT;
                      matchlist->bitlistitem->routetype = TYPE_ROUTEPOINT;

                      //Set the net number for both items
                      bitlistitem->routenumber = netnumber;
                      matchlist->bitlistitem->routenumber = netnumber;

                      //Add both items to the net list
                      additemtonetlist(bitlistitem);
                      additemtonetlist(matchlist->bitlistitem);

                      //Link the pair to each other
                      bitlistitem->matingrouteitem = matchlist->bitlistitem;
                      matchlist->bitlistitem->matingrouteitem = bitlistitem;

                      //Clear the current bit
                      bitlistitem->currentbit = 0;
                      
                      //Signal that a connection has been found
                      return(bitlistitem);
                    }
                  }              
                }
              }

              //Next item to match a pair with
              matchlist = matchlist->next;
            }
            
            //When there is no matching pair found clear the current bit
            bitlistitem->currentbit = 0;
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

void traceroutelist()
{
  //Scan the route list to find a starting point of a net
  
  //Start with the actual sorted route list to find a starting point
  //This is not that simple and requires some analysis
  //There needs to be an output entity in one of the available arcvals to consider something a starting point
  //So an entity that starts with Q, F or FX followed by a digit can be a starting point
  
  //When such a starting point is found trace down the matching bit by finding the matching pair
  //Might need an iterative search through the lists
  
  //When found assign a net number to it.
  
  //Then the route needs to be traced based on the direction of the endpoint
  //This can be an interconnect, a local signal, a direct net (output back on input) or a clock signal
  
  //Here the fold back logic is needed when a calculated block is out of range
  
  //First action is trace actual interconnects
  
  
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
  
  int netnumber = 1;
  
  pBITLISTITEM bitlist = routelist;
  pBITLISTITEM tracetbitlist;
  pBITLISTITEM foundbitlist;
  
  pROUTEINFOITEM routeinfoitem;
  
  pROUTEINFOITEM tileroutelist;

  int routetype;
  

  while(bitlist)
  {
    //Check if the current route bit is not typed already
    if(bitlist->routetype == TYPE_NONE)
    {
      //See if it is a starting point or not
      if(checkstartingpoint(bitlist, netnumber) == 1)
      {
        //For the first connection it can be a single point net
        routetype = TYPE_NET;
        
        //Need a second pointer to trace the route
        tracetbitlist = bitlist;

        //Need to loop back to here to repeat the process of tracking the route
        while(tracetbitlist)
        {
          //Get the routing info for this bit
          routeinfoitem = tracetbitlist->routeitem;

          //Trace the net through the connects
          //The current bitlist item holds the information about the endpoint to match to

          //Get the current endpoint specifics
          name   = routeinfoitem->endpoints[tracetbitlist->routestartentity].name;
          length = routeinfoitem->endpoints[tracetbitlist->routestartentity].length;

          //Determine if this is an end point for this net
          //For the first entry it can be a single route net (only two route bits set for it) runs from an output to an input without an inter or local connect
          //For the next entries it can be the end point
          //Check if the endpoint is a logic or io block input signal A, B, C, D, E, MI, CE, CLK_S, SR
          //Clock nets also need to be set as single route nets
          if(((length == 2) && ((name[0] == 'A') || (name[0] == 'B')  || (name[0] == 'C')  || (name[0] == 'D') || (name[0] == 'E'))) ||
             ((length == 3) &&  (name[0] == 'M') && (name[1] == 'I')) ||
             ((length == 3) &&  (name[0] == 'C') && (name[1] == 'E')) ||
             ((length == 3) &&  (name[0] == 'S') && (name[1] == 'R')) ||
             ((length == 4) &&  (name[0] == 'C') && (name[1] == 'L')  && (name[2] == 'K')) ||
             ((length == 6) &&  (name[0] == 'C') && (name[1] == 'L')  && (name[2] == 'K')  && (name[3] == '_') && (name[4] == 'S')))
          {
            //Make this a either a single point or an endpoint
            tracetbitlist->routetype = routetype;
            tracetbitlist->matingrouteitem->routetype = routetype;

            
            //Before hopping onto the next net the start point should be ran again through the bits to see if there is another matching pair
            
            //The question is if this is the case for every point on a route, so that there can be several branches that need to be traced??
            
            //In case of the start point being an output of a block this is not a problem because that will be found anyway, but it should show up as a single net.
            
            
            
            
            
            //Done with this net so setup for next one
            netnumber++;

            //Signal done with the search
            tracetbitlist = 0;
          }
          else
          {
            //Not the end or a single point net so need to trace it down through the inter and local connects
            //For a connection with more route points signal endpoint type
            routetype = TYPE_ENDPOINT;
            
            //LOCAL connect wires are only driven from interconnect wires, and only drive local inputs
            //Check if it is an actual start of a interconnect wire. Format is like N2BEG7
            if(strncmp(name, "LOCAL", 5) == 0)
            {
              //Get the route list to search, which is the current tile for a LOCAL route
              tileroutelist = tileroutearray[tracetbitlist->tiledata->x][tracetbitlist->tiledata->y];
              
              //Go and try to find a matching route set
              foundbitlist = findrouteconnection(tileroutelist, name, length, netnumber);
              
              //Check if a match has been found
              if(foundbitlist)
              {
                //Use the new route bit to track the net further
                tracetbitlist = foundbitlist;
              }
              else
              {
                //When no match is found there is an error condition
                //Signal an error at this point
                tracetbitlist = 0;
                
                //Make sure the loop is quit
                bitlist->next = 0;
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
              x = tracetbitlist->tiledata->x;
              y = tracetbitlist->tiledata->y;
              
              
              if((x == 3) && (y == 20) && (strcmp(tracetbitlist->bitdata->name, "TOP.XI46.MC13") == 0))
              {
                direction = 'A';
              }

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
                    x = tracetbitlist->tiledata->x + hop;

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
                    x = tracetbitlist->tiledata->x - hop;

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
                    y = tracetbitlist->tiledata->y + hop;

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
                    y = tracetbitlist->tiledata->y - hop;

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

                //Search the route list for a matching entity
                //Need to construct the entity to look for
                //Best use a snprintf function above and a fixed size buffer to create the search term

                //Follow up searches can include LOCAL items!!!!

                //Get the route list to search
                tileroutelist = tileroutearray[x][y];

                //Go and try to find a matching route set
                foundbitlist = findrouteconnection(tileroutelist, entity, length, netnumber);

                //Check if a match has been found
                if(foundbitlist)
                {
                  //Use the new route bit to track the net further
                  tracetbitlist = foundbitlist;

                  //Signal done for this route point
                  hop = hops;
                }
              }
              
              //When there is no new bitlist set at this point there is no matching connection found which is an error
              if(foundbitlist == 0)
              {
                //Signal an error at this point
                tracetbitlist = 0;
                
                //Make sure the loop is quit
                bitlist->next = 0;
              }
            }
            else
            {
              //This is an error condition so mark this route as such and continue
              tracetbitlist->routetype = TYPE_ERROR;
              tracetbitlist->matingrouteitem->routetype = TYPE_ERROR;

              //Done with this net so setup for next one
              netnumber++;

              //Signal done with the search
              tracetbitlist = 0;
            }
              
          } 
        }
      }
    }
    
    //Select the next bit to investigate
    bitlist = bitlist->next;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void printroutelist()
{
  char filename[255];

  int count;
  int lines = 0;
  
  int netnumber = 1;
  
  pBITLISTITEM bitlist = routelist;
  
  pNETLISTITEM printlist;
  
  FILE *fo;

  
  //Memory freeing needs to be added too
  
  snprintf(filename, sizeof(filename), "%s_net_list.csv", FILENAME);
  
  fo = fopen(filename, "w");  
  
  if(fo)
  {
    fprintf(fo, "Net,,,,Tile,,,,,Pin,,Bit\n");
    fprintf(fo, "number,type,match,,name,type,x,y,,pin,,name,type,x,y,xoff,yoff,,expression,rpn,count,,data\n");
    
    printlist = netliststart;
    
    netnumber = 1;
    
    while(printlist)
    {
      bitlist = printlist->bitlistitem;

      //Check if next net is found
      if(bitlist->routenumber != netnumber)
      {
        //Separate the nets with a blank line
        fprintf(fo, "\n");
        
        //Set the new number for change check
        netnumber = bitlist->routenumber;
      }
      
      //Print the net info
      fprintf(fo, "%d,%d,\"%s\",,", bitlist->routenumber, bitlist->routetype, bitlist->bitdata->bitdata[bitlist->routestartentity].data);
      
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
      
      lines++;
      
      //Select the next item
      printlist = printlist->next;
    }

    fprintf(fo, "\n%d\n\n", lines);
    
    
    
    
    //List the unassigned bits
    
    bitlist = routelist;
    lines = 0;
    
    
    while(bitlist)
    {
      if(bitlist->routetype == TYPE_NONE)
      {
        //Print the net info
        fprintf(fo, "%d,%d,\"%s\",,", bitlist->routenumber, bitlist->routetype, bitlist->bitdata->bitdata[bitlist->routestartentity].data);

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

        lines++;
      }
      
      //Select the next item
      bitlist = bitlist->next;
    }

    fprintf(fo, "\n%d\n", lines);
    
    
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

const pTILEPADPINMAP getpinmapfortile(int x, int y, pCONFIGBITDATA bitdata)
{
  int iol = -1;
  int i;
  
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
  
  //When no bit name matches check if it is a routing from or to a pad
  if((iol == -1) && (strncmp(bitdata->name, "TOP.", 4) == 0))
  {
    //For XI numbers from 300 and above it could be an IO route
    if(atoi(&bitdata->name[6]) >= 300)
    {
      //To check if it is a IO route the first data item can be checked
      if(bitdata->datacount)
      {
        //This property seems to be a correct indicator for a pad number
        if(strncmp(bitdata->bitdata[0].data, "PROPERTY(IOL", 12) == 0)
        {
          iol = atoi(&bitdata->bitdata[0].data[12]);
        }
        //This is not certain. First item after the ARCVAL( is a letter followed by a digit
        else if(strncmp(bitdata->bitdata[0].data, "ARCVAL(", 7) == 0)
        {
          //This is not correct and I have no idea how it is actually matched to the IO pad in question
          iol = atoi(&bitdata->bitdata[0].data[8]);
          
          //Only 0 - 3 allowed
          if(iol > 3)
          {
            iol = -1;
          }
        }
      }
    }
  }  
  
  //Check if a pad number has been found
  if(iol != -1)
  {
    for(i=0;i<sizeof(tilepadmap)/sizeof(TILEPADPINMAP);i++)
    {
      if((x == tilepadmap[i].x) && (y == tilepadmap[i].y) && (iol == tilepadmap[i].iol))
        return((const pTILEPADPINMAP)&tilepadmap[i]);
    }
  }  

  return(0);
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
  
  int count;
  
  pTILEGRIDDATA tilegriddata;
  
  pCONFIGBITDATA bitdata;
  
  pFRAMEBITMAPPING framebitdata;

  pTILEPADPINMAP tilepadinmap;
  
  pBITLISTITEM bitlistitem;

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
            tilepadinmap = getpinmapfortile(tilegriddata->x, tilegriddata->y, bitdata);

            //Make a route list
            //Only bits with TOP. in the name indicate routing
            if(strncmp(bitdata->name, "TOP.", 4) == 0)
            {
              //For each topology bit a new entry is created
              bitlistitem = addtoroutelist(tilegriddata, bitdata, tilepadinmap);

              //Setup a tile route array for tracking them back into a net list
              //Each topology item is dissected into separate entities for easier route matching
              addtotileroutearray(bitlistitem);
            }
          }
        }
      }
    }

    //Trace the routes back to a net list
    traceroutelist();

    //Print the list
    printroutelist();
  }

}

//----------------------------------------------------------------------------------------------------------------------------------