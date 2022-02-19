//----------------------------------------------------------------------------------------------------------------------------------

#include <stdio.h>      // standard input / output functions
#include <stdlib.h>
#include <string.h>

//----------------------------------------------------------------------------------------------------------------------------------

#include "database/tilegrid.h"

#include "database/clkdiv_bk1.h"
#include "database/clkdiv_bk2.h"
#include "database/clkdiv_bk3.h"
#include "database/clkdiv_bk4.h"
#include "database/clkdiv_bk5.h"
#include "database/clkdiv_bk6.h"
#include "database/clkdiv_bk7.h"
#include "database/clkdiv_bk8.h"
#include "database/emb_slice.h"
#include "database/emb32k_b0.h"
#include "database/emb32k_b1.h"
#include "database/gclk_csb.h"
#include "database/gclk_ctmux_l.h"
#include "database/gclk_ctmux_u.h"
#include "database/gclk_premux_b.h"
#include "database/gclk_premux_l.h"
#include "database/gclk_premux_r.h"
#include "database/gclk_premux_t.h"
#include "database/gclk_spine.h"
#include "database/ioclk_bk1.h"
#include "database/ioclk_bk2.h"
#include "database/ioclk_bk3.h"
#include "database/ioclk_bk4.h"
#include "database/ioclk_bk5.h"
#include "database/ioclk_bk6.h"
#include "database/ioclk_bk7.h"
#include "database/ioclk_bk8.h"
#include "database/iol_pair_l.h"
#include "database/iol_pair_r.h"
#include "database/iol_quad_b.h"
#include "database/iol_quad_l.h"
#include "database/iol_quad_r.h"
#include "database/iol_quad_t.h"
#include "database/ios_bankref_bl.h"
#include "database/ios_bankref_br.h"
#include "database/ios_bankref_l.h"
#include "database/ios_bankref_r.h"
#include "database/ios_bankref_tl.h"
#include "database/ios_bankref_tr.h"
#include "database/mult.h"
#include "database/osc.h"
#include "database/pib.h"
#include "database/plb.h"
#include "database/pll0.h"
#include "database/pll2.h"

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

typedef unsigned char  uchar;
typedef unsigned int   uint;

typedef unsigned char  uint8;
typedef unsigned short uint16;
typedef unsigned int   uint32;


typedef struct tagBITLISTITEM      BITLISTITEM,      *pBITLISTITEM;

typedef struct tagBITDATAPOINTERS  BITDATAPOINTERS, *pBITDATAPOINTERS;

//----------------------------------------------------------------------------------------------------------------------------------

struct tagBITLISTITEM
{
  pBITLISTITEM  prev;
  pBITLISTITEM  next;
  int           frame;
  int           bit;
  int           tilearrayindex;
  int           bitarrayindex;
  int           bitdataindex;
};

struct tagBITDATAPOINTERS
{
  char           *type;
  int             count;
  pCONFIGBITDATA  data;
};

//----------------------------------------------------------------------------------------------------------------------------------

pBITLISTITEM frames[FRAMES];

int frame_counts[FRAMES];

//----------------------------------------------------------------------------------------------------------------------------------

BITDATAPOINTERS bitdatapointers[] =
{
  { "clkdiv_bk1", clkdiv_bk1_COUNT, clkdiv_bk1_Data },
  { "clkdiv_bk2", clkdiv_bk2_COUNT, clkdiv_bk2_Data },
  { "clkdiv_bk3", clkdiv_bk3_COUNT, clkdiv_bk3_Data },
  { "clkdiv_bk4", clkdiv_bk4_COUNT, clkdiv_bk4_Data },
  { "clkdiv_bk5", clkdiv_bk5_COUNT, clkdiv_bk5_Data },
  { "clkdiv_bk6", clkdiv_bk6_COUNT, clkdiv_bk6_Data },
  { "clkdiv_bk7", clkdiv_bk7_COUNT, clkdiv_bk7_Data },
  { "clkdiv_bk8", clkdiv_bk8_COUNT, clkdiv_bk8_Data },

  { "emb32k_b0", emb32k_b0_COUNT, emb32k_b0_Data },
  { "emb32k_b1", emb32k_b1_COUNT, emb32k_b1_Data },

  { "emb_slice", emb_slice_COUNT, emb_slice_Data },

  { "gclk_csb",      gclk_csb_COUNT,      gclk_csb_Data      },
  { "gclk_ctmux_l",  gclk_ctmux_l_COUNT,  gclk_ctmux_l_Data  },
  { "gclk_ctmux_u",  gclk_ctmux_u_COUNT,  gclk_ctmux_u_Data  },
  { "gclk_premux_b", gclk_premux_b_COUNT, gclk_premux_b_Data },
  { "gclk_premux_l", gclk_premux_l_COUNT, gclk_premux_l_Data },
  { "gclk_premux_r", gclk_premux_r_COUNT, gclk_premux_r_Data },
  { "gclk_premux_t", gclk_premux_t_COUNT, gclk_premux_t_Data },
  { "gclk_spine",    gclk_spine_COUNT,    gclk_spine_Data    },

  { "ioclk_bk1", ioclk_bk1_COUNT, ioclk_bk1_Data },
  { "ioclk_bk2", ioclk_bk2_COUNT, ioclk_bk2_Data },
  { "ioclk_bk3", ioclk_bk3_COUNT, ioclk_bk3_Data },
  { "ioclk_bk4", ioclk_bk4_COUNT, ioclk_bk4_Data },
  { "ioclk_bk5", ioclk_bk5_COUNT, ioclk_bk5_Data },
  { "ioclk_bk6", ioclk_bk6_COUNT, ioclk_bk6_Data },
  { "ioclk_bk7", ioclk_bk7_COUNT, ioclk_bk7_Data },
  { "ioclk_bk8", ioclk_bk8_COUNT, ioclk_bk8_Data },

  { "iol_pair_l", iol_pair_l_COUNT, iol_pair_l_Data },
  { "iol_pair_r", iol_pair_r_COUNT, iol_pair_r_Data },

  { "iol_quad_b", iol_quad_b_COUNT, iol_quad_b_Data },
  { "iol_quad_l", iol_quad_l_COUNT, iol_quad_l_Data },
  { "iol_quad_r", iol_quad_r_COUNT, iol_quad_r_Data },
  { "iol_quad_t", iol_quad_t_COUNT, iol_quad_t_Data },

  { "ios_bankref_bl", ios_bankref_bl_COUNT, ios_bankref_bl_Data },
  { "ios_bankref_br", ios_bankref_br_COUNT, ios_bankref_br_Data },
  { "ios_bankref_l",  ios_bankref_l_COUNT,  ios_bankref_l_Data  },
  { "ios_bankref_r",  ios_bankref_r_COUNT,  ios_bankref_r_Data  },
  { "ios_bankref_tl", ios_bankref_tl_COUNT, ios_bankref_tl_Data },
  { "ios_bankref_tr", ios_bankref_tr_COUNT, ios_bankref_tr_Data },

  { "mult", mult_COUNT, mult_Data },
  { "osc",  osc_COUNT,  osc_Data  },
  { "pib",  pib_COUNT,  pib_Data  },
  { "plb",  plb_COUNT,  plb_Data  },
  { "pll0", pll0_COUNT, pll0_Data },
  { "pll2", pll2_COUNT, pll2_Data },
};

//----------------------------------------------------------------------------------------------------------------------------------

int stricmp(char *str1, char *str2)
{
  char c1,c2;

  while(*str1 && *str2)
  {
    c1 = *str1 & 0x5F;
    c2 = *str2 & 0x5F;

    if(c1 < c2)
      return(-1);

    if(c1 > c2)
      return(1);

    str1++;
    str2++;
  }

  if(*str1)
    return(1);

  if(*str2)
    return(-1);

  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

int gettileforxy(int x, int y, int flag, int startindex)
{
  for(;startindex<TILEGRIDCOUNT; startindex++)
  {
    if((flag == TileGridData[startindex].flag) && (x == TileGridData[startindex].x) && (y == TileGridData[startindex].y))
    {
      return(startindex);
    }
  }

  return(-1);
}

//----------------------------------------------------------------------------------------------------------------------------------

pTILEGRIDDATA gettileforxyandtype(int x, int y, char *type)
{
  pTILEGRIDDATA starttile;

  for(starttile=TileGridData;starttile<&TileGridData[TILEGRIDCOUNT];starttile++)
  {
    if((starttile->flag == -1) && (x == starttile->x) && (y == starttile->y) && (stricmp(type, starttile->type) == 0))
    {
      return(starttile);
    }
  }

  return(0);
}

//----------------------------------------------------------------------------------------------------------------------------------

void makebitlist(int x, int y, int tileindex, int bitdataindex)
{
  int bitindex;
  int tilex,tiley;

  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;

  pTILEGRIDDATA tiledata;

  pCONFIGBITDATA bitdata = bitdatapointers[bitdataindex].data;

  int count = bitdatapointers[bitdataindex].count;

  //Process all the bits in this data set
  for(bitindex=0;bitindex<count;bitindex++)
  {
    //Get memory for the bit list item for this bit
    bitlistitem = malloc(sizeof(BITLISTITEM));

    //Set the source information
    bitlistitem->bitdataindex   = bitdataindex;
    bitlistitem->tilearrayindex = tileindex;
    bitlistitem->bitarrayindex  = bitindex;

    //Calculate in which this bit resides
    tilex = x + bitdata[bitindex].xoff;
    tiley = y + bitdata[bitindex].yoff;

    //To calculate the actual frame and bit location within the configuration bit stream
    //the type of the bit is an indicator where it belongs

    //Get the belonging block within the target tile and use the startframe and startbit to calculate the coordinates
    tiledata = gettileforxyandtype(tilex, tiley, bitdata[bitindex].type);

    if(tiledata)
    {
      bitlistitem->frame = tiledata->startframe + bitdata[bitindex].x;
      bitlistitem->bit   = tiledata->startbit + bitdata[bitindex].y;
    }
    else
    {
      bitlistitem->frame = TileGridData[tileindex].startframe + bitdata[bitindex].x;
      bitlistitem->bit   = TileGridData[tileindex].startbit + bitdata[bitindex].y;
    }

    //Add this bit in the frames list
    if(frames[bitlistitem->frame] == 0)
    {
      //First item in the list, so no previous and next
      bitlistitem->prev = 0;
      bitlistitem->next = 0;

      //Set it as the first item of the list
      frames[bitlistitem->frame] = bitlistitem;
    }
    else
    {
      //Get the first list item
      bitlist = frames[bitlistitem->frame];

      //Look for where the data needs to be inserted or replaced
      while(bitlist)
      {
        //Sort on the bit
        if(bitlistitem->bit < bitlist->bit)
        {
          //Do an insert
          //Check if first item of the list
          if(bitlist->prev == 0)
          {
            //If so make this one the first item in the list, so no previous
            bitlistitem->prev = 0;
            bitlistitem->next = bitlist;

            //Set the back track connection
            bitlist->prev = bitlistitem;

            //Set it as the first item of the list
            frames[bitlistitem->frame] = bitlistitem;
          }
          else
          {
            //Insert it in the list
            //Link the new item to the previous item
            bitlistitem->prev = bitlist->prev;
            bitlist->prev->next = bitlistitem;

            //Link the item to insert before to the new item
            bitlistitem->next = bitlist;
            bitlist->prev = bitlistitem;
          }

          //Done so quit
          break;
        }

        //For equal bits do a replace
        if(bitlistitem->bit == bitlist->bit)
        {
          //Do a replace
          //Check if first item of the list
          if(bitlist->prev == 0)
          {
            //If so make this one the first item in the list, so no previous
            bitlistitem->prev = 0;
            bitlistitem->next = bitlist->next;

            //Set the back track connection if needed
            if(bitlist->next)
            {
              bitlist->next->prev = bitlistitem;
            }

            //Set it as the first item of the list
            frames[bitlistitem->frame] = bitlistitem;
          }
          else
          {
            //Replace it in the list
            //Link the new item to the previous item
            bitlistitem->prev = bitlist->prev;
            bitlist->prev->next = bitlistitem;

            //Link the item to the next item
            bitlistitem->next = bitlist->next;
            
            //Set the back track connection if needed
            if(bitlist->next)
            {
              bitlist->next->prev = bitlistitem;
            }
          }
          
          //Delete the replaced item
          free(bitlist);
          
          //Done so quit
          break;
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
}

//----------------------------------------------------------------------------------------------------------------------------------

//A bit of a problem is the fact that configuration bits can have double assignments
//For now the second entry is used and the original entry is deleted.
//This is valid behavior since the original entry will be either an unused pib or plb bit

int main(int argc, char** argv)
{
  int x,y;

  char filename[255];

  int tileindex;
  int typeindex;
  int i;
  int frame;

  pCONFIGBITDATA bitdata;

  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;

  pBITDATA bititemdata;

  //Clear the data array
  memset(frames, 0, sizeof(frames));

  for(x=0;x<COLUMNS;x++)
  {
    for(y=0;y<ROWS;y++)
    {
      tileindex = 0;

      //Get the flagged tiles for this coordinate pair
      while((tileindex = gettileforxy(x, y, -1, tileindex)) != -1)
      {
        //Make the bit list based on the type of the tile
        for(typeindex=0;typeindex<(sizeof(bitdatapointers)/sizeof(BITDATAPOINTERS));typeindex++)
        {
          //Match the type to the list of types found in the database
          if(strcmp(TileGridData[tileindex].type, bitdatapointers[typeindex].type) == 0)
          {
            //Make the list for the bits in this tile
            makebitlist(x, y, tileindex, typeindex);
            break;
          }
        }

        //Select the next tile
        tileindex++;
      }

      tileindex = 0;

      //Get the not flagged tiles for this coordinate pair
      while((tileindex = gettileforxy(x, y, 0, tileindex)) != -1)
      {
        //Make the bit list based on the type of the tile
        for(typeindex=0;typeindex<(sizeof(bitdatapointers)/sizeof(BITDATAPOINTERS));typeindex++)
        {
          //Match the type to the list of types found in the database
          if(strcmp(TileGridData[tileindex].type, bitdatapointers[typeindex].type) == 0)
          {
            //Make the list for the additional bits
            makebitlist(x, y, tileindex, typeindex);
            break;
          }
        }

        //Select the next tile
        tileindex++;
      }
    }
  }

  //Need to make separate files per frame to reduce the size
  //Make a top header file that loads the separate files and create the big array there
  //Add the data for the frames
  for(frame=0;frame<FRAMES;frame++)
  {
    //Check if this frame has data
    if(frames[frame])
    {
      snprintf(filename, sizeof(filename), "/home/peter/Data/NetbeansProjects/Code_Testing/Anlogic_bitstream_analyzer/frames/frame_%d_bits.h", frame);

      FILE *fo = fopen(filename, "w");

      if(fo)
      {
        fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n\n");
        fprintf(fo, "#include \"../database/configbitdata.h\"\n\n");
        fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n\n");
        fprintf(fo, "FRAMEBITMAPPING frame_%d_bits[%d] =\n{\n", frame, DB_BITS_PER_FRAME);

        //Get the first list item
        bitlist = frames[frame];

        frame_counts[frame] = 0;
        
        while(bitlist)
        {
          //Check if current bit is used
          if(frame_counts[frame] < bitlist->bit)
          {
            //Insert null bits if not on par
            for(i=frame_counts[frame];i<bitlist->bit;i++)
            {
              //Output a null bit
              fprintf(fo, "  { 0, 0 },\n");
              
              //Sync up the bit count
              frame_counts[frame]++;
            }
          }
          
          //Output the current bit to the file
          fprintf(fo, "  { &TileGridData[%d], &%s_Data[%d] },\n", bitlist->tilearrayindex, bitdatapointers[bitlist->bitdataindex].type, bitlist->bitarrayindex);

          //Hold this one for freeing the memory
          bitlistitem = bitlist;

          //Select the next item
          bitlist = bitlist->next;

          //Free this item since it is no longer needed
          free(bitlistitem);
          
          //Add one to the count
          frame_counts[frame]++;
        }

        //Check if bits at the end are missing
        if(frame_counts[frame] < DB_BITS_PER_FRAME)
        {
          //Insert null bits if so
          for(i=frame_counts[frame];i<DB_BITS_PER_FRAME;i++)
          {
            //Output a null bit
            fprintf(fo, "  { 0, 0 },\n");

            //Sync up the bit count
            frame_counts[frame]++;
          }
        }
        
        fprintf(fo, "};\n\n");
        fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n\n");

        fclose(fo);
      }
    }
  }


  FILE *fo = fopen("/home/peter/Data/NetbeansProjects/Code_Testing/Anlogic_bitstream_analyzer/frames/frame_bit_mapping.c", "w");

  if(fo)
  {
    fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n\n");
    fprintf(fo, "#include \"../database/database.h\"\n\n");
    fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n\n");

    for(frame=0;frame<FRAMES;frame++)
    {
      fprintf(fo, "#include \"../frames/frame_%d_bits.h\"\n", frame);
    }

    fprintf(fo, "\n");
    fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n\n");
    fprintf(fo, "pFRAMEBITMAPPING frame_bit_mapping[%d] =\n{\n", FRAMES);

    for(frame=0;frame<FRAMES;frame++)
    {
      fprintf(fo, "  frame_%d_bits,\n", frame);
    }

    fprintf(fo, "};\n\n");
    fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n");
    
    fclose(fo);
  }
  
  fo = fopen("/home/peter/Data/NetbeansProjects/Code_Testing/Anlogic_bitstream_analyzer/frames/frame_bit_mapping.h", "w");

  if(fo)
  {
    fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n\n");
    fprintf(fo, "#ifndef FRAME_BIT_MAPPING_H\n");
    fprintf(fo, "#define FRAME_BIT_MAPPING_H\n\n");
    fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n\n");
    fprintf(fo, "extern pFRAMEBITMAPPING frame_bit_mapping[1075];\n\n");
    fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n\n");
    fprintf(fo, "#endif //FRAME_BIT_MAPPING_H\n\n");
    fprintf(fo, "//----------------------------------------------------------------------------------------------------------------------------------\n");
    
    fclose(fo);
  }  
#if 0  
  fo = fopen("frame_counts.csv", "w");

  if(fo)
  {
    fprintf(fo, "frame,bit count\n");
    
    for(frame=0;frame<FRAMES;frame++)
    {
      fprintf(fo, "%d,%d\n", frame, frame_counts[frame]);
    }
    
    fclose(fo);
  }
#endif
}

//----------------------------------------------------------------------------------------------------------------------------------
