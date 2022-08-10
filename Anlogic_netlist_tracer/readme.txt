This is a copy of the bitstream analyzer where a lot of the code has been removed.

It does not create the bitmap, bits list, io bits list or the route bits list anymore.

The intention is to extend the code to create a proper netlist from the routing bits.
The first version does not find the one to many nets that can exist, but I found how they are setup,
so can adapt the code for it.

An output from a block can have multiple connections in the tile all based on bit pairs.
The first step is to make a list of these and then trace down the connections to the inputs of blocks.
This should result in a list with a single output connected to one or more inputs.

Another issue is the global clock nets for which investigation is needed.

Slowly it will come together as more knowledge is gained.
