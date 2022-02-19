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
