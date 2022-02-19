//----------------------------------------------------------------------------------------------------------------------------------

#ifndef CONFIGBITDATA_H
#define CONFIGBITDATA_H

//----------------------------------------------------------------------------------------------------------------------------------

typedef struct tagTileGridData     TILEGRIDDATA,     *pTILEGRIDDATA;
typedef struct tagTileSites        TILESITES,        *pTILESITES;
typedef struct tagConfigBitData    CONFIGBITDATA,    *pCONFIGBITDATA;
typedef struct tagBitData          BITDATA,          *pBITDATA;
typedef struct tagFRAMEBITMAPPING  FRAMEBITMAPPING,  *pFRAMEBITMAPPING; 

//----------------------------------------------------------------------------------------------------------------------------------

struct tagTileGridData
{
  char *name;
  char *type;
  int   x;
  int   y;
  int   xoff;
  int   rows;
  int   columns;
  int   flag;
  int   startframe;
  int   startbit;
  int   sitecount;

  pTILESITES sites;
};

struct tagTileSites
{
  char *name;
  char *type;
};


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

struct tagFRAMEBITMAPPING
{
  pTILEGRIDDATA  tile;
  pCONFIGBITDATA bit;
};

//----------------------------------------------------------------------------------------------------------------------------------

#endif   //CONFIGBITDATA_H

//----------------------------------------------------------------------------------------------------------------------------------

