//----------------------------------------------------------------------------------------------------------------------------------

#include "configbitdata.h"

//----------------------------------------------------------------------------------------------------------------------------------

char *AH_MC1_DIV2_EXPR_0[1] = 
{
  "A",
};

char *AH_MC1_DIV2_RPN_0[1] = 
{
  "A",
};

BITDATA AH_MC1_DIV2_DATA_0[1] = 
{
  {
  "A",
    "MEMORY(CLKDIV,DIV,1)",
  },
};

char *AH_MC1_DIV_EN_EXPR_1[1] = 
{
  "A",
};

char *AH_MC1_DIV_EN_RPN_1[1] = 
{
  "A",
};

BITDATA AH_MC1_DIV_EN_DATA_1[1] = 
{
  {
  "A",
    "COMP(CLKDIV)",
  },
};

char *AH_MC1_DIV_SRC_EXPR_2[1] = 
{
  "A",
};

char *AH_MC1_DIV_SRC_RPN_2[1] = 
{
  "A",
};

BITDATA AH_MC1_DIV_SRC_DATA_2[1] = 
{
  {
  "A",
    "ARCVAL(CLKDIVMUX8OUT,CLKDIVMUX8IN1)",
  },
};

char *AH_MC1_GSRN_DIS_EXPR_3[1] = 
{
  "A",
};

char *AH_MC1_GSRN_DIS_RPN_3[1] = 
{
  "A",
};

BITDATA AH_MC1_GSRN_DIS_DATA_3[1] = 
{
  {
  "A",
    "PROPERTY(CLKDIV.GSR,DISABLE)",
  },
};

char *AH_MC1_SEL_5_EXPR_4[1] = 
{
  "FALSE",
};

char *AH_MC1_SEL_5_RPN_4[1] = 
{
  "FALSE",
};

BITDATA AH_MC1_SEL_5_DATA_4[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AH_MC1_SEL_4_EXPR_5[1] = 
{
  "FALSE",
};

char *AH_MC1_SEL_4_RPN_5[1] = 
{
  "FALSE",
};

BITDATA AH_MC1_SEL_4_DATA_5[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AH_MC1_SEL_3_EXPR_6[1] = 
{
  "FALSE",
};

char *AH_MC1_SEL_3_RPN_6[1] = 
{
  "FALSE",
};

BITDATA AH_MC1_SEL_3_DATA_6[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AH_MC1_SEL_2_EXPR_7[1] = 
{
  "FALSE",
};

char *AH_MC1_SEL_2_RPN_7[1] = 
{
  "FALSE",
};

BITDATA AH_MC1_SEL_2_DATA_7[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AH_MC1_SEL_1_EXPR_8[1] = 
{
  "FALSE",
};

char *AH_MC1_SEL_1_RPN_8[1] = 
{
  "FALSE",
};

BITDATA AH_MC1_SEL_1_DATA_8[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AH_MC1_SEL_0_EXPR_9[1] = 
{
  "FALSE",
};

char *AH_MC1_SEL_0_RPN_9[1] = 
{
  "FALSE",
};

BITDATA AH_MC1_SEL_0_DATA_9[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AH_MC1_SLCL_N_1_EXPR_10[1] = 
{
  "FALSE",
};

char *AH_MC1_SLCL_N_1_RPN_10[1] = 
{
  "FALSE",
};

BITDATA AH_MC1_SLCL_N_1_DATA_10[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AH_MC1_SLCL_N_0_EXPR_11[1] = 
{
  "FALSE",
};

char *AH_MC1_SLCL_N_0_RPN_11[1] = 
{
  "FALSE",
};

BITDATA AH_MC1_SLCL_N_0_DATA_11[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AH_MC1_STOP_1_EXPR_12[1] = 
{
  "FALSE",
};

char *AH_MC1_STOP_1_RPN_12[1] = 
{
  "FALSE",
};

BITDATA AH_MC1_STOP_1_DATA_12[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AH_MC1_STOP_0_EXPR_13[1] = 
{
  "FALSE",
};

char *AH_MC1_STOP_0_RPN_13[1] = 
{
  "FALSE",
};

BITDATA AH_MC1_STOP_0_DATA_13[1] = 
{
  {
  "A",
    "FALSE",
  },
};

//----------------------------------------------------------------------------------------------------------------------------------

CONFIGBITDATA clkdiv_bk8_Data[14] =
{
  {
    "MC1_DIV2",
    "MISCS_MIC_IO_T",
    2,
    38,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_DIV2_EXPR_0,
    1,
    AH_MC1_DIV2_RPN_0,
    1,
    AH_MC1_DIV2_DATA_0,
  },
  {
    "MC1_DIV_EN",
    "MISCS_MIC_IO_T",
    0,
    45,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_DIV_EN_EXPR_1,
    1,
    AH_MC1_DIV_EN_RPN_1,
    1,
    AH_MC1_DIV_EN_DATA_1,
  },
  {
    "MC1_DIV_SRC",
    "MISCS_MIC_IO_T",
    2,
    39,
    0,
    0,
    1,
    1,
    0,
    1,
    1,
    AH_MC1_DIV_SRC_EXPR_2,
    1,
    AH_MC1_DIV_SRC_RPN_2,
    1,
    AH_MC1_DIV_SRC_DATA_2,
  },
  {
    "MC1_GSRN_DIS",
    "MISCS_MIC_IO_T",
    2,
    36,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_GSRN_DIS_EXPR_3,
    1,
    AH_MC1_GSRN_DIS_RPN_3,
    1,
    AH_MC1_GSRN_DIS_DATA_3,
  },
  {
    "MC1_SEL_5",
    "MISCS_MIC_IO_T",
    3,
    37,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_SEL_5_EXPR_4,
    1,
    AH_MC1_SEL_5_RPN_4,
    1,
    AH_MC1_SEL_5_DATA_4,
  },
  {
    "MC1_SEL_4",
    "MISCS_MIC_IO_T",
    2,
    41,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_SEL_4_EXPR_5,
    1,
    AH_MC1_SEL_4_RPN_5,
    1,
    AH_MC1_SEL_4_DATA_5,
  },
  {
    "MC1_SEL_3",
    "MISCS_MIC_IO_T",
    2,
    37,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_SEL_3_EXPR_6,
    1,
    AH_MC1_SEL_3_RPN_6,
    1,
    AH_MC1_SEL_3_DATA_6,
  },
  {
    "MC1_SEL_2",
    "MISCS_MIC_IO_T",
    0,
    44,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_SEL_2_EXPR_7,
    1,
    AH_MC1_SEL_2_RPN_7,
    1,
    AH_MC1_SEL_2_DATA_7,
  },
  {
    "MC1_SEL_1",
    "MISCS_MIC_IO_T",
    0,
    42,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_SEL_1_EXPR_8,
    1,
    AH_MC1_SEL_1_RPN_8,
    1,
    AH_MC1_SEL_1_DATA_8,
  },
  {
    "MC1_SEL_0",
    "MISCS_MIC_IO_T",
    0,
    46,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_SEL_0_EXPR_9,
    1,
    AH_MC1_SEL_0_RPN_9,
    1,
    AH_MC1_SEL_0_DATA_9,
  },
  {
    "MC1_SLCL_N_1",
    "MISCS_MIC_IO_T",
    2,
    40,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_SLCL_N_1_EXPR_10,
    1,
    AH_MC1_SLCL_N_1_RPN_10,
    1,
    AH_MC1_SLCL_N_1_DATA_10,
  },
  {
    "MC1_SLCL_N_0",
    "MISCS_MIC_IO_T",
    0,
    47,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_SLCL_N_0_EXPR_11,
    1,
    AH_MC1_SLCL_N_0_RPN_11,
    1,
    AH_MC1_SLCL_N_0_DATA_11,
  },
  {
    "MC1_STOP_1",
    "MISCS_MIC_IO_T",
    1,
    36,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_STOP_1_EXPR_12,
    1,
    AH_MC1_STOP_1_RPN_12,
    1,
    AH_MC1_STOP_1_DATA_12,
  },
  {
    "MC1_STOP_0",
    "MISCS_MIC_IO_T",
    0,
    43,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AH_MC1_STOP_0_EXPR_13,
    1,
    AH_MC1_STOP_0_RPN_13,
    1,
    AH_MC1_STOP_0_DATA_13,
  },
};

//----------------------------------------------------------------------------------------------------------------------------------

