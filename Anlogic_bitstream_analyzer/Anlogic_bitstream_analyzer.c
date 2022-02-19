//----------------------------------------------------------------------------------------------------------------------------------

#include <stdio.h>      // standard input / output functions
#include <stdlib.h>
#include <string.h>

//----------------------------------------------------------------------------------------------------------------------------------

#define BITSPERCOLUMN            31
#define BITSPERROW               54

#define COLUMNS                  35      //x last is 34
#define ROWS                     38      //y last is 37
#define FRAMES                 1075
#define BITS_PER_FRAME         2056
#define DB_BITS_PER_FRAME      2052
#define BRAM_BITS_PER_FRAME    9216
#define GAP                      64

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
};

//----------------------------------------------------------------------------------------------------------------------------------

extern unsigned char CharacterMap[256][8];

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

void addtoroutelist(pTILEGRIDDATA tiledata, pCONFIGBITDATA bitdata, pTILEPADPINMAP paddata)
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
    
  uchar *sptr = bitstreamdata;
  
  //getmaxcolumnvalue();
  
  
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
                addtoroutelist(tilegriddata, bitdata, tilepadinmap);
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
    }
  }

}

//----------------------------------------------------------------------------------------------------------------------------------
