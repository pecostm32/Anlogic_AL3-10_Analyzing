//----------------------------------------------------------------------------------------------------------------------------------

#include "configbitdata.h"

//----------------------------------------------------------------------------------------------------------------------------------

#define osc_COUNT 1

//----------------------------------------------------------------------------------------------------------------------------------

char *BO_MC1_PIB_CTRL_OSC_EXPR_0[1] = 
{
  "A",
};

char *BO_MC1_PIB_CTRL_OSC_RPN_0[1] = 
{
  "A",
};

BITDATA BO_MC1_PIB_CTRL_OSC_DATA_0[1] = 
{
  {
  "A",
    "PROPERTY(OSC.STDBY,ENABLE)",
  },
};

//----------------------------------------------------------------------------------------------------------------------------------

CONFIGBITDATA osc_Data[1] =
{
  {
    "MC1_PIB_CTRL_OSC",
    "MISCS_MIC_IO_L",
    1,
    1,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    BO_MC1_PIB_CTRL_OSC_EXPR_0,
    1,
    BO_MC1_PIB_CTRL_OSC_RPN_0,
    1,
    BO_MC1_PIB_CTRL_OSC_DATA_0,
  },
};

//----------------------------------------------------------------------------------------------------------------------------------

