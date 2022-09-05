//----------------------------------------------------------------------------------------------------------------------------------

#ifndef BLOCK_SCHEMATIC_DEFINITIONS_H
#define BLOCK_SCHEMATIC_DEFINITIONS_H

//----------------------------------------------------------------------------------------------------------------------------------

#define BUS_BASED_BLOCKS    0

//----------------------------------------------------------------------------------------------------------------------------------

typedef struct tagSchematicBlock    SCHEMATICBLOCK,  *pSCHEMATICBLOCK;
typedef struct tagSchematicPort     SCHEMATICPORT,   *pSCHEMATICPORT;

//----------------------------------------------------------------------------------------------------------------------------------

//For direction 0 is reset to top left, 1 is step left, 2 is reset to top right, 3 is step right
//Repeat is to expand a bus signal into separate named items. 0 no repeat, just a single item. >=1 repeat the signal and add _x to the name

struct tagSchematicPort
{
  int direction;
  int length;
  int repeat;
  int step;
  
  char  *displayname;
};
  
struct tagSchematicBlock
{
  int width;
  int height;
  
  char *name;
  
  SCHEMATICPORT ports[];
};

SCHEMATICBLOCK pad = 
{
  90,
  131,
  "PAD",
  {
    { 0, 20, 0, 15, "ts"       },
    { 1, 20, 0, 15, "ocomp"    },
    { 1, 20, 0, 15, "otrue"    },

    { 1, 20, 0, 20, "enir_dyn" },

    { 1, 20, 0, 20, "ce"       },
    { 1, 20, 0, 15, "rst"      },
    { 1, 20, 0, 15, "clk"      },

    { 2, 20, 0, 15, "di"        },
    { 3, 20, 0, 15, "icomp"     },
    { 3, 20, 0, 15, "itrue"     },

    { 3, 20, 0, 40, "ipad"     },
    { 3, 20, 0, 15, "opad"     },
    { 3, 20, 0, 15, "bpad"     },
    { 0,  0, 0,  0, 0          },
  }
};

SCHEMATICBLOCK mslice = 
{
  120,
  336,
  "MSLICE",
  {
    { 0, 20, 2, 15, "a" },
    { 1, 20, 2, 15, "b" },
    { 1, 20, 2, 15, "c" },
    { 1, 20, 2, 15, "d" },

    { 1, 20, 2, 20, "mi" },

    { 1, 20, 0, 20, "ce" },
    { 1, 20, 0, 15, "sr" },
    { 1, 20, 0, 15, "clk" },
      
    { 1, 20, 0, 20, "fci" },
      
    { 1, 20, 2, 20, "dpram_di" },
    { 1, 20, 0, 15, "dpram_mode" },
    { 1, 20, 4, 15, "dpram_waddr" },
    { 1, 20, 0, 15, "dpram_wclk" },
    { 1, 20, 0, 15, "dpram_we" },

    { 2, 20, 2,  15, "f" },
    { 3, 20, 2,  15, "fx" },
    { 3, 20, 2,  15, "q" },

    { 3, 20, 0,  20, "fco" },
    { 0,  0, 0,   0, 0 },
  }
};

SCHEMATICBLOCK lslice = 
{
  120,
  361,
  "LSLICE",
  {
    { 0, 20, 2, 15, "a" },
    { 1, 20, 2, 15, "b" },
    { 1, 20, 2, 15, "c" },
    { 1, 20, 2, 15, "d" },
    { 1, 20, 2, 15, "e" },

    { 1, 20, 2, 20, "mi" },
      
    { 1, 20, 0, 20, "ce" },
    { 1, 20, 0, 15, "sr" },
    { 1, 20, 0, 15, "clk" },
      
    { 1, 20, 0, 20, "fci" },
      
    { 1, 20, 2, 20, "dpram_di" },
    { 1, 20, 0, 15, "dpram_mode" },
    { 1, 20, 4, 15, "dpram_waddr" },
    { 1, 20, 0, 15, "dpram_wclk" },
    { 1, 20, 0, 15, "dpram_we" },

    { 2, 20, 2,  15, "f" },
    { 3, 20, 2,  15, "fx" },
    { 3, 20, 2,  15, "q" },

    { 3, 20, 0,  20, "fco" },
    { 0,  0, 0,   0, 0 },
  }
};

SCHEMATICBLOCK emb = 
{
  120,
  701,
  "EMB",
  {
    { 0, 20,  9, 15, "dia" },
    { 1, 20, 13, 15, "addra" },
    { 1, 20,  3, 15, "csa" },
    { 1, 20,  0, 15, "cea" },
    { 1, 20,  0, 15, "oea" },
    { 1, 20,  0, 15, "wea" },
    { 1, 20,  0, 15, "rsta" },
    { 1, 20,  0, 15, "clka" },
      
    { 1, 20,  9, 20, "dib" },
    { 1, 20, 13, 15, "addrb" },
    { 1, 20,  3, 15, "csb" },
    { 1, 20,  0, 15, "ceb" },
    { 1, 20,  0, 15, "oeb" },
    { 1, 20,  0, 15, "web" },
    { 1, 20,  0, 15, "rstb" },
    { 1, 20,  0, 15, "clkb" },
      
    { 2, 20,  9, 15, "doa" },
      
    { 3, 20,  9, 265, "dob" },
    { 0,  0,  0,   0, 0 },
  }
};

SCHEMATICBLOCK pll = 
{
  150,
  326,
  "PLL",
  {
    { 0, 20, 0, 15, "en_pll2io" },
    { 1, 20, 5, 15, "enclkc" },
    { 1, 20, 0, 15, "fbclk_8" },
    { 1, 20, 0, 15, "load_reg" },
    { 1, 20, 0, 15, "phasestep" },
    { 1, 20, 0, 15, "phaseupdown" },
    { 1, 20, 3, 15, "phcntsel" },
    { 1, 20, 5, 15, "pib_input" },
    { 1, 20, 0, 15, "pllreset" },
    { 1, 20, 0, 15, "refclk_10" },
    { 1, 20, 0, 15, "refclk_11" },
    { 1, 20, 0, 15, "scanclk" },
    { 1, 20, 0, 15, "stdby" },
    { 1, 20, 0, 15, "wakeup_sync" },
      
    { 2, 20, 5, 15, "clkc" },
    { 3, 20, 0, 15, "dyn_status" },
    { 3, 20, 0, 15, "ext_lock" },
    { 3, 20, 0, 15, "int_lock" },
    { 3, 20, 0, 15, "phasedone" },
    { 3, 20, 0, 15, "refmuxclk" },
    { 3, 20, 0, 15, "mfgouta"  },
    { 3, 20, 0, 15, "mfgoutb"  },
    { 0,  0, 0,   0, 0          },
  }
};

SCHEMATICBLOCK gclk_ctmux = 
{
  80,
  171,
  "GCLK_CTMUX",
  {
    { 0, 20, 6, 15, "pib_s" },
    { 1, 20, 6, 15, "pib_z" },
    { 1, 20, 2, 15, "pibclk" },
    { 0,  0, 0,  0, 0 },
  }
};

SCHEMATICBLOCK gclk_premux = 
{
  80,
  146,
  "GCLK_PREMUX",
  {
    { 0, 20, 8, 15, "ce" },
    { 1, 20, 4, 15, "pibclk" },
    { 0,  0, 0,  0, 0 },
  }
};

//----------------------------------------------------------------------------------------------------------------------------------

#endif /* BLOCK_SCHEMATIC_DEFINITIONS_H */

//----------------------------------------------------------------------------------------------------------------------------------

