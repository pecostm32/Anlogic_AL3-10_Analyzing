//----------------------------------------------------------------------------------------------------------------------------------

#ifndef CONFIGBITDATA_H
#define CONFIGBITDATA_H

//----------------------------------------------------------------------------------------------------------------------------------

typedef struct tagConfigBitData  CONFIGBITDATA, *pCONFIGBITDATA;
typedef struct tagBitData        BITDATA,       *pBITDATA;

struct tagConfigBitData
{
  char    *name;
  char    *type;
  int      x;
  int      y;
  int      xoff;
  int      yoff;
  int      map_wire_arc;
  int      remap;
  int      pll_info;
  int      cnt;
  
  int      exprcount;
  char   **expr;

  int     rpncount;
  char   **rpn;

  int      datacount;
  pBITDATA bitdata;
};

struct tagBitData
{
  char *item;
  char *data;
};

//----------------------------------------------------------------------------------------------------------------------------------

#endif   //CONFIGBITDATA_H

//----------------------------------------------------------------------------------------------------------------------------------

