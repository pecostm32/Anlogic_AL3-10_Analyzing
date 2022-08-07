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

typedef struct tagCOLORSTRUCT      COLORSTRUCT,      *pCOLORSTRUCT;
typedef struct tagBITDATAPOINTERS  BITDATAPOINTERS,  *pBITDATAPOINTERS;
typedef struct tagBITNAMES         BITNAMES,         *pBITNAMES;
typedef struct tagBITLISTITEM      BITLISTITEM,      *pBITLISTITEM;

typedef struct tagARCVALENTITY     ARCVALENTITY,     *pARCVALENTITY;
typedef struct tagROUTEINFOITEM    ROUTEINFOITEM,    *pROUTEINFOITEM;

typedef struct tagNETLISTITEM      NETLISTITEM,      *pNETLISTITEM,      **ppNETLISTITEM;

//----------------------------------------------------------------------------------------------------------------------------------

struct tagCOLORSTRUCT
{
  uint8 red;
  uint8 green;
  uint8 blue;
};

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
  int            xinumber;
  int            mcnumber;
  int            netnumber;
  
  int            routetype;
  int            routenumber;
  int            routestartentity;
    
  pROUTEINFOITEM routeitem;
  
  pBITLISTITEM   matingrouteitem;
};

struct tagARCVALENTITY
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
  
  ARCVALENTITY   startpoints[MAXENTITIES];
  ARCVALENTITY   endpoints[MAXENTITIES];
  ARCVALENTITY   pointpairs[MAXENTITIES];
};

struct tagNETLISTITEM
{
  pNETLISTITEM next;

  pBITLISTITEM bitlistitem;
};

//----------------------------------------------------------------------------------------------------------------------------------

extern unsigned char CharacterMap[256][8];

//----------------------------------------------------------------------------------------------------------------------------------

uchar fpga_frames[FRAMES][BITS_PER_FRAME / 8];

uchar bitstreamdata[2097152];

uchar fpga_tiles[COLUMNS][ROWS];

#define FILENAME   "fpgas/Original_1013D_fpga"

//#define FILENAME         "/home/peter/Data/Anlogic_projects/pin_test/pin_test"


//#define FILENAME   "fpgas/pin_test_23-112"

//#define FILENAME   "pin_test_old_p23-p112"

//#define FILENAME   "pin_test"

//#define FILENAME   "Scope12"
//#define FILENAME   "/home/peter/Data/Anlogic_projects/Scope15/Scope15"

//#define FILENAME   "fpgas/Original_1014D_fpga"

//----------------------------------------------------------------------------------------------------------------------------------

void draw_horz_line(uint8 *buffer, uint32 bytesperrow, uint32 ypos, uint32 xstart, uint32 xend, uint32 color)
{
  uint8 *ptr;
  uint32 x, xs, xe;
  
  uint8 red   = color;
  uint8 green = color >> 8;
  uint8 blue  = color >> 16;
  
  //Determine the lowest x for start point
  if(xstart < xend)
  {
    //Use the coordinates as is
    xs = xstart;
    xe = xend;
  }
  else
  {
    //Swap start and end
    xs = xend;
    xe = xstart;
  }

  //Point to where the line needs to be drawn
  ptr = buffer + ((ypos * bytesperrow) + (xs * 3));
  
  //Draw the dots
  for(x=xs;x<=xe;x++)
  {
    //Fill the dot
    *ptr++ = red;
    *ptr++ = green;
    *ptr++ = blue;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void draw_vert_line(uint8 *buffer, uint32 bytesperrow, uint32 xpos, uint32 ystart, uint32 yend, uint32 color)
{
  uint8 *ptr;
  uint32 y, ys, ye;
  uint32 pixels = bytesperrow;
  
  uint8 red   = color;
  uint8 green = color >> 8;
  uint8 blue  = color >> 16;
  
  //Determine the lowest y for start point
  if(ystart < yend)
  {
    //Use the coordinates as is
    ys = ystart;
    ye = yend;
  }
  else
  {
    //Swap start and end
    ys = yend;
    ye = ystart;
  }

  //Point to where the line needs to be drawn
  ptr = buffer + ((ys * pixels) + (xpos * 3));
  
  //Draw the dots
  for(y=ys;y<=ye;y++)
  {
    //Fill the dot
    ptr[0] = red;
    ptr[1] = green;
    ptr[2] = blue;
    
    //Point to the next dot
    ptr += pixels;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void draw_rect(uint8 *buffer, uint32 bytesperrow, uint32 xpos, uint32 ypos, uint32 width, uint32 height, uint32 color)
{
  //Compensate for the last pixel
  width--;
  height--;
  
  uint32 xe = xpos + width;
  uint32 ye = ypos + height;
  
  //Just draw the needed lines
  draw_horz_line(buffer, bytesperrow, ypos, xpos, xe, color);
  draw_horz_line(buffer, bytesperrow, ye, xpos, xe, color);
  draw_vert_line(buffer, bytesperrow, xpos, ypos, ye, color);
  draw_vert_line(buffer, bytesperrow, xe, ypos, ye, color);
}

//----------------------------------------------------------------------------------------------------------------------------------

void draw_character(uint8 *buffer, uint32 bytesperrow, uint32 xpos, uint32 ypos, uint32 color, char character)
{
  unsigned char *rows = CharacterMap[character];
  unsigned char  col;
  int ri,ci;
  
  uint8 *ptr;
  
  uint8 red   = color;
  uint8 green = color >> 8;
  uint8 blue  = color >> 16;

  //Each character has 8 rows and per row the top 5 bits are used
  for(ri=0;ri<8;ri++)
  {
    //Get the pixels for this row
    col = rows[ri];
    
    //Start at first dot
    ptr = buffer + ((ypos * bytesperrow) + (xpos * 3));
    
    //Plot the on pixels
    for(ci=0;ci<5;ci++)
    {
      //Check if current dot is on
      if(col & 0x80)
      {
        //Fill the dot
        *ptr++ = red;
        *ptr++ = green;
        *ptr++ = blue;
      }
      else
      {
        //Clear the dot
        *ptr++ = 0;
        *ptr++ = 0;
        *ptr++ = 0;
      }
      
      //Select next dot
      col <<= 1;
    }
    
    //Move to next row
    ypos++;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void draw_text(uint8 *buffer, uint32 bytesperrow, uint32 xpos, uint32 ypos, uint32 color, char *text)
{
  //Display the string
  while(*text)
  {
    //Draw the current character
    draw_character(buffer, bytesperrow, xpos, ypos, color, *text);
    
    //Select next character
    text++;
    
    //Point to next character column
    xpos += 6;
  }
}

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

  char *xiname;
  char *mcname;
  char *netname;
  
  //Get memory for the bit list item for this bit
  bitlistitem = malloc(sizeof(BITLISTITEM));

  //Set the source information
  bitlistitem->tiledata = tiledata;
  bitlistitem->bitdata  = bitdata;
  bitlistitem->paddata  = paddata;
  
  bitlistitem->routetype   = TYPE_NONE;
  bitlistitem->routenumber = 0;

  //MC or NET number could be missing so initialize as not there
  bitlistitem->mcnumber = -1;
  bitlistitem->netnumber = -1;

  //Get routing the numbers
  xiname = strstr(bitdata->name, "XI");
  mcname = strstr(bitdata->name, "MC");
  netname = strstr(bitdata->name, "NET");
  
  //All TOP. bits have a XI number
  bitlistitem->xinumber = atoi(&xiname[2]);

  //Check if this is a MC type
  if(mcname)
  {
    //The MC type is not always a straight number but will do for now
    bitlistitem->mcnumber = atoi(&mcname[2]);
  }
  //Not a MC type then check if it is a NET type
  else if(netname)
  {
    bitlistitem->netnumber = atoi(&netname[3]);
  }
  
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
          //Sort on the XI number next
          if(bitlistitem->xinumber < bitlist->xinumber)
          {
            //Insert the item before the current one
            insertitembeforeroutelist(bitlist, bitlistitem);
            break;
          }

          //On equal XI number check the next property
          if(bitlistitem->xinumber == bitlist->xinumber)
          {
            //Check if the mc number is used
            if(bitlistitem->mcnumber != -1)
            {
              if(bitlistitem->mcnumber < bitlist->mcnumber)
              {
                //Insert the item before the current one
                insertitembeforeroutelist(bitlist, bitlistitem);
                break;
              }
              //Else check if the net number is used
              else if(bitlistitem->netnumber != -1)
              {
                if(bitlistitem->netnumber < bitlist->netnumber)
                {
                  //Insert the item before the current one
                  insertitembeforeroutelist(bitlist, bitlistitem);
                  break;
                }
              }
            }            
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
  int   length;
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

      //We need the length for adding it to the list
      length = end - name;

      //First entity is an end point
      routinfoitem->endpoints[count].name   = name;
      routinfoitem->endpoints[count].length = length;

      //Point to the next entity in the array
      name = &end[1];

      //Find the end of it
      end = strstr(name, ")");

      //We need the length for adding it to the list
      length = end - name;
      
      //Second entity is a start point
      routinfoitem->startpoints[count].name   = name;
      routinfoitem->startpoints[count].length = length;
      
      //Set the length in the point pair for matching complete pairs
      length = routinfoitem->pointpairs[count].name - end;
      routinfoitem->pointpairs[count].length = length;
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

//Also need to set the pin number for the type PIB XI3.. bits, based on the PROPERTY containing IOL and use the digit for the pad number

//When listing them add a blank line as spacer below each pair

void processroutlist()
{
  char filename[255];

  int count;
  int lines;
  
  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;
  
  snprintf(filename, sizeof(filename), "%s_route_list.csv", FILENAME);

  FILE *fo = fopen(filename, "w");

  if(fo)
  {
    fprintf(fo, "Tile,,,,,Pin,,Bit\n");
    fprintf(fo, "name,type,x,y,,pin,,name,type,x,y,xoff,yoff,,expression,rpn,count,,data\n");
    
    bitlist = routelist;
    
    lines = 0;
    
    while(bitlist)
    {
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
      
      //Split the routes in pairs
      if(lines >= 2)
      {
        fprintf(fo, "\n");

        lines = 0;
      }

#if 0
      //Need the list for further processing!!!
      //Hold this one for freeing the memory
      bitlistitem = bitlist;
#endif

      //Select the next item
      bitlist = bitlist->next;

#if 0
      //Need the list for further processing!!!
      //Free this item since it is no longer needed
      free(bitlistitem);
#endif
    }
    
    fclose(fo);
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

int checkstartingpoint(pBITLISTITEM bitlistitem, int netnumber)
{
  int item;
  int pair;
  int xinumber;
  int mcnumber;
  
  pROUTEINFOITEM routeinfoitem = bitlistitem->routeitem;
  pARCVALENTITY  arcvalentity;
  
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
      //Get the filter values for the original route
      xinumber = bitlistitem->xinumber;
      mcnumber = bitlistitem->mcnumber;

      //Get the route list for the tile the original route belongs to
      tileroutelist = tileroutearray[bitlistitem->tiledata->x][bitlistitem->tiledata->y];

      //Check the other route bits in this tile
      while(tileroutelist)
      {
        //Make sure this is not the original item
        if((tileroutelist->bitlistitem->xinumber != xinumber) || (tileroutelist->bitlistitem->mcnumber != mcnumber))
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
                bitlistitem->netnumber = netnumber;
                tileroutelist->bitlistitem->netnumber = netnumber;

                //Add both items to the net list
                additemtonetlist(bitlistitem);
                additemtonetlist(tileroutelist->bitlistitem);
                
                bitlistitem->matingrouteitem = tileroutelist->bitlistitem;
                
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
  
  
  
  char filename[255];

  int count;
  int lines;
  
  char *name;
  int   length;
  
  int x;
  int y;
  
  char direction;
  char wire;
  
  char *type;
  
  int hop;
  int hops;
  int nexthop;
  
  int netnumber = 1;
  
  pBITLISTITEM bitlist;
  
  pROUTEINFOITEM routeinfoitem;
  
  pROUTEINFOITEM tileroutelist;


  
  snprintf(filename, sizeof(filename), "%s_net_list.csv", FILENAME);

  FILE *fo = fopen(filename, "w");

  //This can be moved to a later stage after building the net list first.
  //Memory freeing needs to be added too
  
  if(fo)
  {
//    fprintf(fo, "Tile,,,,,Pin,,Bit\n");
//    fprintf(fo, "name,type,x,y,,pin,,name,type,x,y,xoff,yoff,,expression,rpn,count,,data\n");
    
    bitlist = routelist;
    
    lines = 0;
    
    while(bitlist)
    {
      //Check if the current route bit is not typed already
      if(bitlist->routetype == TYPE_NONE)
      {
        //See if it is a starting point or not
        if(checkstartingpoint(bitlist, netnumber) == 1)
        {
          routeinfoitem = bitlist->routeitem;
          
          //Trace the net through the connects


          //The current bitlist item holds the information about the endpoint to match to


          //Get the current endpoint specifics
          name   = routeinfoitem->endpoints[bitlist->routestartentity].name;
          length = routeinfoitem->endpoints[bitlist->routestartentity].length;
          
          //A single route net (only two route bits set for it) runs from an output to an input without an inter or local connect
          //Check if the endpoint is a logic or io block input signal A, B, C, D, E, MI, CE, CLK_S, SR
          //Clock nets also need to be set as single route nets
          if(((length == 2) && ((name[0] == 'A') || (name[0] == 'B')  || (name[0] == 'C')  || (name[0] == 'D') || (name[0] == 'E'))) ||
             ((length == 3) &&  (name[0] == 'M') && (name[1] == 'I')) ||
             ((length == 3) &&  (name[0] == 'C') && (name[1] == 'E')) ||
             ((length == 3) &&  (name[0] == 'S') && (name[1] == 'R')) ||
             ((length == 4) &&  (name[0] == 'C') && (name[1] == 'L')  && (name[2] == 'K')) ||
             ((length == 6) &&  (name[0] == 'C') && (name[1] == 'L')  && (name[2] == 'K')  && (name[3] == '_') && (name[4] == 'S')))
          {
            //Make this a single route net
            bitlist->routetype = TYPE_NET;
            bitlist->matingrouteitem->routetype = TYPE_NET;
            
            //Done with this net so setup for next one
            netnumber++;
          }
          else
          {
            //Not a single route net so need to trace it down through the inter and local connects
            
            //LOCAL connect wires are only driven from interconnect wires, and only drive local inputs
            //Check if it is an actual start of a interconnect wire. Format is like N2BEG7
            if(strncmp(&name[2], "BEG", 3) != 0)
            {
              //This is an error condition so mark this route as such and continue
              bitlist->routetype = TYPE_ERROR;
              bitlist->matingrouteitem->routetype = TYPE_ERROR;

              //Done with this net so setup for next one
              netnumber++;
            }
            else
            {
              //Following an interconnect start point (BEG) E, W, N, S with a hop number and a wire number needs dissection of it
              //Get the direction, hop count and wire number
              //Based on the hop count and the direction, tile coordinates need to be calculated
              
              //The found tile route list needs to be searched for the matching connection
              //For a single hop look for a matching END
              //For a two or a six hop the MID connection needs to be checked too

              //Get the tile grid coordinates for the starting point
              x = bitlist->tiledata->x;
              y = bitlist->tiledata->y;
              
              //Get the parameters for this interconnect wire
              direction = name[0];
              hops = name[1] - '0';
              wire = name[5];
              
              //Determine the first hop to check
              nexthop = (hops + 1) / 2;
              
              //Handle the needed hops
              for(hop=nexthop;hop<=hops;hop+=nexthop)
              {
                //Maybe setup a xadd and yadd based on the direction
                switch(direction)
                {
                  case 'E':
                    //East is right so add to the x coordinate
                    x = bitlist->tiledata->x + nexthop;

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
                    x = bitlist->tiledata->x - nexthop;

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
                    y = bitlist->tiledata->y + nexthop;

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
                    y = bitlist->tiledata->y - nexthop;

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
                if(hops != nexthop)
                {
                  type = "MID";
                }
                else
                {
                  type = "END";
                }

                //Search the route list for a matching entity
                //Need to construct the entity to look for
                //Best use a snprintf function above and a fixed size buffer to create the search term
                
                //Follow up searches can include LOCAL items!!!!
              
              
              }
              
              
            }
            
            
            
          }
          
          
          
          

          fprintf(fo, "found net start\n");

        }
          
          
          
          
          
      }
      
      
      
#if 0      
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
      
      //Split the routes in pairs
      if(lines >= 2)
      {
        fprintf(fo, "\n");

        lines = 0;
      }
#endif      

      //Select the next item
      bitlist = bitlist->next;
    }
    
    fclose(fo);
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

void insertitembeforeiolist(pBITLISTITEM current, pBITLISTITEM new)
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
    iolist = new;
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

void addtoiolist(pTILEGRIDDATA tiledata, pCONFIGBITDATA bitdata, pTILEPADPINMAP paddata)
{
  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;

  //Get memory for the bit list item for this bit
  bitlistitem = malloc(sizeof(BITLISTITEM));

  //Set the source information
  bitlistitem->tiledata = tiledata;
  bitlistitem->bitdata  = bitdata;
  bitlistitem->paddata  = paddata;

  //Add this io bit in the io list
  if(iolist == 0)
  {
    //First item in the list, so no previous and next
    bitlistitem->prev = 0;
    bitlistitem->next = 0;

    //Set it as the first item of the list
    iolist = bitlistitem;
  }
  else
  {
    //Get the first list item
    bitlist = iolist;

    //Look for where the data needs to be inserted or replaced
    while(bitlist)
    {
      //Sort on the io pin first if set
      if(paddata)
      {
        //Sort on io pin from low to high. When current item does not have a pad insert the one with the pad before
        if((bitlist->paddata == 0) || (paddata->pin < bitlist->paddata->pin))
        {
          //Insert the item before the current one
          insertitembeforeiolist(bitlist, bitlistitem);
          break;
        }
#if 0        
        //When data for the same pin sort on the bit name
        if(paddata->pin == bitlist->paddata->pin)
        {
        }
#endif        
      }
      else
      {
        //Skip items that have an io pin
        if(bitlist->paddata == 0)
        {
          //Sort on tile coordinates otherwise
          if(tiledata->x < bitlist->tiledata->x)
          {
            //When x is smaller insert it before
            insertitembeforeiolist(bitlist, bitlistitem);
            break;
          }
          
          //For the same x coordinate check on the y coordinate
          if((tiledata->x == bitlist->tiledata->x) && (tiledata->y < bitlist->tiledata->y))
          {
            //When y is smaller insert it before
            insertitembeforeiolist(bitlist, bitlistitem);
            break;
          }
          
          //For same tile sort on the pad number and pad name
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
}

//----------------------------------------------------------------------------------------------------------------------------------

//.adc file line
//set_pin_assignment	{ i_led_control }	{ LOCATION = P28; IOSTANDARD = LVCMOS33; PULLTYPE = PULLDOWN; }
//set_pin_assignment	{ o_led_blue }	{ LOCATION = P100; IOSTANDARD = LVCMOS33; DRIVESTRENGTH = 16; PULLTYPE = PULLDOWN; }
//set_pin_assignment	{ o_led_green }	{ LOCATION = P51; IOSTANDARD = LVCMOS33; PULLTYPE = PULLDOWN; }
//set_pin_assignment	{ o_led_red }	{ LOCATION = P112; IOSTANDARD = LVCMOS33; PULLTYPE = PULLDOWN; }
//set_pin_assignment	{ serial_com_1 }	{ LOCATION = P87; IOSTANDARD = LVDS25; INDEL = 15; }

//For sorting on pin properties the name list can be extended with a sort number

//To make this file the data needs to be scanned on a found pin basis, so need to make a sorted list of io bits first
//Based on the list data it is possible to sort the actually used pins by checking if only the source and sink properties are set
//Looks like two source and one sink setting

//For the rest of the properties checking the names is needed

//Either make up net names or load a file with pin names that can be used for the nets

//For reverse engineering the fpga it is needed to look at all the io blocks used, to see if the registers have been used for storage. Not sure if the verilog compiler does this on its own
//or special instructions are needed to accomplish this

//The pin assignment also needs to be written to a verilog file. Have to see if manual work will be needed later

//For matching LVDS pairs extra information is needed in the pin map data. Will skip it since it is not used in the 1013D design
//There are no _bankref_ tiles in that list

void processiolist()
{
  char filename[255];

  int count;
  
  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;
  
  snprintf(filename, sizeof(filename), "%s_io_list.csv", FILENAME);

  FILE *fo = fopen(filename, "w");

  if(fo)
  {
    fprintf(fo, "Tile,,,,,Pin,,Bit\n");
    fprintf(fo, "name,type,x,y,,pin,,name,type,x,y,xoff,yoff,,expression,rpn,count,,data\n");
    
    bitlist = iolist;
    
    while(bitlist)
    {
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

      //Hold this one for freeing the memory
      bitlistitem = bitlist;

      //Select the next item
      bitlist = bitlist->next;

      //Free this item since it is no longer needed
      free(bitlistitem);
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

  char *xiname;
  int   xinumber = -1;
  
  
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
    //The XI number is an indication if it is routing to or from a pad
    xiname = strstr(bitdata->name, "XI");
    xinumber = atoi(&xiname[2]);

    //For XI numbers from 300 and above it could be an IO route
    if(xinumber >= 300)
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

void getmaxcolumnvalue(void)
{
  int x,y;
  int s = 0;
  
  pTILEGRIDDATA starttile = TileGridData;
    
  FILE *fp = fopen("tile_row_col_list.csv", "w");
  
  //Start with y on last and work down
  
  if(fp)
  {
    fprintf(fp, ",");
    
    for(x = 0; x < COLUMNS; x++)
    {
      fprintf(fp, "x%d", x);
      
      if(x < (COLUMNS - 1))
      {
        fprintf(fp, ",");
      } 
    }    

    fprintf(fp, "\n");
    
    for(y = ROWS - 1; y >= 0; y--)
    {
      fprintf(fp, "y%d,", y);
      
      for(x = 0; x < COLUMNS; x++)
      {
        starttile = TileGridData;
        s = 0;
        
        fprintf(fp, "\"");
        
        while(starttile = gettileforxy(x, y, starttile))
        {
          if(s)
          {
            fprintf(fp, " | ");
          }
          
          fprintf(fp, "%d %d", starttile->columns, starttile->rows);
          
          s = 1;
          
          starttile++;
        }
        
        fprintf(fp, "\"");
        
        if(x < (COLUMNS - 1))
        {
          fprintf(fp, ",");
        } 
      }
      
      fprintf(fp, "\n");
    }
    
    fclose(fp);
  }  
  
  return;
}

//----------------------------------------------------------------------------------------------------------------------------------

uint xmapstartframe[FRAMES];


void xmaptostartframe(void)
{
  //Go through the tiles and look for the individual start frames in order by a simple search
  int frame;
  int tile;
  int xoff = 4;
  
  for(frame=0;frame<FRAMES;frame++)
  {
    for(tile=0;tile<TILEGRIDCOUNT;tile++)
    {
      if(TileGridData[tile].flag == -1)
      {
        if(frame == TileGridData[tile].startframe)
        {
          xmapstartframe[frame] = xoff;
          
          xoff += 5;
          break;
        }
      }
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

#define CLKDIV_COLOR    0x00FF6A00
#define GCLK_COLOR      0x00A5FF7F
#define IOCLK_COLOR     0x007FFFFF
#define IOL_COLOR       0x007F92FF
#define IOS_COLOR       0x00FF7FED
#define MULT_COLOR      0x00FFB27F
#define OSC_COLOR       0x00DAFF7F
#define PLL_COLOR       0x007FC9FF



COLORSTRUCT emb_base_color  = { 0x00, 0x00, 0x60};
COLORSTRUCT mics_base_color = { 0x28, 0x28, 0x28};
COLORSTRUCT pib_base_color  = { 0x28, 0x00, 0x00};
COLORSTRUCT plb_base_color  = { 0x00, 0x28, 0x00};

COLORSTRUCT emb_set_color  = { 0x48, 0x48, 0xFF};
COLORSTRUCT mics_set_color = { 0xF0, 0xF0, 0xF0};
COLORSTRUCT pib_set_color  = { 0xFF, 0x48, 0x48};
COLORSTRUCT plb_set_color  = { 0x48, 0xFF, 0x48};



pCOLORSTRUCT gettypebasecolor(char *type)
{
  if(strncmp(type, "plb", 3) == 0)
  {
    return(&plb_base_color);
  }

  if(strncmp(type, "pib", 3) == 0)
  {
    return(&pib_base_color);
  }

  if(strncmp(type, "miscs_mic_io", 12) == 0)
  {
    return(&mics_base_color);
  }

  if(strncmp(type, "emb_slice", 9) == 0)
  {
    return(&emb_base_color);
  }
}

pCOLORSTRUCT gettypesetcolor(char *type)
{
  if(strncmp(type, "plb", 3) == 0)
  {
    return(&plb_set_color);
  }

  if(strncmp(type, "pib", 3) == 0)
  {
    return(&pib_set_color);
  }

  if(strncmp(type, "miscs_mic_io", 12) == 0)
  {
    return(&mics_set_color);
  }

  if(strncmp(type, "emb_slice", 9) == 0)
  {
    return(&emb_set_color);
  }
}

int bitsset = 0;

//----------------------------------------------------------------------------------------------------------------------------------

void draw_bits(uint8 *buffer, uint32 bytesperrow, uint32 xpos, uint32 ypos, pTILEGRIDDATA tile)
{
  uint w,h;
  uint x,y;
  uint f,b;
  uint bit;
  
  uint8 *dptr;
  
  pCOLORSTRUCT color;
  
  pCOLORSTRUCT base = gettypebasecolor(tile->type);
  pCOLORSTRUCT set  = gettypesetcolor(tile->type);

  y = ypos + 2;

  //The configuration data is set in this global variable
  //fpga_frames
  
  for(h=0;h<tile->columns;)
  {
    x = xpos + 2;
    
//    b = tile->startbit + h;
    //To skip the first 4 bits add 4 to the bit to read from the frame
    b = tile->startbit + h + 4;

    for(w=0;w<tile->rows;w++)
    {
      dptr = buffer + (y * bytesperrow) + (x * 3);

      f = tile->startframe + w;
      
      //Get the current bit 
      bit = (fpga_frames[f][b / 8]) << (b % 8);
      
      if(bit & 0x80)
      {
        color = set;
        bitsset++;
      }
      else
      {
        color = base;
      }
      
      *dptr++ = color->blue;
      *dptr++ = color->green;
      *dptr++ = color->red;

      if(w == 26)
      {
        x += 5;
      }
      
      x += 2;
    }

    y += 2;
    h++;

    if((h % 54) == 0)
    {
      y += 13;
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

uint32 textxpositions[COLUMNS] = { 37, 108, 180, 252, 324, 396, 468, 540, 608, 680, 752, 824, 896, 968, 1040, 1112, 1180, 1252, 1324, 1396, 1468, 1540, 1612, 1684, 1752, 1824, 1896, 1968, 2040, 2112, 2184, 2256, 2328, 2400, 2468 };

//----------------------------------------------------------------------------------------------------------------------------------

void createconfigbitmap(void)
{
  unsigned int   pixels;
  unsigned int   rows;
  unsigned int   bytesperrow;
  unsigned int   size;
  unsigned int   filesize;
  unsigned char  buffer[54];
  unsigned char *bitmap;
  
  int x,y;
  int xpos, ypos, width, height;
  
  int length;
  
  char filename[255];
  
  char text[32];
  
  pTILEGRIDDATA starttile = TileGridData;
  
  pixels = (COLUMNS * ((BITSPERCOLUMN * 2) + 10)) - 14;
  
  rows = (ROWS * ((BITSPERROW * 2) + 13)) + 6;
  
  //Number of bytes on a row for a 24 bits per pixel bitmap
  bytesperrow = pixels * 3;

  //Adjust for 32 bit segments
  bytesperrow = (bytesperrow + 3) & 0x0FFFFFFC;

  //Calculate the size of the bitmap in bytes
  size = bytesperrow * rows;
  
  bitmap = malloc(size);
  
  if(bitmap)
  {
    memset(bitmap, 0, size);
    
    xmaptostartframe();

    draw_rect(bitmap, bytesperrow, 0, 0, pixels, rows, 0x00FFFFFF);
    draw_rect(bitmap, bytesperrow, 1, 1, pixels - 2, rows - 2, 0x00FFFFFF);

    for(y=0;y<ROWS;y++)
    {
      for(x=0;x<COLUMNS;x++)
      {
        starttile = TileGridData;
        
        //Make the label for this tile
        length = snprintf(text, sizeof(text), "X%d Y%d", x, y);

        //Calculate the position of the tile text
        ypos = rows - ((y + 1) * ((BITSPERROW * 2) + 13)) - 2;
        xpos = textxpositions[x] - ((length * 6) / 2);
        
        //Need to print x,y information above every tile to make research easier
        draw_text(bitmap, bytesperrow, xpos, ypos, 0x00FFFFFF, text);

        //Draw all the blocks that have bits for this tile position
        while(starttile = gettileforxy(x, y, starttile))
        {
          xpos = (starttile->startframe * 2) + xmapstartframe[starttile->startframe];
          ypos = (starttile->startbit * 2) + (((ROWS - 1) - starttile->y) * 13) + 12;
          
          width  = (starttile->rows * 2) + 3;
          height = (starttile->columns * 2) + 3;

          //Compensation for the plb to match the iob/pib size
          if(starttile->rows == 31)
          {
            width += 5;
          }
          //Compensation for the emb to match multiple plb sizes
          else if(starttile->columns == 486)
          {
            ypos -= 104;
            height += 104;
          }
          //Compensation for the misc_io to multiple plb sizes
          else if(starttile->columns == 162)
          {
            height += 26;
          }
        
          draw_rect(bitmap, bytesperrow, xpos, ypos, width, height, 0x00FFFFFF);

          draw_bits(bitmap, bytesperrow, xpos, ypos, starttile);
          
          starttile++;
        }
      }
    }
    
    
    //Print the bitmap output file name
    snprintf(filename, sizeof(filename), "%s.bmp", FILENAME);
  
    FILE *fo = fopen(filename, "wb");
  
    if(fo)
    {
      //Bitmap magic number
      buffer[0] = 'B';
      buffer[1] = 'M';
      
      filesize = size + 54;
      
      //File size
      buffer[2] = filesize & 0xFF;
      buffer[3] = (filesize >>  8) & 0xFF;
      buffer[4] = (filesize >> 16) & 0xFF;
      buffer[5] = (filesize >> 24) & 0xFF;

      //reserved
      buffer[6] = 0;
      buffer[7] = 0;
      buffer[8] = 0;
      buffer[9] = 0;
      
      //Bitmap offset
      buffer[10] = 54;
      buffer[11] = 0;
      buffer[12] = 0;
      buffer[13] = 0;

      //Header size
      buffer[14] = 40;
      buffer[15] = 0;
      buffer[16] = 0;
      buffer[17] = 0;

      //Bitmap width
      buffer[18] = pixels & 0xFF;
      buffer[19] = (pixels >>  8) & 0xFF;
      buffer[20] = (pixels >> 16) & 0xFF;
      buffer[21] = (pixels >> 24) & 0xFF;
      
      //Bitmap height
      rows = rows * -1;
      buffer[22] = rows & 0xFF;
      buffer[23] = (rows >>  8) & 0xFF;
      buffer[24] = (rows >> 16) & 0xFF;
      buffer[25] = (rows >> 24) & 0xFF;

      //Number of planes      
      buffer[26] = 1;
      buffer[27] = 0;
      
      //Bits per pixel
      buffer[28] = 24;
      buffer[29] = 0;

      //Bitmap compression
      buffer[30] = 0;
      buffer[31] = 0;
      buffer[32] = 0;
      buffer[33] = 0;
      
      //Image size
      buffer[34] = 0;
      buffer[35] = 0;
      buffer[36] = 0;
      buffer[37] = 0;
      
      //Horiz res
      buffer[38] = 0;
      buffer[39] = 0;
      buffer[40] = 0;
      buffer[41] = 0;

      //Vert res
      buffer[42] = 0;
      buffer[43] = 0;
      buffer[44] = 0;
      buffer[45] = 0;

      //Nof colors
      buffer[46] = 0;
      buffer[47] = 0;
      buffer[48] = 0;
      buffer[49] = 0;
      
      //Colors important
      buffer[50] = 0;
      buffer[51] = 0;
      buffer[52] = 0;
      buffer[53] = 0;
      
      fwrite(buffer, 1, 54, fo);

      fwrite(bitmap, 1, size, fo);

      fclose(fo);
    }
    
    free(bitmap);
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
  
  int count;
  
  pTILEGRIDDATA tilegriddata;
  
  pCONFIGBITDATA bitdata;
  
  pFRAMEBITMAPPING framebitdata;

  pTILEPADPINMAP tilepadinmap;
  
  pBITLISTITEM bitlistitem;

  uchar *sptr = bitstreamdata;
  
  //getmaxcolumnvalue();
  
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
    
    //Make a bitmap showing the active bits in the tile grid
    createconfigbitmap();
    
    //Print the output file name
    snprintf(filename, sizeof(filename), "%s.csv", FILENAME);
    
    FILE *fo = fopen(filename, "w");
    
    if(fo)
    {
      fprintf(fo, "Frame,,,Tile,,,,,Pin,,Bit\n");
      fprintf(fo, "frame,bit,,name,type,x,y,,pin,,name,type,expression,count,,data\n");
      
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

            fprintf(fo, "%d,%d,,", i, j);

            //Check if a tile has not been found via frame-bit mapping
            if(tilegriddata == 0)
            {
              //Try to get the tile it belongs to via tile mapping
              tilegriddata = gettileforbit(i, j);
            }
            
            //For io routing bits the listed tile is the originating tile for the pad and not perse the tile the routing bits belong to
            //To accommodate for this the bit data needs to be checked first on having x or y offset info
            
            
            if(tilegriddata)
            {
              fprintf(fo, "%s,%s,%d,%d,,", tilegriddata->name, tilegriddata->type, tilegriddata->x, tilegriddata->y);
            }
            
            if(bitdata)
            {
              tilepadinmap = getpinmapfortile(tilegriddata->x, tilegriddata->y, bitdata);
              
              if(tilepadinmap)
              {
                fprintf(fo, "P%d,,", tilepadinmap->pin);
              }
              else
              {
                fprintf(fo, ",,");
              }
              
              //Check if the bit is an io type
              //The tile itself being of type iol_ also yields routing bits for the pins in use
              //This can be used for the netlist
              //This way ios_bankref_ data is filtered too. Bits are set based on io configuration and especially for LVDS, which is also found in the pad data itself
              if((strncmp(tilegriddata->type, "iol_", 4) == 0) && (strncmp(bitdata->type, "MISCS_MIC_IO_", 13) == 0))
              {
                //Add it to the io list
                addtoiolist(tilegriddata, bitdata, tilepadinmap);
              }
              
              //Make a route list, sorted on matching pairs
              //Only bits with TOP. in the name indicate routing
              if(strncmp(bitdata->name, "TOP.", 4) == 0)
              {
                //For each topology bit a new entry is created
                bitlistitem = addtoroutelist(tilegriddata, bitdata, tilepadinmap);
                
                //Setup a tile route array for tracking them back into a net list
                //Each topology item is dissected into separate entities for easier route matching
                addtotileroutearray(bitlistitem);
              }
              
              
              fprintf(fo, "%s,%s,\"", bitdata->name, bitdata->type);
              
              //Walk through all the expression items
              for(count=0;count<bitdata->exprcount;count++)
              {
                fprintf(fo, "%s", bitdata->expr[count]);
              }
              
              fprintf(fo, "\",%d,,", bitdata->datacount);
              
              //Walk through all the data items
              for(count=0;count<bitdata->datacount;count++)
              {
                //Output them to the file
                fprintf(fo, "\"%s\"", bitdata->bitdata[count].data);

                //Check if not the last item
                if(count < (bitdata->datacount - 1))
                {
                  //Add a separator if so
                  fprintf(fo, ",");
                }
              }
            }
            
            fprintf(fo, "\n");
          }
        }
      }
      
      fclose(fo);
      
      //Process the io list
      processiolist();
      
      //Process the route list
      processroutlist();
      
      //Trace the routes back to a net list
      traceroutelist();
    }
  }

}

//----------------------------------------------------------------------------------------------------------------------------------
