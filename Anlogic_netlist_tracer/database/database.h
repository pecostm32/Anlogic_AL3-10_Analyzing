//----------------------------------------------------------------------------------------------------------------------------------

#ifndef DATABASE_H
#define DATABASE_H

//----------------------------------------------------------------------------------------------------------------------------------

#include "configbitdata.h"

//----------------------------------------------------------------------------------------------------------------------------------

#define TILEGRIDCOUNT 1602

#define clkdiv_bk1_COUNT 14
#define clkdiv_bk2_COUNT 14
#define clkdiv_bk3_COUNT 14
#define clkdiv_bk4_COUNT 14
#define clkdiv_bk5_COUNT 14
#define clkdiv_bk6_COUNT 14
#define clkdiv_bk7_COUNT 14
#define clkdiv_bk8_COUNT 14
#define emb32k_b0_COUNT 37
#define emb32k_b1_COUNT 37
#define emb_slice_COUNT 1116
#define gclk_csb_COUNT 58
#define gclk_ctmux_l_COUNT 113
#define gclk_ctmux_u_COUNT 113
#define gclk_premux_b_COUNT 36
#define gclk_premux_l_COUNT 36
#define gclk_premux_r_COUNT 36
#define gclk_premux_t_COUNT 36
#define gclk_spine_COUNT 32
#define ioclk_bk1_COUNT 14
#define ioclk_bk2_COUNT 14
#define ioclk_bk3_COUNT 14
#define ioclk_bk4_COUNT 14
#define ioclk_bk5_COUNT 14
#define ioclk_bk6_COUNT 14
#define ioclk_bk7_COUNT 14
#define ioclk_bk8_COUNT 14
#define iol_pair_l_COUNT 130
#define iol_pair_r_COUNT 130
#define iol_quad_b_COUNT 260
#define iol_quad_l_COUNT 260
#define iol_quad_r_COUNT 260
#define iol_quad_t_COUNT 260
#define ios_bankref_bl_COUNT 15
#define ios_bankref_br_COUNT 15
#define ios_bankref_l_COUNT 29
#define ios_bankref_r_COUNT 29
#define ios_bankref_tl_COUNT 15
#define ios_bankref_tr_COUNT 15
#define mult_COUNT 37
#define osc_COUNT 1
#define pib_COUNT 1458
#define plb_COUNT 1674
#define pll0_COUNT 247
#define pll2_COUNT 247
//----------------------------------------------------------------------------------------------------------------------------------

extern TILEGRIDDATA TileGridData[1602];

extern CONFIGBITDATA clkdiv_bk1_Data[14];
extern CONFIGBITDATA clkdiv_bk2_Data[14];
extern CONFIGBITDATA clkdiv_bk3_Data[14];
extern CONFIGBITDATA clkdiv_bk4_Data[14];
extern CONFIGBITDATA clkdiv_bk5_Data[14];
extern CONFIGBITDATA clkdiv_bk6_Data[14];
extern CONFIGBITDATA clkdiv_bk7_Data[14];
extern CONFIGBITDATA clkdiv_bk8_Data[14];

extern CONFIGBITDATA emb32k_b0_Data[37];
extern CONFIGBITDATA emb32k_b1_Data[37];

extern CONFIGBITDATA emb_slice_Data[1116];

extern CONFIGBITDATA gclk_csb_Data[58];

extern CONFIGBITDATA gclk_ctmux_l_Data[113];
extern CONFIGBITDATA gclk_ctmux_u_Data[113];

extern CONFIGBITDATA gclk_premux_b_Data[36];
extern CONFIGBITDATA gclk_premux_l_Data[36];
extern CONFIGBITDATA gclk_premux_r_Data[36];
extern CONFIGBITDATA gclk_premux_t_Data[36];

extern CONFIGBITDATA gclk_spine_Data[32];

extern CONFIGBITDATA ioclk_bk1_Data[14];
extern CONFIGBITDATA ioclk_bk2_Data[14];
extern CONFIGBITDATA ioclk_bk3_Data[14];
extern CONFIGBITDATA ioclk_bk4_Data[14];
extern CONFIGBITDATA ioclk_bk5_Data[14];
extern CONFIGBITDATA ioclk_bk6_Data[14];
extern CONFIGBITDATA ioclk_bk7_Data[14];
extern CONFIGBITDATA ioclk_bk8_Data[14];

extern CONFIGBITDATA iol_pair_l_Data[130];
extern CONFIGBITDATA iol_pair_r_Data[130];

extern CONFIGBITDATA iol_quad_b_Data[260];
extern CONFIGBITDATA iol_quad_l_Data[260];
extern CONFIGBITDATA iol_quad_r_Data[260];
extern CONFIGBITDATA iol_quad_t_Data[260];

extern CONFIGBITDATA ios_bankref_bl_Data[15];
extern CONFIGBITDATA ios_bankref_br_Data[15];
extern CONFIGBITDATA ios_bankref_l_Data[29];
extern CONFIGBITDATA ios_bankref_r_Data[29];
extern CONFIGBITDATA ios_bankref_tl_Data[15];
extern CONFIGBITDATA ios_bankref_tr_Data[15];

extern CONFIGBITDATA mult_Data[37];
extern CONFIGBITDATA osc_Data[1];
extern CONFIGBITDATA pib_Data[1458];
extern CONFIGBITDATA plb_Data[1674];
extern CONFIGBITDATA pll0_Data[247];
extern CONFIGBITDATA pll2_Data[247];

//----------------------------------------------------------------------------------------------------------------------------------

#endif //DATABASE_H

//----------------------------------------------------------------------------------------------------------------------------------

