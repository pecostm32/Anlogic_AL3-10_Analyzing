`timescale 100 ps / 100 ps

module fnirsi_1013D_tb;

  wire calib_1KHz;
  wire o_pwm_display;

  reg clock_200MHz = 0;

  reg direction = 0;

  reg mcu_dcs = 1;
  reg mcu_rws = 1;
  reg mcu_clk = 0;
  reg [7:0] i_mcu_data = 0;

  reg [7:0] i_adc1A = 8'h0;
  reg [7:0] i_adc1B = 8'h0;
  reg [7:0] i_adc2A = 8'h0;
  reg [7:0] i_adc2B = 8'h0;

  wire [7:0] io_mcu_data;

  reg [15:0] data_count = 1500;

  assign io_mcu_data = mcu_rws ? i_mcu_data : 8'bz;

  task fpga_write_command(input [7:0] command);
    begin
      #50 mcu_dcs = 1;           //Setup for command
      #50 mcu_rws = 1;           //write
      #50 i_mcu_data = command;
      #50 mcu_clk = 1;           //Clock it in
      #50 mcu_clk = 0;
    end
  endtask

  task fpga_write_byte(input [7:0] data);
    begin
      #50 mcu_dcs = 0;           //Setup for data
      #50 mcu_rws = 1;           //write
      #50 i_mcu_data = data;
      #50 mcu_clk = 1;           //Clock it in
      #50 mcu_clk = 0;
    end
  endtask

  task fpga_write_short(input [15:0] data);
    begin
      #50 mcu_dcs = 0;           //Setup for data
      #50 mcu_rws = 1;           //write
      #50 i_mcu_data = data[15:8];
      #50 mcu_clk = 1;           //Clock it in
      #50 mcu_clk = 0;
      #50 i_mcu_data = data[7:0];
      #50 mcu_clk = 1;           //Clock it in
      #50 mcu_clk = 0;
    end
  endtask

  task fpga_write_int(input [31:0] data);
    begin
      #50 mcu_dcs = 0;           //Setup for data
      #50 mcu_rws = 1;           //write
      #50 i_mcu_data = data[31:24];
      #50 mcu_clk = 1;           //Clock it in
      #50 mcu_clk = 0;
      #50 i_mcu_data = data[23:16];
      #50 mcu_clk = 1;           //Clock it in
      #50 mcu_clk = 0;
      #50 i_mcu_data = data[15:8];
      #50 mcu_clk = 1;           //Clock it in
      #50 mcu_clk = 0;
      #50 i_mcu_data = data[7:0];
      #50 mcu_clk = 1;           //Clock it in
      #50 mcu_clk = 0;
    end
  endtask

  task fpga_read_byte();
    begin
      #50 mcu_dcs = 0;           //Setup for data
      #50 mcu_rws = 0;           //Read
      #200 mcu_clk = 1;          //Clock it out
      #50 mcu_clk = 0;
    end
  endtask

  task fpga_read_short();
    begin
      #50 mcu_dcs = 0;           //Setup for data
      #50 mcu_rws = 0;           //Read
      #200 mcu_clk = 1;          //Clock it out
      #50 mcu_clk = 0;
      #200 mcu_clk = 1;          //Clock it out
      #50 mcu_clk = 0;
    end
  endtask


  fnirsi_1013D fnirsi_test
  (
    .i_xtal    (clock_200MHz),
    .i_mcu_rws (mcu_rws),
    .i_mcu_dcs (mcu_dcs),
    .i_mcu_clk (mcu_clk),

    .io_mcu_data (io_mcu_data),

    .i_adc1A_d (i_adc1A),
    .i_adc1B_d (i_adc1B),
    .i_adc2A_d (i_adc2A),
    .i_adc2B_d (i_adc2B),

    .o_1khz_calib (calib_1KHz)
  );

  always
    #25 clock_200MHz = !clock_200MHz;

  always
   begin
     #750
     if(direction == 0)
       i_adc1A = i_adc1A + 1;
     else
       i_adc1A = i_adc1A - 1;

     if((i_adc1A == 255) & (direction == 0))
       direction = 1;
     else if((i_adc1A == 0) & (direction == 1))
       direction = 0;
   end


  initial
    begin
     #200 fpga_write_command(8'h0E);   //Time base
      #100 fpga_write_int(411100);

      #200 fpga_write_command(8'h16);   //Trigger edge
      #100 fpga_write_byte(0);
      
      #200 fpga_write_command(8'h17);   //Trigger level
      #100 fpga_write_byte(25);

      #200 fpga_write_command(8'h1A);   //Trigger mode
      #100 fpga_write_byte(0);

      #200 fpga_write_command(8'h0F);   //Trigger enable??
      #100 fpga_write_byte(0);

      #200 fpga_write_command(8'h28);   //Sampling mode
      #100 fpga_write_byte(0);


      //Sampling reset
      #200 fpga_write_command(8'h01);
      #100 fpga_write_byte(1);          //Reset stage

      #2000 fpga_write_command(8'h05);
      #100  fpga_read_byte();

      #2000 fpga_write_command(8'h01);
      #100 fpga_write_byte(0);          //Run stage




      //Sampling reset
      #500000 fpga_write_command(8'h01);
      #100 fpga_write_byte(1);          //Reset stage

      #2000 fpga_write_command(8'h05);
      #100  fpga_read_byte();

      #2000 fpga_write_command(8'h01);
      #100 fpga_write_byte(0);          //Run stage


      #2000 fpga_write_command(8'h0A);

      while (io_mcu_data[0] == 0)
        begin
          #100  fpga_read_byte();
        end

/*
      #200 fpga_write_command(8'h33);
      #100 fpga_write_byte(0);

      #200 fpga_write_byte(1);
      #200 fpga_write_byte(2);
      #200 fpga_write_byte(3);
      #200 fpga_write_byte(4);
      #200 fpga_write_byte(6);
      #200 fpga_write_byte(7);
      #200 fpga_write_byte(5);


      #200 fpga_write_command(8'h06);
      #100 fpga_read_short();
*/
//      #200 fpga_write_command(8'h32);
//      #100 fpga_write_short(1900);

//      #200 fpga_write_command(8'h3C);
//      #100 fpga_write_short(16'h8150);

//      #200 fpga_write_command(8'h41);
//      #100 fpga_read_short();


//      #200 fpga_write_command(8'h0D);
//      #100 fpga_write_int(39);

/*
//Sampling reset
      #200 fpga_write_command(8'h01);
      #100 fpga_write_byte(1);

      #2000 fpga_write_command(8'h05);
      #100  fpga_read_byte();

      #400  fpga_read_byte();
      #400  fpga_read_byte();

      #2000 fpga_write_command(8'h01);
      #100 fpga_write_byte(0);

      #2000 fpga_write_command(8'h05);
      #100  fpga_read_byte();

      #400  fpga_read_byte();
      #400  fpga_read_byte();
*/
    end

endmodule
