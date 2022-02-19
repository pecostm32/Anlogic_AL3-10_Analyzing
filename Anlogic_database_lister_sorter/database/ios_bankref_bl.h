//----------------------------------------------------------------------------------------------------------------------------------

#include "configbitdata.h"

//----------------------------------------------------------------------------------------------------------------------------------

#define ios_bankref_bl_COUNT 15

//----------------------------------------------------------------------------------------------------------------------------------

char *BH_MC12_INR_ON_EXPR_0[1] = 
{
  "A",
};

char *BH_MC12_INR_ON_RPN_0[1] = 
{
  "A",
};

BITDATA BH_MC12_INR_ON_DATA_0[1] = 
{
  {
  "A",
    "PROPERTY(BANKREF.INR,ON)",
  },
};

char *BH_MC12_STDBY_INR_EXPR_1[1] = 
{
  "A",
};

char *BH_MC12_STDBY_INR_RPN_1[1] = 
{
  "A",
};

BITDATA BH_MC12_STDBY_INR_DATA_1[1] = 
{
  {
  "A",
    "PROPERTY(BANKREF.INR_STDBY,ENABLE)",
  },
};

char *BH_MC12_ENVR0_1_EXPR_2[3] = 
{
  "A",
  "+",
  "B",
};

char *BH_MC12_ENVR0_1_RPN_2[3] = 
{
  "A",
  "B",
  "+",
};

BITDATA BH_MC12_ENVR0_1_DATA_2[2] = 
{
  {
  "A",
    "PROPERTY(BANKREF.VREF1_VALUE,HIGH)",
  },
  {
  "B",
    "PROPERTY(BANKERF.VREF1_VALUE,MID)",
  },
};

char *BH_MC12_ENVR0_0_EXPR_3[3] = 
{
  "A",
  "+",
  "B",
};

char *BH_MC12_ENVR0_0_RPN_3[3] = 
{
  "A",
  "B",
  "+",
};

BITDATA BH_MC12_ENVR0_0_DATA_3[2] = 
{
  {
  "A",
    "PROPERTY(BANKREF.VREF1_VALUE,HIGH)",
  },
  {
  "B",
    "PROPERTY(BANKERF.VREF1_VALUE,LOW)",
  },
};

char *BH_MC12_ENVR1_1_EXPR_4[3] = 
{
  "A",
  "+",
  "B",
};

char *BH_MC12_ENVR1_1_RPN_4[3] = 
{
  "A",
  "B",
  "+",
};

BITDATA BH_MC12_ENVR1_1_DATA_4[2] = 
{
  {
  "A",
    "PROPERTY(BANKREF.VREF2_VALUE,HIGH)",
  },
  {
  "B",
    "PROPERTY(BANKERF.VREF2_VALUE,MID)",
  },
};

char *BH_MC12_ENVR1_0_EXPR_5[3] = 
{
  "A",
  "+",
  "B",
};

char *BH_MC12_ENVR1_0_RPN_5[3] = 
{
  "A",
  "B",
  "+",
};

BITDATA BH_MC12_ENVR1_0_DATA_5[2] = 
{
  {
  "A",
    "PROPERTY(BANKREF.VREF2_VALUE,HIGH)",
  },
  {
  "B",
    "PROPERTY(BANKERF.VREF2_VALUE,LOW)",
  },
};

char *BH_MC12_VRPD_N_1_EXPR_6[1] = 
{
  "A",
};

char *BH_MC12_VRPD_N_1_RPN_6[1] = 
{
  "A",
};

BITDATA BH_MC12_VRPD_N_1_DATA_6[1] = 
{
  {
  "A",
    "PROPERTY(BANKREF.VREF2,ENABLE)",
  },
};

char *BH_MC12_VRPD_N_0_EXPR_7[1] = 
{
  "A",
};

char *BH_MC12_VRPD_N_0_RPN_7[1] = 
{
  "A",
};

BITDATA BH_MC12_VRPD_N_0_DATA_7[1] = 
{
  {
  "A",
    "PROPERTY(BANKREF.VREF1,ENABLE)",
  },
};

char *BH_MC12_PU_1_EXPR_8[1] = 
{
  "FALSE",
};

char *BH_MC12_PU_1_RPN_8[1] = 
{
  "FALSE",
};

BITDATA BH_MC12_PU_1_DATA_8[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *BH_MC12_PU_0_EXPR_9[1] = 
{
  "FALSE",
};

char *BH_MC12_PU_0_RPN_9[1] = 
{
  "FALSE",
};

BITDATA BH_MC12_PU_0_DATA_9[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *BH_MC12_PD_1_EXPR_10[1] = 
{
  "FALSE",
};

char *BH_MC12_PD_1_RPN_10[1] = 
{
  "FALSE",
};

BITDATA BH_MC12_PD_1_DATA_10[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *BH_MC12_PD_0_EXPR_11[1] = 
{
  "FALSE",
};

char *BH_MC12_PD_0_RPN_11[1] = 
{
  "FALSE",
};

BITDATA BH_MC12_PD_0_DATA_11[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *BH_MC12_RDSEL_2_EXPR_12[7] = 
{
  "A",
  "+",
  "B",
  "+",
  "C",
  "+",
  "D",
};

char *BH_MC12_RDSEL_2_RPN_12[7] = 
{
  "A",
  "B",
  "+",
  "C",
  "+",
  "D",
  "+",
};

BITDATA BH_MC12_RDSEL_2_DATA_12[4] = 
{
  {
  "A",
    "PROPERTY(BANKREF.DIFFRESISTOR,90)",
  },
  {
  "B",
    "PROPERTY(BANKREF.DIFFRESISTOR,80)",
  },
  {
  "C",
    "PROPERTY(BANKREF.DIFFRESISTOR,70)",
  },
  {
  "D",
    "PROPERTY(BANKREF.DIFFRESISTOR,60)",
  },
};

char *BH_MC12_RDSEL_1_EXPR_13[7] = 
{
  "A",
  "+",
  "B",
  "+",
  "C",
  "+",
  "D",
};

char *BH_MC12_RDSEL_1_RPN_13[7] = 
{
  "A",
  "B",
  "+",
  "C",
  "+",
  "D",
  "+",
};

BITDATA BH_MC12_RDSEL_1_DATA_13[4] = 
{
  {
  "A",
    "PROPERTY(BANKREF.DIFFRESISTOR,100)",
  },
  {
  "B",
    "PROPERTY(BANKREF.DIFFRESISTOR,110)",
  },
  {
  "C",
    "PROPERTY(BANKREF.DIFFRESISTOR,70)",
  },
  {
  "D",
    "PROPERTY(BANKREF.DIFFRESISTOR,60)",
  },
};

char *BH_MC12_RDSEL_0_EXPR_14[7] = 
{
  "A",
  "+",
  "B",
  "+",
  "C",
  "+",
  "D",
};

char *BH_MC12_RDSEL_0_RPN_14[7] = 
{
  "A",
  "B",
  "+",
  "C",
  "+",
  "D",
  "+",
};

BITDATA BH_MC12_RDSEL_0_DATA_14[4] = 
{
  {
  "A",
    "PROPERTY(BANKREF.DIFFRESISTOR,100)",
  },
  {
  "B",
    "PROPERTY(BANKREF.DIFFRESISTOR,120)",
  },
  {
  "C",
    "PROPERTY(BANKREF.DIFFRESISTOR,80)",
  },
  {
  "D",
    "PROPERTY(BANKREF.DIFFRESISTOR,60)",
  },
};

//----------------------------------------------------------------------------------------------------------------------------------

CONFIGBITDATA ios_bankref_bl_Data[15] =
{
  {
    "MC12_INR_ON",
    "MISCS_MIC_IO_B",
    2,
    41,
    4,
    0,
    0,
    1,
    0,
    1,
    1,
    BH_MC12_INR_ON_EXPR_0,
    1,
    BH_MC12_INR_ON_RPN_0,
    1,
    BH_MC12_INR_ON_DATA_0,
  },
  {
    "MC12_STDBY_INR",
    "MISCS_MIC_IO_B",
    2,
    43,
    4,
    0,
    0,
    1,
    0,
    1,
    1,
    BH_MC12_STDBY_INR_EXPR_1,
    1,
    BH_MC12_STDBY_INR_RPN_1,
    1,
    BH_MC12_STDBY_INR_DATA_1,
  },
  {
    "MC12_ENVR0_1",
    "MISCS_MIC_IO_B",
    2,
    37,
    4,
    0,
    0,
    1,
    0,
    2,
    3,
    BH_MC12_ENVR0_1_EXPR_2,
    3,
    BH_MC12_ENVR0_1_RPN_2,
    2,
    BH_MC12_ENVR0_1_DATA_2,
  },
  {
    "MC12_ENVR0_0",
    "MISCS_MIC_IO_B",
    2,
    39,
    4,
    0,
    0,
    1,
    0,
    2,
    3,
    BH_MC12_ENVR0_0_EXPR_3,
    3,
    BH_MC12_ENVR0_0_RPN_3,
    2,
    BH_MC12_ENVR0_0_DATA_3,
  },
  {
    "MC12_ENVR1_1",
    "MISCS_MIC_IO_B",
    1,
    42,
    4,
    0,
    0,
    1,
    0,
    2,
    3,
    BH_MC12_ENVR1_1_EXPR_4,
    3,
    BH_MC12_ENVR1_1_RPN_4,
    2,
    BH_MC12_ENVR1_1_DATA_4,
  },
  {
    "MC12_ENVR1_0",
    "MISCS_MIC_IO_B",
    2,
    35,
    4,
    0,
    0,
    1,
    0,
    2,
    3,
    BH_MC12_ENVR1_0_EXPR_5,
    3,
    BH_MC12_ENVR1_0_RPN_5,
    2,
    BH_MC12_ENVR1_0_DATA_5,
  },
  {
    "MC12_VRPD_N_1",
    "MISCS_MIC_IO_B",
    1,
    35,
    4,
    0,
    0,
    1,
    0,
    1,
    1,
    BH_MC12_VRPD_N_1_EXPR_6,
    1,
    BH_MC12_VRPD_N_1_RPN_6,
    1,
    BH_MC12_VRPD_N_1_DATA_6,
  },
  {
    "MC12_VRPD_N_0",
    "MISCS_MIC_IO_B",
    1,
    37,
    4,
    0,
    0,
    1,
    0,
    1,
    1,
    BH_MC12_VRPD_N_0_EXPR_7,
    1,
    BH_MC12_VRPD_N_0_RPN_7,
    1,
    BH_MC12_VRPD_N_0_DATA_7,
  },
  {
    "MC12_PU_1",
    "MISCS_MIC_IO_B",
    1,
    38,
    4,
    0,
    0,
    1,
    0,
    1,
    1,
    BH_MC12_PU_1_EXPR_8,
    1,
    BH_MC12_PU_1_RPN_8,
    1,
    BH_MC12_PU_1_DATA_8,
  },
  {
    "MC12_PU_0",
    "MISCS_MIC_IO_B",
    1,
    40,
    4,
    0,
    0,
    1,
    0,
    1,
    1,
    BH_MC12_PU_0_EXPR_9,
    1,
    BH_MC12_PU_0_RPN_9,
    1,
    BH_MC12_PU_0_DATA_9,
  },
  {
    "MC12_PD_1",
    "MISCS_MIC_IO_B",
    1,
    43,
    4,
    0,
    0,
    1,
    0,
    1,
    1,
    BH_MC12_PD_1_EXPR_10,
    1,
    BH_MC12_PD_1_RPN_10,
    1,
    BH_MC12_PD_1_DATA_10,
  },
  {
    "MC12_PD_0",
    "MISCS_MIC_IO_B",
    1,
    36,
    4,
    0,
    0,
    1,
    0,
    1,
    1,
    BH_MC12_PD_0_EXPR_11,
    1,
    BH_MC12_PD_0_RPN_11,
    1,
    BH_MC12_PD_0_DATA_11,
  },
  {
    "MC12_RDSEL_2",
    "MISCS_MIC_IO_B",
    1,
    39,
    4,
    0,
    0,
    1,
    0,
    4,
    7,
    BH_MC12_RDSEL_2_EXPR_12,
    7,
    BH_MC12_RDSEL_2_RPN_12,
    4,
    BH_MC12_RDSEL_2_DATA_12,
  },
  {
    "MC12_RDSEL_1",
    "MISCS_MIC_IO_B",
    1,
    41,
    4,
    0,
    0,
    1,
    0,
    4,
    7,
    BH_MC12_RDSEL_1_EXPR_13,
    7,
    BH_MC12_RDSEL_1_RPN_13,
    4,
    BH_MC12_RDSEL_1_DATA_13,
  },
  {
    "MC12_RDSEL_0",
    "MISCS_MIC_IO_B",
    1,
    34,
    4,
    0,
    0,
    1,
    0,
    4,
    7,
    BH_MC12_RDSEL_0_EXPR_14,
    7,
    BH_MC12_RDSEL_0_RPN_14,
    4,
    BH_MC12_RDSEL_0_DATA_14,
  },
};

//----------------------------------------------------------------------------------------------------------------------------------

