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
  pBITLISTITEM    prev;
  pBITLISTITEM    next;
  int             count;
  int             xinumber;
  int             mcnumber;
  int             netnumber;
  char           *name;
  pCONFIGBITDATA  bitdata;
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

pBITLISTITEM toplist = 0;

//----------------------------------------------------------------------------------------------------------------------------------
#if 1
//List of pib routing bits
void insertitembeforetoplist(pBITLISTITEM current, pBITLISTITEM new)
{
  //Do an insert
  //Check if current is the first item of the list
  if(current->prev == 0)
  {
    //If so make the new one the first item in the list, so no previous
    new->prev = 0;
    new->next = current;

    //Set the back track connection
    current->prev = new;

    //Set it as the first item of the list
    toplist = new;
  }
  else
  {
    //Insert it in the list
    //Link the new item to the current item
    new->prev = current->prev;
    current->prev->next = new;

    //Link the item to insert before to the new item
    new->next = current;
    current->prev = new;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

pBITLISTITEM makebitlistitem(pCONFIGBITDATA bitdata, int xinumber, int mcnumber, int netnumber)
{
  pBITLISTITEM bitlistitem;
  
  //Get memory for the bit list item for this bit
  bitlistitem = malloc(sizeof(BITLISTITEM));

  bitlistitem->xinumber = xinumber;
  bitlistitem->mcnumber = mcnumber;
  bitlistitem->netnumber = netnumber;

  bitlistitem->count = 1;
  bitlistitem->name = bitdata->name;

  bitlistitem->bitdata = bitdata;
  
  return(bitlistitem);
}

//----------------------------------------------------------------------------------------------------------------------------------

void addtotoplist(pCONFIGBITDATA bitdata)
{
  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;
  
  int xinumber = -1;
  int mcnumber = -1;
  int netnumber = -1;
  
  char *xiname;
  char *mcname;
  char *netname;

  //Only bits with TOP. in the name need to be added
  if(strncmp(bitdata->name, "TOP.", 4) == 0)
  {
    //Get the numbers
    xiname = strstr(bitdata->name, "XI");
    mcname = strstr(bitdata->name, "MC");
    netname = strstr(bitdata->name, "NET");

    xinumber = atoi(&xiname[2]);
    
    if(mcname)
    {
      mcnumber = atoi(&mcname[2]);
    }

    if(netname)
    {
      netnumber = atoi(&netname[3]);
    }
    
    //Add this bit in the top list when it is the first item
    if(toplist == 0)
    {
      //Get memory for the bit list item for this bit
      bitlistitem = makebitlistitem(bitdata, xinumber, mcnumber, netnumber);

      //First item in the list, so no previous and next
      bitlistitem->prev = 0;
      bitlistitem->next = 0;

      //Set it as the first item of the list
      toplist = bitlistitem;
    }
    else
    {
      //Get the first list item
      bitlist = toplist;
      
      //Look for where the data needs to be inserted or a count needs to be updated
      while(bitlist)
      {
        //Insert if the xi number is smaller
        if(xinumber < bitlist->xinumber)
        {
          //Get memory for the bit list item for this bit
          bitlistitem = makebitlistitem(bitdata, xinumber, mcnumber, netnumber);
          
          //Insert the item before the current one
          insertitembeforetoplist(bitlist, bitlistitem);
          break;
        }
        
        //Check on the mc number if the xi number is the same
        if(xinumber == bitlist->xinumber)
        {
          //Check if the mc number is used
          if(mcnumber != -1)
          {
            if(mcnumber < bitlist->mcnumber)
            {
              //Get memory for the bit list item for this bit
              bitlistitem = makebitlistitem(bitdata, xinumber, mcnumber, netnumber);

              //Insert the item before the current one
              insertitembeforetoplist(bitlist, bitlistitem);
              break;
            }

            //If both are the same increment the count
            if(mcnumber == bitlist->mcnumber)
            {
              bitlist->count++;
              break;
            }
          }
          else if(netnumber != -1)
          {
            if(netnumber < bitlist->netnumber)
            {
              //Get memory for the bit list item for this bit
              bitlistitem = makebitlistitem(bitdata, xinumber, mcnumber, netnumber);

              //Insert the item before the current one
              insertitembeforetoplist(bitlist, bitlistitem);
              break;
            }

            //If both are the same increment the count
            if(netnumber == bitlist->netnumber)
            {
              bitlist->count++;
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
          //Get memory for the bit list item for this bit
          bitlistitem = makebitlistitem(bitdata, xinumber, mcnumber, netnumber);

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
  int index;
  int bit;
  int count;
  int lastxi = 0;

  pCONFIGBITDATA bitdata;

  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;
  
  //Process all the bits in the current object
  for(bit=0;bit<pib_COUNT;bit++)
  {
    addtotoplist(&pib_Data[bit]);
  }
  
  FILE *fo = fopen("pib_routing_bit_list.csv", "w");

  if(fo)
  {
    fprintf(fo, "Name,expr,,count,,data\n");

    //Get the first list item
    bitlist = toplist;

    while(bitlist)
    {
      bitdata = bitlist->bitdata;
      
      //Add a line spacer on a xi block change
      if(bitlist->xinumber != lastxi)
      {
        fprintf(fo, "\n");
        
        lastxi = bitlist->xinumber;
      }
      
      //Output the current bit to the file
      fprintf(fo, "%s,\"", bitdata->name);

      //Walk through all the expression items
      for(count=0;count<bitdata->exprcount;count++)
      {
        fprintf(fo, "%s", bitdata->expr[count]);
      }

      fprintf(fo, "\",,%d,,", bitdata->datacount);

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
#endif

//----------------------------------------------------------------------------------------------------------------------------------

#if 0
//Make sorted xi mc net with count list
void insertitembeforetoplist(pBITLISTITEM current, pBITLISTITEM new)
{
  //Do an insert
  //Check if current is the first item of the list
  if(current->prev == 0)
  {
    //If so make the new one the first item in the list, so no previous
    new->prev = 0;
    new->next = current;

    //Set the back track connection
    current->prev = new;

    //Set it as the first item of the list
    toplist = new;
  }
  else
  {
    //Insert it in the list
    //Link the new item to the current item
    new->prev = current->prev;
    current->prev->next = new;

    //Link the item to insert before to the new item
    new->next = current;
    current->prev = new;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

pBITLISTITEM makebitlistitem(char *name, int xinumber, int mcnumber, int netnumber)
{
  pBITLISTITEM bitlistitem;
  
  //Get memory for the bit list item for this bit
  bitlistitem = malloc(sizeof(BITLISTITEM));

  bitlistitem->xinumber = xinumber;
  bitlistitem->mcnumber = mcnumber;
  bitlistitem->netnumber = netnumber;

  bitlistitem->count = 1;
  bitlistitem->name = name;

  return(bitlistitem);
}

//----------------------------------------------------------------------------------------------------------------------------------

void addtotoplist(pCONFIGBITDATA bitdata)
{
  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;
  
  int xinumber = -1;
  int mcnumber = -1;
  int netnumber = -1;
  
  char *xiname;
  char *mcname;
  char *netname;

  //Only bits with TOP. in the name need to be added
  if(strncmp(bitdata->name, "TOP.", 4) == 0)
  {
    //Get the numbers
    xiname = strstr(bitdata->name, "XI");
    mcname = strstr(bitdata->name, "MC");
    netname = strstr(bitdata->name, "NET");

    xinumber = atoi(&xiname[2]);
    
    if(mcname)
    {
      mcnumber = atoi(&mcname[2]);
    }

    if(netname)
    {
      netnumber = atoi(&netname[3]);
    }
    
    //Add this bit in the top list when it is the first item
    if(toplist == 0)
    {
      //Get memory for the bit list item for this bit
      bitlistitem = makebitlistitem(bitdata->name, xinumber, mcnumber, netnumber);

      //First item in the list, so no previous and next
      bitlistitem->prev = 0;
      bitlistitem->next = 0;

      //Set it as the first item of the list
      toplist = bitlistitem;
    }
    else
    {
      //Get the first list item
      bitlist = toplist;
      
      //Look for where the data needs to be inserted or a count needs to be updated
      while(bitlist)
      {
        //Insert if the xi number is smaller
        if(xinumber < bitlist->xinumber)
        {
          //Get memory for the bit list item for this bit
          bitlistitem = makebitlistitem(bitdata->name, xinumber, mcnumber, netnumber);
          
          //Insert the item before the current one
          insertitembeforetoplist(bitlist, bitlistitem);
          break;
        }
        
        //Check on the mc number if the xi number is the same
        if(xinumber == bitlist->xinumber)
        {
          //Check if the mc number is used
          if(mcnumber != -1)
          {
            if(mcnumber < bitlist->mcnumber)
            {
              //Get memory for the bit list item for this bit
              bitlistitem = makebitlistitem(bitdata->name, xinumber, mcnumber, netnumber);

              //Insert the item before the current one
              insertitembeforetoplist(bitlist, bitlistitem);
              break;
            }

            //If both are the same increment the count
            if(mcnumber == bitlist->mcnumber)
            {
              bitlist->count++;
              break;
            }
          }
          else if(netnumber != -1)
          {
            if(netnumber < bitlist->netnumber)
            {
              //Get memory for the bit list item for this bit
              bitlistitem = makebitlistitem(bitdata->name, xinumber, mcnumber, netnumber);

              //Insert the item before the current one
              insertitembeforetoplist(bitlist, bitlistitem);
              break;
            }

            //If both are the same increment the count
            if(netnumber == bitlist->netnumber)
            {
              bitlist->count++;
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
          //Get memory for the bit list item for this bit
          bitlistitem = makebitlistitem(bitdata->name, xinumber, mcnumber, netnumber);

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
  int index;
  int bit;

  pCONFIGBITDATA bitdata;

  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;

  pBITDATA bititemdata;
  
  //Step through the bit data pointer objects
  for(index=0;index<(sizeof(bitdatapointers)/sizeof(BITDATAPOINTERS));index++)
  {
    //Process all the bits in the current object
    for(bit=0;bit<bitdatapointers[index].count;bit++)
    {
      addtotoplist(&bitdatapointers[index].data[bit]);
    }
  }
  
  FILE *fo = fopen("top_route_names_list.csv", "w");

  if(fo)
  {
    fprintf(fo, "Name,,count\n");

    //Get the first list item
    bitlist = toplist;

    while(bitlist)
    {
      //Output the current bit to the file
      fprintf(fo, "%s,,%d\n", bitlist->name, bitlist->count);

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
#endif

//----------------------------------------------------------------------------------------------------------------------------------

#if 0
// Make xi only list
void insertitembeforetoplist(pBITLISTITEM current, pBITLISTITEM new)
{
  //Do an insert
  //Check if current is the first item of the list
  if(current->prev == 0)
  {
    //If so make the new one the first item in the list, so no previous
    new->prev = 0;
    new->next = current;

    //Set the back track connection
    current->prev = new;

    //Set it as the first item of the list
    toplist = new;
  }
  else
  {
    //Insert it in the list
    //Link the new item to the current item
    new->prev = current->prev;
    current->prev->next = new;

    //Link the item to insert before to the new item
    new->next = current;
    current->prev = new;
  }
}

//----------------------------------------------------------------------------------------------------------------------------------

pBITLISTITEM makebitlistitem(char *name, int xinumber, int mcnumber, int netnumber)
{
  pBITLISTITEM bitlistitem;
  
  //Get memory for the bit list item for this bit
  bitlistitem = malloc(sizeof(BITLISTITEM));

  bitlistitem->xinumber = xinumber;
  bitlistitem->mcnumber = mcnumber;
  bitlistitem->netnumber = netnumber;

  bitlistitem->count = 1;
  bitlistitem->name = name;

  return(bitlistitem);
}

//----------------------------------------------------------------------------------------------------------------------------------

void addtotoplist(pCONFIGBITDATA bitdata)
{
  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;
  
  int xinumber = -1;
  
  char *xiname;

  //Only bits with TOP. in the name need to be added
  if(strncmp(bitdata->name, "TOP.", 4) == 0)
  {
    //Get the numbers
    xiname = strstr(bitdata->name, "XI");

    xinumber = atoi(&xiname[2]);
    
    //Add this bit in the top list when it is the first item
    if(toplist == 0)
    {
      //Get memory for the bit list item for this bit
      bitlistitem = makebitlistitem(bitdata->name, xinumber, 0, 0);

      //First item in the list, so no previous and next
      bitlistitem->prev = 0;
      bitlistitem->next = 0;

      //Set it as the first item of the list
      toplist = bitlistitem;
    }
    else
    {
      //Get the first list item
      bitlist = toplist;
      
      //Look for where the data needs to be inserted or a count needs to be updated
      while(bitlist)
      {
        //Insert if the xi number is smaller
        if(xinumber < bitlist->xinumber)
        {
          //Get memory for the bit list item for this bit
          bitlistitem = makebitlistitem(bitdata->name, xinumber, 0, 0);
          
          //Insert the item before the current one
          insertitembeforetoplist(bitlist, bitlistitem);
          break;
        }
        
        //Check on the mc number if the xi number is the same
        if(xinumber == bitlist->xinumber)
        {
          bitlist->count++;
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
          //Get memory for the bit list item for this bit
          bitlistitem = makebitlistitem(bitdata->name, xinumber, 0, 0);

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
  int index;
  int bit;

  pCONFIGBITDATA bitdata;

  pBITLISTITEM bitlist;
  pBITLISTITEM bitlistitem;

  pBITDATA bititemdata;
  
  //Step through the bit data pointer objects
  for(index=0;index<(sizeof(bitdatapointers)/sizeof(BITDATAPOINTERS));index++)
  {
    //Process all the bits in the current object
    for(bit=0;bit<bitdatapointers[index].count;bit++)
    {
      addtotoplist(&bitdatapointers[index].data[bit]);
    }
  }
  
  FILE *fo = fopen("top_xi_names_list.csv", "w");

  if(fo)
  {
    fprintf(fo, "Name,count\n");

    //Get the first list item
    bitlist = toplist;

    while(bitlist)
    {
      //Output the current bit to the file
      fprintf(fo, "%s,%d\n", bitlist->name, bitlist->count);

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
#endif

//----------------------------------------------------------------------------------------------------------------------------------
