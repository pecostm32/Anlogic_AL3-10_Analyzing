//----------------------------------------------------------------------------------------------------------------------------------

//This is experimental software to try to reverse engineer a specific Anlogic FPGA design
//and is not written with security, reliability and optimization in mind.
//There are no checks on if memory is actually allocated!!!
//Also setup bits for slice configuration that are not used in the design are not coded to be recognized.

//For the global clock signals the FNIRSI design uses the same clocks on all the global clock lines enabled in both sides of the FPGA
//so no special attention is payed to how the routing of the hidden global clocks is done
//With manual inspection of the design the signals are mapped by using a table

//This is to name the signals in the gate level verilog this code generates

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

#define PAD_NONE                  0
#define PAD_INPUT                 1
#define PAD_OUTPUT                2
#define PAD_TS                    4
#define PAD_BIDIRECTIONAL         7

//----------------------------------------------------------------------------------------------------------------------------------

#define LOGIC_NONE         0x00000000
#define LOGIC_LUT0         0x00000001          //LUT0 is used in mslice
#define LOGIC_LUTF0        0x00000001          //LUTF0 is used in lslice
#define LOGIC_LUTG0        0x00000002
#define LOGIC_FF0_F        0x00000004
#define LOGIC_FF0_FX       0x00000008
#define LOGIC_FF0_SR       0x00000010
#define LOGIC_F0MUXLUT5    0x00000020
#define LOGIC_FX0MUXLUT4G  0x00000040
#define LOGIC_FX0MUXRIP_N  0x00000080
#define LOGIC_CMIMUX0      0x00000100
#define LOGIC_DEMUX0       0x00000200
#define LOGIC_RIPMODE0     0x00000400
#define LOGIC_LUT1         0x00000800          //LUT1 is used in mslice
#define LOGIC_LUTF1        0x00000800          //LUTF1 is used in lslice
#define LOGIC_LUTG1        0x00001000
#define LOGIC_FF1_F        0x00002000
#define LOGIC_FF1_FX       0x00004000
#define LOGIC_FF1_SR       0x00008000
#define LOGIC_F1MUXLUT5    0x00010000
#define LOGIC_FX1MUXLUT4G  0x00020000
#define LOGIC_FX1MUXRIP_N  0x00040000
#define LOGIC_CMIMUX1      0x00080000
#define LOGIC_DEMUX1       0x00100000
#define LOGIC_RIPMODE1     0x00200000
#define LOGIC_FF_LATCH     0x00400000
#define LOGIC_FF_SYNC      0x00800000
#define LOGIC_FF_CLK       0x01000000
#define LOGIC_FF_GSR       0x02000000
#define LOGIC_FF_CE        0x04000000
#define LOGIC_FF_SR        0x08000000
#define LOGIC_FXMUXON      0x10000000
#define LOGIC_TESTSH       0x20000000

//----------------------------------------------------------------------------------------------------------------------------------

#define PIN_NONE      0x00000000

#define PIN_A0        0x00000001
#define PIN_B0        0x00000002
#define PIN_C0        0x00000004
#define PIN_D0        0x00000008
#define PIN_E0        0x00000010
#define PIN_MI0       0x00000020
#define PIN_F0        0x00000040
#define PIN_FX0       0x00000080
#define PIN_Q0        0x00000100

#define PIN_A1        0x00001000
#define PIN_B1        0x00002000
#define PIN_C1        0x00004000
#define PIN_D1        0x00008000
#define PIN_E1        0x00010000
#define PIN_MI1       0x00020000
#define PIN_F1        0x00040000
#define PIN_FX1       0x00080000
#define PIN_Q1        0x00100000

#define PIN_CLK       0x10000000
#define PIN_CE        0x20000000
#define PIN_SR        0x40000000


#define LUT_INPUT_PINS    0x0000001F

//----------------------------------------------------------------------------------------------------------------------------------

#include "database/database.h"

#include "frames/frame_bit_mapping.h"

#include "database/lqfp144_io_pads.h"

#include "database/al3_10_tile_signal_map.h"

#include "block_schematic_definitions.h"

//----------------------------------------------------------------------------------------------------------------------------------

#define OUTPUT_SCHEMATICS   0
#define OUTPUT_VERILOG      1

#define DESIGN 1

//----------------------------------------------------------------------------------------------------------------------------------

#if DESIGN == 1
#include "pin_assignments/1013D_pin_assignment.h"

#define MODULENAME   "FNIRSI_1013D"

#define FILENAME     "fpgas/Original_1013D/Original_1013D_fpga"
#define BLOCKFOLDER  "fpgas/Original_1013D/1013D_blocks"
#elif DESIGN == 2
#include "pin_assignments/1014D_pin_assignment.h"

#define MODULENAME   "FNIRSI_1014D"

#define FILENAME     "fpgas/Original_1014D/Original_1014D_fpga"
#define BLOCKFOLDER  "fpgas/Original_1014D/1014D_blocks"
#elif DESIGN == 3
#include "pin_assignments/pin_test_pin_assignment.h"

#define MODULENAME   "pin_test"

#define FILENAME     "/home/peter/Data/Anlogic_projects/pin_test/pin_test"
#define BLOCKFOLDER  "/home/peter/Data/Anlogic_projects/pin_test/blocks"
#elif DESIGN == 4
#include "pin_assignments/1013D_pin_assignment.h"

#define MODULENAME   "FNIRSI_1013D"

#define FILENAME   "/home/peter/Data/Anlogic_projects/Scope15/Scope15"
#define BLOCKFOLDER  "/home/peter/Data/Anlogic_projects/Scope15/blocks"
#elif DESIGN == 5
#include "pin_assignments/1013D_pin_assignment.h"

#define MODULENAME   "FNIRSI_1013D"

#define FILENAME   "fpgas/FNIRSI_1013D/FNIRSI_1013D"
#define BLOCKFOLDER  "fpgas/FNIRSI_1013D/blocks"
#endif

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

typedef struct tagPINTYPE          PINTYPE,          *pPINTYPE;


typedef struct tagNAMEITEM         NAMEITEM,         *pNAMEITEM;
typedef struct tagROUTEINFOITEM    ROUTEINFOITEM,    *pROUTEINFOITEM;

typedef struct tagNETLISTITEM      NETLISTITEM,      *pNETLISTITEM,      **ppNETLISTITEM;

typedef struct tagTREELISTITEM     TREELISTITEM,     *pTREELISTITEM,     **ppTREELISTITEM;

typedef struct tagBLOCKCONNECTION  BLOCKCONNECTION,  *pBLOCKCONNECTION;

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

struct tagPINTYPE
{
  char *name;
  int   indexbit;
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
  
  pBLOCKINFOITEM block;
};

#define MAX_BLOCK_CONNECTIONS   100
#define MAX_NAME_LENGTH          64

struct tagBLOCKCONNECTION
{
  char *signalname;
  char *netname;
};

struct tagBLOCKINFOITEM
{
  pBLOCKINFOITEM  prev;
  pBLOCKINFOITEM  next;
  
  pBITLISTITEM    firstsettingsbit;
  
  int             x;
  int             y;

  int             blocknumber;
  int             blocktype;
  
  int             bitcount;         //Number of setup bits in this block
  
  int             connected;        //Flag to signal if there are net connections to this block
  
  int             logicsettings;    //Bit array to reflect the settings bits set for this block
  
  int             lut0;             //Lookup pattern for mslice lut0
  int             lutf0;            //Lookup pattern for lslice lutf0
  int             lutg0;            //Lookup pattern for lslice lutg0
  
  int             lut1;             //Lookup pattern for mslice lut1
  int             lutf1;            //Lookup pattern for lslice lutf1
  int             lutg1;            //Lookup pattern for lslice lutg1
  
  int             sliceid;
  int             padid;
  int             pinnumber;
  int             embid;
  int             pllid;
  
  char           *tiletype;
  
  int             connectioncount;  //Number of connections set in the connections array
  
  BLOCKCONNECTION connections[MAX_BLOCK_CONNECTIONS];
  
  char            padname[MAX_NAME_LENGTH];
  char            lut0output[MAX_NAME_LENGTH];
  char            lut1output[MAX_NAME_LENGTH];
  
  int             padtype;
};

#define MAX_NET_NAME_LENGTH   32

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

  pBLOCKINFOITEM block;
  
  int            lutid;
  int            sliceid;
  int            padid;
  int            pinnumber;
  int            embid;
  int            pllid;
  
  int            routetype;         //Route type for this bit that signals for instance a start or end point 
  int            routestartentity;  //The ARCVAL entity that is used in the match with the mating bit
  int            routeconnected;    //A flag to signal a connection to the next node has been made
  
  char           netname[MAX_NET_NAME_LENGTH];
  
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

struct tagTREELISTITEM
{
  pTREELISTITEM  next;
  
  pTREELISTITEM  child;

  pROUTEINFOITEM fromsignal;
  pROUTEINFOITEM tosignal;
};

//----------------------------------------------------------------------------------------------------------------------------------

uchar fpga_frames[FRAMES][BITS_PER_FRAME / 8];

uchar bitstreamdata[2097152];

uchar fpga_tiles[COLUMNS][ROWS];

//----------------------------------------------------------------------------------------------------------------------------------

PINTYPE slicepins[] =
{
  { "a_0",  PIN_A0   },
  { "a_1",  PIN_A1   },
  { "b_0",  PIN_B0   },
  { "b_1",  PIN_B1   },
  { "c_0",  PIN_C0   },
  { "c_1",  PIN_C1   },
  { "ce",   PIN_CE   },
  { "clk",  PIN_CLK  },
  { "d_0",  PIN_D0   },
  { "d_1",  PIN_D1   },
  { "e_0",  PIN_E0   },
  { "e_1",  PIN_E1   },
  { "f_0",  PIN_F0   },
  { "f_1",  PIN_F1   },
  { "fx_0", PIN_FX0  },
  { "fx_1", PIN_FX1  },
  { "mi_0", PIN_MI0  },
  { "mi_1", PIN_MI1  },
  { "q_0",  PIN_Q0   },
  { "q_1",  PIN_Q1   },
  { "sr",   PIN_SR   },
  { 0,      PIN_NONE }
};

//----------------------------------------------------------------------------------------------------------------------------------

char *lslicesettingnames[] =
{
  "LUTF0",
  "LUTG0",
  "FF0_F",
  "FF0_FX",
  "FF0_SR",
  "F0MUXLUT5",
  "FX0MUXLUT4G",
  "FX0MUXRIP_N",
  "CMIMUX0",
  "DEMUX0",
  "RIPMODE0",
  "LUTF1",
  "LUTG1",
  "FF1_F",
  "FF1_FX",
  "FF1_SR",
  "F1MUXLUT5",
  "FX1MUXLUT4G",
  "FX1MUXRIP_N",
  "CMIMUX1",
  "DEMUX1",
  "RIPMODE1",
  "FF_LATCH",
  "FF_SYNC",
  "FF_CLK",
  "FF_GSR",
  "FF_CE",
  "FF_SR",
  "",
  "TESTSH"
};

char *mslicesettingnames[] =
{
  "LUT0",
  "",
  "FF0_F",
  "FF0_FX",
  "FF0_SR",
  "",
  "",
  "",
  "",
  "",
  "RIPMODE0",
  "LUT1",
  "",
  "FF1_F",
  "FF1_FX",
  "FF1_SR",
  "",
  "",
  "",
  "",
  "",
  "RIPMODE1",
  "FF_LATCH",
  "FF_SYNC",
  "FF_CLK",
  "FF_GSR",
  "FF_CE",
  "FF_SR",
  "FXMUXON",
  "TESTSH"
};

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
pBLOCKINFOITEM  blocklistend = 0;

//A sorted list of setup bits
pBITLISTITEM    blocksetuplist = 0;

//A sorted route list is made in this list
pNETLISTITEM  routelist = 0;

//A sorted and filtered net list is made in this list
pNETLISTITEM  netlist = 0;
ppNETLISTITEM netlistlast  = 0;

//A tree of how the blocks are connected to each other
pTREELISTITEM inputtreelist = 0;

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

extern unsigned char CharacterMap[256][8];

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

void draw_block(uint8 *buffer, uint32 bytesperrow, uint32 xpos, uint32 ypos, uint32 blockcolor, uint32 netcolor, pSCHEMATICBLOCK baseblock, pBLOCKINFOITEM designblock)
{
  int portidx = 0;
  int xs,ys,xe,ye;
  int len;
  int count;
  int idx;
  
  int nameidx;
  
  char name[128];
  
  pSCHEMATICPORT port;
    
  draw_rect(buffer, bytesperrow, xpos, ypos, baseblock->width, baseblock->height, blockcolor);

  len = (strlen(baseblock->name) * 6) / 2;
  
  xs = xpos + (baseblock->width / 2) - len;
  ys = ypos - 10;
  
  draw_text(buffer, bytesperrow, xs, ys, blockcolor, baseblock->name);
  
  //Need to map the type of block to a schematic block here
  switch(designblock->blocktype)
  {
    case BLOCK_PAD:
      if(designblock->pinnumber != -1)
      {
#ifdef PIN_ASSIGNMENTS
        //try to find a hdl name assigned to the pin
        pPINASSIGNMENTS pinlist = pin_assignments;

        while(pinlist->hdl_name)
        {
          if(designblock->pinnumber == pinlist->pinnumber)
          {
            len = (strlen(pinlist->hdl_name) * 6) / 2;

            xs = xpos + (baseblock->width / 2) - len;
            ys = ypos + baseblock->height + 25;

            draw_text(buffer, bytesperrow, xs, ys, blockcolor,  pinlist->hdl_name);
            break;
          }

          pinlist++;
        }
#endif
        
        //Print the block name
        snprintf(name, sizeof(name), "pin_%d_tile_x%dy%d_block_%d", designblock->pinnumber, designblock->x, designblock->y, designblock->blocknumber);
      }
      else
      {
        //Print the block name
        snprintf(name, sizeof(name), "pad_%d_tile_x%dy%d_block_%d", designblock->padid, designblock->x, designblock->y, designblock->blocknumber);
      }
      break;

    case BLOCK_MSLICE:
      //Print the block name
      snprintf(name, sizeof(name), "mslice_%d_tile_x%dy%d_block_%d", designblock->sliceid, designblock->x, designblock->y, designblock->blocknumber);
      break;

    case BLOCK_LSLICE:
      //Print the block name
      snprintf(name, sizeof(name), "lslice_%d_tile_x%dy%d_block_%d", designblock->sliceid, designblock->x, designblock->y, designblock->blocknumber);
      break;

    case BLOCK_EMB:
      //Print the block name
      snprintf(name, sizeof(name), "emb_%d_tile_x%dy%d_block_%d", designblock->embid, designblock->x, designblock->y, designblock->blocknumber);
      break;

    case BLOCK_PLL:
      //Print the block name
      snprintf(name, sizeof(name), "pll%d_tile_x%dy%d_block_%d", designblock->pllid, designblock->x, designblock->y, designblock->blocknumber);
      break;

    case BLOCK_GCLK_PREMUX:
      //Print the block name
      snprintf(name, sizeof(name), "gclk_premux_tile_x%dy%d_block_%d", designblock->x, designblock->y, designblock->blocknumber);
      break;

    case BLOCK_GCLK_CTMUX:
      //Print the block name
      snprintf(name, sizeof(name), "gclk_ctmux_tile_x%dy%d_block_%d", designblock->x, designblock->y, designblock->blocknumber);
      break;
  }
  
  len = (strlen(name) * 6) / 2;
  
  xs = xpos + (baseblock->width / 2) - len;
  ys = ypos + baseblock->height + 10;
  
  draw_text(buffer, bytesperrow, xs, ys, blockcolor, name);
  
  //Process the ports on this block
  port = &baseblock->ports[portidx];
  
  while(port->displayname)
  {
    if((port->direction == 0) || (port->direction == 2))
    {
      ys = ypos + port->step;
    }
    else
    {
      ys += port->step - 10;
    }
    
    count = port->repeat;
    
    nameidx = 0;
    
    do
    {
      switch(port->direction)
      {
        case 0:
        case 1:
          xs = xpos - port->length;
          xe = xpos;
          break;

        case 2:
        case 3:
          xs = xpos + baseblock->width;
          xe = xs + port->length;
          break;
      }
    
      draw_horz_line(buffer, bytesperrow, ys, xs, xe, blockcolor);

      if(port->repeat)
      {
        snprintf(name, sizeof(name), "%s_%d", port->displayname, nameidx++);
      }
      else
      {
        snprintf(name, sizeof(name), "%s", port->displayname);
      }

      switch(port->direction)
      {
        case 0:
        case 1:
          xs = xpos + 5;
          ye = ys - 3;
          break;

        case 2:
        case 3:
          len = (strlen(name) * 6) + 5;
          xs = xpos + baseblock->width - len;
          ye = ys - 3;
          break;
      }
      
      draw_text(buffer, bytesperrow, xs, ye, blockcolor, name);
      
      //Find the matching connection for this signal
      //Need a counter and then go through the list and do string compare against name
      
      //if found print it based on the direction before or after the pin
      //Use the net color for this text
      
      
      for(idx=0;idx<designblock->connectioncount;idx++)
      {
        if(strcmp(name, designblock->connections[idx].signalname) == 0)
        {
          
          switch(port->direction)
          {
            case 0:
            case 1:
              len = (strlen(designblock->connections[idx].netname) * 6) + 5;
              xs = xpos - port->length - len;
              break;

            case 2:
            case 3:
              xs = xpos + baseblock->width + port->length + 5;
              break;
          }
          
          draw_text(buffer, bytesperrow, xs, ye, netcolor, designblock->connections[idx].netname);
          
          break;
        }
      }
      
      
      //Fixed basic step between wires
      ys += 10;
      
    } while(--count > 0);
    
    portidx++;
    
    port = &baseblock->ports[portidx];
  }  
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
    blocklistend = item;
  }
  else
  {
    //Set the forward link
    blocklistend->next = item;
    
    //Set the backward link
    item->prev = blocklistend;
    
    //Set the new end
    blocklistend = item;
  }
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
  
  char *netname;
  
  char **typemap;

  //No pin number found yet
  routeitem->pinnumber = -1;  
  
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
        
        routeitem->pinnumber = routeitem->paddata->pin;
        
        break;
      }
    }
  }  

  //When there is a signal match try to match it to a block
  if(found == 1)
  {
    pBLOCKINFOITEM searchlist = blocklist;
    //Search the block list for a matching block this signal connects to
    
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
        routeitem->block = searchlist;
        
        //Signal that the block has connections
        searchlist->connected = 1;
        
        //Setup the names
        searchlist->connections[searchlist->connectioncount].signalname = routeitem->signalname->hdl_name;
        searchlist->connections[searchlist->connectioncount].netname = routeitem->netname;
        
        //Signal an extra connection to this block
        searchlist->connectioncount++;
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
  int gclkid;
  
  char *netname;
  
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
        
        snprintf(routeitem->netname, MAX_NET_NAME_LENGTH, "ground");
      }
      else if(((length == 5) || (length == 6)) && (strncmp(name, "GCLK", 4) == 0))
      {
        //For a global clock mark it as a global clock signal
        routeitem->netsignal = SIGNAL_GCLK;
        
        gclkid = atoi(&name[4]);
        
        snprintf(routeitem->netname, MAX_NET_NAME_LENGTH, "gclk_%d", gclkid);
      }
      else
      {
        //Not a ground or a global clock means it is an output signal
        routeitem->netsignal = SIGNAL_OUTPUT;

        //Translate the signal name to a hdl name and see if it has a connection with a pin
        mapsignalname(routeitem);
        
        //When the signal is mapped use the prefix and hdl name for the net
        if(routeitem->signalprefix && routeitem->signalname)
        {
          if(routeitem->pinnumber != -1)
          {
            snprintf(routeitem->netname, MAX_NET_NAME_LENGTH, "x%dy%d_pin_%d_%s_net_%d", routeitem->tiledata->x, routeitem->tiledata->y, routeitem->pinnumber, routeitem->signalname->hdl_name, routeitem->netnumber);
          }
          else
          {
            snprintf(routeitem->netname, MAX_NET_NAME_LENGTH, "x%dy%d_%s_%s_net_%d", routeitem->tiledata->x, routeitem->tiledata->y, routeitem->signalprefix->signalprefix, routeitem->signalname->hdl_name, routeitem->netnumber);
          }
        }
        else
        {        
          snprintf(routeitem->netname, MAX_NET_NAME_LENGTH, "x%dy%d_%s_net_%d", routeitem->tiledata->x, routeitem->tiledata->y, routeitem->tiledata->type, routeitem->netnumber);
        }
      }
      
      //Add it to the net list
      additemtofinalnetlist(routeitem);
      
      netname = routeitem->netname;
      
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
        
        strncpy(routeitem->netname, netname, MAX_NET_NAME_LENGTH);
        
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

void additemtotreelist(ppTREELISTITEM list, pROUTEINFOITEM fromsignal, pROUTEINFOITEM tosignal)
{
  pTREELISTITEM item = malloc(sizeof(TREELISTITEM));
  
  item->next = 0;
  item->child = 0;
  item->fromsignal = fromsignal;
  item->tosignal = tosignal;
  
  //Add this new one to the given list point
  *list = item;
}

//----------------------------------------------------------------------------------------------------------------------------------

void createtreelist()
{
  //Need to walk through the net list and when a pad is found as first entry of a net trace down the connections
  int netnumber = 0;
  
  int addtochildlist = 0;
  
  pNETLISTITEM searchlist = netlist;
 
  pROUTEINFOITEM fromsignal;
  pROUTEINFOITEM tosignal;
  
  pTREELISTITEM treelist;
  
  ppTREELISTITEM mainaddlist = &inputtreelist;
  
  ppTREELISTITEM childaddlist;
  
  while(searchlist)
  {
    tosignal = searchlist->routebit;
    
    //Detect the start of the next net
    if(netnumber != tosignal->netnumber)
    {
      //The first entry of a net is always an output, so when the type is pad it means a signal coming into the FPGA
      //And there fore a good starting point for getting an insight in the logic
      if(tosignal->blocktype == BLOCK_PAD)
      {
        //Create and add a new item to the list
        //Then all the items within this net should be hooked onto a child list
        additemtotreelist(mainaddlist, 0, tosignal);
        
        //Set this signal as the originator for the child items
        fromsignal = tosignal;
        
        //Get the current list point        
        treelist = *mainaddlist;
        
        //Setup the child list for it
        childaddlist = &treelist->child;
        
        //Have the main list continue at the next point
        mainaddlist = &treelist->next;
        
        //Signal the rest of the signals of this net need to be added to the child list
        addtochildlist = 1;
      }
      else
      {
        //Not a pad so no tracing this net
        addtochildlist = 0;
      }
    }
    
    if(addtochildlist)
    {
      //Add this item to the child list and trace it down through the blocks
      additemtotreelist(childaddlist, fromsignal, tosignal);
      
      //Get the current list point        
      treelist = *childaddlist;

      //Have the child list continue at the next point
      childaddlist = &treelist->next;
      
      
      //The next block needs to be found based on the current block input found here and the start point of a net matching the block number
      //Only when the signal matches with the current input signal it should add the next signals to the child list of the current one
      
      //A problem here is the fact that embedded block memory has a displacement in the signals when 2 bit mode is used
      //A2 in seems to go to B0 output and A5 in to B2
      //For slices the lut id needs to be used in tracing
      
      
      //Probably need both input and output route items added to the current item, to have this connection data
      //&treelist->child;
      
      
      
    }
    
    searchlist = searchlist->next;
  }
  
  
  
  
}

//----------------------------------------------------------------------------------------------------------------------------------

void insertitembeforesetuplist(pBLOCKINFOITEM block, pBITLISTITEM current, pBITLISTITEM new)
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
  
  //To get the first item of the settings list for this block the previous bit needs to have a different block number
  //When there is no previous bit it is the first for this block
  if((new->prev == 0) || (new->prev && (new->prev->blocknumber < block->blocknumber)))
  {
    //Set this bit as the first for this block
    block->firstsettingsbit = new;
  }       
}

//----------------------------------------------------------------------------------------------------------------------------------

void additemtosetuplist(pBLOCKINFOITEM block, pBITLISTITEM item)
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
        insertitembeforesetuplist(block, addlist, item);
        break;
      }
      
      if(item->blocknumber == addlist->blocknumber)
      {
        //Need sorting on bit name here
        if(strcmp(item->bitdata->name, addlist->bitdata->name) < 0)
        {
          //Insert the item before the current one
          insertitembeforesetuplist(block, addlist, item);
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

        //Check if not already a first bit set, because setting it again would move the pointer to a later in the list bit
        if(block->firstsettingsbit == 0)
        {
          //Set the first bit found for this block as the first one
          block->firstsettingsbit = item;
        }
        
        //Done so quit
        break;
      }
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------
//Converts the number at the indicated location and performs the given modulo on it
//Some settings use multiple bits for a setting within a block where the numbering can extend beyond the modulo
//For example in an IO block there are 4 pads and per pad it can have 5 setting bits for a single setting, where the first 5 bits
//are for pad0, and the next 5 for pad1, etc. By using the modulo the setting bits are ranged 0-4 for all the pads

int getsetupbitidx(char *bit, int skip, int modulo)
{
  char *dptr = bit + skip;
  
  int idx = atoi(dptr) % modulo;
  
  return(idx);
}

//----------------------------------------------------------------------------------------------------------------------------------
//This function detects the type of a block the given setting bit belongs to
//It also processes the bit to mark its meaning in the logic settings for this block

void findblocktype(pBITLISTITEM item, pBLOCKINFOITEM block)
{
  int blocktype = BLOCK_OTHER;
  
  int length;
  
  char *dptr;
  //The block type depends on several things. For instance the tile type for slices is plb in which mslices and lslices sit
  //These depend on the numbers in the bit name
  
  //An emb block can be a fifo which can only be determined by checking more then one bit
  
  //Not sure if the tile type pib is used here because io is situated in dedicated tile types
  
  //No connections made to the block just yet
  block->connected = 0;
  block->connectioncount = 0;
  
  block->sliceid   = -1;
  block->padid     = -1;
  block->pinnumber = -1;
  block->embid     = -1;
  block->pllid     = -1;
  
  if(strncmp(item->tiledata->type, "plb", 3) == 0)
  {
    //Get the lookup table setting for the two luts in the mslice
    if(strncmp(item->bitdata->name, "LUT0_S", 6) == 0)
    {
      //A set bit determines a 1 in the table
      block->lut0 = (1 << getsetupbitidx(item->bitdata->name, 8, 16));
      
      //Signal LUT0 has settings
      block->logicsettings = LOGIC_LUT0;
    }
    else if(strncmp(item->bitdata->name, "LUT1_S", 6) == 0)
    {
      block->lut1 = (1 << getsetupbitidx(item->bitdata->name, 8, 16));
      
      //Signal LUT 1 has settings
      block->logicsettings = LOGIC_LUT1;
    }
    //Get the lookup table setting for the four luts in the lslice
    else if(strncmp(item->bitdata->name, "LUTF0_S", 7) == 0)
    {
      //A set bit determines a 1 in the table
      block->lutf0 = (1 << getsetupbitidx(item->bitdata->name, 9, 16));
      
      //Might need dedicated indicators for F and G lut
      //Signal LUT0 has settings
      block->logicsettings = LOGIC_LUTF0;
    }
    else if(strncmp(item->bitdata->name, "LUTG0_S", 7) == 0)
    {
      block->lutg0 = (1 << getsetupbitidx(item->bitdata->name, 9, 16));
      
      //Signal LUT0 has settings
      block->logicsettings = LOGIC_LUTG0;
    }
    else if(strncmp(item->bitdata->name, "LUTF1_S", 7) == 0)
    {
      block->lutf1 = (1 << getsetupbitidx(item->bitdata->name, 9, 16));
      
      //Signal LUT0 has settings
      block->logicsettings = LOGIC_LUTF1;
    }
    else if(strncmp(item->bitdata->name, "LUTG1_S", 7) == 0)
    {
      block->lutg1 = (1 << getsetupbitidx(item->bitdata->name, 9, 16));
      
      //Signal LUT0 has settings
      block->logicsettings = LOGIC_LUTG1;
    }
    //Check if the F0 output is routed to FF0
    else if(strncmp(item->bitdata->name, "MC1_DI0_S", 9) == 0)
    {
      block->logicsettings = LOGIC_FF0_F;
    }
    //Check if the F1 output is routed to FF1
    else if(strncmp(item->bitdata->name, "MC1_DI1_S", 9) == 0)
    {
      block->logicsettings = LOGIC_FF1_F;
    }
    //Check if the FX0 output is routed to FF0
    else if(strncmp(item->bitdata->name, "MC1_FX0_S", 9) == 0)
    {
      block->logicsettings = LOGIC_FF0_FX;
    }
    //Check if the FX1 output is routed to FF1
    else if(strncmp(item->bitdata->name, "MC1_FX1_S", 9) == 0)
    {
      block->logicsettings = LOGIC_FF1_FX;
    }
    //Check the REGSET mode for FF0
    else if(strncmp(item->bitdata->name, "MC1_SR0_S", 9) == 0)
    {
      block->logicsettings = LOGIC_FF0_SR;
    }
    //Check the REGSET mode for FF1
    else if(strncmp(item->bitdata->name, "MC1_SR1_S", 9) == 0)
    {
      block->logicsettings = LOGIC_FF1_SR;
    }
    //Check the DFFMODET mode for the flip flops
    else if(strncmp(item->bitdata->name, "MC1_FFMODE_S", 12) == 0)
    {
      block->logicsettings = LOGIC_FF_LATCH;
    }
    //Check the SRMODE mode for the flip flops
    else if(strncmp(item->bitdata->name, "MC1_SYNCMODE_S", 14) == 0)
    {
      block->logicsettings = LOGIC_FF_SYNC;
    }
    //Check the CLKMUX setting for the flip flops
    else if(strncmp(item->bitdata->name, "MC1_CLK_", 8) == 0)
    {
      block->logicsettings = LOGIC_FF_CLK;
    }
    //Check the GSR setting for the flip flops
    else if(strncmp(item->bitdata->name, "MC1_DISGSR_S", 12) == 0)
    {
      block->logicsettings = LOGIC_FF_GSR;
    }
    //Check the CEMUX setting for the mslice flip flops
    else if(strncmp(item->bitdata->name, "TOP.XI321.MCS", 13) == 0)
    {
      block->logicsettings = LOGIC_FF_CE;
    }
    //Check the SRMUX setting for the mslice flip flops
    else if(strncmp(item->bitdata->name, "TOP.XI321.MCUNUSED", 18) == 0)
    {
      block->logicsettings = LOGIC_FF_SR;
    }
    //Check the CEMUX setting for the lslice flip flops
    else if(strncmp(item->bitdata->name, "TOP.XI322.MCS", 13) == 0)
    {
      block->logicsettings = LOGIC_FF_CE;
    }
    //Check the SRMUX setting for the lslice flip flops
    else if(strncmp(item->bitdata->name, "TOP.XI322.MCUNUSED", 18) == 0)
    {
      block->logicsettings = LOGIC_FF_SR;
    }
    //Check the CMIMUX0 setting for ???
    else if(strncmp(item->bitdata->name, "MC1_CMISEL0_S", 13) == 0)
    {
      block->logicsettings = LOGIC_CMIMUX0;
    }
    //Check the CMIMUX1 setting for ???
    else if(strncmp(item->bitdata->name, "MC1_CMISEL1_S", 13) == 0)
    {
      block->logicsettings = LOGIC_CMIMUX1;
    }
    //Check the DEMUX0 setting for ???
    else if(strncmp(item->bitdata->name, "MC1_DESEL0_S", 12) == 0)
    {
      block->logicsettings = LOGIC_DEMUX0;
    }
    //Check the DEMUX1 setting for ???
    else if(strncmp(item->bitdata->name, "MC1_DESEL1_S", 12) == 0)
    {
      block->logicsettings = LOGIC_DEMUX1;
    }
    //Check the F0MUXLUT5 setting for ???
    else if(strncmp(item->bitdata->name, "MC1_F0MUXLUT5_S", 15) == 0)
    {
      block->logicsettings = LOGIC_F0MUXLUT5;
    }
    //Check the F1MUXLUT5 setting for ???
    else if(strncmp(item->bitdata->name, "MC1_F1MUXLUT5_S", 15) == 0)
    {
      block->logicsettings = LOGIC_F1MUXLUT5;
    }
    //Check the FX0MUXLUT4G setting for ???
    else if(strncmp(item->bitdata->name, "MC1_FX0MUXLUT4G_S", 17) == 0)
    {
      block->logicsettings = LOGIC_FX0MUXLUT4G;
    }
    //Check the FX1MUXLUT4G setting for ???
    else if(strncmp(item->bitdata->name, "MC1_FX1MUXLUT4G_S", 17) == 0)
    {
      block->logicsettings = LOGIC_FX1MUXLUT4G;
    }
    //Check the FX0MUXRIP_N setting for ???
    else if(strncmp(item->bitdata->name, "MC1_FX0MUXRIP_N_S", 17) == 0)
    {
      block->logicsettings = LOGIC_FX0MUXRIP_N;
    }
    //Check the FX1MUXRIP_N setting for ???
    else if(strncmp(item->bitdata->name, "MC1_FX1MUXRIP_N_S", 17) == 0)
    {
      block->logicsettings = LOGIC_FX1MUXRIP_N;
    }
    //Check the RIPMODE0 setting for adder setup
    else if(strncmp(item->bitdata->name, "MC1_RIPMODE0_S", 14) == 0)
    {
      block->logicsettings = LOGIC_RIPMODE0;
    }
    //Check the RIPMODE1 setting for adder setup
    else if(strncmp(item->bitdata->name, "MC1_RIPMODE1_S", 14) == 0)
    {
      block->logicsettings = LOGIC_RIPMODE1;
    }
    //Check the TESTSH setting for ??
    else if(strncmp(item->bitdata->name, "MC1_TESTSH_S", 12) == 0)
    {
      block->logicsettings = LOGIC_TESTSH;
    }
    //Check the FXMUX setting for ??
    else if(strncmp(item->bitdata->name, "MC1_FXMUXON_S", 13) == 0)
    {
      block->logicsettings = LOGIC_FXMUXON;
    }
    
    //To determine the slice id it is more code efficient to check on the three possible types
    //then doing it in each of the if statements above
    if(strncmp(item->bitdata->name, "LUT", 3) == 0)
    {
      //Find the slice identifier for this bit
      dptr = strstr(item->bitdata->name, "S");
      
      //And convert the digit to a number
      block->sliceid = dptr[1] - '0';
    }
    else if(strncmp(item->bitdata->name, "MC1", 3) == 0)
    {
      //MC1 setup items are slice settings only where the slice id is at the end of the string
      length = strlen(item->bitdata->name);

      block->sliceid = item->bitdata->name[length - 1] - '0';
    }
    else if(strncmp(item->bitdata->name, "TOP.", 4) == 0)
    {
      //Non global routing topology bits have the slice id in the property data
      if(item->bitdata->datacount)
      {
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
  //To catch them all, the tree is scanned multiple times until all the bits have been processed

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
        //When no more setup bits are found the loop will break
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
          
          //Check if the current setup bit is not assigned yet
          if(bitlist->blocknumber == -1)
          {
            //Check if there is a current block or not
            if(currentblock == 0)
            {
              //When not make one
              currentblock = malloc(sizeof(BLOCKINFOITEM));
              
              //No previous and next block yet
              currentblock->prev = 0;
              currentblock->next = 0;
              
              //This is the first setup bit for this block
              currentblock->bitcount = 1;
              
              //Set the coordinates this block belongs to
              currentblock->x = x;
              currentblock->y = y;
              
              //Clear the settings
              currentblock->logicsettings = 0;
              currentblock->lut0  = 0;
              currentblock->lut1  = 0;
              currentblock->lutf0 = 0;
              currentblock->lutf1 = 0;
              currentblock->lutg0 = 0;
              currentblock->lutg1 = 0;
              
              //Set the schematic block type and other properties for this block
              findblocktype(bitlist, currentblock);
              
              //Set the tile type of this block
              currentblock->tiletype = bitlist->tiledata->type;
              
              //Set the block number used for these bits
              currentblock->blocknumber = blocknumber;

              //Set the block number in this bit
              bitlist->blocknumber = currentblock->blocknumber;
              bitlist->block = currentblock;
              
              //Select the next id for the next block
              blocknumber++;
              
              //Add this block to the list
              additemtoblocklist(currentblock);
              
              //Make a sorted settings list
              additemtosetuplist(currentblock, bitlist);
            }
            else
            {
              //No match yet
              bitmatch = 0;
              
              //Make sure the settings are clean
              checkblock.logicsettings = 0;
              checkblock.lut0  = 0;
              checkblock.lut1  = 0;
              checkblock.lutf0 = 0;
              checkblock.lutf1 = 0;
              checkblock.lutg0 = 0;
              checkblock.lutg1 = 0;
              
              //At this point a check is needed to see if the current bit is part of the same block
              //Use a dummy block to get the type and compare the two
              findblocktype(bitlist, &checkblock);
              
              //The block type needs to match before deciding it is the same block
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
                bitlist->block = currentblock;
                
                //Added another setup bit to this block
                currentblock->bitcount++;
                
                //Merge the settings
                currentblock->logicsettings |= checkblock.logicsettings;
                currentblock->lut0  |= checkblock.lut0;
                currentblock->lut1  |= checkblock.lut1;
                currentblock->lutf0 |= checkblock.lutf0;
                currentblock->lutf1 |= checkblock.lutf1;
                currentblock->lutg0 |= checkblock.lutg0;
                currentblock->lutg1 |= checkblock.lutg1;
                
                
                //Make a sorted settings list
                additemtosetuplist(currentblock, bitlist);
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

char *getconnectionnet(pBLOCKINFOITEM block, char *signal)
{
  int connection;
  
  for(connection=0;connection<block->connectioncount;connection++)
  {
    if(strcmp(block->connections[connection].signalname, signal) == 0)
    {
      return(block->connections[connection].netname);
    }
  }
  
  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

#define PULL_UP          0
#define PULL_NONE        1
#define PULL_KEEPER      2
#define PULL_DOWN        3

#define SLEW_RATE_NONE   0
#define SLEW_RATE_MED    1
#define SLEW_RATE_FAST   2

//----------------------------------------------------------------------------------------------------------------------------------

char *lutequationlookup[16] =
{
  0,                             //Now filtered as it yields no ones, but could also be "0"
  "~(B+A)",                      //(NOR)
  "~(B+~A)",
  "~(B+~A)+~(B+A)",
  "~(~B+A)",
  "~(~B+A)+~(B+A)",
  "B@A",                         //(XOR)
  "~(B*A)",                      //(NAND)
  "B*A",                         //(AND)
  "~(B@A)",                      //(NOT_XOR)
  "(B*A)+~(B+~A)",
  "(B*A)+~(B+~A)+~(B+A)",
  "(B*A)+~(~B+A)",
  "(B*A)+~(~B+A)+~(B+A)",
  "B+A",                         //(OR)
  "1"                            //The IDE seems to need equations with normal numbers and not single bit because it sees 1'b1 as 1 but also 1'b0 as 1.
};

//----------------------------------------------------------------------------------------------------------------------------------

//Need a function to distill the bits needed to get a 2 input equation matching the given LUT
//The input needs the two lowest signals denominations plus the top level index and the lookup table in question
//This can work up to LUT4 and only returns the equation for the selected part

//A slice can use for instance the c and d inputs and not the a and b inputs for a LUT2
//In this case aidx is 4 and bidx is 8 and cdidx is 0
//It will then use the lut bits from position 0, 4, 8 and 12 to make up the index into the equation lookup table.

char *getlut2equation(int aidx, int bidx, int cdidx, int lutdata)
{
  int tableidx = 0;
  int lidx = 0;
  int oidx;
  
  for(oidx=0;oidx<4;oidx++)
  {
    //Determine the index into the lookup table based on the given input indexes
    switch(oidx)
    {
      case 0:
        //The first index is based on the c and d input indexes
        lidx = cdidx;
        break;

      case 1:
        //The second index is based on the a, c and d input indexes
        lidx = aidx + cdidx;
        break;

      case 2:
        //The third index is based on the b, c and d input indexes
        lidx = bidx + cdidx;
        break;

      case 3:
        //The fourth index is based on the a, b, c and d input indexes
        lidx = aidx + bidx + cdidx;
        break;
    }
    
    //Fill in the current table index bit based on the needed bit from the given lookup table
    tableidx |= ((lutdata >> lidx) & 1) << oidx;
  }
  
  return(lutequationlookup[tableidx]);
}

//----------------------------------------------------------------------------------------------------------------------------------

void processpadsettings(FILE *fo, pBLOCKINFOITEM block)
{
  int connection;
  
  int padtype = PAD_NONE;
  int pulltype = PULL_UP;
  int slewrate = SLEW_RATE_NONE;
  
  int found = 0;
  
  char *netname;
  
  //When the block is not connected assume it to be an output
  if(block->connected == 0)
  {
    padtype = PAD_OUTPUT;
  }
  
  //Start with the first settings bit for this block
  pBITLISTITEM setuplist = block->firstsettingsbit;
  
  //Need to walk through the settings list and pick the matching bits for the current block
  //The bits in the setup list are sorted on block number so when a change from needed to next one is detected the check can stop
  while((setuplist) && (setuplist->blocknumber == block->blocknumber))
  {
    //To determine the slew rate setting MC12_SLEW_ bits need to be checked
    if(strncmp(setuplist->bitdata->name, "MC12_SLEW_", 10) == 0)
    {
      //Get the index of this bit to determine the slew rate setting
      switch(getsetupbitidx(setuplist->bitdata->name, 10, 2))
      {
        case 0:
          //If the first bit is set it means medium slew rate
          slewrate |= SLEW_RATE_MED;
          break;

        case 1:
          //If the second bit is set it means fast slew rate
          slewrate |= SLEW_RATE_FAST;
          break;
      }
    }
    //To determine the PULLTYPE MC12_USR_ bits need to be checked
    else if(strncmp(setuplist->bitdata->name, "MC12_USR_PD_", 12) == 0)
    {
      //When the PD bit is set it could mean NO PULLUP
      pulltype |= PULL_NONE;
    }
    else if(strncmp(setuplist->bitdata->name, "MC12_USR_PU_N_", 14) == 0)
    {
      //When the PU_N bit is set it could mean KEEPER
      pulltype |= PULL_KEEPER;
    }

    //When there is no connection to the block it needs to be determined by the settings what it is. Input or output
    //This is the case for clock input blocks that connect to the PLL
    if(block->connected == 0)
    {
      //When the bit MC1_TRI_ is set it is an input
      if(strncmp(setuplist->bitdata->name, "MC1_TRI_", 8) == 0)
      {
        padtype = PAD_INPUT;
      }
    }

    //Other bits can be checked here to determine more settings like drive strength
    //but for this defaults are assumed
    
    setuplist = setuplist->next;
  }
  
  //When the block is connected the type can be deduced more easily by checking the connections
  if(block->connected)
  {
    //Check the connections on input, output and ts to determine the PAD MODE
    for(connection=0;connection<block->connectioncount;connection++)
    {
      //A bidirectional pad has all three of the connections, so flags are set based on which signal is connected
      if(strcmp(block->connections[connection].signalname, "di") == 0)
      {
        padtype |= PAD_INPUT;
      }
      else if(strcmp(block->connections[connection].signalname, "otrue") == 0)
      {
        padtype |= PAD_OUTPUT;
      }
      else if(strcmp(block->connections[connection].signalname, "ts") == 0)
      {
        padtype |= PAD_TS;
      }
    }
  }
  else
  {
    //Mark it as connected
    block->connected = 1;
    
    //When it is an input it must be a clock signal and needs to be connected to the pll some how
    
    //When it is an output it needs to be connected to a 1. Have to figure out some signal name for this.
    //A ground connection is made via the visible routing
  }
  
#ifdef PIN_ASSIGNMENTS
  //try to find a hdl name assigned to the pin
  pPINASSIGNMENTS pinlist = pin_assignments;

  while(pinlist->hdl_name)
  {
    if(block->pinnumber == pinlist->pinnumber)
    {
      snprintf(block->padname, sizeof(block->padname), "%s", pinlist->hdl_name);
      found = 1;
      break;
    }

    pinlist++;
  }
#endif

  //No name found or search disabled, then assign one based on type, block and pin number
  if(found == 0)
  {
    if(padtype == PAD_BIDIRECTIONAL)
    {
      snprintf(block->padname, sizeof(block->padname), "io_block_%d_pin_%d", block->blocknumber, block->pinnumber);
    }
    else if(padtype & PAD_INPUT)
    {
      snprintf(block->padname, sizeof(block->padname), "i_block_%d_pin_%d", block->blocknumber, block->pinnumber);
    }    
    else
    {
      snprintf(block->padname, sizeof(block->padname), "o_block_%d_pin_%d", block->blocknumber, block->pinnumber);
    }    
  }
  
  //Set the type for printing in the module io list
  block->padtype = padtype;
  
  //Setup the constraint for the pin
  fprintf(fo, "set_pin_assignment { %s } { LOCATION = P%d; IOSTANDARD = LVCMOS33; PULLTYPE = ", block->padname, block->pinnumber);
  
  //Add the needed PULLTYPE
  switch(pulltype)
  {
    case PULL_UP:
      fprintf(fo, "PULLUP; ");
      break;

    case PULL_NONE:
      fprintf(fo, "NONE; ");
      break;

    case PULL_KEEPER:
      fprintf(fo, "KEEPER; ");
      break;

    case PULL_DOWN:
      fprintf(fo, "PULLDOWN; ");
      break;
  }
  
  //Add the needed slew rate
  if(slewrate == SLEW_RATE_MED)
  {
    fprintf(fo, "SLEWRATE = MED; ");
  }
  else if(slewrate == SLEW_RATE_FAST)
  {
    fprintf(fo, "SLEWRATE = FAST; ");
  }
  
  //Finish the line
  fprintf(fo, "}\n");
  
  //Only when all three are present, it is a bidirectional one
  //Add a connection for the schematic block
  if(padtype == PAD_BIDIRECTIONAL)
  {
    block->connections[block->connectioncount].signalname = "bpad";
  }
  else if(padtype & PAD_INPUT)
  {
    block->connections[block->connectioncount].signalname = "ipad";
  }
  else if(padtype & PAD_OUTPUT)
  {
    block->connections[block->connectioncount].signalname = "opad";
  }

  //Finish the connection for the schematic block
  block->connections[block->connectioncount].netname = block->padname;
  block->connectioncount++;
}

//----------------------------------------------------------------------------------------------------------------------------------

void createpadassignment(FILE *fo, pBLOCKINFOITEM block)
{
  if(block->padtype & PAD_INPUT)
  {
    fprintf(fo, "  assign %s = %s;\n", getconnectionnet(block, "di"), block->padname);
  }
  
  if(block->padtype & PAD_OUTPUT)
  {
    fprintf(fo, "  assign %s = %s;\n", block->padname, getconnectionnet(block, "otrue"));
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

#define B2(n)   n, n+1, n+1, n+2
#define B4(n) B2(n), B2(n+1), B2(n+1), B2(n+2)

int inputsusedcount[] = { B4(0), B4(1), B4(1), B4(2) };

//----------------------------------------------------------------------------------------------------------------------------------

int getsliceusedpins(pBLOCKINFOITEM block)
{
  int usedpins = PIN_NONE;
  
  int connection;
  
  pPINTYPE pintable;

  //When the block is connected the type can be deduced more easily by checking the connections
  if(block->connected)
  {
    //Check the connections on input, output and ts to determine the PAD MODE
    for(connection=0;connection<block->connectioncount;connection++)
    {
      //Reset the pin lookup pointer
      pintable = slicepins;
      
      //Need to search through the pin lookup table to find the index for the current one
      //Based on the combined indexes the logic type can be further determined
      while(pintable->name)
      {
        //Check if the current matches the one in the table
        if(strcmp(block->connections[connection].signalname, pintable->name) == 0)
        {
          //If so mark it in the used pins
          usedpins |= pintable->indexbit;
        }
        
        pintable++;
      }
    }
  }
  
  return(usedpins);
}

//----------------------------------------------------------------------------------------------------------------------------------

char *lut0inputnames[] =
{
  0,
  "a_0",
  "b_0",
  0,
  "c_0",
  0,
  0,
  0,
  "d_0",
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  "e_0",
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  "mi_0"
};

char *lut1inputnames[] =
{
  0,
  "a_1",
  "b_1",
  0,
  "c_1",
  0,
  0,
  0,
  "d_1",
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  "e_1",
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  "mi_1"
};

//----------------------------------------------------------------------------------------------------------------------------------

int weighinputpin(int *inputpins, int *index)
{
  int found = 0;
  
  //Determine the weight for the input.
  //When first input is set it will be 1, 2 for the second, 4 for the third, etc
  while((found == 0) && *inputpins)
  {
    //Bail out on the first set pin
    if(*inputpins & 1)
    {
      found = *index;
    }
    
    //Bump the weight and pins
    *index <<= 1;
    *inputpins >>= 1;
  }
  
  return(found);
}

//----------------------------------------------------------------------------------------------------------------------------------

void outputlutmacro(FILE *fo, pBLOCKINFOITEM block, int lutid, int inputcount, int lutdata, int usedpins, int *uid)
{
  int aidx = 0;
  int bidx = 0;
  int cidx = 0;
  int didx = 0;
  int eidx = 0;
  
  int index = 1;
  int inputpins;
  int partprinted;
  
  char **lutinputnames = lut0inputnames;
  
  char *equation;
  char *outname;
  char *lutoutput = block->lut0output;
  
  //Get the set of used pins belonging to the given lut
  if(lutid)
  {
    //There are 12 bits reserved for LUT0 pins so to get the LUt1 pins shift them down by 12.
    usedpins >>= 12;
    
    //Select the input name table for LUT1
    lutinputnames = lut1inputnames;
    
    //Set the lut output name destination for LUT1
    lutoutput = block->lut1output;
  }
  
  //Filter out the input pins for determining the weights of the macros "a" and "b" inputs
  inputpins = usedpins & LUT_INPUT_PINS;

//This part is wrong in mapping the inputs from the fabric onto the inputs of the LUT macro
//The question is then also if the generation of th equation is wrong
//I guess that for the weighing the setup is still correct in relation with the given lookup table
  
  
//For a two input LUT the top connected bit should be mapped onto "a"
//The next one down should be mapped onto "b"

//Have to verify the formula by using something with an inverted input (A*~B)
  
//For a three input LUT it seems to differ
  
//There might be the need for a translation table to make the mappings based on the number of inputs

//For LUT2
//Assume that
//"d" is always "a"
//"c" is always "b"
  
  
//For LUT3
//Assume that
//"d" is always "a"
//"b" is always "b"
//"c" is always "c"

//Need to verify if the below actually is the case for all occurrences of LUT1, 2 and 3 and maybe 4
  
//A mslice can be combined into a lut5 by setting FXMUXON. Both luts are then combined and the mi0 input is then used as the 5th input
//Since this is a somewhat special case the question is how to handle it here

//This is definitely not correct because for some LUT2 it uses the actual b input instead of the c input
//Need to check the connected inputs to make it work
#if 0  
  //Set the input weights based on the number of inputs
  switch(inputcount)
  {
    case 1:
      aidx = 8;
      break;
      
    case 2:
      aidx = 8;
      bidx = 4;
      break;
      
    case 3:
      aidx = 8;
      bidx = 2;
      cidx = 4;
      break;

    case 4:
      aidx = 1;  //a input pin  88 blue
      bidx = 2;  //b input pin 101 green
      cidx = 4;  //c input pin  28 red
      didx = 8;  //d input pin  31 yellow
      break;
      
    case 5:
      aidx = 1;
      bidx = 2;
      cidx = 4;
      didx = 8;
      eidx = 16;
      break;
  }
#endif
  
  //Even though this setup does not match with the gate level code generated by the IDE for simulation it should yield correct equations
  
  //Determine the weight for the "a" input.
  aidx = weighinputpin(&inputpins, &index);
  
  //When there are more inputs connected weigh the next pin
  if(inputcount > 1)
  {
    //The "b" input has at least the next input weight
    bidx = weighinputpin(&inputpins, &index);

    //When there are still more inputs connected weigh the next pin
    if(inputcount > 2)
    {
      //The "c" input has at least the next input weight
      cidx = weighinputpin(&inputpins, &index);

      //When there are still more inputs connected weigh the next pin
      if(inputcount > 3)
      {
        //The "d" input has at least the next input weight
        didx = weighinputpin(&inputpins, &index);

        //When there are still more inputs connected weigh the next pin
        if(inputcount > 4)
        {
          //The "e" input has at least the next input weight
          eidx = weighinputpin(&inputpins, &index);
        }
      }
    }
  }
  
  //Output the header line of the macro
  fprintf(fo, "  AL_MAP_LUT%d #\n  (\n", inputcount);
  
  //The setup below works but needs a looping code to make it maintainable and easier to grasp
  
  //Another solution would be looping through the table bits and when a one is found makeup an equation part
  //The bit index holds the information on which inputs are set and which are not
  
  //It depends on the number of inputs, but there is still the problem of the inputs having these weights that are not in logical order
  
  
  
  //Print the equation based on the lookup table data and the input weights and the number of inputs
  switch(inputcount)
  {
    case 1:
      //For a single input lut it depends on two settings and is either A or ~A. If the first entry is 1 then it is ~A.
      if(lutdata & 1)
      {
        fprintf(fo, "    .EQN(\"~A\")\n");
      }
      else
      {
        fprintf(fo, "    .EQN(\"A\")\n");
      }
      break;

    case 2:
      //Only a 2 input equation needed
      if(equation = getlut2equation(aidx, bidx, 0, lutdata))
      {
        //When there is a valid result print that
        fprintf(fo, "    .EQN(\"%s\")\n", equation);
      }
      else
      {
        //When there is no one found in the lut, set zero for the equation.
        fprintf(fo, "    .EQN(\"0\")\n");
      }
      break;

    case 3:
      //No need for an or statement yet
      partprinted = 0;
      
      //Print the first part of the line for the equation to allow for filtering the zero parts
      fprintf(fo, "    .EQN(\"");
      
      //Get the equation part for C input being zero
      if(equation = getlut2equation(aidx, bidx, 0, lutdata))
      {
        //If there is a result add it to the line
        fprintf(fo, "(~C*(%s))", equation);
        
        //Signal first part is printed
        partprinted = 1;
      }

      //Get the equation part for C input being set
      if(equation = getlut2equation(aidx, bidx, cidx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(C*(%s))", equation);
        
        //Signal second part is printed
        partprinted = 1;
      }
      
      //Check if the lut has no ones set
      if(partprinted == 0)
      {
        //Set the equation to zero in this case
        fprintf(fo, "0");
      }
      
      //Finish the equation line
      fprintf(fo, "\")\n");
      break;

    case 4:
      //No need for an or statement yet
      partprinted = 0;
      
      //Print the first part of the line for the equation to allow for filtering the zero parts
      fprintf(fo, "    .EQN(\"");
      
      //Get the equation part for C and D input being zero
      if(equation = getlut2equation(aidx, bidx, 0, lutdata))
      {
        //If there is a result add it to the line
        fprintf(fo, "(~D*~C*(%s))", equation);
        
        //Signal first part is printed
        partprinted = 1;
      }

      //Get the equation part for C input being set and D input being zero
      if(equation = getlut2equation(aidx, bidx, cidx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(~D*C*(%s))", equation);
        
        //Signal second part is printed
        partprinted = 1;
      }
      
      //Get the equation part for C input being zero and D input being set
      if(equation = getlut2equation(aidx, bidx, didx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(D*~C*(%s))", equation);
        
        //Signal second part is printed
        partprinted = 1;
      }
      
      //Get the equation part for C and D input being set
      if(equation = getlut2equation(aidx, bidx, didx + cidx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(D*C*(%s))", equation);
        
        //Signal second part is printed
        partprinted = 1;
      }
      
      //Check if the lut has no ones set
      if(partprinted == 0)
      {
        //Set the equation to zero in this case
        fprintf(fo, "0");
      }
      
      //Finish the equation line
      fprintf(fo, "\")\n");
      break;

    case 5:
      //No need for an or statement yet
      partprinted = 0;
      
      //Print the first part of the line for the equation to allow for filtering the zero parts
      fprintf(fo, "    .EQN(\"");
      
      //Get the equation part for C, D and E input being zero
      if(equation = getlut2equation(aidx, bidx, 0, lutdata))
      {
        //If there is a result add it to the line
        fprintf(fo, "(~E*~D*~C*(%s))", equation);
        
        //Signal first part is printed
        partprinted = 1;
      }

      //Get the equation part for C input being set and D and E input being zero
      if(equation = getlut2equation(aidx, bidx, cidx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(~E*~D*C*(%s))", equation);
        
        //Signal second part is printed
        partprinted = 1;
      }
      
      //Get the equation part for C and E input being zero and D input being set
      if(equation = getlut2equation(aidx, bidx, didx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(~E*D*~C*(%s))", equation);
        
        //Signal second part is printed
        partprinted = 1;
      }
      
      //Get the equation part for C and D input being set and E input being zero
      if(equation = getlut2equation(aidx, bidx, didx + cidx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(~E*D*C*(%s))", equation);
        
        //Signal second part is printed
        partprinted = 1;
      }
      
      //Get the equation part for C, D input being zero and E being set
      if(equation = getlut2equation(aidx, bidx, eidx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(E*~D*~C*(%s))", equation);
        
        //Signal first part is printed
        partprinted = 1;
      }

      //Get the equation part for C and E input being set and D input being zero
      if(equation = getlut2equation(aidx, bidx, eidx + cidx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(E*~D*C*(%s))", equation);
        
        //Signal second part is printed
        partprinted = 1;
      }
      
      //Get the equation part for C input being zero and D and E input being set
      if(equation = getlut2equation(aidx, bidx, eidx + didx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(E*D*~C*(%s))", equation);
        
        //Signal second part is printed
        partprinted = 1;
      }
      
      //Get the equation part for C, D and E input being set
      if(equation = getlut2equation(aidx, bidx, eidx + didx + cidx, lutdata))
      {
        //Check if the first part of the equation is printed
        if(partprinted)
        {
          //If so add the or statement to the line
          fprintf(fo, "+");
        }
        
        //If there is a result add it to the line
        fprintf(fo, "(E*D*C*(%s))", equation);
        
        //Signal second part is printed
        partprinted = 1;
      }
      
      //Check if the lut has no ones set
      if(partprinted == 0)
      {
        //Set the equation to zero in this case
        fprintf(fo, "0");
      }
      
      //Finish the equation line
      fprintf(fo, "\")\n");
      break;
  }
  
  
  //The .INIT is not really needed so left out
  
  //That is all for the macro setup part
  fprintf(fo, "  )\n");
  
  //To have the IDE generate the same bit stream the gates need to be numbered in a special way
  //By the looks of things the name needs to be _al_ux, where x can be 1 for most of the blocks
  //but when two luts are used in the same slice the lut0 one needs a 2 for x
  
  //This does not work. The blocks need to be numbered from 0 with the last block in the list starting at the first number after the pads
  //The pads are numbered starting from zero
  //Need to do this numbering on before hand, but how is the question
  //The order of the lut output generation needs to be swapped back to lut0 first
  
  //Need to count the pads first, which is no problem because they are processed first. Then it is a bit problematic because the order has to be from end back to front
  //It seems to work when the blocks are processed from last to first, but this needs a last pointer and prev pointers to track back
  //Have to see how to set the last pointer
  
  //Start the connections section
  fprintf(fo, "  _al_u%d_block_%d_lut_%d\n  (\n", *uid, block->blocknumber, lutid);
  
  //One more _al_u entity dealt with
  *uid = *uid + 1;

  //Get the net name for the "a" input and output it to the file
  fprintf(fo, "    .a(%s),\n" , getconnectionnet(block, lutinputnames[aidx]));
  
  //Connect the additional inputs as needed
  if(inputcount > 1)
  {
    //Get the net name for the "b" input and output it to the file
    fprintf(fo, "    .b(%s),\n" , getconnectionnet(block, lutinputnames[bidx]));

    if(inputcount > 2)
    {
      //Get the net name for the "c" input and output it to the file
      fprintf(fo, "    .c(%s),\n" , getconnectionnet(block, lutinputnames[cidx]));
      
      if(inputcount > 3)
      {
        //Get the net name for the "d" input and output it to the file
        fprintf(fo, "    .d(%s),\n" , getconnectionnet(block, lutinputnames[didx]));
      
        if(inputcount > 4)
        {
          //Get the net name for the "e" input and output it to the file
          fprintf(fo, "    .e(%s),\n" , getconnectionnet(block, lutinputnames[eidx]));
        }
      }      
    }
  }
  
  //For the mslice it can also be FX0 when LOGIC_FXMUXON is set
  //This means that for the LUT it always needs a generated name for the connection
  //This is implicitly handled with the F output not being connected
  
  //Check if the "f" output is connected to a net
  //Since the pins for LUT1 are shifted into LUT0 position check can be done with only f_0
  if(usedpins & PIN_F0)
  {
    //Select the name to connect to based on the given LUT id
    if(lutid)
    {
      outname = "f_1";
    }
    else
    {
      outname = "f_0";
    }
    
    //Get the net name for the "f" output and output it to the file
    fprintf(fo, "    .o(%s)\n" ,getconnectionnet(block, outname));
  }
  else
  {
    //When the LUT is connected to the flip flop there is the need for a internal wire to connect them  
    //Make a name to identify the signal between the LUT and the FF and save it in the space for the given lut
    snprintf(lutoutput, MAX_NAME_LENGTH, "sig_block_%d_lut_%d", block->blocknumber, lutid);

    //Output the given name to the file
    fprintf(fo, "    .o(%s)\n", lutoutput);
  }
  
  //That is all for the macro setup part
  fprintf(fo, "  );\n\n");
}

//----------------------------------------------------------------------------------------------------------------------------------

void outputseqmacro(FILE *fo, pBLOCKINFOITEM block, int ffid, int usedpins)
{
  char *dname;
  char *qname;
  char *regset  = "SET";
  char *dffmode = "FF";
  char *srmode  = "ASYNC";
  char *clkmux  = "CLK";
  char *gsrmode = "ENABLE";
  char *cemux   = "0";
  char *srmux   = "0";
  
  int ceused = 0;
  int srused = 0;
  
  //Setup the needed names based on the given FF id
  if(ffid)
  {
    //For slice 0 the default is the F output instead of the mi input unless the FX MUX is on
    //Check which input is used for the flip flop
    if((block->logicsettings & LOGIC_FF1_F) || ((block->sliceid == 0) && ((block->logicsettings & LOGIC_FXMUXON) == 0)))
    {
      //The LUT1 "f" is selected in this case
      //Check if the "f" output is connected to a net
      if(usedpins & PIN_F1)
      {
        //If so use the net name
        dname = getconnectionnet(block, "f_1");
      }
      else
      {
        //When not use the generated name
        dname =  block->lut1output;
      }
    }
    else if(block->logicsettings & LOGIC_FF1_FX)
    {
      //Check if the "fx" output is connected to a net
      if(usedpins & PIN_FX1)
      {
        //If so use the net name
        dname = getconnectionnet(block, "fx_1");
      }
      else
      {
        //When not use the generated name
        dname =  block->lut1output;
      }
    }
    else
    {
      //per default the "mi" input is used
      dname = getconnectionnet(block, "mi_1");
    }
    
    //See if the REGSET property needs to be changed
    if(block->logicsettings & LOGIC_FF1_SR)
    {
      regset = "RESET";
    }
  
    //Use the "q_1" net for FF1
    qname =  "q_1";
  }
  else
  {
    //For slice 0 the default is the F output instead of the mi input unless the FX MUX is on
    //Check which input is used for the flip flop
    if((block->logicsettings & LOGIC_FF0_F) || ((block->sliceid == 0) && ((block->logicsettings & LOGIC_FXMUXON) == 0)))
    {
      //The LUT0 "f" is selected in this case
      //Check if the "f" output is connected to a net
      if(usedpins & PIN_F0)
      {
        //Check if the "f" output is connected to a net
        dname = getconnectionnet(block, "f_0");
      }
      else
      {
        //When not use the generated name
        dname =  block->lut0output;
      }
    }
    //For slice 0 LUT 0 the default is the FX output when the FX MUX is on
    else if((block->logicsettings & LOGIC_FF0_FX) || ((block->sliceid == 0) && (block->logicsettings & LOGIC_FXMUXON)))
    {
      //Check if the "fx" output is connected to a net
      if(usedpins & PIN_FX0)
      {
        //Check if the "f" output is connected to a net
        dname = getconnectionnet(block, "fx_0");
      }
      else
      {
        //When not use the generated name
        dname =  block->lut0output;
      }
    }
    else
    {
      //per default the "mi" input is used
      dname = getconnectionnet(block, "mi_0");
    }
    
    //See if the REGSET property needs to be changed
    if(block->logicsettings & LOGIC_FF0_SR)
    {
      regset = "RESET";
    }

    //Use the "q_0" net for FF0
    qname =  "q_0";
  }

  //Check if the "ce" pin is actually used or connected to ground
  if(usedpins & PIN_CE)
  {
    //Check if not connected to the ground net
    if(strcmp(getconnectionnet(block, "ce"), "ground"))
    {
      ceused = 1;
    }
  }

  //Check if the "sr" pin is actually used or connected to ground
  if(usedpins & PIN_SR)
  {
    //Check if not connected to the ground net
    if(strcmp(getconnectionnet(block, "sr"), "ground"))
    {
      srused = 1;
    }
  }
  
  //See if the DFFMODE property needs to be changed
  if(block->logicsettings & LOGIC_FF_LATCH)
  {
    dffmode = "LATCH";
  }

  //See if the SRMODE property needs to be changed
  if(block->logicsettings & LOGIC_FF_SYNC)
  {
    srmode = "SYNC";
  }
  
  //See if the CLKMUX property needs to be changed
  if(block->logicsettings & LOGIC_FF_CLK)
  {
    clkmux = "INV";
  }
  
  //See if the GSR property needs to be changed
  if(block->logicsettings & LOGIC_FF_GSR)
  {
    gsrmode = "DISABLE";
  }
  
  //Check the ce and sr pins on connection to decide on the setting of these two
  //Also need to check some settings bits???
  
  //Might need to detect if connected to ground to set the proper selection
  
  //When the "ce" input is connected and the CEMUX mode bit is set the input is inverted
  if((ceused) && (block->logicsettings & LOGIC_FF_CE))
  {
    cemux = "INV";
  }
  //When the "ce" input pin is connected but the CEMUX mode bit is not set it is the actual input
  else if(ceused)
  {
    cemux = "CE";
  }
  //When the "ce" input is not connected and the CEMUX mode bit is set it is "1"
  else if(block->logicsettings & LOGIC_FF_CE)
  {
    cemux = "1";
  }
  
  //When the "sr" input is connected and the SRMUX mode bit is set the input is inverted
  if((srused) && (block->logicsettings & LOGIC_FF_SR))
  {
    srmux = "INV";
  }
  //When the "sr" input pin is connected but the SRMUX mode bit is not set it is the actual input
  else if(srused)
  {
    srmux = "SR";
  }
  //When the "sr" input is not connected and the SRMUX mode bit is set it is "1"
  else if(block->logicsettings & LOGIC_FF_SR)
  {
    srmux = "1";
  }
  
  //Output the header line of the macro
  fprintf(fo, "  AL_MAP_SEQ #\n  (\n");
  
  //Output the given CEMUX setting
  fprintf(fo, "    .CEMUX(\"%s\"),\n" , cemux);
  
  //Output the given CLKMUX setting
  fprintf(fo, "    .CLKMUX(\"%s\"),\n" , clkmux);
  
  //Output the given DFFMODE setting
  fprintf(fo, "    .DFFMODE(\"%s\"),\n" , dffmode);
  
  //Output the given REGSET setting
  fprintf(fo, "    .REGSET(\"%s\"),\n" , regset);
  
  //Output the given SRMODE setting
  fprintf(fo, "    .SRMODE(\"%s\"),\n" , srmode);

  //Output the given GSR setting
  fprintf(fo, "    .GSR(\"%s\"),\n" , gsrmode);

  //Output the given SRMUX setting and close the header
  fprintf(fo, "    .SRMUX(\"%s\")\n  )\n" , srmux);
  
  //Start the connections section
  fprintf(fo, "  reg_block_%d_ff_%d\n  (\n", block->blocknumber, ffid);
  
  //Add the connected pins as needed
  if(usedpins & PIN_CLK)
  {
    //Get the net name for the "clk" input and output it to the file
    fprintf(fo, "    .clk(%s),\n" ,getconnectionnet(block, "clk"));
  }
  
  if(ceused)
  {
    //Get the net name for the "ce" input and output it to the file
    fprintf(fo, "    .ce(%s),\n" ,getconnectionnet(block, "ce"));
  }
  
  if(srused)
  {
    //Get the net name for the "sr" input and output it to the file
    fprintf(fo, "    .sr(%s),\n" ,getconnectionnet(block, "sr"));
  }

  //Output the found connection name for the "d" input to the file
  fprintf(fo, "    .d(%s),\n", dname);

  //Get the net name for the "q" output and output it to the file
  //Also finish the macro
  fprintf(fo, "    .q(%s)\n  );\n\n" ,getconnectionnet(block, qname));
}

//----------------------------------------------------------------------------------------------------------------------------------

void processlslicesettings(FILE *fo, pBLOCKINFOITEM block, int *uid)
{
  int inputcnt;
  
  int usedpins = getsliceusedpins(block);
  
    
    
    //Need the remainder of the settings checked for the SEQ macro and fill in the macro printing based on it
    
    //Check on MC1_F0MUXLUT5_S to confirm LUT_5 mode on f output
    //When not set it might be LUT_4 mode???
    //Have to see if it is needed to check upon, because it seems to work for at least the basic stuff
    
    
    
    //For the AL_MAP_SEQ macro it is needed to check the 
    //TOP.XI322.MCS0 bit to see if CEMUX is set
    //There is also something about the CLKMUX
    
    
    
    //Need to detect an adder setup based on ripple setting
    
    //Need to detect the usage of either of the flip flops
    
    //For a full adder the slice macro can be used?
    
    
    
    //Within the properties there are the values FUNC5, FUNC6 and FUNC7 which I guess are to indicate the basic and extended lut types
    //Have to work through the logic of it to determine the correct intended setting
    
    
    //MC1_CLK bit set indicates inverted clock which is either a slice or a seq property
    
    
    //MC1_CMISEL is for the MI input used only on lslice and is per lut.
    //for lut 0
    //LUTF0 setting must be MI together with CMIMUX0 setting being MI and FUNC6 must not be set for LSFXMUX0
    //for lut 1
    //LUTF1 setting must be MI together with CMIMUX1 setting being MI and FUNC7 must not be set for LSFXMUX1
    
    //MC1_DESEL is for something with the G lut
    //(LUTG must be E, DEMUX must be E and LSFXMUX must not be FUNC5) or MODE is set to RIPPLE
    
    //MC1_RIPMODE selection of the carry borrow mode???
    //MODE must be RIPPLE and INJECT must not be YES
    
    //MC1_DISGSR is per slice but no idea what it does
    //GSR must be DISABLE
    
    
    //MC1_DISRAM is per tile and enabled distributed ram but how and what is involved no idea
    //Not used so no problem
    
    //MC1_F0MUXLUT5_S  something to do with the F output of the two luts ??
    //LSFXMUX0 must be FUNC5, LUTG0 not E and DEMUX0 not E
    
    //MC1_FX0MUXLUT4G something to do with the FX output of the two luts
    //(LSFXMUX0 must be FUNC6, LUTF0 must not be MI and CMIMUX must not be MI) or LSFXMUX0 == SUM
    
    //MC1_FX0MUXRIP_N ??
    //(LSFXMUX0 must be FUNC6, LUTF0 must not be MI and CMIMUX must not be MI) or LSFXMUX0 == LUTG
    
    
    
    
    
    
    //MC1_TESTSH ??
    //TESTMODE must be SHIFT
    
    
    //There are some topology bits that have SRMUX and CEMUX properties says something about inverted signals.
  
  //This is not going to work properly, because the TD IDE uses different mapping when it is just a LUT and not a more complex function within the slice
  //So based on the different settings the type of "gate" needs to be determined, which is a bit tricky.
  
  //To detect for instance a single input lut the used input needs to be determined and no flip flop should be used
  //But when a flip flop is used it could be a sequence "gate"
  
  
  //How to determine the type of the slice??????
  //Need to define the possible types to start with.
  
  //Then when it turns out that there is no flip flop used for both and it is not an adder it must be an AL_MAP_LUT and then
  //The number of inputs needs to be determine, by scanning the connections
  
  //Need to examine the possible logic combinations for the lslice based on the settings!!!!!!
  
  //Check if the lslice macro needs to be used
  //Skip the rest if so  
   
  
  if(block->logicsettings & (LOGIC_LUTF0 | LOGIC_LUTG0))
  {
    block->lut0 = block->lutg0 << 16 | block->lutf0;
    
    //Need to determine the needed macro based on the number of input signals
    //For the lslice the LUT has a, b, c, d and e as possible inputs so only these are counted
    outputlutmacro(fo, block, 0, inputsusedcount[(usedpins & 0x1F)], block->lut0, usedpins, uid);
  }
  
  if(block->logicsettings & (LOGIC_LUTF1 | LOGIC_LUTG1))
  {
    block->lut1 = block->lutg1 << 16 | block->lutf1;
    
    //Need to determine the needed macro based on the number of input signals
    //For the lslice the LUT only has a, b, c, d and e as possible inputs so only these are counted
    outputlutmacro(fo, block, 1, inputsusedcount[((usedpins >> 12) & 0x1F)], block->lut1, usedpins, uid);
  }
 

  
  //Probably need to check if the f output is connected and if so use the f connected net name and do the same in the SEQ macro is used
  //The question is if the flip flop can be used separate from the LUT. It is possible to select different input signals to it
  //Question is if the default is mi. It looks like it, since there are only two bits for the select, MC1_DI and MC1_FX
  //But these are not available for slice 0!!!! For slice 0 it seems to be that F is the default and only option

  //Make it so that when there is no connection to the f_ signal that the output of the LUT is connected to the made up name
  //The flip flop can then be connected based on the settings of the two bits MC1_DI and MC1_FX. Default is mi as input. Either DI or FX is set, and for as far as I can tell, never both

  //This means there is a need for different bit settings to make up the FF input setting
  
  
  //Check if SEQ macro is needed for FF0
  if(usedpins & PIN_Q0)
  {
    //The logic bits signal what settings to use and which input to use
    //The used pins signal which input name to use
    outputseqmacro(fo, block, 0, usedpins);
  }

  //Check if SEQ macro is needed for FF1
  if(usedpins & PIN_Q1)
  {
    //The logic bits signal what settings to use and which input to use
    //The used pins signal which input name to use
    outputseqmacro(fo, block, 1, usedpins);
  }


  

  //Create a function for each macro
  
  //Setup the common verilog for the pad
//  dptr += sprintf(dptr, "  AL_PHY_LSLICE #\n  (\n");
//  dptr += sprintf(dptr, "    .INIT_LUTF0(16'h%4.4X\"),\n", lutf0);
//  dptr += sprintf(dptr, "    .INIT_LUTG0(16'h%4.4X\"),\n", lutg0);
//  dptr += sprintf(dptr, "    .INIT_LUTF1(16'h%4.4X\"),\n", lutf1);
//  dptr += sprintf(dptr, "    .INIT_LUTG1(16'h%4.4X\"),\n", lutg1);

//  dptr += sprintf(dptr, "    .INDEL(\"1\"),\n");
  //Need a block name and list the connections
}

//----------------------------------------------------------------------------------------------------------------------------------

void processmslicesettings(FILE *fo, pBLOCKINFOITEM block, int *uid)
{
  int inputcnt;
  
  int usedpins = getsliceusedpins(block);

    
    
  //MC1_FXMUXON  MSFXMUX needs to be ON. What does this route???
  
  //Need some checks here to see if the mslice macro needs to be used
  //When the mslice macro is used the rest needs to be skipped


//Need to look into RIPMODE and how to process that when set. Each LUT has its own setting for it!!
//But it looks like it is always enabled on both the LUT's. The question is if a macro needs to be created if one of the LUT's is not connected
//And which macro is suited
//When both are set just use the MSLICE macro??
//How to deal with not connected signals??
//Also the fcim and fcom signals need to be taken care of. This needs checking the tiles in the same column on having the RIPMODE also set
  
//Can it be done with the AL_MAP_ADDER macro. If so how to make the connections, and what if the flip flop is used???
// Is it possible to just use the SEQ macro in addition to the ADDER macro???


  
  //Need to look at the connected signals for a block with just LUT logic
  

  //When MC1_FXMUXON bit is set for the slice the LOGIC_FXMUXON bit is set in block->logicsettings
  //The two LUT's are the n combined to a LUT5 setup, but the inputs to the two LUT's can be connected
  //differently. By outputting two LUT4 macros this is dealt with, but then the two outputs need to
  //be merged in a LUT3 macro with the two outputs connected to A and B inputs and mi_0 to the C input
  //The output of the LUT3 macro needs either a generated name or be connected to the fx_0 output.
  //When the first flipflop is used it should be connected to the proper signal.

  //When FXMUXON is set one of the LUT's might have zero bits set, so need to force generation of the LUT macros
  if(block->logicsettings & (LOGIC_LUT0 | LOGIC_FXMUXON))
  {
    //Need to determine the needed macro based on the number of input signals
    //For the mslice the LUT only has a, b, c and d as possible inputs so only these are counted
    outputlutmacro(fo, block, 0, inputsusedcount[(usedpins & 0x0F)], block->lut0, usedpins, uid);
  }

  //When FXMUXON is set one of the LUT's might have zero bits set, so need to force generation of the LUT macros
  if(block->logicsettings & (LOGIC_LUT1 | LOGIC_FXMUXON))
  {
    //Need to determine the needed macro based on the number of input signals
    //For the mslice the LUT only has a, b, c and d as possible inputs so only these are counted
    outputlutmacro(fo, block, 1, inputsusedcount[((usedpins >> 12) & 0x0F)], block->lut1, usedpins, uid);
  }

  if(block->logicsettings & LOGIC_FXMUXON)
  {
    //Output the header line of the macro
    fprintf(fo, "  AL_MAP_LUT3 #\n  (\n");

    //Followed by the fixed equation for the 2 input MUX
    fprintf(fo, "    .EQN(\"(~C*A)+(C*B)\")\n");

    //That is all for the macro setup part
    fprintf(fo, "  )\n");

    //Start the connections section
    fprintf(fo, "  _al_u%d_block_%d\n  (\n", *uid, block->blocknumber);

    //One more _al_u entity dealt with
    *uid = *uid + 1;

    //Use the generated name for the "a" input and output it to the file
    fprintf(fo, "    .a(%s),\n" , block->lut0output);

    //Use the generated name for the "b" input and output it to the file
    fprintf(fo, "    .b(%s),\n" , block->lut1output);
    
    //Get the net name for the "c" input and output it to the file. This is always the mi_0 input
    fprintf(fo, "    .c(%s),\n" , getconnectionnet(block, "mi_0"));

    //Check if the "fx_0" output is connected to a net
    if(usedpins & PIN_FX0)
    {
      //Get the net name for the "f" output and output it to the file
      fprintf(fo, "    .o(%s)\n" ,getconnectionnet(block, "fx_0"));
    }
    else
    {
      //When the LUT is connected to the flip flop there is the need for a internal wire to connect them  
      //Make a name to identify the signal between the LUT and the FF and save it in the space for the given lut
      //It is ok to overwrite the generated name here, since it is not needed elsewhere
      //Also sets it for the use in the SEQ macro if needed
      snprintf(block->lut0output, MAX_NAME_LENGTH, "sig_block_%d_ff0_in", block->blocknumber);

      //Output the given name to the file
      fprintf(fo, "    .o(%s)\n", block->lut0output);
    }

    //That is all for the macro setup part
    fprintf(fo, "  );\n\n");
  }

  //Check if SEQ macro is needed for FF0
  if(usedpins & PIN_Q0)
  {
    //The logic bits signal what settings to use and which input to use
    //The used pins signal which input name to use
    outputseqmacro(fo, block, 0, usedpins);
  }

  //Check if SEQ macro is needed for FF1
  if(usedpins & PIN_Q1)
  {
    //The logic bits signal what settings to use and which input to use
    //The used pins signal which input name to use
    outputseqmacro(fo, block, 1, usedpins);
  }
  
  
  //Need to figure out how to extend the detected logic type based on the connections
  //A simple lut uses the F output and A, B, C and D inputs
  //Have to see if other pins are grounded or not and if so do they matter?
  //Can the clock be used with flip flop 0 or 1 and the other lut be just a lut???
  
  
  
  //Scan the connections and decide on the type of logic
  
  //For the available connections a table lookup would require 9 bits is 512 entries to fill
  //But would be a quick way to determine the logic.
  
  //Have to check out the latest with a register if the lut and register are combined in the same block
  
//  dptr += sprintf(dptr, "  AL_PHY_MSLICE #\n  (\n");
//  dptr += sprintf(dptr, "    .INIT_LUT0(16'h%4.4X\"),\n", lut0);
//  dptr += sprintf(dptr, "    .INIT_LUT1(16'h%4.4X\"),\n", lut1);
}

//----------------------------------------------------------------------------------------------------------------------------------

void creategatelevelverilog()
{
  char filename[255];
  
  pBLOCKINFOITEM printlist;
  
  FILE *fverilog;
  FILE *fconstraint;
  
  int count;
  
  int uid = 0;
  
  int needcomma = 0;
  
  //Create a gate level verilog file
  snprintf(filename, sizeof(filename), "%s_gate_level.v", FILENAME);
  fverilog = fopen(filename, "w");  
  
  //Create a pin constraints file
  snprintf(filename, sizeof(filename), "%s_generated.adc", FILENAME);
  fconstraint = fopen(filename, "w");  
  
  
  if(fverilog && fconstraint)
  {
    fprintf(fverilog, "module %s\n(", MODULENAME);
    
    printlist = blocklist;
    
    //Process the PAD blocks
    while(printlist)
    {
      //Needs to be of type PAD. Pin less and actual unconnected pads need to be filtered based on number of bits
      //Pins that are configured but have connections to the PLL or global clocks can exist without visible connections
      if((printlist->blocktype == BLOCK_PAD) && (printlist->bitcount > 3))
      {
        //Need to process the settings for the current pad
        processpadsettings(fconstraint, printlist);
        
        if(needcomma)
        {
          fprintf(fverilog, ",");
        }

        fprintf(fverilog, "\n");
        
        //output this in the io list of the module
        if(printlist->padtype == PAD_BIDIRECTIONAL)
        {
          fprintf(fverilog, "  inout wire %s", printlist->padname);
        }
        else if(printlist->padtype & PAD_INPUT)
        {
          fprintf(fverilog, "  input wire %s", printlist->padname);
        }
        else if(printlist->padtype & PAD_OUTPUT)
        {
          fprintf(fverilog, "  output wire %s", printlist->padname);
        }
        
        needcomma = 1;
        
        //Need to index the pads to get the _al_u number for the LUT logic blocks
        uid++;
      }
      
      printlist = printlist->next;
    }

    fprintf(fverilog, "\n);\n\n");
    
    //Need a wire list??
    
    //Need some method of connecting the clock signals
    //There are blockless premux connections that need to be resolved for this
    //Have to see if this can be done in an earlier stage
    
    
    //Need to setup a wire list at this point, but need to see what to list
    
    
    
    //The pad names need to be assigned to the internally used wires.
    printlist = blocklist;
    
    //Process the connected PAD blocks
    while(printlist)
    {
      //Needs to be connected and of type PAD
      if((printlist->connected == 1) && (printlist->blocktype == BLOCK_PAD))
      {
        //Create an assign statement for making the connection between the pad and the internally used signal
        createpadassignment(fverilog, printlist);
      }
      
      printlist = printlist->next;
    }
    
    //Extra line between pad assignments and the logic
    fprintf(fverilog, "\n");
    
    
    //At this point the list needs to be processed backwards for naming the _al_u macros in specific order
    //Unfortunately this does not always result in the exact same bit stream due to different placing of the logic
    //Process the remaining logic
    printlist = blocklistend;
    
    //Process the blocks
    while(printlist)
    {
      if(printlist->blocktype == BLOCK_LSLICE)
      {
        //Need to process the settings for the current lslice into the needed macro(s)
//        processlslicesettings(fverilog, printlist, &uid);
      }
      else if(printlist->blocktype == BLOCK_MSLICE)
      {
        //Need to process the settings for the current mslice into the needed macro(s)
        processmslicesettings(fverilog, printlist, &uid);
      }
      
      //process the bram


      //process the pll
      
      
      
      printlist = printlist->prev;
    }    
    
    //Have to see if there is a need for assign statements at this point to connect the in and output signals to internal signals    
    
#if 0
    printlist = blocklist;
    
    //Process the PAD blocks
    while(printlist)
    {
      //Needs to be connected and of type PAD
      if((printlist->connected == 1) && (printlist->blocktype == BLOCK_PAD))
      {
        //output this in the body of the module
        fwrite(printlist->verilog, printlist->veriloglength, 1, fo);
      }
      
      printlist = printlist->next;
    }
    
    //A bit of a problem is the connection that needs to be made and the wires it needs to do it
    //especially when other logic comes into the mix
    
#endif
    
    fprintf(fverilog, "endmodule\n\n");
    
    
  }


  if(fverilog)
  {
    fclose(fverilog);
  }
  
  if(fconstraint)
  {
    fclose(fconstraint);
  }
  
}


//----------------------------------------------------------------------------------------------------------------------------------

void printblocklist()
{
  char filename[255];

  pBLOCKINFOITEM printlist;
  
  FILE *fo;
  
  int connected;
  int count;
  int idx;
  int logicsettings;
  
  char **settingnames;
  
  snprintf(filename, sizeof(filename), "%s_block_list.csv", FILENAME);
  
  fo = fopen(filename, "w");  
  
  if(fo)
  {
    for(connected=1;connected>=0;connected--)
    {
      count = 0;
      
      if(connected == 1)
      {
        fprintf(fo, "Connected blocks\n");
      }
      else
      {
        fprintf(fo, "Unconnected blocks\n");
      }

      fprintf(fo, "block number,x,y,,block type,,emb,slice,pad,pin,,settings\n");

      printlist = blocklist;

      while(printlist)
      {
        if(printlist->connected == connected)
        {
          if(!((printlist->blocktype == BLOCK_PAD) && (printlist->bitcount == 3)))
          {
            count++;

            fprintf(fo, "%d,%d,%d,,\"%s\",", printlist->blocknumber, printlist->x, printlist->y, printlist->tiletype);

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

            if((printlist->blocktype == BLOCK_MSLICE) || (printlist->blocktype == BLOCK_LSLICE))
            {
              //Get the settings for this slice
              logicsettings = printlist->logicsettings;
              
              if(printlist->blocktype == BLOCK_MSLICE)
              {
                settingnames = mslicesettingnames;
              }
              else
              {
                settingnames = lslicesettingnames;
              }

              //Additional separator to align the columns
              fprintf(fo, ",");
              
              //Print them as set
              for(idx=0;idx<32;idx++)
              {
                //Check if the current bit is set and print the name from the list based on the index
                if(logicsettings & 1)
                {
                  fprintf(fo, ",%s", settingnames[idx]);
                }
                
                logicsettings >>= 1;
              }
            }
            
            
            fprintf(fo, "\n");
          }
        }

        
        //Select the next item
        printlist = printlist->next;
      }
      
      fprintf(fo, "\ncount,%d\n\n", count);
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

  int connected;
  int count;
  
  FILE *fo;
  
  snprintf(filename, sizeof(filename), "%s_block_setup_list.csv", FILENAME);
  
  fo = fopen(filename, "w");  
  
  if(fo)
  {
    for(connected=1;connected>=0;connected--)
    {
      count = 0;
      
      if(connected == 1)
      {
        fprintf(fo, "Connected blocks\n");
      }
      else
      {
        fprintf(fo, "Unconnected blocks\n");
      }

      fprintf(fo, "Block,,Tile,,,,,Pin,,Bit\n");
      fprintf(fo, "number,,name,type,x,y,,pin,,name,type,x,y,xoff,yoff,,expression,rpn,count,,data\n");

      printlist = blocksetuplist;

      while(printlist)
      {
        if(printlist->block->connected == connected)
        {
          if(!((printlist->block->blocktype == BLOCK_PAD) && (printlist->block->bitcount == 3)))
          {
            count++;

            //Check if next block is found
            if(printlist->blocknumber != blocknumber)
            {
              //Separate the nets with a blank line
              fprintf(fo, "\n");

              //Set the new number for change check
              blocknumber = printlist->blocknumber;
            }

            printbititem(fo, printlist);
          }
        }

        //Select the next item
        printlist = printlist->next;
      }
      
      fprintf(fo, "\ncount,%d\n\n", count);
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
    fprintf(fo, "net number,signal type,block number,,signal name,pin\n");
    
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
        
      fprintf(fo, "%d,%d,%d,,", bitlist->netnumber, bitlist->netsignal, bitlist->blocknumber);
      
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

void outputblockschematics()
{
  pBLOCKINFOITEM block = blocklist;

  unsigned int   pixels = 600;
  unsigned int   rows = 850;
  unsigned int   bytesperrow;
  unsigned int   size;
  unsigned int   filesize;
  unsigned char  buffer[54];
  unsigned char *bitmap;

  //Need the inverted rows for the bitmap header to maintain proper orientation of the image
  unsigned int   invrows = rows * -1;
  
  char filename[255];
  
  pSCHEMATICBLOCK baseblock;
  
  FILE *fo;
  
  //Number of bytes on a row for a 24 bits per pixel bitmap
  bytesperrow = pixels * 3;

  //Adjust for 32 bit segments
  bytesperrow = (bytesperrow + 3) & 0x0FFFFFFC;

  //Calculate the size of the bitmap in bytes
  size = bytesperrow * rows;
  
  bitmap = malloc(size);
  
  if(bitmap)
  {
    //Setup the bitmap header only once
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
    buffer[22] = invrows & 0xFF;
    buffer[23] = (invrows >>  8) & 0xFF;
    buffer[24] = (invrows >> 16) & 0xFF;
    buffer[25] = (invrows >> 24) & 0xFF;

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
    
    while(block)
    {
      if(block->connected)
      {
        memset(bitmap, 0, size);

        //Blue outline around the current block
        draw_rect(bitmap, bytesperrow, 5, 5, pixels - 10, rows -10, 0x0033AAFF);
        draw_rect(bitmap, bytesperrow, 6, 6, pixels - 12, rows - 12, 0x0033AAFF);

        //No block yet
        baseblock = 0;

        //Need to map the type of block to a schematic block here
        switch(block->blocktype)
        {
          case BLOCK_PAD:
            baseblock = &pad;

            if(block->pinnumber != -1)
            {
              //Print the bitmap output file name
              snprintf(filename, sizeof(filename), "%s/pin_%d_tile_x%dy%d_block_%d.bmp", BLOCKFOLDER, block->pinnumber, block->x, block->y, block->blocknumber);
            }
            else
            {
              //Print the bitmap output file name
              snprintf(filename, sizeof(filename), "%s/pad_%d_tile_x%dy%d_block_%d.bmp", BLOCKFOLDER, block->padid, block->x, block->y, block->blocknumber);
            }
            break;

          case BLOCK_MSLICE:
            baseblock = &mslice;
            
            //Print the bitmap output file name
            snprintf(filename, sizeof(filename), "%s/mslice_%d_tile_x%dy%d_block_%d.bmp", BLOCKFOLDER, block->sliceid, block->x, block->y, block->blocknumber);
            break;

          case BLOCK_LSLICE:
            baseblock = &lslice;
            
            //Print the bitmap output file name
            snprintf(filename, sizeof(filename), "%s/lslice_%d_tile_x%dy%d_block_%d.bmp", BLOCKFOLDER, block->sliceid, block->x, block->y, block->blocknumber);
            break;

          case BLOCK_EMB:
            baseblock = &emb;
            
            //Print the bitmap output file name
            snprintf(filename, sizeof(filename), "%s/emb_%d_tile_x%dy%d_block_%d.bmp", BLOCKFOLDER, block->embid, block->x, block->y, block->blocknumber);
            break;

          case BLOCK_PLL:
            baseblock = &pll;
            
            //Print the bitmap output file name
            snprintf(filename, sizeof(filename), "%s/pll%d_tile_x%dy%d_block_%d.bmp", BLOCKFOLDER, block->pllid, block->x, block->y, block->blocknumber);
            break;

          case BLOCK_GCLK_PREMUX:
            baseblock = &gclk_premux;
            
            //Print the bitmap output file name
            snprintf(filename, sizeof(filename), "%s/gclk_premux_tile_x%dy%d_block_%d.bmp", BLOCKFOLDER, block->x, block->y, block->blocknumber);
            break;

          case BLOCK_GCLK_CTMUX:
            baseblock = &gclk_ctmux;
            
            //Print the bitmap output file name
            snprintf(filename, sizeof(filename), "%s/gclk_ctmux_tile_x%dy%d_block_%d.bmp", BLOCKFOLDER, block->x, block->y, block->blocknumber);
            break;
        }

        //Only when there is a block to draw
        if(baseblock)
        {
          //Draw the block with the signal connections
          draw_block(bitmap, bytesperrow, 250, 70, 0x0000FF00, 0x00FF0000, baseblock, block);

          fo = fopen(filename, "wb");

          if(fo)
          {
            fwrite(buffer, 1, 54, fo);

            fwrite(bitmap, 1, size, fo);

            fclose(fo);
          }
        }
      }
    
      block = block->next;
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

    //Implement a filter on the blocks to eliminate the unconnected io pads based on them only having three setup bits
    //Maybe just a simple bit count during the making of the list will do???
    
    //Filter the route list into a net list
    filterroutelist();
    
    //At this point the data can be converted in gate level verilog by reading both the nets and the block setup data
    
    //The file starts with a module and it's external signals.
    
    //Need to flag the signal names to avoid listing them double
    
    //Then a list of all the wires that are needed.
    
    //After that the AL_PHY_PAD macros to put all the pads in the verilog
    
    //Then the LUTS and SLICES
    
    //And last the BRAM and PLL
    
#ifdef OUTPUT_VERILOG
    creategatelevelverilog();
#endif
    
    //Create a tree list for the connected blocks
//    createtreelist();
    
    //Print the block list
    printblocklist();

    //Print the setup list
    printsetuplist();
    
    //Print the net list
    printnetlist();

    //Create block schematic pages
#ifdef OUTPUT_SCHEMATICS    
    outputblockschematics();
#endif
    
    //Memory cleanup
    freeallmemory();
  }
}

//----------------------------------------------------------------------------------------------------------------------------------
