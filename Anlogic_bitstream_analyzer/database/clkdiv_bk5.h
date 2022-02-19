//----------------------------------------------------------------------------------------------------------------------------------

#include "configbitdata.h"

//----------------------------------------------------------------------------------------------------------------------------------

char *AE_MC1_DIV2_EXPR_0[1] = 
{
  "A",
};

char *AE_MC1_DIV2_RPN_0[1] = 
{
  "A",
};

BITDATA AE_MC1_DIV2_DATA_0[1] = 
{
  {
  "A",
    "MEMORY(CLKDIV,DIV,1)",
  },
};

char *AE_MC1_DIV_EN_EXPR_1[1] = 
{
  "A",
};

char *AE_MC1_DIV_EN_RPN_1[1] = 
{
  "A",
};

BITDATA AE_MC1_DIV_EN_DATA_1[1] = 
{
  {
  "A",
    "COMP(CLKDIV)",
  },
};

char *AE_MC1_DIV_SRC_EXPR_2[1] = 
{
  "A",
};

char *AE_MC1_DIV_SRC_RPN_2[1] = 
{
  "A",
};

BITDATA AE_MC1_DIV_SRC_DATA_2[1] = 
{
  {
  "A",
    "ARCVAL(CLKDIVMUX5OUT,CLKDIVMUX5IN1)",
  },
};

char *AE_MC1_GSRN_DIS_EXPR_3[1] = 
{
  "A",
};

char *AE_MC1_GSRN_DIS_RPN_3[1] = 
{
  "A",
};

BITDATA AE_MC1_GSRN_DIS_DATA_3[1] = 
{
  {
  "A",
    "PROPERTY(CLKDIV.GSR,DISABLE)",
  },
};

char *AE_MC1_SEL_5_EXPR_4[1] = 
{
  "FALSE",
};

char *AE_MC1_SEL_5_RPN_4[1] = 
{
  "FALSE",
};

BITDATA AE_MC1_SEL_5_DATA_4[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AE_MC1_SEL_4_EXPR_5[1] = 
{
  "FALSE",
};

char *AE_MC1_SEL_4_RPN_5[1] = 
{
  "FALSE",
};

BITDATA AE_MC1_SEL_4_DATA_5[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AE_MC1_SEL_3_EXPR_6[1] = 
{
  "FALSE",
};

char *AE_MC1_SEL_3_RPN_6[1] = 
{
  "FALSE",
};

BITDATA AE_MC1_SEL_3_DATA_6[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AE_MC1_SEL_2_EXPR_7[1] = 
{
  "FALSE",
};

char *AE_MC1_SEL_2_RPN_7[1] = 
{
  "FALSE",
};

BITDATA AE_MC1_SEL_2_DATA_7[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AE_MC1_SEL_1_EXPR_8[1] = 
{
  "FALSE",
};

char *AE_MC1_SEL_1_RPN_8[1] = 
{
  "FALSE",
};

BITDATA AE_MC1_SEL_1_DATA_8[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AE_MC1_SEL_0_EXPR_9[1] = 
{
  "FALSE",
};

char *AE_MC1_SEL_0_RPN_9[1] = 
{
  "FALSE",
};

BITDATA AE_MC1_SEL_0_DATA_9[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AE_MC1_SLCL_N_1_EXPR_10[1] = 
{
  "FALSE",
};

char *AE_MC1_SLCL_N_1_RPN_10[1] = 
{
  "FALSE",
};

BITDATA AE_MC1_SLCL_N_1_DATA_10[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AE_MC1_SLCL_N_0_EXPR_11[1] = 
{
  "FALSE",
};

char *AE_MC1_SLCL_N_0_RPN_11[1] = 
{
  "FALSE",
};

BITDATA AE_MC1_SLCL_N_0_DATA_11[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AE_MC1_STOP_1_EXPR_12[1] = 
{
  "FALSE",
};

char *AE_MC1_STOP_1_RPN_12[1] = 
{
  "FALSE",
};

BITDATA AE_MC1_STOP_1_DATA_12[1] = 
{
  {
  "A",
    "FALSE",
  },
};

char *AE_MC1_STOP_0_EXPR_13[1] = 
{
  "FALSE",
};

char *AE_MC1_STOP_0_RPN_13[1] = 
{
  "FALSE",
};

BITDATA AE_MC1_STOP_0_DATA_13[1] = 
{
  {
  "A",
    "FALSE",
  },
};

//----------------------------------------------------------------------------------------------------------------------------------

CONFIGBITDATA clkdiv_bk5_Data[14] =
{
  {
    "MC1_DIV2",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    34,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_DIV2_EXPR_0,
    1,
    AE_MC1_DIV2_RPN_0,
    1,
    AE_MC1_DIV2_DATA_0,
  },
  {
    "MC1_DIV_EN",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    39,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_DIV_EN_EXPR_1,
    1,
    AE_MC1_DIV_EN_RPN_1,
    1,
    AE_MC1_DIV_EN_DATA_1,
  },
  {
    "MC1_DIV_SRC",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    50,
    0,
    0,
    1,
    1,
    0,
    1,
    1,
    AE_MC1_DIV_SRC_EXPR_2,
    1,
    AE_MC1_DIV_SRC_RPN_2,
    1,
    AE_MC1_DIV_SRC_DATA_2,
  },
  {
    "MC1_GSRN_DIS",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    36,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_GSRN_DIS_EXPR_3,
    1,
    AE_MC1_GSRN_DIS_RPN_3,
    1,
    AE_MC1_GSRN_DIS_DATA_3,
  },
  {
    "MC1_SEL_5",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    44,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_SEL_5_EXPR_4,
    1,
    AE_MC1_SEL_5_RPN_4,
    1,
    AE_MC1_SEL_5_DATA_4,
  },
  {
    "MC1_SEL_4",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    51,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_SEL_4_EXPR_5,
    1,
    AE_MC1_SEL_4_RPN_5,
    1,
    AE_MC1_SEL_4_DATA_5,
  },
  {
    "MC1_SEL_3",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    49,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_SEL_3_EXPR_6,
    1,
    AE_MC1_SEL_3_RPN_6,
    1,
    AE_MC1_SEL_3_DATA_6,
  },
  {
    "MC1_SEL_2",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    42,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_SEL_2_EXPR_7,
    1,
    AE_MC1_SEL_2_RPN_7,
    1,
    AE_MC1_SEL_2_DATA_7,
  },
  {
    "MC1_SEL_1",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    47,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_SEL_1_EXPR_8,
    1,
    AE_MC1_SEL_1_RPN_8,
    1,
    AE_MC1_SEL_1_DATA_8,
  },
  {
    "MC1_SEL_0",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    48,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_SEL_0_EXPR_9,
    1,
    AE_MC1_SEL_0_RPN_9,
    1,
    AE_MC1_SEL_0_DATA_9,
  },
  {
    "MC1_SLCL_N_1",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    53,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_SLCL_N_1_EXPR_10,
    1,
    AE_MC1_SLCL_N_1_RPN_10,
    1,
    AE_MC1_SLCL_N_1_DATA_10,
  },
  {
    "MC1_SLCL_N_0",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    45,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_SLCL_N_0_EXPR_11,
    1,
    AE_MC1_SLCL_N_0_RPN_11,
    1,
    AE_MC1_SLCL_N_0_DATA_11,
  },
  {
    "MC1_STOP_1",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    52,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_STOP_1_EXPR_12,
    1,
    AE_MC1_STOP_1_RPN_12,
    1,
    AE_MC1_STOP_1_DATA_12,
  },
  {
    "MC1_STOP_0",
    "MISCS_MIC_IO_LR_CORNER_UR",
    0,
    40,
    0,
    0,
    0,
    1,
    0,
    1,
    1,
    AE_MC1_STOP_0_EXPR_13,
    1,
    AE_MC1_STOP_0_RPN_13,
    1,
    AE_MC1_STOP_0_DATA_13,
  },
};

//----------------------------------------------------------------------------------------------------------------------------------

