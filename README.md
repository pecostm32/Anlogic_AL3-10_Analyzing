# Anlogic_AL3-10_Analyzing
An attempt to reverse engineer a bitstream made for an AL3-10 FPGA

As part of the FNIRSI-1013D reverse engineering / hacking an attempt is made to reverse engineer the existing FPGA programming.

Despite the lack of information a lot is achieved. The mmicko/prjtang project was a big help but not enough to get to a full reversal.

At first the converting of the bitstream to a readable meaning of the bits failed on unused bits being at the beginning instead of the end. Took quite a bit of analyzing and trying with some test designs to figure this out.

The project stranded for now on the routing of the nets because the naming is unclear. To some extend it is possible to track some connections but the interconnect between the tiles is a mystery.

To preserve all the work this repository is created.

There are several C projects used to manipulate the database data to allow for analyzing the bit stream data.

The project to create a visual bitmap and a listing of the configuration bits is: Anlogic_bitstream_analyzer

At first it was needed to convert the Anlogic database file for the AL3-10 to json. For this the prjtang python tools were used. One problem in that is that the X and Y coordinates in the bit description files are swapped. I corrected this in my Anlogic_database_converter project. This creates a C version of the data. This makes processing much faster.

mmicko updated prjtang recently and the database decode tool now uses frame and bit instead of the y and x. My code has not been modified for this!!!!!

Based on this data I created a convertion table to map the configuration bits to their actual meaning. This is done in the Anlogic_bits_in_tile_lister.

Some other support porjects were made to allow analyzing of the database date. These are also included. Also added is my python work project with which I decoded the Tang Dynasty IDE work files. I'm new to python at this point so the code is not great, but it served it's purpose.

Maybe in time, when more knowledge is gathered, a return is made to the project.

-------------------------------------------------------------------------------------------------------------------------------
07-08-2022

Started the project up again after gaining some new insight in how the routing works.

-------------------------------------------------------------------------------------------------------------------------------
18-08-2022

Managed to create a meaningful net list of both FPGA's (1013D and 1014D) including naming the signals of the pins.
But this is a very low level net list that needs a lot of interpretation to get to some verilog write up.

First action will be the making of a .adc file which holds the pin constraints used in the Tang Dynasty IDE,
and maybe a top level verilog file with the signal names of the pins.

A drawing of gate level schematics might be a useful tool in reverse engineering to usable verilog. So I might look into that.

-------------------------------------------------------------------------------------------------------------------------------
05-09-2022

Made good progress. The code of the netlist tracer now generates named block diagrams of each connected block. This gives insight in which blocks belong to which part of the design.

I still need to get more insight in the global clock system to get an understanding about how the design is clocked. This means deeper investigation of property bits.

Getting back to a verilog description of the design will require a lot of manual labour. Not a big deal since it is a one of task.

-------------------------------------------------------------------------------------------------------------------------------
25-09-2022

The code is able to generate gate level verilog for a simple design with 2 and 3 input logic and registers.

Need to verify things like logic equations being properly generated and also have to implement the 1, 4, 5, and 6 input LUT macros.

Once these are done and verified things like adders need to be implemented. Other macros to do are PLL and embedded memory.
Also have to fix some things concerning the global clocks.

Still a lot of work to be done.

-------------------------------------------------------------------------------------------------------------------------------
10-10-2022

Had a break but now back on the project. Without documentation it is very time consuming to work out what all the setting bits
for the logic slices do, and what type of gate level macros to generate for specific settings. The approach of making test designs
in the IDE and then create the gate level verilog only got me so far, because the IDE does not always deliver the wanted setup.
For instance a LUT6 is devided up into multiple smaller LUT's in different slices, instead of using the combined LUT's in a single
slice.

So I'm now analyzing the FNIRSI-1013D bit stream on what settings are present and try to create the needed macros based on it.
For know I'm focusing on the mslice, which is simpler but also has its quirks.

-------------------------------------------------------------------------------------------------------------------------------
15-10-2022

Managed to get complete gate level verilog generated for the 1013D bit stream, but when compiled in the IDE the new bit stream
is different and a test in the scope showed it not working, so still some problems to solve.

-------------------------------------------------------------------------------------------------------------------------------
28-10-2022

The code is now generating higher level verilog but needs improvements to order the output such that declares are near the top
of the file.

It is also needed to make something that merges signals into buses where that is needed. For instance the MCU databus interface
or the memory address buses.

Still no output that compiles back into the original bit stream or at least something that works in the scope.

-------------------------------------------------------------------------------------------------------------------------------
05-11-2022

Made resonable progress. The generated verilog has some problems, but a lot of the communication with the MCU works.
It is possible to set the channel input relays and the display brightness can be controlled.
One problem is that the sampling reset bit does not work like the original.

Working on renaming all the nets to get a clear insight in what things do. For this simulation is also used.

-------------------------------------------------------------------------------------------------------------------------------
10-11-2022

Finaly succeded in reverse engineering the bit stream into working verilog. I missed two setting bits to set the reset level for
mslice0 and lslice2, which caused some parts of the verilog to not work. Investigation of the I2C part that is in the verilog
I discovered this problem. Simulation of the verilog helps a lot in getting an understanding of it.

-------------------------------------------------------------------------------------------------------------------------------
19-11-2022

Made a more readable version of the design, but it does not work on the scope. There are problems with the 200MHz clock timing.
Oddly enough the crude design generated with the reverse engineering tool does not have these problems and works on the scope
to some extend. There are some problems with glitches in the samples.

But the journey has come to its end. It proved to be possible to reverse engineer the design of a FPGA from it's bit stream.
Granted it is not perfect, and there are still issues when compiling it back into a bit stream due to compiler version,
timing constraints, differences in place and route.

Conclusion is that it requires a lot of patience, skill and persistence to get a thing like this done.

It was fun and I learned a lot from it about the working of FPGA's and simulation.
