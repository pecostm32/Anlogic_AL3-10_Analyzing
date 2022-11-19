module FNIRSI_1013D
(
  input wire i_xtal,
  input wire i_mcu_rws,
  input wire i_mcu_dcs,
  input wire i_mcu_clk,
  output wire o_i2c_scl,
  inout wire io_i2c_sda,
  inout wire io_mcu_d_4,
  inout wire io_mcu_d_5,
  inout wire io_mcu_d_6,
  inout wire io_mcu_d_7,
  output wire o_pwm_display,
  inout wire io_mcu_d_2,
  inout wire io_mcu_d_3,
  inout wire io_mcu_d_1,
  inout wire io_mcu_d_0,
  output wire o_1khz_calib,
  output wire o_ac_dc_2,
  output wire o_adc1_encB,
  output wire o_ac_dc_1,
  output wire o_relay2_1,
  input wire i_adc1A_d_6,
  input wire i_adc1A_d_7,
  output wire o_relay2_2,
  output wire o_relay2_3,
  output wire o_relay1_3,
  input wire i_adc1A_d_5,
  output wire o_relay1_2,
  input wire i_adc1A_d_3,
  input wire i_adc1A_d_4,
  output wire o_relay1_1,
  input wire i_adc1A_d_0,
  input wire i_adc1B_d_0,
  input wire i_adc1A_d_1,
  input wire i_adc1A_d_2,
  input wire i_adc1B_d_2,
  input wire i_adc1B_d_1,
  output wire o_offset_1,
  input wire i_adc1B_d_5,
  input wire i_adc1B_d_4,
  input wire i_adc1B_d_3,
  output wire o_adc2_encA,
  output wire o_offset_2,
  input wire i_adc1B_d_7,
  input wire i_adc1B_d_6,
  output wire o_adc1_encA,
  output wire o_adc2_encB,
  input wire i_adc2A_d_6,
  input wire i_adc2A_d_7,
  input wire i_adc2A_d_5,
  input wire i_adc2A_d_4,
  input wire i_adc2A_d_3,
  input wire i_adc2A_d_2,
  input wire i_adc2A_d_0,
  input wire i_adc2A_d_1,
  input wire i_adc2B_d_1,
  input wire i_adc2B_d_0,
  input wire i_adc2B_d_2,
  input wire i_adc2B_d_4,
  input wire i_adc2B_d_3,
  input wire i_adc2B_d_6,
  input wire i_adc2B_d_5,
  input wire i_adc2B_d_7
);

//---------------------------------------------------------------------------
//Wire declarations

  wire sample_read_clock;
  wire read_addr_10;
  wire sig_54_lut_0;
  wire sig_54_lut_1;
  wire read_adc1B_b2;
  wire read_adc2A_b7;
  wire read_adc2A_h_b7;
  wire sig_56_lut_0;
  wire sig_56_lut_1;
  wire sig_56_ff0_d;
  wire read_adc2A_h_b2;
  wire read_adc2A_h_b4;
  wire read_adc2A_b3;
  wire read_adc2A_h_b3;
  wire cur_vs_lev_h;
  wire cur_vs_lev_i;
  wire read_adc2B_b0;
  wire read_adc2B_l_b0;
  wire sig_61_lut_0;
  wire sig_61_lut_1;
  wire read_adc2A_b2;
  wire read_adc2B_b2;
  wire read_adc2B_l_b2;
  wire read_addr_3;
  wire read_addr_0;
  wire read_addr_9;
  wire net_50;
  wire net_62;
  wire net_63;
  wire read_adc1B_l_b2;
  wire read_adc2A_h_b0;
  wire read_adc2A_b1;
  wire read_adc2A_h_b1;
  wire read_adc1B_l_b5;
  wire read_adc2A_h_b6;
  wire sig_134_lut_0;
  wire sig_134_lut_1;
  wire cmd21_adc1B_h_b1;
  wire sig_135_lut_0;
  wire sig_135_lut_1;
  wire read_adc1B_b5;
  wire prev_vs_lev_g;
  wire prev_vs_lev_d;
  wire sig_137_lut_0;
  wire sig_137_lut_1;
  wire sig_137_ff0_d;
  wire sig_138_lut_0;
  wire sig_138_lut_1;
  wire sig_138_ff0_d;
  wire sig_139_lut_0;
  wire sig_139_lut_1;
  wire read_adc2A_b4;
  wire trigger_rise_detect;
  wire trigger_rise_enable;
  wire read_adc2A_b5;
  wire read_adc2A_h_b5;
  wire sig_142_lut_0;
  wire sig_142_lut_1;
  wire read_adc2A_b6;
  wire sampling_enable;
  wire trigger_check_enable;
  wire cmd38_enable0;
  wire net_175;
  wire cmdxxxxxx11_select;
  wire cmd23_select;
  wire cmd1A_enable;
  wire cmd1x_data_write;
  wire cmd35_enable1;
  wire net_180;
  wire cmd0F_enable;
  wire cmd6B_select;
  wire cmd001000xx_select;
  wire cmdxxxx01xx_select;
  wire net_195;
  wire net_198;
  wire net_204;
  wire net_205;
  wire net_209;
  wire net_210;
  wire net_214;
  wire net_216;
  wire offset2_pwm_rst;
  wire net_212;
  wire sig_162_lut_0;
  wire sig_162_lut_1;
  wire net_213;
  wire sig_163_lut_0;
  wire sig_163_lut_1;
  wire net_218;
  wire net_220;
  wire net_221;
  wire net_224;
  wire net_223;
  wire read_adc1B_b7;
  wire read_adc1B_l_b7;
  wire read_adc1B_b4;
  wire read_adc1B_l_b4;
  wire sig_172_lut_0;
  wire sig_172_lut_1;
  wire cmd21_adc1B_l_b1;
  wire sig_173_lut_0;
  wire sig_173_lut_1;
  wire read_adc2A_b0;
  wire sig_174_lut_0;
  wire sig_174_lut_1;
  wire read_adc1B_b3;
  wire net_234;
  wire prev_vs_lev_h;
  wire prev_vs_lev_e;
  wire prev_vs_lev_c;
  wire prev_vs_lev_k;
  wire prev_vs_lev_f;
  wire prev_vs_lev_l;
  wire prev_vs_lev_m;
  wire sig_179_lut_0;
  wire sig_179_lut_1;
  wire sig_179_ff0_d;
  wire cur_vs_lev_e;
  wire cur_vs_lev_f;
  wire cur_vs_lev_g;
  wire cur_vs_lev_l;
  wire sig_182_lut_0;
  wire prev_less_equal_lev;
  wire trigger_fall_detect;
  wire sig_183_lut_1;
  wire net_252;
  wire read_adc2B_l_b1;
  wire cmd22_adc2A_b6;
  wire trigger_data_b6;
  wire sig_186_lut_0;
  wire sig_186_lut_1;
  wire trigger_fall_enable;
  wire cmd22_adc2A_b2;
  wire cmd21_22_adc1B_2A_b2;
  wire cmd01_enable;
  wire cmd21_select;
  wire cmd35_select;
  wire net_268;
  wire sig_190_lut_0;
  wire sig_190_lut_1;
  wire cmd38_select;
  wire cmdxxxx0001_select;
  wire cmd0001x000_select;
  wire sig_192_lut_0;
  wire sig_192_lut_1;
  wire cmd32_select;
  wire sig_193_lut_0;
  wire sig_193_lut_1;
  wire cmd6D_select;
  wire net_273;
  wire net_272;
  wire sig_195_lut_0;
  wire sig_195_lut_1;
  wire cmd6C_select;
  wire net_278;
  wire cmd3C_enable0;
  wire net_284;
  wire cmd3C_enable1;
  wire net_283;
  wire net_281;
  wire sig_199_lut_0;
  wire sig_199_lut_1;
  wire cmd0D_select;
  wire sig_200_lut_0;
  wire sig_200_lut_1;
  wire cmd1F_enable1;
  wire read_addr_8;
  wire read_addr_1;
  wire cmd35_enable0;
  wire net_295;
  wire net_310;
  wire net_309;
  wire net_304;
  wire net_305;
  wire read_addr_7;
  wire read_addr_2;
  wire net_308;
  wire net_298;
  wire sig_207_lut_0;
  wire sig_207_lut_1;
  wire sig_207_ff0_d;
  wire net_313;
  wire net_311;
  wire sig_209_lut_0;
  wire sig_209_lut_1;
  wire sig_209_ff0_d;
  wire read_adc1B_l_b3;
  wire read_adc1A_h_b7;
  wire sig_215_lut_0;
  wire sig_215_lut_1;
  wire read_adc1B_b6;
  wire db_match_i;
  wire db_match_j;
  wire prev_vs_lev_j;
  wire prev_vs_lev_a;
  wire sig_218_lut_0;
  wire sig_218_lut_1;
  wire sig_218_ff0_d;
  wire sig_219_lut_0;
  wire sig_219_lut_1;
  wire sig_219_ff0_d;
  wire cur_vs_lev_a;
  wire cur_vs_lev_j;
  wire cur_vs_lev_d;
  wire cur_vs_lev_k;
  wire sig_222_lut_0;
  wire sig_222_lut_1;
  wire sig_222_ff0_d;
  wire sig_223_lut_0;
  wire sig_223_lut_1;
  wire sig_223_ff0_d;
  wire trigger_data_b2;
  wire cur_vs_lev_b;
  wire cmd17_enable;
  wire cur_vs_lev_c;
  wire net_340;
  wire trigger_data_b4;
  wire db_match_p;
  wire db_match_o;
  wire sig_228_lut_0;
  wire net_349;
  wire cmd22_adc2A_b1;
  wire cmd22_adc2A_b7;
  wire cmd21_23_adc1B_2B_b5;
  wire cmd23_adc2B_b0;
  wire sig_231_lut_0;
  wire sig_231_lut_1;
  wire cmd6E_select;
  wire net_355;
  wire net_354;
  wire sig_233_lut_0;
  wire sig_233_lut_1;
  wire cmd6A_select;
  wire sig_234_lut_0;
  wire net_360;
  wire sig_235_lut_0;
  wire sig_235_lut_1;
  wire sig_235_ff0_d;
  wire sig_236_lut_0;
  wire sig_236_lut_1;
  wire cmd3C_select;
  wire sig_237_lut_0;
  wire sig_237_lut_1;
  wire cmd_0D_0E_select;
  wire net_364;
  wire net_366;
  wire sig_239_lut_0;
  wire net_367;
  wire sig_240_lut_0;
  wire sig_240_lut_1;
  wire sig_240_ff0_d;
  wire read_addr_5;
  wire net_374;
  wire net_368;
  wire net_372;
  wire read_addr_4;
  wire net_370;
  wire read_addr_6;
  wire net_375;
  wire sig_245_lut_0;
  wire sig_245_lut_1;
  wire net_381;
  wire smp_read_offset_c11, smp_read_offset_c10, smp_read_offset_c9, smp_read_offset_c8, smp_read_offset_c7, smp_read_offset_c6, smp_read_offset_c5, smp_read_offset_c4, smp_read_offset_c3, smp_read_offset_c2, smp_read_offset_c1, smp_read_offset_c0;
  wire sig_247_lut_0;
  wire sig_247_lut_1;
  wire cmd0E_enable1;
  wire net_389;
  wire sig_251_lut_0;
  wire sig_251_lut_1;
  wire sig_252_lut_0;
  wire sig_252_lut_1;
  wire sig_257_lut_0;
  wire sig_257_lut_1;
  wire sig_257_ff0_d;
  wire db_match_k;
  wire db_match_l;
  wire sig_263_lut_0;
  wire sig_263_lut_1;
  wire read_adc1A_b7;
  wire db_match_b;
  wire db_match_c;
  wire db_match_d;
  wire db_match_e;
  wire sig_266_lut_0;
  wire sig_266_lut_1;
  wire read_adc1A_b3;
  wire db_match_m;
  wire db_match_n;
  wire sig_268_lut_0;
  wire sig_268_lut_1;
  wire prev_vs_lev_i;
  wire net_425;
  wire trigger_data_b0;
  wire trigger_data_b3;
  wire trigger_data_b7;
  wire read_adc2B_h_b1;
  wire net_426;
  wire cmd15_enable;
  wire trigger_data_b1;
  wire net_431;
  wire cmd65_select;
  wire net_433;
  wire net_435;
  wire sig_275_lut_0;
  wire net_434;
  wire sig_276_lut_0;
  wire sig_276_lut_1;
  wire cmd68_select;
  wire sig_277_lut_0;
  wire sig_277_lut_1;
  wire cmd69_select;
  wire cmd24_select;
  wire cmd27_select;
  wire sig_279_lut_0;
  wire sig_279_lut_1;
  wire sig_279_ff0_d;
  wire db_match_f;
  wire cmd0x_select;
  wire cmd41_select;
  wire cmd6x_select;
  wire net_446;
  wire net_451;
  wire cmd2x_select;
  wire cmd3x_select;
  wire cmd16_enable;
  wire cmd36_enable;
  wire net_460;
  wire net_459;
  wire sig_286_lut_0;
  wire net_461;
  wire cmd38_enable1;
  wire db_match_a;
  wire sig_288_lut_0;
  wire net_470;
  wire cmd37_enable;
  wire cmd67_select;
  wire cmd1F_enable0;
  wire cmd_6F_1F_select;
  wire cmd14_select;
  wire not_cmd_41_14_06;
  wire smp_read_offset_b10;
  wire cmd0x_data_write;
  wire net_480;
  wire net_477;
  wire mcu_data_dir;
  wire net_482;
  wire smp_read_offset_b0;
  wire smp_read_offset_b4;
  wire sig_296_lut_0;
  wire sig_296_lut_1;
  wire smp_read_offset_b7;
  wire smp_read_offset_b5;
  wire smp_read_offset_b11;
  wire mcu_d000000xx;
  wire smp_read_offset_b2;
  wire smp_read_offset_b3;
  wire sig_303_lut_0;
  wire pwm_enable;
  wire read_adc1A_b6;
  wire read_adc1A_h_b6;
  wire db_match_h;
  wire db_match_g;
  wire trigger_data_b5;
  wire prev_vs_lev_b;
  wire sig_313_lut_0;
  wire sig_313_lut_1;
  wire read_adc1A_b1;
  wire db_match_r;
  wire db_match_q;
  wire read_adc1A_h_b3;
  wire read_addr_11;
  wire cmd20_select;
  wire net_535;
  wire net_538;
  wire net_537;
  wire sig_318_lut_0;
  wire sig_318_lut_1;
  wire net_536;
  wire net_545;
  wire net_546;
  wire net_543;
  wire net_544;
  wire net_547;
  wire net_542;
  wire cmd26_select;
  wire cmd25_select;
  wire cmd06_select;
  wire cmd05_select;
  wire sig_324_lut_0;
  wire net_550;
  wire net_553;
  wire net_554;
  wire sig_326_lut_0;
  wire sig_326_lut_1;
  wire cmd0A_select;
  wire net_558;
  wire net_560;
  wire net_562;
  wire net_561;
  wire sig_329_lut_0;
  wire sig_329_lut_1;
  wire sig_329_ff0_d;
  wire sig_330_lut_0;
  wire cmd1x_select;
  wire smp_clk_enable, open_0, open_1, open_2, open_3, open_4, open_5, open_6, open_7, open_8, open_9, open_10, open_11, open_12, open_13, open_14, open_15, open_16, open_17, open_18, open_19, open_20, open_21, open_22, open_23, open_24, open_25, open_26, open_27, open_28, open_29, open_30, open_31;
  wire net_565;
  wire net_569;
  wire cmd34_enable;
  wire cmd33_enable;
  wire cmd0D_enable3;
  wire mcu_d0000010x;
  wire mcu_d00000xxx;
  wire cmd0D_enable2;
  wire sample_rate_cnt_out31, sample_rate_cnt_out30, sample_rate_cnt_out29, sample_rate_cnt_out28, sample_rate_cnt_out27, sample_rate_cnt_out26, sample_rate_cnt_out25, sample_rate_cnt_out24, sample_rate_cnt_out23, sample_rate_cnt_out22, sample_rate_cnt_out21, sample_rate_cnt_out20, sample_rate_cnt_out19, sample_rate_cnt_out18, sample_rate_cnt_out17, sample_rate_cnt_out16, sample_rate_cnt_out15, sample_rate_cnt_out14, sample_rate_cnt_out13, sample_rate_cnt_out12, sample_rate_cnt_out11, sample_rate_cnt_out10, sample_rate_cnt_out9, sample_rate_cnt_out8, sample_rate_cnt_out7, sample_rate_cnt_out6, sample_rate_cnt_out5, sample_rate_cnt_out4, sample_rate_cnt_out3, sample_rate_cnt_out2, sample_rate_cnt_out1, sample_rate_cnt_out0;
  wire smp_read_offset_b9;
  wire cmd0D_enable0;
  wire sig_366_lut_0;
  wire sig_366_lut_1;
  wire pwm_enable_b;
  wire offset1_pwm_c15, offset1_pwm_c14, offset1_pwm_c13, offset1_pwm_c12, offset1_pwm_c11, offset1_pwm_c10, offset1_pwm_c9, offset1_pwm_c8, offset1_pwm_c7, offset1_pwm_c6, offset1_pwm_c5, offset1_pwm_c4, offset1_pwm_c3, offset1_pwm_c2, offset1_pwm_c1, offset1_pwm_c0;
  wire net_679;
  wire net_684;
  wire read_adc1B_l_b0;
  wire read_adc1A_h_b1;
  wire sig_374_lut_0;
  wire sig_374_lut_1;
  wire net_692;
  wire read_adc1A_b0;
  wire read_adc1A_h_b0;
  wire read_adc1A_b4;
  wire read_adc1A_h_b4;
  wire sig_377_lut_0;
  wire sig_377_lut_1;
  wire smp_addr_match_c;
  wire sig_378_lut_0;
  wire smp_addr_match_a;
  wire net_699;
  wire net_698;
  wire sig_380_lut_0;
  wire sig_380_lut_1;
  wire read_b2_a;
  wire read_b4_a;
  wire read_b4_b;
  wire sig_382_lut_0;
  wire sig_382_lut_1;
  wire cmd_write_enable;
  wire i2c_rcv_rst;
  wire sig_384_lut_0;
  wire sig_384_lut_1;
  wire net_712;
  wire read_b5_a;
  wire read_b5_b;
  wire sig_386_lut_0;
  wire net_710;
  wire net_714;
  wire net_715;
  wire net_720;
  wire net_718;
  wire cmd32_enable0;
  wire byte_state_0;
  wire sig_390_lut_0;
  wire sig_390_lut_1;
  wire net_721;
  wire sig_391_lut_0;
  wire smp_addr_match_b;
  wire net_723;
  wire i2c_cmd6D_e5;
  wire sig_393_lut_0;
  wire sig_393_lut_1;
  wire net_728;
  wire cmd0E_enable3;
  wire cmd0E_select;
  wire sig_395_lut_0;
  wire sig_395_lut_1;
  wire sig_396_lut_0;
  wire sig_396_lut_1;
  wire sig_396_ff0_d;
  wire byte_state_1;
  wire cmd06_enable0;
  wire sig_398_lut_0;
  wire sig_398_lut_1;
  wire sig_398_ff0_d;
  wire cmd0E_enable2;
  wire smp_read_offset_b8;
  wire smp_read_offset_b6;
  wire cmd3x_data_write;
  wire smp_read_offset_b1;
  wire cmd0D_enable1;
  wire calib_1KHz_f;
  wire pwm_enable_a;
  wire sig_408_lut_0;
  wire sig_408_lut_1;
  wire read_adc1A_b5;
  wire read_adc1B_l_b6;
  wire read_adc1A_h_b5;
  wire read_adc1A_b2;
  wire read_adc1A_h_b2;
  wire offset1_pwm_rst;
  wire net_766;
  wire net_757;
  wire net_755;
  wire sig_413_lut_0;
  wire sig_413_lut_1;
  wire read_adc1B_b0;
  wire net_773;
  wire net_771;
  wire cmd32_enable1;
  wire net_770;
  wire net_776;
  wire net_777;
  wire i2c_cmd6A_e3;
  wire net_782;
  wire net_778;
  wire i2c_cmd68_e4;
  wire i2c_cmd69_e0;
  wire net_784;
  wire sig_420_lut_0;
  wire sig_420_lut_1;
  wire net_785;
  wire sig_421_lut_0;
  wire sig_421_lut_1;
  wire net_788;
  wire i2c_cmd6E_e7;
  wire net_791;
  wire net_793;
  wire net_789;
  wire sig_424_lut_0;
  wire sig_424_lut_1;
  wire net_792;
  wire sig_425_lut_0;
  wire sig_425_lut_1;
  wire net_798;
  wire net_795;
  wire net_800;
  wire i2c_cmd6B_e6;
  wire net_797;
  wire sig_428_lut_0;
  wire sig_428_lut_1;
  wire net_796;
  wire i2c_cmd6B_e7;
  wire net_805;
  wire i2c_cmd6D_e4;
  wire net_810;
  wire i2c_cmd6C_e4;
  wire net_808;
  wire sig_432_lut_0;
  wire sig_432_lut_1;
  wire net_814;
  wire i2c_cmd6D_e6;
  wire i2c_state_0000000011000000;
  wire i2c_cmd6D_e2;
  wire net_817;
  wire cmd6D_write_enable;
  wire cmd6B_write_enable;
  wire i2c_cmd6C_e6;
  wire net_822;
  wire sig_437_lut_0;
  wire net_823;
  wire cmd6C_write_enable;
  wire cmd6E_write_enable;
  wire sig_439_lut_0;
  wire sig_439_lut_1;
  wire sig_439_ff0_d;
  wire sig_440_lut_0;
  wire net_829;
  wire sig_441_lut_0;
  wire cmd69_write_enable;
  wire cmd0E_enable0;
  wire net_834;
  wire sig_447_lut_0;
  wire sig_447_lut_1;
  wire sig_448_lut_0;
  wire sig_448_lut_1;
  wire sig_449_lut_0;
  wire sig_449_lut_1;
  wire sig_449_ff0_d;
  wire calib_1KHz_c31, calib_1KHz_c30, calib_1KHz_c29, calib_1KHz_c28, calib_1KHz_c27, calib_1KHz_c26, calib_1KHz_c25, calib_1KHz_c24, calib_1KHz_c23, calib_1KHz_c22, calib_1KHz_c21, calib_1KHz_c20, calib_1KHz_c19, calib_1KHz_c18, calib_1KHz_c17, calib_1KHz_c16, calib_1KHz_c15, calib_1KHz_c14, calib_1KHz_c13, calib_1KHz_c12, calib_1KHz_c11, calib_1KHz_c10, calib_1KHz_c9, calib_1KHz_c8, calib_1KHz_c7, calib_1KHz_c6, calib_1KHz_c5, calib_1KHz_c4, calib_1KHz_c3, calib_1KHz_c2, calib_1KHz_c1, calib_1KHz_c0;
  wire calib_1KHz_d;
  wire calib_1KHz_e;
  wire calib_1KHz_c;
  wire calib_1KHz_b;
  wire sig_485_lut_0;
  wire sig_485_lut_1;
  wire net_944;
  wire net_935;
  wire net_938;
  wire net_956;
  wire net_955;
  wire net_958;
  wire net_957;
  wire i2c_cmd6E_e6;
  wire net_960;
  wire i2c_cmd6A_e2;
  wire net_964;
  wire net_970;
  wire i2c_cmd69_e3;
  wire i2c_cmd6D_e0;
  wire net_961;
  wire i2c_cmd69_e5;
  wire net_977;
  wire sig_497_lut_0;
  wire net_974;
  wire not_cmd_05_0A;
  wire net_973;
  wire net_978;
  wire net_979;
  wire sig_500_lut_0;
  wire sig_500_lut_1;
  wire net_982;
  wire i2c_cmd6E_e3;
  wire net_980;
  wire i2c_state_0000000001010100;
  wire net_984;
  wire sig_503_lut_0;
  wire sig_503_lut_1;
  wire sig_503_ff0_d;
  wire i2c_state_00000000xxxx1001;
  wire i2c_state_0000000011111001;
  wire i2c_cmd6B_e0;
  wire net_990;
  wire i2c_cmd6C_e3;
  wire net_996;
  wire i2c_state_0000000010111110;
  wire net_993;
  wire i2c_cmd6E_e5;
  wire net_997;
  wire i2c_cmd69_e1;
  wire net_1005;
  wire i2c_cmd6D_e3;
  wire i2c_state_198_200;
  wire sig_511_lut_0;
  wire sig_511_lut_1;
  wire net_1000;
  wire time_base_timeout, open_32, open_33, open_34, open_35, open_36, open_37, open_38, open_39, open_40, open_41, open_42, open_43, open_44, open_45, open_46, open_47, open_48, open_49, open_50, open_51, open_52, open_53, open_54, open_55, open_56, open_57, open_58, open_59, open_60, open_61, open_62, open_63;
  wire sig_513_lut_0;
  wire net_1012;
  wire i2c_state_00000000xxxx1111;
  wire net_1014;
  wire sig_517_lut_0;
  wire sig_517_lut_1;
  wire time_base_cnt_out31, time_base_cnt_out30, time_base_cnt_out29, time_base_cnt_out28, time_base_cnt_out27, time_base_cnt_out26, time_base_cnt_out25, time_base_cnt_out24, time_base_cnt_out23, time_base_cnt_out22, time_base_cnt_out21, time_base_cnt_out20, time_base_cnt_out19, time_base_cnt_out18, time_base_cnt_out17, time_base_cnt_out16, time_base_cnt_out15, time_base_cnt_out14, time_base_cnt_out13, time_base_cnt_out12, time_base_cnt_out11, time_base_cnt_out10, time_base_cnt_out9, time_base_cnt_out8, time_base_cnt_out7, time_base_cnt_out6, time_base_cnt_out5, time_base_cnt_out4, time_base_cnt_out3, time_base_cnt_out2, time_base_cnt_out1, time_base_cnt_out0;
  wire calib_1KHz_rst;
  wire calib_1KHz_a;
  wire net_1104;
  wire net_1103;
  wire net_1106;
  wire net_1100;
  wire net_1111;
  wire net_1112;
  wire net_1108;
  wire net_1116;
  wire i2c_cmd6B_e2;
  wire net_1109;
  wire sig_552_lut_0;
  wire sig_552_lut_1;
  wire sig_552_ff0_d;
  wire net_1120;
  wire i2c_cmd6C_e1;
  wire i2c_cmd68_e2;
  wire net_1119;
  wire net_1134;
  wire net_1131;
  wire net_1127;
  wire sig_556_lut_1;
  wire i2c_cmd69_e4;
  wire net_1126;
  wire i2c_cmd6C_e5;
  wire net_1132;
  wire i2c_cmd69_e2;
  wire net_1137;
  wire net_1144;
  wire net_1141;
  wire i2c_state_000000001000xxxx;
  wire i2c_state_0000000010001110;
  wire i2c_cmd6B_e3;
  wire net_1139;
  wire i2c_cmd69_e6;
  wire i2c_state_0000000001001111;
  wire net_1149;
  wire net_1145;
  wire net_1152;
  wire net_1151;
  wire sig_566_lut_0;
  wire sig_566_lut_1;
  wire net_1146;
  wire net_1154;
  wire net_1153;
  wire net_1156;
  wire net_1157;
  wire i2c_cmd6D_e7;
  wire net_1159;
  wire net_1158;
  wire i2c_state_0000000001010111;
  wire sig_571_lut_0;
  wire sig_571_lut_1;
  wire net_1165;
  wire i2c_cmd6B_e5;
  wire net_1163;
  wire sig_573_lut_0;
  wire net_1166;
  wire sig_574_lut_0;
  wire sig_574_lut_1;
  wire net_1168;
  wire i2c_cmd6E_e4;
  wire i2c_state_0000000011101111;
  wire sig_576_lut_0;
  wire sig_576_lut_1;
  wire sig_576_ff0_d;
  wire sig_577_lut_0;
  wire net_1172;
  wire sig_578_lut_0;
  wire net_1173;
  wire sig_579_lut_0;
  wire sig_579_lut_1;
  wire sig_580_lut_0;
  wire sig_580_lut_1;
  wire net_1179;
  wire sig_581_lut_1;
  wire sig_582_lut_0;
  wire sig_582_lut_1;
  wire net_1183;
  wire calib_1KHz_g;
  wire calib_1KHz_h;
  wire clk_a_div_c;
  wire clk_a_reset;
  wire i2c_cmd6D_e1;
  wire net_1202;
  wire i2c_state_0000000010001010;
  wire net_1206;
  wire net_1210;
  wire net_1207;
  wire sig_593_lut_0;
  wire sig_593_lut_1;
  wire net_1208;
  wire sig_594_lut_0;
  wire sig_594_lut_1;
  wire net_1209;
  wire sig_595_lut_0;
  wire sig_595_lut_1;
  wire net_1214;
  wire i2c_cmd6C_e2;
  wire net_1213;
  wire net_1215;
  wire net_1211;
  wire net_1218;
  wire net_1217;
  wire net_1220;
  wire net_1226;
  wire sig_600_lut_0;
  wire net_1227;
  wire net_1222;
  wire net_1224;
  wire i2c_cmd6B_e1;
  wire net_1221;
  wire i2c_cmd68_e3;
  wire i2c_state_0000000001010000;
  wire net_1228;
  wire net_1230;
  wire net_1234;
  wire i2c_state_0000000001110100;
  wire net_1239;
  wire net_1237;
  wire net_1235;
  wire net_1241;
  wire sig_608_lut_0;
  wire sig_608_lut_1;
  wire net_1238;
  wire i2c_state_0000000000101001;
  wire net_1236;
  wire net_1246;
  wire net_1244;
  wire net_1243;
  wire net_1242;
  wire sig_612_lut_0;
  wire sig_612_lut_1;
  wire net_1245;
  wire sig_613_lut_0;
  wire sig_613_lut_1;
  wire sig_613_ff0_d;
  wire net_1251;
  wire net_1248;
  wire net_1247;
  wire net_1250;
  wire net_1252;
  wire net_1249;
  wire sig_617_lut_0;
  wire net_1254;
  wire sig_618_lut_0;
  wire sig_618_lut_1;
  wire net_1255;
  wire sig_619_lut_0;
  wire sig_619_lut_1;
  wire net_1260;
  wire sig_620_lut_1;
  wire clk_a_div_d;
  wire clk_a_div_a;
  wire clk_a_div_out15, clk_a_div_out14, clk_a_div_out13, clk_a_div_out12, clk_a_div_out11, clk_a_div_out10, clk_a_div_out9, clk_a_div_out8, clk_a_div_out7, clk_a_div_out6, clk_a_div_out5, clk_a_div_out4, clk_a_div_out3, clk_a_div_out2, clk_a_div_out1, clk_a_div_out0;
  wire i2c_cmd6E_e0;
  wire net_1297;
  wire i2c_cmd68_e6;
  wire net_1293;
  wire net_1299;
  wire i2c_out_cmd6E_b6;
  wire net_1305;
  wire net_1301;
  wire i2c_state_000000001010xxxx;
  wire net_1303;
  wire net_1306;
  wire net_1304;
  wire sig_639_lut_0;
  wire sig_639_lut_1;
  wire net_1308;
  wire i2c_state_00000000xxxx1101;
  wire net_1309;
  wire i2c_cmd6A_e6;
  wire net_1311;
  wire sig_642_lut_0;
  wire sig_642_lut_1;
  wire net_1313;
  wire net_1315;
  wire net_1314;
  wire net_1316;
  wire net_1319;
  wire net_1317;
  wire net_1318;
  wire sig_646_lut_0;
  wire sig_646_lut_1;
  wire net_1320;
  wire sig_647_lut_0;
  wire sig_647_lut_1;
  wire net_1322;
  wire net_1321;
  wire net_1323;
  wire net_1324;
  wire net_1325;
  wire sig_650_lut_0;
  wire sig_650_lut_1;
  wire net_1326;
  wire i2c_cmd69_e7;
  wire net_1327;
  wire net_1329;
  wire net_1331;
  wire sig_653_lut_0;
  wire sig_653_lut_1;
  wire net_1330;
  wire net_1333;
  wire net_1334;
  wire sig_655_lut_0;
  wire net_1335;
  wire sig_656_lut_0;
  wire sig_656_lut_1;
  wire net_1336;
  wire sig_657_lut_0;
  wire sig_657_lut_1;
  wire net_1338;
  wire net_1342;
  wire net_1340;
  wire sig_659_lut_0;
  wire net_1343;
  wire cmd68_write_enable;
  wire cmd6A_write_enable;
  wire state_sum_b3, state_sum_b2, state_sum_b1, state_sum_b0;
  wire sig_662_lut_0;
  wire net_1345;
  wire sig_663_lut_0;
  wire net_1351;
  wire sig_666_lut_0;
  wire sig_666_lut_1;
  wire net_1361;
  wire i2c_clk_rst;
  wire net_1363;
  wire net_1362;
  wire i2c_cmd6A_e4;
  wire i2c_state_xxxxxxxx0110xxxx;
  wire i2c_cmd68_e7;
  wire net_1368;
  wire i2c_state_xxxxxxxx1010xxxx;
  wire i2c_state_xxxxxxxxxx10xxxx;
  wire clk_a_div_b;
  wire i2c_state_000000000000xxxx;
  wire i2c_state_000000000x1011x0;
  wire i2c_state_xxxxxxxx1110xxxx;
  wire net_1378;
  wire net_1374;
  wire i2c_state_000000001110xxxx;
  wire i2c_state_0000000011101010;
  wire net_1387;
  wire net_1381;
  wire net_1383;
  wire net_1384;
  wire net_1386;
  wire net_1388;
  wire i2c_cmd6C_e0;
  wire i2c_state_00000000101011xx;
  wire i2c_cmd6E_e1;
  wire net_1391;
  wire sig_685_lut_0;
  wire sig_685_lut_1;
  wire net_1390;
  wire sig_686_lut_0;
  wire sig_686_lut_1;
  wire net_1393;
  wire net_1395;
  wire net_1396;
  wire net_1402;
  wire net_1404;
  wire net_1397;
  wire net_1398;
  wire net_1400;
  wire net_1401;
  wire net_1403;
  wire net_1399;
  wire i2c_cmd6A_e0;
  wire net_1406;
  wire i2c_state_0000000011001110;
  wire net_1409;
  wire i2c_cmd6E_e2;
  wire net_1405;
  wire net_1415;
  wire net_1416;
  wire i2c_cmd68_e0;
  wire net_1413;
  wire sig_697_lut_0;
  wire sig_697_lut_1;
  wire net_1417;
  wire net_1423;
  wire net_1422;
  wire sig_699_lut_0;
  wire net_1419;
  wire sig_700_lut_0;
  wire sig_700_lut_1;
  wire sig_700_ff0_d;
  wire sig_701_lut_0;
  wire net_1424;
  wire sig_702_lut_0;
  wire net_1427;
  wire sig_703_lut_0;
  wire sig_703_lut_1;
  wire sig_703_ff0_d;
  wire sig_704_lut_0;
  wire net_1429;
  wire i2c_clk_div_out15, i2c_clk_div_out14, i2c_clk_div_out13, i2c_clk_div_out12, i2c_clk_div_out11, i2c_clk_div_out10, i2c_clk_div_out9, i2c_clk_div_out8, i2c_clk_div_out7, i2c_clk_div_out6, i2c_clk_div_out5, i2c_clk_div_out4, i2c_clk_div_out3, i2c_clk_div_out2, i2c_clk_div_out1, i2c_clk_div_out0;
  wire i2c_state_xxxxxxxx1000xxxx;
  wire i2c_state_xxxxxxxx1011xxxx;
  wire i2c_state_xxxxxxxx1100xxxx;
  wire i2c_state_xxxxxxxx1101xxxx;
  wire sig_716_lut_0;
  wire sig_716_lut_1;
  wire i2c_state_000000000011xxxx;
  wire i2c_state_xxxxxxxx01xxxxxx;
  wire i2s_state_unknown_a;
  wire i2c_cmd68_e5;
  wire i2c_state_0000000000101xxx;
  wire i2c_state_000000000100xxxx;
  wire i2c_state_xxxxxxxx0100xxxx;
  wire net_1477;
  wire net_1478;
  wire i2c_state_000000000101xxxx;
  wire i2c_state_000000000111xxxx;
  wire i2c_cmd6A_e7;
  wire i2c_state_000000000110xxxx;
  wire i2c_state_00000000xxxxxx10;
  wire i2c_state_00000000xxxx1110;
  wire i2c_cmd68_e1;
  wire i2c_state_0000000000110xx1;
  wire i2c_state_0000000011101101;
  wire net_1481;
  wire sig_726_lut_0;
  wire sig_726_lut_1;
  wire net_1485;
  wire net_1487;
  wire net_1489;
  wire i2c_state_13_15;
  wire i2c_state_0000000000000000;
  wire net_1488;
  wire net_1492;
  wire i2c_state_00000000xxxx0001;
  wire net_1496;
  wire net_1493;
  wire net_1499;
  wire i2c_state_00000000xxxx0000;
  wire i2c_state_0000000010010000;
  wire net_1500;
  wire i2c_state_0000000010110000;
  wire sig_734_lut_0;
  wire sig_734_lut_1;
  wire net_1501;
  wire sig_735_lut_0;
  wire net_1503;
  wire sig_736_lut_0;
  wire net_1504;
  wire sig_737_lut_0;
  wire sig_737_lut_1;
  wire net_1506;
  wire sig_738_lut_0;
  wire sig_738_lut_1;
  wire net_1507;
  wire sig_739_lut_0;
  wire net_1509;
  wire sig_740_lut_0;
  wire net_1512;
  wire sig_741_lut_0;
  wire sig_741_lut_1;
  wire net_1511;
  wire sig_742_lut_0;
  wire sig_742_lut_1;
  wire sig_742_ff0_d;
  wire sig_743_lut_0;
  wire net_1516;
  wire sig_744_lut_0;
  wire sig_744_lut_1;
  wire sig_744_ff0_d;
  wire sig_745_lut_0;
  wire net_1519;
  wire sig_746_lut_0;
  wire sig_746_lut_1;
  wire i2c_state_xxxxxxxx0000xxxx;
  wire i2c_state_xxxxxxxx1001xxxx;
  wire i2c_state_xxxxxxxx0001xxxx;
  wire i2c_state_xxxxxxxx1111xxxx;
  wire i2c_state_000000000010xxxx;
  wire i2c_state_xxxxxxxx0010xxxx;
  wire i2c_state_00000000xxxx1010;
  wire i2c_state_xxxxxxxx00010010;
  wire sig_756_lut_0;
  wire net_1527;
  wire i2c_state_c15, i2c_state_c14, i2c_state_c13, i2c_state_c12, i2c_state_c11, i2c_state_c10, i2c_state_c9, i2c_state_c8, i2c_state_c7, i2c_state_c6, i2c_state_c5, i2c_state_c4, i2c_state_c3, i2c_state_c2, i2c_state_c1, i2c_state_c0;
  wire sig_759_lut_0;
  wire sig_759_lut_1;
  wire i2c_state_00000000xxxx1000;
  wire i2c_state_xxxxxxxxxxxx00xx;
  wire net_1562;
  wire net_1564;
  wire i2c_state_0000000010010010;
  wire sig_765_lut_0;
  wire sig_765_lut_1;
  wire net_1561;
  wire i2c_cmd6A_e1;
  wire net_1568;
  wire i2c_state_xxxxxxxxxxxx10x1;
  wire i2c_state_xxxxxxxxxxxx1001;
  wire sig_768_lut_0;
  wire net_1571;
  wire i2c_state_xxxxxxxxxxxx1011;
  wire i2c_state_0000000011101011;
  wire i2c_state_00000000xxxx0011;
  wire i2c_state_0000000000010011;
  wire i2c_state_0000000010010011;
  wire i2c_state_0000000010110001;
  wire i2c_state_195_203;
  wire i2c_state_000000001100xxxx;
  wire i2c_cmd6B_e4;
  wire net_1585;
  wire sig_774_lut_0;
  wire net_1581;
  wire i2c_cmd6C_e7;
  wire net_1586;
  wire sig_776_lut_0;
  wire net_1588;
  wire sig_777_lut_0;
  wire net_1592;
  wire sig_778_lut_0;
  wire net_1590;
  wire sig_779_lut_0;
  wire sig_779_lut_1;
  wire sig_779_ff0_d;
  wire sig_780_lut_0;
  wire sig_780_lut_1;
  wire sig_780_ff0_d;
  wire sig_781_lut_0;
  wire sig_781_lut_1;
  wire sig_781_ff0_d;
  wire sig_782_lut_0;
  wire net_1598;
  wire net_1600;
  wire net_1599;
  wire net_1604;
  wire net_1605;
  wire sig_815_lut_0;
  wire sig_815_lut_1;
  wire sig_815_ff0_d;
  wire i2c_session_enable;
  wire i2c_state_00000000xxxxxxxx;
  wire net_1612;
  wire net_1611;
  wire net_1615;
  wire i2c_state_0000xxxxxxxxxxxx;
  wire i2c_cmd6A_e5;
  wire i2c_state_xxxxxxxxxxxx1000;
  wire net_1619;
  wire i2c_state_xxxxxxxxxxxx01xx;
  wire sig_821_lut_0;
  wire sig_821_lut_1;
  wire i2c_state_00000000xxxx1100;
  wire i2c_state_xxxxxxxxxxxx1111;
  wire i2c_state_xxxxxxxxxxxx1101;
  wire i2c_state_xxxxxxxxxxxx0010;
  wire i2c_state_xxxxxxxxxxxx0000;
  wire i2c_state_195_196;
  wire net_1628;
  wire i2c_state_xxxxxxxxxxxx0011;
  wire i2c_state_xxxxxxxxxxxx0001;
  wire sig_826_lut_0;
  wire net_1631;
  wire i2c_state_xxxxxxxxxxxx0111;
  wire i2c_state_xxxxxxxxxxxx0101;
  wire i2c_state_xxxxxxxxxxxx0100;
  wire i2c_state_xxxxxxxxxxxx0110;
  wire sig_829_lut_0;
  wire i2c_out_cmd68_b2;
  wire sig_830_lut_0;
  wire i2c_out_cmd6A_b2;
  wire i2c_state_0000000001110001;
  wire net_1641;
  wire sig_832_lut_0;
  wire net_1644;
  wire sig_833_lut_0;
  wire i2c_out_cmd6A_b1;
  wire sig_834_lut_0;
  wire i2c_out_cmd6E_b2;
  wire sig_82_cea;
  wire sig_82_ceb;
  wire o_adc2A_d0_1;
  wire o_adc2A_d0_0;
  wire o_adc1B_d0_7;
  wire o_adc1B_d0_6;
  wire o_adc1B_d0_5;
  wire o_adc1B_d0_4;
  wire o_adc1B_d0_3;
  wire o_adc1B_d0_2;
  wire o_adc1B_d0_1;
  wire sig_83_cea;
  wire sig_83_ceb;
  wire o_adc2A_d1_1;
  wire o_adc2A_d1_0;
  wire o_adc1B_d1_7;
  wire o_adc1B_d1_6;
  wire o_adc1B_d1_5;
  wire o_adc1B_d1_4;
  wire o_adc1B_d1_3;
  wire o_adc1B_d1_2;
  wire o_adc1B_d1_1;
  wire sig_84_cea;
  wire sig_84_ceb;
  wire o_adc2A_d3_1;
  wire o_adc2A_d3_0;
  wire o_adc1B_d3_7;
  wire o_adc1B_d3_6;
  wire o_adc1B_d3_5;
  wire o_adc1B_d3_4;
  wire o_adc1B_d3_3;
  wire o_adc1B_d3_2;
  wire o_adc1B_d3_1;
  wire sig_94_cea;
  wire sig_94_ceb;
  wire o_adc2A_d2_1;
  wire o_adc2A_d2_0;
  wire o_adc1B_d2_7;
  wire o_adc1B_d2_6;
  wire o_adc1B_d2_5;
  wire o_adc1B_d2_4;
  wire o_adc1B_d2_3;
  wire o_adc1B_d2_2;
  wire o_adc1B_d2_1;
  wire sig_95_cea;
  wire sig_95_ceb;
  wire o_adc2B_d2_2;
  wire o_adc2B_d2_1;
  wire o_adc2B_d2_0;
  wire o_adc2A_d2_7;
  wire o_adc2A_d2_6;
  wire o_adc2A_d2_5;
  wire o_adc2A_d2_4;
  wire o_adc2A_d2_3;
  wire o_adc2A_d2_2;
  wire sig_96_cea;
  wire sig_96_ceb;
  wire o_adc2B_d3_2;
  wire o_adc2B_d3_1;
  wire o_adc2B_d3_0;
  wire o_adc2A_d3_7;
  wire o_adc2A_d3_6;
  wire o_adc2A_d3_5;
  wire o_adc2A_d3_4;
  wire o_adc2A_d3_3;
  wire o_adc2A_d3_2;
  wire sig_97_cea;
  wire sig_97_ceb;
  wire o_adc2B_d1_2;
  wire o_adc2B_d1_1;
  wire o_adc2B_d1_0;
  wire o_adc2A_d1_7;
  wire o_adc2A_d1_6;
  wire o_adc2A_d1_5;
  wire o_adc2A_d1_4;
  wire o_adc2A_d1_3;
  wire o_adc2A_d1_2;
  wire sig_114_cea;
  wire sig_114_ceb;
  wire o_adc2B_d0_2;
  wire o_adc2B_d0_1;
  wire o_adc2B_d0_0;
  wire o_adc2A_d0_7;
  wire o_adc2A_d0_6;
  wire o_adc2A_d0_5;
  wire o_adc2A_d0_4;
  wire o_adc2A_d0_3;
  wire o_adc2A_d0_2;
  wire sig_450_cea;
  wire sig_450_ceb;
  wire o_adc1B_d0_0;
  wire o_adc1A_d0_7;
  wire o_adc1A_d0_6;
  wire o_adc1A_d0_5;
  wire o_adc1A_d0_4;
  wire o_adc1A_d0_3;
  wire o_adc1A_d0_2;
  wire o_adc1A_d0_1;
  wire o_adc1A_d0_0;
  wire sig_455_cea;
  wire sig_455_ceb;
  wire o_adc1B_d1_0;
  wire o_adc1A_d1_7;
  wire o_adc1A_d1_6;
  wire o_adc1A_d1_5;
  wire o_adc1A_d1_4;
  wire o_adc1A_d1_3;
  wire o_adc1A_d1_2;
  wire o_adc1A_d1_1;
  wire o_adc1A_d1_0;
  wire sig_456_cea;
  wire sig_456_ceb;
  wire o_adc1B_d3_0;
  wire o_adc1A_d3_7;
  wire o_adc1A_d3_6;
  wire o_adc1A_d3_5;
  wire o_adc1A_d3_4;
  wire o_adc1A_d3_3;
  wire o_adc1A_d3_2;
  wire o_adc1A_d3_1;
  wire o_adc1A_d3_0;
  wire sig_457_cea;
  wire sig_457_ceb;
  wire o_adc1B_d2_0;
  wire o_adc1A_d2_7;
  wire o_adc1A_d2_6;
  wire o_adc1A_d2_5;
  wire o_adc1A_d2_4;
  wire o_adc1A_d2_3;
  wire o_adc1A_d2_2;
  wire o_adc1A_d2_1;
  wire o_adc1A_d2_0;
  wire o_adc2B_d_4;
  wire o_adc2B_d_3;
  wire o_adc2B_d_6;
  wire o_adc2B_d_5;
  wire o_adc2B_d_7;

//---------------------------------------------------------------------------
//Register declarations

  reg read_addr_l10 = 1'b0;
  reg trigger_previous_b3 = 1'b0;
  reg trigger_level_b6 = 1'b0;
  reg sample_addr_11 = 1'b0, sample_addr_10 = 1'b0, sample_addr_9 = 1'b0, sample_addr_8 = 1'b0, sample_addr_7 = 1'b0, sample_addr_6 = 1'b0, sample_addr_5 = 1'b0, sample_addr_4 = 1'b0, sample_addr_3 = 1'b0, sample_addr_2 = 1'b0, sample_addr_1 = 1'b0, sample_addr_0 = 1'b0;
  reg trigger_address_b3 = 1'b0;
  reg trigger_address_b9 = 1'b0;
  reg trigger_address_b0 = 1'b0;
  reg offset2_pwm_r15 = 1'b0, offset2_pwm_r14 = 1'b0, offset2_pwm_r13 = 1'b0, offset2_pwm_r12 = 1'b0, offset2_pwm_r11 = 1'b0, offset2_pwm_r10 = 1'b0, offset2_pwm_r9 = 1'b0, offset2_pwm_r8 = 1'b0, offset2_pwm_r7 = 1'b0, offset2_pwm_r6 = 1'b0, offset2_pwm_r5 = 1'b0, offset2_pwm_r4 = 1'b0, offset2_pwm_r3 = 1'b0, offset2_pwm_r2 = 1'b0, offset2_pwm_r1 = 1'b0, offset2_pwm_r0 = 1'b0;
  reg ch2_offset_b2 = 1'b0;
  reg ch2_offset_b1 = 1'b0;
  reg trigger_previous_b6 = 1'b0;
  reg trigger_previous_b7 = 1'b0;
  reg trigger_level_b7 = 1'b0;
  reg sample_write_enable = 1'b1;
  reg disp_bright_b10 = 1'b0;
  reg disp_bright_b15 = 1'b0;
  reg trigger_mode = 1'b0;
  reg ch2_offset_b0 = 1'b0;
  reg ch2_offset_b6 = 1'b0;
  reg sample_read_enable = 1'b0;
  reg pre_trigger_addr11 = 1'b0, pre_trigger_addr10 = 1'b0, pre_trigger_addr9 = 1'b1, pre_trigger_addr8 = 1'b1, pre_trigger_addr7 = 1'b0, pre_trigger_addr6 = 1'b0, pre_trigger_addr5 = 1'b1, pre_trigger_addr4 = 1'b0, pre_trigger_addr3 = 1'b0, pre_trigger_addr2 = 1'b0, pre_trigger_addr1 = 1'b0, pre_trigger_addr0 = 1'b0;
  reg cmd3C_b13 = 1'b0;
  reg cmd3C_b11 = 1'b0;
  reg trigger_address_b11 = 1'b0;
  reg ch2_offset_b4 = 1'b0;
  reg ch2_offset_b3 = 1'b0;
  reg ch2_offset_b7 = 1'b0;
  reg ch2_offset_b5 = 1'b0;
  reg ch2_offset_b8 = 1'b0;
  reg ch2_offset_b9 = 1'b0;
  reg trigger_previous_b4 = 1'b0;
  reg trigger_level_b4 = 1'b0;
  reg trigger_level_b5 = 1'b0;
  reg trigger_detect_enable = 1'b0;
  reg sampling_triggered = 1'b0;
  reg time_base_cnt_reg13 = 1'b0;
  reg sampling_reset = 1'b0;
  reg cmd_b2 = 1'b0;
  reg cmd3C_b3 = 1'b0;
  reg cmd3C_b2 = 1'b0;
  reg cmd3C_b9 = 1'b0;
  reg cmd3C_b8 = 1'b0;
  reg cmd3C_b10 = 1'b0;
  reg trigger_address_b8 = 1'b0;
  reg trigger_address_b1 = 1'b0;
  reg ch2_offset_b10 = 1'b0;
  reg ch2_offset_b15 = 1'b0;
  reg cmd3C_b15 = 1'b0;
  reg cmd3C_b14 = 1'b0;
  reg trigger_address_b10 = 1'b0;
  reg trigger_address_b7 = 1'b0;
  reg trigger_address_b2 = 1'b0;
  reg ch2_offset_b13 = 1'b0;
  reg ch2_offset_b12 = 1'b0;
  reg smp_read_offset_r5 = 1'b0;
  reg ch2_offset_b14 = 1'b0;
  reg smp_read_offset_r9 = 1'b0;
  reg disp_bright_b8 = 1'b0;
  reg trigger_previous_b5 = 1'b0;
  reg trigger_previous_b0 = 1'b0;
  reg trigger_level_b1 = 1'b0;
  reg trigger_level_b3 = 1'b0;
  reg trigger_previous_b1 = 1'b0;
  reg trigger_previous_b2 = 1'b0;
  reg trigger_level_b0 = 1'b0;
  reg trigger_level_b2 = 1'b0;
  reg disp_bright_b13 = 1'b0;
  reg disp_bright_b12 = 1'b0;
  reg o_mcu_d_3 = 1'b0;
  reg cmd3C_b0 = 1'b0;
  reg o_mcu_d_1 = 1'b0;
  reg o_mcu_d_5 = 1'b0;
  reg cmd3C_b6 = 1'b0;
  reg o_mcu_d_0 = 1'b0;
  reg o_mcu_d_6 = 1'b0;
  reg trigger_address_b5 = 1'b0;
  reg cmd3C_b1 = 1'b0;
  reg trigger_address_b4 = 1'b0;
  reg trigger_address_b6 = 1'b0;
  reg calib_1KHz_r22 = 1'b0;
  reg smp_read_offset_r6 = 1'b0;
  reg smp_read_offset_r10 = 1'b0;
  reg time_base_b16 = 1'b0;
  reg smp_read_offset_r7 = 1'b0;
  reg smp_read_offset_r0 = 1'b0;
  reg smp_read_offset_r2 = 1'b0;
  reg smp_read_offset_r1 = 1'b0;
  reg smp_read_offset_r8 = 1'b0;
  reg disp_bright_b9 = 1'b0;
  reg disp_bright_b2 = 1'b0;
  reg disp_bright_b3 = 1'b0;
  reg disp_bright_b4 = 1'b0;
  reg disp_bright_b11 = 1'b0;
  reg time_base_cnt_reg14 = 1'b0;
  reg trigger_channel = 1'b0;
  reg pwm_display = 1'b0;
  reg o_mcu_d_7 = 1'b0;
  reg disp_bright_b6 = 1'b0;
  reg cmd_b4 = 1'b0;
  reg cmd_b5 = 1'b0;
  reg cmd3C_b7 = 1'b0;
  reg cmd_b6 = 1'b0;
  reg cmd_b7 = 1'b0;
  reg trigger_edge = 1'b0;
  reg calib_1khz = 1'b0;
  reg disp_bright_b0 = 1'b0;
  reg disp_bright_b1 = 1'b0;
  reg offset_2 = 1'b0;
  reg ac_dc_2 = 1'b0;
  reg sample_rate_b2 = 1'b0;
  reg ch2_offset_b11 = 1'b0;
  reg sample_rate_b8 = 1'b0;
  reg sample_rate_b12 = 1'b0;
  reg smp_read_offset_r3 = 1'b0;
  reg smp_read_offset_r11 = 1'b0;
  reg sample_rate_b15 = 1'b0;
  reg sample_rate_b13 = 1'b0;
  reg sample_rate_b19 = 1'b0;
  reg sample_rate_b18 = 1'b0;
  reg sample_rate_b26 = 1'b0;
  reg sample_rate_b27 = 1'b0;
  reg db_cnt_b15 = 1'b0, db_cnt_b14 = 1'b0, db_cnt_b13 = 1'b0, db_cnt_b12 = 1'b0, db_cnt_b11 = 1'b0, db_cnt_b10 = 1'b0, db_cnt_b9 = 1'b0, db_cnt_b8 = 1'b0, db_cnt_b7 = 1'b0, db_cnt_b6 = 1'b0, db_cnt_b5 = 1'b0, db_cnt_b4 = 1'b0, db_cnt_b3 = 1'b0, db_cnt_b2 = 1'b0, db_cnt_b1 = 1'b0, db_cnt_b0 = 1'b0;
  reg clk_50MHz = 1'b0;
  reg disp_bright_b7 = 1'b0;
  reg disp_bright_b5 = 1'b0;
  reg disp_bright_b14 = 1'b0;
  reg read_addr_l11 = 1'b0;
  reg offset1_pwm_r9 = 1'b0;
  reg o_mcu_d_2 = 1'b0;
  reg cmd3C_b4 = 1'b0;
  reg cmd3C_b5 = 1'b0;
  reg cmd_b3 = 1'b0;
  reg o_mcu_d_4 = 1'b0;
  reg relay2_1 = 1'b0;
  reg sample_rate_cnt_reg6 = 1'b0;
  reg sample_rate_cnt_reg2 = 1'b0;
  reg sample_rate_cnt_reg5 = 1'b0;
  reg sample_rate_b3 = 1'b0;
  reg sample_rate_b4 = 1'b0;
  reg sample_rate_b5 = 1'b0;
  reg sample_rate_b6 = 1'b0;
  reg sample_rate_b7 = 1'b0;
  reg sample_rate_b9 = 1'b0;
  reg sample_rate_cnt_reg9 = 1'b0;
  reg sample_rate_cnt_reg8 = 1'b0;
  reg sample_rate_cnt_reg13 = 1'b0;
  reg sample_rate_cnt_reg14 = 1'b0;
  reg sample_rate_cnt_reg21 = 1'b0;
  reg sample_rate_cnt_reg22 = 1'b0;
  reg sample_rate_cnt_reg17 = 1'b0;
  reg sample_rate_cnt_reg18 = 1'b0;
  reg sample_rate_b20 = 1'b0;
  reg sample_rate_b21 = 1'b0;
  reg sample_rate_b22 = 1'b0;
  reg sample_rate_b23 = 1'b0;
  reg sample_rate_cnt_reg25 = 1'b0;
  reg sample_rate_cnt_reg26 = 1'b0;
  reg sample_rate_b28 = 1'b0;
  reg sample_rate_b29 = 1'b0;
  reg sample_rate_b30 = 1'b0;
  reg sample_rate_b31 = 1'b0;
  reg ac_dc_1 = 1'b0;
  reg sample_rate_b0 = 1'b0;
  reg sample_rate_b1 = 1'b0;
  reg sample_rate_b11 = 1'b0;
  reg sample_rate_b10 = 1'b0;
  reg sample_rate_cnt_reg0 = 1'b0;
  reg sample_rate_cnt_reg1 = 1'b0;
  reg sample_rate_cnt_reg3 = 1'b0;
  reg sample_rate_cnt_reg4 = 1'b0;
  reg sample_rate_cnt_reg10 = 1'b0;
  reg sample_rate_cnt_reg7 = 1'b0;
  reg sample_rate_cnt_reg11 = 1'b0;
  reg sample_rate_cnt_reg12 = 1'b0;
  reg sample_rate_cnt_reg15 = 1'b0;
  reg sample_rate_cnt_reg16 = 1'b0;
  reg sample_rate_cnt_reg19 = 1'b0;
  reg sample_rate_cnt_reg20 = 1'b0;
  reg sample_rate_cnt_reg23 = 1'b0;
  reg sample_rate_cnt_reg24 = 1'b0;
  reg sample_rate_cnt_reg27 = 1'b0;
  reg sample_rate_cnt_reg28 = 1'b0;
  reg sample_rate_cnt_reg31 = 1'b0;
  reg sample_rate_cnt_reg29 = 1'b0;
  reg sample_rate_b25 = 1'b0;
  reg sample_rate_b24 = 1'b0;
  reg offset1_pwm_r0 = 1'b0;
  reg offset1_pwm_r1 = 1'b0;
  reg offset1_pwm_r3 = 1'b0;
  reg offset1_pwm_r4 = 1'b0;
  reg offset1_pwm_r10 = 1'b0;
  reg offset1_pwm_r7 = 1'b0;
  reg offset1_pwm_r11 = 1'b0;
  reg offset1_pwm_r12 = 1'b0;
  reg offset1_pwm_r15 = 1'b0;
  reg sampling_half_way = 1'b0;
  reg i2c_send_enable = 1'b0;
  reg i2c_disable = 1'b0;
  reg cmd_b0 = 1'b0;
  reg cmd_b1 = 1'b0;
  reg offset_1 = 1'b0;
  reg ch1_offset_b10 = 1'b0;
  reg ch1_offset_b15 = 1'b0;
  reg smp_rst_state = 1'b0;
  reg i_i2c_cmd6D_b5 = 1'b0;
  reg time_base_b0 = 1'b0;
  reg sample_write_clock = 1'b0;
  reg adc1_encB = 1'b0;
  reg smp_read_offset_r4 = 1'b0;
  reg cmd3C_b12 = 1'b0;
  reg o_i2c_cmd6E_b5 = 1'b0;
  reg time_base_b10 = 1'b0;
  reg time_base_b8 = 1'b0;
  reg sample_rate_b14 = 1'b0;
  reg sample_rate_b17 = 1'b0;
  reg sample_rate_b16 = 1'b0;
  reg sample_rate_cnt_reg30 = 1'b0;
  reg calib_1KHz_r29 = 1'b0;
  reg offset1_pwm_r13 = 1'b0;
  reg offset1_pwm_r2 = 1'b0;
  reg ch1_offset_b8 = 1'b0;
  reg ch1_offset_b9 = 1'b0;
  reg ch1_offset_b7 = 1'b0;
  reg ch1_offset_b5 = 1'b0;
  reg ch1_offset_b0 = 1'b0;
  reg ch1_offset_b6 = 1'b0;
  reg i_i2c_cmd6A_b3 = 1'b0;
  reg i_i2c_cmd68_b4 = 1'b1;
  reg i_i2c_cmd69_b0 = 1'b0;
  reg i_i2c_cmd6E_b7 = 1'b0;
  reg i_i2c_cmd6B_b6 = 1'b0;
  reg i_i2c_cmd6B_b7 = 1'b0;
  reg i_i2c_cmd6D_b4 = 1'b0;
  reg i_i2c_cmd6C_b4 = 1'b0;
  reg i_i2c_cmd6D_b6 = 1'b0;
  reg i_i2c_cmd6D_b2 = 1'b1;
  reg i_i2c_cmd6C_b6 = 1'b0;
  reg o_i2c_cmd6B_b2 = 1'b0;
  reg o_i2c_cmd6C_b5 = 1'b0;
  reg o_i2c_cmd6D_b6 = 1'b0;
  reg o_i2c_cmd69_b5 = 1'b0;
  reg time_base_b24 = 1'b0;
  reg smp_rst_cnt_b3 = 1'b0, smp_rst_cnt_b2 = 1'b0, smp_rst_cnt_b1 = 1'b0, smp_rst_cnt_b0 = 1'b0;
  reg adc2_encA = 1'b0;
  reg adc1_encA = 1'b0;
  reg relay2_2 = 1'b0;
  reg relay2_3 = 1'b0;
  reg relay1_2 = 1'b0;
  reg relay1_3 = 1'b0;
  reg relay1_1 = 1'b0;
  reg calib_1KHz_r0 = 1'b0;
  reg calib_1KHz_r1 = 1'b0;
  reg calib_1KHz_r3 = 1'b0;
  reg calib_1KHz_r4 = 1'b0;
  reg calib_1KHz_r10 = 1'b0;
  reg calib_1KHz_r7 = 1'b0;
  reg calib_1KHz_r11 = 1'b0;
  reg calib_1KHz_r12 = 1'b0;
  reg calib_1KHz_r15 = 1'b0;
  reg calib_1KHz_r16 = 1'b0;
  reg calib_1KHz_r19 = 1'b0;
  reg calib_1KHz_r20 = 1'b0;
  reg calib_1KHz_r23 = 1'b0;
  reg calib_1KHz_r24 = 1'b0;
  reg calib_1KHz_r27 = 1'b0;
  reg calib_1KHz_r28 = 1'b0;
  reg calib_1KHz_r31 = 1'b0;
  reg calib_1KHz_r18 = 1'b0;
  reg calib_1KHz_r5 = 1'b0;
  reg calib_1KHz_r17 = 1'b0;
  reg calib_1KHz_r9 = 1'b0;
  reg calib_1KHz_r8 = 1'b0;
  reg calib_1KHz_r26 = 1'b0;
  reg ch1_offset_b13 = 1'b0;
  reg ch1_offset_b12 = 1'b0;
  reg ch1_offset_b14 = 1'b0;
  reg ch1_offset_b11 = 1'b0;
  reg i_i2c_cmd6E_b6 = 1'b0;
  reg i_i2c_cmd6A_b2 = 1'b1;
  reg i_i2c_cmd69_b3 = 1'b0;
  reg i_i2c_cmd6D_b0 = 1'b0;
  reg i_i2c_cmd69_b5 = 1'b0;
  reg i2c_sda_dir = 1'b0;
  reg i_i2c_cmd6E_b3 = 1'b0;
  reg o_i2c_sda = 1'b0;
  reg i_i2c_cmd6B_b0 = 1'b0;
  reg i_i2c_cmd6C_b3 = 1'b0;
  reg i_i2c_cmd6E_b5 = 1'b0;
  reg i_i2c_cmd69_b1 = 1'b0;
  reg i_i2c_cmd6D_b3 = 1'b0;
  reg time_base_cnt_reg2 = 1'b0;
  reg time_base_cnt_reg5 = 1'b0;
  reg time_base_b1 = 1'b0;
  reg time_base_b2 = 1'b0;
  reg time_base_b3 = 1'b0;
  reg time_base_b4 = 1'b0;
  reg time_base_b5 = 1'b0;
  reg time_base_b6 = 1'b0;
  reg time_base_b7 = 1'b0;
  reg time_base_b9 = 1'b0;
  reg time_base_b11 = 1'b0;
  reg time_base_b12 = 1'b0;
  reg time_base_b13 = 1'b0;
  reg time_base_b14 = 1'b0;
  reg time_base_b15 = 1'b0;
  reg time_base_b17 = 1'b0;
  reg time_base_b18 = 1'b0;
  reg time_base_b19 = 1'b0;
  reg time_base_b20 = 1'b0;
  reg time_base_b21 = 1'b0;
  reg time_base_b22 = 1'b0;
  reg time_base_b23 = 1'b0;
  reg time_base_b25 = 1'b0;
  reg time_base_b26 = 1'b0;
  reg time_base_b27 = 1'b0;
  reg time_base_b28 = 1'b0;
  reg time_base_b29 = 1'b0;
  reg time_base_b30 = 1'b0;
  reg time_base_b31 = 1'b0;
  reg o_i2c_cmd6C_b2 = 1'b0;
  reg o_i2c_cmd6B_b3 = 1'b0;
  reg o_i2c_cmd6B_b4 = 1'b0;
  reg time_base_cnt_reg0 = 1'b0;
  reg time_base_cnt_reg1 = 1'b0;
  reg time_base_cnt_reg3 = 1'b0;
  reg time_base_cnt_reg4 = 1'b0;
  reg time_base_cnt_reg10 = 1'b0;
  reg time_base_cnt_reg7 = 1'b0;
  reg time_base_cnt_reg11 = 1'b0;
  reg time_base_cnt_reg12 = 1'b0;
  reg time_base_cnt_reg15 = 1'b0;
  reg time_base_cnt_reg16 = 1'b0;
  reg time_base_cnt_reg19 = 1'b0;
  reg time_base_cnt_reg20 = 1'b0;
  reg time_base_cnt_reg23 = 1'b0;
  reg time_base_cnt_reg24 = 1'b0;
  reg time_base_cnt_reg27 = 1'b0;
  reg time_base_cnt_reg28 = 1'b0;
  reg time_base_cnt_reg31 = 1'b0;
  reg time_base_cnt_reg29 = 1'b0;
  reg calib_1KHz_r6 = 1'b0;
  reg calib_1KHz_r2 = 1'b0;
  reg calib_1KHz_r13 = 1'b0;
  reg calib_1KHz_r14 = 1'b0;
  reg offset1_pwm_r5 = 1'b0;
  reg offset1_pwm_r14 = 1'b0;
  reg offset1_pwm_r6 = 1'b0;
  reg offset1_pwm_r8 = 1'b0;
  reg ch1_offset_b2 = 1'b0;
  reg ch1_offset_b1 = 1'b0;
  reg ch1_offset_b4 = 1'b0;
  reg ch1_offset_b3 = 1'b0;
  reg i_i2c_cmd6B_b2 = 1'b0;
  reg o_i2c_cmd6E_b6 = 1'b0;
  reg i_i2c_cmd6C_b1 = 1'b1;
  reg i_i2c_cmd68_b2 = 1'b1;
  reg i2c_scl = 1'b0;
  reg i_i2c_cmd69_b4 = 1'b0;
  reg i_i2c_cmd6C_b5 = 1'b0;
  reg i_i2c_cmd69_b2 = 1'b0;
  reg i_i2c_cmd6B_b3 = 1'b0;
  reg i_i2c_cmd69_b6 = 1'b0;
  reg i_i2c_cmd6D_b7 = 1'b0;
  reg i_i2c_cmd6B_b5 = 1'b0;
  reg o_i2c_cmd6C_b1 = 1'b0;
  reg i_i2c_cmd6E_b4 = 1'b0;
  reg o_i2c_cmd6C_b4 = 1'b0;
  reg o_i2c_cmd6C_b3 = 1'b0;
  reg o_i2c_cmd6D_b1 = 1'b0;
  reg state_b2 = 1'b0;
  reg state_b1 = 1'b0;
  reg o_i2c_cmd6B_b0 = 1'b0;
  reg o_i2c_cmd6B_b1 = 1'b0;
  reg state_b0 = 1'b0;
  reg time_base_cnt_reg8 = 1'b0;
  reg time_base_cnt_reg18 = 1'b0;
  reg time_base_cnt_reg6 = 1'b0;
  reg time_base_cnt_reg21 = 1'b0;
  reg time_base_cnt_reg9 = 1'b0;
  reg time_base_cnt_reg17 = 1'b0;
  reg time_base_cnt_reg30 = 1'b0;
  reg time_base_cnt_reg22 = 1'b0;
  reg time_base_cnt_reg26 = 1'b0;
  reg time_base_cnt_reg25 = 1'b0;
  reg calib_1KHz_r25 = 1'b0;
  reg calib_1KHz_r21 = 1'b0;
  reg clk_a_div_reg6 = 1'b0;
  reg clk_a_div_reg13 = 1'b0;
  reg i_i2c_cmd6D_b1 = 1'b0;
  reg i_i2c_cmd6C_b2 = 1'b0;
  reg adc2_encB = 1'b0;
  reg i_i2c_cmd6B_b1 = 1'b1;
  reg i_i2c_cmd68_b3 = 1'b1;
  reg o_i2c_cmd6D_b5 = 1'b0;
  reg o_i2c_cmd6C_b7 = 1'b0;
  reg o_i2c_cmd6E_b7 = 1'b0;
  reg o_i2c_cmd6E_b4 = 1'b0;
  reg state_b3 = 1'b0;
  reg calib_1KHz_r30 = 1'b0;
  reg clk_a_div_reg14 = 1'b0;
  reg clk_a_div_reg5 = 1'b0;
  reg clk_a_div_reg0 = 1'b0;
  reg clk_a_div_reg1 = 1'b0;
  reg clk_a_div_reg3 = 1'b0;
  reg clk_a_div_reg4 = 1'b0;
  reg clk_a_div_reg10 = 1'b0;
  reg clk_a_div_reg7 = 1'b0;
  reg clk_a_div_reg11 = 1'b0;
  reg clk_a_div_reg12 = 1'b0;
  reg clk_a_div_reg15 = 1'b0;
  reg clk_a_div_reg8 = 1'b0;
  reg clk_a_div_reg9 = 1'b0;
  reg i_i2c_cmd6E_b0 = 1'b1;
  reg i_i2c_cmd68_b6 = 1'b1;
  reg i_i2c_cmd6A_b6 = 1'b0;
  reg i_i2c_cmd69_b7 = 1'b0;
  reg o_i2c_cmd6D_b0 = 1'b0;
  reg o_i2c_cmd6D_b3 = 1'b0;
  reg o_i2c_cmd6D_b2 = 1'b0;
  reg o_i2c_cmd6C_b0 = 1'b0;
  reg o_i2c_cmd69_b3 = 1'b0;
  reg o_i2c_cmd69_b4 = 1'b0;
  reg i2c_clk_div_reg2 = 1'b0;
  reg i2c_clk_div_reg13 = 1'b0;
  reg i2c_clk_div_reg6 = 1'b0;
  reg i2c_clk_div_reg14 = 1'b0;
  reg i_i2c_cmd6A_b4 = 1'b1;
  reg i_i2c_cmd68_b7 = 1'b1;
  reg clk_a_div_reg2 = 1'b0;
  reg i_i2c_cmd6C_b0 = 1'b1;
  reg i_i2c_cmd6E_b1 = 1'b0;
  reg i_i2c_cmd6A_b0 = 1'b0;
  reg i_i2c_cmd6E_b2 = 1'b1;
  reg i_i2c_cmd68_b0 = 1'b1;
  reg o_i2c_cmd6E_b0 = 1'b0;
  reg o_i2c_cmd6A_b7 = 1'b0;
  reg o_i2c_cmd69_b2 = 1'b0;
  reg o_i2c_cmd69_b6 = 1'b0;
  reg o_i2c_cmd6D_b4 = 1'b0;
  reg o_i2c_cmd6A_b3 = 1'b0;
  reg i2c_clk_div_reg0 = 1'b0;
  reg i2c_clk_div_reg1 = 1'b0;
  reg i2c_clk_div_reg3 = 1'b0;
  reg i2c_clk_div_reg4 = 1'b0;
  reg i2c_clk_div_reg10 = 1'b0;
  reg i2c_clk_div_reg7 = 1'b0;
  reg i2c_clk_div_reg11 = 1'b0;
  reg i2c_clk_div_reg12 = 1'b0;
  reg i2c_clk_div_reg15 = 1'b0;
  reg i2c_clk_div_reg5 = 1'b0;
  reg i_i2c_cmd68_b5 = 1'b1;
  reg i2c_state_r5 = 1'b0;
  reg i_i2c_cmd6A_b7 = 1'b1;
  reg i_i2c_cmd68_b1 = 1'b1;
  reg o_i2c_cmd69_b0 = 1'b0;
  reg o_i2c_cmd68_b0 = 1'b0;
  reg o_i2c_cmd6E_b1 = 1'b0;
  reg o_i2c_cmd6D_b7 = 1'b0;
  reg o_i2c_cmd6B_b5 = 1'b0;
  reg o_i2c_cmd6A_b6 = 1'b0;
  reg o_i2c_cmd6A_b4 = 1'b0;
  reg o_i2c_cmd68_b5 = 1'b0;
  reg o_i2c_cmd68_b1 = 1'b0;
  reg o_i2c_cmd68_b3 = 1'b0;
  reg i2c_clk_div_reg9 = 1'b0;
  reg i2c_clk_div_reg8 = 1'b0;
  reg i2c_state_r6 = 1'b0;
  reg i2c_clock = 1'b0;
  reg i2c_state_r1 = 1'b0;
  reg i2c_state_r2 = 1'b0;
  reg i2c_state_r3 = 1'b0;
  reg i2c_state_r4 = 1'b0;
  reg i2c_state_r10 = 1'b0;
  reg i2c_state_r7 = 1'b0;
  reg i2c_state_r11 = 1'b0;
  reg i2c_state_r12 = 1'b0;
  reg i2c_state_r15 = 1'b0;
  reg i_i2c_cmd6A_b1 = 1'b0;
  reg o_i2c_cmd6E_b3 = 1'b0;
  reg i_i2c_cmd6B_b4 = 1'b0;
  reg o_i2c_cmd69_b1 = 1'b0;
  reg i_i2c_cmd6C_b7 = 1'b0;
  reg o_i2c_cmd6B_b7 = 1'b0;
  reg o_i2c_cmd6C_b6 = 1'b0;
  reg o_i2c_cmd6A_b5 = 1'b0;
  reg o_i2c_cmd68_b7 = 1'b0;
  reg o_i2c_cmd69_b7 = 1'b0;
  reg o_i2c_cmd68_b6 = 1'b0;
  reg o_i2c_cmd68_b4 = 1'b0;
  reg i2c_state_r13 = 1'b0;
  reg i2c_session_done = 1'b0;
  reg i2c_state_r9 = 1'b0;
  reg i2c_state_r8 = 1'b0;
  reg i2c_state_r0 = 1'b0;
  reg i2c_state_r14 = 1'b0;
  reg i_i2c_cmd6A_b5 = 1'b1;
  reg o_i2c_cmd6B_b6 = 1'b0;
  reg o_i2c_cmd68_b2 = 1'b0;
  reg o_i2c_cmd6A_b2 = 1'b0;
  reg o_i2c_cmd6A_b0 = 1'b0;
  reg o_i2c_cmd6A_b1 = 1'b0;
  reg o_i2c_cmd6E_b2 = 1'b0;

//---------------------------------------------------------------------------
//Bidirectional and output pad assignments

  assign o_i2c_scl = i2c_scl;
  assign io_i2c_sda = i2c_sda_dir ? o_i2c_sda : 1'bZ;
  assign io_mcu_d_4 = mcu_data_dir ? o_mcu_d_4 : 1'bZ;
  assign io_mcu_d_5 = mcu_data_dir ? o_mcu_d_5 : 1'bZ;
  assign io_mcu_d_6 = mcu_data_dir ? o_mcu_d_6 : 1'bZ;
  assign io_mcu_d_7 = mcu_data_dir ? o_mcu_d_7 : 1'bZ;
  assign o_pwm_display = pwm_display;
  assign io_mcu_d_2 = mcu_data_dir ? o_mcu_d_2 : 1'bZ;
  assign io_mcu_d_3 = mcu_data_dir ? o_mcu_d_3 : 1'bZ;
  assign io_mcu_d_1 = mcu_data_dir ? o_mcu_d_1 : 1'bZ;
  assign io_mcu_d_0 = mcu_data_dir ? o_mcu_d_0 : 1'bZ;
  assign o_1khz_calib = calib_1khz;
  assign o_ac_dc_2 = ac_dc_2;
  assign o_adc1_encB = adc1_encB;
  assign o_ac_dc_1 = ac_dc_1;
  assign o_relay2_1 = relay2_1;
  assign o_relay2_2 = relay2_2;
  assign o_relay2_3 = relay2_3;
  assign o_relay1_3 = relay1_3;
  assign o_relay1_2 = relay1_2;
  assign o_relay1_1 = relay1_1;
  assign o_offset_1 = offset_1;
  assign o_adc2_encA = adc2_encA;
  assign o_offset_2 = offset_2;
  assign o_adc1_encA = adc1_encA;
  assign o_adc2_encB = adc2_encB;

//---------------------------------------------------------------------------
//Clock assignments


//---------------------------------------------------------------------------
//Block 49, MSLICE 1

  assign sample_read_clock = (~i_mcu_clk & ((sample_write_clock & ~sample_read_enable))) | (i_mcu_clk & ((sample_write_clock | sample_read_enable)));
  assign read_addr_10 = (~smp_read_offset_r10 & ((~sample_read_enable & pre_trigger_addr10))) | (smp_read_offset_r10 & ((sample_read_enable | pre_trigger_addr10)));

  always @(posedge sample_read_clock)
  begin
    read_addr_l10 <= read_addr_10;
  end

//---------------------------------------------------------------------------
//Block 54, MSLICE 1

  assign sig_54_lut_0 = (~read_addr_l10 & ~read_addr_l11) | (~read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_2 & ~o_adc1B_d3_2) | (~o_adc1B_d2_2 & o_adc1B_d3_2))) | (read_addr_l10 & ~read_addr_l11) | (read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_2 & ~o_adc1B_d3_2) | (o_adc1B_d2_2 & ~o_adc1B_d3_2)));
  assign sig_54_lut_1 = 1'b0;
  assign read_adc1B_b2 = (~read_adc1B_l_b2 & sig_54_lut_0) | (read_adc1B_l_b2 & sig_54_lut_1);

//---------------------------------------------------------------------------
//Block 55, LSLICE 3

  assign read_adc2A_b7 = (~read_adc2A_h_b7 & ~read_addr_l10 & ~read_addr_l11 & ((o_adc2A_d0_7 & ~o_adc2A_d1_7) | (o_adc2A_d0_7 & o_adc2A_d1_7))) | (~read_adc2A_h_b7 & ~read_addr_l10 & read_addr_l11) | (~read_adc2A_h_b7 & read_addr_l10 & ~read_addr_l11 & ((~o_adc2A_d0_7 & o_adc2A_d1_7) | (o_adc2A_d0_7 & o_adc2A_d1_7))) | (~read_adc2A_h_b7 & read_addr_l10 & read_addr_l11);
  assign read_adc2A_h_b7 = (~o_adc2A_d2_7 & read_addr_l11 & (~(o_adc2A_d3_7 & read_addr_l10))) | (o_adc2A_d2_7 & read_addr_l11 & ((~o_adc2A_d3_7 & read_addr_l10)));

//---------------------------------------------------------------------------
//Block 56, MSLICE 0

  assign sig_56_lut_0 = (~sampling_half_way & ~trigger_edge & ((trigger_previous_b3 & ~trigger_data_b3) | (trigger_previous_b3 & trigger_data_b3))) | (~sampling_half_way & trigger_edge & ((trigger_previous_b3 & ~trigger_data_b3) | (trigger_previous_b3 & trigger_data_b3))) | (sampling_half_way & ~trigger_edge & ((~trigger_previous_b3 & ~trigger_data_b3) | (trigger_previous_b3 & ~trigger_data_b3))) | (sampling_half_way & trigger_edge & ((~trigger_previous_b3 & ~trigger_data_b3) | (trigger_previous_b3 & ~trigger_data_b3)));
  assign sig_56_lut_1 = (~trigger_edge & ~sampling_half_way) | (~trigger_edge & sampling_half_way);
  assign sig_56_ff0_d = (~sampling_reset & sig_56_lut_0) | (sampling_reset & sig_56_lut_1);

  always @(posedge sample_write_clock)
  begin
    trigger_previous_b3 <= sig_56_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 57, LSLICE 2

  assign read_adc2A_h_b2 = (read_addr_l11 & ~read_addr_l10 & ((~o_adc2A_d2_2 & ~o_adc2A_d3_2) | (~o_adc2A_d2_2 & o_adc2A_d3_2))) | (read_addr_l11 & read_addr_l10 & ((~o_adc2A_d2_2 & ~o_adc2A_d3_2) | (o_adc2A_d2_2 & ~o_adc2A_d3_2)));
  assign read_adc2A_h_b4 = (~o_adc2A_d3_4 & read_addr_l11 & (~(o_adc2A_d2_4 & ~read_addr_l10))) | (o_adc2A_d3_4 & read_addr_l11 & ((~o_adc2A_d2_4 & ~read_addr_l10)));

//---------------------------------------------------------------------------
//Block 58, LSLICE 3

  assign read_adc2A_b3 = (~read_adc2A_h_b3 & ~read_addr_l10 & ~read_addr_l11 & ((o_adc2A_d0_3 & ~o_adc2A_d1_3) | (o_adc2A_d0_3 & o_adc2A_d1_3))) | (~read_adc2A_h_b3 & ~read_addr_l10 & read_addr_l11) | (~read_adc2A_h_b3 & read_addr_l10 & ~read_addr_l11 & ((~o_adc2A_d0_3 & o_adc2A_d1_3) | (o_adc2A_d0_3 & o_adc2A_d1_3))) | (~read_adc2A_h_b3 & read_addr_l10 & read_addr_l11);
  assign read_adc2A_h_b3 = (~o_adc2A_d3_3 & read_addr_l11 & (~(o_adc2A_d2_3 & ~read_addr_l10))) | (o_adc2A_d3_3 & read_addr_l11 & ((~o_adc2A_d2_3 & ~read_addr_l10)));

//---------------------------------------------------------------------------
//Block 59, MSLICE 1

  assign cur_vs_lev_h = ((trigger_data_b6 & trigger_level_b6));
  assign cur_vs_lev_i = ((~trigger_level_b6 & ~trigger_data_b6));

  always @(posedge i_mcu_clk)
  begin
    if(cmd17_enable == 1'b1)   //enable
     begin
      trigger_level_b6 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 60, LSLICE 2

  assign read_adc2B_b0 = (~read_adc2B_l_b0 & ~read_addr_l10 & ~read_addr_l11) | (~read_adc2B_l_b0 & ~read_addr_l10 & read_addr_l11 & ((~o_adc2B_d2_0 & ~o_adc2B_d3_0) | (~o_adc2B_d2_0 & o_adc2B_d3_0))) | (~read_adc2B_l_b0 & read_addr_l10 & ~read_addr_l11) | (~read_adc2B_l_b0 & read_addr_l10 & read_addr_l11 & ((~o_adc2B_d2_0 & ~o_adc2B_d3_0) | (o_adc2B_d2_0 & ~o_adc2B_d3_0)));
  assign read_adc2B_l_b0 = (~o_adc2B_d1_0 & o_adc2B_d0_0 & ((~read_addr_l11 & ~read_addr_l10))) | (o_adc2B_d1_0 & ~o_adc2B_d0_0 & ((~read_addr_l11 & read_addr_l10))) | (o_adc2B_d1_0 & o_adc2B_d0_0 & ((~read_addr_l11 & ~read_addr_l10) | (~read_addr_l11 & read_addr_l10)));

//---------------------------------------------------------------------------
//Block 61, MSLICE 1

  assign sig_61_lut_0 = (~read_addr_l10 & ~read_addr_l11 & ((o_adc2A_d0_2 & ~o_adc2A_d1_2) | (o_adc2A_d0_2 & o_adc2A_d1_2))) | (~read_addr_l10 & read_addr_l11) | (read_addr_l10 & ~read_addr_l11 & ((~o_adc2A_d0_2 & o_adc2A_d1_2) | (o_adc2A_d0_2 & o_adc2A_d1_2))) | (read_addr_l10 & read_addr_l11);
  assign sig_61_lut_1 = 1'b0;
  assign read_adc2A_b2 = (~read_adc2A_h_b2 & sig_61_lut_0) | (read_adc2A_h_b2 & sig_61_lut_1);

//---------------------------------------------------------------------------
//MSLICE adder blocks 62, 63, 64, 66, 67, 68, 69

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      { sample_addr_11, sample_addr_10, sample_addr_9, sample_addr_8, sample_addr_7, sample_addr_6, sample_addr_5, sample_addr_4, sample_addr_3, sample_addr_2, sample_addr_1, sample_addr_0 } <= { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      { sample_addr_11, sample_addr_10, sample_addr_9, sample_addr_8, sample_addr_7, sample_addr_6, sample_addr_5, sample_addr_4, sample_addr_3, sample_addr_2, sample_addr_1, sample_addr_0 } <= { sample_addr_11, sample_addr_10, sample_addr_9, sample_addr_8, sample_addr_7, sample_addr_6, sample_addr_5, sample_addr_4, sample_addr_3, sample_addr_2, sample_addr_1, sample_addr_0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
    end
  end

//---------------------------------------------------------------------------
//Block 65, LSLICE 2

  assign read_adc2B_b2 = (~read_adc2B_l_b2 & ~read_addr_l10 & ~read_addr_l11) | (~read_adc2B_l_b2 & ~read_addr_l10 & read_addr_l11 & ((~o_adc2B_d2_2 & ~o_adc2B_d3_2) | (~o_adc2B_d2_2 & o_adc2B_d3_2))) | (~read_adc2B_l_b2 & read_addr_l10 & ~read_addr_l11) | (~read_adc2B_l_b2 & read_addr_l10 & read_addr_l11 & ((~o_adc2B_d2_2 & ~o_adc2B_d3_2) | (o_adc2B_d2_2 & ~o_adc2B_d3_2)));
  assign read_adc2B_l_b2 = (~o_adc2B_d1_2 & o_adc2B_d0_2 & ((~read_addr_l10 & ~read_addr_l11))) | (o_adc2B_d1_2 & ~o_adc2B_d0_2 & ((read_addr_l10 & ~read_addr_l11))) | (o_adc2B_d1_2 & o_adc2B_d0_2 & ((~read_addr_l10 & ~read_addr_l11) | (read_addr_l10 & ~read_addr_l11)));

//---------------------------------------------------------------------------
//Block 70, LSLICE 2

  assign read_addr_3 = (~sample_read_enable & ((~smp_read_offset_r3 & pre_trigger_addr3) | (smp_read_offset_r3 & pre_trigger_addr3))) | (sample_read_enable & ((smp_read_offset_r3 & ~pre_trigger_addr3) | (smp_read_offset_r3 & pre_trigger_addr3)));
  assign read_addr_0 = (~smp_read_offset_r0 & ((pre_trigger_addr0 & ~sample_read_enable))) | (smp_read_offset_r0 & ((pre_trigger_addr0 | sample_read_enable)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      trigger_address_b3 <= 1'b0;
    end
    else
    begin
      if(net_50 == 1'b1)   //enable
       begin
        trigger_address_b3 <= pre_trigger_addr3;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 71, MSLICE 1

  assign read_addr_9 = (~sample_read_enable & ((pre_trigger_addr9 & ~smp_read_offset_r9) | (pre_trigger_addr9 & smp_read_offset_r9))) | (sample_read_enable & ((~pre_trigger_addr9 & smp_read_offset_r9) | (pre_trigger_addr9 & smp_read_offset_r9)));
  assign net_50 = ~sampling_triggered;

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      trigger_address_b9 <= 1'b0;
      trigger_address_b0 <= 1'b0;
    end
    else
    begin
      if(net_50 == 1'b1)   //enable
       begin
        trigger_address_b9 <= pre_trigger_addr9;
        trigger_address_b0 <= pre_trigger_addr0;
      end
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 72, 73, 74, 76, 77, 78, 79, 80, 81

  always @(posedge clk_50MHz)
  begin
    if(offset2_pwm_rst == 1'b1)   //reset
    begin
      { offset2_pwm_r15, offset2_pwm_r14, offset2_pwm_r13, offset2_pwm_r12, offset2_pwm_r11, offset2_pwm_r10, offset2_pwm_r9, offset2_pwm_r8, offset2_pwm_r7, offset2_pwm_r6, offset2_pwm_r5, offset2_pwm_r4, offset2_pwm_r3, offset2_pwm_r2, offset2_pwm_r1, offset2_pwm_r0 } <= { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      { offset2_pwm_r15, offset2_pwm_r14, offset2_pwm_r13, offset2_pwm_r12, offset2_pwm_r11, offset2_pwm_r10, offset2_pwm_r9, offset2_pwm_r8, offset2_pwm_r7, offset2_pwm_r6, offset2_pwm_r5, offset2_pwm_r4, offset2_pwm_r3, offset2_pwm_r2, offset2_pwm_r1, offset2_pwm_r0 } <= { offset2_pwm_r15, offset2_pwm_r14, offset2_pwm_r13, offset2_pwm_r12, offset2_pwm_r11, offset2_pwm_r10, offset2_pwm_r9, offset2_pwm_r8, offset2_pwm_r7, offset2_pwm_r6, offset2_pwm_r5, offset2_pwm_r4, offset2_pwm_r3, offset2_pwm_r2, offset2_pwm_r1, offset2_pwm_r0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
    end
  end

//---------------------------------------------------------------------------
//Block 75, LSLICE 2

  assign net_62 = (~offset2_pwm_r2 & ~ch2_offset_b2 & ~net_63 & (~(offset2_pwm_r3 & ~ch2_offset_b3))) | (~offset2_pwm_r2 & ch2_offset_b2 & ~net_63 & (~(offset2_pwm_r3 & ~ch2_offset_b3))) | (~offset2_pwm_r2 & ch2_offset_b2 & net_63 & (~(offset2_pwm_r3 & ~ch2_offset_b3))) | (offset2_pwm_r2 & ch2_offset_b2 & ~net_63 & (~(offset2_pwm_r3 & ~ch2_offset_b3)));
  assign net_63 = (~offset2_pwm_r0 & ~ch2_offset_b0 & (~(~offset2_pwm_r1 & ch2_offset_b1))) | (~offset2_pwm_r0 & ch2_offset_b0 & ((offset2_pwm_r1 & ~ch2_offset_b1))) | (offset2_pwm_r0 & ~ch2_offset_b0 & (~(~offset2_pwm_r1 & ch2_offset_b1))) | (offset2_pwm_r0 & ch2_offset_b0 & (~(~offset2_pwm_r1 & ch2_offset_b1)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd35_enable1 == 1'b1)   //enable
     begin
      ch2_offset_b2 <= io_mcu_d_2;
      ch2_offset_b1 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 131, LSLICE 3

  assign read_adc1B_l_b2 = (~o_adc1B_d0_2 & read_addr_l10 & ((~read_addr_l11 & o_adc1B_d1_2))) | (o_adc1B_d0_2 & ~read_addr_l10 & ((~read_addr_l11 & ~o_adc1B_d1_2) | (~read_addr_l11 & o_adc1B_d1_2))) | (o_adc1B_d0_2 & read_addr_l10 & ((~read_addr_l11 & o_adc1B_d1_2)));
  assign read_adc2A_h_b0 = (~o_adc2A_d3_0 & read_addr_l11 & (~(o_adc2A_d2_0 & ~read_addr_l10))) | (o_adc2A_d3_0 & read_addr_l11 & ((~o_adc2A_d2_0 & ~read_addr_l10)));

//---------------------------------------------------------------------------
//Block 132, LSLICE 2

  assign read_adc2A_b1 = (~read_adc2A_h_b1 & ~read_addr_l10 & ~read_addr_l11 & ((o_adc2A_d0_1 & ~o_adc2A_d1_1) | (o_adc2A_d0_1 & o_adc2A_d1_1))) | (~read_adc2A_h_b1 & ~read_addr_l10 & read_addr_l11) | (~read_adc2A_h_b1 & read_addr_l10 & ~read_addr_l11 & ((~o_adc2A_d0_1 & o_adc2A_d1_1) | (o_adc2A_d0_1 & o_adc2A_d1_1))) | (~read_adc2A_h_b1 & read_addr_l10 & read_addr_l11);
  assign read_adc2A_h_b1 = (~o_adc2A_d3_1 & ~o_adc2A_d2_1 & ((~read_addr_l10 & read_addr_l11) | (read_addr_l10 & read_addr_l11))) | (~o_adc2A_d3_1 & o_adc2A_d2_1 & ((read_addr_l10 & read_addr_l11))) | (o_adc2A_d3_1 & ~o_adc2A_d2_1 & ((~read_addr_l10 & read_addr_l11)));

//---------------------------------------------------------------------------
//Block 133, LSLICE 3

  assign read_adc1B_l_b5 = (~read_addr_l11 & ~read_addr_l10 & ((o_adc1B_d0_5 & ~o_adc1B_d1_5) | (o_adc1B_d0_5 & o_adc1B_d1_5))) | (~read_addr_l11 & read_addr_l10 & ((~o_adc1B_d0_5 & o_adc1B_d1_5) | (o_adc1B_d0_5 & o_adc1B_d1_5)));
  assign read_adc2A_h_b6 = (~o_adc2A_d2_6 & ~o_adc2A_d3_6 & ((read_addr_l11 & ~read_addr_l10) | (read_addr_l11 & read_addr_l10))) | (~o_adc2A_d2_6 & o_adc2A_d3_6 & ((read_addr_l11 & ~read_addr_l10))) | (o_adc2A_d2_6 & ~o_adc2A_d3_6 & ((read_addr_l11 & read_addr_l10)));

//---------------------------------------------------------------------------
//Block 134, MSLICE 1

  assign sig_134_lut_0 = 1'b0;
  assign sig_134_lut_1 = (~cmd21_select & ~read_addr_l10) | (~cmd21_select & read_addr_l10) | (cmd21_select & ~read_addr_l10 & ((~o_adc1B_d2_1 & ~o_adc1B_d3_1) | (~o_adc1B_d2_1 & o_adc1B_d3_1))) | (cmd21_select & read_addr_l10 & ((~o_adc1B_d2_1 & ~o_adc1B_d3_1) | (o_adc1B_d2_1 & ~o_adc1B_d3_1)));
  assign cmd21_adc1B_h_b1 = (~read_addr_l11 & sig_134_lut_0) | (read_addr_l11 & sig_134_lut_1);

//---------------------------------------------------------------------------
//Block 135, MSLICE 0

  assign sig_135_lut_0 = (~read_addr_l10 & ~read_addr_l11) | (~read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_5 & ~o_adc1B_d3_5) | (~o_adc1B_d2_5 & o_adc1B_d3_5))) | (read_addr_l10 & ~read_addr_l11) | (read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_5 & ~o_adc1B_d3_5) | (o_adc1B_d2_5 & ~o_adc1B_d3_5)));
  assign sig_135_lut_1 = 1'b0;
  assign read_adc1B_b5 = (~read_adc1B_l_b5 & sig_135_lut_0) | (read_adc1B_l_b5 & sig_135_lut_1);

//---------------------------------------------------------------------------
//Block 136, LSLICE 2

  assign prev_vs_lev_g = ((~trigger_level_b6 & trigger_previous_b6));
  assign prev_vs_lev_d = ((trigger_level_b4 & ~trigger_previous_b4));

//---------------------------------------------------------------------------
//Block 137, MSLICE 1

  assign sig_137_lut_0 = (~sampling_half_way & ~trigger_edge & ((trigger_previous_b6 & ~trigger_data_b6) | (trigger_previous_b6 & trigger_data_b6))) | (~sampling_half_way & trigger_edge & ((trigger_previous_b6 & ~trigger_data_b6) | (trigger_previous_b6 & trigger_data_b6))) | (sampling_half_way & ~trigger_edge & ((~trigger_previous_b6 & ~trigger_data_b6) | (trigger_previous_b6 & ~trigger_data_b6))) | (sampling_half_way & trigger_edge & ((~trigger_previous_b6 & ~trigger_data_b6) | (trigger_previous_b6 & ~trigger_data_b6)));
  assign sig_137_lut_1 = (~sampling_half_way & ~trigger_edge) | (sampling_half_way & ~trigger_edge);
  assign sig_137_ff0_d = (~sampling_reset & sig_137_lut_0) | (sampling_reset & sig_137_lut_1);

  always @(posedge sample_write_clock)
  begin
    trigger_previous_b6 <= sig_137_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 138, MSLICE 1

  assign sig_138_lut_0 = (~sampling_half_way & ~trigger_edge & ((trigger_previous_b7 & ~trigger_data_b7) | (trigger_previous_b7 & trigger_data_b7))) | (~sampling_half_way & trigger_edge & ((trigger_previous_b7 & ~trigger_data_b7) | (trigger_previous_b7 & trigger_data_b7))) | (sampling_half_way & ~trigger_edge & ((~trigger_previous_b7 & ~trigger_data_b7) | (trigger_previous_b7 & ~trigger_data_b7))) | (sampling_half_way & trigger_edge & ((~trigger_previous_b7 & ~trigger_data_b7) | (trigger_previous_b7 & ~trigger_data_b7)));
  assign sig_138_lut_1 = (~sampling_half_way & ~trigger_edge) | (sampling_half_way & ~trigger_edge);
  assign sig_138_ff0_d = (~sampling_reset & sig_138_lut_0) | (sampling_reset & sig_138_lut_1);

  always @(posedge sample_write_clock)
  begin
    trigger_previous_b7 <= sig_138_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 139, MSLICE 0

  assign sig_139_lut_0 = (~read_addr_l10 & ~read_addr_l11 & ((o_adc2A_d0_4 & ~o_adc2A_d1_4) | (o_adc2A_d0_4 & o_adc2A_d1_4))) | (~read_addr_l10 & read_addr_l11) | (read_addr_l10 & ~read_addr_l11 & ((~o_adc2A_d0_4 & o_adc2A_d1_4) | (o_adc2A_d0_4 & o_adc2A_d1_4))) | (read_addr_l10 & read_addr_l11);
  assign sig_139_lut_1 = 1'b0;
  assign read_adc2A_b4 = (~read_adc2A_h_b4 & sig_139_lut_0) | (read_adc2A_h_b4 & sig_139_lut_1);

//---------------------------------------------------------------------------
//Block 140, LSLICE 2

  assign trigger_rise_detect = (~trigger_level_b7 & ~cur_vs_lev_g & ~cur_vs_lev_i & ((~trigger_data_b7 & trigger_rise_enable))) | (~trigger_level_b7 & ~cur_vs_lev_g & cur_vs_lev_i & ((~trigger_data_b7 & trigger_rise_enable) | (trigger_data_b7 & trigger_rise_enable))) | (~trigger_level_b7 & cur_vs_lev_g & ~cur_vs_lev_i & ((~trigger_data_b7 & trigger_rise_enable) | (trigger_data_b7 & trigger_rise_enable))) | (~trigger_level_b7 & cur_vs_lev_g & cur_vs_lev_i & ((~trigger_data_b7 & trigger_rise_enable) | (trigger_data_b7 & trigger_rise_enable))) | (trigger_level_b7 & ~cur_vs_lev_g & cur_vs_lev_i & ((~trigger_data_b7 & trigger_rise_enable))) | (trigger_level_b7 & cur_vs_lev_g & ~cur_vs_lev_i & ((~trigger_data_b7 & trigger_rise_enable))) | (trigger_level_b7 & cur_vs_lev_g & cur_vs_lev_i & ((~trigger_data_b7 & trigger_rise_enable)));
  assign trigger_rise_enable = (~trigger_level_b7 & ~prev_less_equal_lev & ~trigger_previous_b7 & ((trigger_detect_enable & ~trigger_edge))) | (~trigger_level_b7 & ~prev_less_equal_lev & trigger_previous_b7 & ((trigger_detect_enable & ~trigger_edge))) | (~trigger_level_b7 & prev_less_equal_lev & ~trigger_previous_b7 & ((~trigger_detect_enable & ~trigger_edge) | (trigger_detect_enable & ~trigger_edge))) | (~trigger_level_b7 & prev_less_equal_lev & trigger_previous_b7 & ((~trigger_detect_enable & ~trigger_edge) | (trigger_detect_enable & ~trigger_edge))) | (trigger_level_b7 & ~prev_less_equal_lev & ~trigger_previous_b7 & ((~trigger_detect_enable & ~trigger_edge) | (trigger_detect_enable & ~trigger_edge))) | (trigger_level_b7 & ~prev_less_equal_lev & trigger_previous_b7 & ((trigger_detect_enable & ~trigger_edge))) | (trigger_level_b7 & prev_less_equal_lev & ~trigger_previous_b7 & ((~trigger_detect_enable & ~trigger_edge) | (trigger_detect_enable & ~trigger_edge))) | (trigger_level_b7 & prev_less_equal_lev & trigger_previous_b7 & ((~trigger_detect_enable & ~trigger_edge) | (trigger_detect_enable & ~trigger_edge)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd17_enable == 1'b1)   //enable
     begin
      trigger_level_b7 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 141, LSLICE 3

  assign read_adc2A_b5 = (~read_adc2A_h_b5 & ~read_addr_l10 & ~read_addr_l11 & ((o_adc2A_d0_5 & ~o_adc2A_d1_5) | (o_adc2A_d0_5 & o_adc2A_d1_5))) | (~read_adc2A_h_b5 & ~read_addr_l10 & read_addr_l11) | (~read_adc2A_h_b5 & read_addr_l10 & ~read_addr_l11 & ((~o_adc2A_d0_5 & o_adc2A_d1_5) | (o_adc2A_d0_5 & o_adc2A_d1_5))) | (~read_adc2A_h_b5 & read_addr_l10 & read_addr_l11);
  assign read_adc2A_h_b5 = (~o_adc2A_d3_5 & ~o_adc2A_d2_5 & ((read_addr_l11 & ~read_addr_l10) | (read_addr_l11 & read_addr_l10))) | (~o_adc2A_d3_5 & o_adc2A_d2_5 & ((read_addr_l11 & read_addr_l10))) | (o_adc2A_d3_5 & ~o_adc2A_d2_5 & ((read_addr_l11 & ~read_addr_l10)));

//---------------------------------------------------------------------------
//Block 142, MSLICE 1

  assign sig_142_lut_0 = (~read_addr_l10 & ~read_addr_l11 & ((o_adc2A_d0_6 & ~o_adc2A_d1_6) | (o_adc2A_d0_6 & o_adc2A_d1_6))) | (~read_addr_l10 & read_addr_l11) | (read_addr_l10 & ~read_addr_l11 & ((~o_adc2A_d0_6 & o_adc2A_d1_6) | (o_adc2A_d0_6 & o_adc2A_d1_6))) | (read_addr_l10 & read_addr_l11);
  assign sig_142_lut_1 = 1'b0;
  assign read_adc2A_b6 = (~read_adc2A_h_b6 & sig_142_lut_0) | (read_adc2A_h_b6 & sig_142_lut_1);

//---------------------------------------------------------------------------
//Block 143, MSLICE 0

  assign sampling_enable = (~sampling_triggered & (~(~trigger_mode & time_base_timeout)));
  assign trigger_check_enable = ((~sampling_triggered & sampling_half_way));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      sample_write_enable <= 1'b1;
    end
    else
    begin
      if(sampling_enable == 1'b0)   //enable
       begin
        sample_write_enable <= 1'b0;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 144, LSLICE 3

  assign cmd38_enable0 = (cmd38_select & i_mcu_rws & ((byte_state_0 & ~i_mcu_dcs)));
  assign net_175 = (~o_mcu_d_0 & ~byte_state_1 & ((~byte_state_0 & ~trigger_address_b0) | (~byte_state_0 & trigger_address_b0))) | (~o_mcu_d_0 & byte_state_1 & ((~byte_state_0 & ~trigger_address_b0))) | (o_mcu_d_0 & byte_state_1 & ((~byte_state_0 & ~trigger_address_b0)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable0 == 1'b1)   //enable
     begin
      disp_bright_b10 <= io_mcu_d_2;
      disp_bright_b15 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 145, MSLICE 1

  assign cmdxxxxxx11_select = ((cmd_b0 & cmd_b1));
  assign cmd23_select = ((cmd001000xx_select & cmdxxxxxx11_select));

//---------------------------------------------------------------------------
//Block 146, LSLICE 2

  assign cmd1A_enable = (cmd_b3 & cmd1x_data_write & cmd_b1 & ((~cmd_b2 & ~cmd_b0)));
  assign cmd1x_data_write = (cmd1x_select & ((i_mcu_rws & ~i_mcu_dcs)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd1A_enable == 1'b1)   //enable
     begin
      trigger_mode <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 147, MSLICE 1

  assign cmd35_enable1 = (i_mcu_rws & cmd35_select & ((byte_state_1 & ~i_mcu_dcs)));
  assign net_180 = ((~ch2_offset_b6 & offset2_pwm_r6));

  always @(posedge i_mcu_clk)
  begin
    if(cmd35_enable1 == 1'b1)   //enable
     begin
      ch2_offset_b0 <= io_mcu_d_0;
      ch2_offset_b6 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 148, LSLICE 3

  assign cmd0F_enable = (cmdxxxxxx11_select & cmd_b2 & ((cmd_b3 & cmd0x_data_write)));
  assign cmd6B_select = (cmd_b3 & cmd6x_select & ((~cmd_b2 & cmdxxxxxx11_select)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0F_enable == 1'b1)   //enable
     begin
      sample_read_enable <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 149, 150, 151, 154, 155, 156, 158

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      { pre_trigger_addr11, pre_trigger_addr10, pre_trigger_addr9, pre_trigger_addr8, pre_trigger_addr7, pre_trigger_addr6, pre_trigger_addr5, pre_trigger_addr4, pre_trigger_addr3, pre_trigger_addr2, pre_trigger_addr1, pre_trigger_addr0 } <= { 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      if(sampling_half_way == 1'b1)   //enable
      begin
        { pre_trigger_addr11, pre_trigger_addr10, pre_trigger_addr9, pre_trigger_addr8, pre_trigger_addr7, pre_trigger_addr6, pre_trigger_addr5, pre_trigger_addr4, pre_trigger_addr3, pre_trigger_addr2, pre_trigger_addr1, pre_trigger_addr0 } <= { pre_trigger_addr11, pre_trigger_addr10, pre_trigger_addr9, pre_trigger_addr8, pre_trigger_addr7, pre_trigger_addr6, pre_trigger_addr5, pre_trigger_addr4, pre_trigger_addr3, pre_trigger_addr2, pre_trigger_addr1, pre_trigger_addr0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
      end
    end
  end

//---------------------------------------------------------------------------
//Block 152, LSLICE 2

  assign cmd001000xx_select = (cmd2x_select & ((~cmd_b2 & ~cmd_b3)));
  assign cmdxxxx01xx_select = ((~cmd_b3 & cmd_b2));

//---------------------------------------------------------------------------
//Block 153, LSLICE 3

  assign net_195 = (~byte_state_1 & ~byte_state_0 & ((~o_mcu_d_0 & ~cmd3C_b8) | (~o_mcu_d_0 & cmd3C_b8))) | (byte_state_1 & ~byte_state_0 & ((~o_mcu_d_0 & ~cmd3C_b8) | (o_mcu_d_0 & ~cmd3C_b8)));
  assign net_198 = (~o_mcu_d_3 & ~byte_state_1 & ((~byte_state_0 & ~cmd3C_b11) | (~byte_state_0 & cmd3C_b11))) | (~o_mcu_d_3 & byte_state_1 & ((~byte_state_0 & ~cmd3C_b11))) | (o_mcu_d_3 & byte_state_1 & ((~byte_state_0 & ~cmd3C_b11)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable1 == 1'b1)   //enable
     begin
      cmd3C_b13 <= io_mcu_d_5;
      cmd3C_b11 <= io_mcu_d_3;
    end
  end

//---------------------------------------------------------------------------
//Block 157, LSLICE 3

  assign net_204 = (~net_205 & cmd14_select & (~(~trigger_address_b11 & byte_state_0)));
  assign net_205 = (~byte_state_1 & ~byte_state_0 & ((~o_mcu_d_3 & ~trigger_address_b3) | (~o_mcu_d_3 & trigger_address_b3))) | (byte_state_1 & ~byte_state_0 & ((~o_mcu_d_3 & ~trigger_address_b3) | (o_mcu_d_3 & ~trigger_address_b3)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      trigger_address_b11 <= 1'b0;
    end
    else
    begin
      if(net_50 == 1'b1)   //enable
       begin
        trigger_address_b11 <= pre_trigger_addr11;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 159, LSLICE 3

  assign net_209 = (~net_210 & ~ch2_offset_b5 & ~offset2_pwm_r5 & (~(offset2_pwm_r4 & ~ch2_offset_b4))) | (~net_210 & ch2_offset_b5 & ~offset2_pwm_r5 & (~(offset2_pwm_r4 & ~ch2_offset_b4))) | (~net_210 & ch2_offset_b5 & offset2_pwm_r5 & (~(offset2_pwm_r4 & ~ch2_offset_b4)));
  assign net_210 = (~net_62 & ~offset2_pwm_r4 & ~ch2_offset_b4 & (~(ch2_offset_b3 & ~offset2_pwm_r3))) | (~net_62 & offset2_pwm_r4 & ~ch2_offset_b4 & (~(ch2_offset_b3 & ~offset2_pwm_r3))) | (~net_62 & offset2_pwm_r4 & ch2_offset_b4 & (~(ch2_offset_b3 & ~offset2_pwm_r3)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd35_enable1 == 1'b1)   //enable
     begin
      ch2_offset_b4 <= io_mcu_d_4;
      ch2_offset_b3 <= io_mcu_d_3;
    end
  end

//---------------------------------------------------------------------------
//Block 160, LSLICE 2

  assign net_214 = (~offset2_pwm_r7 & ~ch2_offset_b7 & ~net_180 & (~(offset2_pwm_r8 & ~ch2_offset_b8))) | (~offset2_pwm_r7 & ch2_offset_b7 & ~net_180 & (~(offset2_pwm_r8 & ~ch2_offset_b8))) | (~offset2_pwm_r7 & ch2_offset_b7 & net_180 & (~(offset2_pwm_r8 & ~ch2_offset_b8))) | (offset2_pwm_r7 & ch2_offset_b7 & ~net_180 & (~(offset2_pwm_r8 & ~ch2_offset_b8)));
  assign net_216 = (~ch2_offset_b7 & ~ch2_offset_b5) | (~ch2_offset_b7 & ch2_offset_b5 & ((~offset2_pwm_r7 & offset2_pwm_r5) | (offset2_pwm_r7 & offset2_pwm_r5))) | (ch2_offset_b7 & ~ch2_offset_b5 & ((offset2_pwm_r7 & ~offset2_pwm_r5) | (offset2_pwm_r7 & offset2_pwm_r5))) | (ch2_offset_b7 & ch2_offset_b5 & ((offset2_pwm_r7 & offset2_pwm_r5)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd35_enable1 == 1'b1)   //enable
     begin
      ch2_offset_b7 <= io_mcu_d_7;
      ch2_offset_b5 <= io_mcu_d_5;
    end
  end

//---------------------------------------------------------------------------
//Block 161, LSLICE 3

  assign offset2_pwm_rst = (~net_381 & ~net_212 & ~offset2_pwm_r9) | (~net_381 & ~net_212 & offset2_pwm_r9) | (~net_381 & net_212 & ~offset2_pwm_r9) | (~net_381 & net_212 & offset2_pwm_r9) | (net_381 & net_212 & offset2_pwm_r9 & ((offset2_pwm_r8 & offset2_pwm_r7)));
  assign net_212 = (offset2_pwm_r10 & ~offset2_pwm_r5 & ((offset2_pwm_r6 & offset2_pwm_r4))) | (offset2_pwm_r10 & offset2_pwm_r5 & ((offset2_pwm_r6 & ~offset2_pwm_r4) | (offset2_pwm_r6 & offset2_pwm_r4)));

//---------------------------------------------------------------------------
//Block 162, MSLICE 0

  assign sig_162_lut_0 = 1'b0;
  assign sig_162_lut_1 = (net_221 & ~ch2_offset_b6 & ((~offset2_pwm_r6 & ~net_209))) | (net_221 & ch2_offset_b6 & ((offset2_pwm_r6 & ~net_209)));
  assign net_213 = (~net_216 & sig_162_lut_0) | (net_216 & sig_162_lut_1);

//---------------------------------------------------------------------------
//Block 163, MSLICE 1

  assign sig_163_lut_0 = (~net_213 & ~net_223 & ((offset2_pwm_r10 & ~ch2_offset_b10))) | (~net_213 & net_223 & (~(~offset2_pwm_r10 & ch2_offset_b10))) | (net_213 & ~net_223 & (~(~offset2_pwm_r10 & ch2_offset_b10))) | (net_213 & net_223 & (~(~offset2_pwm_r10 & ch2_offset_b10)));
  assign sig_163_lut_1 = (~net_213 & ~net_223 & (~(~offset2_pwm_r10 & ch2_offset_b10))) | (~net_213 & net_223 & (~(~offset2_pwm_r10 & ch2_offset_b10))) | (net_213 & ~net_223 & (~(~offset2_pwm_r10 & ch2_offset_b10))) | (net_213 & net_223 & (~(~offset2_pwm_r10 & ch2_offset_b10)));
  assign net_218 = (~net_220 & sig_163_lut_0) | (net_220 & sig_163_lut_1);

//---------------------------------------------------------------------------
//Block 164, MSLICE 1

  assign net_220 = (~net_224 & ~net_214 & (~(~offset2_pwm_r8 & ch2_offset_b8)));
  assign net_221 = (~ch2_offset_b8 & ((~offset2_pwm_r8 & ~net_224) | (offset2_pwm_r8 & ~net_224))) | (ch2_offset_b8 & ((offset2_pwm_r8 & ~net_224)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd35_enable0 == 1'b1)   //enable
     begin
      ch2_offset_b8 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 165, MSLICE 0

  assign net_224 = ((~offset2_pwm_r9 & ch2_offset_b9));
  assign net_223 = ((~ch2_offset_b9 & offset2_pwm_r9));

  always @(posedge i_mcu_clk)
  begin
    if(cmd35_enable0 == 1'b1)   //enable
     begin
      ch2_offset_b9 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 170, LSLICE 2

  assign read_adc1B_b7 = (~read_adc1B_l_b7 & ~read_addr_l10 & ~read_addr_l11) | (~read_adc1B_l_b7 & ~read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_7 & ~o_adc1B_d3_7) | (~o_adc1B_d2_7 & o_adc1B_d3_7))) | (~read_adc1B_l_b7 & read_addr_l10 & ~read_addr_l11) | (~read_adc1B_l_b7 & read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_7 & ~o_adc1B_d3_7) | (o_adc1B_d2_7 & ~o_adc1B_d3_7)));
  assign read_adc1B_l_b7 = (~o_adc1B_d0_7 & ~read_addr_l11 & ((o_adc1B_d1_7 & read_addr_l10))) | (o_adc1B_d0_7 & ~read_addr_l11 & (~(~o_adc1B_d1_7 & read_addr_l10)));

//---------------------------------------------------------------------------
//Block 171, LSLICE 3

  assign read_adc1B_b4 = (~read_adc1B_l_b4 & ~read_addr_l10 & ~read_addr_l11) | (~read_adc1B_l_b4 & ~read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_4 & ~o_adc1B_d3_4) | (~o_adc1B_d2_4 & o_adc1B_d3_4))) | (~read_adc1B_l_b4 & read_addr_l10 & ~read_addr_l11) | (~read_adc1B_l_b4 & read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_4 & ~o_adc1B_d3_4) | (o_adc1B_d2_4 & ~o_adc1B_d3_4)));
  assign read_adc1B_l_b4 = (~o_adc1B_d1_4 & o_adc1B_d0_4 & ((~read_addr_l11 & ~read_addr_l10))) | (o_adc1B_d1_4 & ~o_adc1B_d0_4 & ((~read_addr_l11 & read_addr_l10))) | (o_adc1B_d1_4 & o_adc1B_d0_4 & ((~read_addr_l11 & ~read_addr_l10) | (~read_addr_l11 & read_addr_l10)));

//---------------------------------------------------------------------------
//Block 172, MSLICE 1

  assign sig_172_lut_0 = (~read_addr_l10 & ~cmd21_select) | (~read_addr_l10 & cmd21_select & ((~o_adc1B_d0_1 & ~o_adc1B_d1_1) | (~o_adc1B_d0_1 & o_adc1B_d1_1))) | (read_addr_l10 & ~cmd21_select) | (read_addr_l10 & cmd21_select & ((~o_adc1B_d0_1 & ~o_adc1B_d1_1) | (o_adc1B_d0_1 & ~o_adc1B_d1_1)));
  assign sig_172_lut_1 = 1'b0;
  assign cmd21_adc1B_l_b1 = (~read_addr_l11 & sig_172_lut_0) | (read_addr_l11 & sig_172_lut_1);

//---------------------------------------------------------------------------
//Block 173, MSLICE 0

  assign sig_173_lut_0 = (~read_addr_l10 & ~read_addr_l11 & ((o_adc2A_d0_0 & ~o_adc2A_d1_0) | (o_adc2A_d0_0 & o_adc2A_d1_0))) | (~read_addr_l10 & read_addr_l11) | (read_addr_l10 & ~read_addr_l11 & ((~o_adc2A_d0_0 & o_adc2A_d1_0) | (o_adc2A_d0_0 & o_adc2A_d1_0))) | (read_addr_l10 & read_addr_l11);
  assign sig_173_lut_1 = 1'b0;
  assign read_adc2A_b0 = (~read_adc2A_h_b0 & sig_173_lut_0) | (read_adc2A_h_b0 & sig_173_lut_1);

//---------------------------------------------------------------------------
//Block 174, MSLICE 1

  assign sig_174_lut_0 = (~read_addr_l10 & ~read_addr_l11) | (~read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_3 & ~o_adc1B_d3_3) | (~o_adc1B_d2_3 & o_adc1B_d3_3))) | (read_addr_l10 & ~read_addr_l11) | (read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_3 & ~o_adc1B_d3_3) | (o_adc1B_d2_3 & ~o_adc1B_d3_3)));
  assign sig_174_lut_1 = 1'b0;
  assign read_adc1B_b3 = (~read_adc1B_l_b3 & sig_174_lut_0) | (read_adc1B_l_b3 & sig_174_lut_1);

//---------------------------------------------------------------------------
//Block 175, LSLICE 3

  assign net_234 = ((cmd21_select & ~read_adc1B_b3));
  assign prev_vs_lev_h = ((trigger_level_b6 & ~trigger_previous_b6));

//---------------------------------------------------------------------------
//Block 176, MSLICE 0

  assign prev_vs_lev_e = ((~trigger_level_b4 & trigger_previous_b4));
  assign prev_vs_lev_c = ((~trigger_level_b2 & trigger_previous_b2));

//---------------------------------------------------------------------------
//Block 177, LSLICE 2

  assign prev_vs_lev_k = (~prev_vs_lev_j & ~prev_vs_lev_b & trigger_level_b3 & ((~trigger_previous_b3 & ~prev_vs_lev_e))) | (~prev_vs_lev_j & prev_vs_lev_b & ~trigger_level_b3 & ((~trigger_previous_b3 & ~prev_vs_lev_e))) | (~prev_vs_lev_j & prev_vs_lev_b & trigger_level_b3 & ((~trigger_previous_b3 & ~prev_vs_lev_e) | (trigger_previous_b3 & ~prev_vs_lev_e))) | (prev_vs_lev_j & ~prev_vs_lev_b & ~trigger_level_b3 & ((~trigger_previous_b3 & ~prev_vs_lev_e))) | (prev_vs_lev_j & ~prev_vs_lev_b & trigger_level_b3 & ((~trigger_previous_b3 & ~prev_vs_lev_e) | (trigger_previous_b3 & ~prev_vs_lev_e))) | (prev_vs_lev_j & prev_vs_lev_b & ~trigger_level_b3 & ((~trigger_previous_b3 & ~prev_vs_lev_e))) | (prev_vs_lev_j & prev_vs_lev_b & trigger_level_b3 & ((~trigger_previous_b3 & ~prev_vs_lev_e) | (trigger_previous_b3 & ~prev_vs_lev_e)));
  assign prev_vs_lev_f = (~trigger_level_b3 & ~trigger_previous_b3 & ~prev_vs_lev_d & ((prev_vs_lev_c | prev_vs_lev_a))) | (~trigger_level_b3 & trigger_previous_b3 & ~prev_vs_lev_d) | (trigger_level_b3 & trigger_previous_b3 & ~prev_vs_lev_d & ((prev_vs_lev_c | prev_vs_lev_a)));

//---------------------------------------------------------------------------
//Block 178, LSLICE 3

  assign prev_vs_lev_l = (~prev_vs_lev_k & ~prev_vs_lev_d & trigger_level_b5 & ((~trigger_previous_b5 & ~prev_vs_lev_g))) | (~prev_vs_lev_k & prev_vs_lev_d & ~trigger_level_b5 & ((~trigger_previous_b5 & ~prev_vs_lev_g))) | (~prev_vs_lev_k & prev_vs_lev_d & trigger_level_b5 & ((~trigger_previous_b5 & ~prev_vs_lev_g) | (trigger_previous_b5 & ~prev_vs_lev_g))) | (prev_vs_lev_k & ~prev_vs_lev_d & ~trigger_level_b5 & ((~trigger_previous_b5 & ~prev_vs_lev_g))) | (prev_vs_lev_k & ~prev_vs_lev_d & trigger_level_b5 & ((~trigger_previous_b5 & ~prev_vs_lev_g) | (trigger_previous_b5 & ~prev_vs_lev_g))) | (prev_vs_lev_k & prev_vs_lev_d & ~trigger_level_b5 & ((~trigger_previous_b5 & ~prev_vs_lev_g))) | (prev_vs_lev_k & prev_vs_lev_d & trigger_level_b5 & ((~trigger_previous_b5 & ~prev_vs_lev_g) | (trigger_previous_b5 & ~prev_vs_lev_g)));
  assign prev_vs_lev_m = (~trigger_level_b7 & ~trigger_previous_b7 & ((~prev_vs_lev_h & ~prev_vs_lev_l))) | (~trigger_level_b7 & trigger_previous_b7 & ((~prev_vs_lev_h & ~prev_vs_lev_l))) | (trigger_level_b7 & trigger_previous_b7 & ((~prev_vs_lev_h & ~prev_vs_lev_l)));

//---------------------------------------------------------------------------
//Block 179, MSLICE 1

  assign sig_179_lut_0 = (~sampling_half_way & ~trigger_edge & ((trigger_previous_b4 & ~trigger_data_b4) | (trigger_previous_b4 & trigger_data_b4))) | (~sampling_half_way & trigger_edge & ((trigger_previous_b4 & ~trigger_data_b4) | (trigger_previous_b4 & trigger_data_b4))) | (sampling_half_way & ~trigger_edge & ((~trigger_previous_b4 & ~trigger_data_b4) | (trigger_previous_b4 & ~trigger_data_b4))) | (sampling_half_way & trigger_edge & ((~trigger_previous_b4 & ~trigger_data_b4) | (trigger_previous_b4 & ~trigger_data_b4)));
  assign sig_179_lut_1 = (~sampling_half_way & ~trigger_edge) | (sampling_half_way & ~trigger_edge);
  assign sig_179_ff0_d = (~sampling_reset & sig_179_lut_0) | (sampling_reset & sig_179_lut_1);

  always @(posedge sample_write_clock)
  begin
    trigger_previous_b4 <= sig_179_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 180, LSLICE 2

  assign cur_vs_lev_e = ((~trigger_data_b4 & ~trigger_level_b4));
  assign cur_vs_lev_f = ((trigger_data_b4 & trigger_level_b4));

  always @(posedge i_mcu_clk)
  begin
    if(cmd17_enable == 1'b1)   //enable
     begin
      trigger_level_b4 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 181, LSLICE 3

  assign cur_vs_lev_g = (~trigger_level_b5 & ~cur_vs_lev_e & ~cur_vs_lev_d & ((~trigger_data_b5 & ~cur_vs_lev_h))) | (~trigger_level_b5 & ~cur_vs_lev_e & cur_vs_lev_d & ((~trigger_data_b5 & ~cur_vs_lev_h) | (trigger_data_b5 & ~cur_vs_lev_h))) | (~trigger_level_b5 & cur_vs_lev_e & ~cur_vs_lev_d & ((~trigger_data_b5 & ~cur_vs_lev_h) | (trigger_data_b5 & ~cur_vs_lev_h))) | (~trigger_level_b5 & cur_vs_lev_e & cur_vs_lev_d & ((~trigger_data_b5 & ~cur_vs_lev_h) | (trigger_data_b5 & ~cur_vs_lev_h))) | (trigger_level_b5 & ~cur_vs_lev_e & cur_vs_lev_d & ((~trigger_data_b5 & ~cur_vs_lev_h))) | (trigger_level_b5 & cur_vs_lev_e & ~cur_vs_lev_d & ((~trigger_data_b5 & ~cur_vs_lev_h))) | (trigger_level_b5 & cur_vs_lev_e & cur_vs_lev_d & ((~trigger_data_b5 & ~cur_vs_lev_h)));
  assign cur_vs_lev_l = (~cur_vs_lev_k & ~cur_vs_lev_i & ~trigger_level_b5 & ((trigger_data_b5 & cur_vs_lev_f))) | (~cur_vs_lev_k & ~cur_vs_lev_i & trigger_level_b5 & ((trigger_data_b5 | cur_vs_lev_f))) | (cur_vs_lev_k & ~cur_vs_lev_i & ~trigger_level_b5 & ((trigger_data_b5 & ~cur_vs_lev_f) | (trigger_data_b5 & cur_vs_lev_f))) | (cur_vs_lev_k & ~cur_vs_lev_i & trigger_level_b5);

  always @(posedge i_mcu_clk)
  begin
    if(cmd17_enable == 1'b1)   //enable
     begin
      trigger_level_b5 <= io_mcu_d_5;
    end
  end

//---------------------------------------------------------------------------
//Block 182, MSLICE 0

  assign sig_182_lut_0 = ((trigger_rise_enable | trigger_fall_enable));
  assign prev_less_equal_lev = (~prev_vs_lev_g & ~prev_vs_lev_i & (~(~trigger_level_b7 & trigger_previous_b7)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      trigger_detect_enable <= 1'b0;
    end
    else
    begin
      if(trigger_check_enable == 1'b1)   //enable
       begin
        trigger_detect_enable <= sig_182_lut_0;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 183, LSLICE 2

  assign trigger_fall_detect = (~cur_vs_lev_h & ~cur_vs_lev_l & trigger_level_b7 & ((trigger_data_b7 & trigger_fall_enable))) | (~cur_vs_lev_h & cur_vs_lev_l & ~trigger_level_b7 & ((trigger_data_b7 & trigger_fall_enable))) | (~cur_vs_lev_h & cur_vs_lev_l & trigger_level_b7 & ((~trigger_data_b7 & trigger_fall_enable) | (trigger_data_b7 & trigger_fall_enable))) | (cur_vs_lev_h & ~cur_vs_lev_l & ~trigger_level_b7 & ((trigger_data_b7 & trigger_fall_enable))) | (cur_vs_lev_h & ~cur_vs_lev_l & trigger_level_b7 & ((~trigger_data_b7 & trigger_fall_enable) | (trigger_data_b7 & trigger_fall_enable))) | (cur_vs_lev_h & cur_vs_lev_l & ~trigger_level_b7 & ((trigger_data_b7 & trigger_fall_enable))) | (cur_vs_lev_h & cur_vs_lev_l & trigger_level_b7 & ((~trigger_data_b7 & trigger_fall_enable) | (trigger_data_b7 & trigger_fall_enable)));
  assign sig_183_lut_1 = (~trigger_fall_detect & ((sampling_triggered | trigger_rise_detect))) | (trigger_fall_detect);

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      sampling_triggered <= 1'b0;
    end
    else
    begin
      if(trigger_check_enable == 1'b1)   //enable
       begin
        sampling_triggered <= sig_183_lut_1;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 184, LSLICE 3

  assign net_252 = (~cmd23_select & ~read_adc2B_h_b1 & ~read_adc2B_l_b1 & ((cmd21_adc1B_l_b1 | cmd21_adc1B_h_b1))) | (~cmd23_select & ~read_adc2B_h_b1 & read_adc2B_l_b1 & ((cmd21_adc1B_l_b1 | cmd21_adc1B_h_b1))) | (~cmd23_select & read_adc2B_h_b1 & ~read_adc2B_l_b1 & ((cmd21_adc1B_l_b1 | cmd21_adc1B_h_b1))) | (~cmd23_select & read_adc2B_h_b1 & read_adc2B_l_b1 & ((cmd21_adc1B_l_b1 | cmd21_adc1B_h_b1))) | (cmd23_select & ~read_adc2B_h_b1 & read_adc2B_l_b1 & ((cmd21_adc1B_l_b1 & ~cmd21_adc1B_h_b1) | (cmd21_adc1B_l_b1 & cmd21_adc1B_h_b1))) | (cmd23_select & read_adc2B_h_b1 & ~read_adc2B_l_b1 & ((~cmd21_adc1B_l_b1 & cmd21_adc1B_h_b1) | (cmd21_adc1B_l_b1 & cmd21_adc1B_h_b1))) | (cmd23_select & read_adc2B_h_b1 & read_adc2B_l_b1 & ((cmd21_adc1B_l_b1 | cmd21_adc1B_h_b1)));
  assign read_adc2B_l_b1 = (~o_adc2B_d1_1 & (~(o_adc2B_d0_1 & ~read_addr_l10))) | (o_adc2B_d1_1 & ((~o_adc2B_d0_1 & ~read_addr_l10)));

//---------------------------------------------------------------------------
//Block 185, MSLICE 1

  assign cmd22_adc2A_b6 = (cmd_b1 & read_adc2A_b6 & ((cmd001000xx_select & ~cmd_b0)));
  assign trigger_data_b6 = (~trigger_channel & ((~read_adc1A_b6 & ~read_adc2A_b6) | (~read_adc1A_b6 & read_adc2A_b6))) | (trigger_channel & ((~read_adc1A_b6 & ~read_adc2A_b6) | (read_adc1A_b6 & ~read_adc2A_b6)));

//---------------------------------------------------------------------------
//Block 186, MSLICE 0

  assign sig_186_lut_0 = 1'b0;
  assign sig_186_lut_1 = (~trigger_detect_enable & ~prev_vs_lev_m & ((~trigger_level_b7 & trigger_previous_b7))) | (~trigger_detect_enable & prev_vs_lev_m) | (trigger_detect_enable & ~prev_vs_lev_m) | (trigger_detect_enable & prev_vs_lev_m);
  assign trigger_fall_enable = (~trigger_edge & sig_186_lut_0) | (trigger_edge & sig_186_lut_1);

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg13 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg13 <= time_base_cnt_out13;
    end
  end

//---------------------------------------------------------------------------
//Block 187, LSLICE 2

  assign cmd22_adc2A_b2 = (cmd001000xx_select & cmd_b1 & ((read_adc2A_b2 & ~cmd_b0)));
  assign cmd21_22_adc1B_2A_b2 = (~read_adc1B_b2 & ((~cmd21_select & ~cmd22_adc2A_b2))) | (read_adc1B_b2 & ((~cmd21_select & ~cmd22_adc2A_b2) | (cmd21_select & ~cmd22_adc2A_b2)));

//---------------------------------------------------------------------------
//Block 188, LSLICE 3

  assign cmd01_enable = ((cmd0x_data_write & cmdxxxx0001_select));
  assign cmd21_select = ((cmd2x_select & cmdxxxx0001_select));

  always @(posedge i_mcu_clk)
  begin
    if(cmd01_enable == 1'b1)   //enable
     begin
      sampling_reset <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 189, LSLICE 3

  assign cmd35_select = (cmd3x_select & cmdxxxx01xx_select & ((~cmd_b1 & cmd_b0)));
  assign net_268 = (~cmd_0D_0E_select & ((~cmd32_select & ~cmd35_select)));

//---------------------------------------------------------------------------
//Block 190, MSLICE 0

  assign sig_190_lut_0 = 1'b0;
  assign sig_190_lut_1 = (~cmd_b2 & cmd3x_select & ((~cmd_b1 & ~cmd_b0)));
  assign cmd38_select = (~cmd_b3 & sig_190_lut_0) | (cmd_b3 & sig_190_lut_1);

//---------------------------------------------------------------------------
//Block 191, LSLICE 2

  assign cmdxxxx0001_select = (~cmd_b1 & ~cmd_b3 & ((~cmd_b2 & cmd_b0)));
  assign cmd0001x000_select = (~cmd_b1 & ~cmd_b2 & ((cmd1x_select & ~cmd_b0)));

//---------------------------------------------------------------------------
//Block 192, MSLICE 1

  assign sig_192_lut_0 = 1'b0;
  assign sig_192_lut_1 = (cmd3x_select & ~cmd_b3 & ((~cmd_b2 & ~cmd_b0)));
  assign cmd32_select = (~cmd_b1 & sig_192_lut_0) | (cmd_b1 & sig_192_lut_1);

//---------------------------------------------------------------------------
//Block 193, MSLICE 0

  assign sig_193_lut_0 = 1'b0;
  assign sig_193_lut_1 = (cmd_b2 & ~cmd_b1 & ((cmd_b0 & cmd6x_select)));
  assign cmd6D_select = (~cmd_b3 & sig_193_lut_0) | (cmd_b3 & sig_193_lut_1);

//---------------------------------------------------------------------------
//Block 194, LSLICE 2

  assign net_273 = (sampling_triggered & cmd_b3 & ~cmd_b2 & ((~cmd_b1 & ~cmd_b0)));
  assign net_272 = (~cmd1x_select & ~cmd6A_select) | (~cmd1x_select & cmd6A_select & ((~net_273 & ~i_i2c_cmd6A_b0) | (net_273 & ~i_i2c_cmd6A_b0))) | (cmd1x_select & ~cmd6A_select & ((~net_273 & ~i_i2c_cmd6A_b0) | (~net_273 & i_i2c_cmd6A_b0))) | (cmd1x_select & cmd6A_select & ((~net_273 & ~i_i2c_cmd6A_b0)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd_write_enable == 1'b1)   //enable
     begin
      cmd_b2 <= io_mcu_d_2;
    end
  end

//---------------------------------------------------------------------------
//Block 195, MSLICE 1

  assign sig_195_lut_0 = 1'b0;
  assign sig_195_lut_1 = (cmd_b2 & ~cmd_b1 & ((cmd6x_select & ~cmd_b0)));
  assign cmd6C_select = (~cmd_b3 & sig_195_lut_0) | (cmd_b3 & sig_195_lut_1);

//---------------------------------------------------------------------------
//Block 196, LSLICE 3

  assign net_278 = (~net_204 & ~net_198 & ~cmd41_select) | (~net_204 & ~net_198 & cmd41_select & ((byte_state_0 & ~cmd3C_b3))) | (~net_204 & net_198 & ~cmd41_select) | (~net_204 & net_198 & cmd41_select);
  assign cmd3C_enable0 = (cmd3C_select & i_mcu_rws & ((byte_state_0 & ~i_mcu_dcs)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable0 == 1'b1)   //enable
     begin
      cmd3C_b3 <= io_mcu_d_3;
      cmd3C_b2 <= io_mcu_d_2;
    end
  end

//---------------------------------------------------------------------------
//Block 197, LSLICE 2

  assign net_284 = (~byte_state_0 & ~byte_state_1 & ~cmd3C_b1 & ((o_mcu_d_1 & ~cmd3C_b9) | (o_mcu_d_1 & cmd3C_b9))) | (~byte_state_0 & ~byte_state_1 & cmd3C_b1 & ((o_mcu_d_1 & ~cmd3C_b9) | (o_mcu_d_1 & cmd3C_b9))) | (~byte_state_0 & byte_state_1 & ~cmd3C_b1 & ((~o_mcu_d_1 & cmd3C_b9) | (o_mcu_d_1 & cmd3C_b9))) | (~byte_state_0 & byte_state_1 & cmd3C_b1 & ((~o_mcu_d_1 & cmd3C_b9) | (o_mcu_d_1 & cmd3C_b9))) | (byte_state_0 & ~byte_state_1 & cmd3C_b1) | (byte_state_0 & byte_state_1 & cmd3C_b1);
  assign cmd3C_enable1 = (cmd3C_select & i_mcu_rws & ((~i_mcu_dcs & byte_state_1)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable1 == 1'b1)   //enable
     begin
      cmd3C_b9 <= io_mcu_d_1;
      cmd3C_b8 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 198, LSLICE 3

  assign net_283 = (~net_304 & ~net_281 & ~cmd41_select) | (~net_304 & ~net_281 & cmd41_select & ((byte_state_0 & ~cmd3C_b2))) | (~net_304 & net_281 & ~cmd41_select) | (~net_304 & net_281 & cmd41_select);
  assign net_281 = (~byte_state_1 & ~byte_state_0 & ((~o_mcu_d_2 & ~cmd3C_b10) | (~o_mcu_d_2 & cmd3C_b10))) | (byte_state_1 & ~byte_state_0 & ((~o_mcu_d_2 & ~cmd3C_b10) | (o_mcu_d_2 & ~cmd3C_b10)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable1 == 1'b1)   //enable
     begin
      cmd3C_b10 <= io_mcu_d_2;
    end
  end

//---------------------------------------------------------------------------
//Block 199, MSLICE 0

  assign sig_199_lut_0 = 1'b0;
  assign sig_199_lut_1 = (cmd_b2 & cmd0x_data_write & ((cmd_b0 & ~cmd_b1)));
  assign cmd0D_select = (~cmd_b3 & sig_199_lut_0) | (cmd_b3 & sig_199_lut_1);

//---------------------------------------------------------------------------
//Block 200, MSLICE 0

  assign sig_200_lut_0 = 1'b0;
  assign sig_200_lut_1 = (cmd1x_select & cmdxxxxxx11_select & ((cmd_b2 & byte_state_1)));
  assign cmd1F_enable1 = (~cmd_b3 & sig_200_lut_0) | (cmd_b3 & sig_200_lut_1);

//---------------------------------------------------------------------------
//Block 201, LSLICE 2

  assign read_addr_8 = (~pre_trigger_addr8 & ((sample_read_enable & smp_read_offset_r8))) | (pre_trigger_addr8 & (~(sample_read_enable & ~smp_read_offset_r8)));
  assign read_addr_1 = (~smp_read_offset_r1 & ((~sample_read_enable & pre_trigger_addr1))) | (smp_read_offset_r1 & ((sample_read_enable | pre_trigger_addr1)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      trigger_address_b8 <= 1'b0;
      trigger_address_b1 <= 1'b0;
    end
    else
    begin
      if(net_50 == 1'b1)   //enable
       begin
        trigger_address_b8 <= pre_trigger_addr8;
        trigger_address_b1 <= pre_trigger_addr1;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 202, MSLICE 1

  assign cmd35_enable0 = (i_mcu_rws & cmd35_select & ((byte_state_0 & ~i_mcu_dcs)));
  assign net_295 = (~trigger_address_b8 & ~net_175 & ((cmd14_select & ~byte_state_0))) | (trigger_address_b8 & ~net_175 & ((cmd14_select & ~byte_state_0) | (cmd14_select & byte_state_0)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd35_enable0 == 1'b1)   //enable
     begin
      ch2_offset_b10 <= io_mcu_d_2;
      ch2_offset_b15 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 203, MSLICE 0

  assign net_310 = (~byte_state_1 & ~byte_state_0 & ((~o_mcu_d_7 & ~cmd3C_b15) | (~o_mcu_d_7 & cmd3C_b15))) | (byte_state_1 & ~byte_state_0 & ((~o_mcu_d_7 & ~cmd3C_b15) | (o_mcu_d_7 & ~cmd3C_b15)));
  assign net_309 = (~byte_state_1 & ~o_mcu_d_6 & ((~byte_state_0 & ~cmd3C_b14) | (~byte_state_0 & cmd3C_b14))) | (byte_state_1 & ~o_mcu_d_6 & ((~byte_state_0 & ~cmd3C_b14))) | (byte_state_1 & o_mcu_d_6 & ((~byte_state_0 & ~cmd3C_b14)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable1 == 1'b1)   //enable
     begin
      cmd3C_b15 <= io_mcu_d_7;
      cmd3C_b14 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 204, LSLICE 2

  assign net_304 = (cmd14_select & ~trigger_address_b10 & ((~net_305 & ~byte_state_0))) | (cmd14_select & trigger_address_b10 & ((~net_305 & ~byte_state_0) | (~net_305 & byte_state_0)));
  assign net_305 = (~byte_state_0 & ~byte_state_1 & ((~o_mcu_d_2 & ~trigger_address_b2) | (~o_mcu_d_2 & trigger_address_b2))) | (~byte_state_0 & byte_state_1 & ((~o_mcu_d_2 & ~trigger_address_b2) | (o_mcu_d_2 & ~trigger_address_b2)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      trigger_address_b10 <= 1'b0;
    end
    else
    begin
      if(net_50 == 1'b1)   //enable
       begin
        trigger_address_b10 <= pre_trigger_addr10;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 205, LSLICE 3

  assign read_addr_7 = (~smp_read_offset_r7 & ((~sample_read_enable & pre_trigger_addr7))) | (smp_read_offset_r7 & ((sample_read_enable | pre_trigger_addr7)));
  assign read_addr_2 = (~pre_trigger_addr2 & ((sample_read_enable & smp_read_offset_r2))) | (pre_trigger_addr2 & (~(sample_read_enable & ~smp_read_offset_r2)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      trigger_address_b7 <= 1'b0;
      trigger_address_b2 <= 1'b0;
    end
    else
    begin
      if(net_50 == 1'b1)   //enable
       begin
        trigger_address_b7 <= pre_trigger_addr7;
        trigger_address_b2 <= pre_trigger_addr2;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 206, MSLICE 1

  assign net_308 = (~offset2_pwm_r13 & ~ch2_offset_b13 & (~(offset2_pwm_r12 & ~ch2_offset_b12))) | (~offset2_pwm_r13 & ch2_offset_b13 & (~(offset2_pwm_r12 & ~ch2_offset_b12))) | (offset2_pwm_r13 & ch2_offset_b13 & (~(offset2_pwm_r12 & ~ch2_offset_b12)));
  assign net_298 = (net_308 & ~net_480 & ((ch2_offset_b12 & ~offset2_pwm_r12))) | (net_308 & net_480);

  always @(posedge i_mcu_clk)
  begin
    if(cmd35_enable0 == 1'b1)   //enable
     begin
      ch2_offset_b13 <= io_mcu_d_5;
      ch2_offset_b12 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 207, MSLICE 0

  assign sig_207_lut_0 = (~cmd001000xx_select & ~i_mcu_rws & ((smp_read_offset_r5 & ~smp_read_offset_c5) | (smp_read_offset_r5 & smp_read_offset_c5))) | (~cmd001000xx_select & i_mcu_rws) | (cmd001000xx_select & ~i_mcu_rws & ((~smp_read_offset_r5 & smp_read_offset_c5) | (smp_read_offset_r5 & smp_read_offset_c5))) | (cmd001000xx_select & i_mcu_rws);
  assign sig_207_lut_1 = 1'b0;
  assign sig_207_ff0_d = (~smp_read_offset_b5 & sig_207_lut_0) | (smp_read_offset_b5 & sig_207_lut_1);

  always @(posedge i_mcu_clk)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      smp_read_offset_r5 <= sig_207_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 208, LSLICE 2

  assign net_313 = (~net_298 & ~offset2_pwm_r14 & ((~ch2_offset_b14 & ~net_311) | (ch2_offset_b14 & ~net_311))) | (~net_298 & offset2_pwm_r14 & ((ch2_offset_b14 & ~net_311))) | (net_298 & ~offset2_pwm_r14) | (net_298 & offset2_pwm_r14 & ((ch2_offset_b14 & ~net_311) | (ch2_offset_b14 & net_311)));
  assign net_311 = (~ch2_offset_b13 & ~offset2_pwm_r14 & ((~ch2_offset_b14 & ~offset2_pwm_r13) | (~ch2_offset_b14 & offset2_pwm_r13))) | (~ch2_offset_b13 & offset2_pwm_r14) | (ch2_offset_b13 & ~offset2_pwm_r14 & ((~ch2_offset_b14 & offset2_pwm_r13))) | (ch2_offset_b13 & offset2_pwm_r14 & ((~ch2_offset_b14 & offset2_pwm_r13) | (ch2_offset_b14 & offset2_pwm_r13)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd35_enable0 == 1'b1)   //enable
     begin
      ch2_offset_b14 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 209, MSLICE 0

  assign sig_209_lut_0 = (~cmd001000xx_select & ~i_mcu_rws & ((smp_read_offset_r9 & ~smp_read_offset_c9) | (smp_read_offset_r9 & smp_read_offset_c9))) | (~cmd001000xx_select & i_mcu_rws) | (cmd001000xx_select & ~i_mcu_rws & ((~smp_read_offset_r9 & smp_read_offset_c9) | (smp_read_offset_r9 & smp_read_offset_c9))) | (cmd001000xx_select & i_mcu_rws);
  assign sig_209_lut_1 = 1'b0;
  assign sig_209_ff0_d = (~smp_read_offset_b9 & sig_209_lut_0) | (smp_read_offset_b9 & sig_209_lut_1);

  always @(posedge i_mcu_clk)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      smp_read_offset_r9 <= sig_209_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 214, MSLICE 1

  assign read_adc1B_l_b3 = (~read_addr_l10 & ~read_addr_l11 & ((o_adc1B_d0_3 & ~o_adc1B_d1_3) | (o_adc1B_d0_3 & o_adc1B_d1_3))) | (read_addr_l10 & ~read_addr_l11 & ((~o_adc1B_d0_3 & o_adc1B_d1_3) | (o_adc1B_d0_3 & o_adc1B_d1_3)));
  assign read_adc1A_h_b7 = (read_addr_l11 & ~read_addr_l10 & ((~o_adc1A_d2_7 & ~o_adc1A_d3_7) | (~o_adc1A_d2_7 & o_adc1A_d3_7))) | (read_addr_l11 & read_addr_l10 & ((~o_adc1A_d2_7 & ~o_adc1A_d3_7) | (o_adc1A_d2_7 & ~o_adc1A_d3_7)));

//---------------------------------------------------------------------------
//Block 215, MSLICE 0

  assign sig_215_lut_0 = (~read_addr_l10 & ~read_addr_l11) | (~read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_6 & ~o_adc1B_d3_6) | (~o_adc1B_d2_6 & o_adc1B_d3_6))) | (read_addr_l10 & ~read_addr_l11) | (read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_6 & ~o_adc1B_d3_6) | (o_adc1B_d2_6 & ~o_adc1B_d3_6)));
  assign sig_215_lut_1 = 1'b0;
  assign read_adc1B_b6 = (~read_adc1B_l_b6 & sig_215_lut_0) | (read_adc1B_l_b6 & sig_215_lut_1);

//---------------------------------------------------------------------------
//Block 216, LSLICE 2

  assign db_match_i = (~db_match_k & ~db_match_h & (~(~db_cnt_b8 & disp_bright_b8)));
  assign db_match_j = (~db_match_k & (~(disp_bright_b8 & ~db_cnt_b8)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable0 == 1'b1)   //enable
     begin
      disp_bright_b8 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 217, LSLICE 3

  assign prev_vs_lev_j = (~trigger_previous_b0 & ~trigger_level_b0 & ~trigger_level_b1 & ((~trigger_previous_b1 & ~prev_vs_lev_c))) | (~trigger_previous_b0 & ~trigger_level_b0 & trigger_level_b1 & ((~trigger_previous_b1 & ~prev_vs_lev_c) | (trigger_previous_b1 & ~prev_vs_lev_c))) | (~trigger_previous_b0 & trigger_level_b0 & ~trigger_level_b1 & ((~trigger_previous_b1 & ~prev_vs_lev_c))) | (~trigger_previous_b0 & trigger_level_b0 & trigger_level_b1 & ((~trigger_previous_b1 & ~prev_vs_lev_c) | (trigger_previous_b1 & ~prev_vs_lev_c))) | (trigger_previous_b0 & ~trigger_level_b0 & trigger_level_b1 & ((~trigger_previous_b1 & ~prev_vs_lev_c))) | (trigger_previous_b0 & trigger_level_b0 & ~trigger_level_b1 & ((~trigger_previous_b1 & ~prev_vs_lev_c))) | (trigger_previous_b0 & trigger_level_b0 & trigger_level_b1 & ((~trigger_previous_b1 & ~prev_vs_lev_c) | (trigger_previous_b1 & ~prev_vs_lev_c)));
  assign prev_vs_lev_a = (~trigger_level_b0 & ~trigger_previous_b0 & ~prev_vs_lev_b & (~(~trigger_previous_b1 & trigger_level_b1))) | (~trigger_level_b0 & trigger_previous_b0 & ~prev_vs_lev_b & (~(~trigger_previous_b1 & trigger_level_b1))) | (trigger_level_b0 & ~trigger_previous_b0 & ~prev_vs_lev_b & ((trigger_previous_b1 & ~trigger_level_b1))) | (trigger_level_b0 & trigger_previous_b0 & ~prev_vs_lev_b & (~(~trigger_previous_b1 & trigger_level_b1)));

//---------------------------------------------------------------------------
//Block 218, MSLICE 1

  assign sig_218_lut_0 = (~sampling_half_way & ~trigger_edge & ((trigger_previous_b5 & ~trigger_data_b5) | (trigger_previous_b5 & trigger_data_b5))) | (~sampling_half_way & trigger_edge & ((trigger_previous_b5 & ~trigger_data_b5) | (trigger_previous_b5 & trigger_data_b5))) | (sampling_half_way & ~trigger_edge & ((~trigger_previous_b5 & ~trigger_data_b5) | (trigger_previous_b5 & ~trigger_data_b5))) | (sampling_half_way & trigger_edge & ((~trigger_previous_b5 & ~trigger_data_b5) | (trigger_previous_b5 & ~trigger_data_b5)));
  assign sig_218_lut_1 = (~sampling_half_way & ~trigger_edge) | (sampling_half_way & ~trigger_edge);
  assign sig_218_ff0_d = (~sampling_reset & sig_218_lut_0) | (sampling_reset & sig_218_lut_1);

  always @(posedge sample_write_clock)
  begin
    trigger_previous_b5 <= sig_218_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 219, MSLICE 0

  assign sig_219_lut_0 = (~sampling_half_way & ~trigger_edge & ((trigger_previous_b0 & ~trigger_data_b0) | (trigger_previous_b0 & trigger_data_b0))) | (~sampling_half_way & trigger_edge & ((trigger_previous_b0 & ~trigger_data_b0) | (trigger_previous_b0 & trigger_data_b0))) | (sampling_half_way & ~trigger_edge & ((~trigger_previous_b0 & ~trigger_data_b0) | (trigger_previous_b0 & ~trigger_data_b0))) | (sampling_half_way & trigger_edge & ((~trigger_previous_b0 & ~trigger_data_b0) | (trigger_previous_b0 & ~trigger_data_b0)));
  assign sig_219_lut_1 = (~trigger_edge & ~sampling_half_way) | (~trigger_edge & sampling_half_way);
  assign sig_219_ff0_d = (~sampling_reset & sig_219_lut_0) | (sampling_reset & sig_219_lut_1);

  always @(posedge sample_write_clock)
  begin
    trigger_previous_b0 <= sig_219_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 220, LSLICE 2

  assign cur_vs_lev_a = (~trigger_level_b0 & ~trigger_level_b1 & ~trigger_data_b0 & ((~trigger_data_b1 & ~cur_vs_lev_b) | (trigger_data_b1 & ~cur_vs_lev_b))) | (~trigger_level_b0 & ~trigger_level_b1 & trigger_data_b0 & ((~trigger_data_b1 & ~cur_vs_lev_b) | (trigger_data_b1 & ~cur_vs_lev_b))) | (~trigger_level_b0 & trigger_level_b1 & ~trigger_data_b0 & ((~trigger_data_b1 & ~cur_vs_lev_b))) | (~trigger_level_b0 & trigger_level_b1 & trigger_data_b0 & ((~trigger_data_b1 & ~cur_vs_lev_b))) | (trigger_level_b0 & ~trigger_level_b1 & ~trigger_data_b0 & ((~trigger_data_b1 & ~cur_vs_lev_b) | (trigger_data_b1 & ~cur_vs_lev_b))) | (trigger_level_b0 & ~trigger_level_b1 & trigger_data_b0 & ((~trigger_data_b1 & ~cur_vs_lev_b))) | (trigger_level_b0 & trigger_level_b1 & ~trigger_data_b0 & ((~trigger_data_b1 & ~cur_vs_lev_b)));
  assign cur_vs_lev_j = (~trigger_level_b0 & ~trigger_data_b1 & ~cur_vs_lev_c & ((trigger_level_b1 & trigger_data_b0))) | (~trigger_level_b0 & trigger_data_b1 & ~cur_vs_lev_c & ((trigger_level_b1 | trigger_data_b0))) | (trigger_level_b0 & ~trigger_data_b1 & ~cur_vs_lev_c & ((trigger_level_b1 & ~trigger_data_b0) | (trigger_level_b1 & trigger_data_b0))) | (trigger_level_b0 & trigger_data_b1 & ~cur_vs_lev_c);

  always @(posedge i_mcu_clk)
  begin
    if(cmd17_enable == 1'b1)   //enable
     begin
      trigger_level_b1 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 221, LSLICE 3

  assign cur_vs_lev_d = (~trigger_level_b3 & ~cur_vs_lev_c & ~cur_vs_lev_a & ((~trigger_data_b3 & ~cur_vs_lev_f))) | (~trigger_level_b3 & ~cur_vs_lev_c & cur_vs_lev_a & ((~trigger_data_b3 & ~cur_vs_lev_f) | (trigger_data_b3 & ~cur_vs_lev_f))) | (~trigger_level_b3 & cur_vs_lev_c & ~cur_vs_lev_a & ((~trigger_data_b3 & ~cur_vs_lev_f) | (trigger_data_b3 & ~cur_vs_lev_f))) | (~trigger_level_b3 & cur_vs_lev_c & cur_vs_lev_a & ((~trigger_data_b3 & ~cur_vs_lev_f) | (trigger_data_b3 & ~cur_vs_lev_f))) | (trigger_level_b3 & ~cur_vs_lev_c & cur_vs_lev_a & ((~trigger_data_b3 & ~cur_vs_lev_f))) | (trigger_level_b3 & cur_vs_lev_c & ~cur_vs_lev_a & ((~trigger_data_b3 & ~cur_vs_lev_f))) | (trigger_level_b3 & cur_vs_lev_c & cur_vs_lev_a & ((~trigger_data_b3 & ~cur_vs_lev_f)));
  assign cur_vs_lev_k = (~cur_vs_lev_e & ~trigger_data_b3 & trigger_level_b3 & ((cur_vs_lev_b | cur_vs_lev_j))) | (~cur_vs_lev_e & trigger_data_b3 & ~trigger_level_b3 & ((cur_vs_lev_b | cur_vs_lev_j))) | (~cur_vs_lev_e & trigger_data_b3 & trigger_level_b3);

  always @(posedge i_mcu_clk)
  begin
    if(cmd17_enable == 1'b1)   //enable
     begin
      trigger_level_b3 <= io_mcu_d_3;
    end
  end

//---------------------------------------------------------------------------
//Block 222, MSLICE 1

  assign sig_222_lut_0 = (~sampling_half_way & ~trigger_edge & ((trigger_previous_b1 & ~trigger_data_b1) | (trigger_previous_b1 & trigger_data_b1))) | (~sampling_half_way & trigger_edge & ((trigger_previous_b1 & ~trigger_data_b1) | (trigger_previous_b1 & trigger_data_b1))) | (sampling_half_way & ~trigger_edge & ((~trigger_previous_b1 & ~trigger_data_b1) | (trigger_previous_b1 & ~trigger_data_b1))) | (sampling_half_way & trigger_edge & ((~trigger_previous_b1 & ~trigger_data_b1) | (trigger_previous_b1 & ~trigger_data_b1)));
  assign sig_222_lut_1 = (~sampling_half_way & ~trigger_edge) | (sampling_half_way & ~trigger_edge);
  assign sig_222_ff0_d = (~sampling_reset & sig_222_lut_0) | (sampling_reset & sig_222_lut_1);

  always @(posedge sample_write_clock)
  begin
    trigger_previous_b1 <= sig_222_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 223, MSLICE 0

  assign sig_223_lut_0 = (~sampling_half_way & ~trigger_edge & ((trigger_previous_b2 & ~trigger_data_b2) | (trigger_previous_b2 & trigger_data_b2))) | (~sampling_half_way & trigger_edge & ((trigger_previous_b2 & ~trigger_data_b2) | (trigger_previous_b2 & trigger_data_b2))) | (sampling_half_way & ~trigger_edge & ((~trigger_previous_b2 & ~trigger_data_b2) | (trigger_previous_b2 & ~trigger_data_b2))) | (sampling_half_way & trigger_edge & ((~trigger_previous_b2 & ~trigger_data_b2) | (trigger_previous_b2 & ~trigger_data_b2)));
  assign sig_223_lut_1 = (~trigger_edge & ~sampling_half_way) | (~trigger_edge & sampling_half_way);
  assign sig_223_ff0_d = (~sampling_reset & sig_223_lut_0) | (sampling_reset & sig_223_lut_1);

  always @(posedge sample_write_clock)
  begin
    trigger_previous_b2 <= sig_223_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 224, LSLICE 2

  assign trigger_data_b2 = (~trigger_channel & ((~read_adc2A_b2 & ~read_adc1A_b2) | (read_adc2A_b2 & ~read_adc1A_b2))) | (trigger_channel & ((~read_adc2A_b2 & ~read_adc1A_b2) | (~read_adc2A_b2 & read_adc1A_b2)));
  assign cur_vs_lev_b = ((trigger_data_b2 & trigger_level_b2));

//---------------------------------------------------------------------------
//Block 225, LSLICE 3

  assign cmd17_enable = (cmd1x_data_write & ((cmdxxxx01xx_select & cmdxxxxxx11_select)));
  assign cur_vs_lev_c = ((~trigger_data_b2 & ~trigger_level_b2));

  always @(posedge i_mcu_clk)
  begin
    if(cmd17_enable == 1'b1)   //enable
     begin
      trigger_level_b0 <= io_mcu_d_0;
      trigger_level_b2 <= io_mcu_d_2;
    end
  end

//---------------------------------------------------------------------------
//Block 226, MSLICE 1

  assign net_340 = (cmd_b1 & read_adc2A_b4 & ((cmd001000xx_select & ~cmd_b0)));
  assign trigger_data_b4 = (~trigger_channel & ((~read_adc2A_b4 & ~read_adc1A_b4) | (read_adc2A_b4 & ~read_adc1A_b4))) | (trigger_channel & ((~read_adc2A_b4 & ~read_adc1A_b4) | (~read_adc2A_b4 & read_adc1A_b4)));

//---------------------------------------------------------------------------
//Block 227, LSLICE 2

  assign db_match_p = (~db_cnt_b13 & ~db_cnt_b12) | (~db_cnt_b13 & db_cnt_b12 & ((~disp_bright_b13 & disp_bright_b12) | (disp_bright_b13 & disp_bright_b12))) | (db_cnt_b13 & ~db_cnt_b12 & ((disp_bright_b13 & ~disp_bright_b12) | (disp_bright_b13 & disp_bright_b12))) | (db_cnt_b13 & db_cnt_b12 & ((disp_bright_b13 & disp_bright_b12)));
  assign db_match_o = (~db_cnt_b12 & ~db_match_n & ((db_match_p & disp_bright_b12))) | (~db_cnt_b12 & db_match_n & ((db_match_p & ~disp_bright_b12) | (db_match_p & disp_bright_b12))) | (db_cnt_b12 & db_match_n & ((db_match_p & ~disp_bright_b12) | (db_match_p & disp_bright_b12)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable0 == 1'b1)   //enable
     begin
      disp_bright_b13 <= io_mcu_d_5;
      disp_bright_b12 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 228, LSLICE 3

  assign sig_228_lut_0 = (~i_mcu_rws & ~i_mcu_dcs & ~o_mcu_d_3 & ((~cmd_b3 & ~net_349) | (cmd_b3 & ~net_349))) | (~i_mcu_rws & ~i_mcu_dcs & o_mcu_d_3 & ((~cmd_b3 & ~net_349) | (cmd_b3 & ~net_349))) | (~i_mcu_rws & i_mcu_dcs & ~o_mcu_d_3 & ((cmd_b3 & ~net_349) | (cmd_b3 & net_349))) | (~i_mcu_rws & i_mcu_dcs & o_mcu_d_3 & ((cmd_b3 & ~net_349) | (cmd_b3 & net_349))) | (i_mcu_rws & ~i_mcu_dcs & o_mcu_d_3) | (i_mcu_rws & i_mcu_dcs & o_mcu_d_3);
  assign net_349 = (~net_434 & net_970 & ((net_536 & net_278)));

  always @(posedge i_mcu_clk)
  begin
    o_mcu_d_3 <= sig_228_lut_0;
  end

//---------------------------------------------------------------------------
//Block 229, MSLICE 0

  assign cmd22_adc2A_b1 = (cmd_b1 & read_adc2A_b1 & ((cmd001000xx_select & ~cmd_b0)));
  assign cmd22_adc2A_b7 = (cmd_b1 & read_adc2A_b7 & ((cmd001000xx_select & ~cmd_b0)));

//---------------------------------------------------------------------------
//Block 230, MSLICE 1

  assign cmd21_23_adc1B_2B_b5 = (~cmd21_select & ~read_adc1B_b5 & (~(o_adc2B_d_5 & cmd23_select))) | (~cmd21_select & read_adc1B_b5 & (~(o_adc2B_d_5 & cmd23_select))) | (cmd21_select & read_adc1B_b5 & (~(o_adc2B_d_5 & cmd23_select)));
  assign cmd23_adc2B_b0 = ((cmd23_select & ~read_adc2B_b0));

//---------------------------------------------------------------------------
//Block 231, MSLICE 0

  assign sig_231_lut_0 = 1'b0;
  assign sig_231_lut_1 = (cmd_b2 & cmd_b1 & ((~cmd_b0 & cmd6x_select)));
  assign cmd6E_select = (~cmd_b3 & sig_231_lut_0) | (cmd_b3 & sig_231_lut_1);

//---------------------------------------------------------------------------
//Block 232, LSLICE 2

  assign net_355 = (~net_295 & ~net_195 & ~cmd41_select) | (~net_295 & ~net_195 & cmd41_select & ((byte_state_0 & ~cmd3C_b0))) | (~net_295 & net_195 & ~cmd41_select) | (~net_295 & net_195 & cmd41_select);
  assign net_354 = (net_784 & net_692 & net_355 & ((~net_425 & ~cmd23_adc2B_b0)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable0 == 1'b1)   //enable
     begin
      cmd3C_b0 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 233, MSLICE 1

  assign sig_233_lut_0 = 1'b0;
  assign sig_233_lut_1 = (~cmd_b2 & cmd_b1 & ((cmd6x_select & ~cmd_b0)));
  assign cmd6A_select = (~cmd_b3 & sig_233_lut_0) | (cmd_b3 & sig_233_lut_1);

//---------------------------------------------------------------------------
//Block 234, LSLICE 3

  assign sig_234_lut_0 = (~i_mcu_rws & ~i_mcu_dcs & ~o_mcu_d_1 & ((~cmd_b1 & ~net_360) | (cmd_b1 & ~net_360))) | (~i_mcu_rws & ~i_mcu_dcs & o_mcu_d_1 & ((~cmd_b1 & ~net_360) | (cmd_b1 & ~net_360))) | (~i_mcu_rws & i_mcu_dcs & ~o_mcu_d_1 & ((cmd_b1 & ~net_360) | (cmd_b1 & net_360))) | (~i_mcu_rws & i_mcu_dcs & o_mcu_d_1 & ((cmd_b1 & ~net_360) | (cmd_b1 & net_360))) | (i_mcu_rws & ~i_mcu_dcs & o_mcu_d_1) | (i_mcu_rws & i_mcu_dcs & o_mcu_d_1);
  assign net_360 = (net_372 & net_542 & ~cmd41_select & ((~net_284 & net_957) | (net_284 & net_957))) | (net_372 & net_542 & cmd41_select & ((~net_284 & net_957)));

  always @(posedge i_mcu_clk)
  begin
    o_mcu_d_1 <= sig_234_lut_0;
  end

//---------------------------------------------------------------------------
//Block 235, MSLICE 1

  assign sig_235_lut_0 = (~i_mcu_dcs & ~o_mcu_d_5 & ((~cmd_b5 & ~net_460) | (cmd_b5 & ~net_460))) | (~i_mcu_dcs & o_mcu_d_5 & ((~cmd_b5 & ~net_460) | (cmd_b5 & ~net_460))) | (i_mcu_dcs & ~o_mcu_d_5 & ((cmd_b5 & ~net_460) | (cmd_b5 & net_460))) | (i_mcu_dcs & o_mcu_d_5 & ((cmd_b5 & ~net_460) | (cmd_b5 & net_460)));
  assign sig_235_lut_1 = (~i_mcu_dcs & o_mcu_d_5) | (i_mcu_dcs & o_mcu_d_5);
  assign sig_235_ff0_d = (~i_mcu_rws & sig_235_lut_0) | (i_mcu_rws & sig_235_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_mcu_d_5 <= sig_235_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 236, MSLICE 0

  assign sig_236_lut_0 = 1'b0;
  assign sig_236_lut_1 = (cmd_b2 & cmd3x_select & ((~cmd_b1 & ~cmd_b0)));
  assign cmd3C_select = (~cmd_b3 & sig_236_lut_0) | (cmd_b3 & sig_236_lut_1);

//---------------------------------------------------------------------------
//Block 237, MSLICE 0

  assign sig_237_lut_0 = 1'b0;
  assign sig_237_lut_1 = (cmd_b2 & cmd0x_select & ((cmd_b1 ^ cmd_b0)));
  assign cmd_0D_0E_select = (~cmd_b3 & sig_237_lut_0) | (cmd_b3 & sig_237_lut_1);

//---------------------------------------------------------------------------
//Block 238, LSLICE 2

  assign net_364 = (~byte_state_0 & ~net_309 & ((cmd41_select & ~cmd3C_b6) | (cmd41_select & cmd3C_b6))) | (byte_state_0 & ~net_309 & ((cmd41_select & cmd3C_b6)));
  assign net_366 = (~net_364 & ((net_721 & net_537)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable0 == 1'b1)   //enable
     begin
      cmd3C_b6 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 239, LSLICE 3

  assign sig_239_lut_0 = (~i_mcu_rws & ~i_mcu_dcs & ~o_mcu_d_0 & ((~cmd_b0 & ~net_367) | (cmd_b0 & ~net_367))) | (~i_mcu_rws & ~i_mcu_dcs & o_mcu_d_0 & ((~cmd_b0 & ~net_367) | (cmd_b0 & ~net_367))) | (~i_mcu_rws & i_mcu_dcs & ~o_mcu_d_0 & ((cmd_b0 & ~net_367) | (cmd_b0 & net_367))) | (~i_mcu_rws & i_mcu_dcs & o_mcu_d_0 & ((cmd_b0 & ~net_367) | (cmd_b0 & net_367))) | (i_mcu_rws & ~i_mcu_dcs & o_mcu_d_0) | (i_mcu_rws & i_mcu_dcs & o_mcu_d_0);
  assign net_367 = (net_354 & net_789 & ~o_mcu_d_0) | (net_354 & net_789 & o_mcu_d_0 & ((~net_459 & ~cmd06_enable0)));

  always @(posedge i_mcu_clk)
  begin
    o_mcu_d_0 <= sig_239_lut_0;
  end

//---------------------------------------------------------------------------
//Block 240, MSLICE 1

  assign sig_240_lut_0 = (~i_mcu_dcs & ~o_mcu_d_6 & ((~cmd_b6 & ~net_461) | (cmd_b6 & ~net_461))) | (~i_mcu_dcs & o_mcu_d_6 & ((~cmd_b6 & ~net_461) | (cmd_b6 & ~net_461))) | (i_mcu_dcs & ~o_mcu_d_6 & ((cmd_b6 & ~net_461) | (cmd_b6 & net_461))) | (i_mcu_dcs & o_mcu_d_6 & ((cmd_b6 & ~net_461) | (cmd_b6 & net_461)));
  assign sig_240_lut_1 = (o_mcu_d_6 & ~i_mcu_dcs) | (o_mcu_d_6 & i_mcu_dcs);
  assign sig_240_ff0_d = (~i_mcu_rws & sig_240_lut_0) | (i_mcu_rws & sig_240_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_mcu_d_6 <= sig_240_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 241, MSLICE 0

  assign read_addr_5 = (~smp_read_offset_r5 & ((pre_trigger_addr5 & ~sample_read_enable))) | (smp_read_offset_r5 & ((pre_trigger_addr5 | sample_read_enable)));
  assign net_374 = (~o_mcu_d_5 & byte_state_1 & ((trigger_address_b5 & cmd14_select))) | (o_mcu_d_5 & ~byte_state_1 & ((~trigger_address_b5 & cmd14_select) | (trigger_address_b5 & cmd14_select))) | (o_mcu_d_5 & byte_state_1 & ((trigger_address_b5 & cmd14_select)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      trigger_address_b5 <= 1'b0;
    end
    else
    begin
      if(net_50 == 1'b1)   //enable
       begin
        trigger_address_b5 <= pre_trigger_addr5;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 242, LSLICE 2

  assign net_368 = (~byte_state_0 & ~byte_state_1 & ~trigger_address_b9 & ((o_mcu_d_1 & ~trigger_address_b1) | (o_mcu_d_1 & trigger_address_b1))) | (~byte_state_0 & ~byte_state_1 & trigger_address_b9 & ((o_mcu_d_1 & ~trigger_address_b1) | (o_mcu_d_1 & trigger_address_b1))) | (~byte_state_0 & byte_state_1 & ~trigger_address_b9 & ((~o_mcu_d_1 & trigger_address_b1) | (o_mcu_d_1 & trigger_address_b1))) | (~byte_state_0 & byte_state_1 & trigger_address_b9 & ((~o_mcu_d_1 & trigger_address_b1) | (o_mcu_d_1 & trigger_address_b1))) | (byte_state_0 & ~byte_state_1 & trigger_address_b9) | (byte_state_0 & byte_state_1 & trigger_address_b9);
  assign net_372 = (~net_459 & ~net_368) | (~net_459 & net_368 & ((~o_mcu_d_1 & ~cmd14_select) | (o_mcu_d_1 & ~cmd14_select))) | (net_459 & ~net_368 & ((~o_mcu_d_1 & ~cmd14_select) | (~o_mcu_d_1 & cmd14_select))) | (net_459 & net_368 & ((~o_mcu_d_1 & ~cmd14_select)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable0 == 1'b1)   //enable
     begin
      cmd3C_b1 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 243, LSLICE 3

  assign read_addr_4 = (~smp_read_offset_r4 & ((~sample_read_enable & pre_trigger_addr4))) | (smp_read_offset_r4 & ((sample_read_enable | pre_trigger_addr4)));
  assign net_370 = (cmd14_select & ~byte_state_1 & ((~trigger_address_b4 & o_mcu_d_4) | (trigger_address_b4 & o_mcu_d_4))) | (cmd14_select & byte_state_1 & ((trigger_address_b4 & ~o_mcu_d_4) | (trigger_address_b4 & o_mcu_d_4)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      trigger_address_b4 <= 1'b0;
    end
    else
    begin
      if(net_50 == 1'b1)   //enable
       begin
        trigger_address_b4 <= pre_trigger_addr4;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 244, MSLICE 1

  assign read_addr_6 = (~sample_read_enable & ((pre_trigger_addr6 & ~smp_read_offset_r6) | (pre_trigger_addr6 & smp_read_offset_r6))) | (sample_read_enable & ((~pre_trigger_addr6 & smp_read_offset_r6) | (pre_trigger_addr6 & smp_read_offset_r6)));
  assign net_375 = (~o_mcu_d_6 & byte_state_1 & ((cmd14_select & trigger_address_b6))) | (o_mcu_d_6 & ~byte_state_1 & ((cmd14_select & ~trigger_address_b6) | (cmd14_select & trigger_address_b6))) | (o_mcu_d_6 & byte_state_1 & ((cmd14_select & trigger_address_b6)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      trigger_address_b6 <= 1'b0;
    end
    else
    begin
      if(net_50 == 1'b1)   //enable
       begin
        trigger_address_b6 <= pre_trigger_addr6;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 245, MSLICE 0

  assign sig_245_lut_0 = (~offset2_pwm_r14 & ~offset2_pwm_r13 & ((~offset2_pwm_r12 & ~offset2_pwm_r11)));
  assign sig_245_lut_1 = 1'b0;
  assign net_381 = (~offset2_pwm_r15 & sig_245_lut_0) | (offset2_pwm_r15 & sig_245_lut_1);

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r22 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r22 <= calib_1KHz_c22;
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 246, 249, 250, 253, 254, 255, 256

  assign { smp_read_offset_c11, smp_read_offset_c10, smp_read_offset_c9, smp_read_offset_c8, smp_read_offset_c7, smp_read_offset_c6, smp_read_offset_c5, smp_read_offset_c4, smp_read_offset_c3, smp_read_offset_c2, smp_read_offset_c1, smp_read_offset_c0 } = { 1'b0, smp_read_offset_r10, smp_read_offset_r9, 1'b0, 1'b0, smp_read_offset_r6, 1'b0, smp_read_offset_r4, smp_read_offset_r3, smp_read_offset_r2, 1'b0, smp_read_offset_r0 } + { smp_read_offset_r11, 1'b0, 1'b0, smp_read_offset_r8, smp_read_offset_r7, 1'b0, smp_read_offset_r5, 1'b0, 1'b0, 1'b0, smp_read_offset_r1, 1'b1 };

//---------------------------------------------------------------------------
//Block 247, LSLICE 2

  assign sig_247_lut_0 = (~smp_read_offset_b6 & ~cmd001000xx_select & ~i_mcu_rws & ((smp_read_offset_r6 & ~smp_read_offset_c6) | (smp_read_offset_r6 & smp_read_offset_c6))) | (~smp_read_offset_b6 & ~cmd001000xx_select & i_mcu_rws) | (~smp_read_offset_b6 & cmd001000xx_select & ~i_mcu_rws & ((~smp_read_offset_r6 & smp_read_offset_c6) | (smp_read_offset_r6 & smp_read_offset_c6))) | (~smp_read_offset_b6 & cmd001000xx_select & i_mcu_rws);
  assign sig_247_lut_1 = (~smp_read_offset_b10 & ~cmd001000xx_select & ~i_mcu_rws & ((smp_read_offset_r10 & ~smp_read_offset_c10) | (smp_read_offset_r10 & smp_read_offset_c10))) | (~smp_read_offset_b10 & ~cmd001000xx_select & i_mcu_rws) | (~smp_read_offset_b10 & cmd001000xx_select & ~i_mcu_rws & ((~smp_read_offset_r10 & smp_read_offset_c10) | (smp_read_offset_r10 & smp_read_offset_c10))) | (~smp_read_offset_b10 & cmd001000xx_select & i_mcu_rws);

  always @(posedge i_mcu_clk)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      smp_read_offset_r6 <= sig_247_lut_0;
      smp_read_offset_r10 <= sig_247_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 248, LSLICE 3

  assign cmd0E_enable1 = ((cmd0E_select & byte_state_1));
  assign net_389 = (~trigger_address_b7 & ~byte_state_1 & ((o_mcu_d_7 & cmd14_select))) | (trigger_address_b7 & ~byte_state_1 & ((o_mcu_d_7 & cmd14_select))) | (trigger_address_b7 & byte_state_1 & ((~o_mcu_d_7 & cmd14_select) | (o_mcu_d_7 & cmd14_select)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable1 == 1'b1)   //enable
     begin
      time_base_b16 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 251, LSLICE 2

  assign sig_251_lut_0 = (~smp_read_offset_b7 & ~cmd001000xx_select & ~i_mcu_rws & ((smp_read_offset_r7 & ~smp_read_offset_c7) | (smp_read_offset_r7 & smp_read_offset_c7))) | (~smp_read_offset_b7 & ~cmd001000xx_select & i_mcu_rws) | (~smp_read_offset_b7 & cmd001000xx_select & ~i_mcu_rws & ((~smp_read_offset_r7 & smp_read_offset_c7) | (smp_read_offset_r7 & smp_read_offset_c7))) | (~smp_read_offset_b7 & cmd001000xx_select & i_mcu_rws);
  assign sig_251_lut_1 = (~smp_read_offset_b0 & ~smp_read_offset_r0 & ~i_mcu_rws & ((cmd001000xx_select & smp_read_offset_c0))) | (~smp_read_offset_b0 & ~smp_read_offset_r0 & i_mcu_rws) | (~smp_read_offset_b0 & smp_read_offset_r0 & ~i_mcu_rws & (~(cmd001000xx_select & ~smp_read_offset_c0))) | (~smp_read_offset_b0 & smp_read_offset_r0 & i_mcu_rws);

  always @(posedge i_mcu_clk)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      smp_read_offset_r7 <= sig_251_lut_0;
      smp_read_offset_r0 <= sig_251_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 252, LSLICE 3

  assign sig_252_lut_0 = (~smp_read_offset_b2 & ~cmd001000xx_select & ~i_mcu_rws & ((smp_read_offset_r2 & ~smp_read_offset_c2) | (smp_read_offset_r2 & smp_read_offset_c2))) | (~smp_read_offset_b2 & ~cmd001000xx_select & i_mcu_rws) | (~smp_read_offset_b2 & cmd001000xx_select & ~i_mcu_rws & ((~smp_read_offset_r2 & smp_read_offset_c2) | (smp_read_offset_r2 & smp_read_offset_c2))) | (~smp_read_offset_b2 & cmd001000xx_select & i_mcu_rws);
  assign sig_252_lut_1 = (~smp_read_offset_b1 & ~cmd001000xx_select & ~smp_read_offset_r1 & ((i_mcu_rws & ~smp_read_offset_c1) | (i_mcu_rws & smp_read_offset_c1))) | (~smp_read_offset_b1 & ~cmd001000xx_select & smp_read_offset_r1) | (~smp_read_offset_b1 & cmd001000xx_select & ~smp_read_offset_r1 & ((i_mcu_rws | smp_read_offset_c1))) | (~smp_read_offset_b1 & cmd001000xx_select & smp_read_offset_r1 & ((i_mcu_rws | smp_read_offset_c1)));

  always @(posedge i_mcu_clk)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      smp_read_offset_r2 <= sig_252_lut_0;
      smp_read_offset_r1 <= sig_252_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 257, MSLICE 1

  assign sig_257_lut_0 = (~cmd001000xx_select & ~i_mcu_rws & ((smp_read_offset_r8 & ~smp_read_offset_c8) | (smp_read_offset_r8 & smp_read_offset_c8))) | (~cmd001000xx_select & i_mcu_rws) | (cmd001000xx_select & ~i_mcu_rws & ((~smp_read_offset_r8 & smp_read_offset_c8) | (smp_read_offset_r8 & smp_read_offset_c8))) | (cmd001000xx_select & i_mcu_rws);
  assign sig_257_lut_1 = 1'b0;
  assign sig_257_ff0_d = (~smp_read_offset_b8 & sig_257_lut_0) | (smp_read_offset_b8 & sig_257_lut_1);

  always @(posedge i_mcu_clk)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      smp_read_offset_r8 <= sig_257_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 262, LSLICE 3

  assign db_match_k = ((~db_cnt_b9 & disp_bright_b9));
  assign db_match_l = ((~disp_bright_b9 & db_cnt_b9));

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable0 == 1'b1)   //enable
     begin
      disp_bright_b9 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 263, MSLICE 1

  assign sig_263_lut_0 = (~read_addr_l10 & ~read_addr_l11 & ((o_adc1A_d0_7 & ~o_adc1A_d1_7) | (o_adc1A_d0_7 & o_adc1A_d1_7))) | (~read_addr_l10 & read_addr_l11) | (read_addr_l10 & ~read_addr_l11 & ((~o_adc1A_d0_7 & o_adc1A_d1_7) | (o_adc1A_d0_7 & o_adc1A_d1_7))) | (read_addr_l10 & read_addr_l11);
  assign sig_263_lut_1 = 1'b0;
  assign read_adc1A_b7 = (~read_adc1A_h_b7 & sig_263_lut_0) | (read_adc1A_h_b7 & sig_263_lut_1);

//---------------------------------------------------------------------------
//Block 264, LSLICE 2

  assign db_match_b = (~db_cnt_b2 & ~disp_bright_b2 & ~db_match_a & (~(db_cnt_b3 & ~disp_bright_b3))) | (~db_cnt_b2 & disp_bright_b2 & ~db_match_a & (~(db_cnt_b3 & ~disp_bright_b3))) | (~db_cnt_b2 & disp_bright_b2 & db_match_a & (~(db_cnt_b3 & ~disp_bright_b3))) | (db_cnt_b2 & disp_bright_b2 & ~db_match_a & (~(db_cnt_b3 & ~disp_bright_b3)));
  assign db_match_c = (~db_match_b & ~db_cnt_b4 & ~db_cnt_b3 & ((~disp_bright_b4 & ~disp_bright_b3))) | (~db_match_b & ~db_cnt_b4 & db_cnt_b3 & ((~disp_bright_b4 & ~disp_bright_b3) | (~disp_bright_b4 & disp_bright_b3))) | (~db_match_b & db_cnt_b4 & ~db_cnt_b3 & ((~disp_bright_b4 & ~disp_bright_b3) | (disp_bright_b4 & ~disp_bright_b3))) | (~db_match_b & db_cnt_b4 & db_cnt_b3);

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable1 == 1'b1)   //enable
     begin
      disp_bright_b2 <= io_mcu_d_2;
      disp_bright_b3 <= io_mcu_d_3;
    end
  end

//---------------------------------------------------------------------------
//Block 265, LSLICE 3

  assign db_match_d = (~db_match_c & ~disp_bright_b5 & ~db_cnt_b5 & (~(db_cnt_b4 & ~disp_bright_b4))) | (~db_match_c & disp_bright_b5 & ~db_cnt_b5 & (~(db_cnt_b4 & ~disp_bright_b4))) | (~db_match_c & disp_bright_b5 & db_cnt_b5 & (~(db_cnt_b4 & ~disp_bright_b4)));
  assign db_match_e = (db_match_g & ~disp_bright_b6 & ~db_cnt_b6 & ((db_match_j & ~db_match_d))) | (db_match_g & disp_bright_b6 & db_cnt_b6 & ((db_match_j & ~db_match_d)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable1 == 1'b1)   //enable
     begin
      disp_bright_b4 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 266, MSLICE 0

  assign sig_266_lut_0 = (~read_addr_l10 & ~read_addr_l11 & ((o_adc1A_d0_3 & ~o_adc1A_d1_3) | (o_adc1A_d0_3 & o_adc1A_d1_3))) | (~read_addr_l10 & read_addr_l11) | (read_addr_l10 & ~read_addr_l11 & ((~o_adc1A_d0_3 & o_adc1A_d1_3) | (o_adc1A_d0_3 & o_adc1A_d1_3))) | (read_addr_l10 & read_addr_l11);
  assign sig_266_lut_1 = 1'b0;
  assign read_adc1A_b3 = (~read_adc1A_h_b3 & sig_266_lut_0) | (read_adc1A_h_b3 & sig_266_lut_1);

//---------------------------------------------------------------------------
//Block 267, LSLICE 2

  assign db_match_m = (~db_match_i & ~db_match_e & ~db_match_l & ((db_cnt_b10 & ~disp_bright_b10))) | (~db_match_i & ~db_match_e & db_match_l & (~(~db_cnt_b10 & disp_bright_b10))) | (~db_match_i & db_match_e & ~db_match_l & (~(~db_cnt_b10 & disp_bright_b10))) | (~db_match_i & db_match_e & db_match_l & (~(~db_cnt_b10 & disp_bright_b10))) | (db_match_i & ~db_match_e & ~db_match_l & (~(~db_cnt_b10 & disp_bright_b10))) | (db_match_i & ~db_match_e & db_match_l & (~(~db_cnt_b10 & disp_bright_b10))) | (db_match_i & db_match_e & ~db_match_l & (~(~db_cnt_b10 & disp_bright_b10))) | (db_match_i & db_match_e & db_match_l & (~(~db_cnt_b10 & disp_bright_b10)));
  assign db_match_n = (~db_cnt_b11 & (~(~disp_bright_b11 & db_match_m))) | (db_cnt_b11 & ((disp_bright_b11 & ~db_match_m)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable0 == 1'b1)   //enable
     begin
      disp_bright_b11 <= io_mcu_d_3;
    end
  end

//---------------------------------------------------------------------------
//Block 268, MSLICE 1

  assign sig_268_lut_0 = (~prev_vs_lev_e & ~prev_vs_lev_f & ((trigger_previous_b5 & ~prev_vs_lev_h))) | (~prev_vs_lev_e & prev_vs_lev_f & ((~trigger_previous_b5 & ~prev_vs_lev_h) | (trigger_previous_b5 & ~prev_vs_lev_h))) | (prev_vs_lev_e & ~prev_vs_lev_f & ((~trigger_previous_b5 & ~prev_vs_lev_h) | (trigger_previous_b5 & ~prev_vs_lev_h))) | (prev_vs_lev_e & prev_vs_lev_f & ((~trigger_previous_b5 & ~prev_vs_lev_h) | (trigger_previous_b5 & ~prev_vs_lev_h)));
  assign sig_268_lut_1 = (~prev_vs_lev_e & prev_vs_lev_f & ((trigger_previous_b5 & ~prev_vs_lev_h))) | (prev_vs_lev_e & ~prev_vs_lev_f & ((trigger_previous_b5 & ~prev_vs_lev_h))) | (prev_vs_lev_e & prev_vs_lev_f & ((trigger_previous_b5 & ~prev_vs_lev_h)));
  assign prev_vs_lev_i = (~trigger_level_b5 & sig_268_lut_0) | (trigger_level_b5 & sig_268_lut_1);

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg14 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg14 <= time_base_cnt_out14;
    end
  end

//---------------------------------------------------------------------------
//Block 269, MSLICE 0

  assign net_425 = (cmd_b1 & read_adc2A_b0 & ((cmd001000xx_select & ~cmd_b0)));
  assign trigger_data_b0 = (~trigger_channel & ((~read_adc2A_b0 & ~read_adc1A_b0) | (read_adc2A_b0 & ~read_adc1A_b0))) | (trigger_channel & ((~read_adc2A_b0 & ~read_adc1A_b0) | (~read_adc2A_b0 & read_adc1A_b0)));

//---------------------------------------------------------------------------
//Block 270, LSLICE 2

  assign trigger_data_b3 = (~read_adc1A_b3 & (~(read_adc2A_b3 & trigger_channel))) | (read_adc1A_b3 & ((~read_adc2A_b3 & trigger_channel)));
  assign trigger_data_b7 = (~trigger_channel & ((~read_adc2A_b7 & ~read_adc1A_b7) | (read_adc2A_b7 & ~read_adc1A_b7))) | (trigger_channel & ((~read_adc2A_b7 & ~read_adc1A_b7) | (~read_adc2A_b7 & read_adc1A_b7)));

//---------------------------------------------------------------------------
//Block 271, MSLICE 1

  assign read_adc2B_h_b1 = (~read_addr_l10 & ((~o_adc2B_d3_1 & ~o_adc2B_d2_1) | (o_adc2B_d3_1 & ~o_adc2B_d2_1))) | (read_addr_l10 & ((~o_adc2B_d3_1 & ~o_adc2B_d2_1) | (~o_adc2B_d3_1 & o_adc2B_d2_1)));
  assign net_426 = (~cmd23_select & ~read_adc1A_b2) | (~cmd23_select & read_adc1A_b2 & ((~cmd20_select & ~read_adc2B_b2) | (~cmd20_select & read_adc2B_b2))) | (cmd23_select & ~read_adc1A_b2 & ((~cmd20_select & read_adc2B_b2) | (cmd20_select & read_adc2B_b2))) | (cmd23_select & read_adc1A_b2 & ((~cmd20_select & read_adc2B_b2)));

//---------------------------------------------------------------------------
//Block 272, LSLICE 3

  assign cmd15_enable = (cmdxxxx01xx_select & cmd1x_data_write & ((~cmd_b1 & cmd_b0)));
  assign trigger_data_b1 = (~trigger_channel & ((~read_adc2A_b1 & ~read_adc1A_b1) | (read_adc2A_b1 & ~read_adc1A_b1))) | (trigger_channel & ((~read_adc2A_b1 & ~read_adc1A_b1) | (~read_adc2A_b1 & read_adc1A_b1)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd15_enable == 1'b1)   //enable
     begin
      trigger_channel <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 273, MSLICE 0

  assign net_431 = (~cmd65_select & ((i_mcu_dcs & ~i_mcu_rws) | (i_mcu_dcs & i_mcu_rws))) | (cmd65_select & ((i_mcu_dcs & ~i_mcu_rws)));
  assign cmd65_select = (cmdxxxx01xx_select & cmd_b0 & ((~cmd_b1 & cmd6x_select)));

//---------------------------------------------------------------------------
//Block 274, LSLICE 2

  assign net_433 = (net_805 & ~read_adc1B_b7 & ~cmd21_select & (~(o_adc2B_d_7 & cmd23_select))) | (net_805 & read_adc1B_b7 & ~cmd21_select & (~(o_adc2B_d_7 & cmd23_select))) | (net_805 & read_adc1B_b7 & cmd21_select & (~(o_adc2B_d_7 & cmd23_select)));
  assign net_435 = (net_433 & net_777 & ~cmd20_select & ((~read_adc1A_b7 & ~cmd22_adc2A_b7) | (read_adc1A_b7 & ~cmd22_adc2A_b7))) | (net_433 & net_777 & cmd20_select & ((~read_adc1A_b7 & ~cmd22_adc2A_b7)));

//---------------------------------------------------------------------------
//Block 275, LSLICE 3

  assign sig_275_lut_0 = (~db_cnt_b15 & ((disp_bright_b15 | db_match_r))) | (db_cnt_b15 & ((disp_bright_b15 & db_match_r)));
  assign net_434 = (o_mcu_d_3 & ~not_cmd_05_0A) | (o_mcu_d_3 & not_cmd_05_0A & (~(net_470 & ~cmd06_enable0)));

  always @(posedge clk_50MHz)
  begin
    if(pwm_enable == 1'b0)   //enable
     begin
      pwm_display <= sig_275_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 276, MSLICE 1

  assign sig_276_lut_0 = 1'b0;
  assign sig_276_lut_1 = (~cmd_b1 & ~cmd_b2 & ((cmd6x_select & ~cmd_b0)));
  assign cmd68_select = (~cmd_b3 & sig_276_lut_0) | (cmd_b3 & sig_276_lut_1);

//---------------------------------------------------------------------------
//Block 277, MSLICE 0

  assign sig_277_lut_0 = 1'b0;
  assign sig_277_lut_1 = (cmd_b0 & ~cmd_b1 & ((~cmd_b2 & cmd6x_select)));
  assign cmd69_select = (~cmd_b3 & sig_277_lut_0) | (cmd_b3 & sig_277_lut_1);

//---------------------------------------------------------------------------
//Block 278, LSLICE 2

  assign cmd24_select = (cmd2x_select & cmdxxxx01xx_select & ((~cmd_b1 & ~cmd_b0)));
  assign cmd27_select = (cmdxxxxxx11_select & ((cmd2x_select & cmdxxxx01xx_select)));

//---------------------------------------------------------------------------
//Block 279, MSLICE 1

  assign sig_279_lut_0 = (~i_mcu_dcs & ~o_mcu_d_7 & ((~cmd_b7 & ~net_546) | (cmd_b7 & ~net_546))) | (~i_mcu_dcs & o_mcu_d_7 & ((~cmd_b7 & ~net_546) | (cmd_b7 & ~net_546))) | (i_mcu_dcs & ~o_mcu_d_7 & ((cmd_b7 & ~net_546) | (cmd_b7 & net_546))) | (i_mcu_dcs & o_mcu_d_7 & ((cmd_b7 & ~net_546) | (cmd_b7 & net_546)));
  assign sig_279_lut_1 = (~cmd_b7 & o_mcu_d_7) | (cmd_b7 & o_mcu_d_7);
  assign sig_279_ff0_d = (~i_mcu_rws & sig_279_lut_0) | (i_mcu_rws & sig_279_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_mcu_d_7 <= sig_279_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 280, LSLICE 3

  assign db_match_f = ((db_cnt_b6 & ~disp_bright_b6));
  assign cmd0x_select = (~cmd_b4 & ~cmd_b6 & ((~cmd_b5 & ~cmd_b7)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable1 == 1'b1)   //enable
     begin
      disp_bright_b6 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 281, LSLICE 2

  assign cmd41_select = (cmdxxxx0001_select & cmd_b6 & ~cmd_b7 & ((~cmd_b5 & ~cmd_b4)));
  assign cmd6x_select = (~cmd_b4 & cmd_b5 & ((cmd_b6 & ~cmd_b7)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd_write_enable == 1'b1)   //enable
     begin
      cmd_b4 <= io_mcu_d_4;
      cmd_b5 <= io_mcu_d_5;
    end
  end

//---------------------------------------------------------------------------
//Block 282, LSLICE 3

  assign net_446 = (~net_310 & ~byte_state_0 & ((cmd41_select & ~cmd3C_b7) | (cmd41_select & cmd3C_b7))) | (~net_310 & byte_state_0 & ((cmd41_select & cmd3C_b7)));
  assign net_451 = (net_435 & ((net_800 & ~net_446)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable0 == 1'b1)   //enable
     begin
      cmd3C_b7 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 283, MSLICE 1

  assign cmd2x_select = (cmd_b5 & ~cmd_b7 & ((~cmd_b6 & ~cmd_b4)));
  assign cmd3x_select = (~cmd_b7 & cmd_b5 & ((~cmd_b6 & cmd_b4)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd_write_enable == 1'b1)   //enable
     begin
      cmd_b6 <= io_mcu_d_6;
      cmd_b7 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 284, MSLICE 0

  assign cmd16_enable = (cmd_b1 & cmd1x_data_write & ((cmdxxxx01xx_select & ~cmd_b0)));
  assign cmd36_enable = (cmdxxxx01xx_select & cmd_b1 & ((cmd3x_data_write & ~cmd_b0)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd16_enable == 1'b1)   //enable
     begin
      trigger_edge <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 285, LSLICE 2

  assign net_460 = (net_560 & ~not_cmd_05_0A & ((~o_mcu_d_5 & ~net_459) | (~o_mcu_d_5 & net_459))) | (net_560 & not_cmd_05_0A & (~(o_mcu_d_5 & net_459)));
  assign net_459 = ((net_561 & net_718));

//---------------------------------------------------------------------------
//Block 286, MSLICE 1

  assign sig_286_lut_0 = ~calib_1khz;
  assign net_461 = (~o_mcu_d_6 & ~cmd06_enable0 & ((~net_710 & net_366) | (net_710 & net_366))) | (~o_mcu_d_6 & cmd06_enable0 & ((~net_710 & net_366) | (net_710 & net_366))) | (o_mcu_d_6 & ~cmd06_enable0 & ((net_710 & net_366)));

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //enable
     begin
      calib_1khz <= sig_286_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 287, LSLICE 3

  assign cmd38_enable1 = (cmd38_select & ~i_mcu_dcs & ((i_mcu_rws & byte_state_1)));
  assign db_match_a = (~disp_bright_b0 & ~db_cnt_b1 & ((~db_cnt_b0 & ~disp_bright_b1) | (db_cnt_b0 & ~disp_bright_b1))) | (~disp_bright_b0 & db_cnt_b1) | (disp_bright_b0 & ~db_cnt_b1 & ((db_cnt_b0 & ~disp_bright_b1))) | (disp_bright_b0 & db_cnt_b1 & (~(~db_cnt_b0 & disp_bright_b1)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable1 == 1'b1)   //enable
     begin
      disp_bright_b0 <= io_mcu_d_0;
      disp_bright_b1 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 288, LSLICE 2

  assign sig_288_lut_0 = (~ch2_offset_b15 & ((~offset2_pwm_r15 & net_313))) | (ch2_offset_b15 & (~(offset2_pwm_r15 & ~net_313)));
  assign net_470 = (~net_459 & ((~cmd0001x000_select & ~cmd67_select)));

  always @(posedge clk_50MHz)
  begin
    if(offset2_pwm_rst == 1'b0)   //enable
     begin
      offset_2 <= sig_288_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 289, MSLICE 1

  assign cmd37_enable = (cmdxxxxxx11_select & ((cmdxxxx01xx_select & cmd3x_data_write)));
  assign cmd67_select = (cmdxxxxxx11_select & ((cmdxxxx01xx_select & cmd6x_select)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd37_enable == 1'b1)   //enable
     begin
      ac_dc_2 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 290, LSLICE 3

  assign cmd1F_enable0 = (cmd_b3 & cmd_b2 & byte_state_0 & ((cmd1x_select & cmdxxxxxx11_select)));
  assign cmd_6F_1F_select = (cmd_b3 & ~cmd6x_select & cmd_b2 & ((cmdxxxxxx11_select & cmd1x_select))) | (cmd_b3 & cmd6x_select & cmd_b2 & ((cmdxxxxxx11_select & ~cmd1x_select) | (cmdxxxxxx11_select & cmd1x_select)));

//---------------------------------------------------------------------------
//Block 291, MSLICE 0

  assign cmd14_select = (cmdxxxx01xx_select & cmd1x_select & ((~cmd_b1 & ~cmd_b0)));
  assign not_cmd_41_14_06 = (~cmd06_select & ((~cmd41_select & ~cmd14_select)));

//---------------------------------------------------------------------------
//Block 292, LSLICE 2

  assign smp_read_offset_b10 = (~cmd1F_enable0 & i_mcu_rws & ((~smp_read_offset_r10 & ~io_mcu_d_2) | (~smp_read_offset_r10 & io_mcu_d_2))) | (cmd1F_enable0 & i_mcu_rws & ((~smp_read_offset_r10 & ~io_mcu_d_2) | (smp_read_offset_r10 & ~io_mcu_d_2)));
  assign cmd0x_data_write = (i_mcu_rws & ((~i_mcu_dcs & cmd0x_select)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable3 == 1'b1)   //enable
     begin
      sample_rate_b2 <= io_mcu_d_2;
    end
  end

//---------------------------------------------------------------------------
//Block 293, MSLICE 1

  assign net_480 = (~net_218 & (~(offset2_pwm_r11 & ~ch2_offset_b11))) | (net_218 & ((~offset2_pwm_r11 & ch2_offset_b11)));
  assign net_477 = (~i_mcu_dcs & ((not_cmd_41_14_06 & ~i_mcu_rws))) | (i_mcu_dcs & ((~not_cmd_41_14_06 & ~i_mcu_rws) | (not_cmd_41_14_06 & ~i_mcu_rws)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd35_enable0 == 1'b1)   //enable
     begin
      ch2_offset_b11 <= io_mcu_d_3;
    end
  end

//---------------------------------------------------------------------------
//Block 294, LSLICE 3

  assign mcu_data_dir = ~i_mcu_rws;
  assign net_482 = ((~i_mcu_rws & ~not_cmd_41_14_06));

//---------------------------------------------------------------------------
//Block 295, MSLICE 0

  assign smp_read_offset_b0 = (i_mcu_rws & ~cmd1F_enable1 & ((~smp_read_offset_r0 & ~io_mcu_d_0) | (~smp_read_offset_r0 & io_mcu_d_0))) | (i_mcu_rws & cmd1F_enable1 & ((~smp_read_offset_r0 & ~io_mcu_d_0) | (smp_read_offset_r0 & ~io_mcu_d_0)));
  assign smp_read_offset_b4 = (~cmd1F_enable1 & i_mcu_rws & ((~io_mcu_d_4 & ~smp_read_offset_r4) | (io_mcu_d_4 & ~smp_read_offset_r4))) | (cmd1F_enable1 & i_mcu_rws & ((~io_mcu_d_4 & ~smp_read_offset_r4) | (~io_mcu_d_4 & smp_read_offset_r4)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable2 == 1'b1)   //enable
     begin
      sample_rate_b8 <= io_mcu_d_0;
      sample_rate_b12 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 296, LSLICE 3

  assign sig_296_lut_0 = (~smp_read_offset_b3 & ~cmd001000xx_select & ~i_mcu_rws & ((smp_read_offset_r3 & ~smp_read_offset_c3) | (smp_read_offset_r3 & smp_read_offset_c3))) | (~smp_read_offset_b3 & ~cmd001000xx_select & i_mcu_rws) | (~smp_read_offset_b3 & cmd001000xx_select & ~i_mcu_rws & ((~smp_read_offset_r3 & smp_read_offset_c3) | (smp_read_offset_r3 & smp_read_offset_c3))) | (~smp_read_offset_b3 & cmd001000xx_select & i_mcu_rws);
  assign sig_296_lut_1 = (~smp_read_offset_b11 & ~smp_read_offset_r11 & ~i_mcu_rws & ((cmd001000xx_select & smp_read_offset_c11))) | (~smp_read_offset_b11 & ~smp_read_offset_r11 & i_mcu_rws) | (~smp_read_offset_b11 & smp_read_offset_r11 & ~i_mcu_rws & (~(cmd001000xx_select & ~smp_read_offset_c11))) | (~smp_read_offset_b11 & smp_read_offset_r11 & i_mcu_rws);

  always @(posedge i_mcu_clk)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      smp_read_offset_r3 <= sig_296_lut_0;
      smp_read_offset_r11 <= sig_296_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 297, MSLICE 0

  assign smp_read_offset_b7 = (i_mcu_rws & ~cmd1F_enable1 & ((~smp_read_offset_r7 & ~io_mcu_d_7) | (~smp_read_offset_r7 & io_mcu_d_7))) | (i_mcu_rws & cmd1F_enable1 & ((~smp_read_offset_r7 & ~io_mcu_d_7) | (smp_read_offset_r7 & ~io_mcu_d_7)));
  assign smp_read_offset_b5 = (~cmd1F_enable1 & ~io_mcu_d_5 & ((~smp_read_offset_r5 & i_mcu_rws))) | (~cmd1F_enable1 & io_mcu_d_5 & ((~smp_read_offset_r5 & i_mcu_rws))) | (cmd1F_enable1 & ~io_mcu_d_5 & ((~smp_read_offset_r5 & i_mcu_rws) | (smp_read_offset_r5 & i_mcu_rws)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable2 == 1'b1)   //enable
     begin
      sample_rate_b15 <= io_mcu_d_7;
      sample_rate_b13 <= io_mcu_d_5;
    end
  end

//---------------------------------------------------------------------------
//Block 298, LSLICE 2

  assign smp_read_offset_b11 = (~cmd1F_enable0 & ~smp_read_offset_r11 & ((i_mcu_rws & ~io_mcu_d_3) | (i_mcu_rws & io_mcu_d_3))) | (cmd1F_enable0 & ~smp_read_offset_r11 & ((i_mcu_rws & ~io_mcu_d_3))) | (cmd1F_enable0 & smp_read_offset_r11 & ((i_mcu_rws & ~io_mcu_d_3)));
  assign mcu_d000000xx = ((mcu_d00000xxx & ~io_mcu_d_2));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable1 == 1'b1)   //enable
     begin
      sample_rate_b19 <= io_mcu_d_3;
      sample_rate_b18 <= io_mcu_d_2;
    end
  end

//---------------------------------------------------------------------------
//Block 299, MSLICE 1

  assign smp_read_offset_b2 = (i_mcu_rws & ~cmd1F_enable1 & ((~smp_read_offset_r2 & ~io_mcu_d_2) | (~smp_read_offset_r2 & io_mcu_d_2))) | (i_mcu_rws & cmd1F_enable1 & ((~smp_read_offset_r2 & ~io_mcu_d_2) | (smp_read_offset_r2 & ~io_mcu_d_2)));
  assign smp_read_offset_b3 = (~smp_read_offset_r3 & ~cmd1F_enable1 & ((i_mcu_rws & ~io_mcu_d_3) | (i_mcu_rws & io_mcu_d_3))) | (~smp_read_offset_r3 & cmd1F_enable1 & ((i_mcu_rws & ~io_mcu_d_3))) | (smp_read_offset_r3 & cmd1F_enable1 & ((i_mcu_rws & ~io_mcu_d_3)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable0 == 1'b1)   //enable
     begin
      sample_rate_b26 <= io_mcu_d_2;
      sample_rate_b27 <= io_mcu_d_3;
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 300, 301, 302, 304, 306, 307, 308, 309, 310

  always @(posedge clk_50MHz)
  begin
    if(pwm_enable == 1'b1)   //reset
    begin
      { db_cnt_b15, db_cnt_b14, db_cnt_b13, db_cnt_b12, db_cnt_b11, db_cnt_b10, db_cnt_b9, db_cnt_b8, db_cnt_b7, db_cnt_b6, db_cnt_b5, db_cnt_b4, db_cnt_b3, db_cnt_b2, db_cnt_b1, db_cnt_b0 } <= { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      { db_cnt_b15, db_cnt_b14, db_cnt_b13, db_cnt_b12, db_cnt_b11, db_cnt_b10, db_cnt_b9, db_cnt_b8, db_cnt_b7, db_cnt_b6, db_cnt_b5, db_cnt_b4, db_cnt_b3, db_cnt_b2, db_cnt_b1, db_cnt_b0 } <= { db_cnt_b15, db_cnt_b14, db_cnt_b13, db_cnt_b12, db_cnt_b11, db_cnt_b10, db_cnt_b9, db_cnt_b8, db_cnt_b7, db_cnt_b6, db_cnt_b5, db_cnt_b4, db_cnt_b3, db_cnt_b2, db_cnt_b1, db_cnt_b0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
    end
  end

//---------------------------------------------------------------------------
//Block 303, LSLICE 2

  assign sig_303_lut_0 = ~clk_50MHz;
  assign pwm_enable = (~pwm_enable_a & db_cnt_b15 & ((db_cnt_b13 & db_cnt_b14)));

  always @(posedge clock_200MHz)
  begin
    if(clk_a_reset == 1'b1)   //enable
     begin
      clk_50MHz <= sig_303_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 305, LSLICE 3

  assign read_adc1A_b6 = (~read_adc1A_h_b6 & ~read_addr_l10 & ~read_addr_l11 & ((o_adc1A_d0_6 & ~o_adc1A_d1_6) | (o_adc1A_d0_6 & o_adc1A_d1_6))) | (~read_adc1A_h_b6 & ~read_addr_l10 & read_addr_l11) | (~read_adc1A_h_b6 & read_addr_l10 & ~read_addr_l11 & ((~o_adc1A_d0_6 & o_adc1A_d1_6) | (o_adc1A_d0_6 & o_adc1A_d1_6))) | (~read_adc1A_h_b6 & read_addr_l10 & read_addr_l11);
  assign read_adc1A_h_b6 = (~o_adc1A_d3_6 & ~o_adc1A_d2_6 & ((read_addr_l11 & ~read_addr_l10) | (read_addr_l11 & read_addr_l10))) | (~o_adc1A_d3_6 & o_adc1A_d2_6 & ((read_addr_l11 & read_addr_l10))) | (o_adc1A_d3_6 & ~o_adc1A_d2_6 & ((read_addr_l11 & ~read_addr_l10)));

//---------------------------------------------------------------------------
//Block 311, LSLICE 2

  assign db_match_h = (~db_cnt_b7 & ~disp_bright_b7 & ~db_match_f & (~(db_cnt_b8 & ~disp_bright_b8))) | (~db_cnt_b7 & disp_bright_b7 & ~db_match_f & (~(db_cnt_b8 & ~disp_bright_b8))) | (~db_cnt_b7 & disp_bright_b7 & db_match_f & (~(db_cnt_b8 & ~disp_bright_b8))) | (db_cnt_b7 & disp_bright_b7 & ~db_match_f & (~(db_cnt_b8 & ~disp_bright_b8)));
  assign db_match_g = (~db_cnt_b7 & ~disp_bright_b7 & (~(~db_cnt_b5 & disp_bright_b5))) | (db_cnt_b7 & ~disp_bright_b7 & (~(~db_cnt_b5 & disp_bright_b5))) | (db_cnt_b7 & disp_bright_b7 & (~(~db_cnt_b5 & disp_bright_b5)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable1 == 1'b1)   //enable
     begin
      disp_bright_b7 <= io_mcu_d_7;
      disp_bright_b5 <= io_mcu_d_5;
    end
  end

//---------------------------------------------------------------------------
//Block 312, MSLICE 1

  assign trigger_data_b5 = (~read_adc1A_b5 & (~(read_adc2A_b5 & trigger_channel))) | (read_adc1A_b5 & ((~read_adc2A_b5 & trigger_channel)));
  assign prev_vs_lev_b = ((trigger_level_b2 & ~trigger_previous_b2));

//---------------------------------------------------------------------------
//Block 313, MSLICE 0

  assign sig_313_lut_0 = (~read_addr_l10 & ~read_addr_l11 & ((o_adc1A_d0_1 & ~o_adc1A_d1_1) | (o_adc1A_d0_1 & o_adc1A_d1_1))) | (~read_addr_l10 & read_addr_l11) | (read_addr_l10 & ~read_addr_l11 & ((~o_adc1A_d0_1 & o_adc1A_d1_1) | (o_adc1A_d0_1 & o_adc1A_d1_1))) | (read_addr_l10 & read_addr_l11);
  assign sig_313_lut_1 = 1'b0;
  assign read_adc1A_b1 = (~read_adc1A_h_b1 & sig_313_lut_0) | (read_adc1A_h_b1 & sig_313_lut_1);

//---------------------------------------------------------------------------
//Block 314, LSLICE 2

  assign db_match_r = (~db_cnt_b14 & ~disp_bright_b14 & (~(~db_match_o & db_match_q))) | (~db_cnt_b14 & disp_bright_b14 & (~(~db_match_o & db_match_q))) | (db_cnt_b14 & disp_bright_b14 & (~(~db_match_o & db_match_q)));
  assign db_match_q = (~db_cnt_b14 & ~disp_bright_b13 & ((~disp_bright_b14 & ~db_cnt_b13) | (~disp_bright_b14 & db_cnt_b13))) | (~db_cnt_b14 & disp_bright_b13 & ((~disp_bright_b14 & db_cnt_b13))) | (db_cnt_b14 & ~disp_bright_b13) | (db_cnt_b14 & disp_bright_b13 & ((~disp_bright_b14 & db_cnt_b13) | (disp_bright_b14 & db_cnt_b13)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd38_enable0 == 1'b1)   //enable
     begin
      disp_bright_b14 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 315, LSLICE 3

  assign read_adc1A_h_b3 = (~o_adc1A_d2_3 & read_addr_l11 & (~(read_addr_l10 & o_adc1A_d3_3))) | (o_adc1A_d2_3 & read_addr_l11 & ((read_addr_l10 & ~o_adc1A_d3_3)));
  assign read_addr_11 = (~pre_trigger_addr11 & ((smp_read_offset_r11 & sample_read_enable))) | (pre_trigger_addr11 & (~(~smp_read_offset_r11 & sample_read_enable)));

  always @(posedge sample_read_clock)
  begin
    read_addr_l11 <= read_addr_11;
  end

//---------------------------------------------------------------------------
//Block 316, MSLICE 0

  assign cmd20_select = (~cmd_b0 & ((cmd001000xx_select & ~cmd_b1)));
  assign net_535 = (~cmd21_select & ~read_adc1B_b4 & (~(read_adc1A_b4 & cmd20_select))) | (~cmd21_select & read_adc1B_b4 & (~(read_adc1A_b4 & cmd20_select))) | (cmd21_select & read_adc1B_b4 & (~(read_adc1A_b4 & cmd20_select)));

//---------------------------------------------------------------------------
//Block 317, LSLICE 2

  assign net_538 = (net_797 & ~read_adc1B_b6 & ~cmd21_select & (~(o_adc2B_d_6 & cmd23_select))) | (net_797 & read_adc1B_b6 & ~cmd21_select & (~(o_adc2B_d_6 & cmd23_select))) | (net_797 & read_adc1B_b6 & cmd21_select & (~(o_adc2B_d_6 & cmd23_select)));
  assign net_537 = (net_538 & net_679 & ~cmd20_select & ((~cmd22_adc2A_b6 & ~read_adc1A_b6) | (~cmd22_adc2A_b6 & read_adc1A_b6))) | (net_538 & net_679 & cmd20_select & ((~cmd22_adc2A_b6 & ~read_adc1A_b6)));

//---------------------------------------------------------------------------
//Block 318, MSLICE 1

  assign sig_318_lut_0 = 1'b0;
  assign sig_318_lut_1 = (net_544 & net_782 & (~(i_i2c_cmd6D_b3 & cmd6D_select)));
  assign net_536 = (~net_796 & sig_318_lut_0) | (net_796 & sig_318_lut_1);

//---------------------------------------------------------------------------
//Block 319, MSLICE 0

  assign net_545 = ((offset1_pwm_r9 & ~ch1_offset_b9));
  assign net_546 = (~cmd06_enable0 & ~o_mcu_d_7 & ((net_451 & ~net_710) | (net_451 & net_710))) | (~cmd06_enable0 & o_mcu_d_7 & ((net_451 & net_710))) | (cmd06_enable0 & ~o_mcu_d_7 & ((net_451 & ~net_710) | (net_451 & net_710)));

  always @(posedge clk_50MHz)
  begin
    if(offset1_pwm_rst == 1'b1)   //reset
    begin
      offset1_pwm_r9 <= 1'b0;
    end
    else
    begin
      offset1_pwm_r9 <= offset1_pwm_c9;
    end
  end

//---------------------------------------------------------------------------
//Block 320, LSLICE 2

  assign net_543 = (cmd001000xx_select & cmd_b1 & ~cmd_b0 & ((~o_adc2B_d_3 & read_adc2A_b3) | (o_adc2B_d_3 & read_adc2A_b3))) | (cmd001000xx_select & cmd_b1 & cmd_b0 & ((o_adc2B_d_3 & ~read_adc2A_b3) | (o_adc2B_d_3 & read_adc2A_b3)));
  assign net_544 = (~net_543 & ~read_adc1A_b3 & ~cmd20_select & (~(i_i2c_cmd6B_b3 & cmd6B_select))) | (~net_543 & ~read_adc1A_b3 & cmd20_select & (~(i_i2c_cmd6B_b3 & cmd6B_select))) | (~net_543 & read_adc1A_b3 & ~cmd20_select & (~(i_i2c_cmd6B_b3 & cmd6B_select)));

//---------------------------------------------------------------------------
//Block 321, LSLICE 3

  assign net_547 = (net_1005 & ~i_i2c_cmd6B_b1 & ~cmd6B_select & (~(read_adc1A_b1 & cmd20_select))) | (net_1005 & ~i_i2c_cmd6B_b1 & cmd6B_select & (~(read_adc1A_b1 & cmd20_select))) | (net_1005 & i_i2c_cmd6B_b1 & ~cmd6B_select & (~(read_adc1A_b1 & cmd20_select)));
  assign net_542 = (net_547 & net_252 & ~cmd67_select & (~(~net_718 & o_mcu_d_1))) | (net_547 & net_252 & cmd67_select & ((~net_718 & ~o_mcu_d_1) | (net_718 & ~o_mcu_d_1)));

//---------------------------------------------------------------------------
//Block 322, MSLICE 1

  assign cmd26_select = (cmd_b1 & cmdxxxx01xx_select & ((cmd2x_select & ~cmd_b0)));
  assign cmd25_select = (cmd_b0 & cmdxxxx01xx_select & ((~cmd_b1 & cmd2x_select)));

//---------------------------------------------------------------------------
//Block 323, MSLICE 0

  assign cmd06_select = (cmd_b1 & cmd0x_select & ((cmdxxxx01xx_select & ~cmd_b0)));
  assign cmd05_select = (cmdxxxx01xx_select & cmd0x_select & ((cmd_b0 & ~cmd_b1)));

//---------------------------------------------------------------------------
//Block 324, LSLICE 2

  assign sig_324_lut_0 = (~i_mcu_rws & ~i_mcu_dcs & ~o_mcu_d_2 & ((~cmd_b2 & ~net_550) | (cmd_b2 & ~net_550))) | (~i_mcu_rws & ~i_mcu_dcs & o_mcu_d_2 & ((~cmd_b2 & ~net_550) | (cmd_b2 & ~net_550))) | (~i_mcu_rws & i_mcu_dcs & ~o_mcu_d_2 & ((cmd_b2 & ~net_550) | (cmd_b2 & net_550))) | (~i_mcu_rws & i_mcu_dcs & o_mcu_d_2 & ((cmd_b2 & ~net_550) | (cmd_b2 & net_550))) | (i_mcu_rws & ~i_mcu_dcs & o_mcu_d_2) | (i_mcu_rws & i_mcu_dcs & o_mcu_d_2);
  assign net_550 = (~net_710 & ~o_mcu_d_2 & ((read_b2_a & net_714))) | (net_710 & ~o_mcu_d_2 & ((read_b2_a & net_714))) | (net_710 & o_mcu_d_2 & ((read_b2_a & net_714)));

  always @(posedge i_mcu_clk)
  begin
    o_mcu_d_2 <= sig_324_lut_0;
  end

//---------------------------------------------------------------------------
//Block 325, LSLICE 3

  assign net_553 = (~byte_state_0 & ~byte_state_1 & ~cmd3C_b4 & ((o_mcu_d_4 & ~cmd3C_b12) | (o_mcu_d_4 & cmd3C_b12))) | (~byte_state_0 & ~byte_state_1 & cmd3C_b4 & ((o_mcu_d_4 & ~cmd3C_b12) | (o_mcu_d_4 & cmd3C_b12))) | (~byte_state_0 & byte_state_1 & ~cmd3C_b4 & ((~o_mcu_d_4 & cmd3C_b12) | (o_mcu_d_4 & cmd3C_b12))) | (~byte_state_0 & byte_state_1 & cmd3C_b4 & ((~o_mcu_d_4 & cmd3C_b12) | (o_mcu_d_4 & cmd3C_b12))) | (byte_state_0 & ~byte_state_1 & cmd3C_b4) | (byte_state_0 & byte_state_1 & cmd3C_b4);
  assign net_554 = (net_712 & ~net_710 & ~cmd41_select & ((~net_553 & ~o_mcu_d_4) | (net_553 & ~o_mcu_d_4))) | (net_712 & ~net_710 & cmd41_select & ((~net_553 & ~o_mcu_d_4))) | (net_712 & net_710 & ~cmd41_select) | (net_712 & net_710 & cmd41_select & ((~net_553 & ~o_mcu_d_4) | (~net_553 & o_mcu_d_4)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable0 == 1'b1)   //enable
     begin
      cmd3C_b4 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 326, MSLICE 1

  assign sig_326_lut_0 = 1'b0;
  assign sig_326_lut_1 = (cmd0x_select & cmd_b1 & ((~cmd_b2 & ~cmd_b0)));
  assign cmd0A_select = (~cmd_b3 & sig_326_lut_0) | (cmd_b3 & sig_326_lut_1);

//---------------------------------------------------------------------------
//Block 327, LSLICE 2

  assign net_558 = (~byte_state_0 & ~byte_state_1 & ~cmd3C_b5 & ((o_mcu_d_5 & ~cmd3C_b13) | (o_mcu_d_5 & cmd3C_b13))) | (~byte_state_0 & ~byte_state_1 & cmd3C_b5 & ((o_mcu_d_5 & ~cmd3C_b13) | (o_mcu_d_5 & cmd3C_b13))) | (~byte_state_0 & byte_state_1 & ~cmd3C_b5 & ((~o_mcu_d_5 & cmd3C_b13) | (o_mcu_d_5 & cmd3C_b13))) | (~byte_state_0 & byte_state_1 & cmd3C_b5 & ((~o_mcu_d_5 & cmd3C_b13) | (o_mcu_d_5 & cmd3C_b13))) | (byte_state_0 & ~byte_state_1 & cmd3C_b5) | (byte_state_0 & byte_state_1 & cmd3C_b5);
  assign net_560 = (net_723 & ~cmd41_select & ((~net_558 & read_b5_b) | (net_558 & read_b5_b))) | (net_723 & cmd41_select & ((~net_558 & read_b5_b)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable0 == 1'b1)   //enable
     begin
      cmd3C_b5 <= io_mcu_d_5;
    end
  end

//---------------------------------------------------------------------------
//Block 328, LSLICE 3

  assign net_562 = (~cmd_b3 & ~cmd6C_select & ~cmd_b2 & ((~cmd6x_select & ~cmd2x_select) | (cmd6x_select & ~cmd2x_select))) | (~cmd_b3 & ~cmd6C_select & cmd_b2 & ((~cmd6x_select & ~cmd2x_select) | (cmd6x_select & ~cmd2x_select))) | (cmd_b3 & ~cmd6C_select & ~cmd_b2 & ((~cmd6x_select & ~cmd2x_select) | (~cmd6x_select & cmd2x_select))) | (cmd_b3 & ~cmd6C_select & cmd_b2);
  assign net_561 = (net_562 & not_cmd_41_14_06 & ~cmd67_select & ((~cmd6D_select & ~cmd6E_select)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd_write_enable == 1'b1)   //enable
     begin
      cmd_b3 <= io_mcu_d_3;
    end
  end

//---------------------------------------------------------------------------
//Block 329, MSLICE 1

  assign sig_329_lut_0 = (~i_mcu_dcs & ~o_mcu_d_4 & ((~cmd_b4 & ~net_554) | (cmd_b4 & ~net_554))) | (~i_mcu_dcs & o_mcu_d_4 & ((~cmd_b4 & ~net_554) | (cmd_b4 & ~net_554))) | (i_mcu_dcs & ~o_mcu_d_4 & ((cmd_b4 & ~net_554) | (cmd_b4 & net_554))) | (i_mcu_dcs & o_mcu_d_4 & ((cmd_b4 & ~net_554) | (cmd_b4 & net_554)));
  assign sig_329_lut_1 = (~cmd_b4 & o_mcu_d_4) | (cmd_b4 & o_mcu_d_4);
  assign sig_329_ff0_d = (~i_mcu_rws & sig_329_lut_0) | (i_mcu_rws & sig_329_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_mcu_d_4 <= sig_329_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 330, MSLICE 0

  assign sig_330_lut_0 = (~mcu_d0000010x & ~mcu_d000000xx & ((~io_mcu_d_0 & relay2_1) | (io_mcu_d_0 & relay2_1))) | (~mcu_d0000010x & mcu_d000000xx & ((io_mcu_d_0 & ~relay2_1) | (io_mcu_d_0 & relay2_1))) | (mcu_d0000010x & ~mcu_d000000xx & ((io_mcu_d_0 & ~relay2_1) | (io_mcu_d_0 & relay2_1))) | (mcu_d0000010x & mcu_d000000xx & ((io_mcu_d_0 & ~relay2_1) | (io_mcu_d_0 & relay2_1)));
  assign cmd1x_select = (~cmd_b5 & ~cmd_b7 & ((cmd_b4 & ~cmd_b6)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd36_enable == 1'b1)   //enable
     begin
      relay2_1 <= sig_330_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 331, MSLICE 0

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg6 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg6 <= sample_rate_cnt_out6;
    end
  end

//---------------------------------------------------------------------------
//Block 333, MSLICE 1

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg2 <= 1'b0;
      sample_rate_cnt_reg5 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg2 <= sample_rate_cnt_out2;
      sample_rate_cnt_reg5 <= sample_rate_cnt_out5;
    end
  end

//---------------------------------------------------------------------------
//Block 335, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable3 == 1'b1)   //enable
     begin
      sample_rate_b3 <= io_mcu_d_3;
      sample_rate_b4 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 337, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable3 == 1'b1)   //enable
     begin
      sample_rate_b5 <= io_mcu_d_5;
      sample_rate_b6 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 339, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable3 == 1'b1)   //enable
     begin
      sample_rate_b7 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 342, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable2 == 1'b1)   //enable
     begin
      sample_rate_b9 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 343, MSLICE 0

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg9 <= 1'b0;
      sample_rate_cnt_reg8 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg9 <= sample_rate_cnt_out9;
      sample_rate_cnt_reg8 <= sample_rate_cnt_out8;
    end
  end

//---------------------------------------------------------------------------
//Block 346, MSLICE 1

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg13 <= 1'b0;
      sample_rate_cnt_reg14 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg13 <= sample_rate_cnt_out13;
      sample_rate_cnt_reg14 <= sample_rate_cnt_out14;
    end
  end

//---------------------------------------------------------------------------
//Block 347, MSLICE 0

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg21 <= 1'b0;
      sample_rate_cnt_reg22 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg21 <= sample_rate_cnt_out21;
      sample_rate_cnt_reg22 <= sample_rate_cnt_out22;
    end
  end

//---------------------------------------------------------------------------
//Block 350, MSLICE 1

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg17 <= 1'b0;
      sample_rate_cnt_reg18 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg17 <= sample_rate_cnt_out17;
      sample_rate_cnt_reg18 <= sample_rate_cnt_out18;
    end
  end

//---------------------------------------------------------------------------
//Block 351, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable1 == 1'b1)   //enable
     begin
      sample_rate_b20 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 354, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable1 == 1'b1)   //enable
     begin
      sample_rate_b21 <= io_mcu_d_5;
      sample_rate_b22 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 355, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable1 == 1'b1)   //enable
     begin
      sample_rate_b23 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 358, MSLICE 1

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg25 <= 1'b0;
      sample_rate_cnt_reg26 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg25 <= sample_rate_cnt_out25;
      sample_rate_cnt_reg26 <= sample_rate_cnt_out26;
    end
  end

//---------------------------------------------------------------------------
//Block 359, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable0 == 1'b1)   //enable
     begin
      sample_rate_b28 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 360, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable0 == 1'b1)   //enable
     begin
      sample_rate_b29 <= io_mcu_d_5;
      sample_rate_b30 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 361, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable0 == 1'b1)   //enable
     begin
      sample_rate_b31 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 331, 333, 335, 337, 339, 342, 343, 346, 347, 350, 351, 354, 355, 358, 359, 360, 361

  assign { smp_clk_enable, open_0, open_1, open_2, open_3, open_4, open_5, open_6, open_7, open_8, open_9, open_10, open_11, open_12, open_13, open_14, open_15, open_16, open_17, open_18, open_19, open_20, open_21, open_22, open_23, open_24, open_25, open_26, open_27, open_28, open_29, open_30, open_31 } = { 1'b0, sample_rate_b31, sample_rate_b30, sample_rate_b29, sample_rate_b28, sample_rate_b27, sample_rate_b26, sample_rate_b25, sample_rate_b24, sample_rate_b23, sample_rate_b22, sample_rate_b21, sample_rate_b20, sample_rate_b19, sample_rate_b18, sample_rate_b17, sample_rate_b16, sample_rate_b15, sample_rate_b14, sample_rate_b13, sample_rate_b12, sample_rate_b11, sample_rate_b10, sample_rate_b9, sample_rate_b8, sample_rate_b7, sample_rate_b6, sample_rate_b5, sample_rate_b4, sample_rate_b3, sample_rate_b2, sample_rate_b1, sample_rate_b0 } - { sample_rate_cnt_reg31, sample_rate_cnt_reg30, sample_rate_cnt_reg29, sample_rate_cnt_reg28, sample_rate_cnt_reg27, sample_rate_cnt_reg26, sample_rate_cnt_reg25, sample_rate_cnt_reg24, sample_rate_cnt_reg23, sample_rate_cnt_reg22, sample_rate_cnt_reg21, sample_rate_cnt_reg20, sample_rate_cnt_reg19, sample_rate_cnt_reg18, sample_rate_cnt_reg17, sample_rate_cnt_reg16, sample_rate_cnt_reg15, sample_rate_cnt_reg14, sample_rate_cnt_reg13, sample_rate_cnt_reg12, sample_rate_cnt_reg11, sample_rate_cnt_reg10, sample_rate_cnt_reg9, sample_rate_cnt_reg8, sample_rate_cnt_reg7, sample_rate_cnt_reg6, sample_rate_cnt_reg5, sample_rate_cnt_reg4, sample_rate_cnt_reg3, sample_rate_cnt_reg2, sample_rate_cnt_reg1, sample_rate_cnt_reg0 };

//---------------------------------------------------------------------------
//Block 332, LSLICE 2

  assign net_565 = (cmd06_select & ~byte_state_0 & ((o_mcu_d_1 | byte_state_1)));
  assign net_569 = (~cmd3C_select & ~cmd38_select & ((net_268 & ~cmd_6F_1F_select)));

//---------------------------------------------------------------------------
//Block 334, LSLICE 3

  assign cmd34_enable = (cmdxxxx01xx_select & cmd3x_data_write & ((~cmd_b1 & ~cmd_b0)));
  assign cmd33_enable = (~cmd_b2 & ~cmd_b3 & ((cmd3x_data_write & cmdxxxxxx11_select)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd34_enable == 1'b1)   //enable
     begin
      ac_dc_1 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 336, LSLICE 2

  assign cmd0D_enable3 = (state_b0 & cmd0D_select & state_b1 & ((~state_b3 & ~state_b2)));
  assign mcu_d0000010x = (io_mcu_d_2 & ((~io_mcu_d_1 & mcu_d00000xxx)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable3 == 1'b1)   //enable
     begin
      sample_rate_b0 <= io_mcu_d_0;
      sample_rate_b1 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 338, LSLICE 3

  assign mcu_d00000xxx = (~io_mcu_d_3 & ~io_mcu_d_4 & ~io_mcu_d_5 & ((~io_mcu_d_6 & ~io_mcu_d_7)));
  assign cmd0D_enable2 = (state_b1 & ~state_b3 & cmd0D_select & ((~state_b2 & ~state_b0)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable2 == 1'b1)   //enable
     begin
      sample_rate_b11 <= io_mcu_d_3;
      sample_rate_b10 <= io_mcu_d_2;
    end
  end

//---------------------------------------------------------------------------
//Block 340, LSLICE 2

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg0 <= 1'b0;
      sample_rate_cnt_reg1 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg0 <= sample_rate_cnt_out0;
      sample_rate_cnt_reg1 <= sample_rate_cnt_out1;
    end
  end

//---------------------------------------------------------------------------
//Block 341, LSLICE 3

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg3 <= 1'b0;
      sample_rate_cnt_reg4 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg3 <= sample_rate_cnt_out3;
      sample_rate_cnt_reg4 <= sample_rate_cnt_out4;
    end
  end

//---------------------------------------------------------------------------
//Block 344, LSLICE 2

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg10 <= 1'b0;
      sample_rate_cnt_reg7 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg10 <= sample_rate_cnt_out10;
      sample_rate_cnt_reg7 <= sample_rate_cnt_out7;
    end
  end

//---------------------------------------------------------------------------
//Block 345, LSLICE 3

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg11 <= 1'b0;
      sample_rate_cnt_reg12 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg11 <= sample_rate_cnt_out11;
      sample_rate_cnt_reg12 <= sample_rate_cnt_out12;
    end
  end

//---------------------------------------------------------------------------
//Block 348, LSLICE 2

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg15 <= 1'b0;
      sample_rate_cnt_reg16 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg15 <= sample_rate_cnt_out15;
      sample_rate_cnt_reg16 <= sample_rate_cnt_out16;
    end
  end

//---------------------------------------------------------------------------
//Block 349, LSLICE 3

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg19 <= 1'b0;
      sample_rate_cnt_reg20 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg19 <= sample_rate_cnt_out19;
      sample_rate_cnt_reg20 <= sample_rate_cnt_out20;
    end
  end

//---------------------------------------------------------------------------
//Block 352, LSLICE 2

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg23 <= 1'b0;
      sample_rate_cnt_reg24 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg23 <= sample_rate_cnt_out23;
      sample_rate_cnt_reg24 <= sample_rate_cnt_out24;
    end
  end

//---------------------------------------------------------------------------
//Block 353, LSLICE 3

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg27 <= 1'b0;
      sample_rate_cnt_reg28 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg27 <= sample_rate_cnt_out27;
      sample_rate_cnt_reg28 <= sample_rate_cnt_out28;
    end
  end

//---------------------------------------------------------------------------
//Block 356, LSLICE 2

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg31 <= 1'b0;
      sample_rate_cnt_reg29 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg31 <= sample_rate_cnt_out31;
      sample_rate_cnt_reg29 <= sample_rate_cnt_out29;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 340, 341, 344, 345, 348, 349, 352, 353, 356

  assign { sample_rate_cnt_out31, sample_rate_cnt_out30, sample_rate_cnt_out29, sample_rate_cnt_out28, sample_rate_cnt_out27, sample_rate_cnt_out26, sample_rate_cnt_out25, sample_rate_cnt_out24, sample_rate_cnt_out23, sample_rate_cnt_out22, sample_rate_cnt_out21, sample_rate_cnt_out20, sample_rate_cnt_out19, sample_rate_cnt_out18, sample_rate_cnt_out17, sample_rate_cnt_out16, sample_rate_cnt_out15, sample_rate_cnt_out14, sample_rate_cnt_out13, sample_rate_cnt_out12, sample_rate_cnt_out11, sample_rate_cnt_out10, sample_rate_cnt_out9, sample_rate_cnt_out8, sample_rate_cnt_out7, sample_rate_cnt_out6, sample_rate_cnt_out5, sample_rate_cnt_out4, sample_rate_cnt_out3, sample_rate_cnt_out2, sample_rate_cnt_out1, sample_rate_cnt_out0 } = { sample_rate_cnt_reg31, sample_rate_cnt_reg30, sample_rate_cnt_reg29, sample_rate_cnt_reg28, sample_rate_cnt_reg27, sample_rate_cnt_reg26, sample_rate_cnt_reg25, sample_rate_cnt_reg24, sample_rate_cnt_reg23, sample_rate_cnt_reg22, sample_rate_cnt_reg21, sample_rate_cnt_reg20, sample_rate_cnt_reg19, sample_rate_cnt_reg18, sample_rate_cnt_reg17, sample_rate_cnt_reg16, sample_rate_cnt_reg15, sample_rate_cnt_reg14, sample_rate_cnt_reg13, sample_rate_cnt_reg12, sample_rate_cnt_reg11, sample_rate_cnt_reg10, sample_rate_cnt_reg9, sample_rate_cnt_reg8, sample_rate_cnt_reg7, sample_rate_cnt_reg6, sample_rate_cnt_reg5, sample_rate_cnt_reg4, sample_rate_cnt_reg3, sample_rate_cnt_reg2, sample_rate_cnt_reg1, sample_rate_cnt_reg0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 357, LSLICE 3

  assign smp_read_offset_b9 = (~cmd1F_enable0 & ~smp_read_offset_r9 & ((i_mcu_rws & ~io_mcu_d_1) | (i_mcu_rws & io_mcu_d_1))) | (cmd1F_enable0 & ~smp_read_offset_r9 & ((i_mcu_rws & ~io_mcu_d_1))) | (cmd1F_enable0 & smp_read_offset_r9 & ((i_mcu_rws & ~io_mcu_d_1)));
  assign cmd0D_enable0 = ((byte_state_0 & cmd0D_select));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable0 == 1'b1)   //enable
     begin
      sample_rate_b25 <= io_mcu_d_1;
      sample_rate_b24 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 366, MSLICE 0

  assign sig_366_lut_0 = 1'b0;
  assign sig_366_lut_1 = (~db_cnt_b8 & ~db_cnt_b5 & ((~db_cnt_b6 & db_cnt_b7) | (db_cnt_b6 & db_cnt_b7))) | (~db_cnt_b8 & db_cnt_b5 & ((db_cnt_b6 | db_cnt_b7))) | (db_cnt_b8 & ~db_cnt_b5) | (db_cnt_b8 & db_cnt_b5);
  assign pwm_enable_b = (~db_cnt_b9 & sig_366_lut_0) | (db_cnt_b9 & sig_366_lut_1);

//---------------------------------------------------------------------------
//Block 367, LSLICE 2

  always @(posedge clk_50MHz)
  begin
    if(offset1_pwm_rst == 1'b1)   //reset
    begin
      offset1_pwm_r0 <= 1'b0;
      offset1_pwm_r1 <= 1'b0;
    end
    else
    begin
      offset1_pwm_r0 <= offset1_pwm_c0;
      offset1_pwm_r1 <= offset1_pwm_c1;
    end
  end

//---------------------------------------------------------------------------
//Block 368, LSLICE 3

  always @(posedge clk_50MHz)
  begin
    if(offset1_pwm_rst == 1'b1)   //reset
    begin
      offset1_pwm_r3 <= 1'b0;
      offset1_pwm_r4 <= 1'b0;
    end
    else
    begin
      offset1_pwm_r3 <= offset1_pwm_c3;
      offset1_pwm_r4 <= offset1_pwm_c4;
    end
  end

//---------------------------------------------------------------------------
//Block 370, LSLICE 2

  always @(posedge clk_50MHz)
  begin
    if(offset1_pwm_rst == 1'b1)   //reset
    begin
      offset1_pwm_r10 <= 1'b0;
      offset1_pwm_r7 <= 1'b0;
    end
    else
    begin
      offset1_pwm_r10 <= offset1_pwm_c10;
      offset1_pwm_r7 <= offset1_pwm_c7;
    end
  end

//---------------------------------------------------------------------------
//Block 371, LSLICE 3

  always @(posedge clk_50MHz)
  begin
    if(offset1_pwm_rst == 1'b1)   //reset
    begin
      offset1_pwm_r11 <= 1'b0;
      offset1_pwm_r12 <= 1'b0;
    end
    else
    begin
      offset1_pwm_r11 <= offset1_pwm_c11;
      offset1_pwm_r12 <= offset1_pwm_c12;
    end
  end

//---------------------------------------------------------------------------
//Block 372, LSLICE 2

  always @(posedge clk_50MHz)
  begin
    if(offset1_pwm_rst == 1'b1)   //reset
    begin
      offset1_pwm_r15 <= 1'b0;
    end
    else
    begin
      offset1_pwm_r15 <= offset1_pwm_c15;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 367, 368, 370, 371, 372

  assign { offset1_pwm_c15, offset1_pwm_c14, offset1_pwm_c13, offset1_pwm_c12, offset1_pwm_c11, offset1_pwm_c10, offset1_pwm_c9, offset1_pwm_c8, offset1_pwm_c7, offset1_pwm_c6, offset1_pwm_c5, offset1_pwm_c4, offset1_pwm_c3, offset1_pwm_c2, offset1_pwm_c1, offset1_pwm_c0 } = { offset1_pwm_r15, offset1_pwm_r14, offset1_pwm_r13, offset1_pwm_r12, offset1_pwm_r11, offset1_pwm_r10, offset1_pwm_r9, offset1_pwm_r8, offset1_pwm_r7, offset1_pwm_r6, offset1_pwm_r5, offset1_pwm_r4, offset1_pwm_r3, offset1_pwm_r2, offset1_pwm_r1, offset1_pwm_r0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 369, MSLICE 0

  assign net_679 = (~i_adc1A_d_6 & ~cmd24_select & (~(i_adc1B_d_6 & cmd25_select))) | (~i_adc1A_d_6 & cmd24_select & (~(i_adc1B_d_6 & cmd25_select))) | (i_adc1A_d_6 & ~cmd24_select & (~(i_adc1B_d_6 & cmd25_select)));
  assign net_684 = (~i_adc1B_d_3 & ((~net_234 & ~cmd25_select) | (~net_234 & cmd25_select))) | (i_adc1B_d_3 & ((~net_234 & ~cmd25_select)));

//---------------------------------------------------------------------------
//Block 373, LSLICE 3

  assign read_adc1B_l_b0 = (~o_adc1B_d1_0 & ~read_addr_l11 & ((~read_addr_l10 & o_adc1B_d0_0))) | (o_adc1B_d1_0 & ~read_addr_l11 & ((read_addr_l10 | o_adc1B_d0_0)));
  assign read_adc1A_h_b1 = (~o_adc1A_d3_1 & read_addr_l11 & (~(o_adc1A_d2_1 & ~read_addr_l10))) | (o_adc1A_d3_1 & read_addr_l11 & ((~o_adc1A_d2_1 & ~read_addr_l10)));

//---------------------------------------------------------------------------
//Block 374, MSLICE 0

  assign sig_374_lut_0 = 1'b0;
  assign sig_374_lut_1 = (~i_adc1A_d_0 & ~cmd24_select & (~(cmd21_select & ~read_adc1B_b0))) | (~i_adc1A_d_0 & cmd24_select & (~(cmd21_select & ~read_adc1B_b0))) | (i_adc1A_d_0 & ~cmd24_select & (~(cmd21_select & ~read_adc1B_b0)));
  assign net_692 = (~net_990 & sig_374_lut_0) | (net_990 & sig_374_lut_1);

//---------------------------------------------------------------------------
//Block 375, LSLICE 2

  assign read_adc1A_b0 = (~read_adc1A_h_b0 & ~read_addr_l10 & ~read_addr_l11 & ((o_adc1A_d0_0 & ~o_adc1A_d1_0) | (o_adc1A_d0_0 & o_adc1A_d1_0))) | (~read_adc1A_h_b0 & ~read_addr_l10 & read_addr_l11) | (~read_adc1A_h_b0 & read_addr_l10 & ~read_addr_l11 & ((~o_adc1A_d0_0 & o_adc1A_d1_0) | (o_adc1A_d0_0 & o_adc1A_d1_0))) | (~read_adc1A_h_b0 & read_addr_l10 & read_addr_l11);
  assign read_adc1A_h_b0 = (~o_adc1A_d2_0 & ~o_adc1A_d3_0 & ((read_addr_l11 & ~read_addr_l10) | (read_addr_l11 & read_addr_l10))) | (~o_adc1A_d2_0 & o_adc1A_d3_0 & ((read_addr_l11 & ~read_addr_l10))) | (o_adc1A_d2_0 & ~o_adc1A_d3_0 & ((read_addr_l11 & read_addr_l10)));

//---------------------------------------------------------------------------
//Block 376, LSLICE 3

  assign read_adc1A_b4 = (~read_adc1A_h_b4 & ~read_addr_l10 & ~read_addr_l11 & ((o_adc1A_d0_4 & ~o_adc1A_d1_4) | (o_adc1A_d0_4 & o_adc1A_d1_4))) | (~read_adc1A_h_b4 & ~read_addr_l10 & read_addr_l11) | (~read_adc1A_h_b4 & read_addr_l10 & ~read_addr_l11 & ((~o_adc1A_d0_4 & o_adc1A_d1_4) | (o_adc1A_d0_4 & o_adc1A_d1_4))) | (~read_adc1A_h_b4 & read_addr_l10 & read_addr_l11);
  assign read_adc1A_h_b4 = (~o_adc1A_d3_4 & ~o_adc1A_d2_4 & ((read_addr_l11 & ~read_addr_l10) | (read_addr_l11 & read_addr_l10))) | (~o_adc1A_d3_4 & o_adc1A_d2_4 & ((read_addr_l11 & read_addr_l10))) | (o_adc1A_d3_4 & ~o_adc1A_d2_4 & ((read_addr_l11 & ~read_addr_l10)));

//---------------------------------------------------------------------------
//Block 377, MSLICE 1

  assign sig_377_lut_0 = 1'b0;
  assign sig_377_lut_1 = (sample_addr_10 & ~sample_addr_8 & ((sample_addr_7 | smp_addr_match_b))) | (sample_addr_10 & sample_addr_8);
  assign smp_addr_match_c = (~sample_addr_9 & sig_377_lut_0) | (sample_addr_9 & sig_377_lut_1);

//---------------------------------------------------------------------------
//Block 378, MSLICE 0

  assign sig_378_lut_0 = (~smp_addr_match_c & ((sample_addr_11 | sampling_half_way))) | (smp_addr_match_c);
  assign smp_addr_match_a = (~sample_addr_5 & ~sample_addr_4 & ((~sample_addr_3 & ~sample_addr_2)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      sampling_half_way <= 1'b0;
    end
    else
    begin
      sampling_half_way <= sig_378_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 379, LSLICE 2

  assign net_699 = (cmd_b1 & cmd001000xx_select & ((read_adc2A_b5 & ~cmd_b0)));
  assign net_698 = (net_977 & ~net_699 & (~(i_adc1A_d_5 & cmd24_select)));

//---------------------------------------------------------------------------
//Block 380, MSLICE 0

  assign sig_380_lut_0 = 1'b0;
  assign sig_380_lut_1 = (net_1109 & cmd21_22_adc1B_2A_b2 & (~(i_i2c_cmd69_b2 & cmd69_select)));
  assign read_b2_a = (~net_283 & sig_380_lut_0) | (net_283 & sig_380_lut_1);

//---------------------------------------------------------------------------
//Block 381, LSLICE 2

  assign read_b4_a = (~net_340 & ~cmd25_select & ~i_adc1B_d_4 & (~(i_i2c_cmd6E_b4 & cmd6E_select))) | (~net_340 & ~cmd25_select & i_adc1B_d_4 & (~(i_i2c_cmd6E_b4 & cmd6E_select))) | (~net_340 & cmd25_select & ~i_adc1B_d_4 & (~(i_i2c_cmd6E_b4 & cmd6E_select)));
  assign read_b4_b = (read_b4_a & ~cmd69_select & ~i_i2c_cmd69_b4 & (~(o_adc2B_d_4 & cmd23_select))) | (read_b4_a & ~cmd69_select & i_i2c_cmd69_b4 & (~(o_adc2B_d_4 & cmd23_select))) | (read_b4_a & cmd69_select & ~i_i2c_cmd69_b4 & (~(o_adc2B_d_4 & cmd23_select)));

//---------------------------------------------------------------------------
//Block 382, LSLICE 3

  assign sig_382_lut_0 = (~i2c_send_enable & cmd6x_select & cmdxxxx01xx_select & ((~cmd_b1 & cmd_b0))) | (i2c_send_enable & ~cmd6x_select & ~cmdxxxx01xx_select) | (i2c_send_enable & ~cmd6x_select & cmdxxxx01xx_select) | (i2c_send_enable & cmd6x_select & ~cmdxxxx01xx_select) | (i2c_send_enable & cmd6x_select & cmdxxxx01xx_select & ((cmd_b1 | cmd_b0)));
  assign sig_382_lut_1 = (~cmd_b0 & ~cmd6x_select & ~cmd_b1 & ((i2c_disable & ~cmdxxxx01xx_select) | (i2c_disable & cmdxxxx01xx_select))) | (~cmd_b0 & ~cmd6x_select & cmd_b1 & ((i2c_disable & ~cmdxxxx01xx_select) | (i2c_disable & cmdxxxx01xx_select))) | (~cmd_b0 & cmd6x_select & ~cmd_b1 & ((i2c_disable | cmdxxxx01xx_select))) | (~cmd_b0 & cmd6x_select & cmd_b1 & ((i2c_disable & ~cmdxxxx01xx_select))) | (cmd_b0 & ~cmd6x_select & ~cmd_b1 & ((i2c_disable & ~cmdxxxx01xx_select) | (i2c_disable & cmdxxxx01xx_select))) | (cmd_b0 & ~cmd6x_select & cmd_b1 & ((i2c_disable & ~cmdxxxx01xx_select) | (i2c_disable & cmdxxxx01xx_select))) | (cmd_b0 & cmd6x_select & ~cmd_b1 & ((i2c_disable | cmdxxxx01xx_select))) | (cmd_b0 & cmd6x_select & cmd_b1 & ((i2c_disable & ~cmdxxxx01xx_select) | (i2c_disable & cmdxxxx01xx_select)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd_write_enable == 1'b1)   //enable
     begin
      i2c_send_enable <= sig_382_lut_0;
      i2c_disable <= sig_382_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 383, MSLICE 1

  assign cmd_write_enable = ((i_mcu_dcs & i_mcu_rws));
  assign i2c_rcv_rst = ~i2c_disable;

  always @(posedge i_mcu_clk)
  begin
    if(cmd_write_enable == 1'b1)   //enable
     begin
      cmd_b0 <= io_mcu_d_0;
      cmd_b1 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 384, MSLICE 0

  assign sig_384_lut_0 = 1'b0;
  assign sig_384_lut_1 = (net_778 & net_535 & (~(i_i2c_cmd6B_b4 & cmd6B_select)));
  assign net_712 = (~read_b4_b & sig_384_lut_0) | (read_b4_b & sig_384_lut_1);

//---------------------------------------------------------------------------
//Block 385, LSLICE 2

  assign read_b5_a = (net_798 & net_698 & ~net_834 & (~(i_i2c_cmd6B_b5 & cmd6B_select)));
  assign read_b5_b = (~cmd25_select & read_b5_a & ((~i_adc1B_d_5 & cmd21_23_adc1B_2B_b5) | (i_adc1B_d_5 & cmd21_23_adc1B_2B_b5))) | (cmd25_select & read_b5_a & ((~i_adc1B_d_5 & cmd21_23_adc1B_2B_b5)));

//---------------------------------------------------------------------------
//Block 386, MSLICE 1

  assign sig_386_lut_0 = (~net_956 & ((ch1_offset_b15 & ~offset1_pwm_r15))) | (net_956 & (~(~ch1_offset_b15 & offset1_pwm_r15)));
  assign net_710 = ((net_470 & not_cmd_05_0A));

  always @(posedge clk_50MHz)
  begin
    if(offset1_pwm_rst == 1'b0)   //enable
     begin
      offset_1 <= sig_386_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 387, LSLICE 3

  assign net_714 = (net_964 & net_814 & ~net_715 & (~(i_adc1A_d_2 & cmd24_select)));
  assign net_715 = (cmd06_select & ~byte_state_0 & ((o_mcu_d_2 & ~byte_state_1))) | (cmd06_select & byte_state_0);

//---------------------------------------------------------------------------
//Block 388, MSLICE 0

  assign net_720 = (o_mcu_d_5 & ((cmd0001x000_select | cmd67_select)));
  assign net_718 = ((not_cmd_05_0A & ~cmd0001x000_select));

//---------------------------------------------------------------------------
//Block 389, LSLICE 3

  assign cmd32_enable0 = (cmd32_select & ~i_mcu_dcs & ((byte_state_0 & i_mcu_rws)));
  assign byte_state_0 = (~state_b1 & ~state_b2 & ((~state_b0 & ~state_b3)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd32_enable0 == 1'b1)   //enable
     begin
      ch1_offset_b10 <= io_mcu_d_2;
      ch1_offset_b15 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 390, MSLICE 1

  assign sig_390_lut_0 = 1'b0;
  assign sig_390_lut_1 = (net_792 & ~net_375 & (~(i_i2c_cmd6A_b6 & cmd6A_select)));
  assign net_721 = (~net_822 & sig_390_lut_0) | (net_822 & sig_390_lut_1);

//---------------------------------------------------------------------------
//Block 391, MSLICE 0

  assign sig_391_lut_0 = (~smp_rst_state & ~smp_rst_cnt_b3 & ((smp_rst_cnt_b2 & smp_rst_cnt_b1))) | (~smp_rst_state & smp_rst_cnt_b3) | (smp_rst_state & ~smp_rst_cnt_b3) | (smp_rst_state & smp_rst_cnt_b3);
  assign smp_addr_match_b = (sample_addr_6 & ~smp_addr_match_a) | (sample_addr_6 & smp_addr_match_a & ((sample_addr_1 | sample_addr_0)));

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b0)   //reset
    begin
      smp_rst_state <= 1'b0;
    end
    else
    begin
      smp_rst_state <= sig_391_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 392, LSLICE 2

  assign net_723 = (net_997 & ~net_720 & ~net_374 & (~(i_i2c_cmd6D_b5 & cmd6D_select)));
  assign i2c_cmd6D_e5 = (i2c_state_000000001100xxxx & ((~i2c_send_enable & i2c_state_xxxxxxxxxxxx0010)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6D_b5 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6D_e5 == 1'b1)   //enable
       begin
        i_i2c_cmd6D_b5 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 393, MSLICE 1

  assign sig_393_lut_0 = (~cmd06_select & ~byte_state_0) | (~cmd06_select & byte_state_0) | (cmd06_select & ~byte_state_0 & ((~o_mcu_d_4 & ~byte_state_1)));
  assign sig_393_lut_1 = 1'b0;
  assign net_728 = (~net_370 & sig_393_lut_0) | (net_370 & sig_393_lut_1);

//---------------------------------------------------------------------------
//Block 394, LSLICE 2

  assign cmd0E_enable3 = (state_b0 & cmd0E_select & state_b1 & ((~state_b3 & ~state_b2)));
  assign cmd0E_select = (cmd_b3 & cmd_b2 & cmd_b1 & ((~cmd_b0 & cmd0x_data_write)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable3 == 1'b1)   //enable
     begin
      time_base_b0 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 395, LSLICE 3

  assign sig_395_lut_0 = ~sample_write_clock;
  assign sig_395_lut_1 = ~adc1_encB;

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //enable
     begin
      sample_write_clock <= sig_395_lut_0;
      adc1_encB <= sig_395_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 396, MSLICE 1

  assign sig_396_lut_0 = (~cmd001000xx_select & ~i_mcu_rws & ((smp_read_offset_r4 & ~smp_read_offset_c4) | (smp_read_offset_r4 & smp_read_offset_c4))) | (~cmd001000xx_select & i_mcu_rws) | (cmd001000xx_select & ~i_mcu_rws & ((~smp_read_offset_r4 & smp_read_offset_c4) | (smp_read_offset_r4 & smp_read_offset_c4))) | (cmd001000xx_select & i_mcu_rws);
  assign sig_396_lut_1 = 1'b0;
  assign sig_396_ff0_d = (~smp_read_offset_b4 & sig_396_lut_0) | (smp_read_offset_b4 & sig_396_lut_1);

  always @(posedge i_mcu_clk)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      smp_read_offset_r4 <= sig_396_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 397, MSLICE 0

  assign byte_state_1 = (state_b0 & ~state_b3 & ((~state_b2 & ~state_b1)));
  assign cmd06_enable0 = (~byte_state_0 & ((cmd06_select & ~byte_state_1)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd3C_enable1 == 1'b1)   //enable
     begin
      cmd3C_b12 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 398, MSLICE 1

  assign sig_398_lut_0 = (cmd6E_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_5) | (net_431 & io_mcu_d_5)));
  assign sig_398_lut_1 = (~io_mcu_d_5 & ~i_mcu_dcs & (~(~net_431 & cmd6E_write_enable))) | (~io_mcu_d_5 & i_mcu_dcs & ((net_431 & ~cmd6E_write_enable) | (net_431 & cmd6E_write_enable))) | (io_mcu_d_5 & ~i_mcu_dcs) | (io_mcu_d_5 & i_mcu_dcs & ((net_431 & ~cmd6E_write_enable) | (net_431 & cmd6E_write_enable)));
  assign sig_398_ff0_d = (~o_i2c_cmd6E_b5 & sig_398_lut_0) | (o_i2c_cmd6E_b5 & sig_398_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6E_b5 <= sig_398_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 399, LSLICE 2

  assign cmd0E_enable2 = (state_b1 & cmd0E_select & ~state_b3 & ((~state_b2 & ~state_b0)));
  assign smp_read_offset_b8 = (~cmd1F_enable0 & ~io_mcu_d_0 & ((~smp_read_offset_r8 & i_mcu_rws))) | (~cmd1F_enable0 & io_mcu_d_0 & ((~smp_read_offset_r8 & i_mcu_rws))) | (cmd1F_enable0 & ~io_mcu_d_0 & ((~smp_read_offset_r8 & i_mcu_rws) | (smp_read_offset_r8 & i_mcu_rws)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable2 == 1'b1)   //enable
     begin
      time_base_b10 <= io_mcu_d_2;
      time_base_b8 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 400, MSLICE 1

  assign smp_read_offset_b6 = (i_mcu_rws & ~cmd1F_enable1 & ((~smp_read_offset_r6 & ~io_mcu_d_6) | (~smp_read_offset_r6 & io_mcu_d_6))) | (i_mcu_rws & cmd1F_enable1 & ((~smp_read_offset_r6 & ~io_mcu_d_6) | (smp_read_offset_r6 & ~io_mcu_d_6)));
  assign cmd3x_data_write = (cmd3x_select & ((i_mcu_rws & ~i_mcu_dcs)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable2 == 1'b1)   //enable
     begin
      sample_rate_b14 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 401, MSLICE 0

  assign smp_read_offset_b1 = (i_mcu_rws & ~cmd1F_enable1 & ((~smp_read_offset_r1 & ~io_mcu_d_1) | (~smp_read_offset_r1 & io_mcu_d_1))) | (i_mcu_rws & cmd1F_enable1 & ((~smp_read_offset_r1 & ~io_mcu_d_1) | (smp_read_offset_r1 & ~io_mcu_d_1)));
  assign cmd0D_enable1 = ((byte_state_1 & cmd0D_select));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0D_enable1 == 1'b1)   //enable
     begin
      sample_rate_b17 <= io_mcu_d_1;
      sample_rate_b16 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//Block 402, MSLICE 0

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //reset
    begin
      sample_rate_cnt_reg30 <= 1'b0;
    end
    else
    begin
      sample_rate_cnt_reg30 <= sample_rate_cnt_out30;
    end
  end

//---------------------------------------------------------------------------
//Block 407, LSLICE 2

  assign calib_1KHz_f = (calib_1KHz_g & ~calib_1KHz_r31 & ((~calib_1KHz_r30 & ~calib_1KHz_r29)));
  assign pwm_enable_a = (~pwm_enable_b & ~db_cnt_b12 & (~(db_cnt_b11 & db_cnt_b10))) | (pwm_enable_b & ~db_cnt_b12 & ((~db_cnt_b11 & ~db_cnt_b10) | (~db_cnt_b11 & db_cnt_b10)));

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r29 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r29 <= calib_1KHz_c29;
    end
  end

//---------------------------------------------------------------------------
//Block 408, MSLICE 1

  assign sig_408_lut_0 = (~read_addr_l10 & ~read_addr_l11 & ((o_adc1A_d0_5 & ~o_adc1A_d1_5) | (o_adc1A_d0_5 & o_adc1A_d1_5))) | (~read_addr_l10 & read_addr_l11) | (read_addr_l10 & ~read_addr_l11 & ((~o_adc1A_d0_5 & o_adc1A_d1_5) | (o_adc1A_d0_5 & o_adc1A_d1_5))) | (read_addr_l10 & read_addr_l11);
  assign sig_408_lut_1 = 1'b0;
  assign read_adc1A_b5 = (~read_adc1A_h_b5 & sig_408_lut_0) | (read_adc1A_h_b5 & sig_408_lut_1);

//---------------------------------------------------------------------------
//Block 409, MSLICE 0

  assign read_adc1B_l_b6 = (~read_addr_l10 & ~read_addr_l11 & ((o_adc1B_d0_6 & ~o_adc1B_d1_6) | (o_adc1B_d0_6 & o_adc1B_d1_6))) | (read_addr_l10 & ~read_addr_l11 & ((~o_adc1B_d0_6 & o_adc1B_d1_6) | (o_adc1B_d0_6 & o_adc1B_d1_6)));
  assign read_adc1A_h_b5 = (~read_addr_l10 & read_addr_l11 & ((~o_adc1A_d2_5 & ~o_adc1A_d3_5) | (~o_adc1A_d2_5 & o_adc1A_d3_5))) | (read_addr_l10 & read_addr_l11 & ((~o_adc1A_d2_5 & ~o_adc1A_d3_5) | (o_adc1A_d2_5 & ~o_adc1A_d3_5)));

//---------------------------------------------------------------------------
//Block 410, LSLICE 2

  assign read_adc1A_b2 = (~read_adc1A_h_b2 & ~read_addr_l10 & ~read_addr_l11 & ((o_adc1A_d0_2 & ~o_adc1A_d1_2) | (o_adc1A_d0_2 & o_adc1A_d1_2))) | (~read_adc1A_h_b2 & ~read_addr_l10 & read_addr_l11) | (~read_adc1A_h_b2 & read_addr_l10 & ~read_addr_l11 & ((~o_adc1A_d0_2 & o_adc1A_d1_2) | (o_adc1A_d0_2 & o_adc1A_d1_2))) | (~read_adc1A_h_b2 & read_addr_l10 & read_addr_l11);
  assign read_adc1A_h_b2 = (~o_adc1A_d3_2 & ~o_adc1A_d2_2 & ((read_addr_l11 & ~read_addr_l10) | (read_addr_l11 & read_addr_l10))) | (~o_adc1A_d3_2 & o_adc1A_d2_2 & ((read_addr_l11 & read_addr_l10))) | (o_adc1A_d3_2 & ~o_adc1A_d2_2 & ((read_addr_l11 & ~read_addr_l10)));

//---------------------------------------------------------------------------
//Block 411, LSLICE 3

  assign offset1_pwm_rst = (~net_766 & ~net_1104 & ~offset1_pwm_r9) | (~net_766 & ~net_1104 & offset1_pwm_r9) | (~net_766 & net_1104 & ~offset1_pwm_r9) | (~net_766 & net_1104 & offset1_pwm_r9) | (net_766 & net_1104 & offset1_pwm_r9 & ((offset1_pwm_r8 & offset1_pwm_r7)));
  assign net_766 = (~offset1_pwm_r15 & ~offset1_pwm_r14 & ~offset1_pwm_r13 & ((~offset1_pwm_r12 & ~offset1_pwm_r11)));

  always @(posedge clk_50MHz)
  begin
    if(offset1_pwm_rst == 1'b1)   //reset
    begin
      offset1_pwm_r13 <= 1'b0;
      offset1_pwm_r2 <= 1'b0;
    end
    else
    begin
      offset1_pwm_r13 <= offset1_pwm_c13;
      offset1_pwm_r2 <= offset1_pwm_c2;
    end
  end

//---------------------------------------------------------------------------
//Block 412, MSLICE 1

  assign net_757 = (~net_755 & ~net_773 & (~(~offset1_pwm_r8 & ch1_offset_b8)));
  assign net_755 = ((ch1_offset_b9 & ~offset1_pwm_r9));

  always @(posedge i_mcu_clk)
  begin
    if(cmd32_enable0 == 1'b1)   //enable
     begin
      ch1_offset_b8 <= io_mcu_d_0;
      ch1_offset_b9 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 413, MSLICE 0

  assign sig_413_lut_0 = (~read_addr_l10 & ~read_addr_l11) | (~read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_0 & ~o_adc1B_d3_0) | (~o_adc1B_d2_0 & o_adc1B_d3_0))) | (read_addr_l10 & ~read_addr_l11) | (read_addr_l10 & read_addr_l11 & ((~o_adc1B_d2_0 & ~o_adc1B_d3_0) | (o_adc1B_d2_0 & ~o_adc1B_d3_0)));
  assign sig_413_lut_1 = 1'b0;
  assign read_adc1B_b0 = (~read_adc1B_l_b0 & sig_413_lut_0) | (read_adc1B_l_b0 & sig_413_lut_1);

//---------------------------------------------------------------------------
//Block 414, LSLICE 2

  assign net_773 = (~offset1_pwm_r7 & ~ch1_offset_b7 & ~net_770 & (~(offset1_pwm_r8 & ~ch1_offset_b8))) | (~offset1_pwm_r7 & ch1_offset_b7 & ~net_770 & (~(offset1_pwm_r8 & ~ch1_offset_b8))) | (~offset1_pwm_r7 & ch1_offset_b7 & net_770 & (~(offset1_pwm_r8 & ~ch1_offset_b8))) | (offset1_pwm_r7 & ch1_offset_b7 & ~net_770 & (~(offset1_pwm_r8 & ~ch1_offset_b8)));
  assign net_771 = (~offset1_pwm_r5 & ~ch1_offset_b7 & ((~ch1_offset_b5 & ~offset1_pwm_r7) | (~ch1_offset_b5 & offset1_pwm_r7))) | (~offset1_pwm_r5 & ch1_offset_b7 & ((~ch1_offset_b5 & offset1_pwm_r7))) | (offset1_pwm_r5 & ~ch1_offset_b7) | (offset1_pwm_r5 & ch1_offset_b7 & ((~ch1_offset_b5 & offset1_pwm_r7) | (ch1_offset_b5 & offset1_pwm_r7)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd32_enable1 == 1'b1)   //enable
     begin
      ch1_offset_b7 <= io_mcu_d_7;
      ch1_offset_b5 <= io_mcu_d_5;
    end
  end

//---------------------------------------------------------------------------
//Block 415, LSLICE 3

  assign cmd32_enable1 = (cmd32_select & i_mcu_rws & ((byte_state_1 & ~i_mcu_dcs)));
  assign net_770 = ((offset1_pwm_r6 & ~ch1_offset_b6));

  always @(posedge i_mcu_clk)
  begin
    if(cmd32_enable1 == 1'b1)   //enable
     begin
      ch1_offset_b0 <= io_mcu_d_0;
      ch1_offset_b6 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 416, MSLICE 1

  assign net_776 = (~i_adc1A_d_1 & ~cmd24_select & (~(i_adc2A_d_1 & cmd26_select))) | (~i_adc1A_d_1 & cmd24_select & (~(i_adc2A_d_1 & cmd26_select))) | (i_adc1A_d_1 & ~cmd24_select & (~(i_adc2A_d_1 & cmd26_select)));
  assign net_777 = (~i_adc1A_d_7 & ~cmd24_select & (~(i_adc1B_d_7 & cmd25_select))) | (~i_adc1A_d_7 & cmd24_select & (~(i_adc1B_d_7 & cmd25_select))) | (i_adc1A_d_7 & ~cmd24_select & (~(i_adc1B_d_7 & cmd25_select)));

//---------------------------------------------------------------------------
//Block 417, MSLICE 0

  assign i2c_cmd6A_e3 = ((i2c_state_xxxxxxxx0110xxxx & net_1605));
  assign net_782 = (~cmd26_select & ~i_adc2A_d_3 & (~(i_i2c_cmd6A_b3 & cmd6A_select))) | (~cmd26_select & i_adc2A_d_3 & (~(i_i2c_cmd6A_b3 & cmd6A_select))) | (cmd26_select & ~i_adc2A_d_3 & (~(i_i2c_cmd6A_b3 & cmd6A_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6A_b3 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6A_e3 == 1'b1)   //enable
       begin
        i_i2c_cmd6A_b3 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 418, LSLICE 2

  assign net_778 = (net_785 & net_728 & net_810 & (~(i_i2c_cmd68_b4 & cmd68_select)));
  assign i2c_cmd68_e4 = (i2c_state_xxxxxxxx0010xxxx & ((~i2c_send_enable & i2c_state_00000000xxxx1110)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd68_b4 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd68_e4 == 1'b1)   //enable
       begin
        i_i2c_cmd68_b4 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 419, LSLICE 3

  assign i2c_cmd69_e0 = ((~i2c_send_enable & i2c_state_0000000001010100));
  assign net_784 = (~cmd20_select & ~cmd69_select) | (~cmd20_select & cmd69_select & ((~read_adc1A_b0 & ~i_i2c_cmd69_b0) | (read_adc1A_b0 & ~i_i2c_cmd69_b0))) | (cmd20_select & ~cmd69_select & ((~read_adc1A_b0 & ~i_i2c_cmd69_b0) | (~read_adc1A_b0 & i_i2c_cmd69_b0))) | (cmd20_select & cmd69_select & ((~read_adc1A_b0 & ~i_i2c_cmd69_b0)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd69_b0 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd69_e0 == 1'b1)   //enable
       begin
        i_i2c_cmd69_b0 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 420, MSLICE 1

  assign sig_420_lut_0 = 1'b0;
  assign sig_420_lut_1 = (~i_adc1A_d_4 & ~cmd24_select & (~(i_adc2A_d_4 & cmd26_select))) | (~i_adc1A_d_4 & cmd24_select & (~(i_adc2A_d_4 & cmd26_select))) | (i_adc1A_d_4 & ~cmd24_select & (~(i_adc2A_d_4 & cmd26_select)));
  assign net_785 = (~net_808 & sig_420_lut_0) | (net_808 & sig_420_lut_1);

//---------------------------------------------------------------------------
//Block 421, MSLICE 0

  assign sig_421_lut_0 = 1'b0;
  assign sig_421_lut_1 = (~i_adc2A_d_0 & ~cmd26_select & (~(i_adc2B_d_0 & cmd27_select))) | (~i_adc2A_d_0 & cmd26_select & (~(i_adc2B_d_0 & cmd27_select))) | (i_adc2A_d_0 & ~cmd26_select & (~(i_adc2B_d_0 & cmd27_select)));
  assign net_788 = (~net_272 & sig_421_lut_0) | (net_272 & sig_421_lut_1);

//---------------------------------------------------------------------------
//Block 422, LSLICE 2

  assign i2c_cmd6E_e7 = ((net_1605 & i2c_state_xxxxxxxx1101xxxx));
  assign net_791 = (~i_adc2A_d_7 & ~cmd26_select & (~(cmd6E_select & i_i2c_cmd6E_b7))) | (~i_adc2A_d_7 & cmd26_select & (~(cmd6E_select & i_i2c_cmd6E_b7))) | (i_adc2A_d_7 & ~cmd26_select & (~(cmd6E_select & i_i2c_cmd6E_b7)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6E_b7 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6E_e7 == 1'b1)   //enable
       begin
        i_i2c_cmd6E_b7 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 423, LSLICE 3

  assign net_793 = (net_961 & ~cmd68_select & ~i_i2c_cmd68_b0 & (~(i_i2c_cmd6C_b0 & cmd6C_select))) | (net_961 & ~cmd68_select & i_i2c_cmd68_b0 & (~(i_i2c_cmd6C_b0 & cmd6C_select))) | (net_961 & cmd68_select & ~i_i2c_cmd68_b0 & (~(i_i2c_cmd6C_b0 & cmd6C_select)));
  assign net_789 = (net_788 & net_793 & net_1297 & (~(smp_rst_state & cmd05_select)));

//---------------------------------------------------------------------------
//Block 424, MSLICE 1

  assign sig_424_lut_0 = 1'b0;
  assign sig_424_lut_1 = (~cmd68_select & ~i_i2c_cmd68_b6 & (~(i_i2c_cmd6D_b6 & cmd6D_select))) | (~cmd68_select & i_i2c_cmd68_b6 & (~(i_i2c_cmd6D_b6 & cmd6D_select))) | (cmd68_select & ~i_i2c_cmd68_b6 & (~(i_i2c_cmd6D_b6 & cmd6D_select)));
  assign net_792 = (~net_960 & sig_424_lut_0) | (net_960 & sig_424_lut_1);

//---------------------------------------------------------------------------
//Block 425, MSLICE 0

  assign sig_425_lut_0 = 1'b0;
  assign sig_425_lut_1 = (~cmd68_select & ~i_adc2B_d_5) | (~cmd68_select & i_adc2B_d_5 & ((~i_i2c_cmd68_b5 & ~cmd27_select) | (i_i2c_cmd68_b5 & ~cmd27_select))) | (cmd68_select & ~i_adc2B_d_5 & ((~i_i2c_cmd68_b5 & ~cmd27_select) | (~i_i2c_cmd68_b5 & cmd27_select))) | (cmd68_select & i_adc2B_d_5 & ((~i_i2c_cmd68_b5 & ~cmd27_select)));
  assign net_798 = (~net_1132 & sig_425_lut_0) | (net_1132 & sig_425_lut_1);

//---------------------------------------------------------------------------
//Block 426, LSLICE 2

  assign net_795 = (net_791 & ~cmd68_select & ~i_i2c_cmd68_b7 & (~(i_i2c_cmd6D_b7 & cmd6D_select))) | (net_791 & ~cmd68_select & i_i2c_cmd68_b7 & (~(i_i2c_cmd6D_b7 & cmd6D_select))) | (net_791 & cmd68_select & ~i_i2c_cmd68_b7 & (~(i_i2c_cmd6D_b7 & cmd6D_select)));
  assign net_800 = (net_1586 & net_795 & ~net_389 & (~(i_i2c_cmd6A_b7 & cmd6A_select)));

//---------------------------------------------------------------------------
//Block 427, LSLICE 3

  assign i2c_cmd6B_e6 = (i2c_state_000000001000xxxx & ((i2c_state_xxxxxxxxxxxx0100 & ~i2c_send_enable)));
  assign net_797 = (~i_i2c_cmd69_b6 & ~cmd69_select & (~(i_i2c_cmd6B_b6 & cmd6B_select))) | (~i_i2c_cmd69_b6 & cmd69_select & (~(i_i2c_cmd6B_b6 & cmd6B_select))) | (i_i2c_cmd69_b6 & ~cmd69_select & (~(i_i2c_cmd6B_b6 & cmd6B_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6B_b6 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6B_e6 == 1'b1)   //enable
       begin
        i_i2c_cmd6B_b6 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 428, MSLICE 1

  assign sig_428_lut_0 = 1'b0;
  assign sig_428_lut_1 = (~cmd68_select & ~i_i2c_cmd68_b3 & (~(i_i2c_cmd6C_b3 & cmd6C_select))) | (~cmd68_select & i_i2c_cmd68_b3 & (~(i_i2c_cmd6C_b3 & cmd6C_select))) | (cmd68_select & ~i_i2c_cmd68_b3 & (~(i_i2c_cmd6C_b3 & cmd6C_select)));
  assign net_796 = (~net_980 & sig_428_lut_0) | (net_980 & sig_428_lut_1);

//---------------------------------------------------------------------------
//Block 429, LSLICE 2

  assign i2c_cmd6B_e7 = (i2c_state_000000001000xxxx & ((~i2c_send_enable & i2c_state_xxxxxxxxxxxx0010)));
  assign net_805 = (~i_i2c_cmd69_b7 & ~i_i2c_cmd6B_b7) | (~i_i2c_cmd69_b7 & i_i2c_cmd6B_b7 & ((~cmd69_select & ~cmd6B_select) | (cmd69_select & ~cmd6B_select))) | (i_i2c_cmd69_b7 & ~i_i2c_cmd6B_b7 & ((~cmd69_select & ~cmd6B_select) | (~cmd69_select & cmd6B_select))) | (i_i2c_cmd69_b7 & i_i2c_cmd6B_b7 & ((~cmd69_select & ~cmd6B_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6B_b7 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6B_e7 == 1'b1)   //enable
       begin
        i_i2c_cmd6B_b7 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 430, LSLICE 3

  assign i2c_cmd6D_e4 = (i2c_state_000000001100xxxx & ((~i2c_send_enable & i2c_state_xxxxxxxxxxxx0100)));
  assign net_810 = (~i_adc2B_d_4 & ~cmd27_select & (~(i_i2c_cmd6D_b4 & cmd6D_select))) | (~i_adc2B_d_4 & cmd27_select & (~(i_i2c_cmd6D_b4 & cmd6D_select))) | (i_adc2B_d_4 & ~cmd27_select & (~(i_i2c_cmd6D_b4 & cmd6D_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6D_b4 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6D_e4 == 1'b1)   //enable
       begin
        i_i2c_cmd6D_b4 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 431, MSLICE 1

  assign i2c_cmd6C_e4 = (~i2c_send_enable & ((i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx0110)));
  assign net_808 = (~cmd6A_select & ~i_i2c_cmd6A_b4 & (~(i_i2c_cmd6C_b4 & cmd6C_select))) | (~cmd6A_select & i_i2c_cmd6A_b4 & (~(i_i2c_cmd6C_b4 & cmd6C_select))) | (cmd6A_select & ~i_i2c_cmd6A_b4 & (~(i_i2c_cmd6C_b4 & cmd6C_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6C_b4 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6C_e4 == 1'b1)   //enable
       begin
        i_i2c_cmd6C_b4 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 432, MSLICE 0

  assign sig_432_lut_0 = 1'b0;
  assign sig_432_lut_1 = (~cmd6C_select & ~i_i2c_cmd6C_b2 & (~(i_i2c_cmd6E_b2 & cmd6E_select))) | (~cmd6C_select & i_i2c_cmd6C_b2 & (~(i_i2c_cmd6E_b2 & cmd6E_select))) | (cmd6C_select & ~i_i2c_cmd6C_b2 & (~(i_i2c_cmd6E_b2 & cmd6E_select)));
  assign net_814 = (~net_817 & sig_432_lut_0) | (net_817 & sig_432_lut_1);

//---------------------------------------------------------------------------
//Block 433, LSLICE 2

  assign i2c_cmd6D_e6 = ((~i2c_send_enable & i2c_state_0000000011000000));
  assign i2c_state_0000000011000000 = ((i2c_state_000000001100xxxx & i2c_state_xxxxxxxxxxxx0000));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6D_b6 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6D_e6 == 1'b1)   //enable
       begin
        i_i2c_cmd6D_b6 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 434, LSLICE 3

  assign i2c_cmd6D_e2 = (i2c_state_xxxxxxxxxxxx1000 & ((~i2c_send_enable & i2c_state_000000001100xxxx)));
  assign net_817 = (~cmd27_select & ~i_adc2B_d_2 & (~(i_i2c_cmd6D_b2 & cmd6D_select))) | (~cmd27_select & i_adc2B_d_2 & (~(i_i2c_cmd6D_b2 & cmd6D_select))) | (cmd27_select & ~i_adc2B_d_2 & (~(i_i2c_cmd6D_b2 & cmd6D_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6D_b2 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd6D_e2 == 1'b1)   //enable
       begin
        i_i2c_cmd6D_b2 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 435, MSLICE 0

  assign cmd6D_write_enable = ((i_mcu_rws & cmd6D_select));
  assign cmd6B_write_enable = ((i_mcu_rws & cmd6B_select));

//---------------------------------------------------------------------------
//Block 436, LSLICE 2

  assign i2c_cmd6C_e6 = (~i2c_send_enable & ((i2c_state_xxxxxxxxxxxx0010 & i2c_state_000000001010xxxx)));
  assign net_822 = (~i_adc2B_d_6 & ~cmd27_select & (~(i_i2c_cmd6C_b6 & cmd6C_select))) | (~i_adc2B_d_6 & cmd27_select & (~(i_i2c_cmd6C_b6 & cmd6C_select))) | (i_adc2B_d_6 & ~cmd27_select & (~(i_i2c_cmd6C_b6 & cmd6C_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6C_b6 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6C_e6 == 1'b1)   //enable
       begin
        i_i2c_cmd6C_b6 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 437, LSLICE 3

  assign sig_437_lut_0 = (~o_i2c_cmd6B_b2 & cmd6B_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_2) | (net_431 & io_mcu_d_2))) | (o_i2c_cmd6B_b2 & ~cmd6B_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6B_b2 & ~cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_2) | (net_431 & io_mcu_d_2))) | (o_i2c_cmd6B_b2 & cmd6B_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_2))) | (o_i2c_cmd6B_b2 & cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_2) | (net_431 & io_mcu_d_2)));
  assign net_823 = (i2c_state_xxxxxxxxxxxx1011 & ((i2c_state_000000001000xxxx & o_i2c_cmd6B_b2)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6B_b2 <= sig_437_lut_0;
  end

//---------------------------------------------------------------------------
//Block 438, MSLICE 1

  assign cmd6C_write_enable = ((cmd6C_select & i_mcu_rws));
  assign cmd6E_write_enable = ((cmd6E_select & i_mcu_rws));

//---------------------------------------------------------------------------
//Block 439, MSLICE 0

  assign sig_439_lut_0 = (cmd6C_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_5) | (net_431 & io_mcu_d_5)));
  assign sig_439_lut_1 = (~cmd6C_write_enable & ~io_mcu_d_5 & (~(~net_431 & i_mcu_dcs))) | (~cmd6C_write_enable & io_mcu_d_5 & (~(~net_431 & i_mcu_dcs))) | (cmd6C_write_enable & ~io_mcu_d_5 & ((net_431 & ~i_mcu_dcs) | (net_431 & i_mcu_dcs))) | (cmd6C_write_enable & io_mcu_d_5 & (~(~net_431 & i_mcu_dcs)));
  assign sig_439_ff0_d = (~o_i2c_cmd6C_b5 & sig_439_lut_0) | (o_i2c_cmd6C_b5 & sig_439_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6C_b5 <= sig_439_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 440, LSLICE 2

  assign sig_440_lut_0 = (~o_i2c_cmd6D_b6 & cmd6D_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_6) | (net_431 & io_mcu_d_6))) | (o_i2c_cmd6D_b6 & ~cmd6D_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6D_b6 & ~cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_6) | (net_431 & io_mcu_d_6))) | (o_i2c_cmd6D_b6 & cmd6D_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_6))) | (o_i2c_cmd6D_b6 & cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_6) | (net_431 & io_mcu_d_6)));
  assign net_829 = (i2c_send_enable & ~i2c_state_0000000011111001 & ~o_i2c_cmd6D_b6) | (i2c_send_enable & ~i2c_state_0000000011111001 & o_i2c_cmd6D_b6 & (~(i2c_state_xxxxxxxx1011xxxx & i2c_state_00000000xxxx1111)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6D_b6 <= sig_440_lut_0;
  end

//---------------------------------------------------------------------------
//Block 441, LSLICE 3

  assign sig_441_lut_0 = (~cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b5) | (~cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b5 & ((~net_431 & ~io_mcu_d_5) | (~net_431 & io_mcu_d_5))) | (~cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b5) | (cmd69_write_enable & ~i_mcu_dcs & ~o_i2c_cmd69_b5 & ((~net_431 & io_mcu_d_5))) | (cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b5 & ((~net_431 & io_mcu_d_5) | (net_431 & io_mcu_d_5))) | (cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b5 & ((~net_431 & ~io_mcu_d_5) | (~net_431 & io_mcu_d_5))) | (cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b5);
  assign cmd69_write_enable = ((cmd69_select & i_mcu_rws));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd69_b5 <= sig_441_lut_0;
  end

//---------------------------------------------------------------------------
//Block 442, MSLICE 1

  assign cmd0E_enable0 = ((byte_state_0 & cmd0E_select));
  assign net_834 = (cmd06_select & ~o_mcu_d_5 & ((~byte_state_0 & byte_state_1))) | (cmd06_select & o_mcu_d_5 & ((~byte_state_0 & ~byte_state_1) | (~byte_state_0 & byte_state_1)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable0 == 1'b1)   //enable
     begin
      time_base_b24 <= io_mcu_d_0;
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 443, 444, 445

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b0)   //reset
    begin
      { smp_rst_cnt_b3, smp_rst_cnt_b2, smp_rst_cnt_b1, smp_rst_cnt_b0 } <= { 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      { smp_rst_cnt_b3, smp_rst_cnt_b2, smp_rst_cnt_b1, smp_rst_cnt_b0 } <= { smp_rst_cnt_b3, smp_rst_cnt_b2, smp_rst_cnt_b1, smp_rst_cnt_b0 } + { 1'b0, 1'b0, 1'b0, 1'b1 };
    end
  end

//---------------------------------------------------------------------------
//Block 446, LSLICE 2

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //enable
     begin
      adc2_encA <= adc2_encB;
      adc1_encA <= adc1_encB;
    end
  end

//---------------------------------------------------------------------------
//Block 447, MSLICE 1

  assign sig_447_lut_0 = (~relay2_2 & mcu_d00000xxx & ((~io_mcu_d_2 & ~io_mcu_d_1) | (io_mcu_d_2 & ~io_mcu_d_1))) | (relay2_2 & ~mcu_d00000xxx) | (relay2_2 & mcu_d00000xxx & (~(~io_mcu_d_2 & io_mcu_d_1)));
  assign sig_447_lut_1 = (~mcu_d0000010x & ((mcu_d000000xx | relay2_3)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd36_enable == 1'b1)   //enable
     begin
      relay2_2 <= sig_447_lut_0;
      relay2_3 <= sig_447_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 448, MSLICE 0

  assign sig_448_lut_0 = (~relay1_2 & mcu_d00000xxx & ((~io_mcu_d_2 & ~io_mcu_d_1) | (io_mcu_d_2 & ~io_mcu_d_1))) | (relay1_2 & ~mcu_d00000xxx) | (relay1_2 & mcu_d00000xxx & (~(~io_mcu_d_2 & io_mcu_d_1)));
  assign sig_448_lut_1 = (~mcu_d0000010x & ((mcu_d000000xx | relay1_3)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd33_enable == 1'b1)   //enable
     begin
      relay1_2 <= sig_448_lut_0;
      relay1_3 <= sig_448_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 449, MSLICE 1

  assign sig_449_lut_0 = (~io_mcu_d_1 & ~io_mcu_d_2 & ((relay1_1 & ~io_mcu_d_0) | (relay1_1 & io_mcu_d_0))) | (~io_mcu_d_1 & io_mcu_d_2 & ((relay1_1 & ~io_mcu_d_0) | (relay1_1 & io_mcu_d_0))) | (io_mcu_d_1 & ~io_mcu_d_2 & ((relay1_1 & ~io_mcu_d_0) | (relay1_1 & io_mcu_d_0))) | (io_mcu_d_1 & io_mcu_d_2 & ((relay1_1 & ~io_mcu_d_0) | (relay1_1 & io_mcu_d_0)));
  assign sig_449_lut_1 = (~io_mcu_d_1 & ~io_mcu_d_2 & ((~relay1_1 & io_mcu_d_0) | (relay1_1 & io_mcu_d_0))) | (~io_mcu_d_1 & io_mcu_d_2 & ((~relay1_1 & io_mcu_d_0) | (relay1_1 & io_mcu_d_0))) | (io_mcu_d_1 & ~io_mcu_d_2 & ((~relay1_1 & io_mcu_d_0) | (relay1_1 & io_mcu_d_0))) | (io_mcu_d_1 & io_mcu_d_2 & ((relay1_1 & ~io_mcu_d_0) | (relay1_1 & io_mcu_d_0)));
  assign sig_449_ff0_d = (~mcu_d00000xxx & sig_449_lut_0) | (mcu_d00000xxx & sig_449_lut_1);

  always @(posedge i_mcu_clk)
  begin
    if(cmd33_enable == 1'b1)   //enable
     begin
      relay1_1 <= sig_449_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 477, LSLICE 2

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r0 <= 1'b0;
      calib_1KHz_r1 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r0 <= calib_1KHz_c0;
      calib_1KHz_r1 <= calib_1KHz_c1;
    end
  end

//---------------------------------------------------------------------------
//Block 478, LSLICE 3

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r3 <= 1'b0;
      calib_1KHz_r4 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r3 <= calib_1KHz_c3;
      calib_1KHz_r4 <= calib_1KHz_c4;
    end
  end

//---------------------------------------------------------------------------
//Block 480, LSLICE 2

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r10 <= 1'b0;
      calib_1KHz_r7 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r10 <= calib_1KHz_c10;
      calib_1KHz_r7 <= calib_1KHz_c7;
    end
  end

//---------------------------------------------------------------------------
//Block 481, LSLICE 3

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r11 <= 1'b0;
      calib_1KHz_r12 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r11 <= calib_1KHz_c11;
      calib_1KHz_r12 <= calib_1KHz_c12;
    end
  end

//---------------------------------------------------------------------------
//Block 483, LSLICE 2

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r15 <= 1'b0;
      calib_1KHz_r16 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r15 <= calib_1KHz_c15;
      calib_1KHz_r16 <= calib_1KHz_c16;
    end
  end

//---------------------------------------------------------------------------
//Block 484, LSLICE 3

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r19 <= 1'b0;
      calib_1KHz_r20 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r19 <= calib_1KHz_c19;
      calib_1KHz_r20 <= calib_1KHz_c20;
    end
  end

//---------------------------------------------------------------------------
//Block 486, LSLICE 2

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r23 <= 1'b0;
      calib_1KHz_r24 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r23 <= calib_1KHz_c23;
      calib_1KHz_r24 <= calib_1KHz_c24;
    end
  end

//---------------------------------------------------------------------------
//Block 487, LSLICE 3

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r27 <= 1'b0;
      calib_1KHz_r28 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r27 <= calib_1KHz_c27;
      calib_1KHz_r28 <= calib_1KHz_c28;
    end
  end

//---------------------------------------------------------------------------
//Block 490, LSLICE 2

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r31 <= 1'b0;
      calib_1KHz_r18 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r31 <= calib_1KHz_c31;
      calib_1KHz_r18 <= calib_1KHz_c18;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 477, 478, 480, 481, 483, 484, 486, 487, 490

  assign { calib_1KHz_c31, calib_1KHz_c30, calib_1KHz_c29, calib_1KHz_c28, calib_1KHz_c27, calib_1KHz_c26, calib_1KHz_c25, calib_1KHz_c24, calib_1KHz_c23, calib_1KHz_c22, calib_1KHz_c21, calib_1KHz_c20, calib_1KHz_c19, calib_1KHz_c18, calib_1KHz_c17, calib_1KHz_c16, calib_1KHz_c15, calib_1KHz_c14, calib_1KHz_c13, calib_1KHz_c12, calib_1KHz_c11, calib_1KHz_c10, calib_1KHz_c9, calib_1KHz_c8, calib_1KHz_c7, calib_1KHz_c6, calib_1KHz_c5, calib_1KHz_c4, calib_1KHz_c3, calib_1KHz_c2, calib_1KHz_c1, calib_1KHz_c0 } = { calib_1KHz_r31, calib_1KHz_r30, calib_1KHz_r29, calib_1KHz_r28, calib_1KHz_r27, calib_1KHz_r26, calib_1KHz_r25, calib_1KHz_r24, calib_1KHz_r23, calib_1KHz_r22, calib_1KHz_r21, calib_1KHz_r20, calib_1KHz_r19, calib_1KHz_r18, calib_1KHz_r17, calib_1KHz_r16, calib_1KHz_r15, calib_1KHz_r14, calib_1KHz_r13, calib_1KHz_r12, calib_1KHz_r11, calib_1KHz_r10, calib_1KHz_r9, calib_1KHz_r8, calib_1KHz_r7, calib_1KHz_r6, calib_1KHz_r5, calib_1KHz_r4, calib_1KHz_r3, calib_1KHz_r2, calib_1KHz_r1, calib_1KHz_r0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 479, MSLICE 0

  assign calib_1KHz_d = (~calib_1KHz_r6 & ~calib_1KHz_r5) | (~calib_1KHz_r6 & calib_1KHz_r5 & ((~calib_1KHz_r4 & ~calib_1KHz_r3)));
  assign calib_1KHz_e = (~calib_1KHz_r19 & ~calib_1KHz_r20 & ((~calib_1KHz_r18 & ~calib_1KHz_r17)));

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r5 <= 1'b0;
      calib_1KHz_r17 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r5 <= calib_1KHz_c5;
      calib_1KHz_r17 <= calib_1KHz_c17;
    end
  end

//---------------------------------------------------------------------------
//Block 482, MSLICE 1

  assign calib_1KHz_c = (~calib_1KHz_r9 & ~calib_1KHz_r12 & ((~calib_1KHz_r11 & ~calib_1KHz_r10)));
  assign calib_1KHz_b = (~calib_1KHz_r7 & ~calib_1KHz_r8 & ((calib_1KHz_c & ~calib_1KHz_d) | (calib_1KHz_c & calib_1KHz_d))) | (~calib_1KHz_r7 & calib_1KHz_r8 & ((calib_1KHz_c & ~calib_1KHz_d) | (calib_1KHz_c & calib_1KHz_d))) | (calib_1KHz_r7 & ~calib_1KHz_r8 & ((calib_1KHz_c & ~calib_1KHz_d) | (calib_1KHz_c & calib_1KHz_d))) | (calib_1KHz_r7 & calib_1KHz_r8 & ((calib_1KHz_c & calib_1KHz_d)));

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r9 <= 1'b0;
      calib_1KHz_r8 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r9 <= calib_1KHz_c9;
      calib_1KHz_r8 <= calib_1KHz_c8;
    end
  end

//---------------------------------------------------------------------------
//Block 485, MSLICE 0

  assign sig_485_lut_0 = (~net_1106 & ~net_545 & ((offset1_pwm_r10 & ~ch1_offset_b10))) | (~net_1106 & net_545 & (~(~offset1_pwm_r10 & ch1_offset_b10))) | (net_1106 & ~net_545 & (~(~offset1_pwm_r10 & ch1_offset_b10))) | (net_1106 & net_545 & (~(~offset1_pwm_r10 & ch1_offset_b10)));
  assign sig_485_lut_1 = (~net_1106 & ~net_545 & (~(~offset1_pwm_r10 & ch1_offset_b10))) | (~net_1106 & net_545 & (~(~offset1_pwm_r10 & ch1_offset_b10))) | (net_1106 & ~net_545 & (~(~offset1_pwm_r10 & ch1_offset_b10))) | (net_1106 & net_545 & (~(~offset1_pwm_r10 & ch1_offset_b10)));
  assign net_944 = (~net_757 & sig_485_lut_0) | (net_757 & sig_485_lut_1);

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r26 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r26 <= calib_1KHz_c26;
    end
  end

//---------------------------------------------------------------------------
//Block 488, MSLICE 1

  assign net_935 = (~offset1_pwm_r13 & ~ch1_offset_b13 & (~(offset1_pwm_r12 & ~ch1_offset_b12))) | (~offset1_pwm_r13 & ch1_offset_b13 & (~(offset1_pwm_r12 & ~ch1_offset_b12))) | (offset1_pwm_r13 & ch1_offset_b13 & (~(offset1_pwm_r12 & ~ch1_offset_b12)));
  assign net_938 = (~offset1_pwm_r12 & ~net_955 & ((ch1_offset_b12 & net_935))) | (~offset1_pwm_r12 & net_955 & ((~ch1_offset_b12 & net_935) | (ch1_offset_b12 & net_935))) | (offset1_pwm_r12 & net_955 & ((~ch1_offset_b12 & net_935) | (ch1_offset_b12 & net_935)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd32_enable0 == 1'b1)   //enable
     begin
      ch1_offset_b13 <= io_mcu_d_5;
      ch1_offset_b12 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 489, MSLICE 0

  assign net_956 = (~offset1_pwm_r14 & ~ch1_offset_b14 & (~(~net_938 & net_1103))) | (~offset1_pwm_r14 & ch1_offset_b14 & (~(~net_938 & net_1103))) | (offset1_pwm_r14 & ch1_offset_b14 & (~(~net_938 & net_1103)));
  assign net_955 = (~offset1_pwm_r11 & (~(net_944 & ~ch1_offset_b11))) | (offset1_pwm_r11 & ((~net_944 & ch1_offset_b11)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd32_enable0 == 1'b1)   //enable
     begin
      ch1_offset_b14 <= io_mcu_d_6;
      ch1_offset_b11 <= io_mcu_d_3;
    end
  end

//---------------------------------------------------------------------------
//Block 491, LSLICE 3

  assign net_958 = (~cmd22_adc2A_b1 & ~cmd25_select & ~i_adc1B_d_1 & (~(i_i2c_cmd6E_b1 & cmd6E_select))) | (~cmd22_adc2A_b1 & ~cmd25_select & i_adc1B_d_1 & (~(i_i2c_cmd6E_b1 & cmd6E_select))) | (~cmd22_adc2A_b1 & cmd25_select & ~i_adc1B_d_1 & (~(i_i2c_cmd6E_b1 & cmd6E_select)));
  assign net_957 = (net_958 & net_1120 & net_1202 & (~(i_i2c_cmd68_b1 & cmd68_select)));

//---------------------------------------------------------------------------
//Block 492, MSLICE 0

  assign i2c_cmd6E_e6 = (~i2c_send_enable & ((i2c_state_xxxxxxxx1101xxxx & i2c_state_00000000xxxx1110)));
  assign net_960 = (~cmd26_select & ~i_adc2A_d_6 & (~(i_i2c_cmd6E_b6 & cmd6E_select))) | (~cmd26_select & i_adc2A_d_6 & (~(i_i2c_cmd6E_b6 & cmd6E_select))) | (cmd26_select & ~i_adc2A_d_6 & (~(i_i2c_cmd6E_b6 & cmd6E_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6E_b6 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6E_e6 == 1'b1)   //enable
       begin
        i_i2c_cmd6E_b6 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 493, LSLICE 2

  assign i2c_cmd6A_e2 = (i2c_state_00000000xxxx1110 & ((i2c_state_xxxxxxxx0110xxxx & ~i2c_send_enable)));
  assign net_964 = (~i_adc1B_d_2 & ~cmd25_select & (~(i_i2c_cmd6A_b2 & cmd6A_select))) | (~i_adc1B_d_2 & cmd25_select & (~(i_i2c_cmd6A_b2 & cmd6A_select))) | (i_adc1B_d_2 & ~cmd25_select & (~(i_i2c_cmd6A_b2 & cmd6A_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6A_b2 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd6A_e2 == 1'b1)   //enable
       begin
        i_i2c_cmd6A_b2 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 494, LSLICE 3

  assign net_970 = (net_684 & ~cmd24_select & ~i_adc1A_d_3 & (~(i_i2c_cmd69_b3 & cmd69_select))) | (net_684 & ~cmd24_select & i_adc1A_d_3 & (~(i_i2c_cmd69_b3 & cmd69_select))) | (net_684 & cmd24_select & ~i_adc1A_d_3 & (~(i_i2c_cmd69_b3 & cmd69_select)));
  assign i2c_cmd69_e3 = (~i2c_send_enable & ((i2c_state_xxxxxxxx0100xxxx & i2c_state_00000000xxxx1110)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd69_b3 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd69_e3 == 1'b1)   //enable
       begin
        i_i2c_cmd69_b3 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 495, MSLICE 1

  assign i2c_cmd6D_e0 = ((net_1605 & i2c_state_xxxxxxxx1100xxxx));
  assign net_961 = (~cmd0A_select & ~sample_write_enable & (~(i_i2c_cmd6D_b0 & cmd6D_select))) | (~cmd0A_select & sample_write_enable & (~(i_i2c_cmd6D_b0 & cmd6D_select))) | (cmd0A_select & sample_write_enable & (~(i_i2c_cmd6D_b0 & cmd6D_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6D_b0 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6D_e0 == 1'b1)   //enable
       begin
        i_i2c_cmd6D_b0 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 496, MSLICE 0

  assign i2c_cmd69_e5 = (i2c_state_00000000xxxx1010 & ((~i2c_send_enable & i2c_state_xxxxxxxx0100xxxx)));
  assign net_977 = (~i_i2c_cmd69_b5 & ~read_adc1A_b5) | (~i_i2c_cmd69_b5 & read_adc1A_b5 & ((~cmd69_select & ~cmd20_select) | (cmd69_select & ~cmd20_select))) | (i_i2c_cmd69_b5 & ~read_adc1A_b5 & ((~cmd69_select & ~cmd20_select) | (~cmd69_select & cmd20_select))) | (i_i2c_cmd69_b5 & read_adc1A_b5 & ((~cmd69_select & ~cmd20_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd69_b5 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd69_e5 == 1'b1)   //enable
       begin
        i_i2c_cmd69_b5 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 497, LSLICE 2

  assign sig_497_lut_0 = (~net_982 & ~net_1403 & ~net_1338) | (~net_982 & ~net_1403 & net_1338) | (~net_982 & net_1403 & ~net_1338) | (~net_982 & net_1403 & net_1338 & ((net_974 | i2c_state_0000000001010111)));
  assign net_974 = (~net_1317 & i2c_sda_dir) | (net_1317 & i2c_sda_dir & (~(net_979 & net_1222)));

  always @(posedge i2c_clock)
  begin
    if(i2c_disable == 1'b0)   //enable
     begin
      i2c_sda_dir <= sig_497_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 498, MSLICE 1

  assign not_cmd_05_0A = ((~cmd05_select & ~cmd0A_select));
  assign net_973 = ((net_1304 & net_1153));

//---------------------------------------------------------------------------
//Block 499, LSLICE 3

  assign net_978 = (net_1207 & net_984 & ((net_1478 & ~net_1141)));
  assign net_979 = ((~net_1141 & ~i2c_state_0000000011111001));

//---------------------------------------------------------------------------
//Block 500, MSLICE 0

  assign sig_500_lut_0 = 1'b0;
  assign sig_500_lut_1 = (~net_1211 & ~net_1222 & ((~net_1317 & ~i2c_sda_dir) | (net_1317 & ~i2c_sda_dir))) | (~net_1211 & net_1222 & (~(~net_1317 & i2c_sda_dir))) | (net_1211 & ~net_1222 & ((~net_1317 & ~i2c_sda_dir) | (net_1317 & ~i2c_sda_dir))) | (net_1211 & net_1222 & ((~net_1317 & ~i2c_sda_dir) | (net_1317 & ~i2c_sda_dir)));
  assign net_982 = (~net_1489 & sig_500_lut_0) | (net_1489 & sig_500_lut_1);

//---------------------------------------------------------------------------
//Block 501, LSLICE 2

  assign i2c_cmd6E_e3 = (~i2c_send_enable & ((i2c_state_000000001110xxxx & i2c_state_xxxxxxxxxxxx0100)));
  assign net_980 = (~i_adc2B_d_3 & ~cmd6E_select) | (~i_adc2B_d_3 & cmd6E_select & ((~i_i2c_cmd6E_b3 & ~cmd27_select) | (~i_i2c_cmd6E_b3 & cmd27_select))) | (i_adc2B_d_3 & ~cmd6E_select & ((~i_i2c_cmd6E_b3 & ~cmd27_select) | (i_i2c_cmd6E_b3 & ~cmd27_select))) | (i_adc2B_d_3 & cmd6E_select & ((~i_i2c_cmd6E_b3 & ~cmd27_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6E_b3 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6E_e3 == 1'b1)   //enable
       begin
        i_i2c_cmd6E_b3 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 502, LSLICE 3

  assign i2c_state_0000000001010100 = ((i2c_state_000000000101xxxx & i2c_state_xxxxxxxxxxxx0100));
  assign net_984 = (net_1487 & ~net_1400 & ((net_1153 & net_1381)));

//---------------------------------------------------------------------------
//Block 503, MSLICE 0

  assign sig_503_lut_0 = (~net_1218 & ~net_1242 & ((~net_978 & ~net_1506) | (net_978 & ~net_1506))) | (net_1218 & ~net_1242 & ((~net_978 & ~net_1506) | (net_978 & ~net_1506)));
  assign sig_503_lut_1 = (~net_1218 & ~net_1242) | (~net_1218 & net_1242 & ((~net_978 & ~net_1506) | (~net_978 & net_1506))) | (net_1218 & ~net_1242 & ((~net_978 & ~net_1506) | (net_978 & ~net_1506))) | (net_1218 & net_1242 & ((~net_978 & ~net_1506)));
  assign sig_503_ff0_d = (~o_i2c_sda & sig_503_lut_0) | (o_i2c_sda & sig_503_lut_1);

  always @(posedge i2c_clock)
  begin
    if(i2c_disable == 1'b0)   //enable
     begin
      o_i2c_sda <= sig_503_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 504, LSLICE 2

  assign i2c_state_00000000xxxx1001 = ((i2c_state_xxxxxxxxxxxx1001 & i2c_state_00000000xxxxxxxx));
  assign i2c_state_0000000011111001 = ((i2c_state_00000000xxxx1001 & i2c_state_xxxxxxxx1111xxxx));

//---------------------------------------------------------------------------
//Block 505, MSLICE 1

  assign i2c_cmd6B_e0 = ((~i2c_send_enable & i2c_state_0000000010010000));
  assign net_990 = (~cmd6B_select & ~i_adc1B_d_0) | (~cmd6B_select & i_adc1B_d_0 & ((~i_i2c_cmd6B_b0 & ~cmd25_select) | (i_i2c_cmd6B_b0 & ~cmd25_select))) | (cmd6B_select & ~i_adc1B_d_0 & ((~i_i2c_cmd6B_b0 & ~cmd25_select) | (~i_i2c_cmd6B_b0 & cmd25_select))) | (cmd6B_select & i_adc1B_d_0 & ((~i_i2c_cmd6B_b0 & ~cmd25_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6B_b0 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6B_e0 == 1'b1)   //enable
       begin
        i_i2c_cmd6B_b0 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 506, MSLICE 0

  assign i2c_cmd6C_e3 = (i2c_state_000000001010xxxx & ((~i2c_send_enable & i2c_state_xxxxxxxxxxxx1000)));
  assign net_996 = (~i2c_state_xxxxxxxxxxxx1000 & ((i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx0110))) | (i2c_state_xxxxxxxxxxxx1000 & ((i2c_state_000000001010xxxx & ~i2c_state_xxxxxxxxxxxx0110) | (i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx0110)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6C_b3 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6C_e3 == 1'b1)   //enable
       begin
        i_i2c_cmd6C_b3 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 507, LSLICE 2

  assign i2c_state_0000000010111110 = ((i2c_state_xxxxxxxx1011xxxx & i2c_state_00000000xxxx1110));
  assign net_993 = ((~i2c_state_0000000010111110 & ~i2c_state_0000000010110000));

//---------------------------------------------------------------------------
//Block 508, LSLICE 3

  assign i2c_cmd6E_e5 = (i2c_state_xxxxxxxxxxxx0000 & ((~i2c_send_enable & i2c_state_000000001110xxxx)));
  assign net_997 = (~i_i2c_cmd6A_b5 & ~cmd6A_select & (~(i_i2c_cmd6E_b5 & cmd6E_select))) | (~i_i2c_cmd6A_b5 & cmd6A_select & (~(i_i2c_cmd6E_b5 & cmd6E_select))) | (i_i2c_cmd6A_b5 & ~cmd6A_select & (~(i_i2c_cmd6E_b5 & cmd6E_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6E_b5 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6E_e5 == 1'b1)   //enable
       begin
        i_i2c_cmd6E_b5 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 509, MSLICE 0

  assign i2c_cmd69_e1 = (i2c_state_000000000101xxxx & ((~i2c_send_enable & i2c_state_xxxxxxxxxxxx0010)));
  assign net_1005 = (~cmd69_select & ((~net_565 & ~i_i2c_cmd69_b1) | (~net_565 & i_i2c_cmd69_b1))) | (cmd69_select & ((~net_565 & ~i_i2c_cmd69_b1)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd69_b1 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd69_e1 == 1'b1)   //enable
       begin
        i_i2c_cmd69_b1 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 510, LSLICE 2

  assign i2c_cmd6D_e3 = (i2c_state_xxxxxxxxxxxx0110 & ((i2c_state_000000001100xxxx & ~i2c_send_enable)));
  assign i2c_state_198_200 = (i2c_state_000000001100xxxx & ((i2c_state_xxxxxxxxxxxx0110 | i2c_state_xxxxxxxxxxxx1000)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6D_b3 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6D_e3 == 1'b1)   //enable
       begin
        i_i2c_cmd6D_b3 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 511, MSLICE 1

  assign sig_511_lut_0 = (~i2c_state_00000000xxxx1111 & ~i2c_state_xxxxxxxx1101xxxx) | (~i2c_state_00000000xxxx1111 & i2c_state_xxxxxxxx1101xxxx & ((~i2c_state_xxxxxxxx1011xxxx & ~i2c_state_00000000xxxx1110) | (i2c_state_xxxxxxxx1011xxxx & ~i2c_state_00000000xxxx1110))) | (i2c_state_00000000xxxx1111 & ~i2c_state_xxxxxxxx1101xxxx & ((~i2c_state_xxxxxxxx1011xxxx & ~i2c_state_00000000xxxx1110) | (~i2c_state_xxxxxxxx1011xxxx & i2c_state_00000000xxxx1110)));
  assign sig_511_lut_1 = 1'b0;
  assign net_1000 = (~i2c_state_0000000011000000 & sig_511_lut_0) | (i2c_state_0000000011000000 & sig_511_lut_1);

//---------------------------------------------------------------------------
//Block 512, MSLICE 0

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg2 <= 1'b0;
      time_base_cnt_reg5 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg2 <= time_base_cnt_out2;
      time_base_cnt_reg5 <= time_base_cnt_out5;
    end
  end

//---------------------------------------------------------------------------
//Block 515, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable3 == 1'b1)   //enable
     begin
      time_base_b1 <= io_mcu_d_1;
      time_base_b2 <= io_mcu_d_2;
    end
  end

//---------------------------------------------------------------------------
//Block 516, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable3 == 1'b1)   //enable
     begin
      time_base_b3 <= io_mcu_d_3;
      time_base_b4 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 518, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable3 == 1'b1)   //enable
     begin
      time_base_b5 <= io_mcu_d_5;
      time_base_b6 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 519, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable3 == 1'b1)   //enable
     begin
      time_base_b7 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 522, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable2 == 1'b1)   //enable
     begin
      time_base_b9 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 523, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable2 == 1'b1)   //enable
     begin
      time_base_b11 <= io_mcu_d_3;
      time_base_b12 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 526, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable2 == 1'b1)   //enable
     begin
      time_base_b13 <= io_mcu_d_5;
      time_base_b14 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 527, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable2 == 1'b1)   //enable
     begin
      time_base_b15 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 530, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable1 == 1'b1)   //enable
     begin
      time_base_b17 <= io_mcu_d_1;
      time_base_b18 <= io_mcu_d_2;
    end
  end

//---------------------------------------------------------------------------
//Block 531, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable1 == 1'b1)   //enable
     begin
      time_base_b19 <= io_mcu_d_3;
      time_base_b20 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 534, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable1 == 1'b1)   //enable
     begin
      time_base_b21 <= io_mcu_d_5;
      time_base_b22 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 535, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable1 == 1'b1)   //enable
     begin
      time_base_b23 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//Block 537, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable0 == 1'b1)   //enable
     begin
      time_base_b25 <= io_mcu_d_1;
      time_base_b26 <= io_mcu_d_2;
    end
  end

//---------------------------------------------------------------------------
//Block 538, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable0 == 1'b1)   //enable
     begin
      time_base_b27 <= io_mcu_d_3;
      time_base_b28 <= io_mcu_d_4;
    end
  end

//---------------------------------------------------------------------------
//Block 539, MSLICE 1

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable0 == 1'b1)   //enable
     begin
      time_base_b29 <= io_mcu_d_5;
      time_base_b30 <= io_mcu_d_6;
    end
  end

//---------------------------------------------------------------------------
//Block 540, MSLICE 0

  always @(posedge i_mcu_clk)
  begin
    if(cmd0E_enable0 == 1'b1)   //enable
     begin
      time_base_b31 <= io_mcu_d_7;
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 512, 515, 516, 518, 519, 522, 523, 526, 527, 530, 531, 534, 535, 537, 538, 539, 540

  assign { time_base_timeout, open_32, open_33, open_34, open_35, open_36, open_37, open_38, open_39, open_40, open_41, open_42, open_43, open_44, open_45, open_46, open_47, open_48, open_49, open_50, open_51, open_52, open_53, open_54, open_55, open_56, open_57, open_58, open_59, open_60, open_61, open_62, open_63 } = { 1'b0, time_base_b31, time_base_b30, time_base_b29, time_base_b28, time_base_b27, time_base_b26, time_base_b25, time_base_b24, time_base_b23, time_base_b22, time_base_b21, time_base_b20, time_base_b19, time_base_b18, time_base_b17, time_base_b16, time_base_b15, time_base_b14, time_base_b13, time_base_b12, time_base_b11, time_base_b10, time_base_b9, time_base_b8, time_base_b7, time_base_b6, time_base_b5, time_base_b4, time_base_b3, time_base_b2, time_base_b1, time_base_b0 } - { time_base_cnt_reg31, time_base_cnt_reg30, time_base_cnt_reg29, time_base_cnt_reg28, time_base_cnt_reg27, time_base_cnt_reg26, time_base_cnt_reg25, time_base_cnt_reg24, time_base_cnt_reg23, time_base_cnt_reg22, time_base_cnt_reg21, time_base_cnt_reg20, time_base_cnt_reg19, time_base_cnt_reg18, time_base_cnt_reg17, time_base_cnt_reg16, time_base_cnt_reg15, time_base_cnt_reg14, time_base_cnt_reg13, time_base_cnt_reg12, time_base_cnt_reg11, time_base_cnt_reg10, time_base_cnt_reg9, time_base_cnt_reg8, time_base_cnt_reg7, time_base_cnt_reg6, time_base_cnt_reg5, time_base_cnt_reg4, time_base_cnt_reg3, time_base_cnt_reg2, time_base_cnt_reg1, time_base_cnt_reg0 };

//---------------------------------------------------------------------------
//Block 513, LSLICE 2

  assign sig_513_lut_0 = (~o_i2c_cmd6C_b2 & cmd6C_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_2) | (net_431 & io_mcu_d_2))) | (o_i2c_cmd6C_b2 & ~cmd6C_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6C_b2 & ~cmd6C_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_2) | (net_431 & io_mcu_d_2))) | (o_i2c_cmd6C_b2 & cmd6C_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_2))) | (o_i2c_cmd6C_b2 & cmd6C_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_2) | (net_431 & io_mcu_d_2)));
  assign net_1012 = (~i2c_state_000000000100xxxx & ~o_i2c_cmd69_b5 & (~(i2c_state_000000001010xxxx & o_i2c_cmd6C_b2))) | (~i2c_state_000000000100xxxx & o_i2c_cmd69_b5 & (~(i2c_state_000000001010xxxx & o_i2c_cmd6C_b2))) | (i2c_state_000000000100xxxx & ~o_i2c_cmd69_b5 & (~(i2c_state_000000001010xxxx & o_i2c_cmd6C_b2)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6C_b2 <= sig_513_lut_0;
  end

//---------------------------------------------------------------------------
//Block 514, LSLICE 3

  assign i2c_state_00000000xxxx1111 = ((i2c_state_xxxxxxxxxxxx1111 & i2c_state_00000000xxxxxxxx));
  assign net_1014 = (i2c_state_xxxxxxxx1101xxxx & ((o_i2c_cmd6E_b5 & i2c_state_00000000xxxx1111)));

//---------------------------------------------------------------------------
//Block 517, LSLICE 2

  assign sig_517_lut_0 = (~o_i2c_cmd6B_b3 & cmd6B_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd6B_b3 & ~cmd6B_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6B_b3 & ~cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd6B_b3 & cmd6B_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_3))) | (o_i2c_cmd6B_b3 & cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3)));
  assign sig_517_lut_1 = (~o_i2c_cmd6B_b4 & cmd6B_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_4) | (net_431 & io_mcu_d_4))) | (o_i2c_cmd6B_b4 & ~cmd6B_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6B_b4 & ~cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_4) | (net_431 & io_mcu_d_4))) | (o_i2c_cmd6B_b4 & cmd6B_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_4))) | (o_i2c_cmd6B_b4 & cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_4) | (net_431 & io_mcu_d_4)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6B_b3 <= sig_517_lut_0;
    o_i2c_cmd6B_b4 <= sig_517_lut_1;
  end

//---------------------------------------------------------------------------
//Block 520, LSLICE 2

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg0 <= 1'b0;
      time_base_cnt_reg1 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg0 <= time_base_cnt_out0;
      time_base_cnt_reg1 <= time_base_cnt_out1;
    end
  end

//---------------------------------------------------------------------------
//Block 521, LSLICE 3

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg3 <= 1'b0;
      time_base_cnt_reg4 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg3 <= time_base_cnt_out3;
      time_base_cnt_reg4 <= time_base_cnt_out4;
    end
  end

//---------------------------------------------------------------------------
//Block 524, LSLICE 2

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg10 <= 1'b0;
      time_base_cnt_reg7 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg10 <= time_base_cnt_out10;
      time_base_cnt_reg7 <= time_base_cnt_out7;
    end
  end

//---------------------------------------------------------------------------
//Block 525, LSLICE 3

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg11 <= 1'b0;
      time_base_cnt_reg12 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg11 <= time_base_cnt_out11;
      time_base_cnt_reg12 <= time_base_cnt_out12;
    end
  end

//---------------------------------------------------------------------------
//Block 528, LSLICE 2

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg15 <= 1'b0;
      time_base_cnt_reg16 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg15 <= time_base_cnt_out15;
      time_base_cnt_reg16 <= time_base_cnt_out16;
    end
  end

//---------------------------------------------------------------------------
//Block 529, LSLICE 3

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg19 <= 1'b0;
      time_base_cnt_reg20 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg19 <= time_base_cnt_out19;
      time_base_cnt_reg20 <= time_base_cnt_out20;
    end
  end

//---------------------------------------------------------------------------
//Block 532, LSLICE 2

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg23 <= 1'b0;
      time_base_cnt_reg24 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg23 <= time_base_cnt_out23;
      time_base_cnt_reg24 <= time_base_cnt_out24;
    end
  end

//---------------------------------------------------------------------------
//Block 533, LSLICE 3

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg27 <= 1'b0;
      time_base_cnt_reg28 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg27 <= time_base_cnt_out27;
      time_base_cnt_reg28 <= time_base_cnt_out28;
    end
  end

//---------------------------------------------------------------------------
//Block 536, LSLICE 2

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg31 <= 1'b0;
      time_base_cnt_reg29 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg31 <= time_base_cnt_out31;
      time_base_cnt_reg29 <= time_base_cnt_out29;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 520, 521, 524, 525, 528, 529, 532, 533, 536

  assign { time_base_cnt_out31, time_base_cnt_out30, time_base_cnt_out29, time_base_cnt_out28, time_base_cnt_out27, time_base_cnt_out26, time_base_cnt_out25, time_base_cnt_out24, time_base_cnt_out23, time_base_cnt_out22, time_base_cnt_out21, time_base_cnt_out20, time_base_cnt_out19, time_base_cnt_out18, time_base_cnt_out17, time_base_cnt_out16, time_base_cnt_out15, time_base_cnt_out14, time_base_cnt_out13, time_base_cnt_out12, time_base_cnt_out11, time_base_cnt_out10, time_base_cnt_out9, time_base_cnt_out8, time_base_cnt_out7, time_base_cnt_out6, time_base_cnt_out5, time_base_cnt_out4, time_base_cnt_out3, time_base_cnt_out2, time_base_cnt_out1, time_base_cnt_out0 } = { time_base_cnt_reg31, time_base_cnt_reg30, time_base_cnt_reg29, time_base_cnt_reg28, time_base_cnt_reg27, time_base_cnt_reg26, time_base_cnt_reg25, time_base_cnt_reg24, time_base_cnt_reg23, time_base_cnt_reg22, time_base_cnt_reg21, time_base_cnt_reg20, time_base_cnt_reg19, time_base_cnt_reg18, time_base_cnt_reg17, time_base_cnt_reg16, time_base_cnt_reg15, time_base_cnt_reg14, time_base_cnt_reg13, time_base_cnt_reg12, time_base_cnt_reg11, time_base_cnt_reg10, time_base_cnt_reg9, time_base_cnt_reg8, time_base_cnt_reg7, time_base_cnt_reg6, time_base_cnt_reg5, time_base_cnt_reg4, time_base_cnt_reg3, time_base_cnt_reg2, time_base_cnt_reg1, time_base_cnt_reg0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 545, LSLICE 2

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r6 <= 1'b0;
      calib_1KHz_r2 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r6 <= calib_1KHz_c6;
      calib_1KHz_r2 <= calib_1KHz_c2;
    end
  end

//---------------------------------------------------------------------------
//Block 546, LSLICE 2

  assign calib_1KHz_rst = (~calib_1KHz_a & ~calib_1KHz_b) | (~calib_1KHz_a & calib_1KHz_b) | (calib_1KHz_a & ~calib_1KHz_b & ((calib_1KHz_r14 & calib_1KHz_r13)));
  assign calib_1KHz_a = (calib_1KHz_e & calib_1KHz_f & ((~calib_1KHz_r15 & ~calib_1KHz_r16)));

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r13 <= 1'b0;
      calib_1KHz_r14 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r13 <= calib_1KHz_c13;
      calib_1KHz_r14 <= calib_1KHz_c14;
    end
  end

//---------------------------------------------------------------------------
//Block 547, LSLICE 2

  assign net_1104 = (offset1_pwm_r10 & offset1_pwm_r6 & ((offset1_pwm_r5 | offset1_pwm_r4)));
  assign net_1103 = (~ch1_offset_b13 & ~offset1_pwm_r14 & ((~ch1_offset_b14 & ~offset1_pwm_r13) | (~ch1_offset_b14 & offset1_pwm_r13))) | (~ch1_offset_b13 & offset1_pwm_r14) | (ch1_offset_b13 & ~offset1_pwm_r14 & ((~ch1_offset_b14 & offset1_pwm_r13))) | (ch1_offset_b13 & offset1_pwm_r14 & ((~ch1_offset_b14 & offset1_pwm_r13) | (ch1_offset_b14 & offset1_pwm_r13)));

  always @(posedge clk_50MHz)
  begin
    if(offset1_pwm_rst == 1'b1)   //reset
    begin
      offset1_pwm_r5 <= 1'b0;
      offset1_pwm_r14 <= 1'b0;
    end
    else
    begin
      offset1_pwm_r5 <= offset1_pwm_c5;
      offset1_pwm_r14 <= offset1_pwm_c14;
    end
  end

//---------------------------------------------------------------------------
//Block 548, LSLICE 3

  assign net_1106 = (net_771 & net_1100 & ~offset1_pwm_r6 & ((~ch1_offset_b6 & ~net_1108))) | (net_771 & net_1100 & offset1_pwm_r6 & ((ch1_offset_b6 & ~net_1108)));
  assign net_1100 = (~net_755 & (~(ch1_offset_b8 & ~offset1_pwm_r8)));

  always @(posedge clk_50MHz)
  begin
    if(offset1_pwm_rst == 1'b1)   //reset
    begin
      offset1_pwm_r6 <= 1'b0;
      offset1_pwm_r8 <= 1'b0;
    end
    else
    begin
      offset1_pwm_r6 <= offset1_pwm_c6;
      offset1_pwm_r8 <= offset1_pwm_c8;
    end
  end

//---------------------------------------------------------------------------
//Block 549, LSLICE 2

  assign net_1111 = (~offset1_pwm_r2 & ~ch1_offset_b2 & ~net_1112 & (~(offset1_pwm_r3 & ~ch1_offset_b3))) | (~offset1_pwm_r2 & ch1_offset_b2 & ~net_1112 & (~(offset1_pwm_r3 & ~ch1_offset_b3))) | (~offset1_pwm_r2 & ch1_offset_b2 & net_1112 & (~(offset1_pwm_r3 & ~ch1_offset_b3))) | (offset1_pwm_r2 & ch1_offset_b2 & ~net_1112 & (~(offset1_pwm_r3 & ~ch1_offset_b3)));
  assign net_1112 = (~offset1_pwm_r1 & ~ch1_offset_b0 & ((~ch1_offset_b1 & ~offset1_pwm_r0) | (~ch1_offset_b1 & offset1_pwm_r0))) | (~offset1_pwm_r1 & ch1_offset_b0 & ((~ch1_offset_b1 & offset1_pwm_r0))) | (offset1_pwm_r1 & ~ch1_offset_b0) | (offset1_pwm_r1 & ch1_offset_b0 & (~(ch1_offset_b1 & ~offset1_pwm_r0)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd32_enable1 == 1'b1)   //enable
     begin
      ch1_offset_b2 <= io_mcu_d_2;
      ch1_offset_b1 <= io_mcu_d_1;
    end
  end

//---------------------------------------------------------------------------
//Block 550, LSLICE 3

  assign net_1108 = (~net_1116 & ~ch1_offset_b5 & ~offset1_pwm_r5 & (~(offset1_pwm_r4 & ~ch1_offset_b4))) | (~net_1116 & ch1_offset_b5 & ~offset1_pwm_r5 & (~(offset1_pwm_r4 & ~ch1_offset_b4))) | (~net_1116 & ch1_offset_b5 & offset1_pwm_r5 & (~(offset1_pwm_r4 & ~ch1_offset_b4)));
  assign net_1116 = (~net_1111 & ~offset1_pwm_r4 & ~ch1_offset_b4 & (~(ch1_offset_b3 & ~offset1_pwm_r3))) | (~net_1111 & offset1_pwm_r4 & ~ch1_offset_b4 & (~(ch1_offset_b3 & ~offset1_pwm_r3))) | (~net_1111 & offset1_pwm_r4 & ch1_offset_b4 & (~(ch1_offset_b3 & ~offset1_pwm_r3)));

  always @(posedge i_mcu_clk)
  begin
    if(cmd32_enable1 == 1'b1)   //enable
     begin
      ch1_offset_b4 <= io_mcu_d_4;
      ch1_offset_b3 <= io_mcu_d_3;
    end
  end

//---------------------------------------------------------------------------
//Block 551, MSLICE 1

  assign i2c_cmd6B_e2 = ((net_1605 & i2c_state_xxxxxxxx1000xxxx));
  assign net_1109 = (net_1119 & net_426 & (~(i_i2c_cmd6B_b2 & cmd6B_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6B_b2 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6B_e2 == 1'b1)   //enable
       begin
        i_i2c_cmd6B_b2 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 552, MSLICE 0

  assign sig_552_lut_0 = (cmd6E_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_6) | (net_431 & io_mcu_d_6)));
  assign sig_552_lut_1 = (~cmd6E_write_enable & ~i_mcu_dcs) | (~cmd6E_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_6) | (net_431 & io_mcu_d_6))) | (cmd6E_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_6))) | (cmd6E_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_6) | (net_431 & io_mcu_d_6)));
  assign sig_552_ff0_d = (~o_i2c_cmd6E_b6 & sig_552_lut_0) | (o_i2c_cmd6E_b6 & sig_552_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6E_b6 <= sig_552_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 553, LSLICE 2

  assign net_1120 = (net_776 & ~cmd6A_select & ~i_i2c_cmd6A_b1 & (~(i_i2c_cmd6C_b1 & cmd6C_select))) | (net_776 & ~cmd6A_select & i_i2c_cmd6A_b1 & (~(i_i2c_cmd6C_b1 & cmd6C_select))) | (net_776 & cmd6A_select & ~i_i2c_cmd6A_b1 & (~(i_i2c_cmd6C_b1 & cmd6C_select)));
  assign i2c_cmd6C_e1 = ((i2c_state_xxxxxxxx1010xxxx & net_1605));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6C_b1 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd6C_e1 == 1'b1)   //enable
       begin
        i_i2c_cmd6C_b1 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 554, MSLICE 1

  assign i2c_cmd68_e2 = (i2c_state_000000000011xxxx & ((i2c_state_xxxxxxxxxxxx0010 & ~i2c_send_enable)));
  assign net_1119 = (~cmd26_select & ~i_adc2A_d_2 & (~(i_i2c_cmd68_b2 & cmd68_select))) | (~cmd26_select & i_adc2A_d_2 & (~(i_i2c_cmd68_b2 & cmd68_select))) | (cmd26_select & ~i_adc2A_d_2 & (~(i_i2c_cmd68_b2 & cmd68_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd68_b2 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd68_e2 == 1'b1)   //enable
       begin
        i_i2c_cmd68_b2 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 555, MSLICE 0

  assign net_1134 = (net_973 & ((i2c_send_enable & net_1378)));
  assign net_1131 = (~net_979 & ~i2c_scl & ((net_1134 & ~i2c_state_0000000000000000) | (net_1134 & i2c_state_0000000000000000))) | (net_979 & ~i2c_scl & ((net_1134 & ~i2c_state_0000000000000000) | (net_1134 & i2c_state_0000000000000000))) | (net_979 & i2c_scl & ((net_1134 & ~i2c_state_0000000000000000)));

//---------------------------------------------------------------------------
//Block 556, LSLICE 2

  assign net_1127 = (net_973 & ~i2c_send_enable & ~i2c_state_xxxxxxxx1110xxxx) | (net_973 & ~i2c_send_enable & i2c_state_xxxxxxxx1110xxxx & ((~i2c_state_00000000xxxx1110 & ~i2c_state_00000000xxxx1100)));
  assign sig_556_lut_1 = (~net_1308 & ~net_1215 & ~net_1131) | (~net_1308 & ~net_1215 & net_1131) | (~net_1308 & net_1215 & ~net_1131) | (~net_1308 & net_1215 & net_1131) | (net_1308 & ~net_1215 & ~net_1131 & (~(net_1127 & net_1207))) | (net_1308 & ~net_1215 & net_1131 & ((~net_1127 & ~net_1207) | (net_1127 & ~net_1207))) | (net_1308 & net_1215 & ~net_1131) | (net_1308 & net_1215 & net_1131 & ((~net_1127 & ~net_1207) | (net_1127 & ~net_1207)));

  always @(posedge i2c_clock)
  begin
    if(i2c_disable == 1'b0)   //enable
     begin
      i2c_scl <= sig_556_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 557, LSLICE 3

  assign i2c_cmd69_e4 = ((net_1605 & i2c_state_xxxxxxxx0100xxxx));
  assign net_1126 = (~i2c_state_00000000xxxx1101 & ((i2c_state_xxxxxxxx0100xxxx & i2c_state_00000000xxxx1110))) | (i2c_state_00000000xxxx1101 & ((i2c_state_xxxxxxxx0100xxxx & ~i2c_state_00000000xxxx1110) | (i2c_state_xxxxxxxx0100xxxx & i2c_state_00000000xxxx1110)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd69_b4 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd69_e4 == 1'b1)   //enable
       begin
        i_i2c_cmd69_b4 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 558, MSLICE 1

  assign i2c_cmd6C_e5 = (i2c_state_000000001010xxxx & ((i2c_state_xxxxxxxxxxxx0100 & ~i2c_send_enable)));
  assign net_1132 = (~cmd26_select & ~i_adc2A_d_5 & (~(i_i2c_cmd6C_b5 & cmd6C_select))) | (~cmd26_select & i_adc2A_d_5 & (~(i_i2c_cmd6C_b5 & cmd6C_select))) | (cmd26_select & ~i_adc2A_d_5 & (~(i_i2c_cmd6C_b5 & cmd6C_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6C_b5 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6C_e5 == 1'b1)   //enable
       begin
        i_i2c_cmd6C_b5 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 559, MSLICE 0

  assign i2c_cmd69_e2 = ((~i2c_send_enable & i2c_state_0000000001010000));
  assign net_1137 = (~i2c_state_0000000001001111 & ((~i2c_state_0000000001010000 & ~net_1126)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd69_b2 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd69_e2 == 1'b1)   //enable
       begin
        i_i2c_cmd69_b2 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 560, LSLICE 2

  assign net_1144 = ((o_i2c_cmd6A_b7 & i2c_state_0000000001010111));
  assign net_1141 = ((net_1314 & net_1322));

//---------------------------------------------------------------------------
//Block 561, LSLICE 3

  assign i2c_state_000000001000xxxx = ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxx1000xxxx));
  assign i2c_state_0000000010001110 = ((i2c_state_00000000xxxx1110 & i2c_state_xxxxxxxx1000xxxx));

//---------------------------------------------------------------------------
//Block 562, MSLICE 1

  assign i2c_cmd6B_e3 = ((i2c_state_0000000010001010 & ~i2c_send_enable));
  assign net_1139 = (~i2c_state_xxxxxxxxxxxx1011 & ~i2c_state_0000000010001010 & ((~net_1246 & ~i2c_state_000000001000xxxx) | (~net_1246 & i2c_state_000000001000xxxx))) | (i2c_state_xxxxxxxxxxxx1011 & ~i2c_state_0000000010001010 & ((~net_1246 & ~i2c_state_000000001000xxxx)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6B_b3 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6B_e3 == 1'b1)   //enable
       begin
        i_i2c_cmd6B_b3 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 563, MSLICE 0

  assign i2c_cmd69_e6 = (~i2c_send_enable & ((i2c_state_000000000100xxxx & i2c_state_xxxxxxxxxxxx1000)));
  assign i2c_state_0000000001001111 = ((i2c_state_xxxxxxxxxxxx1111 & i2c_state_000000000100xxxx));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd69_b6 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd69_e6 == 1'b1)   //enable
       begin
        i_i2c_cmd69_b6 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 564, LSLICE 2

  assign net_1149 = (~net_996 & ~i2c_state_0000000001010000 & ~i2c_state_00000000xxxx1110) | (~net_996 & ~i2c_state_0000000001010000 & i2c_state_00000000xxxx1110 & ((~i2c_state_xxxxxxxx1010xxxx & ~i2c_state_xxxxxxxx1101xxxx)));
  assign net_1145 = (~i2c_state_00000000xxxx1001 & ((~net_996 & ~i2c_state_xxxxxxxx1010xxxx) | (~net_996 & i2c_state_xxxxxxxx1010xxxx))) | (i2c_state_00000000xxxx1001 & ((~net_996 & ~i2c_state_xxxxxxxx1010xxxx)));

//---------------------------------------------------------------------------
//Block 565, LSLICE 3

  assign net_1152 = (net_1163 & ~i2c_state_0000000010010000 & ~i2c_state_0000000001010100 & (~(i2c_state_xxxxxxxxxxxx0010 & i2c_state_000000001000xxxx)));
  assign net_1151 = (net_1152 & ~i2c_state_0000000001110100 & ~i2c_state_000000000101xxxx & ((~i2c_state_xxxxxxxxxxxx0010 & ~i2c_state_0000000010001110) | (i2c_state_xxxxxxxxxxxx0010 & ~i2c_state_0000000010001110))) | (net_1152 & ~i2c_state_0000000001110100 & i2c_state_000000000101xxxx & ((~i2c_state_xxxxxxxxxxxx0010 & ~i2c_state_0000000010001110)));

//---------------------------------------------------------------------------
//Block 566, MSLICE 1

  assign sig_566_lut_0 = (~i2c_state_0000000010010011 & ~i2c_state_0000000000010011 & ((~i2c_state_0000000001010000 & ~i2c_state_0000000001010100)));
  assign sig_566_lut_1 = 1'b0;
  assign net_1146 = (~net_1423 & sig_566_lut_0) | (net_1423 & sig_566_lut_1);

//---------------------------------------------------------------------------
//Block 567, MSLICE 0

  assign net_1154 = (i2c_state_000000001100xxxx & ~i2c_state_xxxxxxxxxxxx0100 & ((i2c_state_xxxxxxxxxxxx0000 | i2c_state_xxxxxxxxxxxx0010))) | (i2c_state_000000001100xxxx & i2c_state_xxxxxxxxxxxx0100);
  assign net_1153 = (~i2c_state_xxxxxxxx1101xxxx & ~i2c_state_0000000011001110 & ((~net_1154 & ~i2c_state_00000000xxxx1100) | (~net_1154 & i2c_state_00000000xxxx1100))) | (i2c_state_xxxxxxxx1101xxxx & ~i2c_state_0000000011001110 & ((~net_1154 & ~i2c_state_00000000xxxx1100)));

//---------------------------------------------------------------------------
//Block 568, LSLICE 2

  assign net_1156 = (~i2c_state_000000001010xxxx & ((net_1165 & ~i2c_state_xxxxxxxxxxxx0010) | (net_1165 & i2c_state_xxxxxxxxxxxx0010))) | (i2c_state_000000001010xxxx & ((net_1165 & ~i2c_state_xxxxxxxxxxxx0010)));
  assign net_1157 = ((i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx0000));

//---------------------------------------------------------------------------
//Block 569, LSLICE 3

  assign i2c_cmd6D_e7 = ((i2c_state_0000000010111110 & ~i2c_send_enable));
  assign net_1159 = (~i2c_state_0000000010111110 & ~i2c_state_000000001010xxxx) | (~i2c_state_0000000010111110 & i2c_state_000000001010xxxx & ((~i2c_state_xxxxxxxxxxxx0101 & ~i2c_state_xxxxxxxxxxxx0100)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6D_b7 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6D_e7 == 1'b1)   //enable
       begin
        i_i2c_cmd6D_b7 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 570, MSLICE 1

  assign net_1158 = (~i2c_state_000000001010xxxx & ((net_1145 & ~i2c_state_xxxxxxxxxxxx0111) | (net_1145 & i2c_state_xxxxxxxxxxxx0111))) | (i2c_state_000000001010xxxx & ((net_1145 & ~i2c_state_xxxxxxxxxxxx0111)));
  assign i2c_state_0000000001010111 = ((i2c_state_000000000101xxxx & i2c_state_xxxxxxxxxxxx0111));

//---------------------------------------------------------------------------
//Block 571, MSLICE 0

  assign sig_571_lut_0 = (~i2c_state_000000001000xxxx & ~i2c_state_xxxxxxxxxxxx0110) | (~i2c_state_000000001000xxxx & i2c_state_xxxxxxxxxxxx0110) | (i2c_state_000000001000xxxx & ~i2c_state_xxxxxxxxxxxx0110 & ((~i2c_state_xxxxxxxxxxxx1000 & ~i2c_state_xxxxxxxxxxxx0100)));
  assign sig_571_lut_1 = 1'b0;
  assign net_1165 = (~net_1157 & sig_571_lut_0) | (net_1157 & sig_571_lut_1);

//---------------------------------------------------------------------------
//Block 572, LSLICE 2

  assign i2c_cmd6B_e5 = (i2c_state_xxxxxxxxxxxx0110 & ((i2c_state_000000001000xxxx & ~i2c_send_enable)));
  assign net_1163 = (~i2c_state_000000000101xxxx & ~i2c_state_000000000110xxxx) | (~i2c_state_000000000101xxxx & i2c_state_000000000110xxxx & ((~i2c_state_xxxxxxxxxxxx0100 & ~i2c_state_xxxxxxxxxxxx0110) | (~i2c_state_xxxxxxxxxxxx0100 & i2c_state_xxxxxxxxxxxx0110))) | (i2c_state_000000000101xxxx & ~i2c_state_000000000110xxxx & ((~i2c_state_xxxxxxxxxxxx0100 & ~i2c_state_xxxxxxxxxxxx0110) | (i2c_state_xxxxxxxxxxxx0100 & ~i2c_state_xxxxxxxxxxxx0110))) | (i2c_state_000000000101xxxx & i2c_state_000000000110xxxx & ((~i2c_state_xxxxxxxxxxxx0100 & ~i2c_state_xxxxxxxxxxxx0110)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6B_b5 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6B_e5 == 1'b1)   //enable
       begin
        i_i2c_cmd6B_b5 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 573, LSLICE 3

  assign sig_573_lut_0 = (~cmd6C_write_enable & ~i_mcu_dcs & o_i2c_cmd6C_b1) | (~cmd6C_write_enable & i_mcu_dcs & ~o_i2c_cmd6C_b1 & ((~net_431 & ~io_mcu_d_1) | (~net_431 & io_mcu_d_1))) | (~cmd6C_write_enable & i_mcu_dcs & o_i2c_cmd6C_b1) | (cmd6C_write_enable & ~i_mcu_dcs & ~o_i2c_cmd6C_b1 & ((~net_431 & io_mcu_d_1))) | (cmd6C_write_enable & ~i_mcu_dcs & o_i2c_cmd6C_b1 & ((~net_431 & io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (cmd6C_write_enable & i_mcu_dcs & ~o_i2c_cmd6C_b1 & ((~net_431 & ~io_mcu_d_1) | (~net_431 & io_mcu_d_1))) | (cmd6C_write_enable & i_mcu_dcs & o_i2c_cmd6C_b1);
  assign net_1166 = (~o_i2c_cmd6B_b3 & ~net_1241 & ~o_i2c_cmd6C_b1) | (~o_i2c_cmd6B_b3 & ~net_1241 & o_i2c_cmd6C_b1) | (~o_i2c_cmd6B_b3 & net_1241 & ~o_i2c_cmd6C_b1) | (o_i2c_cmd6B_b3 & ~net_1241 & ~o_i2c_cmd6C_b1 & (~(i2c_state_000000001000xxxx & i2c_state_xxxxxxxxxxxx1001))) | (o_i2c_cmd6B_b3 & ~net_1241 & o_i2c_cmd6C_b1 & (~(i2c_state_000000001000xxxx & i2c_state_xxxxxxxxxxxx1001))) | (o_i2c_cmd6B_b3 & net_1241 & ~o_i2c_cmd6C_b1 & (~(i2c_state_000000001000xxxx & i2c_state_xxxxxxxxxxxx1001)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6C_b1 <= sig_573_lut_0;
  end

//---------------------------------------------------------------------------
//Block 574, MSLICE 1

  assign sig_574_lut_0 = (i2c_state_000000001110xxxx & ~i2c_state_000000001010xxxx & ((i2c_state_xxxxxxxxxxxx0010 | i2c_state_xxxxxxxxxxxx0000))) | (i2c_state_000000001110xxxx & i2c_state_000000001010xxxx & ((i2c_state_xxxxxxxxxxxx0010 | i2c_state_xxxxxxxxxxxx0000)));
  assign sig_574_lut_1 = (~i2c_state_000000001110xxxx & ~i2c_state_xxxxxxxxxxxx0000 & ((~i2c_state_xxxxxxxxxxxx0010 & i2c_state_000000001010xxxx) | (i2c_state_xxxxxxxxxxxx0010 & i2c_state_000000001010xxxx))) | (~i2c_state_000000001110xxxx & i2c_state_xxxxxxxxxxxx0000 & ((~i2c_state_xxxxxxxxxxxx0010 & i2c_state_000000001010xxxx) | (i2c_state_xxxxxxxxxxxx0010 & i2c_state_000000001010xxxx))) | (i2c_state_000000001110xxxx & ~i2c_state_xxxxxxxxxxxx0000) | (i2c_state_000000001110xxxx & i2c_state_xxxxxxxxxxxx0000);
  assign net_1168 = (~i2c_state_xxxxxxxxxxxx0100 & sig_574_lut_0) | (i2c_state_xxxxxxxxxxxx0100 & sig_574_lut_1);

//---------------------------------------------------------------------------
//Block 575, MSLICE 0

  assign i2c_cmd6E_e4 = (i2c_state_000000001110xxxx & ((i2c_state_xxxxxxxxxxxx0010 & ~i2c_send_enable)));
  assign i2c_state_0000000011101111 = ((i2c_state_000000001110xxxx & i2c_state_xxxxxxxxxxxx1111));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6E_b4 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6E_e4 == 1'b1)   //enable
       begin
        i_i2c_cmd6E_b4 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 576, MSLICE 0

  assign sig_576_lut_0 = (cmd6C_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_4) | (net_431 & io_mcu_d_4)));
  assign sig_576_lut_1 = (~cmd6C_write_enable & ~i_mcu_dcs) | (~cmd6C_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_4) | (net_431 & io_mcu_d_4))) | (cmd6C_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_4))) | (cmd6C_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_4) | (net_431 & io_mcu_d_4)));
  assign sig_576_ff0_d = (~o_i2c_cmd6C_b4 & sig_576_lut_0) | (o_i2c_cmd6C_b4 & sig_576_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6C_b4 <= sig_576_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 577, LSLICE 2

  assign sig_577_lut_0 = (~o_i2c_cmd6C_b3 & cmd6C_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd6C_b3 & ~cmd6C_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6C_b3 & ~cmd6C_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd6C_b3 & cmd6C_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_3))) | (o_i2c_cmd6C_b3 & cmd6C_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3)));
  assign net_1172 = (i2c_state_xxxxxxxxxxxx0111 & ((i2c_state_000000001010xxxx & o_i2c_cmd6C_b3)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6C_b3 <= sig_577_lut_0;
  end

//---------------------------------------------------------------------------
//Block 578, LSLICE 3

  assign sig_578_lut_0 = (~o_i2c_cmd6D_b1 & cmd6D_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (o_i2c_cmd6D_b1 & ~cmd6D_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6D_b1 & ~cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (o_i2c_cmd6D_b1 & cmd6D_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_1))) | (o_i2c_cmd6D_b1 & cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_1) | (net_431 & io_mcu_d_1)));
  assign net_1173 = (i2c_state_xxxxxxxxxxxx1001 & ((i2c_state_000000001100xxxx & o_i2c_cmd6D_b1)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6D_b1 <= sig_578_lut_0;
  end

//---------------------------------------------------------------------------
//Block 579, MSLICE 0

  assign sig_579_lut_0 = (~state_b2 & ~net_477 & ((~i_mcu_dcs & ~net_1183))) | (~state_b2 & net_477 & ((~i_mcu_dcs & ~net_1183))) | (state_b2 & ~net_477 & ((~i_mcu_dcs & ~net_1183))) | (state_b2 & net_477);
  assign sig_579_lut_1 = (~state_b1 & ~net_477 & ((~i_mcu_dcs & ~net_1255))) | (~state_b1 & net_477 & ((~i_mcu_dcs & ~net_1255))) | (state_b1 & ~net_477 & ((~i_mcu_dcs & ~net_1255))) | (state_b1 & net_477);

  always @(posedge i_mcu_clk)
  begin
    state_b2 <= sig_579_lut_0;
    state_b1 <= sig_579_lut_1;
  end

//---------------------------------------------------------------------------
//Block 580, LSLICE 2

  assign sig_580_lut_0 = (~o_i2c_cmd6B_b0 & cmd6B_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (o_i2c_cmd6B_b0 & ~cmd6B_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6B_b0 & ~cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (o_i2c_cmd6B_b0 & cmd6B_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_0))) | (o_i2c_cmd6B_b0 & cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_0) | (net_431 & io_mcu_d_0)));
  assign sig_580_lut_1 = (~cmd6B_write_enable & ~i_mcu_dcs & o_i2c_cmd6B_b1) | (~cmd6B_write_enable & i_mcu_dcs & ~o_i2c_cmd6B_b1 & ((~net_431 & ~io_mcu_d_1) | (~net_431 & io_mcu_d_1))) | (~cmd6B_write_enable & i_mcu_dcs & o_i2c_cmd6B_b1) | (cmd6B_write_enable & ~i_mcu_dcs & ~o_i2c_cmd6B_b1 & ((~net_431 & io_mcu_d_1))) | (cmd6B_write_enable & ~i_mcu_dcs & o_i2c_cmd6B_b1 & ((~net_431 & io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (cmd6B_write_enable & i_mcu_dcs & ~o_i2c_cmd6B_b1 & ((~net_431 & ~io_mcu_d_1) | (~net_431 & io_mcu_d_1))) | (cmd6B_write_enable & i_mcu_dcs & o_i2c_cmd6B_b1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6B_b0 <= sig_580_lut_0;
    o_i2c_cmd6B_b1 <= sig_580_lut_1;
  end

//---------------------------------------------------------------------------
//Block 581, LSLICE 3

  assign net_1179 = (~i_mcu_rws & ~state_sum_b0 & ~net_569) | (~i_mcu_rws & ~state_sum_b0 & net_569) | (~i_mcu_rws & state_sum_b0 & ~net_569 & ((~net_482 & ~state_b0) | (~net_482 & state_b0))) | (~i_mcu_rws & state_sum_b0 & net_569 & ((~net_482 & ~state_b0) | (~net_482 & state_b0))) | (i_mcu_rws & ~state_sum_b0 & ~net_569) | (i_mcu_rws & ~state_sum_b0 & net_569 & ((~net_482 & ~state_b0) | (net_482 & ~state_b0))) | (i_mcu_rws & state_sum_b0 & net_569 & ((~net_482 & ~state_b0)));
  assign sig_581_lut_1 = (~net_477 & ~i_mcu_dcs & ((~state_b0 & ~net_1179) | (state_b0 & ~net_1179))) | (net_477 & ~i_mcu_dcs & (~(~state_b0 & net_1179))) | (net_477 & i_mcu_dcs & ((state_b0 & ~net_1179) | (state_b0 & net_1179)));

  always @(posedge i_mcu_clk)
  begin
    state_b0 <= sig_581_lut_1;
  end

//---------------------------------------------------------------------------
//Block 582, MSLICE 1

  assign sig_582_lut_0 = (~state_sum_b2 & ~net_569) | (~state_sum_b2 & net_569) | (state_sum_b2 & ~net_569 & ((~net_482 & ~state_b2) | (~net_482 & state_b2))) | (state_sum_b2 & net_569 & ((~net_482 & ~state_b2) | (~net_482 & state_b2)));
  assign sig_582_lut_1 = (~state_sum_b2 & ~net_569) | (~state_sum_b2 & net_569 & ((~net_482 & ~state_b2) | (net_482 & ~state_b2))) | (state_sum_b2 & net_569 & ((~net_482 & ~state_b2)));
  assign net_1183 = (~i_mcu_rws & sig_582_lut_0) | (i_mcu_rws & sig_582_lut_1);

//---------------------------------------------------------------------------
//Block 583, LSLICE 2

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg8 <= 1'b0;
      time_base_cnt_reg18 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg8 <= time_base_cnt_out8;
      time_base_cnt_reg18 <= time_base_cnt_out18;
    end
  end

//---------------------------------------------------------------------------
//Block 584, MSLICE 1

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg6 <= 1'b0;
      time_base_cnt_reg21 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg6 <= time_base_cnt_out6;
      time_base_cnt_reg21 <= time_base_cnt_out21;
    end
  end

//---------------------------------------------------------------------------
//Block 585, LSLICE 3

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg9 <= 1'b0;
      time_base_cnt_reg17 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg9 <= time_base_cnt_out9;
      time_base_cnt_reg17 <= time_base_cnt_out17;
    end
  end

//---------------------------------------------------------------------------
//Block 586, MSLICE 0

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg30 <= 1'b0;
      time_base_cnt_reg22 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg30 <= time_base_cnt_out30;
      time_base_cnt_reg22 <= time_base_cnt_out22;
    end
  end

//---------------------------------------------------------------------------
//Block 587, LSLICE 3

  always @(posedge sample_write_clock)
  begin
    if(sampling_reset == 1'b1)   //reset
    begin
      time_base_cnt_reg26 <= 1'b0;
      time_base_cnt_reg25 <= 1'b0;
    end
    else
    begin
      time_base_cnt_reg26 <= time_base_cnt_out26;
      time_base_cnt_reg25 <= time_base_cnt_out25;
    end
  end

//---------------------------------------------------------------------------
//Block 588, LSLICE 2

  assign calib_1KHz_g = (calib_1KHz_h & ~calib_1KHz_r28 & ~calib_1KHz_r27 & ((~calib_1KHz_r26 & ~calib_1KHz_r25)));
  assign calib_1KHz_h = (~calib_1KHz_r23 & ~calib_1KHz_r24 & ((~calib_1KHz_r21 & ~calib_1KHz_r22)));

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r25 <= 1'b0;
      calib_1KHz_r21 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r25 <= calib_1KHz_c25;
      calib_1KHz_r21 <= calib_1KHz_c21;
    end
  end

//---------------------------------------------------------------------------
//Block 589, LSLICE 3

  assign clk_a_div_c = (clk_a_div_b & ~clk_a_div_reg9 & ~clk_a_div_reg8 & ((~clk_a_div_reg7 & ~clk_a_div_reg6)));
  assign clk_a_reset = (~(clk_a_div_d & clk_a_div_c));

  always @(posedge clock_200MHz)
  begin
    if(clk_a_reset == 1'b1)   //reset
    begin
      clk_a_div_reg6 <= 1'b0;
      clk_a_div_reg13 <= 1'b0;
    end
    else
    begin
      clk_a_div_reg6 <= clk_a_div_out6;
      clk_a_div_reg13 <= clk_a_div_out13;
    end
  end

//---------------------------------------------------------------------------
//Block 590, LSLICE 2

  assign i2c_cmd6D_e1 = (i2c_state_00000000xxxx1010 & ((i2c_state_xxxxxxxx1100xxxx & ~i2c_send_enable)));
  assign net_1202 = (~i_adc2B_d_1 & ~cmd27_select & (~(i_i2c_cmd6D_b1 & cmd6D_select))) | (~i_adc2B_d_1 & cmd27_select & (~(i_i2c_cmd6D_b1 & cmd6D_select))) | (i_adc2B_d_1 & ~cmd27_select & (~(i_i2c_cmd6D_b1 & cmd6D_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6D_b1 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6D_e1 == 1'b1)   //enable
       begin
        i_i2c_cmd6D_b1 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 591, LSLICE 3

  assign i2c_state_0000000010001010 = ((i2c_state_00000000xxxx1010 & i2c_state_xxxxxxxx1000xxxx));
  assign net_1206 = ((i2c_state_xxxxxxxx1000xxxx & ~i2s_state_unknown_a));

//---------------------------------------------------------------------------
//Block 592, LSLICE 3

  assign net_1210 = (net_1149 & ~net_1168 & ~i2c_state_000000000011xxxx) | (net_1149 & ~net_1168 & i2c_state_000000000011xxxx & ((~i2c_state_xxxxxxxxxxxx0010 & ~i2c_state_xxxxxxxxxxxx0000)));
  assign net_1207 = (net_1208 & net_1210 & ~i2c_state_xxxxxxxx0100xxxx & ((net_1156 & ~net_1305) | (net_1156 & net_1305))) | (net_1208 & net_1210 & i2c_state_xxxxxxxx0100xxxx & ((net_1156 & net_1305)));

//---------------------------------------------------------------------------
//Block 593, MSLICE 0

  assign sig_593_lut_0 = (net_1151 & ~net_1206 & ((~i2c_state_000000000x1011x0 & ~net_1311)));
  assign sig_593_lut_1 = 1'b0;
  assign net_1208 = (~net_1303 & sig_593_lut_0) | (net_1303 & sig_593_lut_1);

//---------------------------------------------------------------------------
//Block 594, MSLICE 1

  assign sig_594_lut_0 = 1'b0;
  assign sig_594_lut_1 = (~net_1126 & net_1325 & ((net_1313 & ~net_1206)));
  assign net_1209 = (~net_1146 & sig_594_lut_0) | (net_1146 & sig_594_lut_1);

//---------------------------------------------------------------------------
//Block 595, MSLICE 0

  assign sig_595_lut_0 = (~i2c_state_0000000001001111 & ~i2c_state_00000000xxxx1110) | (~i2c_state_0000000001001111 & i2c_state_00000000xxxx1110 & ((~i2c_state_xxxxxxxx1110xxxx & ~i2c_state_xxxxxxxx1000xxxx)));
  assign sig_595_lut_1 = 1'b0;
  assign net_1214 = (~i2c_state_xxxxxxxx00010010 & sig_595_lut_0) | (i2c_state_xxxxxxxx00010010 & sig_595_lut_1);

//---------------------------------------------------------------------------
//Block 596, LSLICE 2

  assign i2c_cmd6C_e2 = (i2c_state_xxxxxxxx1010xxxx & ((~i2c_send_enable & i2c_state_00000000xxxx1010)));
  assign net_1213 = (~i2c_state_xxxxxxxx1010xxxx & ((~net_1241 & ~i2c_state_00000000xxxx1010) | (~net_1241 & i2c_state_00000000xxxx1010))) | (i2c_state_xxxxxxxx1010xxxx & ((~net_1241 & ~i2c_state_00000000xxxx1010)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6C_b2 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6C_e2 == 1'b1)   //enable
       begin
        i_i2c_cmd6C_b2 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 597, MSLICE 1

  assign net_1215 = (i2c_scl & ~i2c_state_0000000000000000 & ((net_1211 | i2c_state_0000000011101111))) | (i2c_scl & i2c_state_0000000000000000);
  assign net_1211 = ((net_1322 & net_1314));

//---------------------------------------------------------------------------
//Block 598, LSLICE 3

  assign net_1218 = (net_1383 & net_1209 & net_1236 & ((net_1217 & ~net_1211)));
  assign net_1217 = (net_1238 & net_1398 & ((~i2c_state_0000000000101xxx & net_1230)));

//---------------------------------------------------------------------------
//Block 599, MSLICE 0

  assign net_1220 = (~net_1309 & net_1374 & ((net_993 & ~net_1303)));
  assign net_1226 = ((~i2c_state_0000000000010011 & ~i2c_state_0000000000101xxx));

//---------------------------------------------------------------------------
//Block 600, LSLICE 3

  assign sig_600_lut_0 = ~adc2_encB;
  assign net_1227 = ((~net_1301 & i2c_state_xxxxxxxx0000xxxx));

  always @(negedge clock_200MHz)
  begin
    if(smp_clk_enable == 1'b1)   //enable
     begin
      adc2_encB <= sig_600_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 601, LSLICE 2

  assign net_1222 = (net_1383 & net_1239 & net_1220 & ((net_1224 & net_1226)));
  assign net_1224 = (net_1245 & net_1145 & net_1304 & ((~i2c_state_00000000101011xx & net_1326)));

//---------------------------------------------------------------------------
//Block 602, MSLICE 1

  assign i2c_cmd6B_e1 = ((~i2c_send_enable & i2c_state_0000000010001110));
  assign net_1221 = (~i2c_state_000000001000xxxx & ~i2c_state_0000000010001110 & ((~i2c_state_xxxxxxxxxxxx0111 & ~net_1388) | (i2c_state_xxxxxxxxxxxx0111 & ~net_1388))) | (i2c_state_000000001000xxxx & ~i2c_state_0000000010001110 & ((~i2c_state_xxxxxxxxxxxx0111 & ~net_1388)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6B_b1 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd6B_e1 == 1'b1)   //enable
       begin
        i_i2c_cmd6B_b1 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 603, MSLICE 0

  assign i2c_cmd68_e3 = (~i2c_send_enable & ((i2c_state_xxxxxxxxxxxx0000 & i2c_state_000000000011xxxx)));
  assign i2c_state_0000000001010000 = ((i2c_state_000000000101xxxx & i2c_state_xxxxxxxxxxxx0000));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd68_b3 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd68_e3 == 1'b1)   //enable
       begin
        i_i2c_cmd68_b3 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 604, LSLICE 2

  assign net_1228 = (~i2c_state_0000000011001110 & ~i2c_state_xxxxxxxxxxxx1111 & ~i2c_state_000000001100xxxx & (~(i2c_state_xxxxxxxxxxxx1000 & i2c_state_000000000100xxxx))) | (~i2c_state_0000000011001110 & ~i2c_state_xxxxxxxxxxxx1111 & i2c_state_000000001100xxxx & (~(i2c_state_xxxxxxxxxxxx1000 & i2c_state_000000000100xxxx))) | (~i2c_state_0000000011001110 & i2c_state_xxxxxxxxxxxx1111 & ~i2c_state_000000001100xxxx & (~(i2c_state_xxxxxxxxxxxx1000 & i2c_state_000000000100xxxx)));
  assign net_1230 = (net_1163 & net_1228 & ((~net_1309 & net_1234)));

//---------------------------------------------------------------------------
//Block 605, LSLICE 3

  assign net_1234 = (net_1330 & ~i2c_state_0000000001110100 & ~i2c_state_0000000001010111 & (~(i2c_state_xxxxxxxxxxxx0110 & i2c_state_000000000100xxxx)));
  assign i2c_state_0000000001110100 = ((i2c_state_xxxxxxxxxxxx0100 & i2c_state_000000000111xxxx));

//---------------------------------------------------------------------------
//Block 606, LSLICE 2

  assign net_1239 = (~net_1386 & net_1000 & ~i2c_state_000000001100xxxx) | (~net_1386 & net_1000 & i2c_state_000000001100xxxx & ((~i2c_state_xxxxxxxxxxxx0100 & ~i2c_state_xxxxxxxxxxxx0101)));
  assign net_1237 = (~net_1386 & ~net_1409 & (~(i2c_state_000000001100xxxx & i2c_state_xxxxxxxxxxxx0010)));

//---------------------------------------------------------------------------
//Block 607, LSLICE 3

  assign net_1235 = (i2c_state_000000001010xxxx & ((i2c_state_xxxxxxxxxxxx0011 & o_i2c_cmd6C_b5)));
  assign net_1241 = ((i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx1011));

//---------------------------------------------------------------------------
//Block 608, MSLICE 0

  assign sig_608_lut_0 = 1'b0;
  assign sig_608_lut_1 = (net_1159 & ~i2c_state_0000000010110001 & ((~net_1334 & ~i2c_state_0000000010010000)));
  assign net_1238 = (~net_1158 & sig_608_lut_0) | (net_1158 & sig_608_lut_1);

//---------------------------------------------------------------------------
//Block 609, MSLICE 1

  assign i2c_state_0000000000101001 = ((i2c_state_xxxxxxxxxxxx1001 & i2c_state_000000000010xxxx));
  assign net_1236 = (net_1331 & ((net_1000 & ~net_1316)));

//---------------------------------------------------------------------------
//Block 610, MSLICE 0

  assign net_1246 = (i2c_state_000000001000xxxx & ((i2c_state_xxxxxxxxxxxx1001 | i2c_state_xxxxxxxxxxxx0101)));
  assign net_1244 = (o_i2c_cmd6B_b5 & ((i2c_state_000000001000xxxx & i2c_state_xxxxxxxxxxxx0101)));

//---------------------------------------------------------------------------
//Block 611, LSLICE 2

  assign net_1243 = (~net_1144 & ~i2c_out_cmd68_b2 & ~net_1516 & (~(o_i2c_cmd68_b6 & i2c_state_0000000000101001)));
  assign net_1242 = (net_1243 & net_1340 & net_1599 & ((net_1248 & net_1247)));

//---------------------------------------------------------------------------
//Block 612, MSLICE 1

  assign sig_612_lut_0 = (net_1336 & ~i2c_state_000000001100xxxx) | (net_1336 & i2c_state_000000001100xxxx & ((~i2c_state_xxxxxxxxxxxx1001 & ~i2c_state_xxxxxxxxxxxx0111)));
  assign sig_612_lut_1 = 1'b0;
  assign net_1245 = (~i2c_state_195_203 & sig_612_lut_0) | (i2c_state_195_203 & sig_612_lut_1);

//---------------------------------------------------------------------------
//Block 613, MSLICE 0

  assign sig_613_lut_0 = (cmd6D_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_5) | (net_431 & io_mcu_d_5)));
  assign sig_613_lut_1 = (~cmd6D_write_enable & ~io_mcu_d_5 & (~(~net_431 & i_mcu_dcs))) | (~cmd6D_write_enable & io_mcu_d_5 & (~(~net_431 & i_mcu_dcs))) | (cmd6D_write_enable & ~io_mcu_d_5 & ((net_431 & ~i_mcu_dcs) | (net_431 & i_mcu_dcs))) | (cmd6D_write_enable & io_mcu_d_5 & (~(~net_431 & i_mcu_dcs)));
  assign sig_613_ff0_d = (~o_i2c_cmd6D_b5 & sig_613_lut_0) | (o_i2c_cmd6D_b5 & sig_613_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6D_b5 <= sig_613_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 614, LSLICE 3

  assign net_1251 = (net_1335 & ~net_1592 & ~o_i2c_cmd69_b4) | (net_1335 & ~net_1592 & o_i2c_cmd69_b4 & (~(i2c_state_xxxxxxxxxxxx1011 & i2c_state_000000000100xxxx)));
  assign net_1248 = (net_829 & ~o_i2c_cmd6B_b1 & net_1429 & ((net_1251 & ~net_1422) | (net_1251 & net_1422))) | (net_829 & o_i2c_cmd6B_b1 & net_1429 & ((net_1251 & ~net_1422)));

//---------------------------------------------------------------------------
//Block 615, LSLICE 2

  assign net_1247 = (net_1166 & net_1250 & net_1512 & ((~net_1509 & ~net_823)));
  assign net_1250 = (~net_1012 & ~i2c_state_xxxxxxxxxxxx1001 & ((net_1249 & net_1507))) | (net_1012 & ~i2c_state_xxxxxxxxxxxx1001 & ((net_1249 & net_1507))) | (net_1012 & i2c_state_xxxxxxxxxxxx1001 & ((net_1249 & net_1507)));

//---------------------------------------------------------------------------
//Block 616, MSLICE 1

  assign net_1252 = (o_i2c_cmd6C_b4 & ((i2c_state_xxxxxxxxxxxx0101 & i2c_state_000000001010xxxx)));
  assign net_1249 = (~net_1252 & ~i2c_out_cmd6E_b6 & (~(~net_1343 & i2c_state_000000001100xxxx)));

//---------------------------------------------------------------------------
//Block 617, LSLICE 2

  assign sig_617_lut_0 = (~o_i2c_cmd6C_b7 & cmd6C_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_7) | (net_431 & io_mcu_d_7))) | (o_i2c_cmd6C_b7 & ~cmd6C_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6C_b7 & ~cmd6C_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_7) | (net_431 & io_mcu_d_7))) | (o_i2c_cmd6C_b7 & cmd6C_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_7))) | (o_i2c_cmd6C_b7 & cmd6C_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_7) | (net_431 & io_mcu_d_7)));
  assign net_1254 = (~net_1244 & ~net_1419 & ~net_1235 & (~(o_i2c_cmd6C_b7 & i2c_state_0000000010010011)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6C_b7 <= sig_617_lut_0;
  end

//---------------------------------------------------------------------------
//Block 618, MSLICE 1

  assign sig_618_lut_0 = (~state_sum_b1 & ~net_569) | (~state_sum_b1 & net_569) | (state_sum_b1 & ~net_569 & ((~net_482 & ~state_b1) | (~net_482 & state_b1))) | (state_sum_b1 & net_569 & ((~net_482 & ~state_b1) | (~net_482 & state_b1)));
  assign sig_618_lut_1 = (~state_sum_b1 & ~net_569) | (~state_sum_b1 & net_569 & ((~net_482 & ~state_b1) | (net_482 & ~state_b1))) | (state_sum_b1 & net_569 & ((~net_482 & ~state_b1)));
  assign net_1255 = (~i_mcu_rws & sig_618_lut_0) | (i_mcu_rws & sig_618_lut_1);

//---------------------------------------------------------------------------
//Block 619, LSLICE 3

  assign sig_619_lut_0 = (~o_i2c_cmd6E_b7 & cmd6E_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_7) | (net_431 & io_mcu_d_7))) | (o_i2c_cmd6E_b7 & ~cmd6E_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6E_b7 & ~cmd6E_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_7) | (net_431 & io_mcu_d_7))) | (o_i2c_cmd6E_b7 & cmd6E_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_7))) | (o_i2c_cmd6E_b7 & cmd6E_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_7) | (net_431 & io_mcu_d_7)));
  assign sig_619_lut_1 = (~cmd6E_write_enable & o_i2c_cmd6E_b4 & ~i_mcu_dcs) | (~cmd6E_write_enable & o_i2c_cmd6E_b4 & i_mcu_dcs & ((net_431 & ~io_mcu_d_4) | (net_431 & io_mcu_d_4))) | (cmd6E_write_enable & ~o_i2c_cmd6E_b4 & ~i_mcu_dcs & ((~net_431 & io_mcu_d_4) | (net_431 & io_mcu_d_4))) | (cmd6E_write_enable & o_i2c_cmd6E_b4 & ~i_mcu_dcs & ((net_431 | io_mcu_d_4))) | (cmd6E_write_enable & o_i2c_cmd6E_b4 & i_mcu_dcs & ((net_431 & ~io_mcu_d_4) | (net_431 & io_mcu_d_4)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6E_b7 <= sig_619_lut_0;
    o_i2c_cmd6E_b4 <= sig_619_lut_1;
  end

//---------------------------------------------------------------------------
//Block 620, LSLICE 2

  assign net_1260 = (~i_mcu_rws & ~state_sum_b3 & ~net_569) | (~i_mcu_rws & ~state_sum_b3 & net_569) | (~i_mcu_rws & state_sum_b3 & ~net_569 & ((~net_482 & ~state_b3) | (~net_482 & state_b3))) | (~i_mcu_rws & state_sum_b3 & net_569 & ((~net_482 & ~state_b3) | (~net_482 & state_b3))) | (i_mcu_rws & ~state_sum_b3 & ~net_569) | (i_mcu_rws & ~state_sum_b3 & net_569 & ((~net_482 & ~state_b3) | (net_482 & ~state_b3))) | (i_mcu_rws & state_sum_b3 & net_569 & ((~net_482 & ~state_b3)));
  assign sig_620_lut_1 = (~net_477 & ~net_1260 & ((~i_mcu_dcs & ~state_b3) | (~i_mcu_dcs & state_b3))) | (net_477 & ~net_1260 & (~(i_mcu_dcs & ~state_b3))) | (net_477 & net_1260 & ((~i_mcu_dcs & state_b3) | (i_mcu_dcs & state_b3)));

  always @(posedge i_mcu_clk)
  begin
    state_b3 <= sig_620_lut_1;
  end

//---------------------------------------------------------------------------
//Block 625, LSLICE 2

  always @(posedge clk_50MHz)
  begin
    if(calib_1KHz_rst == 1'b1)   //reset
    begin
      calib_1KHz_r30 <= 1'b0;
    end
    else
    begin
      calib_1KHz_r30 <= calib_1KHz_c30;
    end
  end

//---------------------------------------------------------------------------
//Block 626, LSLICE 3

  assign clk_a_div_d = (clk_a_div_a & ~clk_a_div_reg15 & ~clk_a_div_reg14 & ((~clk_a_div_reg13 & ~clk_a_div_reg12)));
  assign clk_a_div_a = (~clk_a_div_reg1 & ~clk_a_div_reg10 & ((~clk_a_div_reg11 & ~clk_a_div_reg0)));

  always @(posedge clock_200MHz)
  begin
    if(clk_a_reset == 1'b1)   //reset
    begin
      clk_a_div_reg14 <= 1'b0;
      clk_a_div_reg5 <= 1'b0;
    end
    else
    begin
      clk_a_div_reg14 <= clk_a_div_out14;
      clk_a_div_reg5 <= clk_a_div_out5;
    end
  end

//---------------------------------------------------------------------------
//Block 627, LSLICE 2

  always @(posedge clock_200MHz)
  begin
    if(clk_a_reset == 1'b1)   //reset
    begin
      clk_a_div_reg0 <= 1'b0;
      clk_a_div_reg1 <= 1'b0;
    end
    else
    begin
      clk_a_div_reg0 <= clk_a_div_out0;
      clk_a_div_reg1 <= clk_a_div_out1;
    end
  end

//---------------------------------------------------------------------------
//Block 628, LSLICE 3

  always @(posedge clock_200MHz)
  begin
    if(clk_a_reset == 1'b1)   //reset
    begin
      clk_a_div_reg3 <= 1'b0;
      clk_a_div_reg4 <= 1'b0;
    end
    else
    begin
      clk_a_div_reg3 <= clk_a_div_out3;
      clk_a_div_reg4 <= clk_a_div_out4;
    end
  end

//---------------------------------------------------------------------------
//Block 630, LSLICE 2

  always @(posedge clock_200MHz)
  begin
    if(clk_a_reset == 1'b1)   //reset
    begin
      clk_a_div_reg10 <= 1'b0;
      clk_a_div_reg7 <= 1'b0;
    end
    else
    begin
      clk_a_div_reg10 <= clk_a_div_out10;
      clk_a_div_reg7 <= clk_a_div_out7;
    end
  end

//---------------------------------------------------------------------------
//Block 631, LSLICE 3

  always @(posedge clock_200MHz)
  begin
    if(clk_a_reset == 1'b1)   //reset
    begin
      clk_a_div_reg11 <= 1'b0;
      clk_a_div_reg12 <= 1'b0;
    end
    else
    begin
      clk_a_div_reg11 <= clk_a_div_out11;
      clk_a_div_reg12 <= clk_a_div_out12;
    end
  end

//---------------------------------------------------------------------------
//Block 632, LSLICE 2

  always @(posedge clock_200MHz)
  begin
    if(clk_a_reset == 1'b1)   //reset
    begin
      clk_a_div_reg15 <= 1'b0;
      clk_a_div_reg8 <= 1'b0;
    end
    else
    begin
      clk_a_div_reg15 <= clk_a_div_out15;
      clk_a_div_reg8 <= clk_a_div_out8;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 627, 628, 630, 631, 632

  assign { clk_a_div_out15, clk_a_div_out14, clk_a_div_out13, clk_a_div_out12, clk_a_div_out11, clk_a_div_out10, clk_a_div_out9, clk_a_div_out8, clk_a_div_out7, clk_a_div_out6, clk_a_div_out5, clk_a_div_out4, clk_a_div_out3, clk_a_div_out2, clk_a_div_out1, clk_a_div_out0 } = { clk_a_div_reg15, clk_a_div_reg14, clk_a_div_reg13, clk_a_div_reg12, clk_a_div_reg11, clk_a_div_reg10, clk_a_div_reg9, clk_a_div_reg8, clk_a_div_reg7, clk_a_div_reg6, clk_a_div_reg5, clk_a_div_reg4, clk_a_div_reg3, clk_a_div_reg2, clk_a_div_reg1, clk_a_div_reg0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 629, MSLICE 0

  always @(posedge clock_200MHz)
  begin
    if(clk_a_reset == 1'b1)   //reset
    begin
      clk_a_div_reg9 <= 1'b0;
    end
    else
    begin
      clk_a_div_reg9 <= clk_a_div_out9;
    end
  end

//---------------------------------------------------------------------------
//Block 633, LSLICE 3

  assign i2c_cmd6E_e0 = ((i2c_state_0000000011101010 & ~i2c_send_enable));
  assign net_1297 = (~i2c_session_done & ~cmd67_select & (~(i_i2c_cmd6E_b0 & cmd6E_select))) | (~i2c_session_done & cmd67_select & (~(i_i2c_cmd6E_b0 & cmd6E_select))) | (i2c_session_done & ~cmd67_select & (~(i_i2c_cmd6E_b0 & cmd6E_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6E_b0 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd6E_e0 == 1'b1)   //enable
       begin
        i_i2c_cmd6E_b0 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 634, MSLICE 1

  assign i2c_cmd68_e6 = (~i2c_send_enable & ((i2c_state_00000000xxxx1010 & i2c_state_xxxxxxxx0010xxxx)));
  assign net_1293 = (~i2c_state_xxxxxxxx0010xxxx & ((~i2c_state_xxxxxxxx0110xxxx & ~i2c_state_00000000xxxx1010) | (~i2c_state_xxxxxxxx0110xxxx & i2c_state_00000000xxxx1010))) | (i2c_state_xxxxxxxx0010xxxx & ((~i2c_state_xxxxxxxx0110xxxx & ~i2c_state_00000000xxxx1010)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd68_b6 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd68_e6 == 1'b1)   //enable
       begin
        i_i2c_cmd68_b6 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 635, MSLICE 0

  assign net_1299 = (~i2c_state_00000000xxxx1100 & ((i2c_state_00000000xxxx1101 & i2c_state_xxxxxxxx1000xxxx))) | (i2c_state_00000000xxxx1100 & ((~i2c_state_00000000xxxx1101 & i2c_state_xxxxxxxx1000xxxx) | (i2c_state_00000000xxxx1101 & i2c_state_xxxxxxxx1000xxxx)));
  assign i2c_out_cmd6E_b6 = (i2c_state_xxxxxxxx1101xxxx & ((o_i2c_cmd6E_b6 & i2c_state_00000000xxxx1101)));

//---------------------------------------------------------------------------
//Block 636, LSLICE 2

  assign net_1305 = (~i2c_state_00000000xxxx1110 & ((~i2c_state_00000000xxxx1100 & net_1301)));
  assign net_1301 = ((~i2c_state_00000000xxxx1010 & ~i2c_state_00000000xxxx1000));

//---------------------------------------------------------------------------
//Block 637, LSLICE 3

  assign i2c_state_000000001010xxxx = ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxx1010xxxx));
  assign net_1303 = ((i2c_state_xxxxxxxx1010xxxx & ~i2s_state_unknown_a));

//---------------------------------------------------------------------------
//Block 638, MSLICE 1

  assign net_1306 = (~i2c_state_198_200 & ~net_1496 & (~(i2c_state_xxxxxxxx1100xxxx & i2c_state_00000000xxxx1010)));
  assign net_1304 = (~i2s_state_unknown_a & ((~i2c_state_xxxxxxxx1100xxxx & ~i2c_state_198_200))) | (i2s_state_unknown_a & ((~i2c_state_xxxxxxxx1100xxxx & ~i2c_state_198_200) | (i2c_state_xxxxxxxx1100xxxx & ~i2c_state_198_200)));

//---------------------------------------------------------------------------
//Block 639, MSLICE 0

  assign sig_639_lut_0 = 1'b0;
  assign sig_639_lut_1 = (net_1368 & net_1401 & (~(~net_1301 & i2c_state_xxxxxxxx1110xxxx)));
  assign net_1308 = (~net_993 & sig_639_lut_0) | (net_993 & sig_639_lut_1);

//---------------------------------------------------------------------------
//Block 640, LSLICE 2

  assign i2c_state_00000000xxxx1101 = ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxxxxxx1101));
  assign net_1309 = (~i2c_state_00000000xxxx1100 & ((i2c_state_00000000xxxx1101 & i2c_state_xxxxxxxx1101xxxx))) | (i2c_state_00000000xxxx1100 & ((~i2c_state_00000000xxxx1101 & i2c_state_xxxxxxxx1101xxxx) | (i2c_state_00000000xxxx1101 & i2c_state_xxxxxxxx1101xxxx)));

//---------------------------------------------------------------------------
//Block 641, LSLICE 3

  assign i2c_cmd6A_e6 = (i2c_state_xxxxxxxxxxxx0110 & ((~i2c_send_enable & i2c_state_000000000110xxxx)));
  assign net_1311 = (~net_1301 & ~i2c_state_00000000xxxxxxxx & ((~i2c_state_xxxxxxxxxxxx0110 & ~net_1293) | (i2c_state_xxxxxxxxxxxx0110 & ~net_1293))) | (~net_1301 & i2c_state_00000000xxxxxxxx & ((~i2c_state_xxxxxxxxxxxx0110 & ~net_1293) | (i2c_state_xxxxxxxxxxxx0110 & ~net_1293))) | (net_1301 & i2c_state_00000000xxxxxxxx & ((i2c_state_xxxxxxxxxxxx0110 & ~net_1293)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6A_b6 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6A_e6 == 1'b1)   //enable
       begin
        i_i2c_cmd6A_b6 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 642, MSLICE 1

  assign sig_642_lut_0 = (net_1628 & ~net_1496 & ((~net_1246 & net_1214)));
  assign sig_642_lut_1 = 1'b0;
  assign net_1313 = (~net_1388 & sig_642_lut_0) | (net_1388 & sig_642_lut_1);

//---------------------------------------------------------------------------
//Block 643, MSLICE 0

  assign net_1315 = (~i2c_state_0000000000110xx1 & net_1568 & ((~net_1390 & net_1137)));
  assign net_1314 = (net_1320 & net_1221 & ((net_1139 & ~net_1485)));

//---------------------------------------------------------------------------
//Block 644, LSLICE 3

  assign net_1316 = (~net_1301 & i2c_state_xxxxxxxx1100xxxx & ~i2c_state_00000000xxxxxxxx) | (~net_1301 & i2c_state_xxxxxxxx1100xxxx & i2c_state_00000000xxxxxxxx) | (net_1301 & i2c_state_xxxxxxxx1100xxxx & i2c_state_00000000xxxxxxxx & ((i2c_state_xxxxxxxxxxxx1001 | i2c_state_xxxxxxxxxxxx0111)));
  assign net_1319 = (net_1381 & net_1391 & ~net_1316 & ((net_1226 & net_1315)));

//---------------------------------------------------------------------------
//Block 645, LSLICE 2

  assign net_1317 = (net_1318 & net_1139 & net_1137 & ((net_1323 & net_1398)));
  assign net_1318 = (~i2c_state_xxxxxxxxxxxx0011 & ~i2c_state_000000000101xxxx & ((~i2c_state_13_15 & ~net_1496))) | (~i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000101xxxx & ((~i2c_state_13_15 & ~net_1496))) | (i2c_state_xxxxxxxxxxxx0011 & ~i2c_state_000000000101xxxx & ((~i2c_state_13_15 & ~net_1496)));

//---------------------------------------------------------------------------
//Block 646, MSLICE 1

  assign sig_646_lut_0 = (net_1564 & ~i2c_state_00000000101011xx & ((net_1213 & net_1238)));
  assign sig_646_lut_1 = 1'b0;
  assign net_1320 = (~net_1299 & sig_646_lut_0) | (net_1299 & sig_646_lut_1);

//---------------------------------------------------------------------------
//Block 647, MSLICE 0

  assign sig_647_lut_0 = 1'b0;
  assign sig_647_lut_1 = (net_1239 & net_1404 & ((net_1395 & net_1319)));
  assign net_1322 = (~net_1585 & sig_647_lut_0) | (net_1585 & sig_647_lut_1);

//---------------------------------------------------------------------------
//Block 648, LSLICE 2

  assign net_1321 = (~net_1299 & ~i2c_state_000000000100xxxx & ~i2c_state_xxxxxxxxxxxx0111 & (~(i2c_state_xxxxxxxxxxxx0001 & i2c_state_000000000101xxxx))) | (~net_1299 & ~i2c_state_000000000100xxxx & i2c_state_xxxxxxxxxxxx0111 & (~(i2c_state_xxxxxxxxxxxx0001 & i2c_state_000000000101xxxx))) | (~net_1299 & i2c_state_000000000100xxxx & ~i2c_state_xxxxxxxxxxxx0111 & (~(i2c_state_xxxxxxxxxxxx0001 & i2c_state_000000000101xxxx)));
  assign net_1323 = (net_1327 & net_1321 & ((net_1151 & net_1404)));

//---------------------------------------------------------------------------
//Block 649, MSLICE 1

  assign net_1324 = (~i2c_state_xxxxxxxxxxxx0010 & ((i2c_state_000000000101xxxx & i2c_state_xxxxxxxxxxxx0011))) | (i2c_state_xxxxxxxxxxxx0010 & ((i2c_state_000000000101xxxx & ~i2c_state_xxxxxxxxxxxx0011) | (i2c_state_000000000101xxxx & i2c_state_xxxxxxxxxxxx0011)));
  assign net_1325 = (net_1237 & ~net_1324 & ((net_1213 & ~net_1402)));

//---------------------------------------------------------------------------
//Block 650, MSLICE 0

  assign sig_650_lut_0 = 1'b0;
  assign sig_650_lut_1 = (~i2c_state_000000001010xxxx & ~i2c_state_0000000011001110) | (i2c_state_000000001010xxxx & ~i2c_state_0000000011001110 & ((~i2c_state_xxxxxxxxxxxx0100 & ~i2c_state_xxxxxxxxxxxx0101)));
  assign net_1326 = (~net_1399 & sig_650_lut_0) | (net_1399 & sig_650_lut_1);

//---------------------------------------------------------------------------
//Block 651, LSLICE 2

  assign i2c_cmd69_e7 = (i2c_state_000000000100xxxx & ((i2c_state_xxxxxxxxxxxx0110 & ~i2c_send_enable)));
  assign net_1327 = (net_1416 & ~i2c_state_000000000100xxxx) | (net_1416 & i2c_state_000000000100xxxx & ((~i2c_state_xxxxxxxxxxxx0110 & ~i2c_state_xxxxxxxxxxxx1000)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd69_b7 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd69_e7 == 1'b1)   //enable
       begin
        i_i2c_cmd69_b7 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 652, LSLICE 3

  assign net_1329 = (~i2c_state_0000000010110000 & ~i2c_state_000000001100xxxx & ~i2c_state_xxxxxxxxxxxx0110) | (~i2c_state_0000000010110000 & ~i2c_state_000000001100xxxx & i2c_state_xxxxxxxxxxxx0110) | (~i2c_state_0000000010110000 & i2c_state_000000001100xxxx & ~i2c_state_xxxxxxxxxxxx0110 & ((~i2c_state_xxxxxxxxxxxx0101 & ~i2c_state_xxxxxxxxxxxx1011)));
  assign net_1331 = (net_1387 & net_1329 & ~i2c_state_xxxxxxxxxxxx0010 & (~(i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000001010xxxx))) | (net_1387 & net_1329 & i2c_state_xxxxxxxxxxxx0010 & ((~i2c_state_xxxxxxxxxxxx0011 & ~i2c_state_000000001010xxxx) | (i2c_state_xxxxxxxxxxxx0011 & ~i2c_state_000000001010xxxx)));

//---------------------------------------------------------------------------
//Block 653, MSLICE 1

  assign sig_653_lut_0 = 1'b0;
  assign sig_653_lut_1 = (~i2c_state_000000000101xxxx & ~i2c_state_xxxxxxxxxxxx0111) | (~i2c_state_000000000101xxxx & i2c_state_xxxxxxxxxxxx0111 & ((~i2c_state_xxxxxxxxxxxx0001 & ~i2c_state_000000000100xxxx) | (i2c_state_xxxxxxxxxxxx0001 & ~i2c_state_000000000100xxxx))) | (i2c_state_000000000101xxxx & ~i2c_state_xxxxxxxxxxxx0111 & ((~i2c_state_xxxxxxxxxxxx0001 & ~i2c_state_000000000100xxxx) | (~i2c_state_xxxxxxxxxxxx0001 & i2c_state_000000000100xxxx))) | (i2c_state_000000000101xxxx & i2c_state_xxxxxxxxxxxx0111 & ((~i2c_state_xxxxxxxxxxxx0001 & ~i2c_state_000000000100xxxx)));
  assign net_1330 = (~net_1413 & sig_653_lut_0) | (net_1413 & sig_653_lut_1);

//---------------------------------------------------------------------------
//Block 654, LSLICE 2

  assign net_1333 = (o_i2c_cmd6B_b4 & ((i2c_state_xxxxxxxxxxxx0111 & i2c_state_000000001000xxxx)));
  assign net_1334 = ((i2c_state_xxxxxxxxxxxx1111 & i2c_state_000000001000xxxx));

//---------------------------------------------------------------------------
//Block 655, LSLICE 3

  assign sig_655_lut_0 = (~o_i2c_cmd6D_b0 & cmd6D_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (o_i2c_cmd6D_b0 & ~cmd6D_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6D_b0 & ~cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (o_i2c_cmd6D_b0 & cmd6D_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_0))) | (o_i2c_cmd6D_b0 & cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_0) | (net_431 & io_mcu_d_0)));
  assign net_1335 = (~o_i2c_cmd6B_b0 & ~i2c_state_000000001100xxxx & ~net_1334) | (~o_i2c_cmd6B_b0 & ~i2c_state_000000001100xxxx & net_1334) | (~o_i2c_cmd6B_b0 & i2c_state_000000001100xxxx & ~net_1334 & (~(i2c_state_xxxxxxxxxxxx1011 & o_i2c_cmd6D_b0))) | (~o_i2c_cmd6B_b0 & i2c_state_000000001100xxxx & net_1334 & (~(i2c_state_xxxxxxxxxxxx1011 & o_i2c_cmd6D_b0))) | (o_i2c_cmd6B_b0 & ~i2c_state_000000001100xxxx & ~net_1334) | (o_i2c_cmd6B_b0 & i2c_state_000000001100xxxx & ~net_1334 & (~(i2c_state_xxxxxxxxxxxx1011 & o_i2c_cmd6D_b0)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6D_b0 <= sig_655_lut_0;
  end

//---------------------------------------------------------------------------
//Block 656, MSLICE 1

  assign sig_656_lut_0 = (~i2c_state_000000001010xxxx & ~i2c_state_xxxxxxxxxxxx0010) | (~i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx0010 & ((~i2c_state_xxxxxxxxxxxx0011 & ~i2c_state_000000001100xxxx) | (i2c_state_xxxxxxxxxxxx0011 & ~i2c_state_000000001100xxxx))) | (i2c_state_000000001010xxxx & ~i2c_state_xxxxxxxxxxxx0010 & ((~i2c_state_xxxxxxxxxxxx0011 & ~i2c_state_000000001100xxxx) | (~i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000001100xxxx)));
  assign sig_656_lut_1 = 1'b0;
  assign net_1336 = (~net_1409 & sig_656_lut_0) | (net_1409 & sig_656_lut_1);

//---------------------------------------------------------------------------
//Block 657, MSLICE 0

  assign sig_657_lut_0 = 1'b0;
  assign sig_657_lut_1 = (~i2c_state_0000000010110001 & ~i2c_state_0000000010010011 & (~(i2c_state_xxxxxxxxxxxx1111 & i2c_state_000000001100xxxx)));
  assign net_1338 = (~net_1413 & sig_657_lut_0) | (net_1413 & sig_657_lut_1);

//---------------------------------------------------------------------------
//Block 658, LSLICE 2

  assign net_1342 = (~net_1173 & ~net_1333 & ~net_1172 & (~(o_i2c_cmd6D_b5 & net_1409)));
  assign net_1340 = (net_1342 & net_1254 & ~net_1571 & ((~net_1504 & ~net_1351)));

//---------------------------------------------------------------------------
//Block 659, LSLICE 3

  assign sig_659_lut_0 = (~o_i2c_cmd6D_b3 & cmd6D_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd6D_b3 & ~cmd6D_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6D_b3 & ~cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd6D_b3 & cmd6D_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_3))) | (o_i2c_cmd6D_b3 & cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3)));
  assign net_1343 = (~o_i2c_cmd6D_b3 & ~i2c_state_xxxxxxxxxxxx1111) | (~o_i2c_cmd6D_b3 & i2c_state_xxxxxxxxxxxx1111 & ((~o_i2c_cmd6E_b7 & ~i2c_state_xxxxxxxxxxxx0101) | (~o_i2c_cmd6E_b7 & i2c_state_xxxxxxxxxxxx0101))) | (o_i2c_cmd6D_b3 & ~i2c_state_xxxxxxxxxxxx1111 & ((~o_i2c_cmd6E_b7 & ~i2c_state_xxxxxxxxxxxx0101) | (o_i2c_cmd6E_b7 & ~i2c_state_xxxxxxxxxxxx0101))) | (o_i2c_cmd6D_b3 & i2c_state_xxxxxxxxxxxx1111 & ((~o_i2c_cmd6E_b7 & ~i2c_state_xxxxxxxxxxxx0101)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6D_b3 <= sig_659_lut_0;
  end

//---------------------------------------------------------------------------
//Block 660, MSLICE 1

  assign cmd68_write_enable = ((cmd68_select & i_mcu_rws));
  assign cmd6A_write_enable = ((cmd6A_select & i_mcu_rws));

//---------------------------------------------------------------------------
//MSLICE adder blocks 661, 664, 665

  assign { state_sum_b3, state_sum_b2, state_sum_b1, state_sum_b0 } = { 1'b0, 1'b0, state_b1, state_b0 } + { state_b3, state_b2, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 662, LSLICE 2

  assign sig_662_lut_0 = (~cmd6D_write_enable & ~i_mcu_dcs & o_i2c_cmd6D_b2) | (~cmd6D_write_enable & i_mcu_dcs & ~o_i2c_cmd6D_b2 & ((~net_431 & ~io_mcu_d_2) | (~net_431 & io_mcu_d_2))) | (~cmd6D_write_enable & i_mcu_dcs & o_i2c_cmd6D_b2) | (cmd6D_write_enable & ~i_mcu_dcs & ~o_i2c_cmd6D_b2 & ((~net_431 & io_mcu_d_2))) | (cmd6D_write_enable & ~i_mcu_dcs & o_i2c_cmd6D_b2 & ((~net_431 & io_mcu_d_2) | (net_431 & io_mcu_d_2))) | (cmd6D_write_enable & i_mcu_dcs & ~o_i2c_cmd6D_b2 & ((~net_431 & ~io_mcu_d_2) | (~net_431 & io_mcu_d_2))) | (cmd6D_write_enable & i_mcu_dcs & o_i2c_cmd6D_b2);
  assign net_1345 = (i2c_state_xxxxxxxxxxxx0111 & ((o_i2c_cmd6D_b2 & i2c_state_000000001100xxxx)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6D_b2 <= sig_662_lut_0;
  end

//---------------------------------------------------------------------------
//Block 663, LSLICE 3

  assign sig_663_lut_0 = (~cmd6C_write_enable & ~i_mcu_dcs & o_i2c_cmd6C_b0) | (~cmd6C_write_enable & i_mcu_dcs & ~o_i2c_cmd6C_b0 & ((~net_431 & ~io_mcu_d_0) | (~net_431 & io_mcu_d_0))) | (~cmd6C_write_enable & i_mcu_dcs & o_i2c_cmd6C_b0) | (cmd6C_write_enable & ~i_mcu_dcs & ~o_i2c_cmd6C_b0 & ((~net_431 & io_mcu_d_0))) | (cmd6C_write_enable & ~i_mcu_dcs & o_i2c_cmd6C_b0 & ((~net_431 & io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (cmd6C_write_enable & i_mcu_dcs & ~o_i2c_cmd6C_b0 & ((~net_431 & ~io_mcu_d_0) | (~net_431 & io_mcu_d_0))) | (cmd6C_write_enable & i_mcu_dcs & o_i2c_cmd6C_b0);
  assign net_1351 = (i2c_state_xxxxxxxxxxxx1101 & ((o_i2c_cmd6C_b0 & i2c_state_000000001010xxxx)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6C_b0 <= sig_663_lut_0;
  end

//---------------------------------------------------------------------------
//Block 666, LSLICE 2

  assign sig_666_lut_0 = (~cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b3) | (~cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b3 & ((~net_431 & ~io_mcu_d_3) | (~net_431 & io_mcu_d_3))) | (~cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b3) | (cmd69_write_enable & ~i_mcu_dcs & ~o_i2c_cmd69_b3 & ((~net_431 & io_mcu_d_3))) | (cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b3 & ((~net_431 & io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b3 & ((~net_431 & ~io_mcu_d_3) | (~net_431 & io_mcu_d_3))) | (cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b3);
  assign sig_666_lut_1 = (~cmd69_write_enable & ~o_i2c_cmd69_b4 & i_mcu_dcs & ((~net_431 & ~io_mcu_d_4) | (~net_431 & io_mcu_d_4))) | (~cmd69_write_enable & o_i2c_cmd69_b4 & ~i_mcu_dcs) | (~cmd69_write_enable & o_i2c_cmd69_b4 & i_mcu_dcs) | (cmd69_write_enable & ~o_i2c_cmd69_b4 & ~i_mcu_dcs & ((~net_431 & io_mcu_d_4))) | (cmd69_write_enable & ~o_i2c_cmd69_b4 & i_mcu_dcs & ((~net_431 & ~io_mcu_d_4) | (~net_431 & io_mcu_d_4))) | (cmd69_write_enable & o_i2c_cmd69_b4 & ~i_mcu_dcs & ((~net_431 & io_mcu_d_4) | (net_431 & io_mcu_d_4))) | (cmd69_write_enable & o_i2c_cmd69_b4 & i_mcu_dcs);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd69_b3 <= sig_666_lut_0;
    o_i2c_cmd69_b4 <= sig_666_lut_1;
  end

//---------------------------------------------------------------------------
//Block 671, LSLICE 2

  assign net_1361 = (net_1363 & ~i2c_clk_div_reg2 & ~i2c_clk_div_reg5) | (net_1363 & ~i2c_clk_div_reg2 & i2c_clk_div_reg5) | (net_1363 & i2c_clk_div_reg2 & ~i2c_clk_div_reg5) | (net_1363 & i2c_clk_div_reg2 & i2c_clk_div_reg5 & (~(i2c_clk_div_reg4 & i2c_clk_div_reg3)));
  assign i2c_clk_rst = (~net_1362 & ~i2c_clk_div_reg10) | (~net_1362 & i2c_clk_div_reg10) | (net_1362 & ~i2c_clk_div_reg10 & (~(net_1361 & ~i2c_clk_div_reg11))) | (net_1362 & i2c_clk_div_reg10);

  always @(posedge clock_200MHz)
  begin
    if(i2c_clk_rst == 1'b1)   //reset
    begin
      i2c_clk_div_reg2 <= 1'b0;
      i2c_clk_div_reg13 <= 1'b0;
    end
    else
    begin
      i2c_clk_div_reg2 <= i2c_clk_div_out2;
      i2c_clk_div_reg13 <= i2c_clk_div_out13;
    end
  end

//---------------------------------------------------------------------------
//Block 672, LSLICE 3

  assign net_1363 = (~i2c_clk_div_reg7 & ~i2c_clk_div_reg9 & ((~i2c_clk_div_reg8 & ~i2c_clk_div_reg6)));
  assign net_1362 = (~i2c_clk_div_reg15 & ~i2c_clk_div_reg14 & ((~i2c_clk_div_reg12 & ~i2c_clk_div_reg13)));

  always @(posedge clock_200MHz)
  begin
    if(i2c_clk_rst == 1'b1)   //reset
    begin
      i2c_clk_div_reg6 <= 1'b0;
      i2c_clk_div_reg14 <= 1'b0;
    end
    else
    begin
      i2c_clk_div_reg6 <= i2c_clk_div_out6;
      i2c_clk_div_reg14 <= i2c_clk_div_out14;
    end
  end

//---------------------------------------------------------------------------
//Block 673, LSLICE 2

  assign i2c_cmd6A_e4 = (i2c_state_00000000xxxx1010 & ((~i2c_send_enable & i2c_state_xxxxxxxx0110xxxx)));
  assign i2c_state_xxxxxxxx0110xxxx = ((i2c_state_xxxxxxxx01xxxxxx & i2c_state_xxxxxxxxxx10xxxx));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6A_b4 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd6A_e4 == 1'b1)   //enable
       begin
        i_i2c_cmd6A_b4 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 674, LSLICE 3

  assign i2c_cmd68_e7 = (i2c_state_xxxxxxxx0010xxxx & ((~i2c_send_enable & i2c_state_00000000xxxx1000)));
  assign net_1368 = (~i2c_state_xxxxxxxx0010xxxx & ((~i2c_state_00000000xxxx1000 & ~i2c_state_xxxxxxxx00010010) | (i2c_state_00000000xxxx1000 & ~i2c_state_xxxxxxxx00010010))) | (i2c_state_xxxxxxxx0010xxxx & ((~i2c_state_00000000xxxx1000 & ~i2c_state_xxxxxxxx00010010)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd68_b7 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd68_e7 == 1'b1)   //enable
       begin
        i_i2c_cmd68_b7 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 675, MSLICE 1

  assign i2c_state_xxxxxxxx1010xxxx = (i2c_state_xxxxxxxxxx10xxxx & ((i2c_state_r7 & ~i2c_state_r6)));
  assign i2c_state_xxxxxxxxxx10xxxx = ((i2c_state_r5 & ~i2c_state_r4));

//---------------------------------------------------------------------------
//Block 676, MSLICE 0

  assign clk_a_div_b = (~clk_a_div_reg5 & ~clk_a_div_reg4 & ((~clk_a_div_reg3 & ~clk_a_div_reg2)));
  assign i2c_state_000000000000xxxx = ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxx0000xxxx));

  always @(posedge clock_200MHz)
  begin
    if(clk_a_reset == 1'b1)   //reset
    begin
      clk_a_div_reg2 <= 1'b0;
    end
    else
    begin
      clk_a_div_reg2 <= clk_a_div_out2;
    end
  end

//---------------------------------------------------------------------------
//Block 677, LSLICE 2

  assign i2c_state_000000000x1011x0 = (i2c_state_xxxxxxxxxx10xxxx & ~i2c_state_r7 & ((i2c_state_00000000xxxx1100 | i2c_state_00000000xxxx1110)));
  assign i2c_state_xxxxxxxx1110xxxx = (i2c_state_xxxxxxxxxx10xxxx & ((i2c_state_r7 & i2c_state_r6)));

//---------------------------------------------------------------------------
//Block 678, MSLICE 1

  assign net_1378 = (~i2c_state_xxxxxxxx1111xxxx & ~i2c_state_00000000xxxx1000 & (~(i2c_state_xxxxxxxx1110xxxx & i2c_state_00000000xxxx1100))) | (~i2c_state_xxxxxxxx1111xxxx & i2c_state_00000000xxxx1000 & (~(i2c_state_xxxxxxxx1110xxxx & i2c_state_00000000xxxx1100))) | (i2c_state_xxxxxxxx1111xxxx & ~i2c_state_00000000xxxx1000 & (~(i2c_state_xxxxxxxx1110xxxx & i2c_state_00000000xxxx1100)));
  assign net_1374 = (~i2c_state_00000000xxxx1110 & ((~i2c_state_xxxxxxxx1110xxxx & ~i2c_state_0000000011101111) | (i2c_state_xxxxxxxx1110xxxx & ~i2c_state_0000000011101111))) | (i2c_state_00000000xxxx1110 & ((~i2c_state_xxxxxxxx1110xxxx & ~i2c_state_0000000011101111)));

//---------------------------------------------------------------------------
//Block 679, LSLICE 3

  assign i2c_state_000000001110xxxx = ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxx1110xxxx));
  assign i2c_state_0000000011101010 = ((i2c_state_xxxxxxxx1110xxxx & i2c_state_00000000xxxx1010));

//---------------------------------------------------------------------------
//Block 680, MSLICE 0

  assign net_1387 = (~i2c_state_xxxxxxxx1100xxxx & ~i2c_state_00000000xxxx1100 & (~(i2c_state_xxxxxxxx1010xxxx & i2c_state_00000000xxxx1110))) | (~i2c_state_xxxxxxxx1100xxxx & i2c_state_00000000xxxx1100 & (~(i2c_state_xxxxxxxx1010xxxx & i2c_state_00000000xxxx1110))) | (i2c_state_xxxxxxxx1100xxxx & ~i2c_state_00000000xxxx1100 & (~(i2c_state_xxxxxxxx1010xxxx & i2c_state_00000000xxxx1110)));
  assign net_1381 = (~i2c_state_xxxxxxxx1100xxxx & ~i2c_state_00000000xxxx1100 & ((~net_1406 & ~i2c_state_00000000xxxx1101) | (~net_1406 & i2c_state_00000000xxxx1101))) | (~i2c_state_xxxxxxxx1100xxxx & i2c_state_00000000xxxx1100 & ((~net_1406 & ~i2c_state_00000000xxxx1101) | (~net_1406 & i2c_state_00000000xxxx1101))) | (i2c_state_xxxxxxxx1100xxxx & ~i2c_state_00000000xxxx1100 & ((~net_1406 & ~i2c_state_00000000xxxx1101)));

//---------------------------------------------------------------------------
//Block 681, LSLICE 2

  assign net_1383 = (~net_1619 & net_1384 & ~i2c_state_xxxxxxxx1110xxxx) | (~net_1619 & net_1384 & i2c_state_xxxxxxxx1110xxxx & ((net_1301 & ~i2c_state_00000000xxxx1100)));
  assign net_1384 = ((~net_1561 & ~i2c_state_0000000000110xx1));

//---------------------------------------------------------------------------
//Block 682, LSLICE 3

  assign net_1386 = (~i2c_state_xxxxxxxxxxxx0011 & i2c_state_xxxxxxxx1110xxxx & ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxxxxxx0010))) | (i2c_state_xxxxxxxxxxxx0011 & i2c_state_xxxxxxxx1110xxxx & ((i2c_state_00000000xxxxxxxx & ~i2c_state_xxxxxxxxxxxx0010) | (i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxxxxxx0010)));
  assign net_1388 = (~i2c_state_xxxxxxxxxxxx0011 & i2c_state_xxxxxxxx1000xxxx & ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxxxxxx0010))) | (i2c_state_xxxxxxxxxxxx0011 & i2c_state_xxxxxxxx1000xxxx & ((i2c_state_00000000xxxxxxxx & ~i2c_state_xxxxxxxxxxxx0010) | (i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxxxxxx0010)));

//---------------------------------------------------------------------------
//Block 683, MSLICE 1

  assign i2c_cmd6C_e0 = (~i2c_send_enable & ((i2c_state_00000000xxxx1110 & i2c_state_xxxxxxxx1010xxxx)));
  assign i2c_state_00000000101011xx = (~i2c_state_00000000xxxx1110 & i2c_state_xxxxxxxx1010xxxx & ((i2c_state_xxxxxxxxxxxx1101 & i2c_state_00000000xxxxxxxx))) | (i2c_state_00000000xxxx1110 & i2c_state_xxxxxxxx1010xxxx);

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6C_b0 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd6C_e0 == 1'b1)   //enable
       begin
        i_i2c_cmd6C_b0 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 684, LSLICE 2

  assign i2c_cmd6E_e1 = (~i2c_send_enable & ((i2c_state_xxxxxxxxxxxx1000 & i2c_state_000000001110xxxx)));
  assign net_1391 = (~net_1619 & (~(i2c_state_xxxxxxxxxxxx1000 & i2c_state_000000001110xxxx)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6E_b1 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6E_e1 == 1'b1)   //enable
       begin
        i_i2c_cmd6E_b1 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 685, MSLICE 0

  assign sig_685_lut_0 = 1'b0;
  assign sig_685_lut_1 = (~i2c_state_xxxxxxxxxxxx10x1 & ~i2s_state_unknown_a & ((~i2c_state_00000000xxxxxxxx & ~i2c_state_r4) | (i2c_state_00000000xxxxxxxx & ~i2c_state_r4))) | (i2c_state_xxxxxxxxxxxx10x1 & ~i2s_state_unknown_a & ((~i2c_state_00000000xxxxxxxx & ~i2c_state_r4) | (i2c_state_00000000xxxxxxxx & ~i2c_state_r4))) | (i2c_state_xxxxxxxxxxxx10x1 & i2s_state_unknown_a & ((i2c_state_00000000xxxxxxxx & ~i2c_state_r4)));
  assign net_1390 = (~i2c_state_xxxxxxxx01xxxxxx & sig_685_lut_0) | (i2c_state_xxxxxxxx01xxxxxx & sig_685_lut_1);

//---------------------------------------------------------------------------
//Block 686, MSLICE 1

  assign sig_686_lut_0 = (net_1500 & ~i2c_state_0000000011101101 & ((~i2c_state_xxxxxxxx00010010 & ~i2c_state_0000000000000000)));
  assign sig_686_lut_1 = 1'b0;
  assign net_1393 = (~i2c_state_13_15 & sig_686_lut_0) | (i2c_state_13_15 & sig_686_lut_1);

//---------------------------------------------------------------------------
//Block 687, LSLICE 3

  assign net_1395 = (net_1393 & net_1499 & net_1396 & ((net_1481 & net_1230)));
  assign net_1396 = (~i2c_state_xxxxxxxx1110xxxx & ~i2c_state_00000000xxxx1100 & ((net_1492 & ~i2c_state_0000000001010100))) | (~i2c_state_xxxxxxxx1110xxxx & i2c_state_00000000xxxx1100 & ((net_1492 & ~i2c_state_0000000001010100))) | (i2c_state_xxxxxxxx1110xxxx & ~i2c_state_00000000xxxx1100 & ((net_1492 & ~i2c_state_0000000001010100)));

//---------------------------------------------------------------------------
//Block 688, MSLICE 0

  assign net_1402 = (i2c_state_000000000000xxxx & ~i2c_state_xxxxxxxxxxxx0111 & ((i2c_state_xxxxxxxxxxxx1101 | i2c_state_xxxxxxxxxxxx10x1))) | (i2c_state_000000000000xxxx & i2c_state_xxxxxxxxxxxx0111);
  assign net_1404 = (~net_1227 & ~net_1562 & (~(i2c_state_000000000000xxxx & i2c_state_xxxxxxxxxxxx10x1)));

//---------------------------------------------------------------------------
//Block 689, LSLICE 2

  assign net_1397 = (net_1585 & ~net_1406 & net_1501 & ((net_1165 & ~i2c_state_0000000010010010)));
  assign net_1398 = ((net_1397 & ~net_1390));

//---------------------------------------------------------------------------
//Block 690, LSLICE 3

  assign net_1400 = (~i2c_state_xxxxxxxxxxxx0110 & i2c_state_000000000011xxxx & ~i2c_state_000000000100xxxx & ((i2c_state_xxxxxxxxxxxx0100 | i2c_state_xxxxxxxxxxxx1000))) | (~i2c_state_xxxxxxxxxxxx0110 & i2c_state_000000000011xxxx & i2c_state_000000000100xxxx & ((i2c_state_xxxxxxxxxxxx0100 | i2c_state_xxxxxxxxxxxx1000))) | (i2c_state_xxxxxxxxxxxx0110 & ~i2c_state_000000000011xxxx & i2c_state_000000000100xxxx) | (i2c_state_xxxxxxxxxxxx0110 & i2c_state_000000000011xxxx & ~i2c_state_000000000100xxxx) | (i2c_state_xxxxxxxxxxxx0110 & i2c_state_000000000011xxxx & i2c_state_000000000100xxxx);
  assign net_1401 = (net_1405 & ~net_1400 & ~net_1406 & ((~net_1562 & ~net_1227)));

//---------------------------------------------------------------------------
//Block 691, MSLICE 1

  assign net_1403 = (i2c_send_enable & ~i2c_state_0000000011101101 & ((~i2c_state_0000000000010011 & ~i2c_state_0000000000000000)));
  assign net_1399 = (~i2c_state_xxxxxxxxxxxx1011 & ~i2c_state_0000000011101101 & (~(i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx0111))) | (i2c_state_xxxxxxxxxxxx1011 & ~i2c_state_0000000011101101 & ((~i2c_state_000000001010xxxx & ~i2c_state_xxxxxxxxxxxx0111) | (~i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx0111)));

//---------------------------------------------------------------------------
//Block 692, MSLICE 0

  assign i2c_cmd6A_e0 = (i2c_state_000000000111xxxx & ((~i2c_send_enable & i2c_state_xxxxxxxxxxxx0010)));
  assign net_1406 = (~i2c_state_xxxxxxxxxxxx0000 & ((i2c_state_xxxxxxxxxxxx0010 & i2c_state_000000000111xxxx))) | (i2c_state_xxxxxxxxxxxx0000 & ((~i2c_state_xxxxxxxxxxxx0010 & i2c_state_000000000111xxxx) | (i2c_state_xxxxxxxxxxxx0010 & i2c_state_000000000111xxxx)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6A_b0 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6A_e0 == 1'b1)   //enable
       begin
        i_i2c_cmd6A_b0 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 693, LSLICE 2

  assign i2c_state_0000000011001110 = ((i2c_state_xxxxxxxx1100xxxx & i2c_state_00000000xxxx1110));
  assign net_1409 = ((i2c_state_00000000xxxx0001 & i2c_state_xxxxxxxx1100xxxx));

//---------------------------------------------------------------------------
//Block 694, MSLICE 1

  assign i2c_cmd6E_e2 = (~i2c_send_enable & ((i2c_state_000000001110xxxx & i2c_state_xxxxxxxxxxxx0110)));
  assign net_1405 = (net_1500 & ~i2c_state_000000001110xxxx & ((~i2c_state_xxxxxxxxxxxx0110 & ~i2c_state_0000000010010010) | (i2c_state_xxxxxxxxxxxx0110 & ~i2c_state_0000000010010010))) | (net_1500 & i2c_state_000000001110xxxx & ((~i2c_state_xxxxxxxxxxxx0110 & ~i2c_state_0000000010010010)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6E_b2 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd6E_e2 == 1'b1)   //enable
       begin
        i_i2c_cmd6E_b2 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 695, MSLICE 0

  assign net_1415 = (~i2c_state_xxxxxxxxxxxx0111 & ((i2c_state_xxxxxxxxxxxx0100 & i2c_state_000000000000xxxx))) | (i2c_state_xxxxxxxxxxxx0111 & ((~i2c_state_xxxxxxxxxxxx0100 & i2c_state_000000000000xxxx) | (i2c_state_xxxxxxxxxxxx0100 & i2c_state_000000000000xxxx)));
  assign net_1416 = (~net_1415 & ~i2c_state_00000000xxxx0011 & ((~net_1334 & ~i2c_state_xxxxxxxx1000xxxx) | (~net_1334 & i2c_state_xxxxxxxx1000xxxx))) | (~net_1415 & i2c_state_00000000xxxx0011 & ((~net_1334 & ~i2c_state_xxxxxxxx1000xxxx)));

//---------------------------------------------------------------------------
//Block 696, LSLICE 2

  assign i2c_cmd68_e0 = (~i2c_send_enable & ((i2c_state_xxxxxxxxxxxx0110 & i2c_state_000000000011xxxx)));
  assign net_1413 = (~i2c_state_xxxxxxxxxxxx1001 & ~i2c_state_xxxxxxxxxxxx0101) | (~i2c_state_xxxxxxxxxxxx1001 & i2c_state_xxxxxxxxxxxx0101 & ((~i2c_state_000000000111xxxx & ~i2c_state_000000000011xxxx) | (~i2c_state_000000000111xxxx & i2c_state_000000000011xxxx))) | (i2c_state_xxxxxxxxxxxx1001 & ~i2c_state_xxxxxxxxxxxx0101 & ((~i2c_state_000000000111xxxx & ~i2c_state_000000000011xxxx) | (i2c_state_000000000111xxxx & ~i2c_state_000000000011xxxx))) | (i2c_state_xxxxxxxxxxxx1001 & i2c_state_xxxxxxxxxxxx0101 & ((~i2c_state_000000000111xxxx & ~i2c_state_000000000011xxxx)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd68_b0 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd68_e0 == 1'b1)   //enable
       begin
        i_i2c_cmd68_b0 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 697, MSLICE 1

  assign sig_697_lut_0 = (~i2c_state_000000001010xxxx & ~i2c_state_xxxxxxxxxxxx1111 & (~(i2c_state_xxxxxxxxxxxx1101 & i2c_state_000000001100xxxx))) | (~i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx1111 & (~(i2c_state_xxxxxxxxxxxx1101 & i2c_state_000000001100xxxx))) | (i2c_state_000000001010xxxx & ~i2c_state_xxxxxxxxxxxx1111 & (~(i2c_state_xxxxxxxxxxxx1101 & i2c_state_000000001100xxxx)));
  assign sig_697_lut_1 = 1'b0;
  assign net_1417 = (~i2c_state_0000000011101011 & sig_697_lut_0) | (i2c_state_0000000011101011 & sig_697_lut_1);

//---------------------------------------------------------------------------
//Block 698, MSLICE 0

  assign net_1423 = (~i2c_state_xxxxxxxxxxxx1101 & ((i2c_state_000000001000xxxx & i2c_state_xxxxxxxxxxxx1011))) | (i2c_state_xxxxxxxxxxxx1101 & ((i2c_state_000000001000xxxx & ~i2c_state_xxxxxxxxxxxx1011) | (i2c_state_000000001000xxxx & i2c_state_xxxxxxxxxxxx1011)));
  assign net_1422 = ((i2c_state_xxxxxxxxxxxx1101 & i2c_state_000000001000xxxx));

//---------------------------------------------------------------------------
//Block 699, LSLICE 2

  assign sig_699_lut_0 = (~cmd6E_write_enable & ~i_mcu_dcs & o_i2c_cmd6E_b0) | (~cmd6E_write_enable & i_mcu_dcs & ~o_i2c_cmd6E_b0 & ((~net_431 & ~io_mcu_d_0) | (~net_431 & io_mcu_d_0))) | (~cmd6E_write_enable & i_mcu_dcs & o_i2c_cmd6E_b0) | (cmd6E_write_enable & ~i_mcu_dcs & ~o_i2c_cmd6E_b0 & ((~net_431 & io_mcu_d_0))) | (cmd6E_write_enable & ~i_mcu_dcs & o_i2c_cmd6E_b0 & ((~net_431 & io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (cmd6E_write_enable & i_mcu_dcs & ~o_i2c_cmd6E_b0 & ((~net_431 & ~io_mcu_d_0) | (~net_431 & io_mcu_d_0))) | (cmd6E_write_enable & i_mcu_dcs & o_i2c_cmd6E_b0);
  assign net_1419 = (i2c_state_xxxxxxxxxxxx1001 & ((i2c_state_000000001110xxxx & o_i2c_cmd6E_b0)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6E_b0 <= sig_699_lut_0;
  end

//---------------------------------------------------------------------------
//Block 700, MSLICE 1

  assign sig_700_lut_0 = (~i_mcu_dcs & o_i2c_cmd6A_b7) | (i_mcu_dcs & ~o_i2c_cmd6A_b7 & ((~net_431 & ~io_mcu_d_7) | (~net_431 & io_mcu_d_7))) | (i_mcu_dcs & o_i2c_cmd6A_b7);
  assign sig_700_lut_1 = (~i_mcu_dcs & ~o_i2c_cmd6A_b7 & ((~net_431 & io_mcu_d_7))) | (~i_mcu_dcs & o_i2c_cmd6A_b7 & ((~net_431 & io_mcu_d_7) | (net_431 & io_mcu_d_7))) | (i_mcu_dcs & ~o_i2c_cmd6A_b7 & ((~net_431 & ~io_mcu_d_7) | (~net_431 & io_mcu_d_7))) | (i_mcu_dcs & o_i2c_cmd6A_b7);
  assign sig_700_ff0_d = (~cmd6A_write_enable & sig_700_lut_0) | (cmd6A_write_enable & sig_700_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6A_b7 <= sig_700_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 701, LSLICE 3

  assign sig_701_lut_0 = (~cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b2) | (~cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b2 & ((~net_431 & ~io_mcu_d_2) | (~net_431 & io_mcu_d_2))) | (~cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b2) | (cmd69_write_enable & ~i_mcu_dcs & ~o_i2c_cmd69_b2 & ((~net_431 & io_mcu_d_2))) | (cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b2 & ((~net_431 & io_mcu_d_2) | (net_431 & io_mcu_d_2))) | (cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b2 & ((~net_431 & ~io_mcu_d_2) | (~net_431 & io_mcu_d_2))) | (cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b2);
  assign net_1424 = (~o_i2c_cmd69_b2 & ~o_i2c_cmd69_b3) | (~o_i2c_cmd69_b2 & o_i2c_cmd69_b3 & ((~i2c_state_xxxxxxxxxxxx1111 & ~i2c_state_xxxxxxxxxxxx1101) | (i2c_state_xxxxxxxxxxxx1111 & ~i2c_state_xxxxxxxxxxxx1101))) | (o_i2c_cmd69_b2 & ~o_i2c_cmd69_b3 & ((~i2c_state_xxxxxxxxxxxx1111 & ~i2c_state_xxxxxxxxxxxx1101) | (~i2c_state_xxxxxxxxxxxx1111 & i2c_state_xxxxxxxxxxxx1101))) | (o_i2c_cmd69_b2 & o_i2c_cmd69_b3 & ((~i2c_state_xxxxxxxxxxxx1111 & ~i2c_state_xxxxxxxxxxxx1101)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd69_b2 <= sig_701_lut_0;
  end

//---------------------------------------------------------------------------
//Block 702, LSLICE 2

  assign sig_702_lut_0 = (~cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b6) | (~cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b6 & ((~net_431 & ~io_mcu_d_6) | (~net_431 & io_mcu_d_6))) | (~cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b6) | (cmd69_write_enable & ~i_mcu_dcs & ~o_i2c_cmd69_b6 & ((~net_431 & io_mcu_d_6))) | (cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b6 & ((~net_431 & io_mcu_d_6) | (net_431 & io_mcu_d_6))) | (cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b6 & ((~net_431 & ~io_mcu_d_6) | (~net_431 & io_mcu_d_6))) | (cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b6);
  assign net_1427 = (~net_1424 & i2c_state_000000000100xxxx) | (net_1424 & i2c_state_000000000100xxxx & ((o_i2c_cmd69_b6 & i2c_state_xxxxxxxxxxxx0111)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd69_b6 <= sig_702_lut_0;
  end

//---------------------------------------------------------------------------
//Block 703, MSLICE 1

  assign sig_703_lut_0 = (cmd6D_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_4) | (net_431 & io_mcu_d_4)));
  assign sig_703_lut_1 = (~cmd6D_write_enable & ~i_mcu_dcs) | (~cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_4) | (net_431 & io_mcu_d_4))) | (cmd6D_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_4))) | (cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_4) | (net_431 & io_mcu_d_4)));
  assign sig_703_ff0_d = (~o_i2c_cmd6D_b4 & sig_703_lut_0) | (o_i2c_cmd6D_b4 & sig_703_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6D_b4 <= sig_703_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 704, LSLICE 2

  assign sig_704_lut_0 = (~o_i2c_cmd6A_b3 & cmd6A_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd6A_b3 & ~cmd6A_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6A_b3 & ~cmd6A_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd6A_b3 & cmd6A_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_3))) | (o_i2c_cmd6A_b3 & cmd6A_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3)));
  assign net_1429 = (~net_1014 & ~i2c_state_xxxxxxxxxxxx1011) | (~net_1014 & i2c_state_xxxxxxxxxxxx1011 & (~(i2c_state_000000000110xxxx & o_i2c_cmd6A_b3)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6A_b3 <= sig_704_lut_0;
  end

//---------------------------------------------------------------------------
//Block 709, LSLICE 2

  always @(posedge clock_200MHz)
  begin
    if(i2c_clk_rst == 1'b1)   //reset
    begin
      i2c_clk_div_reg0 <= 1'b0;
      i2c_clk_div_reg1 <= 1'b0;
    end
    else
    begin
      i2c_clk_div_reg0 <= i2c_clk_div_out0;
      i2c_clk_div_reg1 <= i2c_clk_div_out1;
    end
  end

//---------------------------------------------------------------------------
//Block 710, LSLICE 3

  always @(posedge clock_200MHz)
  begin
    if(i2c_clk_rst == 1'b1)   //reset
    begin
      i2c_clk_div_reg3 <= 1'b0;
      i2c_clk_div_reg4 <= 1'b0;
    end
    else
    begin
      i2c_clk_div_reg3 <= i2c_clk_div_out3;
      i2c_clk_div_reg4 <= i2c_clk_div_out4;
    end
  end

//---------------------------------------------------------------------------
//Block 711, LSLICE 2

  always @(posedge clock_200MHz)
  begin
    if(i2c_clk_rst == 1'b1)   //reset
    begin
      i2c_clk_div_reg10 <= 1'b0;
      i2c_clk_div_reg7 <= 1'b0;
    end
    else
    begin
      i2c_clk_div_reg10 <= i2c_clk_div_out10;
      i2c_clk_div_reg7 <= i2c_clk_div_out7;
    end
  end

//---------------------------------------------------------------------------
//Block 712, LSLICE 3

  always @(posedge clock_200MHz)
  begin
    if(i2c_clk_rst == 1'b1)   //reset
    begin
      i2c_clk_div_reg11 <= 1'b0;
      i2c_clk_div_reg12 <= 1'b0;
    end
    else
    begin
      i2c_clk_div_reg11 <= i2c_clk_div_out11;
      i2c_clk_div_reg12 <= i2c_clk_div_out12;
    end
  end

//---------------------------------------------------------------------------
//Block 713, LSLICE 2

  always @(posedge clock_200MHz)
  begin
    if(i2c_clk_rst == 1'b1)   //reset
    begin
      i2c_clk_div_reg15 <= 1'b0;
      i2c_clk_div_reg5 <= 1'b0;
    end
    else
    begin
      i2c_clk_div_reg15 <= i2c_clk_div_out15;
      i2c_clk_div_reg5 <= i2c_clk_div_out5;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 709, 710, 711, 712, 713

  assign { i2c_clk_div_out15, i2c_clk_div_out14, i2c_clk_div_out13, i2c_clk_div_out12, i2c_clk_div_out11, i2c_clk_div_out10, i2c_clk_div_out9, i2c_clk_div_out8, i2c_clk_div_out7, i2c_clk_div_out6, i2c_clk_div_out5, i2c_clk_div_out4, i2c_clk_div_out3, i2c_clk_div_out2, i2c_clk_div_out1, i2c_clk_div_out0 } = { i2c_clk_div_reg15, i2c_clk_div_reg14, i2c_clk_div_reg13, i2c_clk_div_reg12, i2c_clk_div_reg11, i2c_clk_div_reg10, i2c_clk_div_reg9, i2c_clk_div_reg8, i2c_clk_div_reg7, i2c_clk_div_reg6, i2c_clk_div_reg5, i2c_clk_div_reg4, i2c_clk_div_reg3, i2c_clk_div_reg2, i2c_clk_div_reg1, i2c_clk_div_reg0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 714, LSLICE 3

  assign i2c_state_xxxxxxxx1000xxxx = (~i2c_state_r6 & i2c_state_r7 & ((~i2c_state_r4 & ~i2c_state_r5)));
  assign i2c_state_xxxxxxxx1011xxxx = (~i2c_state_r6 & i2c_state_r4 & ((i2c_state_r5 & i2c_state_r7)));

//---------------------------------------------------------------------------
//Block 715, MSLICE 1

  assign i2c_state_xxxxxxxx1100xxxx = (i2c_state_r7 & i2c_state_r6 & ((~i2c_state_r5 & ~i2c_state_r4)));
  assign i2c_state_xxxxxxxx1101xxxx = (i2c_state_r7 & i2c_state_r6 & ((i2c_state_r4 & ~i2c_state_r5)));

//---------------------------------------------------------------------------
//Block 716, MSLICE 0

  assign sig_716_lut_0 = 1'b0;
  assign sig_716_lut_1 = (~i2c_state_r6 & ~i2c_state_r7 & ((i2c_state_r5 & i2c_state_00000000xxxxxxxx)));
  assign i2c_state_000000000011xxxx = (~i2c_state_r4 & sig_716_lut_0) | (i2c_state_r4 & sig_716_lut_1);

//---------------------------------------------------------------------------
//Block 717, LSLICE 2

  assign i2c_state_xxxxxxxx01xxxxxx = ((~i2c_state_r7 & i2c_state_r6));
  assign i2s_state_unknown_a = ((~i2c_state_00000000xxxx1100 & ~i2c_state_00000000xxxx1010));

//---------------------------------------------------------------------------
//Block 718, MSLICE 1

  assign i2c_cmd68_e5 = (~i2c_send_enable & ((i2c_state_00000000xxxx1100 & i2c_state_xxxxxxxx0010xxxx)));
  assign i2c_state_0000000000101xxx = (i2c_state_r3 & ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxx0010xxxx)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd68_b5 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd68_e5 == 1'b1)   //enable
       begin
        i_i2c_cmd68_b5 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 719, MSLICE 0

  assign i2c_state_000000000100xxxx = (i2c_state_xxxxxxxx01xxxxxx & i2c_state_00000000xxxxxxxx & ((~i2c_state_r5 & ~i2c_state_r4)));
  assign i2c_state_xxxxxxxx0100xxxx = (i2c_state_xxxxxxxx01xxxxxx & ((~i2c_state_r5 & ~i2c_state_r4)));

//---------------------------------------------------------------------------
//Block 720, LSLICE 3

  assign net_1477 = (~net_1488 & net_1306 & ~net_1402 & (~(i2c_state_r5 & ~i2c_state_r0)));
  assign net_1478 = (net_1481 & net_1477 & ((net_1564 & net_1368)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r5 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r5 <= i2c_state_c5;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 721, LSLICE 2

  assign i2c_state_000000000101xxxx = (i2c_state_r4 & i2c_state_00000000xxxxxxxx & ((i2c_state_xxxxxxxx01xxxxxx & ~i2c_state_r5)));
  assign i2c_state_000000000111xxxx = (i2c_state_r4 & i2c_state_00000000xxxxxxxx & ((i2c_state_xxxxxxxx01xxxxxx & i2c_state_r5)));

//---------------------------------------------------------------------------
//Block 722, MSLICE 1

  assign i2c_cmd6A_e7 = (i2c_state_xxxxxxxxxxxx0100 & ((~i2c_send_enable & i2c_state_000000000110xxxx)));
  assign i2c_state_000000000110xxxx = (i2c_state_xxxxxxxx01xxxxxx & ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxxxx10xxxx)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6A_b7 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd6A_e7 == 1'b1)   //enable
       begin
        i_i2c_cmd6A_b7 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 723, MSLICE 0

  assign i2c_state_00000000xxxxxx10 = (i2c_state_r1 & ((i2c_state_00000000xxxxxxxx & ~i2c_state_r0)));
  assign i2c_state_00000000xxxx1110 = (i2c_state_r3 & ((i2c_state_r2 & i2c_state_00000000xxxxxx10)));

//---------------------------------------------------------------------------
//Block 724, LSLICE 2

  assign i2c_cmd68_e1 = (i2c_state_xxxxxxxxxxxx0100 & ((~i2c_send_enable & i2c_state_000000000011xxxx)));
  assign i2c_state_0000000000110xx1 = (~i2c_state_r0 & i2c_state_000000000011xxxx & ((~i2c_state_r2 & ~i2c_state_r3) | (i2c_state_r2 & ~i2c_state_r3))) | (i2c_state_r0 & i2c_state_000000000011xxxx & ((~i2c_state_r2 & ~i2c_state_r3)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd68_b1 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd68_e1 == 1'b1)   //enable
       begin
        i_i2c_cmd68_b1 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 725, LSLICE 3

  assign i2c_state_0000000011101101 = ((i2c_state_000000001110xxxx & i2c_state_xxxxxxxxxxxx1101));
  assign net_1481 = ((~i2c_state_0000000011101011 & ~i2c_state_0000000011101010));

//---------------------------------------------------------------------------
//Block 726, MSLICE 1

  assign sig_726_lut_0 = (~i2c_state_00000000xxxx0001 & i2c_state_xxxxxxxx1010xxxx & ((~i2c_state_xxxxxxxx1001xxxx & i2c_state_00000000xxxx1100) | (i2c_state_xxxxxxxx1001xxxx & i2c_state_00000000xxxx1100))) | (i2c_state_00000000xxxx0001 & ~i2c_state_xxxxxxxx1010xxxx & ((i2c_state_xxxxxxxx1001xxxx & ~i2c_state_00000000xxxx1100) | (i2c_state_xxxxxxxx1001xxxx & i2c_state_00000000xxxx1100))) | (i2c_state_00000000xxxx0001 & i2c_state_xxxxxxxx1010xxxx);
  assign sig_726_lut_1 = (~i2c_state_00000000xxxx0001 & ~i2c_state_xxxxxxxx1010xxxx & ((~i2c_state_00000000xxxx1100 & i2c_state_xxxxxxxx1001xxxx) | (i2c_state_00000000xxxx1100 & i2c_state_xxxxxxxx1001xxxx))) | (~i2c_state_00000000xxxx0001 & i2c_state_xxxxxxxx1010xxxx) | (i2c_state_00000000xxxx0001 & ~i2c_state_xxxxxxxx1010xxxx & ((~i2c_state_00000000xxxx1100 & i2c_state_xxxxxxxx1001xxxx) | (i2c_state_00000000xxxx1100 & i2c_state_xxxxxxxx1001xxxx))) | (i2c_state_00000000xxxx0001 & i2c_state_xxxxxxxx1010xxxx);
  assign net_1485 = (~i2c_state_00000000xxxx0011 & sig_726_lut_0) | (i2c_state_00000000xxxx0011 & sig_726_lut_1);

//---------------------------------------------------------------------------
//Block 727, LSLICE 2

  assign net_1487 = (net_1493 & ~i2c_state_xxxxxxxx1001xxxx & ~i2c_state_00000000xxxx0001 & (~(i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000111xxxx))) | (net_1493 & ~i2c_state_xxxxxxxx1001xxxx & i2c_state_00000000xxxx0001 & (~(i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000111xxxx))) | (net_1493 & i2c_state_xxxxxxxx1001xxxx & ~i2c_state_00000000xxxx0001 & (~(i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000111xxxx)));
  assign net_1489 = (net_1487 & net_1417 & ((~i2c_send_enable & ~i2c_state_0000000000000000)));

//---------------------------------------------------------------------------
//Block 728, LSLICE 3

  assign i2c_state_13_15 = (i2c_state_000000000000xxxx & ((i2c_state_xxxxxxxxxxxx1101 | i2c_state_xxxxxxxxxxxx1111)));
  assign i2c_state_0000000000000000 = ((i2c_state_000000000000xxxx & i2c_state_xxxxxxxxxxxx0000));

//---------------------------------------------------------------------------
//Block 729, MSLICE 1

  assign net_1488 = (i2c_state_000000000000xxxx & ~i2c_state_xxxxxxxxxxxx0011 & ((i2c_state_xxxxxxxxxxxx0101 | i2c_state_xxxxxxxxxxxx0001))) | (i2c_state_000000000000xxxx & i2c_state_xxxxxxxxxxxx0011);
  assign net_1492 = ((~net_1496 & ~i2c_state_000000000000xxxx));

//---------------------------------------------------------------------------
//Block 730, MSLICE 0

  assign i2c_state_00000000xxxx0001 = ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxxxxxx0001));
  assign net_1496 = (~i2c_state_00000000xxxx0000 & ((i2c_state_xxxxxxxx0001xxxx & i2c_state_00000000xxxx0001))) | (i2c_state_00000000xxxx0000 & ((i2c_state_xxxxxxxx0001xxxx & ~i2c_state_00000000xxxx0001) | (i2c_state_xxxxxxxx0001xxxx & i2c_state_00000000xxxx0001)));

//---------------------------------------------------------------------------
//Block 731, LSLICE 2

  assign net_1493 = (~i2c_state_xxxxxxxxxxxx0101 & ~i2c_state_000000000101xxxx & (~(i2c_state_xxxxxxxxxxxx0111 & i2c_state_000000000011xxxx))) | (~i2c_state_xxxxxxxxxxxx0101 & i2c_state_000000000101xxxx & (~(i2c_state_xxxxxxxxxxxx0111 & i2c_state_000000000011xxxx))) | (i2c_state_xxxxxxxxxxxx0101 & ~i2c_state_000000000101xxxx & (~(i2c_state_xxxxxxxxxxxx0111 & i2c_state_000000000011xxxx)));
  assign net_1499 = ((~net_1324 & net_1493));

//---------------------------------------------------------------------------
//Block 732, LSLICE 3

  assign i2c_state_00000000xxxx0000 = ((i2c_state_xxxxxxxxxxxx0000 & i2c_state_00000000xxxxxxxx));
  assign i2c_state_0000000010010000 = ((i2c_state_xxxxxxxx1001xxxx & i2c_state_00000000xxxx0000));

//---------------------------------------------------------------------------
//Block 733, MSLICE 1

  assign net_1500 = (~i2c_state_000000000000xxxx & ~i2c_state_xxxxxxxxxxxx0100 & (~(i2c_state_xxxxxxxx0001xxxx & i2c_state_00000000xxxx0000))) | (~i2c_state_000000000000xxxx & i2c_state_xxxxxxxxxxxx0100 & (~(i2c_state_xxxxxxxx0001xxxx & i2c_state_00000000xxxx0000))) | (i2c_state_000000000000xxxx & ~i2c_state_xxxxxxxxxxxx0100 & (~(i2c_state_xxxxxxxx0001xxxx & i2c_state_00000000xxxx0000)));
  assign i2c_state_0000000010110000 = ((i2c_state_00000000xxxx0000 & i2c_state_xxxxxxxx1011xxxx));

//---------------------------------------------------------------------------
//Block 734, MSLICE 0

  assign sig_734_lut_0 = (~i2c_state_000000001000xxxx & ~i2c_state_xxxxxxxxxxxx0111 & (~(i2c_state_xxxxxxxxxxxx0001 & i2c_state_000000001010xxxx))) | (~i2c_state_000000001000xxxx & i2c_state_xxxxxxxxxxxx0111 & (~(i2c_state_xxxxxxxxxxxx0001 & i2c_state_000000001010xxxx))) | (i2c_state_000000001000xxxx & ~i2c_state_xxxxxxxxxxxx0111 & (~(i2c_state_xxxxxxxxxxxx0001 & i2c_state_000000001010xxxx)));
  assign sig_734_lut_1 = 1'b0;
  assign net_1501 = (~net_1488 & sig_734_lut_0) | (net_1488 & sig_734_lut_1);

//---------------------------------------------------------------------------
//Block 735, LSLICE 2

  assign sig_735_lut_0 = (~cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b0) | (~cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b0 & ((~net_431 & ~io_mcu_d_0) | (~net_431 & io_mcu_d_0))) | (~cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b0) | (cmd69_write_enable & ~i_mcu_dcs & ~o_i2c_cmd69_b0 & ((~net_431 & io_mcu_d_0))) | (cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b0 & ((~net_431 & io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b0 & ((~net_431 & ~io_mcu_d_0) | (~net_431 & io_mcu_d_0))) | (cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b0);
  assign net_1503 = (i2c_state_000000000101xxxx & ((o_i2c_cmd69_b0 & i2c_state_xxxxxxxxxxxx0011)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd69_b0 <= sig_735_lut_0;
  end

//---------------------------------------------------------------------------
//Block 736, LSLICE 3

  assign sig_736_lut_0 = (~o_i2c_cmd68_b0 & cmd68_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (o_i2c_cmd68_b0 & ~cmd68_write_enable & ~i_mcu_dcs) | (o_i2c_cmd68_b0 & ~cmd68_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (o_i2c_cmd68_b0 & cmd68_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_0))) | (o_i2c_cmd68_b0 & cmd68_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_0) | (net_431 & io_mcu_d_0)));
  assign net_1504 = (~o_i2c_cmd68_b1 & o_i2c_cmd68_b0 & i2c_state_xxxxxxxxxxxx0101 & ((~i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000011xxxx) | (i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000011xxxx))) | (o_i2c_cmd68_b1 & ~o_i2c_cmd68_b0 & ~i2c_state_xxxxxxxxxxxx0101 & ((i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000011xxxx))) | (o_i2c_cmd68_b1 & ~o_i2c_cmd68_b0 & i2c_state_xxxxxxxxxxxx0101 & ((i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000011xxxx))) | (o_i2c_cmd68_b1 & o_i2c_cmd68_b0 & ~i2c_state_xxxxxxxxxxxx0101 & ((i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000011xxxx))) | (o_i2c_cmd68_b1 & o_i2c_cmd68_b0 & i2c_state_xxxxxxxxxxxx0101 & ((~i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000011xxxx) | (i2c_state_xxxxxxxxxxxx0011 & i2c_state_000000000011xxxx)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd68_b0 <= sig_736_lut_0;
  end

//---------------------------------------------------------------------------
//Block 737, MSLICE 1

  assign sig_737_lut_0 = (~i2c_state_000000001110xxxx & ~i2c_state_xxxxxxxxxxxx1111) | (~i2c_state_000000001110xxxx & i2c_state_xxxxxxxxxxxx1111 & ((~i2c_state_xxxxxxxxxxxx1011 & ~i2c_state_000000000000xxxx) | (i2c_state_xxxxxxxxxxxx1011 & ~i2c_state_000000000000xxxx))) | (i2c_state_000000001110xxxx & ~i2c_state_xxxxxxxxxxxx1111 & ((~i2c_state_xxxxxxxxxxxx1011 & ~i2c_state_000000000000xxxx) | (~i2c_state_xxxxxxxxxxxx1011 & i2c_state_000000000000xxxx)));
  assign sig_737_lut_1 = 1'b0;
  assign net_1506 = (~i2c_send_enable & sig_737_lut_0) | (i2c_send_enable & sig_737_lut_1);

//---------------------------------------------------------------------------
//Block 738, MSLICE 0

  assign sig_738_lut_0 = (~i2c_state_0000000000010011 & ~i2c_state_000000001110xxxx) | (~i2c_state_0000000000010011 & i2c_state_000000001110xxxx & (~(i2c_state_xxxxxxxxxxxx0001 & o_i2c_cmd6E_b4))) | (i2c_state_0000000000010011 & ~i2c_state_000000001110xxxx) | (i2c_state_0000000000010011 & i2c_state_000000001110xxxx & (~(i2c_state_xxxxxxxxxxxx0001 & o_i2c_cmd6E_b4)));
  assign sig_738_lut_1 = (~i2c_state_0000000000010011 & ~i2c_state_000000001110xxxx) | (~i2c_state_0000000000010011 & i2c_state_000000001110xxxx & (~(i2c_state_xxxxxxxxxxxx0001 & o_i2c_cmd6E_b4)));
  assign net_1507 = (~o_i2c_cmd68_b7 & sig_738_lut_0) | (o_i2c_cmd68_b7 & sig_738_lut_1);

//---------------------------------------------------------------------------
//Block 739, LSLICE 2

  assign sig_739_lut_0 = (~o_i2c_cmd6E_b1 & cmd6E_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (o_i2c_cmd6E_b1 & ~cmd6E_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6E_b1 & ~cmd6E_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (o_i2c_cmd6E_b1 & cmd6E_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_1))) | (o_i2c_cmd6E_b1 & cmd6E_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_1) | (net_431 & io_mcu_d_1)));
  assign net_1509 = (o_i2c_cmd6E_b1 & ((i2c_state_xxxxxxxxxxxx0111 & i2c_state_000000001110xxxx)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6E_b1 <= sig_739_lut_0;
  end

//---------------------------------------------------------------------------
//Block 740, LSLICE 3

  assign sig_740_lut_0 = (~o_i2c_cmd6D_b7 & cmd6D_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_7) | (net_431 & io_mcu_d_7))) | (o_i2c_cmd6D_b7 & ~cmd6D_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6D_b7 & ~cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_7) | (net_431 & io_mcu_d_7))) | (o_i2c_cmd6D_b7 & cmd6D_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_7))) | (o_i2c_cmd6D_b7 & cmd6D_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_7) | (net_431 & io_mcu_d_7)));
  assign net_1512 = (~net_1631 & ~i2c_out_cmd6E_b2 & ~net_1345 & (~(o_i2c_cmd6D_b7 & i2c_state_0000000010110001)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6D_b7 <= sig_740_lut_0;
  end

//---------------------------------------------------------------------------
//Block 741, MSLICE 1

  assign sig_741_lut_0 = 1'b0;
  assign sig_741_lut_1 = (~i2c_state_000000000110xxxx & ~o_i2c_cmd6A_b4 & ((o_i2c_cmd69_b7 & i2c_state_000000000011xxxx))) | (~i2c_state_000000000110xxxx & o_i2c_cmd6A_b4 & ((o_i2c_cmd69_b7 & i2c_state_000000000011xxxx))) | (i2c_state_000000000110xxxx & ~o_i2c_cmd6A_b4 & ((o_i2c_cmd69_b7 & i2c_state_000000000011xxxx))) | (i2c_state_000000000110xxxx & o_i2c_cmd6A_b4);
  assign net_1511 = (~i2c_state_xxxxxxxxxxxx1001 & sig_741_lut_0) | (i2c_state_xxxxxxxxxxxx1001 & sig_741_lut_1);

//---------------------------------------------------------------------------
//Block 742, MSLICE 0

  assign sig_742_lut_0 = (cmd6B_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_5) | (net_431 & io_mcu_d_5)));
  assign sig_742_lut_1 = (~cmd6B_write_enable & ~io_mcu_d_5 & (~(~net_431 & i_mcu_dcs))) | (~cmd6B_write_enable & io_mcu_d_5 & (~(~net_431 & i_mcu_dcs))) | (cmd6B_write_enable & ~io_mcu_d_5 & ((net_431 & ~i_mcu_dcs) | (net_431 & i_mcu_dcs))) | (cmd6B_write_enable & io_mcu_d_5 & (~(~net_431 & i_mcu_dcs)));
  assign sig_742_ff0_d = (~o_i2c_cmd6B_b5 & sig_742_lut_0) | (o_i2c_cmd6B_b5 & sig_742_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6B_b5 <= sig_742_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 743, LSLICE 2

  assign sig_743_lut_0 = (~o_i2c_cmd6A_b6 & cmd6A_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_6) | (net_431 & io_mcu_d_6))) | (o_i2c_cmd6A_b6 & ~cmd6A_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6A_b6 & ~cmd6A_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_6) | (net_431 & io_mcu_d_6))) | (o_i2c_cmd6A_b6 & cmd6A_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_6))) | (o_i2c_cmd6A_b6 & cmd6A_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_6) | (net_431 & io_mcu_d_6)));
  assign net_1516 = (o_i2c_cmd6A_b6 & ((i2c_state_000000000110xxxx & i2c_state_xxxxxxxxxxxx0101)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6A_b6 <= sig_743_lut_0;
  end

//---------------------------------------------------------------------------
//Block 744, MSLICE 1

  assign sig_744_lut_0 = (~i_mcu_dcs & o_i2c_cmd6A_b4) | (i_mcu_dcs & ~o_i2c_cmd6A_b4 & ((~net_431 & ~io_mcu_d_4) | (~net_431 & io_mcu_d_4))) | (i_mcu_dcs & o_i2c_cmd6A_b4);
  assign sig_744_lut_1 = (~i_mcu_dcs & ~o_i2c_cmd6A_b4 & ((~net_431 & io_mcu_d_4))) | (~i_mcu_dcs & o_i2c_cmd6A_b4 & ((~net_431 & io_mcu_d_4) | (net_431 & io_mcu_d_4))) | (i_mcu_dcs & ~o_i2c_cmd6A_b4 & ((~net_431 & ~io_mcu_d_4) | (~net_431 & io_mcu_d_4))) | (i_mcu_dcs & o_i2c_cmd6A_b4);
  assign sig_744_ff0_d = (~cmd6A_write_enable & sig_744_lut_0) | (cmd6A_write_enable & sig_744_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6A_b4 <= sig_744_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 745, LSLICE 2

  assign sig_745_lut_0 = (~o_i2c_cmd68_b5 & cmd68_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_5) | (net_431 & io_mcu_d_5))) | (o_i2c_cmd68_b5 & ~cmd68_write_enable & ~i_mcu_dcs) | (o_i2c_cmd68_b5 & ~cmd68_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_5) | (net_431 & io_mcu_d_5))) | (o_i2c_cmd68_b5 & cmd68_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_5))) | (o_i2c_cmd68_b5 & cmd68_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_5) | (net_431 & io_mcu_d_5)));
  assign net_1519 = (i2c_state_xxxxxxxxxxxx1011 & ((o_i2c_cmd68_b5 & i2c_state_000000000010xxxx)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd68_b5 <= sig_745_lut_0;
  end

//---------------------------------------------------------------------------
//Block 746, LSLICE 3

  assign sig_746_lut_0 = (~o_i2c_cmd68_b1 & cmd68_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (o_i2c_cmd68_b1 & ~cmd68_write_enable & ~i_mcu_dcs) | (o_i2c_cmd68_b1 & ~cmd68_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (o_i2c_cmd68_b1 & cmd68_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_1))) | (o_i2c_cmd68_b1 & cmd68_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_1) | (net_431 & io_mcu_d_1)));
  assign sig_746_lut_1 = (~o_i2c_cmd68_b3 & ~i_mcu_dcs & cmd68_write_enable & ((~net_431 & io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd68_b3 & ~i_mcu_dcs & ~cmd68_write_enable) | (o_i2c_cmd68_b3 & ~i_mcu_dcs & cmd68_write_enable & ((net_431 | io_mcu_d_3))) | (o_i2c_cmd68_b3 & i_mcu_dcs & ~cmd68_write_enable & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd68_b3 & i_mcu_dcs & cmd68_write_enable & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd68_b1 <= sig_746_lut_0;
    o_i2c_cmd68_b3 <= sig_746_lut_1;
  end

//---------------------------------------------------------------------------
//Block 751, LSLICE 3

  always @(posedge clock_200MHz)
  begin
    if(i2c_clk_rst == 1'b1)   //reset
    begin
      i2c_clk_div_reg9 <= 1'b0;
      i2c_clk_div_reg8 <= 1'b0;
    end
    else
    begin
      i2c_clk_div_reg9 <= i2c_clk_div_out9;
      i2c_clk_div_reg8 <= i2c_clk_div_out8;
    end
  end

//---------------------------------------------------------------------------
//Block 752, LSLICE 3

  assign i2c_state_xxxxxxxx0000xxxx = (~i2c_state_r6 & ~i2c_state_r5 & ((~i2c_state_r7 & ~i2c_state_r4)));
  assign i2c_state_xxxxxxxx1001xxxx = (i2c_state_r7 & i2c_state_r4 & ((~i2c_state_r5 & ~i2c_state_r6)));

//---------------------------------------------------------------------------
//Block 753, MSLICE 0

  assign i2c_state_xxxxxxxx0001xxxx = (i2c_state_r4 & ~i2c_state_r7 & ((~i2c_state_r6 & ~i2c_state_r5)));
  assign i2c_state_xxxxxxxx1111xxxx = (i2c_state_r6 & i2c_state_r7 & ((i2c_state_r5 & i2c_state_r4)));

//---------------------------------------------------------------------------
//Block 754, LSLICE 2

  assign i2c_state_000000000010xxxx = (i2c_state_xxxxxxxxxx10xxxx & i2c_state_00000000xxxxxxxx & ((~i2c_state_r7 & ~i2c_state_r6)));
  assign i2c_state_xxxxxxxx0010xxxx = (~i2c_state_r6 & ((i2c_state_xxxxxxxxxx10xxxx & ~i2c_state_r7)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r6 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r6 <= i2c_state_c6;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 755, LSLICE 3

  assign i2c_state_00000000xxxx1010 = (i2c_state_r3 & ((~i2c_state_r2 & i2c_state_00000000xxxxxx10)));
  assign i2c_state_xxxxxxxx00010010 = (i2c_state_xxxxxxxxxxxx00xx & ((i2c_state_xxxxxxxx0001xxxx & i2c_state_00000000xxxxxx10)));

//---------------------------------------------------------------------------
//Block 756, MSLICE 1

  assign sig_756_lut_0 = ~i2c_clock;
  assign net_1527 = (i2c_state_r9 & i2c_state_r8 & ((i2c_state_r10 & ~i2c_state_xxxxxxxx0000xxxx)));

  always @(posedge clock_200MHz)
  begin
    if(i2c_clk_rst == 1'b1)   //enable
     begin
      i2c_clock <= sig_756_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 757, LSLICE 2

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r1 <= 1'b0;
      i2c_state_r2 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r1 <= i2c_state_c1;
        i2c_state_r2 <= i2c_state_c2;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 758, LSLICE 3

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r3 <= 1'b0;
      i2c_state_r4 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r3 <= i2c_state_c3;
        i2c_state_r4 <= i2c_state_c4;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 760, LSLICE 2

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r10 <= 1'b0;
      i2c_state_r7 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r10 <= i2c_state_c10;
        i2c_state_r7 <= i2c_state_c7;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 761, LSLICE 3

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r11 <= 1'b0;
      i2c_state_r12 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r11 <= i2c_state_c11;
        i2c_state_r12 <= i2c_state_c12;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 763, LSLICE 2

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r15 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r15 <= i2c_state_c15;
      end
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 757, 758, 760, 761, 763

  assign { i2c_state_c15, i2c_state_c14, i2c_state_c13, i2c_state_c12, i2c_state_c11, i2c_state_c10, i2c_state_c9, i2c_state_c8, i2c_state_c7, i2c_state_c6, i2c_state_c5, i2c_state_c4, i2c_state_c3, i2c_state_c2, i2c_state_c1, i2c_state_c0 } = { i2c_state_r15, i2c_state_r14, i2c_state_r13, i2c_state_r12, i2c_state_r11, i2c_state_r10, i2c_state_r9, i2c_state_r8, i2c_state_r7, i2c_state_r6, i2c_state_r5, i2c_state_r4, i2c_state_r3, i2c_state_r2, i2c_state_r1, i2c_state_r0 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 759, MSLICE 1

  assign sig_759_lut_0 = 1'b0;
  assign sig_759_lut_1 = (i2c_state_00000000xxxxxxxx & ~i2c_state_r1 & ((~i2c_state_r0 & ~i2c_state_r2)));
  assign i2c_state_00000000xxxx1000 = (~i2c_state_r3 & sig_759_lut_0) | (i2c_state_r3 & sig_759_lut_1);

//---------------------------------------------------------------------------
//Block 762, MSLICE 0

  assign i2c_state_xxxxxxxxxxxx00xx = ((~i2c_state_r2 & ~i2c_state_r3));
  assign net_1562 = (~i2c_state_00000000xxxxxx10 & ((i2c_state_00000000xxxx1100 & i2c_state_xxxxxxxx0000xxxx))) | (i2c_state_00000000xxxxxx10 & ((~i2c_state_00000000xxxx1100 & i2c_state_xxxxxxxx0000xxxx) | (i2c_state_00000000xxxx1100 & i2c_state_xxxxxxxx0000xxxx)));

//---------------------------------------------------------------------------
//Block 764, LSLICE 3

  assign net_1564 = (~i2c_state_0000000010010010 & ~i2c_state_0000000010110000 & (~(i2c_state_xxxxxxxxxxxx1111 & i2c_state_000000001010xxxx)));
  assign i2c_state_0000000010010010 = (i2c_state_xxxxxxxxxxxx00xx & ((i2c_state_xxxxxxxx1001xxxx & i2c_state_00000000xxxxxx10)));

//---------------------------------------------------------------------------
//Block 765, MSLICE 1

  assign sig_765_lut_0 = 1'b0;
  assign sig_765_lut_1 = (~i2c_state_r3 & ~i2c_state_r1 & ((i2c_state_r0 & i2c_state_r2))) | (~i2c_state_r3 & i2c_state_r1 & ((~i2c_state_r0 & ~i2c_state_r2) | (i2c_state_r0 & ~i2c_state_r2))) | (i2c_state_r3 & ~i2c_state_r1 & ((~i2c_state_r0 & ~i2c_state_r2)));
  assign net_1561 = (~i2c_state_000000000011xxxx & sig_765_lut_0) | (i2c_state_000000000011xxxx & sig_765_lut_1);

//---------------------------------------------------------------------------
//Block 766, LSLICE 2

  assign i2c_cmd6A_e1 = (~i2c_send_enable & ((i2c_state_xxxxxxxxxxxx0000 & i2c_state_000000000111xxxx)));
  assign net_1568 = (~i2c_state_xxxxxxxxxxxx0011 & ~net_1561 & ((~i2c_state_000000000111xxxx & ~i2c_state_000000001100xxxx) | (i2c_state_000000000111xxxx & ~i2c_state_000000001100xxxx))) | (i2c_state_xxxxxxxxxxxx0011 & ~net_1561 & ((~i2c_state_000000000111xxxx & ~i2c_state_000000001100xxxx)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6A_b1 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6A_e1 == 1'b1)   //enable
       begin
        i_i2c_cmd6A_b1 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 767, MSLICE 1

  assign i2c_state_xxxxxxxxxxxx10x1 = (i2c_state_r3 & ((i2c_state_r0 & ~i2c_state_r2)));
  assign i2c_state_xxxxxxxxxxxx1001 = ((~i2c_state_r1 & i2c_state_xxxxxxxxxxxx10x1));

//---------------------------------------------------------------------------
//Block 768, LSLICE 3

  assign sig_768_lut_0 = (~o_i2c_cmd6E_b3 & cmd6E_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd6E_b3 & ~cmd6E_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6E_b3 & ~cmd6E_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3))) | (o_i2c_cmd6E_b3 & cmd6E_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_3))) | (o_i2c_cmd6E_b3 & cmd6E_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_3) | (net_431 & io_mcu_d_3)));
  assign net_1571 = (~o_i2c_cmd6E_b3 & ~i2c_state_xxxxxxxx1110xxxx & o_i2c_cmd6D_b4 & ((i2c_state_00000000xxxx0011 & i2c_state_xxxxxxxx1100xxxx))) | (~o_i2c_cmd6E_b3 & i2c_state_xxxxxxxx1110xxxx & o_i2c_cmd6D_b4 & ((i2c_state_00000000xxxx0011 & i2c_state_xxxxxxxx1100xxxx))) | (o_i2c_cmd6E_b3 & ~i2c_state_xxxxxxxx1110xxxx & o_i2c_cmd6D_b4 & ((i2c_state_00000000xxxx0011 & i2c_state_xxxxxxxx1100xxxx))) | (o_i2c_cmd6E_b3 & i2c_state_xxxxxxxx1110xxxx & ~o_i2c_cmd6D_b4 & ((i2c_state_00000000xxxx0011 & ~i2c_state_xxxxxxxx1100xxxx) | (i2c_state_00000000xxxx0011 & i2c_state_xxxxxxxx1100xxxx))) | (o_i2c_cmd6E_b3 & i2c_state_xxxxxxxx1110xxxx & o_i2c_cmd6D_b4 & ((i2c_state_00000000xxxx0011 & ~i2c_state_xxxxxxxx1100xxxx) | (i2c_state_00000000xxxx0011 & i2c_state_xxxxxxxx1100xxxx)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6E_b3 <= sig_768_lut_0;
  end

//---------------------------------------------------------------------------
//Block 769, MSLICE 0

  assign i2c_state_xxxxxxxxxxxx1011 = ((i2c_state_r1 & i2c_state_xxxxxxxxxxxx10x1));
  assign i2c_state_0000000011101011 = ((i2c_state_000000001110xxxx & i2c_state_xxxxxxxxxxxx1011));

//---------------------------------------------------------------------------
//Block 770, LSLICE 2

  assign i2c_state_00000000xxxx0011 = ((i2c_state_xxxxxxxxxxxx0011 & i2c_state_00000000xxxxxxxx));
  assign i2c_state_0000000000010011 = ((i2c_state_xxxxxxxx0001xxxx & i2c_state_00000000xxxx0011));

//---------------------------------------------------------------------------
//Block 771, LSLICE 3

  assign i2c_state_0000000010010011 = ((i2c_state_xxxxxxxx1001xxxx & i2c_state_00000000xxxx0011));
  assign i2c_state_0000000010110001 = ((i2c_state_xxxxxxxx1011xxxx & i2c_state_00000000xxxx0001));

//---------------------------------------------------------------------------
//Block 772, MSLICE 1

  assign i2c_state_195_203 = (i2c_state_xxxxxxxx1100xxxx & i2c_state_00000000xxxxxxxx & ((i2c_state_xxxxxxxxxxxx1011 | i2c_state_xxxxxxxxxxxx0011)));
  assign i2c_state_000000001100xxxx = ((i2c_state_00000000xxxxxxxx & i2c_state_xxxxxxxx1100xxxx));

//---------------------------------------------------------------------------
//Block 773, MSLICE 0

  assign i2c_cmd6B_e4 = (~i2c_send_enable & ((i2c_state_000000001000xxxx & i2c_state_xxxxxxxxxxxx1000)));
  assign net_1585 = (~i2c_state_0000000001110001 & ~i2c_state_000000000110xxxx) | (~i2c_state_0000000001110001 & i2c_state_000000000110xxxx & ((~i2c_state_xxxxxxxxxxxx1000 & ~i2c_state_r2)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6B_b4 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6B_e4 == 1'b1)   //enable
       begin
        i_i2c_cmd6B_b4 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 774, LSLICE 2

  assign sig_774_lut_0 = (~cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b1) | (~cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b1 & ((~net_431 & ~io_mcu_d_1) | (~net_431 & io_mcu_d_1))) | (~cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b1) | (cmd69_write_enable & ~i_mcu_dcs & ~o_i2c_cmd69_b1 & ((~net_431 & io_mcu_d_1))) | (cmd69_write_enable & ~i_mcu_dcs & o_i2c_cmd69_b1 & ((~net_431 & io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (cmd69_write_enable & i_mcu_dcs & ~o_i2c_cmd69_b1 & ((~net_431 & ~io_mcu_d_1) | (~net_431 & io_mcu_d_1))) | (cmd69_write_enable & i_mcu_dcs & o_i2c_cmd69_b1);
  assign net_1581 = (i2c_state_000000000101xxxx & ((i2c_state_xxxxxxxxxxxx0001 & o_i2c_cmd69_b1)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd69_b1 <= sig_774_lut_0;
  end

//---------------------------------------------------------------------------
//Block 775, MSLICE 1

  assign i2c_cmd6C_e7 = ((~i2c_send_enable & net_1157));
  assign net_1586 = (~i_i2c_cmd6C_b7 & ~i_adc2B_d_7) | (~i_i2c_cmd6C_b7 & i_adc2B_d_7 & ((~cmd27_select & ~cmd6C_select) | (~cmd27_select & cmd6C_select))) | (i_i2c_cmd6C_b7 & ~i_adc2B_d_7 & ((~cmd27_select & ~cmd6C_select) | (cmd27_select & ~cmd6C_select))) | (i_i2c_cmd6C_b7 & i_adc2B_d_7 & ((~cmd27_select & ~cmd6C_select)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6C_b7 <= 1'b0;
    end
    else
    begin
      if(i2c_cmd6C_e7 == 1'b1)   //enable
       begin
        i_i2c_cmd6C_b7 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 776, LSLICE 3

  assign sig_776_lut_0 = (~o_i2c_cmd6B_b7 & cmd6B_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_7) | (net_431 & io_mcu_d_7))) | (o_i2c_cmd6B_b7 & ~cmd6B_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6B_b7 & ~cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_7) | (net_431 & io_mcu_d_7))) | (o_i2c_cmd6B_b7 & cmd6B_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_7))) | (o_i2c_cmd6B_b7 & cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_7) | (net_431 & io_mcu_d_7)));
  assign net_1588 = (i2c_state_000000000111xxxx & ((i2c_state_xxxxxxxxxxxx0101 & o_i2c_cmd6B_b7)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6B_b7 <= sig_776_lut_0;
  end

//---------------------------------------------------------------------------
//Block 777, LSLICE 2

  assign sig_777_lut_0 = (~o_i2c_cmd6C_b6 & cmd6C_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_6) | (net_431 & io_mcu_d_6))) | (o_i2c_cmd6C_b6 & ~cmd6C_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6C_b6 & ~cmd6C_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_6) | (net_431 & io_mcu_d_6))) | (o_i2c_cmd6C_b6 & cmd6C_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_6))) | (o_i2c_cmd6C_b6 & cmd6C_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_6) | (net_431 & io_mcu_d_6)));
  assign net_1592 = (i2c_state_xxxxxxxxxxxx0001 & ((i2c_state_000000001010xxxx & o_i2c_cmd6C_b6)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6C_b6 <= sig_777_lut_0;
  end

//---------------------------------------------------------------------------
//Block 778, LSLICE 3

  assign sig_778_lut_0 = (~cmd6A_write_enable & ~i_mcu_dcs & o_i2c_cmd6A_b5) | (~cmd6A_write_enable & i_mcu_dcs & ~o_i2c_cmd6A_b5 & ((~net_431 & ~io_mcu_d_5) | (~net_431 & io_mcu_d_5))) | (~cmd6A_write_enable & i_mcu_dcs & o_i2c_cmd6A_b5) | (cmd6A_write_enable & ~i_mcu_dcs & ~o_i2c_cmd6A_b5 & ((~net_431 & io_mcu_d_5))) | (cmd6A_write_enable & ~i_mcu_dcs & o_i2c_cmd6A_b5 & ((~net_431 & io_mcu_d_5) | (net_431 & io_mcu_d_5))) | (cmd6A_write_enable & i_mcu_dcs & ~o_i2c_cmd6A_b5 & ((~net_431 & ~io_mcu_d_5) | (~net_431 & io_mcu_d_5))) | (cmd6A_write_enable & i_mcu_dcs & o_i2c_cmd6A_b5);
  assign net_1590 = (i2c_state_xxxxxxxxxxxx0111 & ((i2c_state_000000000110xxxx & o_i2c_cmd6A_b5)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6A_b5 <= sig_778_lut_0;
  end

//---------------------------------------------------------------------------
//Block 779, MSLICE 1

  assign sig_779_lut_0 = (cmd68_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_7) | (net_431 & io_mcu_d_7)));
  assign sig_779_lut_1 = (~io_mcu_d_7 & ~i_mcu_dcs & (~(~net_431 & cmd68_write_enable))) | (~io_mcu_d_7 & i_mcu_dcs & ((net_431 & ~cmd68_write_enable) | (net_431 & cmd68_write_enable))) | (io_mcu_d_7 & ~i_mcu_dcs) | (io_mcu_d_7 & i_mcu_dcs & ((net_431 & ~cmd68_write_enable) | (net_431 & cmd68_write_enable)));
  assign sig_779_ff0_d = (~o_i2c_cmd68_b7 & sig_779_lut_0) | (o_i2c_cmd68_b7 & sig_779_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd68_b7 <= sig_779_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 780, MSLICE 0

  assign sig_780_lut_0 = (~i_mcu_dcs & o_i2c_cmd69_b7) | (i_mcu_dcs & ~o_i2c_cmd69_b7 & ((~net_431 & ~io_mcu_d_7) | (~net_431 & io_mcu_d_7))) | (i_mcu_dcs & o_i2c_cmd69_b7);
  assign sig_780_lut_1 = (~i_mcu_dcs & io_mcu_d_7 & (~(net_431 & ~o_i2c_cmd69_b7))) | (i_mcu_dcs & ~io_mcu_d_7 & (~(net_431 & ~o_i2c_cmd69_b7))) | (i_mcu_dcs & io_mcu_d_7 & (~(net_431 & ~o_i2c_cmd69_b7)));
  assign sig_780_ff0_d = (~cmd69_write_enable & sig_780_lut_0) | (cmd69_write_enable & sig_780_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd69_b7 <= sig_780_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 781, MSLICE 1

  assign sig_781_lut_0 = (cmd68_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_6) | (net_431 & io_mcu_d_6)));
  assign sig_781_lut_1 = (~io_mcu_d_6 & ~i_mcu_dcs & (~(~net_431 & cmd68_write_enable))) | (~io_mcu_d_6 & i_mcu_dcs & ((net_431 & ~cmd68_write_enable) | (net_431 & cmd68_write_enable))) | (io_mcu_d_6 & ~i_mcu_dcs) | (io_mcu_d_6 & i_mcu_dcs & ((net_431 & ~cmd68_write_enable) | (net_431 & cmd68_write_enable)));
  assign sig_781_ff0_d = (~o_i2c_cmd68_b6 & sig_781_lut_0) | (o_i2c_cmd68_b6 & sig_781_lut_1);

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd68_b6 <= sig_781_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 782, LSLICE 3

  assign sig_782_lut_0 = (~o_i2c_cmd68_b4 & cmd68_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_4) | (net_431 & io_mcu_d_4))) | (o_i2c_cmd68_b4 & ~cmd68_write_enable & ~i_mcu_dcs) | (o_i2c_cmd68_b4 & ~cmd68_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_4) | (net_431 & io_mcu_d_4))) | (o_i2c_cmd68_b4 & cmd68_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_4))) | (o_i2c_cmd68_b4 & cmd68_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_4) | (net_431 & io_mcu_d_4)));
  assign net_1598 = (~net_1519 & ~i2c_state_000000000010xxxx & ~i2c_state_xxxxxxxxxxxx1101) | (~net_1519 & ~i2c_state_000000000010xxxx & i2c_state_xxxxxxxxxxxx1101) | (~net_1519 & i2c_state_000000000010xxxx & ~i2c_state_xxxxxxxxxxxx1101 & ((~o_i2c_cmd68_b4 & ~net_1600) | (o_i2c_cmd68_b4 & ~net_1600))) | (~net_1519 & i2c_state_000000000010xxxx & i2c_state_xxxxxxxxxxxx1101 & ((~o_i2c_cmd68_b4 & ~net_1600)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd68_b4 <= sig_782_lut_0;
  end

//---------------------------------------------------------------------------
//Block 783, LSLICE 2

  assign net_1600 = ((o_i2c_cmd68_b3 & i2c_state_xxxxxxxxxxxx1111));
  assign net_1599 = (~net_1427 & net_1644 & ((net_1641 & net_1598)));

//---------------------------------------------------------------------------
//Block 814, LSLICE 3

  assign net_1604 = (~net_1527 & ~i2c_state_r11 & ((i2c_state_r13 & i2c_state_r12))) | (~net_1527 & i2c_state_r11 & ((i2c_state_r13 & ~i2c_state_r12) | (i2c_state_r13 & i2c_state_r12))) | (net_1527 & ~i2c_state_r11 & ((i2c_state_r13 & ~i2c_state_r12) | (i2c_state_r13 & i2c_state_r12))) | (net_1527 & i2c_state_r11 & ((i2c_state_r13 & ~i2c_state_r12) | (i2c_state_r13 & i2c_state_r12)));
  assign net_1605 = ((~i2c_send_enable & i2c_state_00000000xxxx1100));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r13 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r13 <= i2c_state_c13;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 815, MSLICE 1

  assign sig_815_lut_0 = (~net_1612 & ~i2c_state_r8) | (~net_1612 & i2c_state_r8) | (net_1612 & ~i2c_state_r8) | (net_1612 & i2c_state_r8);
  assign sig_815_lut_1 = (~net_1612 & i2c_state_r8 & (~(i2c_send_enable & i2c_state_xxxxxxxx0000xxxx))) | (net_1612 & ~i2c_state_r8) | (net_1612 & i2c_state_r8);
  assign sig_815_ff0_d = (~i2c_session_enable & sig_815_lut_0) | (i2c_session_enable & sig_815_lut_1);

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_session_done <= 1'b0;
    end
    else
    begin
      i2c_session_done <= sig_815_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 816, LSLICE 2

  assign i2c_session_enable = (i2c_state_0000xxxxxxxxxxxx & ~i2c_session_done & ~i2c_state_r9 & ((~i2c_state_r11 & ~i2c_state_r10)));
  assign i2c_state_00000000xxxxxxxx = (i2c_state_0000xxxxxxxxxxxx & ~i2c_state_r9 & ~i2c_state_r8 & ((~i2c_state_r11 & ~i2c_state_r10)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r9 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r9 <= i2c_state_c9;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 817, LSLICE 3

  assign net_1612 = (i2c_state_r3 & ~i2c_state_r8 & net_1611) | (i2c_state_r3 & i2c_state_r8 & ~net_1611 & ((i2c_state_r2 | i2c_state_r1))) | (i2c_state_r3 & i2c_state_r8 & net_1611);
  assign net_1611 = (i2c_state_xxxxxxxx1111xxxx & ~i2c_send_enable & ~i2c_state_r2 & ((i2c_state_r0 & i2c_state_r1))) | (i2c_state_xxxxxxxx1111xxxx & ~i2c_send_enable & i2c_state_r2);

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r8 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r8 <= i2c_state_c8;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 818, MSLICE 0

  assign net_1615 = (~i2c_state_r14 & ((~i2c_state_r15 & ~net_1604)));
  assign i2c_state_0000xxxxxxxxxxxx = (~i2c_state_r15 & ~i2c_state_r14 & ((~i2c_state_r13 & ~i2c_state_r12)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i2c_state_r0 <= 1'b0;
      i2c_state_r14 <= 1'b0;
    end
    else
    begin
      if(net_1615 == 1'b1)   //enable
       begin
        i2c_state_r0 <= i2c_state_c0;
        i2c_state_r14 <= i2c_state_c14;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 819, LSLICE 2

  assign i2c_cmd6A_e5 = (i2c_state_000000000110xxxx & ((~i2c_send_enable & i2c_state_xxxxxxxxxxxx1000)));
  assign i2c_state_xxxxxxxxxxxx1000 = (~i2c_state_r0 & i2c_state_r3 & ((~i2c_state_r2 & ~i2c_state_r1)));

  always @(posedge i2c_clock)
  begin
    if(i2c_rcv_rst == 1'b0)   //reset
    begin
      i_i2c_cmd6A_b5 <= 1'b1;
    end
    else
    begin
      if(i2c_cmd6A_e5 == 1'b1)   //enable
       begin
        i_i2c_cmd6A_b5 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 820, LSLICE 3

  assign net_1619 = (~i2c_state_r1 & ~i2c_state_r2 & ((i2c_state_000000001110xxxx & ~i2c_state_r3) | (i2c_state_000000001110xxxx & i2c_state_r3))) | (~i2c_state_r1 & i2c_state_r2 & ((i2c_state_000000001110xxxx & ~i2c_state_r3))) | (i2c_state_r1 & i2c_state_r2 & ((i2c_state_000000001110xxxx & ~i2c_state_r3)));
  assign i2c_state_xxxxxxxxxxxx01xx = ((~i2c_state_r3 & i2c_state_r2));

//---------------------------------------------------------------------------
//Block 821, MSLICE 1

  assign sig_821_lut_0 = 1'b0;
  assign sig_821_lut_1 = (i2c_state_r2 & ~i2c_state_r1 & ((~i2c_state_r0 & i2c_state_00000000xxxxxxxx)));
  assign i2c_state_00000000xxxx1100 = (~i2c_state_r3 & sig_821_lut_0) | (i2c_state_r3 & sig_821_lut_1);

//---------------------------------------------------------------------------
//Block 822, MSLICE 0

  assign i2c_state_xxxxxxxxxxxx1111 = (i2c_state_r3 & i2c_state_r2 & ((i2c_state_r1 & i2c_state_r0)));
  assign i2c_state_xxxxxxxxxxxx1101 = (~i2c_state_r1 & i2c_state_r2 & ((i2c_state_r3 & i2c_state_r0)));

//---------------------------------------------------------------------------
//Block 823, LSLICE 2

  assign i2c_state_xxxxxxxxxxxx0010 = (i2c_state_r1 & ((~i2c_state_r0 & i2c_state_xxxxxxxxxxxx00xx)));
  assign i2c_state_xxxxxxxxxxxx0000 = (i2c_state_xxxxxxxxxxxx00xx & ((~i2c_state_r0 & ~i2c_state_r1)));

//---------------------------------------------------------------------------
//Block 824, LSLICE 3

  assign i2c_state_195_196 = (i2c_state_xxxxxxxx1100xxxx & i2c_state_00000000xxxxxxxx & ((i2c_state_xxxxxxxxxxxx0011 | i2c_state_xxxxxxxxxxxx0100)));
  assign net_1628 = (~i2c_state_195_196 & ~i2c_state_00000000xxxx1100 & (~(i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx1101))) | (~i2c_state_195_196 & i2c_state_00000000xxxx1100 & ((~i2c_state_000000001010xxxx & ~i2c_state_xxxxxxxxxxxx1101) | (~i2c_state_000000001010xxxx & i2c_state_xxxxxxxxxxxx1101)));

//---------------------------------------------------------------------------
//Block 825, MSLICE 0

  assign i2c_state_xxxxxxxxxxxx0011 = (i2c_state_xxxxxxxxxxxx00xx & ((i2c_state_r1 & i2c_state_r0)));
  assign i2c_state_xxxxxxxxxxxx0001 = (~i2c_state_r1 & ((i2c_state_r0 & i2c_state_xxxxxxxxxxxx00xx)));

//---------------------------------------------------------------------------
//Block 826, LSLICE 3

  assign sig_826_lut_0 = (~o_i2c_cmd6B_b6 & cmd6B_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_6) | (net_431 & io_mcu_d_6))) | (o_i2c_cmd6B_b6 & ~cmd6B_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6B_b6 & ~cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_6) | (net_431 & io_mcu_d_6))) | (o_i2c_cmd6B_b6 & cmd6B_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_6))) | (o_i2c_cmd6B_b6 & cmd6B_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_6) | (net_431 & io_mcu_d_6)));
  assign net_1631 = (i2c_state_00000000xxxx0011 & ((i2c_state_xxxxxxxx1000xxxx & o_i2c_cmd6B_b6)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6B_b6 <= sig_826_lut_0;
  end

//---------------------------------------------------------------------------
//Block 827, LSLICE 2

  assign i2c_state_xxxxxxxxxxxx0111 = (i2c_state_xxxxxxxxxxxx01xx & ((i2c_state_r0 & i2c_state_r1)));
  assign i2c_state_xxxxxxxxxxxx0101 = (i2c_state_xxxxxxxxxxxx01xx & ((~i2c_state_r1 & i2c_state_r0)));

//---------------------------------------------------------------------------
//Block 828, MSLICE 1

  assign i2c_state_xxxxxxxxxxxx0100 = (~i2c_state_r0 & ((i2c_state_xxxxxxxxxxxx01xx & ~i2c_state_r1)));
  assign i2c_state_xxxxxxxxxxxx0110 = (~i2c_state_r0 & ((i2c_state_r1 & i2c_state_xxxxxxxxxxxx01xx)));

//---------------------------------------------------------------------------
//Block 829, LSLICE 2

  assign sig_829_lut_0 = (~o_i2c_cmd68_b2 & cmd68_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_2) | (net_431 & io_mcu_d_2))) | (o_i2c_cmd68_b2 & ~cmd68_write_enable & ~i_mcu_dcs) | (o_i2c_cmd68_b2 & ~cmd68_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_2) | (net_431 & io_mcu_d_2))) | (o_i2c_cmd68_b2 & cmd68_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_2))) | (o_i2c_cmd68_b2 & cmd68_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_2) | (net_431 & io_mcu_d_2)));
  assign i2c_out_cmd68_b2 = (i2c_state_000000000011xxxx & ((i2c_state_xxxxxxxxxxxx0001 & o_i2c_cmd68_b2)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd68_b2 <= sig_829_lut_0;
  end

//---------------------------------------------------------------------------
//Block 830, LSLICE 3

  assign sig_830_lut_0 = (~cmd6A_write_enable & ~i_mcu_dcs & o_i2c_cmd6A_b2) | (~cmd6A_write_enable & i_mcu_dcs & ~o_i2c_cmd6A_b2 & ((~net_431 & ~io_mcu_d_2) | (~net_431 & io_mcu_d_2))) | (~cmd6A_write_enable & i_mcu_dcs & o_i2c_cmd6A_b2) | (cmd6A_write_enable & ~i_mcu_dcs & ~o_i2c_cmd6A_b2 & ((~net_431 & io_mcu_d_2))) | (cmd6A_write_enable & ~i_mcu_dcs & o_i2c_cmd6A_b2 & ((~net_431 & io_mcu_d_2) | (net_431 & io_mcu_d_2))) | (cmd6A_write_enable & i_mcu_dcs & ~o_i2c_cmd6A_b2 & ((~net_431 & ~io_mcu_d_2) | (~net_431 & io_mcu_d_2))) | (cmd6A_write_enable & i_mcu_dcs & o_i2c_cmd6A_b2);
  assign i2c_out_cmd6A_b2 = (i2c_state_xxxxxxxxxxxx1101 & ((i2c_state_000000000110xxxx & o_i2c_cmd6A_b2)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6A_b2 <= sig_830_lut_0;
  end

//---------------------------------------------------------------------------
//Block 831, MSLICE 0

  assign i2c_state_0000000001110001 = ((i2c_state_000000000111xxxx & i2c_state_xxxxxxxxxxxx0001));
  assign net_1641 = (~net_1511 & ~net_1588 & ((~net_1581 & ~i2c_out_cmd6A_b2)));

//---------------------------------------------------------------------------
//Block 832, LSLICE 3

  assign sig_832_lut_0 = (~o_i2c_cmd6A_b0 & cmd6A_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (o_i2c_cmd6A_b0 & ~cmd6A_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6A_b0 & ~cmd6A_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_0) | (net_431 & io_mcu_d_0))) | (o_i2c_cmd6A_b0 & cmd6A_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_0))) | (o_i2c_cmd6A_b0 & cmd6A_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_0) | (net_431 & io_mcu_d_0)));
  assign net_1644 = (~net_1503 & ~i2c_out_cmd6A_b1 & ~net_1590 & (~(o_i2c_cmd6A_b0 & i2c_state_0000000001110001)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6A_b0 <= sig_832_lut_0;
  end

//---------------------------------------------------------------------------
//Block 833, LSLICE 3

  assign sig_833_lut_0 = (~o_i2c_cmd6A_b1 & cmd6A_write_enable & ~i_mcu_dcs & ((~net_431 & io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (o_i2c_cmd6A_b1 & ~cmd6A_write_enable & ~i_mcu_dcs) | (o_i2c_cmd6A_b1 & ~cmd6A_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_1) | (net_431 & io_mcu_d_1))) | (o_i2c_cmd6A_b1 & cmd6A_write_enable & ~i_mcu_dcs & ((net_431 | io_mcu_d_1))) | (o_i2c_cmd6A_b1 & cmd6A_write_enable & i_mcu_dcs & ((net_431 & ~io_mcu_d_1) | (net_431 & io_mcu_d_1)));
  assign i2c_out_cmd6A_b1 = (i2c_state_xxxxxxxxxxxx1111 & ((i2c_state_000000000110xxxx & o_i2c_cmd6A_b1)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6A_b1 <= sig_833_lut_0;
  end

//---------------------------------------------------------------------------
//Block 834, LSLICE 2

  assign sig_834_lut_0 = (~cmd6E_write_enable & ~i_mcu_dcs & o_i2c_cmd6E_b2) | (~cmd6E_write_enable & i_mcu_dcs & ~o_i2c_cmd6E_b2 & ((~net_431 & ~io_mcu_d_2) | (~net_431 & io_mcu_d_2))) | (~cmd6E_write_enable & i_mcu_dcs & o_i2c_cmd6E_b2) | (cmd6E_write_enable & ~i_mcu_dcs & ~o_i2c_cmd6E_b2 & ((~net_431 & io_mcu_d_2))) | (cmd6E_write_enable & ~i_mcu_dcs & o_i2c_cmd6E_b2 & ((~net_431 & io_mcu_d_2) | (net_431 & io_mcu_d_2))) | (cmd6E_write_enable & i_mcu_dcs & ~o_i2c_cmd6E_b2 & ((~net_431 & ~io_mcu_d_2) | (~net_431 & io_mcu_d_2))) | (cmd6E_write_enable & i_mcu_dcs & o_i2c_cmd6E_b2);
  assign i2c_out_cmd6E_b2 = (i2c_state_000000001110xxxx & i2c_state_xxxxxxxxxxxx01xx & o_i2c_cmd6E_b2 & ((~i2c_state_r1 & i2c_state_r0)));

  always @(posedge i_mcu_clk)
  begin
    o_i2c_cmd6E_b2 <= sig_834_lut_0;
  end

//---------------------------------------------------------------------------
//Block 82, EMB 1

  assign sig_82_cea = sample_write_enable & ~sample_addr_11 & ~sample_addr_10;
  assign sig_82_ceb = ~read_addr_11 & ~read_addr_10;

  sample_memory_9 samples_block_82
  (
    .dia({i_adc2A_d_1,i_adc2A_d_0,i_adc1B_d_7,i_adc1B_d_6,i_adc1B_d_5,i_adc1B_d_4,i_adc1B_d_3,i_adc1B_d_2,i_adc1B_d_1}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_82_cea),
    .clka(sample_write_clock),
    .dob({o_adc2A_d0_1,o_adc2A_d0_0,o_adc1B_d0_7,o_adc1B_d0_6,o_adc1B_d0_5,o_adc1B_d0_4,o_adc1B_d0_3,o_adc1B_d0_2,o_adc1B_d0_1}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_82_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 83, EMB 2

  assign sig_83_cea = sample_write_enable & ~sample_addr_11 & sample_addr_10;
  assign sig_83_ceb = ~read_addr_11 & read_addr_10;

  sample_memory_9 samples_block_83
  (
    .dia({i_adc2A_d_1,i_adc2A_d_0,i_adc1B_d_7,i_adc1B_d_6,i_adc1B_d_5,i_adc1B_d_4,i_adc1B_d_3,i_adc1B_d_2,i_adc1B_d_1}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_83_cea),
    .clka(sample_write_clock),
    .dob({o_adc2A_d1_1,o_adc2A_d1_0,o_adc1B_d1_7,o_adc1B_d1_6,o_adc1B_d1_5,o_adc1B_d1_4,o_adc1B_d1_3,o_adc1B_d1_2,o_adc1B_d1_1}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_83_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 84, EMB 3

  assign sig_84_cea = sample_write_enable & sample_addr_11 & sample_addr_10;
  assign sig_84_ceb = read_addr_11 & read_addr_10;

  sample_memory_9 samples_block_84
  (
    .dia({i_adc2A_d_1,i_adc2A_d_0,i_adc1B_d_7,i_adc1B_d_6,i_adc1B_d_5,i_adc1B_d_4,i_adc1B_d_3,i_adc1B_d_2,i_adc1B_d_1}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_84_cea),
    .clka(sample_write_clock),
    .dob({o_adc2A_d3_1,o_adc2A_d3_0,o_adc1B_d3_7,o_adc1B_d3_6,o_adc1B_d3_5,o_adc1B_d3_4,o_adc1B_d3_3,o_adc1B_d3_2,o_adc1B_d3_1}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_84_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 94, EMB 0

  assign sig_94_cea = sample_write_enable & sample_addr_11 & ~sample_addr_10;
  assign sig_94_ceb = read_addr_11 & ~read_addr_10;

  sample_memory_9 samples_block_94
  (
    .dia({i_adc2A_d_1,i_adc2A_d_0,i_adc1B_d_7,i_adc1B_d_6,i_adc1B_d_5,i_adc1B_d_4,i_adc1B_d_3,i_adc1B_d_2,i_adc1B_d_1}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_94_cea),
    .clka(sample_write_clock),
    .dob({o_adc2A_d2_1,o_adc2A_d2_0,o_adc1B_d2_7,o_adc1B_d2_6,o_adc1B_d2_5,o_adc1B_d2_4,o_adc1B_d2_3,o_adc1B_d2_2,o_adc1B_d2_1}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_94_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 95, EMB 1

  assign sig_95_cea = sample_write_enable & sample_addr_11 & ~sample_addr_10;
  assign sig_95_ceb = read_addr_11 & ~read_addr_10;

  sample_memory_9 samples_block_95
  (
    .dia({i_adc2B_d_2,i_adc2B_d_1,i_adc2B_d_0,i_adc2A_d_7,i_adc2A_d_6,i_adc2A_d_5,i_adc2A_d_4,i_adc2A_d_3,i_adc2A_d_2}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_95_cea),
    .clka(sample_write_clock),
    .dob({o_adc2B_d2_2,o_adc2B_d2_1,o_adc2B_d2_0,o_adc2A_d2_7,o_adc2A_d2_6,o_adc2A_d2_5,o_adc2A_d2_4,o_adc2A_d2_3,o_adc2A_d2_2}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_95_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 96, EMB 2

  assign sig_96_cea = sample_write_enable & sample_addr_11 & sample_addr_10;
  assign sig_96_ceb = read_addr_11 & read_addr_10;

  sample_memory_9 samples_block_96
  (
    .dia({i_adc2B_d_2,i_adc2B_d_1,i_adc2B_d_0,i_adc2A_d_7,i_adc2A_d_6,i_adc2A_d_5,i_adc2A_d_4,i_adc2A_d_3,i_adc2A_d_2}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_96_cea),
    .clka(sample_write_clock),
    .dob({o_adc2B_d3_2,o_adc2B_d3_1,o_adc2B_d3_0,o_adc2A_d3_7,o_adc2A_d3_6,o_adc2A_d3_5,o_adc2A_d3_4,o_adc2A_d3_3,o_adc2A_d3_2}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_96_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 97, EMB 3

  assign sig_97_cea = sample_write_enable & ~sample_addr_11 & sample_addr_10;
  assign sig_97_ceb = ~read_addr_11 & read_addr_10;

  sample_memory_9 samples_block_97
  (
    .dia({i_adc2B_d_2,i_adc2B_d_1,i_adc2B_d_0,i_adc2A_d_7,i_adc2A_d_6,i_adc2A_d_5,i_adc2A_d_4,i_adc2A_d_3,i_adc2A_d_2}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_97_cea),
    .clka(sample_write_clock),
    .dob({o_adc2B_d1_2,o_adc2B_d1_1,o_adc2B_d1_0,o_adc2A_d1_7,o_adc2A_d1_6,o_adc2A_d1_5,o_adc2A_d1_4,o_adc2A_d1_3,o_adc2A_d1_2}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_97_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 114, EMB 0

  assign sig_114_cea = sample_write_enable & ~sample_addr_11 & ~sample_addr_10;
  assign sig_114_ceb = ~read_addr_11 & ~read_addr_10;

  sample_memory_9 samples_block_114
  (
    .dia({i_adc2B_d_2,i_adc2B_d_1,i_adc2B_d_0,i_adc2A_d_7,i_adc2A_d_6,i_adc2A_d_5,i_adc2A_d_4,i_adc2A_d_3,i_adc2A_d_2}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_114_cea),
    .clka(sample_write_clock),
    .dob({o_adc2B_d0_2,o_adc2B_d0_1,o_adc2B_d0_0,o_adc2A_d0_7,o_adc2A_d0_6,o_adc2A_d0_5,o_adc2A_d0_4,o_adc2A_d0_3,o_adc2A_d0_2}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_114_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 450, EMB 3

  assign sig_450_cea = sample_write_enable & ~sample_addr_11 & ~sample_addr_10;
  assign sig_450_ceb = ~read_addr_11 & ~read_addr_10;

  sample_memory_9 samples_block_450
  (
    .dia({i_adc1B_d_0,i_adc1A_d_7,i_adc1A_d_6,i_adc1A_d_5,i_adc1A_d_4,i_adc1A_d_3,i_adc1A_d_2,i_adc1A_d_1,i_adc1A_d_0}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_450_cea),
    .clka(sample_write_clock),
    .dob({o_adc1B_d0_0,o_adc1A_d0_7,o_adc1A_d0_6,o_adc1A_d0_5,o_adc1A_d0_4,o_adc1A_d0_3,o_adc1A_d0_2,o_adc1A_d0_1,o_adc1A_d0_0}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_450_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 455, EMB 0

  assign sig_455_cea = sample_write_enable & ~sample_addr_11 & sample_addr_10;
  assign sig_455_ceb = ~read_addr_11 & read_addr_10;

  sample_memory_9 samples_block_455
  (
    .dia({i_adc1B_d_0,i_adc1A_d_7,i_adc1A_d_6,i_adc1A_d_5,i_adc1A_d_4,i_adc1A_d_3,i_adc1A_d_2,i_adc1A_d_1,i_adc1A_d_0}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_455_cea),
    .clka(sample_write_clock),
    .dob({o_adc1B_d1_0,o_adc1A_d1_7,o_adc1A_d1_6,o_adc1A_d1_5,o_adc1A_d1_4,o_adc1A_d1_3,o_adc1A_d1_2,o_adc1A_d1_1,o_adc1A_d1_0}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_455_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 456, EMB 1

  assign sig_456_cea = sample_write_enable & sample_addr_11 & sample_addr_10;
  assign sig_456_ceb = read_addr_11 & read_addr_10;

  sample_memory_9 samples_block_456
  (
    .dia({i_adc1B_d_0,i_adc1A_d_7,i_adc1A_d_6,i_adc1A_d_5,i_adc1A_d_4,i_adc1A_d_3,i_adc1A_d_2,i_adc1A_d_1,i_adc1A_d_0}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_456_cea),
    .clka(sample_write_clock),
    .dob({o_adc1B_d3_0,o_adc1A_d3_7,o_adc1A_d3_6,o_adc1A_d3_5,o_adc1A_d3_4,o_adc1A_d3_3,o_adc1A_d3_2,o_adc1A_d3_1,o_adc1A_d3_0}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_456_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 457, EMB 2

  assign sig_457_cea = sample_write_enable & sample_addr_11 & ~sample_addr_10;
  assign sig_457_ceb = read_addr_11 & ~read_addr_10;

  sample_memory_9 samples_block_457
  (
    .dia({i_adc1B_d_0,i_adc1A_d_7,i_adc1A_d_6,i_adc1A_d_5,i_adc1A_d_4,i_adc1A_d_3,i_adc1A_d_2,i_adc1A_d_1,i_adc1A_d_0}),
    .addra({sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sig_457_cea),
    .clka(sample_write_clock),
    .dob({o_adc1B_d2_0,o_adc1A_d2_7,o_adc1A_d2_6,o_adc1A_d2_5,o_adc1A_d2_4,o_adc1A_d2_3,o_adc1A_d2_2,o_adc1A_d2_1,o_adc1A_d2_0}),
    .addrb({read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(sig_457_ceb),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 458, EMB 3

  sample_memory_2 samples_block_458
  (
    .dia({ i_adc2B_d_4, i_adc2B_d_3 }),
    .addra({sample_addr_11,sample_addr_10,sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sample_write_enable),
    .clka(sample_write_clock),
    .dob({o_adc2B_d_4,o_adc2B_d_3}),
    .addrb({read_addr_11,read_addr_10,read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(1'b1),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 463, EMB 0

  sample_memory_2 samples_block_463
  (
    .dia({ i_adc2B_d_6, i_adc2B_d_5 }),
    .addra({sample_addr_11,sample_addr_10,sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sample_write_enable),
    .clka(sample_write_clock),
    .dob({o_adc2B_d_6,o_adc2B_d_5}),
    .addrb({read_addr_11,read_addr_10,read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(1'b1),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Block 464, EMB 1

  sample_memory_2 samples_block_464
  (
    .dia({ i_adc2B_d_7 }),
    .addra({sample_addr_11,sample_addr_10,sample_addr_9,sample_addr_8,sample_addr_7,sample_addr_6,sample_addr_5,sample_addr_4,sample_addr_3,sample_addr_2,sample_addr_1,sample_addr_0}),
    .cea(sample_write_enable),
    .clka(sample_write_clock),
    .dob({open_n64,o_adc2B_d_7}),
    .addrb({read_addr_11,read_addr_10,read_addr_9,read_addr_8,read_addr_7,read_addr_6,read_addr_5,read_addr_4,read_addr_3,read_addr_2,read_addr_1,read_addr_0}),
    .ceb(1'b1),
    .clkb(sample_read_clock)
  );

//---------------------------------------------------------------------------
//Clock part

  pll master_clock
  (
    .refclk   (i_xtal),
    .reset    (1'b0),
    .clk0_out (clock_200MHz)
  );

endmodule

