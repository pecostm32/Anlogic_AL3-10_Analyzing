module FNIRSI_1014D
(
  output wire io_i2c_scl,
  inout wire io_i2c_sda,
  input wire i_clk2,
  input wire i_clk1,
  output wire o_pwm_display,
  input wire i_mcu_rws,
  input wire i_mcu_dcs,
  input wire i_mcu_clk,
  output wire o_dac_d[1],
  output wire o_dac_d[0],
  inout wire io_mcu_d[4],
  inout wire io_mcu_d[5],
  inout wire io_mcu_d[6],
  inout wire io_mcu_d[7],
  output wire o_dac_d[2],
  output wire o_dac_d[5],
  output wire o_dac_d[3],
  output wire o_dac_d[4],
  inout wire io_mcu_d[2],
  inout wire io_mcu_d[3],
  inout wire io_mcu_d[1],
  inout wire io_mcu_d[0],
  output wire o_dac_d[6],
  output wire o_dac_d[7],
  output wire o_ac_dc_2,
  output wire o_ac_dc_1,
  output wire o_relay1_2,
  output wire o_relay1_1,
  output wire o_relay2_2,
  output wire o_relay1_3,
  output wire o_relay2_3,
  output wire o_relay2_1,
  input wire i_adc1B_d[6],
  output wire o_adc1_encB,
  input wire i_adc1B_d[7],
  input wire i_adc2A_d[6],
  input wire i_adc2A_d[5],
  output wire o_adc2_encA,
  input wire i_adc2A_d[7],
  input wire i_adc2A_d[3],
  input wire i_adc2A_d[4],
  input wire i_adc1B_d[2],
  input wire i_adc1B_d[3],
  input wire i_adc1B_d[4],
  input wire i_adc1B_d[5],
  input wire i_adc2A_d[0],
  input wire i_adc2A_d[1],
  input wire i_adc2A_d[2],
  input wire i_adc1B_d[0],
  input wire i_adc1B_d[1],
  input wire i_adc2B_d[1],
  input wire i_adc2B_d[0],
  input wire i_adc2B_d[2],
  input wire i_adc2B_d[4],
  input wire i_adc2B_d[3],
  input wire i_adc2B_d[5],
  input wire i_adc2B_d[6],
  output wire o_adc2_encB,
  input wire i_adc2B_d[7],
  output wire o_offset_2,
  output wire o_offset_1,
  output wire o_adc1_encA,
  input wire i_adc1A_d[7],
  input wire i_adc1A_d[5],
  input wire i_adc1A_d[6],
  input wire i_adc1A_d[3],
  input wire i_adc1A_d[4],
  input wire i_adc1A_d[2],
  input wire i_adc1A_d[0],
  input wire i_adc1A_d[1]
);

//---------------------------------------------------------------------------
//Wire declarations

  wire sig_101_lut_0;
  wire sig_101_lut_1;
  wire net_79;
  wire net_78;
  wire net_84;
  wire net_83;
  wire sig_110_lut_0;
  wire sig_110_lut_1;
  wire net_85;
  wire sig_111_lut_0;
  wire sig_111_lut_1;
  wire net_86;
  wire net_90;
  wire net_89;
  wire sig_113_lut_0;
  wire sig_113_lut_1;
  wire net_91;
  wire sig_114_lut_0;
  wire sig_114_lut_1;
  wire net_95;
  wire net_94;
  wire net_96;
  wire net_92;
  wire net_93;
  wire sig_117_lut_0;
  wire sig_117_lut_1;
  wire sig_118_lut_0;
  wire net_100;
  wire sig_119_lut_0;
  wire sig_119_lut_1;
  wire sig_120_lut_0;
  wire sig_120_lut_1;
  wire net_129, net_125, net_127, net_121, net_124, net_122, net_123, net_113, net_109, net_114;
  wire sig_126_lut_0;
  wire sig_126_lut_1;
  wire sig_129_lut_0;
  wire sig_129_lut_1;
  wire net_133;
  wire net_132;
  wire net_137;
  wire net_138;
  wire sig_135_lut_0;
  wire sig_135_lut_1;
  wire net_146;
  wire net_144;
  wire net_145;
  wire net_143;
  wire net_148;
  wire sig_138_lut_0;
  wire sig_138_lut_1;
  wire net_147;
  wire sig_139_lut_0;
  wire sig_139_lut_1;
  wire net_160;
  wire net_177, net_169, net_171, net_167, net_172, net_173, net_164, net_170, net_168, net_153, net_157, net_156, net_158, net_152, net_154, net_159;
  wire sig_142_lut_0;
  wire sig_142_lut_1;
  wire net_161;
  wire sig_146_lut_0;
  wire sig_146_lut_1;
  wire net_179;
  wire net_184;
  wire net_182;
  wire net_183;
  wire net_185;
  wire net_186;
  wire net_187;
  wire net_192;
  wire net_193;
  wire sig_152_lut_0;
  wire net_191;
  wire sig_153_lut_0;
  wire sig_153_lut_1;
  wire sig_153_ff0_d;
  wire sig_154_lut_0;
  wire sig_154_lut_1;
  wire sig_154_ff0_d;
  wire sig_155_lut_0;
  wire net_197;
  wire sig_156_lut_0;
  wire sig_156_lut_1;
  wire sig_156_ff0_d;
  wire sig_157_lut_0;
  wire net_199;
  wire sig_158_lut_0;
  wire sig_158_lut_1;
  wire sig_158_ff0_d;
  wire sig_159_lut_0;
  wire net_203;
  wire sig_160_lut_0;
  wire net_204;
  wire sig_161_lut_0;
  wire sig_161_lut_1;
  wire sig_161_ff0_d;
  wire sig_162_lut_0;
  wire sig_162_lut_1;
  wire sig_162_ff0_d;
  wire sig_163_lut_0;
  wire net_209;
  wire sig_164_lut_0;
  wire sig_164_lut_1;
  wire sig_164_ff0_d;
  wire sig_165_lut_0;
  wire net_211;
  wire sig_166_lut_0;
  wire net_213;
  wire sig_167_lut_0;
  wire sig_167_lut_1;
  wire sig_172_lut_0;
  wire sig_172_lut_1;
  wire net_219;
  wire net_218;
  wire net_224;
  wire net_222;
  wire net_220;
  wire net_221;
  wire net_235;
  wire net_238;
  wire net_234;
  wire net_236;
  wire net_232;
  wire net_237;
  wire net_240;
  wire net_241;
  wire net_246;
  wire net_245;
  wire sig_182_lut_0;
  wire sig_182_lut_1;
  wire net_244;
  wire sig_183_lut_0;
  wire sig_183_lut_1;
  wire net_250;
  wire sig_184_lut_0;
  wire sig_184_lut_1;
  wire net_251;
  wire net_249;
  wire sig_186_lut_0;
  wire sig_186_lut_1;
  wire net_252;
  wire sig_187_lut_0;
  wire sig_187_lut_1;
  wire net_254;
  wire sig_188_lut_0;
  wire net_257;
  wire net_261;
  wire net_260;
  wire net_258;
  wire net_259;
  wire net_264;
  wire net_265;
  wire sig_192_lut_0;
  wire net_266;
  wire sig_193_lut_0;
  wire sig_193_lut_1;
  wire sig_193_ff0_d;
  wire sig_194_lut_0;
  wire net_269;
  wire sig_195_lut_0;
  wire net_270;
  wire sig_196_lut_0;
  wire sig_196_lut_1;
  wire net_276;
  wire net_272;
  wire net_274;
  wire sig_198_lut_0;
  wire net_273;
  wire sig_199_lut_0;
  wire sig_199_lut_1;
  wire sig_199_ff0_d;
  wire sig_200_lut_0;
  wire sig_200_lut_1;
  wire sig_200_ff0_d;
  wire sig_201_lut_0;
  wire net_281;
  wire sig_202_lut_0;
  wire net_282;
  wire sig_203_lut_0;
  wire sig_203_lut_1;
  wire sig_203_ff0_d;
  wire net_286;
  wire net_288;
  wire sig_205_lut_0;
  wire net_287;
  wire sig_206_lut_0;
  wire sig_206_lut_1;
  wire sig_207_lut_0;
  wire sig_207_lut_1;
  wire sig_207_ff0_d;
  wire sig_212_lut_0;
  wire sig_212_lut_1;
  wire net_305;
  wire net_304;
  wire net_306;
  wire net_307;
  wire net_308;
  wire net_309;
  wire net_313;
  wire net_310;
  wire sig_221_lut_0;
  wire sig_221_lut_1;
  wire net_312;
  wire net_315;
  wire net_316;
  wire net_320;
  wire net_319;
  wire net_323;
  wire net_321;
  wire sig_225_lut_0;
  wire sig_225_lut_1;
  wire sig_225_ff0_d;
  wire net_328;
  wire net_327;
  wire sig_227_lut_0;
  wire sig_227_lut_1;
  wire net_329;
  wire net_331;
  wire net_332;
  wire net_337;
  wire net_338;
  wire net_340;
  wire net_334;
  wire net_339;
  wire net_335;
  wire sig_232_lut_0;
  wire sig_232_lut_1;
  wire sig_232_ff0_d;
  wire net_343;
  wire net_344;
  wire sig_234_lut_0;
  wire sig_234_lut_1;
  wire sig_234_ff0_d;
  wire net_345;
  wire net_346;
  wire sig_236_lut_0;
  wire sig_236_lut_1;
  wire net_348;
  wire net_347;
  wire net_349;
  wire sig_238_lut_0;
  wire sig_238_lut_1;
  wire net_350;
  wire net_355;
  wire net_352;
  wire sig_240_lut_0;
  wire net_353;
  wire sig_241_lut_0;
  wire sig_241_lut_1;
  wire net_354;
  wire sig_242_lut_0;
  wire net_357;
  wire sig_243_lut_0;
  wire net_359;
  wire sig_244_lut_0;
  wire sig_244_lut_1;
  wire sig_244_ff0_d;
  wire sig_245_lut_0;
  wire sig_245_lut_1;
  wire net_361;
  wire sig_246_lut_0;
  wire sig_246_lut_1;
  wire sig_246_ff0_d;
  wire sig_247_lut_0;
  wire sig_247_lut_1;
  wire net_451, open_0, open_1, open_2, open_3, open_4, open_5, open_6, open_7, open_8, open_9, open_10, open_11, open_12, open_13, open_14, open_15, open_16, open_17, open_18, open_19, open_20, open_21, open_22, open_23, open_24, open_25, open_26, open_27, open_28, open_29, open_30, open_31;
  wire net_437, net_425, net_430, net_428, net_431, net_423, net_426, net_429, net_424, net_410, net_406, net_412, net_415, net_408, net_413, net_414, net_409, net_395, net_391, net_393, net_397, net_398, net_390, net_392, net_394, net_382, net_378, net_383, net_384, net_379, net_381, net_385;
  wire net_436;
  wire net_439;
  wire net_447;
  wire net_444;
  wire net_449;
  wire net_446;
  wire net_452;
  wire net_454;
  wire net_455;
  wire net_453;
  wire sig_279_lut_0;
  wire sig_279_lut_1;
  wire net_467;
  wire net_462;
  wire net_466;
  wire net_464;
  wire net_465;
  wire net_468;
  wire net_463;
  wire net_473;
  wire net_472;
  wire net_474;
  wire net_470;
  wire net_479;
  wire net_475;
  wire net_476;
  wire net_477;
  wire net_483;
  wire net_480;
  wire sig_288_lut_0;
  wire sig_288_lut_1;
  wire net_481;
  wire sig_289_lut_0;
  wire sig_289_lut_1;
  wire net_485;
  wire net_489;
  wire net_487;
  wire sig_291_lut_0;
  wire net_488;
  wire sig_292_lut_0;
  wire sig_292_lut_1;
  wire net_490;
  wire net_498;
  wire net_497;
  wire net_492;
  wire net_495;
  wire sig_295_lut_0;
  wire net_494;
  wire net_493;
  wire net_496;
  wire net_500;
  wire net_499;
  wire sig_298_lut_0;
  wire net_503;
  wire sig_299_lut_0;
  wire sig_299_lut_1;
  wire net_502;
  wire sig_300_lut_0;
  wire sig_300_lut_1;
  wire sig_300_ff0_d;
  wire sig_301_lut_0;
  wire net_507;
  wire sig_302_lut_0;
  wire net_509;
  wire sig_303_lut_0;
  wire sig_303_lut_1;
  wire sig_303_ff0_d;
  wire net_513;
  wire net_512;
  wire net_515;
  wire net_514;
  wire net_519;
  wire net_517;
  wire sig_309_lut_0;
  wire sig_309_lut_1;
  wire net_525;
  wire net_526;
  wire net_524;
  wire net_523;
  wire net_529;
  wire sig_312_lut_0;
  wire sig_312_lut_1;
  wire net_528;
  wire net_536;
  wire net_533;
  wire net_532;
  wire net_535;
  wire sig_315_lut_0;
  wire sig_315_lut_1;
  wire net_537;
  wire net_541;
  wire net_540;
  wire net_545;
  wire net_548;
  wire net_550;
  wire net_546;
  wire net_549;
  wire net_551;
  wire sig_320_lut_0;
  wire sig_320_lut_1;
  wire net_547;
  wire net_556;
  wire net_557;
  wire net_555;
  wire net_554;
  wire net_558;
  wire net_559;
  wire net_566;
  wire net_565;
  wire net_563;
  wire net_562;
  wire net_561;
  wire net_567;
  wire net_568;
  wire net_564;
  wire net_571;
  wire net_570;
  wire net_572;
  wire net_569;
  wire net_574;
  wire net_573;
  wire sig_331_lut_0;
  wire sig_331_lut_1;
  wire net_578;
  wire net_575;
  wire net_580;
  wire net_576;
  wire net_582;
  wire net_581;
  wire net_579;
  wire net_584;
  wire net_588;
  wire sig_336_lut_0;
  wire net_586;
  wire net_587;
  wire net_585;
  wire sig_338_lut_0;
  wire net_590;
  wire net_592;
  wire net_593;
  wire sig_340_lut_0;
  wire net_594;
  wire sig_341_lut_0;
  wire sig_341_lut_1;
  wire net_595;
  wire sig_342_lut_0;
  wire sig_342_lut_1;
  wire net_606;
  wire net_604;
  wire net_603;
  wire net_601;
  wire net_611;
  wire net_613;
  wire net_612;
  wire net_615;
  wire sig_352_lut_0;
  wire sig_352_lut_1;
  wire net_614;
  wire net_624;
  wire net_623;
  wire net_622;
  wire net_625;
  wire sig_358_lut_0;
  wire sig_358_lut_1;
  wire net_626;
  wire net_633;
  wire net_630;
  wire net_628;
  wire net_631;
  wire sig_361_lut_0;
  wire net_629;
  wire net_634;
  wire net_632;
  wire net_637;
  wire net_636;
  wire net_641;
  wire net_640;
  wire sig_365_lut_0;
  wire sig_365_lut_1;
  wire net_642;
  wire net_648;
  wire net_652;
  wire net_649;
  wire net_647;
  wire net_646;
  wire net_650;
  wire sig_369_lut_0;
  wire sig_369_lut_1;
  wire net_651;
  wire sig_370_lut_0;
  wire sig_370_lut_1;
  wire net_653;
  wire net_657;
  wire net_658;
  wire net_661;
  wire net_656;
  wire net_660;
  wire net_659;
  wire net_666;
  wire net_664;
  wire sig_375_lut_0;
  wire net_663;
  wire sig_376_lut_0;
  wire sig_376_lut_1;
  wire net_665;
  wire net_667;
  wire net_668;
  wire net_673;
  wire net_670;
  wire sig_379_lut_0;
  wire sig_379_lut_1;
  wire net_672;
  wire net_675;
  wire net_674;
  wire sig_381_lut_0;
  wire sig_381_lut_1;
  wire net_677;
  wire net_680;
  wire net_679;
  wire net_678;
  wire net_682;
  wire sig_384_lut_0;
  wire sig_384_lut_1;
  wire net_681;
  wire sig_385_lut_0;
  wire sig_385_lut_1;
  wire net_687;
  wire net_686;
  wire net_684;
  wire sig_387_lut_0;
  wire net_685;
  wire sig_388_lut_0;
  wire sig_388_lut_1;
  wire net_688;
  wire sig_389_lut_0;
  wire sig_389_lut_1;
  wire sig_389_ff0_d;
  wire sig_412_lut_0;
  wire sig_412_lut_1;
  wire sig_412_ff0_d;
  wire net_774, net_766, net_769, net_765, net_770, net_771, net_764, net_763, net_768, net_755, net_756, net_754, net_757, net_751, net_753, net_758;
  wire sig_415_lut_0;
  wire sig_415_lut_1;
  wire net_750;
  wire sig_418_lut_0;
  wire sig_418_lut_1;
  wire sig_418_ff0_d;
  wire sig_420_lut_0;
  wire sig_420_lut_1;
  wire net_780;
  wire net_782;
  wire net_778;
  wire net_784;
  wire net_779;
  wire net_783;
  wire net_781;
  wire sig_424_lut_0;
  wire sig_424_lut_1;
  wire net_786;
  wire sig_425_lut_0;
  wire net_785;
  wire sig_426_lut_0;
  wire sig_426_lut_1;
  wire net_787;
  wire net_789;
  wire net_790;
  wire net_795;
  wire net_792;
  wire net_793;
  wire net_794;
  wire net_798;
  wire net_797;
  wire sig_431_lut_0;
  wire sig_431_lut_1;
  wire net_796;
  wire net_805;
  wire net_804;
  wire net_802;
  wire net_803;
  wire net_807;
  wire net_801;
  wire net_809;
  wire net_810;
  wire net_820;
  wire net_816;
  wire net_811;
  wire net_814;
  wire net_813;
  wire net_817;
  wire sig_439_lut_0;
  wire sig_439_lut_1;
  wire net_815;
  wire net_825;
  wire net_826;
  wire net_822;
  wire net_824;
  wire sig_442_lut_0;
  wire sig_442_lut_1;
  wire sig_442_ff0_d;
  wire net_830;
  wire net_829;
  wire net_837;
  wire net_841;
  wire net_834;
  wire net_836;
  wire net_842;
  wire net_838;
  wire net_839;
  wire net_840;
  wire net_844;
  wire net_846;
  wire net_843;
  wire net_847;
  wire sig_450_lut_0;
  wire sig_450_lut_1;
  wire net_848;
  wire net_849;
  wire net_850;
  wire sig_452_lut_0;
  wire sig_452_lut_1;
  wire net_853;
  wire net_852;
  wire net_854;
  wire net_857;
  wire net_851;
  wire net_855;
  wire net_856;
  wire sig_456_lut_0;
  wire sig_456_lut_1;
  wire net_860;
  wire net_859;
  wire net_858;
  wire sig_458_lut_0;
  wire sig_458_lut_1;
  wire net_861;
  wire net_862;
  wire net_863;
  wire sig_460_lut_0;
  wire sig_460_lut_1;
  wire sig_460_ff0_d;
  wire sig_461_lut_0;
  wire sig_461_lut_1;
  wire net_868;
  wire net_869;
  wire sig_467_lut_0;
  wire sig_467_lut_1;
  wire sig_467_ff0_d;
  wire sig_468_lut_0;
  wire sig_468_lut_1;
  wire sig_468_ff0_d;
  wire net_873;
  wire net_871;
  wire sig_470_lut_0;
  wire sig_470_lut_1;
  wire net_874;
  wire sig_471_lut_0;
  wire sig_471_lut_1;
  wire sig_471_ff0_d;
  wire net_880;
  wire net_879;
  wire sig_473_lut_0;
  wire sig_473_lut_1;
  wire sig_473_ff0_d;
  wire net_882;
  wire net_883;
  wire net_893;
  wire net_889;
  wire net_894;
  wire net_891;
  wire sig_477_lut_0;
  wire net_892;
  wire net_897;
  wire net_895;
  wire net_900;
  wire net_896;
  wire net_903;
  wire net_902;
  wire net_904;
  wire net_905;
  wire sig_482_lut_0;
  wire sig_482_lut_1;
  wire net_906;
  wire net_912;
  wire net_915;
  wire sig_484_lut_0;
  wire net_910;
  wire sig_485_lut_0;
  wire sig_485_lut_1;
  wire sig_485_ff0_d;
  wire net_914;
  wire net_913;
  wire net_918;
  wire net_916;
  wire net_921;
  wire net_922;
  wire net_924;
  wire net_925;
  wire net_926;
  wire net_920;
  wire net_935;
  wire net_931;
  wire net_930;
  wire net_934;
  wire net_929;
  wire net_937;
  wire net_936;
  wire net_940;
  wire net_939;
  wire net_942;
  wire net_947;
  wire net_945;
  wire net_943;
  wire net_954;
  wire net_957;
  wire net_953;
  wire net_951;
  wire net_955;
  wire net_949;
  wire net_952;
  wire net_950;
  wire sig_502_lut_0;
  wire sig_502_lut_1;
  wire net_958;
  wire net_961;
  wire net_960;
  wire net_962;
  wire net_959;
  wire net_969;
  wire net_965;
  wire net_964;
  wire net_967;
  wire net_966;
  wire net_963;
  wire sig_508_lut_0;
  wire sig_508_lut_1;
  wire net_968;
  wire sig_509_lut_0;
  wire sig_509_lut_1;
  wire net_970;
  wire sig_510_lut_0;
  wire sig_510_lut_1;
  wire sig_510_ff0_d;
  wire sig_511_lut_0;
  wire sig_511_lut_1;
  wire sig_512_lut_0;
  wire sig_512_lut_1;
  wire sig_512_ff0_d;
  wire net_976;
  wire net_975;
  wire sig_514_lut_0;
  wire sig_514_lut_1;
  wire net_977;
  wire net_979;
  wire net_980;
  wire sig_516_lut_0;
  wire sig_516_lut_1;
  wire sig_516_ff0_d;
  wire net_987;
  wire net_984;
  wire net_985;
  wire net_983;
  wire sig_519_lut_0;
  wire sig_519_lut_1;
  wire sig_519_ff0_d;
  wire sig_520_lut_0;
  wire sig_521_lut_0;
  wire sig_521_lut_1;
  wire sig_521_ff0_d;
  wire net_991;
  wire net_993;
  wire sig_524_lut_0;
  wire net_1000;
  wire net_998;
  wire net_999;
  wire net_1004;
  wire net_1008;
  wire net_1010;
  wire net_1013;
  wire net_1020;
  wire net_1021;
  wire net_1018;
  wire net_1017;
  wire net_1016;
  wire net_1022;
  wire net_1028;
  wire net_1023;
  wire net_1027;
  wire net_1026;
  wire net_1030;
  wire net_1031;
  wire net_1040;
  wire net_1032;
  wire net_1036;
  wire net_1038;
  wire net_1033;
  wire net_1041;
  wire net_1034;
  wire net_1035;
  wire net_1049;
  wire net_1045;
  wire net_1050;
  wire net_1048;
  wire sig_544_lut_0;
  wire sig_544_lut_1;
  wire net_1047;
  wire net_1054;
  wire net_1052;
  wire sig_546_lut_0;
  wire sig_546_lut_1;
  wire sig_546_ff0_d;
  wire net_1061;
  wire net_1056;
  wire net_1063;
  wire net_1057;
  wire net_1055;
  wire net_1060;
  wire net_1065;
  wire net_1064;
  wire sig_551_lut_0;
  wire sig_551_lut_1;
  wire net_1066;
  wire net_1067;
  wire net_1068;
  wire sig_553_lut_0;
  wire net_1072;
  wire sig_554_lut_0;
  wire net_1071;
  wire sig_555_lut_0;
  wire sig_555_lut_1;
  wire net_1073;
  wire net_1077;
  wire net_1078;
  wire sig_557_lut_0;
  wire net_1076;
  wire sig_558_lut_0;
  wire sig_558_lut_1;
  wire sig_558_ff0_d;
  wire sig_559_lut_0;
  wire sig_559_lut_1;
  wire net_1081;
  wire net_1082;
  wire net_1080;
  wire sig_561_lut_0;
  wire sig_561_lut_1;
  wire sig_561_ff0_d;
  wire sig_562_lut_0;
  wire sig_562_lut_1;
  wire net_1083;
  wire net_1087;
  wire net_1089;
  wire net_1090;
  wire net_1088;
  wire sig_565_lut_0;
  wire sig_565_lut_1;
  wire sig_565_ff0_d;
  wire net_1097;
  wire net_1099;
  wire net_1093;
  wire net_1095;
  wire net_1098;
  wire net_1094;
  wire sig_569_lut_0;
  wire sig_569_lut_1;
  wire sig_569_ff0_d;
  wire net_1105;
  wire net_1108;
  wire net_1107;
  wire net_1106;
  wire sig_572_lut_0;
  wire sig_572_lut_1;
  wire net_1114;
  wire sig_573_lut_0;
  wire net_1112;
  wire net_1111;
  wire net_1117;
  wire net_1116;
  wire net_1113;
  wire net_1120;
  wire net_1121;
  wire net_1132, net_1127, net_1128, net_1129;
  wire net_1126;
  wire net_1125;
  wire net_1136;
  wire net_1131;
  wire net_1140;
  wire net_1135;
  wire net_1141;
  wire net_1142;
  wire net_1145;
  wire net_1149;
  wire net_1147;
  wire net_1148;
  wire net_1154;
  wire net_1146;
  wire net_1160;
  wire net_1156;
  wire net_1165;
  wire net_1161;
  wire net_1162;
  wire net_1155;
  wire net_1164;
  wire net_1159;
  wire net_1196, net_1191, net_1188, net_1194, net_1185, net_1180, net_1174, net_1178, net_1179, net_1171, net_1169, net_1168;
  wire net_1189;
  wire net_1184;
  wire net_1183;
  wire net_1192;
  wire sig_600_lut_0;
  wire net_1199;
  wire net_1201;
  wire net_1200;
  wire sig_602_lut_0;
  wire sig_602_lut_1;
  wire sig_602_ff0_d;
  wire sig_603_lut_0;
  wire net_1204;
  wire sig_608_lut_0;
  wire sig_608_lut_1;
  wire net_1208;
  wire net_1207;
  wire net_1206;
  wire sig_610_lut_0;
  wire sig_610_lut_1;
  wire sig_610_ff0_d;
  wire sig_611_lut_0;
  wire sig_611_lut_1;
  wire net_1209;
  wire net_1212;
  wire net_1210;
  wire net_1220;
  wire net_1221;
  wire net_1222;
  wire net_1217;
  wire net_1229;
  wire net_1228;
  wire net_1238;
  wire net_1235;
  wire net_1240;
  wire net_1247;
  wire net_1244;
  wire net_1242;
  wire net_1249;
  wire net_1245;
  wire net_1258;
  wire net_1251;
  wire net_1253;
  wire net_1252;
  wire net_1262;
  wire net_1259;
  wire sig_631_lut_0;
  wire sig_631_lut_1;
  wire net_1268;
  wire net_1269;
  wire net_1277;
  wire net_1276;
  wire net_1283;
  wire net_1286;
  wire net_1294;
  wire net_1291;
  wire net_1295;
  wire net_1289;
  wire net_1298;
  wire net_1290;
  wire net_1328, net_1315, net_1319, net_1317, net_1321, net_1322, net_1316, net_1320, net_1318, net_1309, net_1310, net_1306, net_1307, net_1304, net_1305, net_1308;
  wire sig_646_lut_0;
  wire sig_646_lut_1;
  wire net_1303;
  wire sig_650_lut_0;
  wire net_1326;
  wire net_1327;
  wire net_1329;
  wire sig_652_lut_0;
  wire sig_652_lut_1;
  wire sig_652_ff0_d;
  wire sig_653_lut_0;
  wire net_1332;
  wire sig_654_lut_0;
  wire sig_654_lut_1;
  wire net_1333;
  wire sig_655_lut_0;
  wire sig_655_lut_1;
  wire sig_655_ff0_d;
  wire net_1335;
  wire net_1336;
  wire sig_657_lut_0;
  wire net_1338;
  wire net_1339;
  wire net_1342;
  wire net_1341;
  wire net_1345;
  wire net_1344;
  wire net_1343;
  wire sig_661_lut_0;
  wire net_1349;
  wire sig_662_lut_0;
  wire sig_662_lut_1;
  wire net_1384, net_1374, net_1377, net_1375, net_1379, net_1380, net_1373, net_1378, net_1376, net_1362, net_1365, net_1364, net_1367, net_1366, net_1361, net_1368;
  wire net_1469, open_32, open_33, open_34, open_35, open_36, open_37, open_38, open_39, open_40, open_41, open_42, open_43, open_44, open_45, open_46, open_47, open_48, open_49, open_50, open_51, open_52, open_53, open_54, open_55, open_56, open_57, open_58, open_59, open_60, open_61, open_62, open_63;
  wire net_1392;
  wire net_1390;
  wire net_1457, net_1450, net_1442, net_1451, net_1453, net_1445, net_1447, net_1452, net_1448, net_1431, net_1426, net_1435, net_1437, net_1428, net_1433, net_1436, net_1430, net_1416, net_1419, net_1417, net_1420, net_1421, net_1414, net_1415, net_1418, net_1401, net_1404, net_1402, net_1406, net_1398, net_1399, net_1405;
  wire sig_698_lut_0;
  wire net_1464;
  wire sig_699_lut_0;
  wire net_1463;
  wire sig_702_lut_0;
  wire sig_702_lut_1;
  wire net_1468;
  wire sig_707_lut_0;
  wire sig_707_lut_1;
  wire net_1476;
  wire net_1477;
  wire net_1490;
  wire net_1485;
  wire net_1491;
  wire net_1484;
  wire sig_716_lut_0;
  wire sig_716_lut_1;
  wire sig_716_ff0_d;
  wire sig_717_lut_0;
  wire net_1499;
  wire net_1501;
  wire net_1495;
  wire net_1498;
  wire sig_720_lut_0;
  wire net_1500;
  wire net_1505;
  wire net_1503;
  wire sig_723_lut_0;
  wire sig_723_lut_1;
  wire net_1514;
  wire net_1515;
  wire net_1512;
  wire net_1513;
  wire net_1516;
  wire net_1518;
  wire net_1520;
  wire net_1521;
  wire net_1524;
  wire net_1523;
  wire net_1526;
  wire net_1525;
  wire sig_730_lut_0;
  wire sig_730_lut_1;
  wire net_1528;
  wire net_1530;
  wire net_1531;
  wire net_1614, net_1605, net_1600, net_1607, net_1609, net_1601, net_1599, net_1608, net_1604, net_1588, net_1586, net_1593, net_1595, net_1587, net_1591, net_1594, net_1590, net_1576, net_1578, net_1574, net_1579, net_1580, net_1573, net_1577, net_1575, net_1561, net_1565, net_1564, net_1566, net_1560, net_1563, net_1567;
  wire net_1584;
  wire net_1615;
  wire net_1613;
  wire sig_783_lut_0;
  wire sig_783_lut_1;
  wire net_1649, net_1635, net_1641, net_1639, net_1642, net_1643, net_1637, net_1640, net_1636, net_1623, net_1621, net_1626, net_1627, net_1625, net_1624, net_1628;
  wire sig_790_lut_0;
  wire net_1648;
  wire net_1652;
  wire net_1651;
  wire net_1659;
  wire net_1661;
  wire net_1660;
  wire net_1662;
  wire net_1665;
  wire net_1664;
  wire net_1668;
  wire net_1669;
  wire sig_61_cea;
  wire sig_61_ceb;
  wire sig_69_cea;
  wire sig_69_ceb;
  wire net_33;
  wire net_37;
  wire net_35;
  wire net_36;
  wire net_34;
  wire net_30;
  wire net_29;
  wire net_31;
  wire net_32;
  wire sig_70_cea;
  wire sig_70_ceb;
  wire net_43;
  wire net_46;
  wire net_42;
  wire net_45;
  wire net_44;
  wire net_41;
  wire net_38;
  wire net_39;
  wire net_40;
  wire sig_71_cea;
  wire sig_71_ceb;
  wire net_52;
  wire net_53;
  wire net_51;
  wire net_55;
  wire net_54;
  wire net_47;
  wire net_48;
  wire net_49;
  wire net_50;
  wire sig_88_cea;
  wire sig_88_ceb;
  wire net_58;
  wire net_64;
  wire net_61;
  wire net_63;
  wire net_62;
  wire net_56;
  wire net_57;
  wire net_60;
  wire net_59;
  wire sig_390_cea;
  wire sig_390_ceb;
  wire net_690;
  wire net_697;
  wire net_696;
  wire net_698;
  wire net_695;
  wire net_693;
  wire net_694;
  wire net_691;
  wire net_692;
  wire sig_398_cea;
  wire sig_398_ceb;
  wire net_702;
  wire net_705;
  wire net_706;
  wire net_704;
  wire net_707;
  wire net_703;
  wire net_699;
  wire net_701;
  wire net_700;
  wire sig_399_cea;
  wire sig_399_ceb;
  wire net_712;
  wire net_714;
  wire net_715;
  wire net_716;
  wire net_713;
  wire net_711;
  wire net_708;
  wire net_710;
  wire net_709;
  wire sig_400_cea;
  wire sig_400_ceb;
  wire net_722;
  wire net_725;
  wire net_721;
  wire net_723;
  wire net_724;
  wire net_717;
  wire net_720;
  wire net_718;
  wire net_719;
  wire sig_401_cea;
  wire sig_401_ceb;
  wire net_728;
  wire net_732;
  wire net_733;
  wire net_734;
  wire net_731;
  wire net_730;
  wire net_729;
  wire net_727;
  wire net_726;
  wire sig_406_cea;
  wire sig_406_ceb;
  wire net_738;
  wire net_741;
  wire net_743;
  wire net_740;
  wire net_742;
  wire net_739;
  wire net_737;
  wire net_736;
  wire net_735;
  wire sig_732_cea;
  wire sig_732_ceb;
  wire net_1534;
  wire net_1540;
  wire net_1542;
  wire net_1539;
  wire net_1541;
  wire net_1537;
  wire net_1538;
  wire net_1535;
  wire net_1536;
  wire sig_738_cea;
  wire sig_738_ceb;
  wire net_1544;
  wire net_1549;
  wire net_1550;
  wire net_1548;
  wire net_1551;
  wire net_1546;
  wire net_1545;
  wire net_1543;
  wire net_1547;
  wire net_1552;
  wire net_1553;
  wire net_1554;
  wire net_1555;
  wire net_1556;

//---------------------------------------------------------------------------
//Register declarations

  reg net_65 = 1'b0;
  reg net_66 = 1'b0;
  reg net_76 = 1'b0, net_74 = 1'b0, net_77 = 1'b0, net_70 = 1'b0, net_72 = 1'b0, net_71 = 1'b0, net_73 = 1'b0, net_67 = 1'b0, net_69 = 1'b0, net_68 = 1'b0;
  reg net_80 = 1'b0;
  reg net_75 = 1'b0;
  reg net_81 = 1'b0;
  reg net_82 = 1'b0;
  reg net_88 = 1'b0;
  reg net_87 = 1'b0;
  reg net_98 = 1'b0;
  reg net_97 = 1'b0;
  reg net_99 = 1'b0;
  reg net_102 = 1'b0;
  reg net_104 = 1'b0;
  reg net_103 = 1'b0;
  reg net_101 = 1'b0;
  reg net_112 = 1'b0;
  reg net_110 = 1'b0;
  reg net_111 = 1'b0;
  reg net_120 = 1'b0;
  reg net_117 = 1'b0;
  reg net_118 = 1'b0;
  reg net_119 = 1'b0;
  reg net_130 = 1'b0;
  reg net_128 = 1'b0;
  reg net_126 = 1'b0;
  reg net_107 = 1'b0;
  reg net_108 = 1'b0;
  reg net_116 = 1'b0;
  reg net_115 = 1'b0;
  reg net_134 = 1'b0;
  reg net_131 = 1'b0;
  reg net_135 = 1'b0;
  reg net_136 = 1'b0;
  reg net_139 = 1'b0;
  reg net_141 = 1'b0;
  reg net_140 = 1'b0;
  reg net_142 = 1'b0;
  reg net_151 = 1'b0;
  reg net_150 = 1'b0;
  reg net_149 = 1'b0;
  reg net_155 = 1'b0;
  reg net_163 = 1'b0;
  reg net_165 = 1'b0;
  reg net_162 = 1'b0;
  reg net_166 = 1'b0;
  reg net_174 = 1'b0;
  reg net_175 = 1'b0;
  reg net_178 = 1'b0;
  reg net_176 = 1'b0;
  reg net_180 = 1'b0;
  reg net_181 = 1'b0;
  reg net_189 = 1'b0;
  reg net_190 = 1'b0;
  reg net_188 = 1'b0;
  reg net_196 = 1'b0;
  reg net_195 = 1'b0;
  reg net_194 = 1'b0;
  reg net_198 = 1'b0;
  reg net_205 = 1'b0;
  reg net_200 = 1'b0;
  reg net_201 = 1'b0;
  reg net_202 = 1'b0;
  reg net_207 = 1'b0;
  reg net_206 = 1'b0;
  reg net_208 = 1'b0;
  reg net_210 = 1'b0;
  reg net_212 = 1'b0;
  reg net_214 = 1'b0;
  reg net_215 = 1'b0;
  reg net_217 = 1'b0;
  reg net_216 = 1'b0;
  reg net_226 = 1'b0;
  reg net_227 = 1'b0;
  reg net_223 = 1'b0;
  reg net_225 = 1'b0;
  reg net_228 = 1'b0;
  reg net_229 = 1'b0;
  reg net_230 = 1'b0;
  reg net_231 = 1'b0;
  reg net_233 = 1'b0;
  reg net_239 = 1'b0;
  reg net_242 = 1'b0;
  reg net_243 = 1'b0;
  reg net_247 = 1'b0;
  reg net_248 = 1'b0;
  reg net_253 = 1'b0;
  reg net_256 = 1'b0;
  reg net_255 = 1'b0;
  reg net_263 = 1'b0;
  reg net_262 = 1'b0;
  reg net_267 = 1'b0;
  reg net_268 = 1'b0;
  reg net_271 = 1'b0;
  reg net_275 = 1'b0;
  reg net_277 = 1'b0;
  reg net_278 = 1'b0;
  reg net_279 = 1'b0;
  reg net_280 = 1'b0;
  reg net_284 = 1'b0;
  reg net_285 = 1'b0;
  reg net_283 = 1'b0;
  reg net_289 = 1'b0;
  reg net_291 = 1'b0;
  reg net_290 = 1'b0;
  reg net_293 = 1'b0;
  reg net_292 = 1'b0;
  reg net_294 = 1'b0;
  reg net_297 = 1'b0;
  reg net_296 = 1'b0;
  reg net_295 = 1'b0;
  reg net_299 = 1'b0;
  reg net_298 = 1'b0;
  reg net_301 = 1'b0;
  reg net_302 = 1'b0;
  reg net_303 = 1'b0;
  reg net_300 = 1'b0;
  reg net_311 = 1'b0;
  reg net_314 = 1'b0;
  reg net_322 = 1'b0;
  reg net_318 = 1'b0;
  reg net_317 = 1'b0;
  reg net_324 = 1'b0;
  reg net_325 = 1'b0;
  reg net_326 = 1'b0;
  reg net_330 = 1'b0;
  reg net_333 = 1'b0;
  reg net_336 = 1'b0;
  reg net_341 = 1'b0;
  reg net_342 = 1'b0;
  reg net_351 = 1'b0;
  reg net_356 = 1'b0;
  reg net_358 = 1'b0;
  reg net_360 = 1'b0;
  reg net_364 = 1'b0;
  reg net_362 = 1'b0;
  reg net_363 = 1'b0;
  reg net_366 = 1'b0;
  reg net_368 = 1'b0;
  reg net_367 = 1'b0;
  reg net_365 = 1'b0;
  reg net_372 = 1'b0;
  reg net_370 = 1'b0;
  reg net_371 = 1'b0;
  reg net_369 = 1'b0;
  reg net_376 = 1'b0;
  reg net_375 = 1'b0;
  reg net_396 = 1'b0;
  reg net_388 = 1'b0;
  reg net_386 = 1'b0;
  reg net_405 = 1'b0;
  reg net_404 = 1'b0;
  reg net_402 = 1'b0;
  reg net_421 = 1'b0;
  reg net_418 = 1'b0;
  reg net_420 = 1'b0;
  reg net_417 = 1'b0;
  reg net_435 = 1'b0;
  reg net_434 = 1'b0;
  reg net_433 = 1'b0;
  reg net_443 = 1'b0;
  reg net_441 = 1'b0;
  reg net_442 = 1'b0;
  reg net_440 = 1'b0;
  reg net_450 = 1'b0;
  reg net_377 = 1'b0;
  reg net_374 = 1'b0;
  reg net_373 = 1'b0;
  reg net_380 = 1'b0;
  reg net_389 = 1'b0;
  reg net_400 = 1'b0;
  reg net_387 = 1'b0;
  reg net_399 = 1'b0;
  reg net_401 = 1'b0;
  reg net_411 = 1'b0;
  reg net_403 = 1'b0;
  reg net_407 = 1'b0;
  reg net_416 = 1'b0;
  reg net_427 = 1'b0;
  reg net_419 = 1'b0;
  reg net_422 = 1'b0;
  reg net_432 = 1'b0;
  reg net_438 = 1'b0;
  reg net_448 = 1'b0;
  reg net_445 = 1'b0;
  reg net_458 = 1'b0;
  reg net_457 = 1'b0;
  reg net_456 = 1'b0;
  reg net_460 = 1'b0;
  reg net_461 = 1'b0;
  reg net_459 = 1'b0;
  reg net_469 = 1'b0;
  reg net_471 = 1'b0;
  reg net_482 = 1'b0;
  reg net_478 = 1'b0;
  reg net_484 = 1'b0;
  reg net_486 = 1'b0;
  reg net_491 = 1'b0;
  reg net_501 = 1'b0;
  reg net_508 = 1'b0;
  reg net_505 = 1'b0;
  reg net_506 = 1'b0;
  reg net_504 = 1'b0;
  reg net_511 = 1'b0;
  reg net_510 = 1'b0;
  reg net_516 = 1'b0;
  reg net_518 = 1'b0;
  reg net_520 = 1'b0;
  reg net_522 = 1'b0;
  reg net_521 = 1'b0;
  reg net_527 = 1'b0;
  reg net_530 = 1'b0;
  reg net_531 = 1'b0;
  reg net_534 = 1'b0;
  reg net_538 = 1'b0;
  reg net_539 = 1'b0;
  reg net_543 = 1'b0;
  reg net_544 = 1'b0;
  reg net_542 = 1'b0;
  reg net_552 = 1'b0;
  reg net_553 = 1'b0;
  reg net_560 = 1'b0;
  reg net_577 = 1'b1;
  reg net_583 = 1'b0;
  reg net_589 = 1'b0;
  reg net_591 = 1'b0;
  reg net_596 = 1'b0;
  reg net_597 = 1'b0;
  reg net_598 = 1'b0;
  reg net_599 = 1'b0;
  reg net_600 = 1'b0;
  reg net_602 = 1'b0;
  reg net_605 = 1'b0;
  reg net_608 = 1'b0;
  reg net_610 = 1'b0;
  reg net_609 = 1'b0;
  reg net_607 = 1'b0;
  reg net_620 = 1'b0, net_616 = 1'b0, net_618 = 1'b0, net_617 = 1'b0;
  reg net_619 = 1'b0;
  reg net_621 = 1'b0;
  reg net_627 = 1'b0;
  reg net_635 = 1'b0;
  reg net_638 = 1'b0;
  reg net_639 = 1'b0;
  reg net_643 = 1'b0;
  reg net_645 = 1'b0;
  reg net_644 = 1'b0;
  reg net_655 = 1'b0;
  reg net_654 = 1'b0;
  reg net_662 = 1'b0;
  reg net_669 = 1'b1;
  reg net_671 = 1'b1;
  reg net_676 = 1'b1;
  reg net_683 = 1'b0;
  reg net_689 = 1'b0;
  reg net_744 = 1'b0;
  reg net_745 = 1'b0;
  reg net_746 = 1'b0;
  reg net_749 = 1'b0;
  reg net_748 = 1'b0;
  reg net_747 = 1'b0;
  reg net_752 = 1'b0;
  reg net_761 = 1'b0;
  reg net_767 = 1'b0;
  reg net_760 = 1'b0;
  reg net_762 = 1'b0;
  reg net_772 = 1'b0;
  reg net_773 = 1'b0;
  reg net_759 = 1'b0;
  reg net_775 = 1'b0;
  reg net_776 = 1'b0;
  reg net_777 = 1'b0;
  reg net_788 = 1'b0;
  reg net_799 = 1'b0;
  reg net_791 = 1'b0;
  reg net_800 = 1'b0;
  reg net_806 = 1'b0;
  reg net_808 = 1'b0;
  reg net_819 = 1'b0;
  reg net_818 = 1'b0;
  reg net_812 = 1'b0;
  reg net_827 = 1'b1;
  reg net_821 = 1'b0;
  reg net_823 = 1'b0;
  reg net_828 = 1'b0;
  reg net_833 = 1'b0;
  reg net_835 = 1'b0;
  reg net_831 = 1'b1;
  reg net_832 = 1'b0;
  reg net_845 = 1'b0;
  reg net_864 = 1'b0;
  reg net_866 = 1'b0;
  reg net_865 = 1'b0;
  reg net_867 = 1'b0;
  reg net_870 = 1'b0;
  reg net_872 = 1'b0;
  reg net_875 = 1'b0;
  reg net_878 = 1'b0;
  reg net_877 = 1'b0;
  reg net_876 = 1'b0;
  reg net_884 = 1'b0;
  reg net_881 = 1'b0;
  reg net_886 = 1'b0;
  reg net_887 = 1'b0;
  reg net_888 = 1'b0;
  reg net_885 = 1'b0;
  reg net_890 = 1'b0;
  reg net_898 = 1'b0;
  reg net_899 = 1'b0;
  reg net_901 = 1'b0;
  reg net_907 = 1'b0;
  reg net_911 = 1'b0;
  reg net_908 = 1'b0;
  reg net_909 = 1'b0;
  reg net_917 = 1'b0;
  reg net_919 = 1'b0;
  reg net_927 = 1'b0;
  reg net_923 = 1'b0;
  reg net_938 = 1'b0;
  reg net_933 = 1'b0;
  reg net_932 = 1'b0;
  reg net_928 = 1'b1;
  reg net_941 = 1'b0;
  reg net_944 = 1'b0;
  reg net_946 = 1'b1;
  reg net_948 = 1'b0;
  reg net_956 = 1'b0;
  reg net_971 = 1'b0;
  reg net_972 = 1'b0;
  reg net_973 = 1'b0;
  reg net_974 = 1'b0;
  reg net_978 = 1'b0;
  reg net_981 = 1'b0;
  reg net_988 = 1'b0;
  reg net_986 = 1'b0;
  reg net_982 = 1'b0;
  reg net_990 = 1'b0;
  reg net_989 = 1'b0;
  reg net_992 = 1'b0;
  reg net_1009 = 1'b0, net_1001 = 1'b0, net_1003 = 1'b0, net_1002 = 1'b0, net_1005 = 1'b0, net_995 = 1'b0, net_997 = 1'b0, net_996 = 1'b0;
  reg net_994 = 1'b0;
  reg net_1006 = 1'b0;
  reg net_1007 = 1'b0;
  reg net_1012 = 1'b0;
  reg net_1011 = 1'b0;
  reg net_1014 = 1'b1;
  reg net_1015 = 1'b1;
  reg net_1019 = 1'b0;
  reg net_1025 = 1'b0;
  reg net_1024 = 1'b0;
  reg net_1029 = 1'b0;
  reg net_1043 = 1'b0;
  reg net_1042 = 1'b1;
  reg net_1039 = 1'b0;
  reg net_1037 = 1'b0;
  reg net_1051 = 1'b0;
  reg net_1046 = 1'b0;
  reg net_1044 = 1'b0;
  reg net_1053 = 1'b0;
  reg net_1062 = 1'b0;
  reg net_1058 = 1'b0;
  reg net_1059 = 1'b0;
  reg net_1070 = 1'b0;
  reg net_1069 = 1'b0;
  reg net_1075 = 1'b0;
  reg net_1074 = 1'b0;
  reg net_1079 = 1'b0;
  reg net_1085 = 1'b0;
  reg net_1086 = 1'b0;
  reg net_1084 = 1'b0;
  reg net_1091 = 1'b0;
  reg net_1096 = 1'b0;
  reg net_1092 = 1'b0;
  reg net_1100 = 1'b0;
  reg net_1103 = 1'b0;
  reg net_1104 = 1'b0;
  reg net_1102 = 1'b0;
  reg net_1101 = 1'b0;
  reg net_1118 = 1'b0;
  reg net_1109 = 1'b0;
  reg net_1110 = 1'b0;
  reg net_1115 = 1'b0;
  reg net_1119 = 1'b0;
  reg net_1130 = 1'b0;
  reg net_1123 = 1'b0;
  reg net_1124 = 1'b0;
  reg net_1138 = 1'b0;
  reg net_1137 = 1'b0;
  reg net_1122 = 1'b1;
  reg net_1139 = 1'b0;
  reg net_1133 = 1'b0;
  reg net_1134 = 1'b0;
  reg net_1143 = 1'b0;
  reg net_1153 = 1'b0;
  reg net_1151 = 1'b0;
  reg net_1144 = 1'b0;
  reg net_1150 = 1'b0;
  reg net_1152 = 1'b0;
  reg net_1158 = 1'b0;
  reg net_1157 = 1'b0;
  reg net_1166 = 1'b1;
  reg net_1163 = 1'b1;
  reg net_1167 = 1'b1;
  reg net_1173 = 1'b0;
  reg net_1172 = 1'b0;
  reg net_1170 = 1'b0;
  reg net_1175 = 1'b0;
  reg net_1176 = 1'b0;
  reg net_1181 = 1'b0;
  reg net_1177 = 1'b0;
  reg net_1187 = 1'b0;
  reg net_1193 = 1'b0;
  reg net_1195 = 1'b0;
  reg net_1190 = 1'b0;
  reg net_1197 = 1'b0;
  reg net_1186 = 1'b0;
  reg net_1182 = 1'b0;
  reg net_1198 = 1'b0;
  reg net_1202 = 1'b0;
  reg net_1203 = 1'b0;
  reg net_1205 = 1'b0;
  reg net_1211 = 1'b0;
  reg net_1241 = 1'b0, net_1231 = 1'b0, net_1233 = 1'b0, net_1232 = 1'b0, net_1234 = 1'b0, net_1223 = 1'b0, net_1226 = 1'b0, net_1224 = 1'b0, net_1227 = 1'b0, net_1214 = 1'b0, net_1216 = 1'b0, net_1215 = 1'b0;
  reg net_1213 = 1'b0;
  reg net_1218 = 1'b0;
  reg net_1219 = 1'b0;
  reg net_1230 = 1'b0;
  reg net_1225 = 1'b0;
  reg net_1237 = 1'b0;
  reg net_1236 = 1'b0;
  reg net_1248 = 1'b0;
  reg net_1250 = 1'b0;
  reg net_1246 = 1'b0;
  reg net_1243 = 1'b0;
  reg net_1239 = 1'b0;
  reg net_1257 = 1'b0;
  reg net_1254 = 1'b0;
  reg net_1256 = 1'b0;
  reg net_1255 = 1'b0;
  reg net_1261 = 1'b0;
  reg net_1260 = 1'b0;
  reg net_1288 = 1'b0, net_1279 = 1'b0, net_1281 = 1'b1, net_1280 = 1'b1, net_1282 = 1'b0, net_1272 = 1'b0, net_1274 = 1'b1, net_1273 = 1'b0, net_1275 = 1'b0, net_1265 = 1'b0, net_1267 = 1'b0, net_1266 = 1'b0;
  reg net_1264 = 1'b0;
  reg net_1263 = 1'b0;
  reg net_1271 = 1'b0;
  reg net_1270 = 1'b0;
  reg net_1278 = 1'b1;
  reg net_1285 = 1'b0;
  reg net_1284 = 1'b0;
  reg net_1296 = 1'b0;
  reg net_1297 = 1'b0;
  reg net_1287 = 1'b0;
  reg net_1292 = 1'b0;
  reg net_1293 = 1'b0;
  reg net_1301 = 1'b0;
  reg net_1300 = 1'b0;
  reg net_1299 = 1'b0;
  reg net_1302 = 1'b0;
  reg net_1314 = 1'b0;
  reg net_1312 = 1'b0;
  reg net_1311 = 1'b0;
  reg net_1313 = 1'b0;
  reg net_1323 = 1'b0;
  reg net_1324 = 1'b0;
  reg net_1325 = 1'b0;
  reg net_1330 = 1'b0;
  reg net_1331 = 1'b0;
  reg net_1334 = 1'b0;
  reg net_1337 = 1'b0;
  reg net_1346 = 1'b0;
  reg net_1340 = 1'b0;
  reg net_1347 = 1'b0;
  reg net_1348 = 1'b0;
  reg net_1350 = 1'b0;
  reg net_1370 = 1'b0, net_1354 = 1'b0, net_1358 = 1'b0, net_1355 = 1'b0, net_1359 = 1'b0, net_1351 = 1'b0, net_1353 = 1'b0, net_1352 = 1'b0;
  reg net_1363 = 1'b0;
  reg net_1357 = 1'b0;
  reg net_1356 = 1'b0;
  reg net_1360 = 1'b0;
  reg net_1381 = 1'b0;
  reg net_1371 = 1'b0;
  reg net_1369 = 1'b0;
  reg net_1372 = 1'b0;
  reg net_1382 = 1'b0;
  reg net_1385 = 1'b0;
  reg net_1383 = 1'b0;
  reg net_1387 = 1'b0;
  reg net_1386 = 1'b0;
  reg net_1391 = 1'b0;
  reg net_1388 = 1'b0;
  reg net_1403 = 1'b0;
  reg net_1400 = 1'b0;
  reg net_1409 = 1'b0;
  reg net_1407 = 1'b0;
  reg net_1411 = 1'b0;
  reg net_1410 = 1'b0;
  reg net_1425 = 1'b0;
  reg net_1429 = 1'b0;
  reg net_1432 = 1'b0;
  reg net_1441 = 1'b0;
  reg net_1439 = 1'b0;
  reg net_1446 = 1'b0;
  reg net_1449 = 1'b0;
  reg net_1455 = 1'b0;
  reg net_1458 = 1'b0;
  reg net_1456 = 1'b0;
  reg net_1462 = 1'b0;
  reg net_1459 = 1'b0;
  reg net_1466 = 1'b0;
  reg net_1465 = 1'b0;
  reg net_1467 = 1'b0;
  reg net_1393 = 1'b0;
  reg net_1389 = 1'b0;
  reg net_1396 = 1'b0;
  reg net_1395 = 1'b0;
  reg net_1394 = 1'b0;
  reg net_1397 = 1'b0;
  reg net_1412 = 1'b0;
  reg net_1413 = 1'b0;
  reg net_1408 = 1'b0;
  reg net_1422 = 1'b0;
  reg net_1423 = 1'b0;
  reg net_1434 = 1'b0;
  reg net_1424 = 1'b0;
  reg net_1427 = 1'b0;
  reg net_1438 = 1'b0;
  reg net_1443 = 1'b0;
  reg net_1440 = 1'b0;
  reg net_1444 = 1'b0;
  reg net_1454 = 1'b0;
  reg net_1461 = 1'b0;
  reg net_1460 = 1'b0;
  reg net_1472 = 1'b0;
  reg net_1471 = 1'b0;
  reg net_1483 = 1'b0, net_1478 = 1'b0, net_1480 = 1'b0, net_1479 = 1'b0, net_1481 = 1'b0, net_1473 = 1'b0, net_1475 = 1'b0, net_1474 = 1'b0;
  reg net_1489 = 1'b0;
  reg net_1488 = 1'b0;
  reg net_1487 = 1'b0;
  reg net_1486 = 1'b0;
  reg net_1482 = 1'b0;
  reg net_1492 = 1'b0;
  reg net_1496 = 1'b1;
  reg net_1493 = 1'b0;
  reg net_1497 = 1'b0;
  reg net_1502 = 1'b0;
  reg net_1494 = 1'b0;
  reg net_1506 = 1'b0;
  reg net_1504 = 1'b0;
  reg net_1508 = 1'b0;
  reg net_1507 = 1'b0;
  reg net_1509 = 1'b0;
  reg net_1511 = 1'b0;
  reg net_1517 = 1'b0;
  reg net_1510 = 1'b1;
  reg net_1519 = 1'b0;
  reg net_1522 = 1'b1;
  reg net_1527 = 1'b0;
  reg net_1532 = 1'b0;
  reg net_1529 = 1'b0;
  reg net_1568 = 1'b0;
  reg net_1559 = 1'b0;
  reg net_1558 = 1'b0;
  reg net_1562 = 1'b0;
  reg net_1570 = 1'b0;
  reg net_1571 = 1'b0;
  reg net_1569 = 1'b0;
  reg net_1572 = 1'b0;
  reg net_1581 = 1'b0;
  reg net_1592 = 1'b0;
  reg net_1582 = 1'b0;
  reg net_1585 = 1'b0;
  reg net_1596 = 1'b0;
  reg net_1606 = 1'b0;
  reg net_1597 = 1'b0;
  reg net_1598 = 1'b0;
  reg net_1611 = 1'b0;
  reg net_1616 = 1'b0;
  reg net_1583 = 1'b0;
  reg net_1589 = 1'b0;
  reg net_1603 = 1'b0;
  reg net_1602 = 1'b0;
  reg net_1612 = 1'b0;
  reg net_1610 = 1'b0;
  reg net_1617 = 1'b0;
  reg net_1618 = 1'b0;
  reg net_1629 = 1'b0;
  reg net_1620 = 1'b0;
  reg net_1619 = 1'b0;
  reg net_1622 = 1'b0;
  reg net_1638 = 1'b0;
  reg net_1633 = 1'b0;
  reg net_1630 = 1'b0;
  reg net_1634 = 1'b0;
  reg net_1644 = 1'b0;
  reg net_1650 = 1'b0;
  reg net_1632 = 1'b0;
  reg net_1631 = 1'b0;
  reg net_1646 = 1'b0;
  reg net_1647 = 1'b0;
  reg net_1645 = 1'b0;
  reg net_1656 = 1'b0;
  reg net_1658 = 1'b0;
  reg net_1657 = 1'b0;
  reg net_1655 = 1'b0;
  reg net_1666 = 1'b0;
  reg net_1663 = 1'b0;
  reg net_1667 = 1'b0;
  reg net_1670 = 1'b0;
  reg net_1672 = 1'b0;
  reg net_1671 = 1'b0;

//---------------------------------------------------------------------------
//Bidirectional and output pad assignments

  assign io_i2c_scl = net_341;
  assign io_i2c_sda = net_194 ? net_342 : 1'bZ;
  assign o_pwm_display = net_1118;
  assign o_dac_d[1] = net_23;
  assign o_dac_d[0] = net_22;
  assign io_mcu_d[4] = net_288 ? net_324 : 1'bZ;
  assign io_mcu_d[5] = net_288 ? net_256 : 1'bZ;
  assign io_mcu_d[6] = net_288 ? net_190 : 1'bZ;
  assign io_mcu_d[7] = net_288 ? net_188 : 1'bZ;
  assign o_dac_d[2] = net_21;
  assign o_dac_d[5] = net_26;
  assign o_dac_d[3] = net_24;
  assign o_dac_d[4] = net_27;
  assign io_mcu_d[2] = net_288 ? net_908 : 1'bZ;
  assign io_mcu_d[3] = net_288 ? net_262 : 1'bZ;
  assign io_mcu_d[1] = net_288 ? net_662 : 1'bZ;
  assign io_mcu_d[0] = net_288 ? net_911 : 1'bZ;
  assign o_dac_d[6] = net_25;
  assign o_dac_d[7] = net_28;
  assign o_ac_dc_2 = net_253;
  assign o_ac_dc_1 = net_322;
  assign o_relay1_2 = net_866;
  assign o_relay1_1 = net_864;
  assign o_relay2_2 = net_972;
  assign o_relay1_3 = net_865;
  assign o_relay2_3 = net_973;
  assign o_relay2_1 = net_971;
  assign o_adc1_encB = net_1502;
  assign o_adc2_encA = net_1471;
  assign o_adc2_encB = net_1472;
  assign o_offset_2 = net_788;
  assign o_offset_1 = net_990;
  assign o_adc1_encA = net_1618;

//---------------------------------------------------------------------------
//Clock assignments


//---------------------------------------------------------------------------
//Block 101, LSLICE 2

  assign sig_101_lut_0 = (~net_234 & ~net_512 & ((~net_121 & net_65) | (net_121 & net_65))) | (~net_234 & net_512 & ((net_121 | net_65))) | (net_234 & net_512 & ((net_121 & ~net_65) | (net_121 & net_65)));
  assign sig_101_lut_1 = (~net_123 & ~net_234 & ((~net_512 & net_66) | (net_512 & net_66))) | (net_123 & ~net_234 & ((net_512 | net_66))) | (net_123 & net_234 & ((net_512 & ~net_66) | (net_512 & net_66)));

  always @(posedge gclk_9)
  begin
    net_65 <= sig_101_lut_0;
    net_66 <= sig_101_lut_1;
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 102, 103, 104, 105, 106, 108

  always @(posedge gclk_7)
  begin
    if(net_137 == 1'b1)   //reset
    begin
      { net_76, net_74, net_77, net_70, net_72, net_71, net_73, net_67, net_69, net_68 } <= { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      { net_76, net_74, net_77, net_70, net_72, net_71, net_73, net_67, net_69, net_68 } <= { net_76, net_74, net_77, net_70, net_72, net_71, net_73, net_67, net_69, net_68 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
    end
  end

//---------------------------------------------------------------------------
//Block 107, LSLICE 2

  assign net_79 = (~net_70 & ~net_80 & ~net_77 & ((net_226 | net_78))) | (~net_70 & ~net_80 & net_77 & ((net_226 & net_78))) | (~net_70 & net_80 & ~net_77) | (~net_70 & net_80 & net_77 & ((net_226 & ~net_78) | (net_226 & net_78))) | (net_70 & ~net_80 & ~net_77 & ((net_226 & ~net_78) | (net_226 & net_78))) | (net_70 & net_80 & ~net_77 & ((net_226 | net_78))) | (net_70 & net_80 & net_77 & ((net_226 & net_78)));
  assign net_78 = (~net_227 & ~net_133 & ~net_71 & ((~net_72 & net_75))) | (~net_227 & net_133 & ~net_71 & ((~net_72 & ~net_75) | (~net_72 & net_75))) | (~net_227 & net_133 & net_71 & ((~net_72 & net_75))) | (net_227 & ~net_133 & ~net_71 & (~(net_72 & ~net_75))) | (net_227 & ~net_133 & net_71 & ((~net_72 & ~net_75) | (~net_72 & net_75))) | (net_227 & net_133 & ~net_71) | (net_227 & net_133 & net_71 & (~(net_72 & ~net_75)));

  always @(posedge gclk_9)
  begin
    if(net_221 == 1'b1)   //enable
     begin
      net_80 <= io_mcu_d[6];
      net_75 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 109, LSLICE 2

  assign net_84 = (~net_148 & ~net_82 & ~net_239 & (~(net_155 & ~net_81))) | (~net_148 & net_82 & ~net_239 & (~(net_155 & ~net_81))) | (~net_148 & net_82 & net_239 & (~(net_155 & ~net_81)));
  assign net_83 = (~net_141 & ~net_239 & ((~net_176 & ~net_82) | (net_176 & ~net_82))) | (~net_141 & net_239) | (net_141 & ~net_239 & ((net_176 & ~net_82))) | (net_141 & net_239 & ((net_176 & ~net_82) | (net_176 & net_82)));

  always @(posedge gclk_9)
  begin
    if(net_235 == 1'b1)   //enable
     begin
      net_81 <= io_mcu_d[4];
      net_82 <= io_mcu_d[5];
    end
  end

//---------------------------------------------------------------------------
//Block 110, MSLICE 1

  assign sig_110_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_37 & ~net_46) | (net_37 & net_46))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_37 & net_46) | (net_37 & net_46)));
  assign sig_110_lut_1 = 1'b0;
  assign net_85 = (~net_187 & sig_110_lut_0) | (net_187 & sig_110_lut_1);

//---------------------------------------------------------------------------
//Block 111, MSLICE 0

  assign sig_111_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_31 & ~net_39) | (net_31 & net_39))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_31 & net_39) | (net_31 & net_39)));
  assign sig_111_lut_1 = 1'b0;
  assign net_86 = (~net_93 & sig_111_lut_0) | (net_93 & sig_111_lut_1);

//---------------------------------------------------------------------------
//Block 112, LSLICE 3

  assign net_90 = (~net_240 & ~net_89 & ~net_178) | (~net_240 & ~net_89 & net_178) | (net_240 & ~net_89 & ~net_178) | (net_240 & ~net_89 & net_178) | (net_240 & net_89 & net_178 & ((net_233 & net_165)));
  assign net_89 = (~net_174 & ~net_88 & ~net_166 & ((~net_162 & ~net_87)));

  always @(posedge gclk_5)
  begin
    if(net_90 == 1'b1)   //reset
    begin
      net_88 <= 1'b0;
      net_87 <= 1'b0;
    end
    else
    begin
      net_88 <= net_171;
      net_87 <= net_169;
    end
  end

//---------------------------------------------------------------------------
//Block 113, MSLICE 1

  assign sig_113_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((~net_33 & ~net_43) | (~net_33 & net_43))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_33 & ~net_43) | (net_33 & ~net_43)));
  assign sig_113_lut_1 = 1'b0;
  assign net_91 = (~net_92 & sig_113_lut_0) | (net_92 & sig_113_lut_1);

//---------------------------------------------------------------------------
//Block 114, MSLICE 0

  assign sig_114_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_34 & ~net_44) | (net_34 & net_44))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_34 & net_44) | (net_34 & net_44)));
  assign sig_114_lut_1 = 1'b0;
  assign net_95 = (~net_96 & sig_114_lut_0) | (net_96 & sig_114_lut_1);

//---------------------------------------------------------------------------
//Block 115, LSLICE 2

  assign net_94 = (~net_57 & ~net_1044 & ((~net_48 & ~net_189))) | (~net_57 & net_1044 & ((~net_48 & ~net_189) | (net_48 & ~net_189))) | (net_57 & ~net_1044 & ((~net_48 & ~net_189)));
  assign net_96 = (~net_62 & ~net_189 & (~(net_54 & ~net_1044))) | (net_62 & ~net_189 & ((~net_54 & ~net_1044)));

//---------------------------------------------------------------------------
//Block 116, LSLICE 3

  assign net_92 = (~net_1044 & ~net_189 & ((net_52 & ~net_58) | (net_52 & net_58))) | (net_1044 & ~net_189 & ((~net_52 & net_58) | (net_52 & net_58)));
  assign net_93 = (~net_49 & ~net_189 & (~(net_60 & net_1044))) | (net_49 & ~net_189 & ((~net_60 & net_1044)));

//---------------------------------------------------------------------------
//Block 117, LSLICE 3

  assign sig_117_lut_0 = (~io_mcu_d[2] & ~net_264 & ~i_mcu_dcs & ((~net_793 & net_98) | (net_793 & net_98))) | (~io_mcu_d[2] & ~net_264 & i_mcu_dcs & ((net_793 & net_98))) | (~io_mcu_d[2] & net_264 & ~i_mcu_dcs & ((net_793 & net_98))) | (~io_mcu_d[2] & net_264 & i_mcu_dcs & ((net_793 & net_98))) | (io_mcu_d[2] & ~net_264 & ~i_mcu_dcs & ((~net_793 & net_98) | (net_793 & net_98))) | (io_mcu_d[2] & ~net_264 & i_mcu_dcs & ((net_793 & net_98))) | (io_mcu_d[2] & net_264 & ~i_mcu_dcs) | (io_mcu_d[2] & net_264 & i_mcu_dcs & ((net_793 & net_98)));
  assign sig_117_lut_1 = (~io_mcu_d[3] & ~i_mcu_dcs & ~net_264 & ((~net_793 & net_97) | (net_793 & net_97))) | (~io_mcu_d[3] & ~i_mcu_dcs & net_264 & ((net_793 & net_97))) | (~io_mcu_d[3] & i_mcu_dcs & ~net_264 & ((net_793 & net_97))) | (~io_mcu_d[3] & i_mcu_dcs & net_264 & ((net_793 & net_97))) | (io_mcu_d[3] & ~i_mcu_dcs & ~net_264 & ((~net_793 & net_97) | (net_793 & net_97))) | (io_mcu_d[3] & ~i_mcu_dcs & net_264) | (io_mcu_d[3] & i_mcu_dcs & ~net_264 & ((net_793 & net_97))) | (io_mcu_d[3] & i_mcu_dcs & net_264 & ((net_793 & net_97)));

  always @(posedge gclk_9)
  begin
    net_98 <= sig_117_lut_0;
    net_97 <= sig_117_lut_1;
  end

//---------------------------------------------------------------------------
//Block 118, LSLICE 3

  assign sig_118_lut_0 = (~i_mcu_dcs & ~net_100 & ~io_mcu_d[5] & ((~net_793 & net_99) | (net_793 & net_99))) | (~i_mcu_dcs & ~net_100 & io_mcu_d[5] & ((~net_793 & net_99) | (net_793 & net_99))) | (~i_mcu_dcs & net_100 & io_mcu_d[5] & (~(net_793 & ~net_99))) | (i_mcu_dcs & ~net_100 & ~io_mcu_d[5] & (~(net_793 & ~net_99))) | (i_mcu_dcs & ~net_100 & io_mcu_d[5] & (~(net_793 & ~net_99))) | (i_mcu_dcs & net_100 & ~io_mcu_d[5] & (~(net_793 & ~net_99))) | (i_mcu_dcs & net_100 & io_mcu_d[5] & (~(net_793 & ~net_99)));
  assign net_100 = ((i_mcu_rws & net_648));

  always @(posedge gclk_9)
  begin
    net_99 <= sig_118_lut_0;
  end

//---------------------------------------------------------------------------
//Block 119, LSLICE 2

  assign sig_119_lut_0 = (~net_816 & ~i_mcu_dcs & ~io_mcu_d[2] & ((~net_793 & net_102) | (net_793 & net_102))) | (~net_816 & ~i_mcu_dcs & io_mcu_d[2] & ((~net_793 & net_102) | (net_793 & net_102))) | (~net_816 & i_mcu_dcs & ~io_mcu_d[2] & (~(net_793 & ~net_102))) | (~net_816 & i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_102))) | (net_816 & ~i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_102))) | (net_816 & i_mcu_dcs & ~io_mcu_d[2] & (~(net_793 & ~net_102))) | (net_816 & i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_102)));
  assign sig_119_lut_1 = (~io_mcu_d[3] & ~net_816 & ~i_mcu_dcs & ((~net_793 & net_104) | (net_793 & net_104))) | (~io_mcu_d[3] & ~net_816 & i_mcu_dcs & ((net_793 & net_104))) | (~io_mcu_d[3] & net_816 & ~i_mcu_dcs & ((net_793 & net_104))) | (~io_mcu_d[3] & net_816 & i_mcu_dcs & ((net_793 & net_104))) | (io_mcu_d[3] & ~net_816 & ~i_mcu_dcs & ((~net_793 & net_104) | (net_793 & net_104))) | (io_mcu_d[3] & ~net_816 & i_mcu_dcs & ((net_793 & net_104))) | (io_mcu_d[3] & net_816 & ~i_mcu_dcs) | (io_mcu_d[3] & net_816 & i_mcu_dcs & ((net_793 & net_104)));

  always @(posedge gclk_9)
  begin
    net_102 <= sig_119_lut_0;
    net_104 <= sig_119_lut_1;
  end

//---------------------------------------------------------------------------
//Block 120, LSLICE 3

  assign sig_120_lut_0 = (~io_mcu_d[5] & ~net_816 & ~i_mcu_dcs & ((~net_793 & net_103) | (net_793 & net_103))) | (~io_mcu_d[5] & ~net_816 & i_mcu_dcs & ((net_793 & net_103))) | (~io_mcu_d[5] & net_816 & ~i_mcu_dcs & ((net_793 & net_103))) | (~io_mcu_d[5] & net_816 & i_mcu_dcs & ((net_793 & net_103))) | (io_mcu_d[5] & ~net_816 & ~i_mcu_dcs & ((~net_793 & net_103) | (net_793 & net_103))) | (io_mcu_d[5] & ~net_816 & i_mcu_dcs & ((net_793 & net_103))) | (io_mcu_d[5] & net_816 & ~i_mcu_dcs) | (io_mcu_d[5] & net_816 & i_mcu_dcs & ((net_793 & net_103)));
  assign sig_120_lut_1 = (~io_mcu_d[4] & ~net_816 & ~i_mcu_dcs & ((~net_793 & net_101) | (net_793 & net_101))) | (~io_mcu_d[4] & ~net_816 & i_mcu_dcs & ((net_793 & net_101))) | (~io_mcu_d[4] & net_816 & ~i_mcu_dcs & ((net_793 & net_101))) | (~io_mcu_d[4] & net_816 & i_mcu_dcs & ((net_793 & net_101))) | (io_mcu_d[4] & ~net_816 & ~i_mcu_dcs & ((~net_793 & net_101) | (net_793 & net_101))) | (io_mcu_d[4] & ~net_816 & i_mcu_dcs & ((net_793 & net_101))) | (io_mcu_d[4] & net_816 & ~i_mcu_dcs) | (io_mcu_d[4] & net_816 & i_mcu_dcs & ((net_793 & net_101)));

  always @(posedge gclk_9)
  begin
    net_103 <= sig_120_lut_0;
    net_101 <= sig_120_lut_1;
  end

//---------------------------------------------------------------------------
//Block 125, MSLICE 0

  always @(negedge gclk_9)
  begin
    net_112 <= net_115;
  end

//---------------------------------------------------------------------------
//Block 127, MSLICE 1

  always @(negedge gclk_9)
  begin
    net_110 <= net_290;
    net_111 <= net_216;
  end

//---------------------------------------------------------------------------
//Block 128, MSLICE 0

  always @(negedge gclk_9)
  begin
    net_120 <= net_66;
    net_117 <= net_108;
  end

//---------------------------------------------------------------------------
//Block 130, MSLICE 1

  always @(negedge gclk_9)
  begin
    net_118 <= net_107;
    net_119 <= net_65;
  end

//---------------------------------------------------------------------------
//Block 131, MSLICE 0

  always @(negedge gclk_9)
  begin
    net_130 <= net_217;
    net_128 <= net_291;
  end

//---------------------------------------------------------------------------
//Block 132, MSLICE 1

  always @(negedge gclk_9)
  begin
    net_126 <= net_116;
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 125, 127, 128, 130, 131, 132

  assign { net_129, net_125, net_127, net_121, net_124, net_122, net_123, net_113, net_109, net_114 } = { net_116, 1'b0, net_217, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, net_290, net_115 } + { 1'b0, net_291, 1'b0, net_65, net_107, net_108, net_66, net_216, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 126, LSLICE 2

  assign sig_126_lut_0 = (~net_124 & ~net_512 & ((~net_234 & net_107))) | (~net_124 & net_512 & ((~net_234 & net_107))) | (net_124 & ~net_512 & ((~net_234 & net_107))) | (net_124 & net_512);
  assign sig_126_lut_1 = (~net_234 & ~net_512 & ((~net_122 & net_108) | (net_122 & net_108))) | (~net_234 & net_512 & ((net_122 | net_108))) | (net_234 & net_512 & ((net_122 & ~net_108) | (net_122 & net_108)));

  always @(posedge gclk_9)
  begin
    net_107 <= sig_126_lut_0;
    net_108 <= sig_126_lut_1;
  end

//---------------------------------------------------------------------------
//Block 129, LSLICE 3

  assign sig_129_lut_0 = (~net_129 & ~net_512 & ((~net_234 & net_116))) | (~net_129 & net_512 & ((~net_234 & net_116))) | (net_129 & ~net_512 & ((~net_234 & net_116))) | (net_129 & net_512);
  assign sig_129_lut_1 = (~net_114 & ~net_512 & ((~net_234 & net_115))) | (~net_114 & net_512 & ((~net_234 & net_115))) | (net_114 & ~net_512 & ((~net_234 & net_115))) | (net_114 & net_512);

  always @(posedge gclk_9)
  begin
    net_116 <= sig_129_lut_0;
    net_115 <= sig_129_lut_1;
  end

//---------------------------------------------------------------------------
//Block 133, LSLICE 2

  assign net_133 = (~net_67 & ~net_134 & ~net_223 & ((~net_73 & ~net_132))) | (~net_67 & ~net_134 & net_223 & (~(net_73 & net_132))) | (~net_67 & net_134 & ~net_223 & ((~net_73 & ~net_132) | (~net_73 & net_132))) | (~net_67 & net_134 & net_223) | (net_67 & ~net_134 & net_223 & ((~net_73 & ~net_132) | (~net_73 & net_132))) | (net_67 & net_134 & ~net_223 & ((~net_73 & ~net_132))) | (net_67 & net_134 & net_223 & (~(net_73 & net_132)));
  assign net_132 = (~net_225 & ~net_69 & ((~net_68 & ~net_131) | (net_68 & ~net_131))) | (~net_225 & net_69) | (net_225 & ~net_69 & ((net_68 & ~net_131))) | (net_225 & net_69 & (~(~net_68 & net_131)));

  always @(posedge gclk_9)
  begin
    if(net_221 == 1'b1)   //enable
     begin
      net_134 <= io_mcu_d[2];
      net_131 <= io_mcu_d[1];
    end
  end

//---------------------------------------------------------------------------
//Block 134, LSLICE 3

  assign net_137 = (~net_74 & ~net_136 & ~net_79 & (~(~net_76 & net_135))) | (~net_74 & ~net_136 & net_79 & ((net_76 & ~net_135))) | (~net_74 & net_136 & ~net_79 & ((net_76 & ~net_135))) | (~net_74 & net_136 & net_79 & ((net_76 & ~net_135))) | (net_74 & ~net_136 & ~net_79 & (~(~net_76 & net_135))) | (net_74 & ~net_136 & net_79 & (~(~net_76 & net_135))) | (net_74 & net_136 & ~net_79 & (~(~net_76 & net_135))) | (net_74 & net_136 & net_79 & ((net_76 & ~net_135)));
  assign net_138 = (net_452 & ((net_220 & net_1283)));

  always @(posedge gclk_9)
  begin
    if(net_138 == 1'b1)   //enable
     begin
      net_135 <= io_mcu_d[1];
      net_136 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 135, MSLICE 0

  assign sig_135_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_29 & ~net_38) | (net_29 & net_38))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_29 & net_38) | (net_29 & net_38)));
  assign sig_135_lut_1 = 1'b0;
  assign net_146 = (~net_94 & sig_135_lut_0) | (net_94 & sig_135_lut_1);

//---------------------------------------------------------------------------
//Block 136, LSLICE 2

  assign net_144 = (~net_145 & ~net_165 & ~net_84 & ((net_83 & ~net_139))) | (~net_145 & net_165 & ~net_84 & (~(~net_83 & net_139))) | (~net_145 & net_165 & net_84 & ((~net_83 & ~net_139) | (net_83 & ~net_139))) | (net_145 & ~net_165 & ~net_84 & ((~net_83 & ~net_139) | (net_83 & ~net_139))) | (net_145 & ~net_165 & net_84 & ((~net_83 & ~net_139) | (net_83 & ~net_139))) | (net_145 & net_165 & ~net_84) | (net_145 & net_165 & net_84);
  assign net_145 = ((net_176 & ~net_141));

  always @(posedge gclk_9)
  begin
    if(net_235 == 1'b1)   //enable
     begin
      net_139 <= io_mcu_d[7];
      net_141 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 137, LSLICE 3

  assign net_143 = (~net_175 & ~net_142 & ~net_238 & ((~net_149 & ~net_140) | (~net_149 & net_140))) | (~net_175 & ~net_142 & net_238 & ((~net_149 & net_140))) | (~net_175 & net_142 & ~net_238) | (~net_175 & net_142 & net_238 & ((~net_149 & net_140) | (net_149 & net_140))) | (net_175 & ~net_142 & ~net_238 & ((~net_149 & net_140))) | (net_175 & net_142 & ~net_238 & ((~net_149 & net_140) | (net_149 & net_140)));
  assign net_148 = (~net_81 & ~net_155 & ~net_149 & ((~net_142 & ~net_143))) | (~net_81 & ~net_155 & net_149 & ((~net_142 & ~net_143) | (net_142 & ~net_143))) | (~net_81 & net_155 & ~net_149 & ((~net_142 & ~net_143))) | (~net_81 & net_155 & net_149 & ((~net_142 & ~net_143) | (net_142 & ~net_143))) | (net_81 & net_155 & ~net_149 & ((~net_142 & ~net_143))) | (net_81 & net_155 & net_149 & ((~net_142 & ~net_143) | (net_142 & ~net_143)));

  always @(posedge gclk_9)
  begin
    if(net_235 == 1'b1)   //enable
     begin
      net_140 <= io_mcu_d[2];
      net_142 <= io_mcu_d[3];
    end
  end

//---------------------------------------------------------------------------
//Block 138, MSLICE 1

  assign sig_138_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_36 & ~net_45) | (net_36 & net_45))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_36 & net_45) | (net_36 & net_45)));
  assign sig_138_lut_1 = 1'b0;
  assign net_147 = (~net_218 & sig_138_lut_0) | (net_218 & sig_138_lut_1);

//---------------------------------------------------------------------------
//Block 139, MSLICE 0

  assign sig_139_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_32 & ~net_40) | (net_32 & net_40))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_32 & net_40) | (net_32 & net_40)));
  assign sig_139_lut_1 = 1'b0;
  assign net_160 = (~net_185 & sig_139_lut_0) | (net_185 & sig_139_lut_1);

//---------------------------------------------------------------------------
//Block 140, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_90 == 1'b1)   //reset
    begin
      net_151 <= 1'b0;
      net_150 <= 1'b0;
    end
    else
    begin
      net_151 <= net_159;
      net_150 <= net_154;
    end
  end

//---------------------------------------------------------------------------
//Block 141, LSLICE 3

  always @(posedge gclk_5)
  begin
    if(net_90 == 1'b1)   //reset
    begin
      net_149 <= 1'b0;
      net_155 <= 1'b0;
    end
    else
    begin
      net_149 <= net_158;
      net_155 <= net_156;
    end
  end

//---------------------------------------------------------------------------
//Block 143, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_90 == 1'b1)   //reset
    begin
      net_163 <= 1'b0;
      net_165 <= 1'b0;
    end
    else
    begin
      net_163 <= net_173;
      net_165 <= net_168;
    end
  end

//---------------------------------------------------------------------------
//Block 144, LSLICE 3

  always @(posedge gclk_5)
  begin
    if(net_90 == 1'b1)   //reset
    begin
      net_162 <= 1'b0;
      net_166 <= 1'b0;
    end
    else
    begin
      net_162 <= net_172;
      net_166 <= net_167;
    end
  end

//---------------------------------------------------------------------------
//Block 145, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_90 == 1'b1)   //reset
    begin
      net_174 <= 1'b0;
      net_175 <= 1'b0;
    end
    else
    begin
      net_174 <= net_177;
      net_175 <= net_152;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 140, 141, 143, 144, 145

  assign { net_177, net_169, net_171, net_167, net_172, net_173, net_164, net_170, net_168, net_153, net_157, net_156, net_158, net_152, net_154, net_159 } = { net_174, net_87, net_88, net_166, net_162, net_163, net_178, net_233, net_165, net_176, net_239, net_155, net_149, net_175, net_150, net_151 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 142, MSLICE 1

  assign sig_142_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_30 & ~net_41) | (net_30 & net_41))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_30 & net_41) | (net_30 & net_41)));
  assign sig_142_lut_1 = 1'b0;
  assign net_161 = (~net_192 & sig_142_lut_0) | (net_192 & sig_142_lut_1);

//---------------------------------------------------------------------------
//Block 146, MSLICE 1

  assign sig_146_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_35 & ~net_42) | (net_35 & net_42))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_35 & net_42) | (net_35 & net_42)));
  assign sig_146_lut_1 = 1'b0;
  assign net_179 = (~net_259 & sig_146_lut_0) | (net_259 & sig_146_lut_1);

//---------------------------------------------------------------------------
//Block 147, MSLICE 0

  always @(posedge gclk_5)
  begin
    if(net_90 == 1'b1)   //reset
    begin
      net_178 <= 1'b0;
      net_176 <= 1'b0;
    end
    else
    begin
      net_178 <= net_164;
      net_176 <= net_153;
    end
  end

//---------------------------------------------------------------------------
//Block 148, LSLICE 2

  assign net_184 = ((i_mcu_dcs & i_mcu_rws));
  assign net_182 = ~net_248;

  always @(posedge gclk_9)
  begin
    if(net_184 == 1'b1)   //enable
     begin
      net_180 <= io_mcu_d[0];
      net_181 <= io_mcu_d[1];
    end
  end

//---------------------------------------------------------------------------
//Block 149, MSLICE 1

  assign net_183 = (~net_1044 & ~net_189 & ((net_739 & ~net_730) | (net_739 & net_730))) | (net_1044 & ~net_189 & ((~net_739 & net_730) | (net_739 & net_730)));
  assign net_185 = (~net_1044 & ~net_189 & ((~net_50 & ~net_59) | (~net_50 & net_59))) | (net_1044 & ~net_189 & ((~net_50 & ~net_59) | (net_50 & ~net_59)));

//---------------------------------------------------------------------------
//Block 150, LSLICE 3

  assign net_186 = (~net_740 & net_1044 & ((~net_189 & net_734))) | (net_740 & ~net_1044 & ((~net_189 & ~net_734) | (~net_189 & net_734))) | (net_740 & net_1044 & ((~net_189 & net_734)));
  assign net_187 = (~net_53 & ~net_64 & ((~net_1044 & ~net_189) | (net_1044 & ~net_189))) | (~net_53 & net_64 & ((~net_1044 & ~net_189))) | (net_53 & ~net_64 & ((net_1044 & ~net_189)));

//---------------------------------------------------------------------------
//Block 151, MSLICE 0

  assign net_192 = (~net_189 & ~net_1044 & ((~net_47 & ~net_56) | (~net_47 & net_56))) | (~net_189 & net_1044 & ((~net_47 & ~net_56) | (net_47 & ~net_56)));
  assign net_193 = (~net_527 & ((net_1288 & ~net_1197) | (net_1288 & net_1197))) | (net_527 & ((~net_1288 & net_1197) | (net_1288 & net_1197)));

  always @(posedge gclk_3)
  begin
    net_189 <= net_193;
  end

//---------------------------------------------------------------------------
//Block 152, LSLICE 2

  assign sig_152_lut_0 = (~i_mcu_rws & ~i_mcu_dcs & ~net_190 & ((~net_531 & ~net_191) | (net_531 & ~net_191))) | (~i_mcu_rws & ~i_mcu_dcs & net_190 & ((~net_531 & ~net_191) | (net_531 & ~net_191))) | (~i_mcu_rws & i_mcu_dcs & ~net_190 & ((net_531 & ~net_191) | (net_531 & net_191))) | (~i_mcu_rws & i_mcu_dcs & net_190 & ((net_531 & ~net_191) | (net_531 & net_191))) | (i_mcu_rws & ~i_mcu_dcs & net_190) | (i_mcu_rws & i_mcu_dcs & net_190);
  assign net_191 = (~net_190 & ((~net_310 & net_468) | (net_310 & net_468))) | (net_190 & ((net_310 & net_468)));

  always @(posedge gclk_9)
  begin
    net_190 <= sig_152_lut_0;
  end

//---------------------------------------------------------------------------
//Block 153, MSLICE 1

  assign sig_153_lut_0 = (~i_mcu_dcs & ~net_339) | (i_mcu_dcs & ~net_339 & ((net_314 & ~net_188) | (net_314 & net_188))) | (i_mcu_dcs & net_339 & ((net_314 & ~net_188) | (net_314 & net_188)));
  assign sig_153_lut_1 = (net_188 & ~i_mcu_dcs) | (net_188 & i_mcu_dcs);
  assign sig_153_ff0_d = (~i_mcu_rws & sig_153_lut_0) | (i_mcu_rws & sig_153_lut_1);

  always @(posedge gclk_9)
  begin
    net_188 <= sig_153_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 154, MSLICE 0

  assign sig_154_lut_0 = (net_264 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[6]) | (net_793 & io_mcu_d[6])));
  assign sig_154_lut_1 = (~net_793 & ~i_mcu_dcs & (~(net_264 & ~io_mcu_d[6]))) | (net_793 & ~i_mcu_dcs) | (net_793 & i_mcu_dcs);
  assign sig_154_ff0_d = (~net_196 & sig_154_lut_0) | (net_196 & sig_154_lut_1);

  always @(posedge gclk_9)
  begin
    net_196 <= sig_154_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 155, LSLICE 2

  assign sig_155_lut_0 = (~io_mcu_d[4] & ~net_264 & ~i_mcu_dcs & ((~net_793 & net_195) | (net_793 & net_195))) | (~io_mcu_d[4] & ~net_264 & i_mcu_dcs & ((net_793 & net_195))) | (~io_mcu_d[4] & net_264 & ~i_mcu_dcs & ((net_793 & net_195))) | (~io_mcu_d[4] & net_264 & i_mcu_dcs & ((net_793 & net_195))) | (io_mcu_d[4] & ~net_264 & ~i_mcu_dcs & ((~net_793 & net_195) | (net_793 & net_195))) | (io_mcu_d[4] & ~net_264 & i_mcu_dcs & ((net_793 & net_195))) | (io_mcu_d[4] & net_264 & ~i_mcu_dcs) | (io_mcu_d[4] & net_264 & i_mcu_dcs & ((net_793 & net_195)));
  assign net_197 = (~net_962 & ~net_195 & (~(net_952 & net_97))) | (~net_962 & net_195 & (~(net_952 & net_97))) | (net_962 & ~net_195 & (~(net_952 & net_97)));

  always @(posedge gclk_9)
  begin
    net_195 <= sig_155_lut_0;
  end

//---------------------------------------------------------------------------
//Block 156, MSLICE 1

  assign sig_156_lut_0 = (~net_569 & ~net_247 & ((~net_350 & net_194) | (net_350 & net_194))) | (~net_569 & net_247) | (net_569 & ~net_247 & ((~net_350 & net_194) | (net_350 & net_194))) | (net_569 & net_247 & ((~net_350 & net_194) | (net_350 & net_194)));
  assign sig_156_lut_1 = (~net_194 & ~net_350 & ((~net_569 & net_247))) | (~net_194 & net_350 & ((~net_569 & ~net_247) | (~net_569 & net_247))) | (net_194 & ~net_350 & ((~net_569 & net_247))) | (net_194 & net_350 & ((~net_569 & ~net_247) | (~net_569 & net_247)));
  assign sig_156_ff0_d = (~net_578 & sig_156_lut_0) | (net_578 & sig_156_lut_1);

  always @(posedge gclk_8)
  begin
    if(net_248 == 1'b0)   //enable
     begin
      net_194 <= sig_156_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 157, LSLICE 3

  assign sig_157_lut_0 = (~io_mcu_d[0] & ~net_264 & ~i_mcu_dcs & ((~net_793 & net_198) | (net_793 & net_198))) | (~io_mcu_d[0] & ~net_264 & i_mcu_dcs & ((net_793 & net_198))) | (~io_mcu_d[0] & net_264 & ~i_mcu_dcs & ((net_793 & net_198))) | (~io_mcu_d[0] & net_264 & i_mcu_dcs & ((net_793 & net_198))) | (io_mcu_d[0] & ~net_264 & ~i_mcu_dcs & ((~net_793 & net_198) | (net_793 & net_198))) | (io_mcu_d[0] & ~net_264 & i_mcu_dcs & ((net_793 & net_198))) | (io_mcu_d[0] & net_264 & ~i_mcu_dcs) | (io_mcu_d[0] & net_264 & i_mcu_dcs & ((net_793 & net_198)));
  assign net_199 = (~net_843 & ~net_198 & (~(net_98 & net_585))) | (~net_843 & net_198 & (~(net_98 & net_585))) | (net_843 & ~net_198 & (~(net_98 & net_585)));

  always @(posedge gclk_9)
  begin
    net_198 <= sig_157_lut_0;
  end

//---------------------------------------------------------------------------
//Block 158, MSLICE 0

  assign sig_158_lut_0 = (net_264 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[7]) | (net_793 & io_mcu_d[7])));
  assign sig_158_lut_1 = (~io_mcu_d[7] & ~i_mcu_dcs & (~(net_264 & ~net_793))) | (~io_mcu_d[7] & i_mcu_dcs & ((~net_264 & net_793) | (net_264 & net_793))) | (io_mcu_d[7] & ~i_mcu_dcs) | (io_mcu_d[7] & i_mcu_dcs & ((~net_264 & net_793) | (net_264 & net_793)));
  assign sig_158_ff0_d = (~net_205 & sig_158_lut_0) | (net_205 & sig_158_lut_1);

  always @(posedge gclk_9)
  begin
    net_205 <= sig_158_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 159, LSLICE 2

  assign sig_159_lut_0 = (~net_100 & ~i_mcu_dcs & ~io_mcu_d[2] & ((~net_793 & net_200) | (net_793 & net_200))) | (~net_100 & ~i_mcu_dcs & io_mcu_d[2] & ((~net_793 & net_200) | (net_793 & net_200))) | (~net_100 & i_mcu_dcs & ~io_mcu_d[2] & (~(net_793 & ~net_200))) | (~net_100 & i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_200))) | (net_100 & ~i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_200))) | (net_100 & i_mcu_dcs & ~io_mcu_d[2] & (~(net_793 & ~net_200))) | (net_100 & i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_200)));
  assign net_203 = (net_943 & ~net_200 & net_99 & ((~net_952 & net_862) | (net_952 & net_862))) | (net_943 & net_200 & ~net_99 & ((net_952 & ~net_862) | (net_952 & net_862))) | (net_943 & net_200 & net_99 & ((net_952 | net_862)));

  always @(posedge gclk_9)
  begin
    net_200 <= sig_159_lut_0;
  end

//---------------------------------------------------------------------------
//Block 160, LSLICE 3

  assign sig_160_lut_0 = (~io_mcu_d[1] & ~net_265 & ~i_mcu_dcs & ((~net_793 & net_201) | (net_793 & net_201))) | (~io_mcu_d[1] & ~net_265 & i_mcu_dcs & ((net_793 & net_201))) | (~io_mcu_d[1] & net_265 & ~i_mcu_dcs & ((net_793 & net_201))) | (~io_mcu_d[1] & net_265 & i_mcu_dcs & ((net_793 & net_201))) | (io_mcu_d[1] & ~net_265 & ~i_mcu_dcs & ((~net_793 & net_201) | (net_793 & net_201))) | (io_mcu_d[1] & ~net_265 & i_mcu_dcs & ((net_793 & net_201))) | (io_mcu_d[1] & net_265 & ~i_mcu_dcs) | (io_mcu_d[1] & net_265 & i_mcu_dcs & ((net_793 & net_201)));
  assign net_204 = (~net_103 & ~net_201 & ~net_840) | (~net_103 & ~net_201 & net_840) | (~net_103 & net_201 & ~net_840 & (~(net_862 & net_951))) | (~net_103 & net_201 & net_840 & (~(net_862 & net_951))) | (net_103 & ~net_201 & ~net_840) | (net_103 & net_201 & ~net_840 & (~(net_862 & net_951)));

  always @(posedge gclk_9)
  begin
    net_201 <= sig_160_lut_0;
  end

//---------------------------------------------------------------------------
//Block 161, MSLICE 1

  assign sig_161_lut_0 = (net_816 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[6]) | (net_793 & io_mcu_d[6])));
  assign sig_161_lut_1 = (~net_816 & ~i_mcu_dcs) | (~net_816 & i_mcu_dcs & ((net_793 & ~io_mcu_d[6]) | (net_793 & io_mcu_d[6]))) | (net_816 & ~i_mcu_dcs & ((net_793 | io_mcu_d[6]))) | (net_816 & i_mcu_dcs & ((net_793 & ~io_mcu_d[6]) | (net_793 & io_mcu_d[6])));
  assign sig_161_ff0_d = (~net_202 & sig_161_lut_0) | (net_202 & sig_161_lut_1);

  always @(posedge gclk_9)
  begin
    net_202 <= sig_161_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 162, MSLICE 0

  assign sig_162_lut_0 = (net_816 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[7]) | (net_793 & io_mcu_d[7])));
  assign sig_162_lut_1 = (~io_mcu_d[7] & ~i_mcu_dcs & (~(~net_793 & net_816))) | (~io_mcu_d[7] & i_mcu_dcs & ((net_793 & ~net_816) | (net_793 & net_816))) | (io_mcu_d[7] & ~i_mcu_dcs) | (io_mcu_d[7] & i_mcu_dcs & ((net_793 & ~net_816) | (net_793 & net_816)));
  assign sig_162_ff0_d = (~net_207 & sig_162_lut_0) | (net_207 & sig_162_lut_1);

  always @(posedge gclk_9)
  begin
    net_207 <= sig_162_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 163, LSLICE 2

  assign sig_163_lut_0 = (~io_mcu_d[1] & ~net_816 & ~i_mcu_dcs & ((~net_793 & net_206) | (net_793 & net_206))) | (~io_mcu_d[1] & ~net_816 & i_mcu_dcs & ((net_793 & net_206))) | (~io_mcu_d[1] & net_816 & ~i_mcu_dcs & ((net_793 & net_206))) | (~io_mcu_d[1] & net_816 & i_mcu_dcs & ((net_793 & net_206))) | (io_mcu_d[1] & ~net_816 & ~i_mcu_dcs & ((~net_793 & net_206) | (net_793 & net_206))) | (io_mcu_d[1] & ~net_816 & i_mcu_dcs & ((net_793 & net_206))) | (io_mcu_d[1] & net_816 & ~i_mcu_dcs) | (io_mcu_d[1] & net_816 & i_mcu_dcs & ((net_793 & net_206)));
  assign net_209 = (~net_950 & ~net_206 & (~(net_102 & net_843))) | (~net_950 & net_206 & (~(net_102 & net_843))) | (net_950 & ~net_206 & (~(net_102 & net_843)));

  always @(posedge gclk_9)
  begin
    net_206 <= sig_163_lut_0;
  end

//---------------------------------------------------------------------------
//Block 164, MSLICE 1

  assign sig_164_lut_0 = (net_286 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[5]) | (net_793 & io_mcu_d[5])));
  assign sig_164_lut_1 = (~net_286 & ~i_mcu_dcs) | (~net_286 & i_mcu_dcs & ((net_793 & ~io_mcu_d[5]) | (net_793 & io_mcu_d[5]))) | (net_286 & ~i_mcu_dcs & ((net_793 | io_mcu_d[5]))) | (net_286 & i_mcu_dcs & ((net_793 & ~io_mcu_d[5]) | (net_793 & io_mcu_d[5])));
  assign sig_164_ff0_d = (~net_208 & sig_164_lut_0) | (net_208 & sig_164_lut_1);

  always @(posedge gclk_9)
  begin
    net_208 <= sig_164_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 165, LSLICE 3

  assign sig_165_lut_0 = (~io_mcu_d[2] & ~net_286 & ~i_mcu_dcs & ((~net_793 & net_210) | (net_793 & net_210))) | (~io_mcu_d[2] & ~net_286 & i_mcu_dcs & ((net_793 & net_210))) | (~io_mcu_d[2] & net_286 & ~i_mcu_dcs & ((net_793 & net_210))) | (~io_mcu_d[2] & net_286 & i_mcu_dcs & ((net_793 & net_210))) | (io_mcu_d[2] & ~net_286 & ~i_mcu_dcs & ((~net_793 & net_210) | (net_793 & net_210))) | (io_mcu_d[2] & ~net_286 & i_mcu_dcs & ((net_793 & net_210))) | (io_mcu_d[2] & net_286 & ~i_mcu_dcs) | (io_mcu_d[2] & net_286 & i_mcu_dcs & ((net_793 & net_210)));
  assign net_211 = (~net_863 & ~net_210 & (~(net_843 & net_208))) | (~net_863 & net_210 & (~(net_843 & net_208))) | (net_863 & ~net_210 & (~(net_843 & net_208)));

  always @(posedge gclk_9)
  begin
    net_210 <= sig_165_lut_0;
  end

//---------------------------------------------------------------------------
//Block 166, LSLICE 3

  assign sig_166_lut_0 = (~net_286 & ~i_mcu_dcs & ~io_mcu_d[1] & ((~net_793 & net_212) | (net_793 & net_212))) | (~net_286 & ~i_mcu_dcs & io_mcu_d[1] & ((~net_793 & net_212) | (net_793 & net_212))) | (~net_286 & i_mcu_dcs & ~io_mcu_d[1] & (~(net_793 & ~net_212))) | (~net_286 & i_mcu_dcs & io_mcu_d[1] & (~(net_793 & ~net_212))) | (net_286 & ~i_mcu_dcs & io_mcu_d[1] & (~(net_793 & ~net_212))) | (net_286 & i_mcu_dcs & ~io_mcu_d[1] & (~(net_793 & ~net_212))) | (net_286 & i_mcu_dcs & io_mcu_d[1] & (~(net_793 & ~net_212)));
  assign net_213 = (~net_214 & ~net_212) | (~net_214 & net_212 & ((~net_668 & ~net_564) | (~net_668 & net_564))) | (net_214 & ~net_212 & ((~net_668 & ~net_564) | (net_668 & ~net_564))) | (net_214 & net_212 & ((~net_668 & ~net_564)));

  always @(posedge gclk_9)
  begin
    net_212 <= sig_166_lut_0;
  end

//---------------------------------------------------------------------------
//Block 167, LSLICE 2

  assign sig_167_lut_0 = (~net_100 & ~i_mcu_dcs & ~io_mcu_d[3] & ((~net_793 & net_214) | (net_793 & net_214))) | (~net_100 & ~i_mcu_dcs & io_mcu_d[3] & ((~net_793 & net_214) | (net_793 & net_214))) | (~net_100 & i_mcu_dcs & ~io_mcu_d[3] & (~(net_793 & ~net_214))) | (~net_100 & i_mcu_dcs & io_mcu_d[3] & (~(net_793 & ~net_214))) | (net_100 & ~i_mcu_dcs & io_mcu_d[3] & (~(net_793 & ~net_214))) | (net_100 & i_mcu_dcs & ~io_mcu_d[3] & (~(net_793 & ~net_214))) | (net_100 & i_mcu_dcs & io_mcu_d[3] & (~(net_793 & ~net_214)));
  assign sig_167_lut_1 = (~net_100 & ~i_mcu_dcs & ~io_mcu_d[4] & ((~net_793 & net_215) | (net_793 & net_215))) | (~net_100 & ~i_mcu_dcs & io_mcu_d[4] & ((~net_793 & net_215) | (net_793 & net_215))) | (~net_100 & i_mcu_dcs & ~io_mcu_d[4] & (~(net_793 & ~net_215))) | (~net_100 & i_mcu_dcs & io_mcu_d[4] & (~(net_793 & ~net_215))) | (net_100 & ~i_mcu_dcs & io_mcu_d[4] & (~(net_793 & ~net_215))) | (net_100 & i_mcu_dcs & ~io_mcu_d[4] & (~(net_793 & ~net_215))) | (net_100 & i_mcu_dcs & io_mcu_d[4] & (~(net_793 & ~net_215)));

  always @(posedge gclk_9)
  begin
    net_214 <= sig_167_lut_0;
    net_215 <= sig_167_lut_1;
  end

//---------------------------------------------------------------------------
//Block 172, MSLICE 0

  assign sig_172_lut_0 = (~net_512 & ~net_234 & ((~net_127 & net_217) | (net_127 & net_217))) | (net_512 & ~net_234 & ((net_127 | net_217))) | (net_512 & net_234 & ((net_127 & ~net_217) | (net_127 & net_217)));
  assign sig_172_lut_1 = (~net_512 & ~net_234 & ((~net_113 & net_216) | (net_113 & net_216))) | (net_512 & ~net_234 & ((net_113 | net_216))) | (net_512 & net_234 & ((net_113 & ~net_216) | (net_113 & net_216)));

  always @(posedge gclk_9)
  begin
    net_217 <= sig_172_lut_0;
    net_216 <= sig_172_lut_1;
  end

//---------------------------------------------------------------------------
//Block 173, MSLICE 0

  assign net_219 = (~net_1044 & ~net_189 & ((~net_692 & ~net_700) | (~net_692 & net_700))) | (net_1044 & ~net_189 & ((~net_692 & ~net_700) | (net_692 & ~net_700)));
  assign net_218 = (~net_189 & ~net_1044 & ((~net_55 & ~net_63) | (~net_55 & net_63))) | (~net_189 & net_1044 & ((~net_55 & ~net_63) | (net_55 & ~net_63)));

//---------------------------------------------------------------------------
//Block 174, LSLICE 2

  assign net_224 = ((net_452 & net_309));
  assign net_222 = ((net_315 & net_452));

  always @(posedge gclk_9)
  begin
    if(net_221 == 1'b1)   //enable
     begin
      net_226 <= io_mcu_d[7];
      net_227 <= io_mcu_d[5];
    end
  end

//---------------------------------------------------------------------------
//Block 175, MSLICE 1

  assign net_220 = (net_181 & net_180 & ((net_316 & net_308)));
  assign net_221 = (net_1141 & ((net_452 & net_220)));

  always @(posedge gclk_9)
  begin
    if(net_221 == 1'b1)   //enable
     begin
      net_223 <= io_mcu_d[3];
      net_225 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 176, MSLICE 0

  assign net_235 = (net_1141 & ((net_452 & net_517)));
  assign net_238 = (~net_228 & ~net_151 & (~(~net_150 & net_229))) | (~net_228 & net_151 & (~(~net_150 & net_229))) | (net_228 & ~net_151 & ((net_150 & ~net_229))) | (net_228 & net_151 & (~(~net_150 & net_229)));

  always @(posedge gclk_9)
  begin
    if(net_235 == 1'b1)   //enable
     begin
      net_228 <= io_mcu_d[0];
      net_229 <= io_mcu_d[1];
    end
  end

//---------------------------------------------------------------------------
//Block 177, LSLICE 2

  assign net_234 = (~net_316 & i_mcu_dcs & ((i_mcu_rws & ~net_249) | (i_mcu_rws & net_249))) | (net_316 & ~i_mcu_dcs & ((i_mcu_rws & net_249))) | (net_316 & i_mcu_dcs & ((i_mcu_rws & ~net_249) | (i_mcu_rws & net_249)));
  assign net_236 = ((i_mcu_rws & net_316));

//---------------------------------------------------------------------------
//Block 178, LSLICE 3

  assign net_232 = (~net_144 & ~net_231 & ~net_233 & ((~net_178 & ~net_230) | (~net_178 & net_230))) | (~net_144 & ~net_231 & net_233 & ((~net_178 & net_230))) | (~net_144 & net_231 & ~net_233) | (~net_144 & net_231 & net_233 & ((~net_178 & net_230) | (net_178 & net_230))) | (net_144 & ~net_231 & ~net_233 & ((~net_178 & net_230))) | (net_144 & net_231 & ~net_233 & ((~net_178 & net_230) | (net_178 & net_230)));
  assign net_237 = (~net_178 & ~net_163 & ~net_231 & ((~net_302 & ~net_232))) | (~net_178 & net_163 & ~net_231 & ((~net_302 & ~net_232) | (net_302 & ~net_232))) | (net_178 & ~net_163 & ~net_231 & ((~net_302 & ~net_232))) | (net_178 & ~net_163 & net_231 & ((~net_302 & ~net_232))) | (net_178 & net_163 & ~net_231 & ((~net_302 & ~net_232) | (net_302 & ~net_232))) | (net_178 & net_163 & net_231 & ((~net_302 & ~net_232) | (net_302 & ~net_232)));

  always @(posedge gclk_9)
  begin
    if(net_304 == 1'b1)   //enable
     begin
      net_230 <= io_mcu_d[0];
      net_231 <= io_mcu_d[1];
    end
  end

//---------------------------------------------------------------------------
//Block 179, MSLICE 1

  always @(posedge gclk_5)
  begin
    if(net_90 == 1'b1)   //reset
    begin
      net_233 <= 1'b0;
    end
    else
    begin
      net_233 <= net_170;
    end
  end

//---------------------------------------------------------------------------
//Block 180, MSLICE 0

  assign net_240 = (net_176 & net_163 & ((net_155 | net_239)));
  assign net_241 = (~net_324 & ~net_1283 & ((net_1349 & net_1141))) | (~net_324 & net_1283 & ((net_1349 & ~net_1141) | (net_1349 & net_1141))) | (net_324 & ~net_1283 & ((net_1349 & ~net_1141) | (net_1349 & net_1141))) | (net_324 & net_1283 & ((net_1349 & ~net_1141) | (net_1349 & net_1141)));

  always @(posedge gclk_5)
  begin
    if(net_90 == 1'b1)   //reset
    begin
      net_239 <= 1'b0;
    end
    else
    begin
      net_239 <= net_157;
    end
  end

//---------------------------------------------------------------------------
//Block 181, LSLICE 2

  assign net_246 = (~net_307 & ~net_174 & ~net_303 & ((net_87 & ~net_242))) | (~net_307 & net_174 & ~net_303) | (~net_307 & net_174 & net_303 & ((net_87 & ~net_242))) | (net_307 & ~net_174 & ~net_303) | (net_307 & net_174 & ~net_303) | (net_307 & net_174 & net_303);
  assign net_245 = (~net_87 & ~net_242 & (~(~net_88 & net_243))) | (net_87 & ~net_242 & (~(~net_88 & net_243))) | (net_87 & net_242 & (~(~net_88 & net_243)));

  always @(posedge gclk_9)
  begin
    if(net_304 == 1'b1)   //enable
     begin
      net_242 <= io_mcu_d[6];
      net_243 <= io_mcu_d[5];
    end
  end

//---------------------------------------------------------------------------
//Block 182, MSLICE 1

  assign sig_182_lut_0 = 1'b0;
  assign sig_182_lut_1 = (~net_180 & ~net_181 & ((~net_252 & net_85) | (net_252 & net_85))) | (net_180 & ~net_181 & ((~net_252 & ~net_85) | (~net_252 & net_85)));
  assign net_244 = (~net_896 & sig_182_lut_0) | (net_896 & sig_182_lut_1);

//---------------------------------------------------------------------------
//Block 183, MSLICE 0

  assign sig_183_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((~net_716 & ~net_723) | (~net_716 & net_723))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_716 & ~net_723) | (net_716 & ~net_723)));
  assign sig_183_lut_1 = 1'b0;
  assign net_250 = (~net_186 & sig_183_lut_0) | (net_186 & sig_183_lut_1);

//---------------------------------------------------------------------------
//Block 184, LSLICE 2

  assign sig_184_lut_0 = (~net_180 & ~net_647 & ~net_308 & ((~net_181 & net_247) | (net_181 & net_247))) | (~net_180 & ~net_647 & net_308 & ((~net_181 & net_247) | (net_181 & net_247))) | (~net_180 & net_647 & ~net_308 & ((~net_181 & net_247) | (net_181 & net_247))) | (~net_180 & net_647 & net_308 & ((net_181 & net_247))) | (net_180 & ~net_647 & ~net_308 & ((~net_181 & net_247) | (net_181 & net_247))) | (net_180 & ~net_647 & net_308 & ((~net_181 & net_247) | (net_181 & net_247))) | (net_180 & net_647 & ~net_308 & ((~net_181 & net_247) | (net_181 & net_247))) | (net_180 & net_647 & net_308 & (~(net_181 & ~net_247)));
  assign sig_184_lut_1 = (~net_181 & ~net_308 & ~net_647 & ((~net_180 & net_248) | (net_180 & net_248))) | (~net_181 & ~net_308 & net_647 & ((~net_180 & net_248) | (net_180 & net_248))) | (~net_181 & net_308 & ~net_647 & ((~net_180 & net_248) | (net_180 & net_248))) | (~net_181 & net_308 & net_647) | (net_181 & ~net_308 & ~net_647 & ((~net_180 & net_248) | (net_180 & net_248))) | (net_181 & ~net_308 & net_647 & ((~net_180 & net_248) | (net_180 & net_248))) | (net_181 & net_308 & ~net_647 & ((~net_180 & net_248) | (net_180 & net_248))) | (net_181 & net_308 & net_647 & ((net_180 & net_248)));

  always @(posedge gclk_9)
  begin
    if(net_184 == 1'b1)   //enable
     begin
      net_247 <= sig_184_lut_0;
      net_248 <= sig_184_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 185, LSLICE 3

  assign net_251 = (net_895 & net_180 & ((net_181 & net_308)));
  assign net_249 = (net_308 & ((net_181 & ~net_180)));

  always @(posedge gclk_9)
  begin
    if(net_251 == 1'b1)   //enable
     begin
      net_253 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 186, MSLICE 1

  assign sig_186_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((~net_715 & ~net_721) | (~net_715 & net_721))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_715 & ~net_721) | (net_715 & ~net_721)));
  assign sig_186_lut_1 = 1'b0;
  assign net_252 = (~net_258 & sig_186_lut_0) | (net_258 & sig_186_lut_1);

//---------------------------------------------------------------------------
//Block 187, MSLICE 0

  assign sig_187_lut_0 = (net_1114 & ~net_338 & ((~net_260 & ~net_321)));
  assign sig_187_lut_1 = 1'b0;
  assign net_254 = (~net_244 & sig_187_lut_0) | (net_244 & sig_187_lut_1);

//---------------------------------------------------------------------------
//Block 188, LSLICE 2

  assign sig_188_lut_0 = (~i_mcu_rws & ~i_mcu_dcs & ~net_256 & ((~net_530 & ~net_257) | (net_530 & ~net_257))) | (~i_mcu_rws & ~i_mcu_dcs & net_256 & ((~net_530 & ~net_257) | (net_530 & ~net_257))) | (~i_mcu_rws & i_mcu_dcs & ~net_256 & ((net_530 & ~net_257) | (net_530 & net_257))) | (~i_mcu_rws & i_mcu_dcs & net_256 & ((net_530 & ~net_257) | (net_530 & net_257))) | (i_mcu_rws & ~i_mcu_dcs & net_256) | (i_mcu_rws & i_mcu_dcs & net_256);
  assign net_257 = (net_466 & ~net_256 & ((net_814 & ~net_1341) | (net_814 & net_1341))) | (net_466 & net_256 & ((net_814 & ~net_1341)));

  always @(posedge gclk_9)
  begin
    net_256 <= sig_188_lut_0;
  end

//---------------------------------------------------------------------------
//Block 189, LSLICE 3

  assign net_261 = (~net_247 & ((net_847 & net_564)));
  assign net_260 = ((net_255 & net_648));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_255 <= 1'b0;
    end
    else
    begin
      if(net_261 == 1'b1)   //enable
       begin
        net_255 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 190, MSLICE 1

  assign net_258 = (~net_1044 & ~net_189 & ((net_743 & ~net_733) | (net_743 & net_733))) | (net_1044 & ~net_189 & ((~net_743 & net_733) | (net_743 & net_733)));
  assign net_259 = (~net_1044 & ~net_189 & ((~net_51 & ~net_61) | (~net_51 & net_61))) | (net_1044 & ~net_189 & ((~net_51 & ~net_61) | (net_51 & ~net_61)));

//---------------------------------------------------------------------------
//Block 191, LSLICE 2

  assign net_264 = ((i_mcu_rws & net_998));
  assign net_265 = ((net_547 & i_mcu_rws));

//---------------------------------------------------------------------------
//Block 192, LSLICE 3

  assign sig_192_lut_0 = (~io_mcu_d[5] & ~i_mcu_dcs & ~net_264 & ((~net_793 & net_263) | (net_793 & net_263))) | (~io_mcu_d[5] & ~i_mcu_dcs & net_264 & ((net_793 & net_263))) | (~io_mcu_d[5] & i_mcu_dcs & ~net_264 & ((net_793 & net_263))) | (~io_mcu_d[5] & i_mcu_dcs & net_264 & ((net_793 & net_263))) | (io_mcu_d[5] & ~i_mcu_dcs & ~net_264 & ((~net_793 & net_263) | (net_793 & net_263))) | (io_mcu_d[5] & ~i_mcu_dcs & net_264) | (io_mcu_d[5] & i_mcu_dcs & ~net_264 & ((net_793 & net_263))) | (io_mcu_d[5] & i_mcu_dcs & net_264 & ((net_793 & net_263)));
  assign net_266 = (net_197 & ~net_263 & ~net_196) | (net_197 & ~net_263 & net_196 & (~(~net_1301 & net_959))) | (net_197 & net_263 & ~net_196 & (~(net_1301 & net_959))) | (net_197 & net_263 & net_196 & ((~net_1301 & ~net_959) | (net_1301 & ~net_959)));

  always @(posedge gclk_9)
  begin
    net_263 <= sig_192_lut_0;
  end

//---------------------------------------------------------------------------
//Block 193, MSLICE 1

  assign sig_193_lut_0 = (~i_mcu_dcs & ~net_559) | (i_mcu_dcs & ~net_559 & ((net_643 & ~net_262) | (net_643 & net_262))) | (i_mcu_dcs & net_559 & ((net_643 & ~net_262) | (net_643 & net_262)));
  assign sig_193_lut_1 = (net_262 & ~i_mcu_dcs) | (net_262 & i_mcu_dcs);
  assign sig_193_ff0_d = (~i_mcu_rws & sig_193_lut_0) | (i_mcu_rws & sig_193_lut_1);

  always @(posedge gclk_9)
  begin
    net_262 <= sig_193_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 194, LSLICE 2

  assign sig_194_lut_0 = (~io_mcu_d[1] & ~net_264 & ~i_mcu_dcs & ((~net_793 & net_267) | (net_793 & net_267))) | (~io_mcu_d[1] & ~net_264 & i_mcu_dcs & ((net_793 & net_267))) | (~io_mcu_d[1] & net_264 & ~i_mcu_dcs & ((net_793 & net_267))) | (~io_mcu_d[1] & net_264 & i_mcu_dcs & ((net_793 & net_267))) | (io_mcu_d[1] & ~net_264 & ~i_mcu_dcs & ((~net_793 & net_267) | (net_793 & net_267))) | (io_mcu_d[1] & ~net_264 & i_mcu_dcs & ((net_793 & net_267))) | (io_mcu_d[1] & net_264 & ~i_mcu_dcs) | (io_mcu_d[1] & net_264 & i_mcu_dcs & ((net_793 & net_267)));
  assign net_269 = (net_1523 & ~net_267 & ((~net_592 & ~net_199) | (net_592 & ~net_199))) | (net_1523 & net_267 & (~(~net_592 & net_199)));

  always @(posedge gclk_9)
  begin
    net_267 <= sig_194_lut_0;
  end

//---------------------------------------------------------------------------
//Block 195, LSLICE 3

  assign sig_195_lut_0 = (~net_100 & ~i_mcu_dcs & ~io_mcu_d[6] & ((~net_793 & net_268) | (net_793 & net_268))) | (~net_100 & ~i_mcu_dcs & io_mcu_d[6] & ((~net_793 & net_268) | (net_793 & net_268))) | (~net_100 & i_mcu_dcs & ~io_mcu_d[6] & (~(net_793 & ~net_268))) | (~net_100 & i_mcu_dcs & io_mcu_d[6] & (~(net_793 & ~net_268))) | (net_100 & ~i_mcu_dcs & io_mcu_d[6] & (~(net_793 & ~net_268))) | (net_100 & i_mcu_dcs & ~io_mcu_d[6] & (~(net_793 & ~net_268))) | (net_100 & i_mcu_dcs & io_mcu_d[6] & (~(net_793 & ~net_268)));
  assign net_270 = (net_950 & ~net_268 & net_1155 & ((net_277 & ~net_943) | (net_277 & net_943))) | (net_950 & net_268 & ~net_1155 & ((~net_277 & net_943) | (net_277 & net_943))) | (net_950 & net_268 & net_1155 & ((net_277 | net_943)));

  always @(posedge gclk_9)
  begin
    net_268 <= sig_195_lut_0;
  end

//---------------------------------------------------------------------------
//Block 196, MSLICE 0

  assign sig_196_lut_0 = 1'b0;
  assign sig_196_lut_1 = (net_204 & ~net_345 & (~(net_205 & net_968)));
  assign net_276 = (~net_498 & sig_196_lut_0) | (net_498 & sig_196_lut_1);

//---------------------------------------------------------------------------
//Block 197, LSLICE 2

  assign net_272 = (~net_203 & ~net_209 & ~net_961) | (~net_203 & net_209 & ~net_961) | (~net_203 & net_209 & net_961 & (~(net_101 & net_585)));
  assign net_274 = (~net_270 & net_272 & ~net_273 & (~(net_862 & ~net_488)));

//---------------------------------------------------------------------------
//Block 198, LSLICE 3

  assign sig_198_lut_0 = (~io_mcu_d[4] & ~net_265 & ~i_mcu_dcs & ((~net_793 & net_271) | (net_793 & net_271))) | (~io_mcu_d[4] & ~net_265 & i_mcu_dcs & ((net_793 & net_271))) | (~io_mcu_d[4] & net_265 & ~i_mcu_dcs & ((net_793 & net_271))) | (~io_mcu_d[4] & net_265 & i_mcu_dcs & ((net_793 & net_271))) | (io_mcu_d[4] & ~net_265 & ~i_mcu_dcs & ((~net_793 & net_271) | (net_793 & net_271))) | (io_mcu_d[4] & ~net_265 & i_mcu_dcs & ((net_793 & net_271))) | (io_mcu_d[4] & net_265 & ~i_mcu_dcs) | (io_mcu_d[4] & net_265 & i_mcu_dcs & ((net_793 & net_271)));
  assign net_273 = (net_592 & ~net_271 & net_961 & ((net_104 & ~net_964) | (net_104 & net_964))) | (net_592 & net_271 & ~net_961 & ((~net_104 & net_964) | (net_104 & net_964))) | (net_592 & net_271 & net_961 & ((net_104 | net_964)));

  always @(posedge gclk_9)
  begin
    net_271 <= sig_198_lut_0;
  end

//---------------------------------------------------------------------------
//Block 199, MSLICE 1

  assign sig_199_lut_0 = (net_265 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[3]) | (net_793 & io_mcu_d[3])));
  assign sig_199_lut_1 = (~net_793 & ~i_mcu_dcs & (~(net_265 & ~io_mcu_d[3]))) | (net_793 & ~i_mcu_dcs) | (net_793 & i_mcu_dcs);
  assign sig_199_ff0_d = (~net_275 & sig_199_lut_0) | (net_275 & sig_199_lut_1);

  always @(posedge gclk_9)
  begin
    net_275 <= sig_199_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 200, MSLICE 0

  assign sig_200_lut_0 = (~i_mcu_dcs & ~io_mcu_d[5] & ((~net_793 & net_277) | (net_793 & net_277))) | (~i_mcu_dcs & io_mcu_d[5] & ((~net_793 & net_277) | (net_793 & net_277))) | (i_mcu_dcs & ~io_mcu_d[5] & (~(net_793 & ~net_277))) | (i_mcu_dcs & io_mcu_d[5] & (~(net_793 & ~net_277)));
  assign sig_200_lut_1 = (~net_277 & ~i_mcu_dcs & ((io_mcu_d[5] & ~net_793))) | (~net_277 & i_mcu_dcs & ((~io_mcu_d[5] & ~net_793) | (io_mcu_d[5] & ~net_793))) | (net_277 & ~i_mcu_dcs & ((io_mcu_d[5] & ~net_793) | (io_mcu_d[5] & net_793))) | (net_277 & i_mcu_dcs);
  assign sig_200_ff0_d = (~net_343 & sig_200_lut_0) | (net_343 & sig_200_lut_1);

  always @(posedge gclk_9)
  begin
    net_277 <= sig_200_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 201, LSLICE 2

  assign sig_201_lut_0 = (~net_343 & ~i_mcu_dcs & ~io_mcu_d[2] & ((~net_793 & net_278) | (net_793 & net_278))) | (~net_343 & ~i_mcu_dcs & io_mcu_d[2] & ((~net_793 & net_278) | (net_793 & net_278))) | (~net_343 & i_mcu_dcs & ~io_mcu_d[2] & (~(net_793 & ~net_278))) | (~net_343 & i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_278))) | (net_343 & ~i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_278))) | (net_343 & i_mcu_dcs & ~io_mcu_d[2] & (~(net_793 & ~net_278))) | (net_343 & i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_278)));
  assign net_281 = (net_962 & ~net_278 & ((~net_1521 & ~net_213) | (net_1521 & ~net_213))) | (net_962 & net_278 & (~(~net_1521 & net_213)));

  always @(posedge gclk_9)
  begin
    net_278 <= sig_201_lut_0;
  end

//---------------------------------------------------------------------------
//Block 202, LSLICE 3

  assign sig_202_lut_0 = (~io_mcu_d[0] & ~net_265 & ~i_mcu_dcs & ((~net_793 & net_279) | (net_793 & net_279))) | (~io_mcu_d[0] & ~net_265 & i_mcu_dcs & ((net_793 & net_279))) | (~io_mcu_d[0] & net_265 & ~i_mcu_dcs & ((net_793 & net_279))) | (~io_mcu_d[0] & net_265 & i_mcu_dcs & ((net_793 & net_279))) | (io_mcu_d[0] & ~net_265 & ~i_mcu_dcs & ((~net_793 & net_279) | (net_793 & net_279))) | (io_mcu_d[0] & ~net_265 & i_mcu_dcs & ((net_793 & net_279))) | (io_mcu_d[0] & net_265 & ~i_mcu_dcs) | (io_mcu_d[0] & net_265 & i_mcu_dcs & ((net_793 & net_279)));
  assign net_282 = (net_863 & ~net_279 & net_564 & ((net_215 & ~net_951) | (net_215 & net_951))) | (net_863 & net_279 & ~net_564 & ((~net_215 & net_951) | (net_215 & net_951))) | (net_863 & net_279 & net_564 & ((net_215 | net_951)));

  always @(posedge gclk_9)
  begin
    net_279 <= sig_202_lut_0;
  end

//---------------------------------------------------------------------------
//Block 203, MSLICE 1

  assign sig_203_lut_0 = (net_344 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[6]) | (net_793 & io_mcu_d[6])));
  assign sig_203_lut_1 = (~net_344 & ~i_mcu_dcs) | (~net_344 & i_mcu_dcs & ((net_793 & ~io_mcu_d[6]) | (net_793 & io_mcu_d[6]))) | (net_344 & ~i_mcu_dcs & ((net_793 | io_mcu_d[6]))) | (net_344 & i_mcu_dcs & ((net_793 & ~io_mcu_d[6]) | (net_793 & io_mcu_d[6])));
  assign sig_203_ff0_d = (~net_280 & sig_203_lut_0) | (net_280 & sig_203_lut_1);

  always @(posedge gclk_9)
  begin
    net_280 <= sig_203_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 204, MSLICE 0

  assign net_286 = ((net_1113 & i_mcu_rws));
  assign net_288 = ~i_mcu_rws;

//---------------------------------------------------------------------------
//Block 205, LSLICE 2

  assign sig_205_lut_0 = (~io_mcu_d[0] & ~i_mcu_dcs & ~net_286 & ((~net_793 & net_284) | (net_793 & net_284))) | (~io_mcu_d[0] & ~i_mcu_dcs & net_286 & ((net_793 & net_284))) | (~io_mcu_d[0] & i_mcu_dcs & ~net_286 & ((net_793 & net_284))) | (~io_mcu_d[0] & i_mcu_dcs & net_286 & ((net_793 & net_284))) | (io_mcu_d[0] & ~i_mcu_dcs & ~net_286 & ((~net_793 & net_284) | (net_793 & net_284))) | (io_mcu_d[0] & ~i_mcu_dcs & net_286) | (io_mcu_d[0] & i_mcu_dcs & ~net_286 & ((net_793 & net_284))) | (io_mcu_d[0] & i_mcu_dcs & net_286 & ((net_793 & net_284)));
  assign net_287 = (net_668 & ~net_284 & net_289 & ((~net_952 & net_862) | (net_952 & net_862))) | (net_668 & net_284 & ~net_289 & ((net_952 & ~net_862) | (net_952 & net_862))) | (net_668 & net_284 & net_289 & ((net_952 | net_862)));

  always @(posedge gclk_9)
  begin
    net_284 <= sig_205_lut_0;
  end

//---------------------------------------------------------------------------
//Block 206, LSLICE 3

  assign sig_206_lut_0 = (~io_mcu_d[7] & ~net_286 & ~i_mcu_dcs & ((~net_793 & net_285) | (net_793 & net_285))) | (~io_mcu_d[7] & ~net_286 & i_mcu_dcs & ((net_793 & net_285))) | (~io_mcu_d[7] & net_286 & ~i_mcu_dcs & ((net_793 & net_285))) | (~io_mcu_d[7] & net_286 & i_mcu_dcs & ((net_793 & net_285))) | (io_mcu_d[7] & ~net_286 & ~i_mcu_dcs & ((~net_793 & net_285) | (net_793 & net_285))) | (io_mcu_d[7] & ~net_286 & i_mcu_dcs & ((net_793 & net_285))) | (io_mcu_d[7] & net_286 & ~i_mcu_dcs) | (io_mcu_d[7] & net_286 & i_mcu_dcs & ((net_793 & net_285)));
  assign sig_206_lut_1 = (~io_mcu_d[4] & ~net_286 & ~i_mcu_dcs & ((~net_793 & net_283) | (net_793 & net_283))) | (~io_mcu_d[4] & ~net_286 & i_mcu_dcs & ((net_793 & net_283))) | (~io_mcu_d[4] & net_286 & ~i_mcu_dcs & ((net_793 & net_283))) | (~io_mcu_d[4] & net_286 & i_mcu_dcs & ((net_793 & net_283))) | (io_mcu_d[4] & ~net_286 & ~i_mcu_dcs & ((~net_793 & net_283) | (net_793 & net_283))) | (io_mcu_d[4] & ~net_286 & i_mcu_dcs & ((net_793 & net_283))) | (io_mcu_d[4] & net_286 & ~i_mcu_dcs) | (io_mcu_d[4] & net_286 & i_mcu_dcs & ((net_793 & net_283)));

  always @(posedge gclk_9)
  begin
    net_285 <= sig_206_lut_0;
    net_283 <= sig_206_lut_1;
  end

//---------------------------------------------------------------------------
//Block 207, MSLICE 1

  assign sig_207_lut_0 = (~net_793 & ~i_mcu_dcs & ((net_286 & io_mcu_d[3]))) | (net_793 & ~i_mcu_dcs & ((net_286 & io_mcu_d[3])));
  assign sig_207_lut_1 = (~net_793 & ~i_mcu_dcs & (~(net_286 & ~io_mcu_d[3]))) | (net_793 & ~i_mcu_dcs) | (net_793 & i_mcu_dcs);
  assign sig_207_ff0_d = (~net_289 & sig_207_lut_0) | (net_289 & sig_207_lut_1);

  always @(posedge gclk_9)
  begin
    net_289 <= sig_207_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 212, MSLICE 0

  assign sig_212_lut_0 = (~net_512 & ~net_234 & ((~net_125 & net_291) | (net_125 & net_291))) | (net_512 & ~net_234 & ((net_125 | net_291))) | (net_512 & net_234 & ((net_125 & ~net_291) | (net_125 & net_291)));
  assign sig_212_lut_1 = (~net_512 & ~net_234 & ((~net_109 & net_290) | (net_109 & net_290))) | (net_512 & ~net_234 & ((net_109 | net_290))) | (net_512 & net_234 & ((net_109 & ~net_290) | (net_109 & net_290)));

  always @(posedge gclk_9)
  begin
    net_291 <= sig_212_lut_0;
    net_290 <= sig_212_lut_1;
  end

//---------------------------------------------------------------------------
//Block 213, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_293 <= 1'b0;
      net_292 <= 1'b0;
    end
    else
    begin
      net_293 <= net_392;
      net_292 <= net_395;
    end
  end

//---------------------------------------------------------------------------
//Block 214, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_294 <= 1'b0;
      net_297 <= 1'b0;
    end
    else
    begin
      net_294 <= net_382;
      net_297 <= net_413;
    end
  end

//---------------------------------------------------------------------------
//Block 215, MSLICE 1

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_296 <= 1'b0;
      net_295 <= 1'b0;
    end
    else
    begin
      net_296 <= net_390;
      net_295 <= net_391;
    end
  end

//---------------------------------------------------------------------------
//Block 216, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_299 <= 1'b0;
      net_298 <= 1'b0;
    end
    else
    begin
      net_299 <= net_426;
      net_298 <= net_410;
    end
  end

//---------------------------------------------------------------------------
//Block 217, LSLICE 2

  assign net_305 = (~net_237 & ~net_302 & ~net_162 & ((~net_163 & ~net_301) | (~net_163 & net_301))) | (~net_237 & ~net_302 & net_162 & ((~net_163 & net_301))) | (~net_237 & net_302 & ~net_162) | (~net_237 & net_302 & net_162 & ((~net_163 & net_301) | (net_163 & net_301)));
  assign net_304 = (net_517 & ((net_452 & net_1283)));

  always @(posedge gclk_9)
  begin
    if(net_304 == 1'b1)   //enable
     begin
      net_301 <= io_mcu_d[3];
      net_302 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 218, LSLICE 3

  assign net_306 = (net_245 & ~net_300 & ~net_166 & (~(~net_174 & net_303))) | (net_245 & ~net_300 & net_166 & (~(~net_174 & net_303))) | (net_245 & net_300 & net_166 & (~(~net_174 & net_303)));
  assign net_307 = (net_245 & ~net_243 & ~net_166 & ((net_88 & ~net_300) | (net_88 & net_300))) | (net_245 & ~net_243 & net_166 & (~(~net_88 & net_300))) | (net_245 & net_243 & net_166 & ((~net_88 & ~net_300) | (net_88 & ~net_300)));

  always @(posedge gclk_9)
  begin
    if(net_304 == 1'b1)   //enable
     begin
      net_303 <= io_mcu_d[7];
      net_300 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 219, LSLICE 2

  assign net_308 = ((~net_643 & net_644));
  assign net_309 = (~net_531 & ~net_645 & ((~net_314 & ~net_530)));

//---------------------------------------------------------------------------
//Block 220, MSLICE 1

  assign net_313 = ((net_446 & net_1141));
  assign net_310 = (~net_916 & ((~net_1141 & ~net_1341) | (net_1141 & ~net_1341))) | (net_916 & ((net_1141 & ~net_1341)));

  always @(posedge gclk_9)
  begin
    if(net_313 == 1'b1)   //enable
     begin
      net_311 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 221, MSLICE 0

  assign sig_221_lut_0 = 1'b0;
  assign sig_221_lut_1 = (net_180 & ~net_643 & ((~net_644 & ~net_181)));
  assign net_312 = (~net_316 & sig_221_lut_0) | (net_316 & sig_221_lut_1);

//---------------------------------------------------------------------------
//Block 222, LSLICE 3

  assign net_315 = (~net_530 & net_645 & ((~net_531 & ~net_314)));
  assign net_316 = (~net_314 & ~net_645 & ((net_531 & ~net_530)));

  always @(posedge gclk_9)
  begin
    if(net_184 == 1'b1)   //enable
     begin
      net_314 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//Block 223, LSLICE 2

  assign net_320 = (net_895 & net_308 & ((~net_180 & ~net_181)));
  assign net_319 = (net_308 & ((~net_181 & net_180)));

  always @(posedge gclk_9)
  begin
    if(net_320 == 1'b1)   //enable
     begin
      net_322 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 224, LSLICE 3

  assign net_323 = (~net_328 & net_312 & (~(net_1283 & ~net_318)));
  assign net_321 = (net_312 & ~net_331 & (~(net_1283 & ~net_317)));

  always @(posedge gclk_9)
  begin
    if(net_454 == 1'b1)   //enable
     begin
      net_318 <= io_mcu_d[3];
      net_317 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//Block 225, MSLICE 0

  assign sig_225_lut_0 = (~i_mcu_dcs & ~net_807) | (i_mcu_dcs & ~net_807 & ((net_645 & ~net_324) | (net_645 & net_324))) | (i_mcu_dcs & net_807 & ((net_645 & ~net_324) | (net_645 & net_324)));
  assign sig_225_lut_1 = (net_324 & ~i_mcu_dcs) | (net_324 & i_mcu_dcs);
  assign sig_225_ff0_d = (~i_mcu_rws & sig_225_lut_0) | (i_mcu_rws & sig_225_lut_1);

  always @(posedge gclk_9)
  begin
    net_324 <= sig_225_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 226, LSLICE 2

  assign net_328 = (~net_262 & ~net_1141 & ((~net_1283 & ~net_325) | (~net_1283 & net_325))) | (~net_262 & net_1141 & ((~net_1283 & ~net_325))) | (net_262 & net_1141 & ((~net_1283 & ~net_325)));
  assign net_327 = (~net_1141 & ~net_190 & ((~net_1283 & ~net_326) | (~net_1283 & net_326))) | (net_1141 & ~net_190 & ((~net_1283 & ~net_326))) | (net_1141 & net_190 & ((~net_1283 & ~net_326)));

  always @(posedge gclk_9)
  begin
    if(net_535 == 1'b1)   //enable
     begin
      net_325 <= io_mcu_d[3];
      net_326 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 227, MSLICE 1

  assign sig_227_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((~net_711 & ~net_717) | (~net_711 & net_717))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_711 & ~net_717) | (net_711 & ~net_717)));
  assign sig_227_lut_1 = 1'b0;
  assign net_329 = (~net_183 & sig_227_lut_0) | (net_183 & sig_227_lut_1);

//---------------------------------------------------------------------------
//Block 228, LSLICE 3

  assign net_331 = (~net_1141 & ~net_1283 & ((~net_188 & ~net_330) | (~net_188 & net_330))) | (net_1141 & ~net_1283 & ((~net_188 & ~net_330) | (net_188 & ~net_330)));
  assign net_332 = (~net_1150 & net_188 & ((net_439 & ~net_1141))) | (net_1150 & ~net_188 & ((net_439 & net_1141))) | (net_1150 & net_188 & ((net_439 & ~net_1141) | (net_439 & net_1141)));

  always @(posedge gclk_9)
  begin
    if(net_535 == 1'b1)   //enable
     begin
      net_330 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//Block 229, MSLICE 0

  assign net_337 = (~net_247 & ((net_668 & net_1056)));
  assign net_338 = ((net_333 & net_1113));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_333 <= 1'b0;
    end
    else
    begin
      if(net_337 == 1'b1)   //enable
       begin
        net_333 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 230, LSLICE 3

  assign net_340 = (~net_247 & ((net_668 & net_1276)));
  assign net_334 = (~net_951 & net_1468 & ((net_1067 & ~net_1276) | (net_1067 & net_1276))) | (net_951 & ~net_1468 & ((net_1067 | net_1276))) | (net_951 & net_1468 & ((net_1067 | net_1276)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_336 <= 1'b0;
    end
    else
    begin
      if(net_340 == 1'b1)   //enable
       begin
        net_336 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 231, MSLICE 1

  assign net_339 = (net_254 & net_554 & (~(net_188 & ~net_310)));
  assign net_335 = ((~net_266 & net_1038));

//---------------------------------------------------------------------------
//Block 232, MSLICE 0

  assign sig_232_lut_0 = (~net_574 & ~net_487) | (~net_574 & net_487) | (net_574 & ~net_487) | (net_574 & net_487);
  assign sig_232_lut_1 = (~net_341 & ~net_574) | (net_341 & ~net_574) | (net_341 & net_574 & (~(~net_487 & net_1532)));
  assign sig_232_ff0_d = (~net_680 & sig_232_lut_0) | (net_680 & sig_232_lut_1);

  always @(posedge gclk_8)
  begin
    if(net_248 == 1'b0)   //enable
     begin
      net_341 <= sig_232_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 233, LSLICE 2

  assign net_343 = ((net_999 & i_mcu_rws));
  assign net_344 = ((i_mcu_rws & net_906));

//---------------------------------------------------------------------------
//Block 234, MSLICE 1

  assign sig_234_lut_0 = (~net_489 & ~net_481) | (~net_489 & net_481 & ((~net_346 & net_342) | (net_346 & net_342))) | (net_489 & ~net_481) | (net_489 & net_481 & ((~net_346 & net_342)));
  assign sig_234_lut_1 = 1'b0;
  assign sig_234_ff0_d = (~net_582 & sig_234_lut_0) | (net_582 & sig_234_lut_1);

  always @(posedge gclk_8)
  begin
    if(net_248 == 1'b0)   //enable
     begin
      net_342 <= sig_234_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 235, LSLICE 3

  assign net_345 = (net_960 & net_202 & ((net_962 & net_1289)));
  assign net_346 = (~net_962 & ~net_849 & ((~net_826 & net_350))) | (net_962 & ~net_849 & ((~net_826 & net_350))) | (net_962 & net_849 & ((~net_826 & net_350)));

//---------------------------------------------------------------------------
//Block 236, MSLICE 0

  assign sig_236_lut_0 = (~net_668 & ~net_862) | (~net_668 & net_862) | (net_668 & ~net_862 & ((~net_952 & ~net_843)));
  assign sig_236_lut_1 = 1'b0;
  assign net_348 = (~net_477 & sig_236_lut_0) | (net_477 & sig_236_lut_1);

//---------------------------------------------------------------------------
//Block 237, LSLICE 3

  assign net_347 = (~net_281 & ~net_335 & ~net_355 & (~(net_207 & net_352)));
  assign net_349 = (net_276 & net_509 & net_361 & ((net_485 & net_347)));

//---------------------------------------------------------------------------
//Block 238, MSLICE 1

  assign sig_238_lut_0 = 1'b0;
  assign sig_238_lut_1 = (net_570 & net_572 & ((~net_475 & ~net_968)));
  assign net_350 = (~net_860 & sig_238_lut_0) | (net_860 & sig_238_lut_1);

//---------------------------------------------------------------------------
//Block 239, MSLICE 0

  assign net_355 = (net_951 & ((net_275 & net_843)));
  assign net_352 = ((net_952 & net_951));

//---------------------------------------------------------------------------
//Block 240, LSLICE 2

  assign sig_240_lut_0 = (~io_mcu_d[4] & ~net_344 & ~i_mcu_dcs & ((~net_793 & net_351) | (net_793 & net_351))) | (~io_mcu_d[4] & ~net_344 & i_mcu_dcs & ((net_793 & net_351))) | (~io_mcu_d[4] & net_344 & ~i_mcu_dcs & ((net_793 & net_351))) | (~io_mcu_d[4] & net_344 & i_mcu_dcs & ((net_793 & net_351))) | (io_mcu_d[4] & ~net_344 & ~i_mcu_dcs & ((~net_793 & net_351) | (net_793 & net_351))) | (io_mcu_d[4] & ~net_344 & i_mcu_dcs & ((net_793 & net_351))) | (io_mcu_d[4] & net_344 & ~i_mcu_dcs) | (io_mcu_d[4] & net_344 & i_mcu_dcs & ((net_793 & net_351)));
  assign net_353 = (net_351 & ((net_1032 & net_843)));

  always @(posedge gclk_9)
  begin
    net_351 <= sig_240_lut_0;
  end

//---------------------------------------------------------------------------
//Block 241, MSLICE 1

  assign sig_241_lut_0 = (~net_588 & ~net_951) | (~net_588 & net_951 & ((~net_862 & ~net_950)));
  assign sig_241_lut_1 = 1'b0;
  assign net_354 = (~net_840 & sig_241_lut_0) | (net_840 & sig_241_lut_1);

//---------------------------------------------------------------------------
//Block 242, LSLICE 3

  assign sig_242_lut_0 = (~net_265 & ~i_mcu_dcs & ~io_mcu_d[2] & ((~net_793 & net_356) | (net_793 & net_356))) | (~net_265 & ~i_mcu_dcs & io_mcu_d[2] & ((~net_793 & net_356) | (net_793 & net_356))) | (~net_265 & i_mcu_dcs & ~io_mcu_d[2] & (~(net_793 & ~net_356))) | (~net_265 & i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_356))) | (net_265 & ~i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_356))) | (net_265 & i_mcu_dcs & ~io_mcu_d[2] & (~(net_793 & ~net_356))) | (net_265 & i_mcu_dcs & io_mcu_d[2] & (~(net_793 & ~net_356)));
  assign net_357 = (net_356 & ((net_950 & net_951)));

  always @(posedge gclk_9)
  begin
    net_356 <= sig_242_lut_0;
  end

//---------------------------------------------------------------------------
//Block 243, LSLICE 3

  assign sig_243_lut_0 = (~net_343 & ~i_mcu_dcs & ~io_mcu_d[7] & ((~net_793 & net_358) | (net_793 & net_358))) | (~net_343 & ~i_mcu_dcs & io_mcu_d[7] & ((~net_793 & net_358) | (net_793 & net_358))) | (~net_343 & i_mcu_dcs & ~io_mcu_d[7] & (~(net_793 & ~net_358))) | (~net_343 & i_mcu_dcs & io_mcu_d[7] & (~(net_793 & ~net_358))) | (net_343 & ~i_mcu_dcs & io_mcu_d[7] & (~(net_793 & ~net_358))) | (net_343 & i_mcu_dcs & ~io_mcu_d[7] & (~(net_793 & ~net_358))) | (net_343 & i_mcu_dcs & io_mcu_d[7] & (~(net_793 & ~net_358)));
  assign net_359 = ((net_358 & net_475));

  always @(posedge gclk_9)
  begin
    net_358 <= sig_243_lut_0;
  end

//---------------------------------------------------------------------------
//Block 244, MSLICE 1

  assign sig_244_lut_0 = (net_286 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[6]) | (net_793 & io_mcu_d[6])));
  assign sig_244_lut_1 = (~net_286 & ~i_mcu_dcs) | (~net_286 & i_mcu_dcs & ((net_793 & ~io_mcu_d[6]) | (net_793 & io_mcu_d[6]))) | (net_286 & ~i_mcu_dcs & ((net_793 | io_mcu_d[6]))) | (net_286 & i_mcu_dcs & ((net_793 & ~io_mcu_d[6]) | (net_793 & io_mcu_d[6])));
  assign sig_244_ff0_d = (~net_360 & sig_244_lut_0) | (net_360 & sig_244_lut_1);

  always @(posedge gclk_9)
  begin
    net_360 <= sig_244_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 245, MSLICE 0

  assign sig_245_lut_0 = (~net_595 & ~net_590 & ((~net_579 & ~net_359)));
  assign sig_245_lut_1 = 1'b0;
  assign net_361 = (~net_282 & sig_245_lut_0) | (net_282 & sig_245_lut_1);

//---------------------------------------------------------------------------
//Block 246, MSLICE 0

  assign sig_246_lut_0 = (net_344 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[5]) | (net_793 & io_mcu_d[5])));
  assign sig_246_lut_1 = (~net_344 & ~i_mcu_dcs) | (~net_344 & i_mcu_dcs & ((~io_mcu_d[5] & net_793) | (io_mcu_d[5] & net_793))) | (net_344 & ~i_mcu_dcs & ((io_mcu_d[5] | net_793))) | (net_344 & i_mcu_dcs & ((~io_mcu_d[5] & net_793) | (io_mcu_d[5] & net_793)));
  assign sig_246_ff0_d = (~net_364 & sig_246_lut_0) | (net_364 & sig_246_lut_1);

  always @(posedge gclk_9)
  begin
    net_364 <= sig_246_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 247, LSLICE 2

  assign sig_247_lut_0 = (~io_mcu_d[2] & ~net_344 & ~i_mcu_dcs & ((~net_793 & net_362) | (net_793 & net_362))) | (~io_mcu_d[2] & ~net_344 & i_mcu_dcs & ((net_793 & net_362))) | (~io_mcu_d[2] & net_344 & ~i_mcu_dcs & ((net_793 & net_362))) | (~io_mcu_d[2] & net_344 & i_mcu_dcs & ((net_793 & net_362))) | (io_mcu_d[2] & ~net_344 & ~i_mcu_dcs & ((~net_793 & net_362) | (net_793 & net_362))) | (io_mcu_d[2] & ~net_344 & i_mcu_dcs & ((net_793 & net_362))) | (io_mcu_d[2] & net_344 & ~i_mcu_dcs) | (io_mcu_d[2] & net_344 & i_mcu_dcs & ((net_793 & net_362)));
  assign sig_247_lut_1 = (~net_344 & ~io_mcu_d[3] & ~i_mcu_dcs & ((~net_793 & net_363) | (net_793 & net_363))) | (~net_344 & ~io_mcu_d[3] & i_mcu_dcs & ((net_793 & net_363))) | (~net_344 & io_mcu_d[3] & ~i_mcu_dcs & ((~net_793 & net_363) | (net_793 & net_363))) | (~net_344 & io_mcu_d[3] & i_mcu_dcs & ((net_793 & net_363))) | (net_344 & ~io_mcu_d[3] & ~i_mcu_dcs & ((net_793 & net_363))) | (net_344 & ~io_mcu_d[3] & i_mcu_dcs & ((net_793 & net_363))) | (net_344 & io_mcu_d[3] & ~i_mcu_dcs) | (net_344 & io_mcu_d[3] & i_mcu_dcs & ((net_793 & net_363)));

  always @(posedge gclk_9)
  begin
    net_362 <= sig_247_lut_0;
    net_363 <= sig_247_lut_1;
  end

//---------------------------------------------------------------------------
//Block 248, MSLICE 0

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_366 <= 1'b0;
      net_368 <= 1'b0;
    end
    else
    begin
      net_366 <= net_379;
      net_368 <= net_378;
    end
  end

//---------------------------------------------------------------------------
//Block 249, MSLICE 1

  always @(posedge gclk_9)
  begin
    if(net_634 == 1'b1)   //enable
     begin
      net_367 <= io_mcu_d[1];
      net_365 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 250, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_634 == 1'b1)   //enable
     begin
      net_372 <= io_mcu_d[3];
      net_370 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 251, MSLICE 1

  always @(posedge gclk_9)
  begin
    if(net_634 == 1'b1)   //enable
     begin
      net_371 <= io_mcu_d[5];
      net_369 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 252, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_634 == 1'b1)   //enable
     begin
      net_376 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//Block 255, MSLICE 1

  always @(posedge gclk_9)
  begin
    if(net_640 == 1'b1)   //enable
     begin
      net_375 <= io_mcu_d[1];
    end
  end

//---------------------------------------------------------------------------
//Block 256, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_640 == 1'b1)   //enable
     begin
      net_396 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 259, MSLICE 1

  always @(posedge gclk_9)
  begin
    if(net_640 == 1'b1)   //enable
     begin
      net_388 <= io_mcu_d[5];
      net_386 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 260, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_640 == 1'b1)   //enable
     begin
      net_405 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//Block 263, MSLICE 1

  always @(posedge gclk_9)
  begin
    if(net_313 == 1'b1)   //enable
     begin
      net_404 <= io_mcu_d[1];
      net_402 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 264, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_313 == 1'b1)   //enable
     begin
      net_421 <= io_mcu_d[3];
      net_418 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 267, MSLICE 1

  always @(posedge gclk_9)
  begin
    if(net_313 == 1'b1)   //enable
     begin
      net_420 <= io_mcu_d[5];
      net_417 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 268, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_313 == 1'b1)   //enable
     begin
      net_435 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//Block 270, MSLICE 1

  always @(posedge gclk_9)
  begin
    if(net_455 == 1'b1)   //enable
     begin
      net_434 <= io_mcu_d[1];
      net_433 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 272, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_455 == 1'b1)   //enable
     begin
      net_443 <= io_mcu_d[3];
      net_441 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 274, MSLICE 1

  always @(posedge gclk_9)
  begin
    if(net_455 == 1'b1)   //enable
     begin
      net_442 <= io_mcu_d[5];
      net_440 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 276, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_455 == 1'b1)   //enable
     begin
      net_450 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 248, 249, 250, 251, 252, 255, 256, 259, 260, 263, 264, 267, 268, 270, 272, 274, 276

  assign { net_451, open_0, open_1, open_2, open_3, open_4, open_5, open_6, open_7, open_8, open_9, open_10, open_11, open_12, open_13, open_14, open_15, open_16, open_17, open_18, open_19, open_20, open_21, open_22, open_23, open_24, open_25, open_26, open_27, open_28, open_29, open_30, open_31 } = { 1'b0, net_450, net_440, net_442, net_441, net_443, net_433, net_434, net_456, net_435, net_417, net_420, net_418, net_421, net_402, net_404, net_311, net_405, net_386, net_388, net_396, net_638, net_639, net_375, net_1130, net_376, net_369, net_371, net_370, net_372, net_365, net_367, net_635 } - { net_432, net_522, net_438, net_422, net_419, net_518, net_299, net_427, net_416, net_298, net_520, net_407, net_403, net_521, net_297, net_411, net_401, net_292, net_295, net_399, net_387, net_389, net_296, net_293, net_400, net_294, net_368, net_380, net_373, net_366, net_374, net_377 };

//---------------------------------------------------------------------------
//Block 253, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_377 <= 1'b0;
      net_374 <= 1'b0;
    end
    else
    begin
      net_377 <= net_385;
      net_374 <= net_381;
    end
  end

//---------------------------------------------------------------------------
//Block 254, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_373 <= 1'b0;
      net_380 <= 1'b0;
    end
    else
    begin
      net_373 <= net_384;
      net_380 <= net_383;
    end
  end

//---------------------------------------------------------------------------
//Block 257, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_389 <= 1'b0;
      net_400 <= 1'b0;
    end
    else
    begin
      net_389 <= net_398;
      net_400 <= net_394;
    end
  end

//---------------------------------------------------------------------------
//Block 258, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_387 <= 1'b0;
      net_399 <= 1'b0;
    end
    else
    begin
      net_387 <= net_397;
      net_399 <= net_393;
    end
  end

//---------------------------------------------------------------------------
//Block 261, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_401 <= 1'b0;
      net_411 <= 1'b0;
    end
    else
    begin
      net_401 <= net_409;
      net_411 <= net_414;
    end
  end

//---------------------------------------------------------------------------
//Block 262, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_403 <= 1'b0;
      net_407 <= 1'b0;
    end
    else
    begin
      net_403 <= net_415;
      net_407 <= net_412;
    end
  end

//---------------------------------------------------------------------------
//Block 265, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_416 <= 1'b0;
      net_427 <= 1'b0;
    end
    else
    begin
      net_416 <= net_424;
      net_427 <= net_429;
    end
  end

//---------------------------------------------------------------------------
//Block 266, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_419 <= 1'b0;
      net_422 <= 1'b0;
    end
    else
    begin
      net_419 <= net_431;
      net_422 <= net_428;
    end
  end

//---------------------------------------------------------------------------
//Block 269, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_432 <= 1'b0;
      net_438 <= 1'b0;
    end
    else
    begin
      net_432 <= net_437;
      net_438 <= net_430;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 253, 254, 257, 258, 261, 262, 265, 266, 269

  assign { net_437, net_425, net_430, net_428, net_431, net_423, net_426, net_429, net_424, net_410, net_406, net_412, net_415, net_408, net_413, net_414, net_409, net_395, net_391, net_393, net_397, net_398, net_390, net_392, net_394, net_382, net_378, net_383, net_384, net_379, net_381, net_385 } = { net_432, net_522, net_438, net_422, net_419, net_518, net_299, net_427, net_416, net_298, net_520, net_407, net_403, net_521, net_297, net_411, net_401, net_292, net_295, net_399, net_387, net_389, net_296, net_293, net_400, net_294, net_368, net_380, net_373, net_366, net_374, net_377 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 271, LSLICE 3

  assign net_436 = (net_180 & net_181 & ((net_647 & net_308)));
  assign net_439 = (net_315 & net_308 & ((~net_180 & ~net_181)));

//---------------------------------------------------------------------------
//Block 273, LSLICE 2

  assign net_447 = (~net_532 & ~net_220 & ~net_643) | (~net_532 & ~net_220 & net_643 & (~(net_644 & ~net_444)));
  assign net_444 = (~net_647 & ~net_180 & (~(net_181 & net_309))) | (~net_647 & net_180 & (~(~net_181 & net_309))) | (net_647 & ~net_180 & (~(net_181 & net_309))) | (net_647 & net_180 & ((~net_181 & ~net_309)));

  always @(posedge gclk_9)
  begin
    if(net_535 == 1'b1)   //enable
     begin
      net_448 <= io_mcu_d[5];
    end
  end

//---------------------------------------------------------------------------
//Block 275, LSLICE 3

  assign net_449 = (net_224 & net_180 & ~net_643 & ((~net_644 & ~net_181)));
  assign net_446 = (net_643 & net_644 & net_180 & ((net_224 & ~net_181)));

  always @(posedge gclk_9)
  begin
    if(net_449 == 1'b1)   //enable
     begin
      net_445 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 277, LSLICE 3

  assign net_452 = ((~i_mcu_dcs & i_mcu_rws));
  assign net_454 = (net_1283 & ((net_532 & net_452)));

  always @(posedge gclk_9)
  begin
    if(net_454 == 1'b1)   //enable
     begin
      net_458 <= io_mcu_d[1];
      net_457 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 278, MSLICE 1

  assign net_455 = ((net_446 & net_1283));
  assign net_453 = ((net_1283 & net_525));

  always @(posedge gclk_9)
  begin
    if(net_455 == 1'b1)   //enable
     begin
      net_456 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 279, MSLICE 0

  assign sig_279_lut_0 = (~net_336 & ~net_1113 & (~(net_523 & ~net_250))) | (~net_336 & net_1113 & (~(net_523 & ~net_250))) | (net_336 & ~net_1113 & (~(net_523 & ~net_250)));
  assign sig_279_lut_1 = 1'b0;
  assign net_467 = (~net_653 & sig_279_lut_0) | (net_653 & sig_279_lut_1);

//---------------------------------------------------------------------------
//Block 280, LSLICE 2

  assign net_462 = (~net_1283 & ~net_1141 & ~net_448 & ((net_256 & ~net_460) | (net_256 & net_460))) | (~net_1283 & ~net_1141 & net_448 & ((net_256 & ~net_460) | (net_256 & net_460))) | (~net_1283 & net_1141 & net_448) | (net_1283 & ~net_1141 & ~net_448 & ((~net_256 & net_460) | (net_256 & net_460))) | (net_1283 & ~net_1141 & net_448 & ((~net_256 & net_460) | (net_256 & net_460))) | (net_1283 & net_1141 & ~net_448 & ((~net_256 & net_460) | (net_256 & net_460))) | (net_1283 & net_1141 & net_448 & ((~net_256 & net_460) | (net_256 & net_460)));
  assign net_466 = (net_1238 & ~net_462 & ~net_312 & (~(net_471 & net_547))) | (net_1238 & ~net_462 & net_312 & (~(net_471 & net_547))) | (net_1238 & net_462 & ~net_312 & (~(net_471 & net_547)));

  always @(posedge gclk_9)
  begin
    if(net_454 == 1'b1)   //enable
     begin
      net_460 <= io_mcu_d[5];
    end
  end

//---------------------------------------------------------------------------
//Block 281, MSLICE 1

  assign net_464 = (~net_1141 & ~net_1283 & ((~net_908 & ~net_461) | (~net_908 & net_461))) | (net_1141 & ~net_1283 & ((~net_908 & ~net_461) | (net_908 & ~net_461)));
  assign net_465 = (~net_457 & ~net_1283 & ((net_312 & ~net_464))) | (net_457 & ~net_1283 & ((net_312 & ~net_464))) | (net_457 & net_1283 & ((net_312 & ~net_464)));

  always @(posedge gclk_9)
  begin
    if(net_535 == 1'b1)   //enable
     begin
      net_461 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 282, LSLICE 3

  assign net_468 = (net_1505 & ~net_463 & net_659 & ((net_467 & net_931)));
  assign net_463 = (~net_327 & ~net_1283 & ((net_312 & ~net_459) | (net_312 & net_459))) | (~net_327 & net_1283 & ((net_312 & net_459)));

  always @(posedge gclk_9)
  begin
    if(net_454 == 1'b1)   //enable
     begin
      net_459 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 283, MSLICE 1

  assign net_473 = (net_1067 & ((net_1032 & ~net_247)));
  assign net_472 = (~net_469 & ((~net_332 & ~net_906) | (~net_332 & net_906))) | (net_469 & ((~net_332 & ~net_906)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_469 <= 1'b0;
    end
    else
    begin
      if(net_473 == 1'b1)   //enable
       begin
        net_469 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 284, LSLICE 3

  assign net_474 = (~net_247 & ((net_951 & net_1056)));
  assign net_470 = ((net_1289 & net_1056));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_471 <= 1'b0;
    end
    else
    begin
      if(net_474 == 1'b1)   //enable
       begin
        net_471 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 285, MSLICE 0

  assign net_479 = (~net_247 & ((net_1468 & net_1056)));
  assign net_475 = ((net_950 & net_1468));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_482 <= 1'b0;
    end
    else
    begin
      if(net_479 == 1'b1)   //enable
       begin
        net_482 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 286, LSLICE 2

  assign net_476 = (net_1032 & ((net_847 & ~net_247)));
  assign net_477 = (~net_863 & ~net_843 & ((net_1032 & net_1276))) | (~net_863 & net_843 & ((net_1032 & ~net_1276) | (net_1032 & net_1276))) | (net_863 & ~net_843 & ((net_1032 & ~net_1276) | (net_1032 & net_1276))) | (net_863 & net_843 & ((net_1032 & ~net_1276) | (net_1032 & net_1276)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_478 <= 1'b0;
    end
    else
    begin
      if(net_476 == 1'b1)   //enable
       begin
        net_478 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 287, LSLICE 3

  assign net_483 = (~net_247 & ((net_951 & net_847)));
  assign net_480 = (~net_862 & ~net_1523 & (~(net_847 & net_564))) | (~net_862 & net_1523 & (~(net_847 & net_564))) | (net_862 & ~net_1523 & (~(net_847 & net_564)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_484 <= 1'b0;
    end
    else
    begin
      if(net_483 == 1'b1)   //enable
       begin
        net_484 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 288, MSLICE 1

  assign sig_288_lut_0 = (~net_584 & ~net_952) | (~net_584 & net_952 & ((~net_863 & ~net_1060) | (net_863 & ~net_1060))) | (net_584 & ~net_952 & ((~net_863 & ~net_1060) | (~net_863 & net_1060)));
  assign sig_288_lut_1 = 1'b0;
  assign net_481 = (~net_247 & sig_288_lut_0) | (net_247 & sig_288_lut_1);

//---------------------------------------------------------------------------
//Block 289, MSLICE 0

  assign sig_289_lut_0 = 1'b0;
  assign sig_289_lut_1 = (~net_353 & ~net_1245 & ((~net_493 & ~net_269)));
  assign net_485 = (~net_494 & sig_289_lut_0) | (net_494 & sig_289_lut_1);

//---------------------------------------------------------------------------
//Block 290, LSLICE 2

  assign net_489 = (net_672 & net_575 & ((net_497 & ~net_487)));
  assign net_487 = ((net_580 & net_570));

//---------------------------------------------------------------------------
//Block 291, LSLICE 3

  assign sig_291_lut_0 = (~net_816 & ~i_mcu_dcs & ~io_mcu_d[0] & ((~net_793 & net_486) | (net_793 & net_486))) | (~net_816 & ~i_mcu_dcs & io_mcu_d[0] & ((~net_793 & net_486) | (net_793 & net_486))) | (~net_816 & i_mcu_dcs & ~io_mcu_d[0] & (~(net_793 & ~net_486))) | (~net_816 & i_mcu_dcs & io_mcu_d[0] & (~(net_793 & ~net_486))) | (net_816 & ~i_mcu_dcs & io_mcu_d[0] & (~(net_793 & ~net_486))) | (net_816 & i_mcu_dcs & ~io_mcu_d[0] & (~(net_793 & ~net_486))) | (net_816 & i_mcu_dcs & io_mcu_d[0] & (~(net_793 & ~net_486)));
  assign net_488 = (~net_961 & ((~net_486 & ~net_967) | (net_486 & ~net_967))) | (net_961 & ((~net_486 & ~net_967)));

  always @(posedge gclk_9)
  begin
    net_486 <= sig_291_lut_0;
  end

//---------------------------------------------------------------------------
//Block 292, MSLICE 1

  assign sig_292_lut_0 = 1'b0;
  assign sig_292_lut_1 = (~net_588 & ~net_969 & (~(net_1067 & net_1060)));
  assign net_490 = (~net_838 & sig_292_lut_0) | (net_838 & sig_292_lut_1);

//---------------------------------------------------------------------------
//Block 293, MSLICE 0

  assign net_498 = (net_502 & ~net_357 & (~(~net_211 & net_668)));
  assign net_497 = (net_958 & ((~net_334 & ~net_674)));

//---------------------------------------------------------------------------
//Block 294, LSLICE 2

  assign net_492 = (~net_826 & ~net_968 & ~net_668) | (~net_826 & ~net_968 & net_668 & ((~net_863 & ~net_962)));
  assign net_495 = (net_348 & net_492 & net_354 & ((~net_1068 & ~net_688)));

//---------------------------------------------------------------------------
//Block 295, LSLICE 3

  assign sig_295_lut_0 = (~io_mcu_d[7] & ~net_344 & ~i_mcu_dcs & ((~net_793 & net_491) | (net_793 & net_491))) | (~io_mcu_d[7] & ~net_344 & i_mcu_dcs & ((net_793 & net_491))) | (~io_mcu_d[7] & net_344 & ~i_mcu_dcs & ((net_793 & net_491))) | (~io_mcu_d[7] & net_344 & i_mcu_dcs & ((net_793 & net_491))) | (io_mcu_d[7] & ~net_344 & ~i_mcu_dcs & ((~net_793 & net_491) | (net_793 & net_491))) | (io_mcu_d[7] & ~net_344 & i_mcu_dcs & ((net_793 & net_491))) | (io_mcu_d[7] & net_344 & ~i_mcu_dcs) | (io_mcu_d[7] & net_344 & i_mcu_dcs & ((net_793 & net_491)));
  assign net_494 = (~net_287 & ~net_491 & ((~net_593 & ~net_969) | (~net_593 & net_969))) | (~net_287 & net_491 & ((~net_593 & ~net_969)));

  always @(posedge gclk_9)
  begin
    net_491 <= sig_295_lut_0;
  end

//---------------------------------------------------------------------------
//Block 296, MSLICE 1

  assign net_493 = (net_668 & ((net_950 & net_283)));
  assign net_496 = ((~net_1067 & net_668));

//---------------------------------------------------------------------------
//Block 297, MSLICE 0

  assign net_500 = (~net_1468 & ~net_843 & (~(net_950 & net_1523))) | (~net_1468 & net_843 & (~(net_950 & net_1523))) | (net_1468 & ~net_843 & (~(net_950 & net_1523)));
  assign net_499 = ((net_585 & net_1468));

//---------------------------------------------------------------------------
//Block 298, LSLICE 3

  assign sig_298_lut_0 = (~net_100 & ~i_mcu_dcs & ~io_mcu_d[1] & ((~net_793 & net_501) | (net_793 & net_501))) | (~net_100 & ~i_mcu_dcs & io_mcu_d[1] & ((~net_793 & net_501) | (net_793 & net_501))) | (~net_100 & i_mcu_dcs & ~io_mcu_d[1] & (~(net_793 & ~net_501))) | (~net_100 & i_mcu_dcs & io_mcu_d[1] & (~(net_793 & ~net_501))) | (net_100 & ~i_mcu_dcs & io_mcu_d[1] & (~(net_793 & ~net_501))) | (net_100 & i_mcu_dcs & ~io_mcu_d[1] & (~(net_793 & ~net_501))) | (net_100 & i_mcu_dcs & io_mcu_d[1] & (~(net_793 & ~net_501)));
  assign net_503 = (~net_499 & ~net_501 & ~net_1333) | (~net_499 & ~net_501 & net_1333 & (~(net_843 & net_285))) | (~net_499 & net_501 & ~net_1333) | (~net_499 & net_501 & net_1333 & (~(net_843 & net_285))) | (net_499 & ~net_501 & ~net_1333) | (net_499 & ~net_501 & net_1333 & (~(net_843 & net_285)));

  always @(posedge gclk_9)
  begin
    net_501 <= sig_298_lut_0;
  end

//---------------------------------------------------------------------------
//Block 299, MSLICE 1

  assign sig_299_lut_0 = 1'b0;
  assign sig_299_lut_1 = (~net_594 & ~net_1521) | (net_594 & ~net_1521) | (net_594 & net_1521 & (~(net_508 & net_863)));
  assign net_502 = (~net_247 & sig_299_lut_0) | (net_247 & sig_299_lut_1);

//---------------------------------------------------------------------------
//Block 300, MSLICE 0

  assign sig_300_lut_0 = (net_343 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[3]) | (net_793 & io_mcu_d[3])));
  assign sig_300_lut_1 = (~net_343 & ~i_mcu_dcs) | (~net_343 & i_mcu_dcs & ((net_793 & ~io_mcu_d[3]) | (net_793 & io_mcu_d[3]))) | (net_343 & ~i_mcu_dcs & ((net_793 | io_mcu_d[3]))) | (net_343 & i_mcu_dcs & ((net_793 & ~io_mcu_d[3]) | (net_793 & io_mcu_d[3])));
  assign sig_300_ff0_d = (~net_508 & sig_300_lut_0) | (net_508 & sig_300_lut_1);

  always @(posedge gclk_9)
  begin
    net_508 <= sig_300_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 301, LSLICE 2

  assign sig_301_lut_0 = (~net_344 & ~i_mcu_dcs & ~io_mcu_d[1] & ((~net_793 & net_505) | (net_793 & net_505))) | (~net_344 & ~i_mcu_dcs & io_mcu_d[1] & ((~net_793 & net_505) | (net_793 & net_505))) | (~net_344 & i_mcu_dcs & ~io_mcu_d[1] & (~(net_793 & ~net_505))) | (~net_344 & i_mcu_dcs & io_mcu_d[1] & (~(net_793 & ~net_505))) | (net_344 & ~i_mcu_dcs & io_mcu_d[1] & (~(net_793 & ~net_505))) | (net_344 & i_mcu_dcs & ~io_mcu_d[1] & (~(net_793 & ~net_505))) | (net_344 & i_mcu_dcs & io_mcu_d[1] & (~(net_793 & ~net_505)));
  assign net_507 = (~net_863 & ~net_505 & net_363 & ((net_950 & net_1032))) | (~net_863 & net_505 & net_363 & ((net_950 & net_1032))) | (net_863 & ~net_505 & net_363 & ((net_950 & net_1032))) | (net_863 & net_505 & ~net_363 & ((~net_950 & net_1032) | (net_950 & net_1032))) | (net_863 & net_505 & net_363 & ((~net_950 & net_1032) | (net_950 & net_1032)));

  always @(posedge gclk_9)
  begin
    net_505 <= sig_301_lut_0;
  end

//---------------------------------------------------------------------------
//Block 302, LSLICE 3

  assign sig_302_lut_0 = (~net_100 & ~i_mcu_dcs & ~io_mcu_d[0] & ((~net_793 & net_506) | (net_793 & net_506))) | (~net_100 & ~i_mcu_dcs & io_mcu_d[0] & ((~net_793 & net_506) | (net_793 & net_506))) | (~net_100 & i_mcu_dcs & ~io_mcu_d[0] & (~(net_793 & ~net_506))) | (~net_100 & i_mcu_dcs & io_mcu_d[0] & (~(net_793 & ~net_506))) | (net_100 & ~i_mcu_dcs & io_mcu_d[0] & (~(net_793 & ~net_506))) | (net_100 & i_mcu_dcs & ~io_mcu_d[0] & (~(net_793 & ~net_506))) | (net_100 & i_mcu_dcs & io_mcu_d[0] & (~(net_793 & ~net_506)));
  assign net_509 = (net_503 & ~net_506 & ~net_684 & ((~net_507 & ~net_685))) | (net_503 & ~net_506 & net_684 & ((~net_507 & ~net_685))) | (net_503 & net_506 & ~net_684 & ((~net_507 & ~net_685)));

  always @(posedge gclk_9)
  begin
    net_506 <= sig_302_lut_0;
  end

//---------------------------------------------------------------------------
//Block 303, MSLICE 1

  assign sig_303_lut_0 = (~i_mcu_dcs & ~io_mcu_d[7] & ((~net_793 & net_504) | (net_793 & net_504))) | (~i_mcu_dcs & io_mcu_d[7] & ((~net_793 & net_504) | (net_793 & net_504))) | (i_mcu_dcs & ~io_mcu_d[7] & (~(net_793 & ~net_504))) | (i_mcu_dcs & io_mcu_d[7] & (~(net_793 & ~net_504)));
  assign sig_303_lut_1 = (~net_504 & ~io_mcu_d[7] & ((i_mcu_dcs & ~net_793))) | (~net_504 & io_mcu_d[7] & ((~i_mcu_dcs & ~net_793) | (i_mcu_dcs & ~net_793))) | (net_504 & ~io_mcu_d[7] & ((i_mcu_dcs & ~net_793) | (i_mcu_dcs & net_793))) | (net_504 & io_mcu_d[7]);
  assign sig_303_ff0_d = (~net_100 & sig_303_lut_0) | (net_100 & sig_303_lut_1);

  always @(posedge gclk_9)
  begin
    net_504 <= sig_303_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 304, MSLICE 1

  assign net_513 = ((net_249 & net_222));
  assign net_512 = (~i_mcu_dcs & ((net_236 & net_249)));

  always @(posedge gclk_9)
  begin
    if(net_513 == 1'b1)   //enable
     begin
      net_511 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 305, LSLICE 3

  assign net_515 = (net_236 & net_1111 & ~net_181 & ((~net_180 & ~i_mcu_dcs)));
  assign net_514 = (~net_1337 & ((~net_510 & gclk_2))) | (net_1337 & ((net_510 | gclk_2)));

  always @(posedge gclk_9)
  begin
    if(net_515 == 1'b1)   //enable
     begin
      net_510 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 306, LSLICE 2

  assign net_519 = ((net_319 & net_222));
  assign net_517 = ((net_533 & net_319));

  always @(posedge gclk_9)
  begin
    if(net_519 == 1'b1)   //enable
     begin
      net_516 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 307, MSLICE 1

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_518 <= 1'b0;
      net_520 <= 1'b0;
    end
    else
    begin
      net_518 <= net_423;
      net_520 <= net_406;
    end
  end

//---------------------------------------------------------------------------
//Block 308, MSLICE 0

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //reset
    begin
      net_522 <= 1'b0;
      net_521 <= 1'b0;
    end
    else
    begin
      net_522 <= net_425;
      net_521 <= net_408;
    end
  end

//---------------------------------------------------------------------------
//Block 309, MSLICE 0

  assign sig_309_lut_0 = 1'b0;
  assign sig_309_lut_1 = (net_644 & net_181 & ((net_180 & net_315)));
  assign net_525 = (~net_643 & sig_309_lut_0) | (net_643 & sig_309_lut_1);

//---------------------------------------------------------------------------
//Block 310, LSLICE 2

  assign net_526 = (net_643 & net_644 & net_181 & ((net_180 & net_224)));
  assign net_524 = (net_181 & net_533 & ~net_643 & ((~net_644 & ~net_180)));

  always @(posedge gclk_9)
  begin
    if(net_526 == 1'b1)   //enable
     begin
      net_527 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 311, LSLICE 3

  assign net_523 = (net_180 & ((~net_181 & net_896)));
  assign net_529 = ((~net_528 & net_523));

//---------------------------------------------------------------------------
//Block 312, MSLICE 1

  assign sig_312_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((~net_708 & ~net_720) | (~net_708 & net_720))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_708 & ~net_720) | (net_708 & ~net_720)));
  assign sig_312_lut_1 = 1'b0;
  assign net_528 = (~net_666 & sig_312_lut_0) | (net_666 & sig_312_lut_1);

//---------------------------------------------------------------------------
//Block 313, MSLICE 0

  assign net_536 = (~net_531 & ~net_314 & ((~net_645 & net_530)));
  assign net_533 = (net_530 & ~net_314 & ((net_645 & ~net_531)));

  always @(posedge gclk_9)
  begin
    if(net_184 == 1'b1)   //enable
     begin
      net_530 <= io_mcu_d[5];
      net_531 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 314, LSLICE 2

  assign net_532 = (net_643 & net_644 & ~net_181 & ((net_533 & ~net_180)));
  assign net_535 = (net_452 & ((net_532 & net_1141)));

  always @(posedge gclk_9)
  begin
    if(net_535 == 1'b1)   //enable
     begin
      net_534 <= io_mcu_d[4];
      net_538 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 315, MSLICE 1

  assign sig_315_lut_0 = (~net_482 & ~net_648 & (~(net_642 & net_905))) | (~net_482 & net_648 & (~(net_642 & net_905))) | (net_482 & ~net_648 & (~(net_642 & net_905)));
  assign sig_315_lut_1 = 1'b0;
  assign net_537 = (~net_637 & sig_315_lut_0) | (net_637 & sig_315_lut_1);

//---------------------------------------------------------------------------
//Block 316, LSLICE 3

  assign net_541 = (~net_247 & ((net_1067 & net_1468)));
  assign net_540 = (~net_905 & ~net_539) | (~net_905 & net_539 & ((~net_648 & ~net_874) | (~net_648 & net_874))) | (net_905 & ~net_539 & ((~net_648 & ~net_874) | (net_648 & ~net_874))) | (net_905 & net_539 & ((~net_648 & ~net_874)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_539 <= 1'b0;
    end
    else
    begin
      if(net_541 == 1'b1)   //enable
       begin
        net_539 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 317, LSLICE 2

  assign net_545 = (~net_1283 & ~net_1141 & ~net_534 & ((net_324 & ~net_543) | (net_324 & net_543))) | (~net_1283 & ~net_1141 & net_534 & ((net_324 & ~net_543) | (net_324 & net_543))) | (~net_1283 & net_1141 & net_534) | (net_1283 & ~net_1141 & ~net_534 & ((~net_324 & net_543) | (net_324 & net_543))) | (net_1283 & ~net_1141 & net_534 & ((~net_324 & net_543) | (net_324 & net_543))) | (net_1283 & net_1141 & ~net_534 & ((~net_324 & net_543) | (net_324 & net_543))) | (net_1283 & net_1141 & net_534 & ((~net_324 & net_543) | (net_324 & net_543)));
  assign net_548 = (net_1049 & ~net_545 & ~net_312 & (~(net_324 & net_1341))) | (net_1049 & ~net_545 & net_312 & (~(net_324 & net_1341))) | (net_1049 & net_545 & ~net_312 & (~(net_324 & net_1341)));

  always @(posedge gclk_9)
  begin
    if(net_454 == 1'b1)   //enable
     begin
      net_543 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 318, LSLICE 3

  assign net_550 = ((net_957 & ~net_247));
  assign net_546 = ((net_544 & net_1113));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_544 <= 1'b0;
    end
    else
    begin
      if(net_550 == 1'b1)   //enable
       begin
        net_544 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 319, MSLICE 1

  assign net_549 = (net_1303 & ((~net_247 & net_1161)));
  assign net_551 = (~net_542 & ~net_633 & ((~net_1113 & net_540) | (net_1113 & net_540))) | (net_542 & ~net_633 & ((~net_1113 & net_540)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_542 <= 1'b0;
    end
    else
    begin
      if(net_549 == 1'b1)   //enable
       begin
        net_542 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 320, MSLICE 0

  assign sig_320_lut_0 = 1'b0;
  assign sig_320_lut_1 = (net_644 & net_647 & ((net_180 & ~net_181)));
  assign net_547 = (~net_643 & sig_320_lut_0) | (net_643 & sig_320_lut_1);

//---------------------------------------------------------------------------
//Block 321, MSLICE 0

  assign net_556 = (net_668 & ((~net_247 & net_847)));
  assign net_557 = (~net_552 & ~net_1113 & (~(net_523 & ~net_651))) | (~net_552 & net_1113 & (~(net_523 & ~net_651))) | (net_552 & ~net_1113 & (~(net_523 & ~net_651)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_552 <= 1'b0;
    end
    else
    begin
      if(net_556 == 1'b1)   //enable
       begin
        net_552 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 322, LSLICE 2

  assign net_555 = (net_1528 & ((~net_247 & net_1648)));
  assign net_554 = (~net_547 & ~net_553 & ((net_472 & net_1108))) | (~net_547 & net_553 & ((net_472 & net_1108))) | (net_547 & ~net_553 & ((net_472 & net_1108)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_553 <= 1'b0;
    end
    else
    begin
      if(net_555 == 1'b1)   //enable
       begin
        net_553 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 323, LSLICE 3

  assign net_558 = (net_1515 & ~net_906 & ~net_1053 & (~(net_484 & net_547))) | (net_1515 & ~net_906 & net_1053 & (~(net_484 & net_547))) | (net_1515 & net_906 & ~net_1053 & (~(net_484 & net_547)));
  assign net_559 = (net_795 & ~net_262 & ((~net_310 & net_558) | (net_310 & net_558))) | (net_795 & net_262 & ((net_310 & net_558)));

//---------------------------------------------------------------------------
//Block 324, MSLICE 0

  assign net_566 = (~net_247 & ((net_1276 & net_951)));
  assign net_565 = (~net_560 & ~net_906) | (~net_560 & net_906 & ((~net_478 & ~net_547) | (~net_478 & net_547))) | (net_560 & ~net_906 & ((~net_478 & ~net_547) | (net_478 & ~net_547))) | (net_560 & net_906 & ((~net_478 & ~net_547)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_560 <= 1'b0;
    end
    else
    begin
      if(net_566 == 1'b1)   //enable
       begin
        net_560 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 325, LSLICE 2

  assign net_563 = (~net_1528 & ~net_470 & ~net_1161 & ((net_561 & ~net_562))) | (~net_1528 & ~net_470 & net_1161 & ((net_561 & ~net_562))) | (~net_1528 & net_470 & ~net_1161 & ((net_561 & ~net_562))) | (net_1528 & ~net_470 & ~net_1161 & ((net_561 & ~net_562))) | (net_1528 & net_470 & ~net_1161 & ((net_561 & ~net_562)));
  assign net_562 = (~net_1468 & net_1521 & ((net_1276 & ~net_847) | (net_1276 & net_847))) | (net_1468 & ~net_1521 & ((net_1276 | net_847))) | (net_1468 & net_1521 & ((net_1276 | net_847)));

//---------------------------------------------------------------------------
//Block 326, LSLICE 3

  assign net_561 = (~net_957 & ~net_1468 & ~net_1056 & (~(net_1276 & net_1333))) | (~net_957 & ~net_1468 & net_1056 & (~(net_1276 & net_1333))) | (~net_957 & net_1468 & ~net_1056 & (~(net_1276 & net_1333)));
  assign net_567 = (net_348 & ~net_1047 & ~net_1525 & ((net_571 & net_561))) | (net_348 & ~net_1047 & net_1525 & ((net_571 & net_561))) | (net_348 & net_1047 & ~net_1525 & ((net_571 & net_561)));

//---------------------------------------------------------------------------
//Block 327, MSLICE 1

  assign net_568 = (net_1289 & net_847 & ((net_943 | net_961)));
  assign net_564 = ((net_1289 & net_943));

//---------------------------------------------------------------------------
//Block 328, LSLICE 2

  assign net_571 = (~net_352 & (~(net_1648 & net_1528)));
  assign net_570 = (net_836 & ((~net_829 & net_567)));

//---------------------------------------------------------------------------
//Block 329, MSLICE 1

  assign net_572 = (net_480 & net_681 & ((~net_1161 & ~net_1068)));
  assign net_569 = (net_846 & net_490 & ((~net_475 & ~net_968)));

//---------------------------------------------------------------------------
//Block 330, LSLICE 3

  assign net_574 = (net_848 & ~net_573 & ~net_1302 & ((net_961 & ~net_687))) | (net_848 & ~net_573 & net_1302 & ((~net_961 & ~net_687) | (net_961 & ~net_687))) | (net_848 & net_573 & ~net_1302 & ((~net_961 & ~net_687) | (net_961 & ~net_687))) | (net_848 & net_573 & net_1302 & ((~net_961 & ~net_687) | (net_961 & ~net_687)));
  assign net_573 = (~net_1528 & ~net_1303 & ((~net_670 & ~net_1047)));

//---------------------------------------------------------------------------
//Block 331, MSLICE 0

  assign sig_331_lut_0 = 1'b0;
  assign sig_331_lut_1 = (net_563 & net_495 & ((net_860 & net_489)));
  assign net_578 = (~net_686 & sig_331_lut_0) | (net_686 & sig_331_lut_1);

//---------------------------------------------------------------------------
//Block 332, LSLICE 2

  assign net_575 = (~net_499 & ~net_853 & ~net_1155 & (~(net_950 & net_564))) | (~net_499 & ~net_853 & net_1155 & (~(net_950 & net_564))) | (~net_499 & net_853 & ~net_1155 & (~(net_950 & net_564)));
  assign net_580 = (net_850 & net_575 & net_682 & ((net_497 & net_495)));

//---------------------------------------------------------------------------
//Block 333, LSLICE 3

  assign net_576 = (net_852 & net_682 & ~net_851 & (~(net_1329 & net_966)));
  assign net_582 = (net_349 & ~net_1065 & ~net_487 & (~(net_342 & ~net_576))) | (net_349 & ~net_1065 & net_487 & ((~net_342 & ~net_576) | (~net_342 & net_576))) | (net_349 & net_1065 & ~net_487 & ((~net_342 & ~net_576) | (~net_342 & net_576))) | (net_349 & net_1065 & net_487 & ((~net_342 & ~net_576) | (~net_342 & net_576)));

//---------------------------------------------------------------------------
//Block 334, MSLICE 1

  assign net_581 = (~net_247 & ((net_1303 & net_1525)));
  assign net_579 = (net_1289 & ~net_274) | (net_1289 & net_274 & ((~net_586 & net_1525)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_577 <= 1'b1;
    end
    else
    begin
      if(net_581 == 1'b1)   //enable
       begin
        net_577 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 335, MSLICE 0

  assign net_584 = ((net_1289 & net_961));
  assign net_588 = ((net_962 & net_584));

//---------------------------------------------------------------------------
//Block 336, LSLICE 2

  assign sig_336_lut_0 = (~net_344 & ~i_mcu_dcs & ~io_mcu_d[0] & ((~net_793 & net_583) | (net_793 & net_583))) | (~net_344 & ~i_mcu_dcs & io_mcu_d[0] & ((~net_793 & net_583) | (net_793 & net_583))) | (~net_344 & i_mcu_dcs & ~io_mcu_d[0] & (~(net_793 & ~net_583))) | (~net_344 & i_mcu_dcs & io_mcu_d[0] & (~(net_793 & ~net_583))) | (net_344 & ~i_mcu_dcs & io_mcu_d[0] & (~(net_793 & ~net_583))) | (net_344 & i_mcu_dcs & ~io_mcu_d[0] & (~(net_793 & ~net_583))) | (net_344 & i_mcu_dcs & io_mcu_d[0] & (~(net_793 & ~net_583)));
  assign net_586 = (~net_362 & ~net_583 & ~net_587) | (~net_362 & net_583 & ~net_587 & ((~net_962 & ~net_862) | (~net_962 & net_862))) | (net_362 & ~net_583 & ~net_587 & ((~net_962 & ~net_862) | (net_962 & ~net_862))) | (net_362 & net_583 & ~net_587 & ((~net_962 & ~net_862)));

  always @(posedge gclk_9)
  begin
    net_583 <= sig_336_lut_0;
  end

//---------------------------------------------------------------------------
//Block 337, MSLICE 1

  assign net_587 = (net_1078 & ~net_1301 & ((net_280 & ~net_364) | (net_280 & net_364))) | (net_1078 & net_1301 & ((~net_280 & net_364) | (net_280 & net_364)));
  assign net_585 = ((~net_1301 & net_1078));

//---------------------------------------------------------------------------
//Block 338, LSLICE 3

  assign sig_338_lut_0 = (~io_mcu_d[0] & ~net_343 & ~i_mcu_dcs & ((~net_793 & net_589) | (net_793 & net_589))) | (~io_mcu_d[0] & ~net_343 & i_mcu_dcs & ((net_793 & net_589))) | (~io_mcu_d[0] & net_343 & ~i_mcu_dcs & ((net_793 & net_589))) | (~io_mcu_d[0] & net_343 & i_mcu_dcs & ((net_793 & net_589))) | (io_mcu_d[0] & ~net_343 & ~i_mcu_dcs & ((~net_793 & net_589) | (net_793 & net_589))) | (io_mcu_d[0] & ~net_343 & i_mcu_dcs & ((net_793 & net_589))) | (io_mcu_d[0] & net_343 & ~i_mcu_dcs) | (io_mcu_d[0] & net_343 & i_mcu_dcs & ((net_793 & net_589)));
  assign net_590 = (net_1333 & ((net_589 & net_585)));

  always @(posedge gclk_9)
  begin
    net_589 <= sig_338_lut_0;
  end

//---------------------------------------------------------------------------
//Block 339, LSLICE 2

  assign net_592 = ((net_1301 & net_1078));
  assign net_593 = (net_360 & ((net_592 & net_668)));

//---------------------------------------------------------------------------
//Block 340, LSLICE 3

  assign sig_340_lut_0 = (~io_mcu_d[1] & ~net_343 & ~i_mcu_dcs & ((~net_793 & net_591) | (net_793 & net_591))) | (~io_mcu_d[1] & ~net_343 & i_mcu_dcs & ((net_793 & net_591))) | (~io_mcu_d[1] & net_343 & ~i_mcu_dcs & ((net_793 & net_591))) | (~io_mcu_d[1] & net_343 & i_mcu_dcs & ((net_793 & net_591))) | (io_mcu_d[1] & ~net_343 & ~i_mcu_dcs & ((~net_793 & net_591) | (net_793 & net_591))) | (io_mcu_d[1] & ~net_343 & i_mcu_dcs & ((net_793 & net_591))) | (io_mcu_d[1] & net_343 & ~i_mcu_dcs) | (io_mcu_d[1] & net_343 & i_mcu_dcs & ((net_793 & net_591)));
  assign net_594 = (~net_591 & ~net_596) | (~net_591 & net_596 & ((~net_843 & ~net_952) | (~net_843 & net_952))) | (net_591 & ~net_596 & ((~net_843 & ~net_952) | (net_843 & ~net_952))) | (net_591 & net_596 & ((~net_843 & ~net_952)));

  always @(posedge gclk_9)
  begin
    net_591 <= sig_340_lut_0;
  end

//---------------------------------------------------------------------------
//Block 341, MSLICE 1

  assign sig_341_lut_0 = 1'b0;
  assign sig_341_lut_1 = (~net_597 & ~net_1521 & ((net_504 & net_1523))) | (~net_597 & net_1521 & ((net_504 & net_1523))) | (net_597 & ~net_1521 & ((net_504 & net_1523))) | (net_597 & net_1521);
  assign net_595 = (~net_862 & sig_341_lut_0) | (net_862 & sig_341_lut_1);

//---------------------------------------------------------------------------
//Block 342, LSLICE 2

  assign sig_342_lut_0 = (~io_mcu_d[6] & ~net_343 & ~i_mcu_dcs & ((~net_793 & net_596) | (net_793 & net_596))) | (~io_mcu_d[6] & ~net_343 & i_mcu_dcs & ((net_793 & net_596))) | (~io_mcu_d[6] & net_343 & ~i_mcu_dcs & ((net_793 & net_596))) | (~io_mcu_d[6] & net_343 & i_mcu_dcs & ((net_793 & net_596))) | (io_mcu_d[6] & ~net_343 & ~i_mcu_dcs & ((~net_793 & net_596) | (net_793 & net_596))) | (io_mcu_d[6] & ~net_343 & i_mcu_dcs & ((net_793 & net_596))) | (io_mcu_d[6] & net_343 & ~i_mcu_dcs) | (io_mcu_d[6] & net_343 & i_mcu_dcs & ((net_793 & net_596)));
  assign sig_342_lut_1 = (~net_343 & ~i_mcu_dcs & ~io_mcu_d[4] & ((~net_793 & net_597) | (net_793 & net_597))) | (~net_343 & ~i_mcu_dcs & io_mcu_d[4] & ((~net_793 & net_597) | (net_793 & net_597))) | (~net_343 & i_mcu_dcs & ~io_mcu_d[4] & (~(net_793 & ~net_597))) | (~net_343 & i_mcu_dcs & io_mcu_d[4] & (~(net_793 & ~net_597))) | (net_343 & ~i_mcu_dcs & io_mcu_d[4] & (~(net_793 & ~net_597))) | (net_343 & i_mcu_dcs & ~io_mcu_d[4] & (~(net_793 & ~net_597))) | (net_343 & i_mcu_dcs & io_mcu_d[4] & (~(net_793 & ~net_597)));

  always @(posedge gclk_9)
  begin
    net_596 <= sig_342_lut_0;
    net_597 <= sig_342_lut_1;
  end

//---------------------------------------------------------------------------
//Block 347, LSLICE 2

  assign net_606 = (~net_775 & ~net_599 & ~net_601 & (~(net_752 & ~net_598))) | (~net_775 & net_599 & ~net_601 & (~(net_752 & ~net_598))) | (net_775 & net_599 & ~net_601 & (~(net_752 & ~net_598)));
  assign net_604 = (~net_610 & ~net_775 & ((~net_745 & ~net_599) | (net_745 & ~net_599))) | (~net_610 & net_775) | (net_610 & ~net_775 & ((net_745 & ~net_599))) | (net_610 & net_775 & ((net_745 & ~net_599) | (net_745 & net_599)));

  always @(posedge gclk_9)
  begin
    if(net_612 == 1'b1)   //enable
     begin
      net_598 <= io_mcu_d[4];
      net_599 <= io_mcu_d[5];
    end
  end

//---------------------------------------------------------------------------
//Block 348, LSLICE 3

  assign net_603 = (~net_773 & ~net_602 & ~net_615 & ((~net_747 & ~net_600) | (~net_747 & net_600))) | (~net_773 & ~net_602 & net_615 & ((~net_747 & net_600))) | (~net_773 & net_602 & ~net_615) | (~net_773 & net_602 & net_615 & ((~net_747 & net_600) | (net_747 & net_600))) | (net_773 & ~net_602 & ~net_615 & ((~net_747 & net_600))) | (net_773 & net_602 & ~net_615 & ((~net_747 & net_600) | (net_747 & net_600)));
  assign net_601 = (~net_752 & ~net_747 & ~net_598 & ((~net_602 & ~net_603))) | (~net_752 & net_747 & ~net_598 & ((~net_602 & ~net_603) | (net_602 & ~net_603))) | (net_752 & ~net_747 & ~net_598 & ((~net_602 & ~net_603))) | (net_752 & ~net_747 & net_598 & ((~net_602 & ~net_603))) | (net_752 & net_747 & ~net_598 & ((~net_602 & ~net_603) | (net_602 & ~net_603))) | (net_752 & net_747 & net_598 & ((~net_602 & ~net_603) | (net_602 & ~net_603)));

  always @(posedge gclk_9)
  begin
    if(net_612 == 1'b1)   //enable
     begin
      net_600 <= io_mcu_d[2];
      net_602 <= io_mcu_d[3];
    end
  end

//---------------------------------------------------------------------------
//Block 349, MSLICE 1

  always @(posedge gclk_5)
  begin
    if(net_880 == 1'b1)   //reset
    begin
      net_605 <= 1'b0;
    end
    else
    begin
      net_605 <= net_763;
    end
  end

//---------------------------------------------------------------------------
//Block 350, LSLICE 2

  assign net_611 = (~net_613 & ~net_767 & ~net_606 & ((net_604 & ~net_608))) | (~net_613 & net_767 & ~net_606 & (~(~net_604 & net_608))) | (~net_613 & net_767 & net_606 & ((~net_604 & ~net_608) | (net_604 & ~net_608))) | (net_613 & ~net_767 & ~net_606 & ((~net_604 & ~net_608) | (net_604 & ~net_608))) | (net_613 & ~net_767 & net_606 & ((~net_604 & ~net_608) | (net_604 & ~net_608))) | (net_613 & net_767 & ~net_606) | (net_613 & net_767 & net_606);
  assign net_613 = ((net_745 & ~net_610));

  always @(posedge gclk_9)
  begin
    if(net_612 == 1'b1)   //enable
     begin
      net_608 <= io_mcu_d[7];
      net_610 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 351, LSLICE 3

  assign net_612 = (net_452 & ((net_1141 & net_524)));
  assign net_615 = (~net_749 & ~net_609 & (~(~net_748 & net_607))) | (~net_749 & net_609 & ((net_748 & ~net_607))) | (net_749 & ~net_609 & (~(~net_748 & net_607))) | (net_749 & net_609 & (~(~net_748 & net_607)));

  always @(posedge gclk_9)
  begin
    if(net_612 == 1'b1)   //enable
     begin
      net_609 <= io_mcu_d[0];
      net_607 <= io_mcu_d[1];
    end
  end

//---------------------------------------------------------------------------
//Block 352, MSLICE 1

  assign sig_352_lut_0 = (~net_1044 & ~net_904) | (~net_1044 & net_904 & ((~net_697 & ~net_705) | (~net_697 & net_705))) | (net_1044 & ~net_904) | (net_1044 & net_904 & ((~net_697 & ~net_705) | (net_697 & ~net_705)));
  assign sig_352_lut_1 = 1'b0;
  assign net_614 = (~net_189 & sig_352_lut_0) | (net_189 & sig_352_lut_1);

//---------------------------------------------------------------------------
//MSLICE adder blocks 353, 354, 355

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b0)   //reset
    begin
      { net_620, net_616, net_618, net_617 } <= { 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      { net_620, net_616, net_618, net_617 } <= { net_620, net_616, net_618, net_617 } + { 1'b0, 1'b0, 1'b0, 1'b1 };
    end
  end

//---------------------------------------------------------------------------
//Block 356, LSLICE 2

  assign net_624 = (~net_147 & (~(net_873 & net_516))) | (net_147 & ((~net_873 & net_516)));
  assign net_623 = (~net_516 & ((~net_1212 & ~net_85) | (net_1212 & ~net_85))) | (net_516 & ((~net_1212 & ~net_85) | (~net_1212 & net_85)));

//---------------------------------------------------------------------------
//Block 357, LSLICE 3

  assign net_622 = (~net_605 & ~net_621 & ~net_611 & ((~net_744 & ~net_619) | (~net_744 & net_619))) | (~net_605 & ~net_621 & net_611 & ((~net_744 & net_619))) | (~net_605 & net_621 & ~net_611) | (~net_605 & net_621 & net_611 & ((~net_744 & net_619) | (net_744 & net_619))) | (net_605 & ~net_621 & ~net_611 & ((~net_744 & net_619))) | (net_605 & net_621 & ~net_611 & ((~net_744 & net_619) | (net_744 & net_619)));
  assign net_625 = (~net_761 & ~net_744 & ~net_621 & ((~net_777 & ~net_622))) | (~net_761 & net_744 & ~net_621 & ((~net_777 & ~net_622))) | (~net_761 & net_744 & net_621 & ((~net_777 & ~net_622))) | (net_761 & ~net_744 & ~net_621 & ((~net_777 & ~net_622) | (net_777 & ~net_622))) | (net_761 & net_744 & ~net_621 & ((~net_777 & ~net_622) | (net_777 & ~net_622))) | (net_761 & net_744 & net_621 & ((~net_777 & ~net_622) | (net_777 & ~net_622)));

  always @(posedge gclk_9)
  begin
    if(net_779 == 1'b1)   //enable
     begin
      net_619 <= io_mcu_d[0];
      net_621 <= io_mcu_d[1];
    end
  end

//---------------------------------------------------------------------------
//Block 358, MSLICE 1

  assign sig_358_lut_0 = 1'b0;
  assign sig_358_lut_1 = (~net_181 & ~net_180 & ((~net_873 & net_147) | (net_873 & net_147))) | (net_181 & ~net_180 & ((net_873 & ~net_147) | (net_873 & net_147)));
  assign net_626 = (~net_896 & sig_358_lut_0) | (net_896 & sig_358_lut_1);

//---------------------------------------------------------------------------
//Block 359, MSLICE 0

  assign net_633 = (net_896 & net_146 & ((~net_181 & ~net_180)));
  assign net_630 = (~net_516 & ((~net_874 & ~net_146) | (net_874 & ~net_146))) | (net_516 & ((~net_874 & ~net_146) | (~net_874 & net_146)));

//---------------------------------------------------------------------------
//Block 360, LSLICE 2

  assign net_628 = (~net_180 & net_161 & ((~net_181 & net_896)));
  assign net_631 = (~net_516 & ((~net_1083 & ~net_161) | (net_1083 & ~net_161))) | (net_516 & ((~net_1083 & ~net_161) | (~net_1083 & net_161)));

//---------------------------------------------------------------------------
//Block 361, MSLICE 1

  assign sig_361_lut_0 = (~net_618 & ~net_620 & ((~net_616 & net_627) | (net_616 & net_627))) | (~net_618 & net_620) | (net_618 & ~net_620 & ((net_616 | net_627))) | (net_618 & net_620);
  assign net_629 = (~net_719 & (~(~net_1044 & net_709))) | (net_719 & ((~net_1044 & ~net_709)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b0)   //reset
    begin
      net_627 <= 1'b0;
    end
    else
    begin
      net_627 <= sig_361_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 362, LSLICE 3

  assign net_634 = (net_1507 & net_446 & net_1263 & ((~net_1508 & ~net_1264)));
  assign net_632 = (net_447 & ~net_525 & ((~net_517 & ~net_524)));

  always @(posedge gclk_9)
  begin
    if(net_634 == 1'b1)   //enable
     begin
      net_635 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 363, MSLICE 0

  assign net_637 = (net_896 & net_86 & ((~net_181 & ~net_180)));
  assign net_636 = (~net_642 & (~(~net_516 & net_86))) | (net_642 & ((~net_516 & ~net_86)));

//---------------------------------------------------------------------------
//Block 364, LSLICE 3

  assign net_641 = (~io_mcu_d[3] & ~io_mcu_d[4] & ~io_mcu_d[5] & ((~io_mcu_d[6] & ~io_mcu_d[7])));
  assign net_640 = (net_1263 & ~net_1508 & ~net_1264 & ((net_446 & ~net_1507)));

  always @(posedge gclk_9)
  begin
    if(net_640 == 1'b1)   //enable
     begin
      net_638 <= io_mcu_d[3];
      net_639 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 365, MSLICE 1

  assign sig_365_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_712 & ~net_722) | (net_712 & net_722))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_712 & net_722) | (net_712 & net_722)));
  assign sig_365_lut_1 = 1'b0;
  assign net_642 = (~net_664 & sig_365_lut_0) | (net_664 & sig_365_lut_1);

//---------------------------------------------------------------------------
//Block 366, MSLICE 0

  assign net_648 = (net_1111 & net_647 & ((net_180 & ~net_181)));
  assign net_652 = (~net_180 & ~net_181 & ((net_1111 & net_315)));

//---------------------------------------------------------------------------
//Block 367, LSLICE 2

  assign net_649 = (net_1010 & ~net_647) | (net_1010 & net_647 & (~(~net_181 & net_643)));
  assign net_647 = (net_530 & ~net_314 & ((net_531 & ~net_645)));

  always @(posedge gclk_9)
  begin
    if(net_184 == 1'b1)   //enable
     begin
      net_643 <= io_mcu_d[3];
      net_645 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 368, LSLICE 3

  assign net_646 = (net_309 & ~net_181 & ~net_643 & ((net_180 & net_644))) | (net_309 & net_181 & net_643 & ((~net_180 & ~net_644)));
  assign net_650 = (~net_652 & ~net_436 & net_1341 & ((net_911 & ~net_646)));

  always @(posedge gclk_9)
  begin
    if(net_184 == 1'b1)   //enable
     begin
      net_644 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 369, MSLICE 1

  assign sig_369_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((~net_713 & ~net_724) | (~net_713 & net_724))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_713 & ~net_724) | (net_713 & ~net_724)));
  assign sig_369_lut_1 = 1'b0;
  assign net_651 = (~net_657 & sig_369_lut_0) | (net_657 & sig_369_lut_1);

//---------------------------------------------------------------------------
//Block 370, MSLICE 0

  assign sig_370_lut_0 = 1'b0;
  assign sig_370_lut_1 = (~net_181 & ~net_180 & ((~net_1555 & net_179) | (net_1555 & net_179))) | (net_181 & net_180 & ((net_1555 & ~net_179) | (net_1555 & net_179)));
  assign net_653 = (~net_896 & sig_370_lut_0) | (net_896 & sig_370_lut_1);

//---------------------------------------------------------------------------
//Block 371, LSLICE 2

  assign net_657 = (~net_731 & ~net_1044 & ((net_742 & ~net_189))) | (net_731 & ~net_1044 & ((net_742 & ~net_189))) | (net_731 & net_1044 & ((~net_742 & ~net_189) | (net_742 & ~net_189)));
  assign net_658 = (~net_732 & ~net_741 & ((~net_189 & ~net_1044) | (~net_189 & net_1044))) | (~net_732 & net_741 & ((~net_189 & net_1044))) | (net_732 & ~net_741 & ((~net_189 & ~net_1044)));

//---------------------------------------------------------------------------
//Block 372, LSLICE 3

  assign net_661 = (~net_323 & ~net_656 & ~net_439) | (~net_323 & ~net_656 & net_439 & ((net_1283 & ~net_655))) | (~net_323 & net_656 & ~net_439) | (~net_323 & net_656 & net_439);
  assign net_656 = (~net_1141 & ~net_927 & ((~net_1283 & ~net_262))) | (~net_1141 & net_927 & ((~net_1283 & ~net_262))) | (net_1141 & ~net_927 & ((~net_1283 & ~net_262) | (~net_1283 & net_262)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_655 <= 1'b0;
    end
    else
    begin
      if(net_1291 == 1'b1)   //enable
       begin
        net_655 <= net_1288;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 373, MSLICE 1

  assign net_660 = (net_943 & ((~net_247 & net_670)));
  assign net_659 = (~net_654 & ~net_648 & (~(net_987 & net_905))) | (~net_654 & net_648 & (~(net_987 & net_905))) | (net_654 & ~net_648 & (~(net_987 & net_905)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_654 <= 1'b0;
    end
    else
    begin
      if(net_660 == 1'b1)   //enable
       begin
        net_654 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 374, MSLICE 0

  assign net_666 = (~net_1044 & ~net_189 & ((net_737 & ~net_729) | (net_737 & net_729))) | (net_1044 & ~net_189 & ((~net_737 & net_729) | (net_737 & net_729)));
  assign net_664 = (~net_189 & ~net_1044 & ((~net_738 & ~net_728) | (~net_738 & net_728))) | (~net_189 & net_1044 & ((~net_738 & ~net_728) | (net_738 & ~net_728)));

//---------------------------------------------------------------------------
//Block 375, LSLICE 2

  assign sig_375_lut_0 = (~i_mcu_rws & ~i_mcu_dcs & ~net_662 & ((~net_181 & ~net_663) | (net_181 & ~net_663))) | (~i_mcu_rws & ~i_mcu_dcs & net_662 & ((~net_181 & ~net_663) | (net_181 & ~net_663))) | (~i_mcu_rws & i_mcu_dcs & ~net_662 & ((net_181 & ~net_663) | (net_181 & net_663))) | (~i_mcu_rws & i_mcu_dcs & net_662 & ((net_181 & ~net_663) | (net_181 & net_663))) | (i_mcu_rws & ~i_mcu_dcs & net_662) | (i_mcu_rws & i_mcu_dcs & net_662);
  assign net_663 = (net_803 & ~net_662 & ((net_810 & ~net_1341) | (net_810 & net_1341))) | (net_803 & net_662 & ((net_810 & ~net_1341)));

  always @(posedge gclk_9)
  begin
    net_662 <= sig_375_lut_0;
  end

//---------------------------------------------------------------------------
//Block 376, MSLICE 1

  assign sig_376_lut_0 = (~net_1113 & ~net_669) | (~net_1113 & net_669) | (net_1113 & ~net_669);
  assign sig_376_lut_1 = (~net_1113 & ~net_669 & ((~net_1141 & ~net_662))) | (~net_1113 & net_669 & ((~net_1141 & ~net_662))) | (net_1113 & ~net_669 & ((~net_1141 & ~net_662)));
  assign net_665 = (~net_916 & sig_376_lut_0) | (net_916 & sig_376_lut_1);

//---------------------------------------------------------------------------
//Block 377, MSLICE 0

  assign net_667 = ((net_1161 & net_920));
  assign net_668 = ((net_1289 & net_1161));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_669 <= 1'b1;
    end
    else
    begin
      if(net_667 == 1'b1)   //enable
       begin
        net_669 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 378, LSLICE 2

  assign net_673 = (net_929 & ((net_951 & ~net_247)));
  assign net_670 = ((net_929 & net_1289));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_671 <= 1'b1;
    end
    else
    begin
      if(net_673 == 1'b1)   //enable
       begin
        net_671 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 379, MSLICE 1

  assign sig_379_lut_0 = (~net_829 & net_841 & (~(net_1067 & net_1333)));
  assign sig_379_lut_1 = 1'b0;
  assign net_672 = (~net_949 & sig_379_lut_0) | (net_949 & sig_379_lut_1);

//---------------------------------------------------------------------------
//Block 380, MSLICE 0

  assign net_675 = (~net_247 & ((net_1521 & net_929)));
  assign net_674 = (~net_951 & ~net_843 & ((net_1299 & net_1521))) | (~net_951 & net_843 & ((~net_1299 & net_1521) | (net_1299 & net_1521))) | (net_951 & ~net_843 & ((net_1299 & net_1521))) | (net_951 & net_843);

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_676 <= 1'b1;
    end
    else
    begin
      if(net_675 == 1'b1)   //enable
       begin
        net_676 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 381, MSLICE 1

  assign sig_381_lut_0 = (~net_670 & ~net_1047 & (~(net_1057 & ~net_1532))) | (~net_670 & net_1047 & (~(net_1057 & ~net_1532))) | (net_670 & ~net_1047 & (~(net_1057 & ~net_1532))) | (net_670 & net_1047 & (~(net_1057 & ~net_1532)));
  assign sig_381_lut_1 = (~net_1047 & ~net_670 & (~(net_1057 & ~net_1532)));
  assign net_677 = (~net_961 & sig_381_lut_0) | (net_961 & sig_381_lut_1);

//---------------------------------------------------------------------------
//Block 382, LSLICE 2

  assign net_680 = (~net_334 & net_955 & net_677 & ((net_563 & net_679)));
  assign net_679 = (~net_857 & net_854 & ((net_1532 & ~net_965))) | (net_857 & net_854 & ((~net_1532 & ~net_965) | (net_1532 & ~net_965)));

//---------------------------------------------------------------------------
//Block 383, LSLICE 3

  assign net_678 = (~net_965 & ~net_952 & ~net_1032 & (~(net_863 & net_584))) | (~net_965 & ~net_952 & net_1032 & (~(net_863 & net_584))) | (~net_965 & net_952 & ~net_1032 & (~(net_863 & net_584)));
  assign net_682 = (net_500 & ~net_962 & ((~net_951 & net_678) | (net_951 & net_678))) | (net_500 & net_962 & ((~net_951 & net_678)));

//---------------------------------------------------------------------------
//Block 384, MSLICE 1

  assign sig_384_lut_0 = (~net_851 & ~net_1302) | (~net_851 & net_1302 & (~(net_963 & net_470)));
  assign sig_384_lut_1 = 1'b0;
  assign net_681 = (~net_969 & sig_384_lut_0) | (net_969 & sig_384_lut_1);

//---------------------------------------------------------------------------
//Block 385, MSLICE 0

  assign sig_385_lut_0 = (~net_970 & ~net_1068 & ((net_1032 | net_496))) | (~net_970 & net_1068) | (net_970 & ~net_1068) | (net_970 & net_1068);
  assign sig_385_lut_1 = 1'b0;
  assign net_687 = (~net_1532 & sig_385_lut_0) | (net_1532 & sig_385_lut_1);

//---------------------------------------------------------------------------
//Block 386, LSLICE 2

  assign net_686 = (~net_1300 & ~net_964 & ((~net_1532 & ~net_684) | (net_1532 & ~net_684))) | (net_1300 & ~net_964 & ((net_1532 & ~net_684))) | (net_1300 & net_964 & ((net_1532 & ~net_684)));
  assign net_684 = ((net_592 & net_1468));

//---------------------------------------------------------------------------
//Block 387, LSLICE 3

  assign sig_387_lut_0 = (~io_mcu_d[7] & ~net_265 & ~i_mcu_dcs & ((~net_793 & net_683) | (net_793 & net_683))) | (~io_mcu_d[7] & ~net_265 & i_mcu_dcs & ((net_793 & net_683))) | (~io_mcu_d[7] & net_265 & ~i_mcu_dcs & ((net_793 & net_683))) | (~io_mcu_d[7] & net_265 & i_mcu_dcs & ((net_793 & net_683))) | (io_mcu_d[7] & ~net_265 & ~i_mcu_dcs & ((~net_793 & net_683) | (net_793 & net_683))) | (io_mcu_d[7] & ~net_265 & i_mcu_dcs & ((net_793 & net_683))) | (io_mcu_d[7] & net_265 & ~i_mcu_dcs) | (io_mcu_d[7] & net_265 & i_mcu_dcs & ((net_793 & net_683)));
  assign net_685 = (net_966 & ~net_683 & ~net_1648 & ((net_689 & net_964))) | (net_966 & ~net_683 & net_1648 & ((net_689 & net_964))) | (net_966 & net_683 & ~net_1648 & ((net_689 & net_964))) | (net_966 & net_683 & net_1648);

  always @(posedge gclk_9)
  begin
    net_683 <= sig_387_lut_0;
  end

//---------------------------------------------------------------------------
//Block 388, MSLICE 0

  assign sig_388_lut_0 = (net_1060 & net_1301 & (~(net_1532 & ~net_1300)));
  assign sig_388_lut_1 = (~net_1300 & ~net_1301 & ((net_1060 & ~net_1532) | (net_1060 & net_1532))) | (~net_1300 & net_1301 & ((net_1060 & ~net_1532) | (net_1060 & net_1532))) | (net_1300 & ~net_1301 & ((net_1060 & ~net_1532) | (net_1060 & net_1532))) | (net_1300 & net_1301 & ((net_1060 & ~net_1532) | (net_1060 & net_1532)));
  assign net_688 = (~net_1299 & sig_388_lut_0) | (net_1299 & sig_388_lut_1);

//---------------------------------------------------------------------------
//Block 389, MSLICE 1

  assign sig_389_lut_0 = (net_265 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[5]) | (net_793 & io_mcu_d[5])));
  assign sig_389_lut_1 = (~net_793 & ~i_mcu_dcs & (~(net_265 & ~io_mcu_d[5]))) | (net_793 & ~i_mcu_dcs) | (net_793 & i_mcu_dcs);
  assign sig_389_ff0_d = (~net_689 & sig_389_lut_0) | (net_689 & sig_389_lut_1);

  always @(posedge gclk_9)
  begin
    net_689 <= sig_389_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 411, LSLICE 3

  always @(posedge gclk_5)
  begin
    if(net_880 == 1'b1)   //reset
    begin
      net_744 <= 1'b0;
      net_745 <= 1'b0;
    end
    else
    begin
      net_744 <= net_764;
      net_745 <= net_755;
    end
  end

//---------------------------------------------------------------------------
//Block 412, MSLICE 0

  assign sig_412_lut_0 = (~net_994 & ~net_511 & ((~net_759 & net_746) | (net_759 & net_746))) | (~net_994 & net_511 & ((~net_759 & net_746) | (net_759 & net_746))) | (net_994 & ~net_511 & ((net_759 & ~net_746) | (net_759 & net_746))) | (net_994 & net_511 & ((net_759 & ~net_746) | (net_759 & net_746)));
  assign sig_412_lut_1 = (~net_746 & ~net_511) | (net_746 & ~net_511);
  assign sig_412_ff0_d = (~net_445 & sig_412_lut_0) | (net_445 & sig_412_lut_1);

  always @(posedge gclk_4)
  begin
    net_746 <= sig_412_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 413, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_880 == 1'b1)   //reset
    begin
      net_749 <= 1'b0;
      net_748 <= 1'b0;
    end
    else
    begin
      net_749 <= net_758;
      net_748 <= net_753;
    end
  end

//---------------------------------------------------------------------------
//Block 414, LSLICE 3

  always @(posedge gclk_5)
  begin
    if(net_880 == 1'b1)   //reset
    begin
      net_747 <= 1'b0;
      net_752 <= 1'b0;
    end
    else
    begin
      net_747 <= net_757;
      net_752 <= net_754;
    end
  end

//---------------------------------------------------------------------------
//Block 416, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_880 == 1'b1)   //reset
    begin
      net_761 <= 1'b0;
      net_767 <= 1'b0;
    end
    else
    begin
      net_761 <= net_771;
      net_767 <= net_768;
    end
  end

//---------------------------------------------------------------------------
//Block 417, LSLICE 3

  always @(posedge gclk_5)
  begin
    if(net_880 == 1'b1)   //reset
    begin
      net_760 <= 1'b0;
      net_762 <= 1'b0;
    end
    else
    begin
      net_760 <= net_770;
      net_762 <= net_765;
    end
  end

//---------------------------------------------------------------------------
//Block 419, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_880 == 1'b1)   //reset
    begin
      net_772 <= 1'b0;
      net_773 <= 1'b0;
    end
    else
    begin
      net_772 <= net_774;
      net_773 <= net_751;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 413, 414, 416, 417, 419

  assign { net_774, net_766, net_769, net_765, net_770, net_771, net_764, net_763, net_768, net_755, net_756, net_754, net_757, net_751, net_753, net_758 } = { net_772, net_877, net_878, net_762, net_760, net_761, net_744, net_605, net_767, net_745, net_775, net_752, net_747, net_773, net_748, net_749 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 415, MSLICE 1

  assign sig_415_lut_0 = (~net_1044 & ~net_904) | (~net_1044 & net_904 & ((~net_690 & ~net_702) | (~net_690 & net_702))) | (net_1044 & ~net_904) | (net_1044 & net_904 & ((~net_690 & ~net_702) | (net_690 & ~net_702)));
  assign sig_415_lut_1 = 1'b0;
  assign net_750 = (~net_189 & sig_415_lut_0) | (net_189 & sig_415_lut_1);

//---------------------------------------------------------------------------
//Block 418, MSLICE 1

  assign sig_418_lut_0 = (~net_994 & ~net_511 & ((~net_636 & net_759) | (net_636 & net_759))) | (~net_994 & net_511 & ((~net_636 & net_759) | (net_636 & net_759))) | (net_994 & ~net_511 & ((~net_636 & ~net_759) | (~net_636 & net_759))) | (net_994 & net_511 & ((~net_636 & ~net_759) | (~net_636 & net_759)));
  assign sig_418_lut_1 = (~net_759 & ~net_994 & ((~net_511 & ~net_636) | (~net_511 & net_636))) | (~net_759 & net_994 & ((~net_511 & ~net_636) | (~net_511 & net_636))) | (net_759 & ~net_994 & ((~net_511 & ~net_636) | (~net_511 & net_636))) | (net_759 & net_994 & ((~net_511 & ~net_636) | (~net_511 & net_636)));
  assign sig_418_ff0_d = (~net_445 & sig_418_lut_0) | (net_445 & sig_418_lut_1);

  always @(posedge gclk_4)
  begin
    net_759 <= sig_418_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 420, MSLICE 0

  assign sig_420_lut_0 = 1'b0;
  assign sig_420_lut_1 = (~net_160 & ~net_896) | (~net_160 & net_896) | (net_160 & ~net_896) | (net_160 & net_896 & ((net_180 | net_181)));
  assign net_780 = (~net_786 & sig_420_lut_0) | (net_786 & sig_420_lut_1);

//---------------------------------------------------------------------------
//Block 421, LSLICE 2

  assign net_782 = (net_745 & net_761 & ((net_752 | net_775)));
  assign net_778 = (~net_1349 & ((~net_312 & ~net_439)));

  always @(posedge gclk_5)
  begin
    if(net_880 == 1'b1)   //reset
    begin
      net_775 <= 1'b0;
    end
    else
    begin
      net_775 <= net_756;
    end
  end

//---------------------------------------------------------------------------
//Block 422, LSLICE 3

  assign net_784 = (~net_625 & ~net_777 & ~net_760 & ((~net_761 & ~net_776) | (~net_761 & net_776))) | (~net_625 & ~net_777 & net_760 & ((~net_761 & net_776))) | (~net_625 & net_777 & ~net_760) | (~net_625 & net_777 & net_760 & ((~net_761 & net_776) | (net_761 & net_776)));
  assign net_779 = (net_452 & ((net_524 & net_1283)));

  always @(posedge gclk_9)
  begin
    if(net_779 == 1'b1)   //enable
     begin
      net_776 <= io_mcu_d[3];
      net_777 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 423, MSLICE 1

  assign net_783 = (~net_1209 & (~(net_95 & ~net_516))) | (net_1209 & ((~net_95 & ~net_516)));
  assign net_781 = (~net_160 & (~(net_516 & net_787))) | (net_160 & ((net_516 & ~net_787)));

//---------------------------------------------------------------------------
//Block 424, MSLICE 0

  assign sig_424_lut_0 = (~net_436 & ~net_627) | (~net_436 & net_627 & (~(net_309 & net_319))) | (net_436 & ~net_627) | (net_436 & net_627 & (~(net_309 & net_319)));
  assign sig_424_lut_1 = (~net_319 & ~net_627 & ((~net_309 & ~net_436) | (net_309 & ~net_436))) | (~net_319 & net_627 & ((~net_309 & ~net_436) | (net_309 & ~net_436))) | (net_319 & ~net_627 & ((~net_309 & ~net_436) | (net_309 & ~net_436))) | (net_319 & net_627 & ((~net_309 & ~net_436)));
  assign net_786 = (~net_1062 & sig_424_lut_0) | (net_1062 & sig_424_lut_1);

//---------------------------------------------------------------------------
//Block 425, LSLICE 2

  assign sig_425_lut_0 = (~net_246 & ~net_306 & ~net_305) | (~net_246 & ~net_306 & net_305) | (~net_246 & net_306 & ~net_305 & ((net_301 & ~net_162))) | (~net_246 & net_306 & net_305);
  assign net_785 = (~net_1003 & net_1001 & net_1009 & ((net_1002 | net_1005))) | (net_1003 & net_1001 & net_1009);

  always @(posedge gclk_5)
  begin
    if(net_90 == 1'b0)   //enable
     begin
      net_788 <= sig_425_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 426, MSLICE 1

  assign sig_426_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_714 & ~net_725) | (net_714 & net_725))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_714 & net_725) | (net_714 & net_725)));
  assign sig_426_lut_1 = 1'b0;
  assign net_787 = (~net_658 & sig_426_lut_0) | (net_658 & sig_426_lut_1);

//---------------------------------------------------------------------------
//Block 427, LSLICE 3

  assign net_789 = (~net_546 & ~net_91 & ~net_523 & (~(net_904 & ~net_985))) | (~net_546 & net_91 & ~net_523 & (~(net_904 & ~net_985))) | (~net_546 & net_91 & net_523 & (~(net_904 & ~net_985)));
  assign net_790 = (net_804 & ~net_1348 & ~net_918 & ((~net_652 & net_789) | (net_652 & net_789))) | (net_804 & net_1348 & ~net_918 & ((~net_652 & net_789)));

//---------------------------------------------------------------------------
//Block 428, LSLICE 2

  assign net_795 = (net_913 & net_661 & net_797 & ((~net_529 & ~net_792)));
  assign net_792 = ((net_1083 & net_905));

//---------------------------------------------------------------------------
//Block 429, LSLICE 3

  assign net_793 = (~net_319 & i_mcu_dcs) | (net_319 & i_mcu_dcs & (~(i_mcu_rws & net_647)));
  assign net_794 = ((net_319 & net_536));

  always @(negedge gclk_4)
  begin
    net_799 <= i_adc1A_d[3];
  end

//---------------------------------------------------------------------------
//Block 430, MSLICE 1

  assign net_798 = (~net_247 & ((net_1161 & net_1047)));
  assign net_797 = (~net_791 & ~net_628 & ((~net_1113 & net_1345) | (net_1113 & net_1345))) | (net_791 & ~net_628 & ((~net_1113 & net_1345)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_791 <= 1'b0;
    end
    else
    begin
      if(net_798 == 1'b1)   //enable
       begin
        net_791 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 431, MSLICE 0

  assign sig_431_lut_0 = 1'b0;
  assign sig_431_lut_1 = (net_644 & net_181 & ((net_647 & ~net_180)));
  assign net_796 = (~net_643 & sig_431_lut_0) | (net_643 & sig_431_lut_1);

//---------------------------------------------------------------------------
//Block 432, MSLICE 0

  assign net_805 = (net_1468 & ((net_1276 & ~net_247)));
  assign net_804 = (~net_800 & ~net_648 & (~(net_787 & net_905))) | (~net_800 & net_648 & (~(net_787 & net_905))) | (net_800 & ~net_648 & (~(net_787 & net_905)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_800 <= 1'b0;
    end
    else
    begin
      if(net_805 == 1'b1)   //enable
       begin
        net_800 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 433, LSLICE 2

  assign net_802 = (net_1518 & ~net_932 & ~net_796 & (~(i_adc2A_d[1] & net_1251))) | (net_1518 & ~net_932 & net_796 & (~(i_adc2A_d[1] & net_1251))) | (net_1518 & net_932 & ~net_796 & (~(i_adc2A_d[1] & net_1251)));
  assign net_803 = (net_802 & net_537 & ((net_947 & net_665)));

  always @(negedge gclk_4)
  begin
    net_806 <= i_adc2A_d[1];
  end

//---------------------------------------------------------------------------
//Block 434, MSLICE 1

  assign net_807 = (net_801 & net_548 & (~(net_1041 & ~net_181)));
  assign net_801 = (net_1491 & net_1121 & ((net_915 & net_565)));

//---------------------------------------------------------------------------
//Block 435, LSLICE 3

  assign net_809 = (~net_1283 & ~net_1141 & ~net_458 & ((net_662 & ~net_808) | (net_662 & net_808))) | (~net_1283 & ~net_1141 & net_458 & ((net_662 & ~net_808) | (net_662 & net_808))) | (~net_1283 & net_1141 & ~net_458 & ((~net_662 & net_808) | (net_662 & net_808))) | (~net_1283 & net_1141 & net_458 & ((~net_662 & net_808) | (net_662 & net_808))) | (net_1283 & ~net_1141 & net_458) | (net_1283 & net_1141 & net_458);
  assign net_810 = (net_993 & ~net_312 & ~net_1160) | (net_993 & ~net_312 & net_1160 & ((~net_439 & ~net_809) | (~net_439 & net_809))) | (net_993 & net_312 & ~net_1160 & ((~net_439 & ~net_809) | (net_439 & ~net_809))) | (net_993 & net_312 & net_1160 & ((~net_439 & ~net_809)));

  always @(posedge gclk_9)
  begin
    if(net_535 == 1'b1)   //enable
     begin
      net_808 <= io_mcu_d[1];
    end
  end

//---------------------------------------------------------------------------
//Block 436, MSLICE 0

  assign net_820 = (~net_1244 & ~i_adc1A_d[7] & (~(net_828 & net_796))) | (~net_1244 & i_adc1A_d[7] & (~(net_828 & net_796))) | (net_1244 & ~i_adc1A_d[7] & (~(net_828 & net_796)));
  assign net_816 = ((net_796 & i_mcu_rws));

  always @(negedge gclk_4)
  begin
    net_819 <= i_adc1A_d[7];
  end

//---------------------------------------------------------------------------
//Block 437, LSLICE 2

  assign net_811 = (net_936 & ~net_941 & ~net_796 & (~(i_adc1B_d[5] & net_794))) | (net_936 & ~net_941 & net_796 & (~(i_adc1B_d[5] & net_794))) | (net_936 & net_941 & ~net_796 & (~(i_adc1B_d[5] & net_794)));
  assign net_814 = (net_811 & ~net_626 & ((net_813 & ~net_1030)));

  always @(negedge gclk_4)
  begin
    net_818 <= i_adc1B_d[5];
  end

//---------------------------------------------------------------------------
//Block 438, LSLICE 3

  assign net_813 = (net_557 & ~net_812 & ~net_648 & (~(net_1556 & net_904))) | (net_557 & ~net_812 & net_648 & (~(net_1556 & net_904))) | (net_557 & net_812 & ~net_648 & (~(net_1556 & net_904)));
  assign net_817 = (net_1047 & ((net_943 & ~net_247)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_812 <= 1'b0;
    end
    else
    begin
      if(net_817 == 1'b1)   //enable
       begin
        net_812 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 439, MSLICE 1

  assign sig_439_lut_0 = (~net_906 & ~net_1527 & (~(net_671 & net_547))) | (~net_906 & net_1527 & (~(net_671 & net_547))) | (net_906 & ~net_1527 & (~(net_671 & net_547)));
  assign sig_439_lut_1 = 1'b0;
  assign net_815 = (~net_465 & sig_439_lut_0) | (net_465 & sig_439_lut_1);

//---------------------------------------------------------------------------
//Block 440, MSLICE 0

  assign net_825 = (net_1038 & ((net_929 & ~net_247)));
  assign net_826 = ((net_1299 & net_1038));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_827 <= 1'b1;
    end
    else
    begin
      if(net_825 == 1'b1)   //enable
       begin
        net_827 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 441, LSLICE 2

  assign net_822 = (~net_1286 & ~net_1035 & ~net_312) | (~net_1286 & ~net_1035 & net_312 & ((net_1283 & ~net_821))) | (~net_1286 & net_1035 & ~net_312) | (~net_1286 & net_1035 & net_312);
  assign net_824 = (~net_547 & net_822 & ~net_946) | (~net_547 & net_822 & net_946 & ((~net_956 & ~net_906) | (net_956 & ~net_906))) | (net_547 & net_822 & ~net_946 & ((~net_956 & ~net_906) | (~net_956 & net_906))) | (net_547 & net_822 & net_946 & ((~net_956 & ~net_906)));

  always @(posedge gclk_9)
  begin
    if(net_454 == 1'b1)   //enable
     begin
      net_821 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 442, MSLICE 1

  assign sig_442_lut_0 = (net_265 & ~i_mcu_dcs & ((~net_793 & io_mcu_d[6]) | (net_793 & io_mcu_d[6])));
  assign sig_442_lut_1 = (~net_793 & ~i_mcu_dcs & (~(net_265 & ~io_mcu_d[6]))) | (net_793 & ~i_mcu_dcs) | (net_793 & i_mcu_dcs);
  assign sig_442_ff0_d = (~net_823 & sig_442_lut_0) | (net_823 & sig_442_lut_1);

  always @(posedge gclk_9)
  begin
    net_823 <= sig_442_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 443, LSLICE 3

  assign net_830 = (net_1303 & ((~net_247 & net_960)));
  assign net_829 = (~net_1289 & ~net_962 & ((net_1303 & net_960))) | (~net_1289 & net_962 & ((net_1303 & net_960))) | (net_1289 & ~net_962 & ((net_1303 & net_960))) | (net_1289 & net_962 & ((~net_1303 & net_960) | (net_1303 & net_960)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_828 <= 1'b0;
    end
    else
    begin
      if(net_830 == 1'b1)   //enable
       begin
        net_828 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 444, MSLICE 0

  assign net_837 = (~net_247 & ((net_1521 & net_847)));
  assign net_841 = (~net_952 & ~net_847 & ((~net_1525 & ~net_1521) | (~net_1525 & net_1521))) | (~net_952 & net_847 & ((~net_1525 & ~net_1521))) | (net_952 & ~net_847) | (net_952 & net_847 & ((~net_1525 & ~net_1521) | (net_1525 & ~net_1521)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_833 <= 1'b0;
    end
    else
    begin
      if(net_837 == 1'b1)   //enable
       begin
        net_833 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 445, LSLICE 2

  assign net_834 = (net_964 & ((~net_247 & net_1047)));
  assign net_836 = (~net_964 & net_846 & ((~net_1528 & ~net_684) | (net_1528 & ~net_684))) | (net_964 & net_846 & ((~net_1528 & ~net_684)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_835 <= 1'b0;
    end
    else
    begin
      if(net_834 == 1'b1)   //enable
       begin
        net_835 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 446, LSLICE 3

  assign net_842 = (net_1523 & ((net_847 & ~net_247)));
  assign net_838 = (~net_1523 & net_247 & ((~net_862 & ~net_352) | (net_862 & ~net_352))) | (net_1523 & net_247 & ((~net_862 & ~net_352)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_831 <= 1'b1;
    end
    else
    begin
      if(net_842 == 1'b1)   //enable
       begin
        net_831 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 447, MSLICE 1

  assign net_839 = ((net_920 & net_960));
  assign net_840 = (net_960 & ((net_952 & net_1289)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_832 <= 1'b0;
    end
    else
    begin
      if(net_839 == 1'b1)   //enable
       begin
        net_832 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 448, LSLICE 2

  assign net_844 = (~net_247 & ((net_1333 & net_1056)));
  assign net_846 = (~net_966 & ~net_1648 & (~(net_843 & net_1333))) | (~net_966 & net_1648 & (~(net_843 & net_1333))) | (net_966 & ~net_1648 & (~(net_843 & net_1333)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_845 <= 1'b0;
    end
    else
    begin
      if(net_844 == 1'b1)   //enable
       begin
        net_845 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 449, MSLICE 0

  assign net_843 = (net_1532 & net_1300 & ((~net_1299 & ~net_1301)));
  assign net_847 = (net_1300 & net_1301 & ((~net_1299 & ~net_1532)));

//---------------------------------------------------------------------------
//Block 450, MSLICE 1

  assign sig_450_lut_0 = 1'b0;
  assign sig_450_lut_1 = (~net_1066 & ~net_1276) | (~net_1066 & net_1276 & ((~net_584 & ~net_1060)));
  assign net_848 = (~net_1073 & sig_450_lut_0) | (net_1073 & sig_450_lut_1);

//---------------------------------------------------------------------------
//Block 451, LSLICE 3

  assign net_849 = ((net_1312 & net_1182));
  assign net_850 = (net_1192 & ~net_475 & ((net_480 & net_856)));

//---------------------------------------------------------------------------
//Block 452, MSLICE 0

  assign sig_452_lut_0 = 1'b0;
  assign sig_452_lut_1 = (~net_1300 & ~net_1301 & ((net_1299 & ~net_1532))) | (net_1300 & ~net_1301 & ((net_1299 & net_1532))) | (net_1300 & net_1301 & ((net_1299 ^ net_1532)));
  assign net_853 = (~net_1289 & sig_452_lut_0) | (net_1289 & sig_452_lut_1);

//---------------------------------------------------------------------------
//Block 453, LSLICE 2

  assign net_852 = (~net_1064 & ~net_954 & ~net_1060) | (~net_1064 & ~net_954 & net_1060 & ((~net_1078 & ~net_843)));
  assign net_854 = (~net_954 & ~net_568 & (~(net_1067 & net_584)));

//---------------------------------------------------------------------------
//Block 454, LSLICE 3

  assign net_857 = (~net_1060 & ~net_1299 & ((~net_1301 & ~net_951) | (net_1301 & ~net_951))) | (~net_1060 & net_1299) | (net_1060 & ~net_1299 & ((~net_1301 & ~net_951)));
  assign net_851 = (net_1060 & ~net_962 & ((net_959 | net_950))) | (net_1060 & net_962);

//---------------------------------------------------------------------------
//Block 455, MSLICE 1

  assign net_855 = (net_1299 & net_1300 & ((net_1532 & net_564)));
  assign net_856 = (net_1073 & ~net_970 & (~(net_959 & net_564)));

//---------------------------------------------------------------------------
//Block 456, MSLICE 0

  assign sig_456_lut_0 = 1'b0;
  assign sig_456_lut_1 = (net_852 & ~net_1301 & (~(net_1532 & net_1057))) | (net_852 & net_1301 & (~(~net_1532 & net_1057)));
  assign net_860 = (~net_861 & sig_456_lut_0) | (net_861 & sig_456_lut_1);

//---------------------------------------------------------------------------
//Block 457, LSLICE 2

  assign net_859 = (~net_1303 & ~net_668 & ~net_592 & ((~net_961 & ~net_858) | (net_961 & ~net_858))) | (~net_1303 & ~net_668 & net_592 & ((~net_961 & ~net_858) | (net_961 & ~net_858))) | (~net_1303 & net_668 & ~net_592 & ((~net_961 & ~net_858) | (net_961 & ~net_858))) | (net_1303 & ~net_668 & ~net_592 & ((~net_961 & ~net_858))) | (net_1303 & ~net_668 & net_592 & ((~net_961 & ~net_858))) | (net_1303 & net_668 & ~net_592 & ((~net_961 & ~net_858)));
  assign net_858 = (~net_1299 & net_584 & (~(~net_1300 & net_1301))) | (net_1299 & net_584 & ((~net_1300 & ~net_1301)));

//---------------------------------------------------------------------------
//Block 458, MSLICE 1

  assign sig_458_lut_0 = (~net_564 & ~net_965 & ((~net_959 & net_859) | (net_959 & net_859))) | (net_564 & ~net_965 & ((~net_959 & net_859)));
  assign sig_458_lut_1 = 1'b0;
  assign net_861 = (~net_970 & sig_458_lut_0) | (net_970 & sig_458_lut_1);

//---------------------------------------------------------------------------
//Block 459, LSLICE 3

  assign net_862 = ((~net_1301 & net_959));
  assign net_863 = ((net_1301 & net_959));

//---------------------------------------------------------------------------
//Block 460, MSLICE 1

  assign sig_460_lut_0 = (~io_mcu_d[1] & ~io_mcu_d[2] & ((~io_mcu_d[0] & net_864) | (io_mcu_d[0] & net_864))) | (~io_mcu_d[1] & io_mcu_d[2] & ((~io_mcu_d[0] & net_864) | (io_mcu_d[0] & net_864))) | (io_mcu_d[1] & ~io_mcu_d[2] & ((~io_mcu_d[0] & net_864) | (io_mcu_d[0] & net_864))) | (io_mcu_d[1] & io_mcu_d[2] & ((~io_mcu_d[0] & net_864) | (io_mcu_d[0] & net_864)));
  assign sig_460_lut_1 = (~net_864 & ~io_mcu_d[2] & ((~io_mcu_d[1] & io_mcu_d[0]) | (io_mcu_d[1] & io_mcu_d[0]))) | (~net_864 & io_mcu_d[2] & ((~io_mcu_d[1] & io_mcu_d[0]))) | (net_864 & ~io_mcu_d[2] & ((~io_mcu_d[1] & io_mcu_d[0]) | (io_mcu_d[1] & io_mcu_d[0]))) | (net_864 & io_mcu_d[2] & ((io_mcu_d[1] | io_mcu_d[0])));
  assign sig_460_ff0_d = (~net_641 & sig_460_lut_0) | (net_641 & sig_460_lut_1);

  always @(posedge gclk_9)
  begin
    if(net_1107 == 1'b1)   //enable
     begin
      net_864 <= sig_460_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 461, MSLICE 1

  assign sig_461_lut_0 = (~io_mcu_d[1] & ~net_641 & ((~io_mcu_d[2] & net_866) | (io_mcu_d[2] & net_866))) | (~io_mcu_d[1] & net_641) | (io_mcu_d[1] & ~net_641 & ((~io_mcu_d[2] & net_866) | (io_mcu_d[2] & net_866))) | (io_mcu_d[1] & net_641 & ((io_mcu_d[2] & net_866)));
  assign sig_461_lut_1 = (~io_mcu_d[2] & ~io_mcu_d[1] & ((net_641 | net_865))) | (~io_mcu_d[2] & io_mcu_d[1] & ((net_641 | net_865))) | (io_mcu_d[2] & ~io_mcu_d[1] & ((~net_641 & net_865))) | (io_mcu_d[2] & io_mcu_d[1] & ((~net_641 & net_865) | (net_641 & net_865)));

  always @(posedge gclk_9)
  begin
    if(net_1107 == 1'b1)   //enable
     begin
      net_866 <= sig_461_lut_0;
      net_865 <= sig_461_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 466, LSLICE 3

  assign net_868 = (~net_691 & ~net_1044 & ((~net_701 & ~net_189) | (net_701 & ~net_189))) | (~net_691 & net_1044 & ((~net_701 & ~net_189))) | (net_691 & net_1044 & ((~net_701 & ~net_189)));
  assign net_869 = (~net_694 & ~net_699 & ((~net_1044 & ~net_189) | (net_1044 & ~net_189))) | (~net_694 & net_699 & ((~net_1044 & ~net_189))) | (net_694 & ~net_699 & ((net_1044 & ~net_189)));

//---------------------------------------------------------------------------
//Block 467, MSLICE 1

  assign sig_467_lut_0 = (~net_994 & ~net_511 & ((~net_631 & net_867) | (net_631 & net_867))) | (~net_994 & net_511 & ((~net_631 & net_867) | (net_631 & net_867))) | (net_994 & ~net_511 & ((~net_631 & ~net_867) | (~net_631 & net_867))) | (net_994 & net_511 & ((~net_631 & ~net_867) | (~net_631 & net_867)));
  assign sig_467_lut_1 = (~net_867 & ~net_994 & ((~net_631 & ~net_511) | (net_631 & ~net_511))) | (~net_867 & net_994 & ((~net_631 & ~net_511) | (net_631 & ~net_511))) | (net_867 & ~net_994 & ((~net_631 & ~net_511) | (net_631 & ~net_511))) | (net_867 & net_994 & ((~net_631 & ~net_511) | (net_631 & ~net_511)));
  assign sig_467_ff0_d = (~net_445 & sig_467_lut_0) | (net_445 & sig_467_lut_1);

  always @(posedge gclk_4)
  begin
    net_867 <= sig_467_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 468, MSLICE 0

  assign sig_468_lut_0 = (~net_994 & ~net_511 & ((~net_624 & net_870) | (net_624 & net_870))) | (~net_994 & net_511 & ((~net_624 & net_870) | (net_624 & net_870))) | (net_994 & ~net_511 & ((~net_624 & ~net_870) | (~net_624 & net_870))) | (net_994 & net_511 & ((~net_624 & ~net_870) | (~net_624 & net_870)));
  assign sig_468_lut_1 = (~net_870 & ~net_511) | (net_870 & ~net_511);
  assign sig_468_ff0_d = (~net_445 & sig_468_lut_0) | (net_445 & sig_468_lut_1);

  always @(posedge gclk_4)
  begin
    net_870 <= sig_468_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 469, LSLICE 2

  assign net_873 = (~net_1546 & ~net_1044 & ~net_189 & ((~net_1537 & ~net_871) | (net_1537 & ~net_871))) | (~net_1546 & ~net_1044 & net_189 & ((net_1537 & ~net_871))) | (~net_1546 & net_1044 & ~net_189 & ((~net_1537 & ~net_871) | (net_1537 & ~net_871))) | (net_1546 & ~net_1044 & ~net_189 & ((~net_1537 & ~net_871) | (net_1537 & ~net_871))) | (net_1546 & ~net_1044 & net_189 & ((net_1537 & ~net_871))) | (net_1546 & net_1044 & ~net_189 & ((~net_1537 & ~net_871) | (net_1537 & ~net_871))) | (net_1546 & net_1044 & net_189 & ((~net_1537 & ~net_871) | (net_1537 & ~net_871)));
  assign net_871 = (~net_693 & ~net_703 & ((~net_189 & ~net_1044) | (~net_189 & net_1044))) | (~net_693 & net_703 & ((~net_189 & ~net_1044))) | (net_693 & ~net_703 & ((~net_189 & net_1044)));

  always @(negedge gclk_4)
  begin
    net_872 <= net_1233;
  end

//---------------------------------------------------------------------------
//Block 470, MSLICE 1

  assign sig_470_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_1536 & ~net_1547) | (net_1536 & net_1547))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_1536 & net_1547) | (net_1536 & net_1547)));
  assign sig_470_lut_1 = 1'b0;
  assign net_874 = (~net_219 & sig_470_lut_0) | (net_219 & sig_470_lut_1);

//---------------------------------------------------------------------------
//Block 471, MSLICE 0

  assign sig_471_lut_0 = (~net_994 & ~net_511 & ((~net_876 & net_875) | (net_876 & net_875))) | (~net_994 & net_511 & ((~net_876 & net_875) | (net_876 & net_875))) | (net_994 & ~net_511 & ((net_876 & ~net_875) | (net_876 & net_875))) | (net_994 & net_511 & ((net_876 & ~net_875) | (net_876 & net_875)));
  assign sig_471_lut_1 = (~net_875 & ~net_511) | (net_875 & ~net_511);
  assign sig_471_ff0_d = (~net_445 & sig_471_lut_0) | (net_445 & sig_471_lut_1);

  always @(posedge gclk_4)
  begin
    net_875 <= sig_471_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 472, LSLICE 2

  assign net_880 = (~net_767 & ~net_782 & ~net_744 & ((~net_605 & ~net_879) | (net_605 & ~net_879))) | (~net_767 & ~net_782 & net_744 & ((~net_605 & ~net_879) | (net_605 & ~net_879))) | (~net_767 & net_782 & ~net_744 & ((~net_605 & ~net_879) | (net_605 & ~net_879))) | (~net_767 & net_782 & net_744 & ((~net_605 & ~net_879) | (net_605 & ~net_879))) | (net_767 & ~net_782 & ~net_744 & ((~net_605 & ~net_879) | (net_605 & ~net_879))) | (net_767 & ~net_782 & net_744 & ((~net_605 & ~net_879) | (net_605 & ~net_879))) | (net_767 & net_782 & ~net_744 & ((~net_605 & ~net_879) | (net_605 & ~net_879))) | (net_767 & net_782 & net_744 & (~(~net_605 & net_879)));
  assign net_879 = (~net_762 & ~net_878 & ~net_772 & ((~net_760 & ~net_877)));

  always @(posedge gclk_5)
  begin
    if(net_880 == 1'b1)   //reset
    begin
      net_878 <= 1'b0;
      net_877 <= 1'b0;
    end
    else
    begin
      net_878 <= net_769;
      net_877 <= net_766;
    end
  end

//---------------------------------------------------------------------------
//Block 473, MSLICE 1

  assign sig_473_lut_0 = (~net_994 & ~net_511 & ((~net_623 & net_876) | (net_623 & net_876))) | (~net_994 & net_511 & ((~net_623 & net_876) | (net_623 & net_876))) | (net_994 & ~net_511 & ((~net_623 & ~net_876) | (~net_623 & net_876))) | (net_994 & net_511 & ((~net_623 & ~net_876) | (~net_623 & net_876)));
  assign sig_473_lut_1 = (~net_876 & ~net_994 & ((~net_511 & ~net_623) | (~net_511 & net_623))) | (~net_876 & net_994 & ((~net_511 & ~net_623) | (~net_511 & net_623))) | (net_876 & ~net_994 & ((~net_511 & ~net_623) | (~net_511 & net_623))) | (net_876 & net_994 & ((~net_511 & ~net_623) | (~net_511 & net_623)));
  assign sig_473_ff0_d = (~net_445 & sig_473_lut_0) | (net_445 & sig_473_lut_1);

  always @(posedge gclk_4)
  begin
    net_876 <= sig_473_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 474, MSLICE 0

  assign net_882 = (net_181 & net_180 & ((net_308 & net_222)));
  assign net_883 = ((~net_630 & ~net_881));

  always @(posedge gclk_9)
  begin
    if(net_882 == 1'b1)   //enable
     begin
      net_884 <= io_mcu_d[0];
      net_881 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 475, LSLICE 2

  assign net_893 = (~net_762 & ~net_887 & net_891 & (~(~net_772 & net_886))) | (net_762 & ~net_887 & net_891 & (~(~net_772 & net_886))) | (net_762 & net_887 & net_891 & (~(~net_772 & net_886)));
  assign net_889 = (~net_878 & net_891 & ~net_885 & ((net_762 & ~net_887))) | (~net_878 & net_891 & net_885 & ((net_762 & ~net_887))) | (net_878 & net_891 & ~net_885) | (net_878 & net_891 & net_885 & ((net_762 & ~net_887)));

  always @(posedge gclk_9)
  begin
    if(net_779 == 1'b1)   //enable
     begin
      net_886 <= io_mcu_d[7];
      net_887 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 476, LSLICE 3

  assign net_894 = (~net_877 & ~net_772 & ~net_886 & ((net_889 & ~net_888) | (net_889 & net_888))) | (~net_877 & net_772 & ~net_886) | (~net_877 & net_772 & net_886 & ((net_889 & ~net_888) | (net_889 & net_888))) | (net_877 & ~net_772 & ~net_886 & (~(~net_889 & net_888))) | (net_877 & net_772 & ~net_886) | (net_877 & net_772 & net_886 & (~(~net_889 & net_888)));
  assign net_891 = (~net_877 & ~net_888 & (~(~net_878 & net_885))) | (net_877 & ~net_888 & (~(~net_878 & net_885))) | (net_877 & net_888 & (~(~net_878 & net_885)));

  always @(posedge gclk_9)
  begin
    if(net_779 == 1'b1)   //enable
     begin
      net_888 <= io_mcu_d[6];
      net_885 <= io_mcu_d[5];
    end
  end

//---------------------------------------------------------------------------
//Block 477, MSLICE 1

  assign sig_477_lut_0 = ~net_890;
  assign net_892 = (~net_1355 & ~net_1351) | (~net_1355 & net_1351 & (~(net_1359 & net_1353)));

  always @(posedge gclk_5)
  begin
    if(net_785 == 1'b1)   //enable
     begin
      net_890 <= sig_477_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 478, MSLICE 0

  assign net_897 = (net_895 & net_1111 & ((~net_181 & ~net_180)));
  assign net_895 = ((net_452 & net_533));

  always @(posedge gclk_9)
  begin
    if(net_897 == 1'b1)   //enable
     begin
      net_898 <= io_mcu_d[0];
      net_899 <= io_mcu_d[3];
    end
  end

//---------------------------------------------------------------------------
//Block 479, LSLICE 2

  assign net_900 = (net_452 & net_180 & net_536 & ((net_1111 & ~net_181)));
  assign net_896 = (~net_643 & ((net_536 & ~net_644)));

  always @(posedge gclk_9)
  begin
    if(net_900 == 1'b1)   //enable
     begin
      net_901 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 480, LSLICE 3

  assign net_903 = (~net_179 & (~(net_987 & net_516))) | (net_179 & ((~net_987 & net_516)));
  assign net_902 = (net_1095 & (~(net_908 & net_1341)));

//---------------------------------------------------------------------------
//Block 481, MSLICE 0

  assign net_904 = (net_896 & ((net_181 & net_180)));
  assign net_905 = (~net_180 & ((net_896 & net_181)));

//---------------------------------------------------------------------------
//Block 482, MSLICE 1

  assign sig_482_lut_0 = 1'b0;
  assign sig_482_lut_1 = (net_644 & net_647 & ((~net_181 & ~net_180)));
  assign net_906 = (~net_643 & sig_482_lut_0) | (net_643 & sig_482_lut_1);

//---------------------------------------------------------------------------
//Block 483, MSLICE 0

  assign net_912 = (net_1303 & ((net_943 & ~net_247)));
  assign net_915 = (~net_907 & ~net_648 & (~(net_905 & net_1209))) | (~net_907 & net_648 & (~(net_905 & net_1209))) | (net_907 & ~net_648 & (~(net_905 & net_1209)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_907 <= 1'b0;
    end
    else
    begin
      if(net_912 == 1'b1)   //enable
       begin
        net_907 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 484, LSLICE 2

  assign sig_484_lut_0 = (~i_mcu_rws & ~i_mcu_dcs & ~net_911 & ((~net_180 & ~net_910) | (net_180 & ~net_910))) | (~i_mcu_rws & ~i_mcu_dcs & net_911 & ((~net_180 & ~net_910) | (net_180 & ~net_910))) | (~i_mcu_rws & i_mcu_dcs & ~net_911 & ((net_180 & ~net_910) | (net_180 & net_910))) | (~i_mcu_rws & i_mcu_dcs & net_911 & ((net_180 & ~net_910) | (net_180 & net_910))) | (i_mcu_rws & ~i_mcu_dcs & net_911) | (i_mcu_rws & i_mcu_dcs & net_911);
  assign net_910 = (net_1136 & net_1008 & net_824 & ((net_790 & ~net_650)));

  always @(posedge gclk_9)
  begin
    net_911 <= sig_484_lut_0;
  end

//---------------------------------------------------------------------------
//Block 485, MSLICE 1

  assign sig_485_lut_0 = (~i_mcu_dcs & ~net_1022) | (i_mcu_dcs & ~net_1022 & ((net_644 & ~net_908) | (net_644 & net_908))) | (i_mcu_dcs & net_1022 & ((net_644 & ~net_908) | (net_644 & net_908)));
  assign sig_485_lut_1 = (net_908 & ~i_mcu_dcs) | (net_908 & i_mcu_dcs);
  assign sig_485_ff0_d = (~i_mcu_rws & sig_485_lut_0) | (i_mcu_rws & sig_485_lut_1);

  always @(posedge gclk_9)
  begin
    net_908 <= sig_485_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 486, LSLICE 3

  assign net_914 = (net_1528 & ((~net_247 & net_943)));
  assign net_913 = (~net_904 & ~net_909) | (~net_904 & net_909 & ((~net_648 & ~net_1554) | (~net_648 & net_1554))) | (net_904 & ~net_909 & ((~net_648 & ~net_1554) | (net_648 & ~net_1554))) | (net_904 & net_909 & ((~net_648 & ~net_1554)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_909 <= 1'b0;
    end
    else
    begin
      if(net_914 == 1'b1)   //enable
       begin
        net_909 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 487, MSLICE 0

  assign net_918 = (net_916 & ((net_911 & ~net_1141)));
  assign net_916 = ((net_1349 & ~net_1283));

  always @(posedge gclk_9)
  begin
    if(net_1149 == 1'b1)   //enable
     begin
      net_917 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 488, LSLICE 2

  assign net_921 = (~net_527 & ((~net_1176 & net_1273) | (net_1176 & net_1273))) | (net_527 & ((net_1176 & ~net_1273) | (net_1176 & net_1273)));
  assign net_922 = (net_439 & ~net_919 & ((~net_1141 & net_324))) | (net_439 & net_919 & ((net_1141 | net_324)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_919 <= 1'b0;
    end
    else
    begin
      if(net_1291 == 1'b1)   //enable
       begin
        net_919 <= net_1273;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 489, MSLICE 1

  assign net_924 = (~net_1175 & ((~net_527 & net_1275))) | (net_1175 & ((net_527 | net_1275)));
  assign net_925 = (~net_727 & (~(~net_1044 & net_736))) | (net_727 & ((~net_1044 & ~net_736)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_927 <= 1'b0;
    end
    else
    begin
      if(net_1291 == 1'b1)   //enable
       begin
        net_927 <= net_1275;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 490, LSLICE 3

  assign net_926 = (~net_247 & ((net_1032 & net_1056)));
  assign net_920 = ((~net_247 & net_1528));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_923 <= 1'b0;
    end
    else
    begin
      if(net_926 == 1'b1)   //enable
       begin
        net_923 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 491, MSLICE 0

  assign net_935 = ~net_963;

//---------------------------------------------------------------------------
//Block 492, LSLICE 2

  assign net_931 = (~net_794 & ~i_adc1A_d[6] & ~net_1244 & ((~i_adc1B_d[6] & net_930) | (i_adc1B_d[6] & net_930))) | (~net_794 & ~i_adc1A_d[6] & net_1244 & ((~i_adc1B_d[6] & net_930) | (i_adc1B_d[6] & net_930))) | (~net_794 & i_adc1A_d[6] & ~net_1244 & ((~i_adc1B_d[6] & net_930) | (i_adc1B_d[6] & net_930))) | (net_794 & ~i_adc1A_d[6] & ~net_1244 & ((~i_adc1B_d[6] & net_930))) | (net_794 & ~i_adc1A_d[6] & net_1244 & ((~i_adc1B_d[6] & net_930))) | (net_794 & i_adc1A_d[6] & ~net_1244 & ((~i_adc1B_d[6] & net_930)));
  assign net_930 = (~net_833 & ~net_999 & (~(net_796 & net_832))) | (~net_833 & net_999 & (~(net_796 & net_832))) | (net_833 & ~net_999 & (~(net_796 & net_832)));

  always @(negedge gclk_4)
  begin
    net_938 <= i_adc1B_d[6];
    net_933 <= i_adc1A_d[6];
  end

//---------------------------------------------------------------------------
//Block 493, MSLICE 1

  assign net_934 = (net_929 & ((net_584 & ~net_247)));
  assign net_929 = (~net_1301 & ~net_1300 & ((net_1299 & ~net_1532)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_932 <= 1'b0;
    end
    else
    begin
      if(net_934 == 1'b1)   //enable
       begin
        net_932 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 494, LSLICE 3

  assign net_937 = (net_963 & net_948 & net_1303 & ((~net_247 & ~net_1302)));
  assign net_936 = (~net_676 & ~net_928) | (~net_676 & net_928 & ((~net_999 & ~net_998) | (net_999 & ~net_998))) | (net_676 & ~net_928 & ((~net_999 & ~net_998) | (~net_999 & net_998))) | (net_676 & net_928 & ((~net_999 & ~net_998)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_928 <= 1'b1;
    end
    else
    begin
      if(net_937 == 1'b1)   //enable
       begin
        net_928 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 495, MSLICE 0

  assign net_940 = (net_1067 & ((~net_247 & net_584)));
  assign net_939 = ((net_1289 & net_1067));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_941 <= 1'b0;
    end
    else
    begin
      if(net_940 == 1'b1)   //enable
       begin
        net_941 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 496, LSLICE 2

  assign net_942 = (net_1013 & ~net_835 & ~net_547 & (~(i_adc1B_d[1] & net_794))) | (net_1013 & ~net_835 & net_547 & (~(i_adc1B_d[1] & net_794))) | (net_1013 & net_835 & ~net_547 & (~(i_adc1B_d[1] & net_794)));
  assign net_947 = (~net_577 & ((net_942 & ~net_906) | (net_942 & net_906))) | (net_577 & ((net_942 & ~net_906)));

  always @(negedge gclk_4)
  begin
    net_944 <= i_adc1B_d[1];
  end

//---------------------------------------------------------------------------
//Block 497, LSLICE 3

  assign net_945 = ((net_1525 & net_920));
  assign net_943 = (~net_1302 & ~net_1312 & ((net_1182 & ~net_948)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_946 <= 1'b1;
    end
    else
    begin
      if(net_945 == 1'b1)   //enable
       begin
        net_946 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 498, MSLICE 0

  assign net_954 = (net_939 & net_1302 & ((net_963 & ~net_948)));
  assign net_957 = ((net_939 & net_1329));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_948 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_948 <= net_1310;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 499, LSLICE 2

  assign net_953 = (net_1303 & ((~net_247 & net_964)));
  assign net_951 = ((net_1289 & net_964));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_956 <= 1'b0;
    end
    else
    begin
      if(net_953 == 1'b1)   //enable
       begin
        net_956 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 500, LSLICE 3

  assign net_955 = (~net_1159 & ~net_949 & ((~net_1528 & ~net_1303))) | (net_1159 & ~net_949);
  assign net_949 = (~net_1528 & ((net_1648 & net_939))) | (net_1528 & ((net_1648 & ~net_939) | (net_1648 & net_939)));

//---------------------------------------------------------------------------
//Block 501, MSLICE 1

  assign net_952 = (net_1299 & net_1300 & ((net_1301 & net_1532)));
  assign net_950 = (net_1301 & net_1300 & ((net_1532 & ~net_1299)));

//---------------------------------------------------------------------------
//Block 502, MSLICE 0

  assign sig_502_lut_0 = (~net_855 & ~net_668) | (~net_855 & net_668 & ((~net_847 & ~net_950)));
  assign sig_502_lut_1 = 1'b0;
  assign net_958 = (~net_1500 & sig_502_lut_0) | (net_1500 & sig_502_lut_1);

//---------------------------------------------------------------------------
//Block 503, LSLICE 3

  assign net_961 = (net_849 & ((~net_1302 & net_948)));
  assign net_960 = (net_849 & ((net_1302 & ~net_948)));

//---------------------------------------------------------------------------
//Block 504, LSLICE 2

  assign net_962 = (net_1300 & net_1532 & ((~net_1301 & net_1299)));
  assign net_959 = (net_1299 & ((~net_1300 & net_1532)));

//---------------------------------------------------------------------------
//Block 505, MSLICE 0

  assign net_969 = (net_592 & ((net_1289 & net_1329)));
  assign net_965 = ((net_1329 & net_470));

//---------------------------------------------------------------------------
//Block 506, LSLICE 2

  assign net_964 = (net_849 & ((~net_1302 & ~net_948)));
  assign net_967 = (net_849 & ((net_948 & net_1302)));

//---------------------------------------------------------------------------
//Block 507, LSLICE 3

  assign net_966 = ((net_585 & net_1289));
  assign net_963 = ((~net_1312 & ~net_1182));

//---------------------------------------------------------------------------
//Block 508, MSLICE 1

  assign sig_508_lut_0 = 1'b0;
  assign sig_508_lut_1 = (net_1302 & net_1289 & ((net_963 & ~net_948)));
  assign net_968 = (~net_592 & sig_508_lut_0) | (net_592 & sig_508_lut_1);

//---------------------------------------------------------------------------
//Block 509, MSLICE 0

  assign sig_509_lut_0 = 1'b0;
  assign sig_509_lut_1 = (~net_1300 & ~net_1301 & (~(net_1299 & net_1532))) | (~net_1300 & net_1301 & ((~net_1299 & ~net_1532) | (~net_1299 & net_1532))) | (net_1300 & ~net_1301 & ((~net_1299 & ~net_1532) | (~net_1299 & net_1532))) | (net_1300 & net_1301 & ((~net_1299 & ~net_1532)));
  assign net_970 = (~net_1523 & sig_509_lut_0) | (net_1523 & sig_509_lut_1);

//---------------------------------------------------------------------------
//Block 510, MSLICE 1

  assign sig_510_lut_0 = (~io_mcu_d[1] & ~io_mcu_d[2] & ((~io_mcu_d[0] & net_971) | (io_mcu_d[0] & net_971))) | (~io_mcu_d[1] & io_mcu_d[2] & ((~io_mcu_d[0] & net_971) | (io_mcu_d[0] & net_971))) | (io_mcu_d[1] & ~io_mcu_d[2] & ((~io_mcu_d[0] & net_971) | (io_mcu_d[0] & net_971))) | (io_mcu_d[1] & io_mcu_d[2] & ((~io_mcu_d[0] & net_971) | (io_mcu_d[0] & net_971)));
  assign sig_510_lut_1 = (~net_971 & ~io_mcu_d[2] & ((~io_mcu_d[1] & io_mcu_d[0]) | (io_mcu_d[1] & io_mcu_d[0]))) | (~net_971 & io_mcu_d[2] & ((~io_mcu_d[1] & io_mcu_d[0]))) | (net_971 & ~io_mcu_d[2] & ((~io_mcu_d[1] & io_mcu_d[0]) | (io_mcu_d[1] & io_mcu_d[0]))) | (net_971 & io_mcu_d[2] & ((io_mcu_d[1] | io_mcu_d[0])));
  assign sig_510_ff0_d = (~net_641 & sig_510_lut_0) | (net_641 & sig_510_lut_1);

  always @(posedge gclk_9)
  begin
    if(net_1117 == 1'b1)   //enable
     begin
      net_971 <= sig_510_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 511, LSLICE 2

  assign sig_511_lut_0 = (~io_mcu_d[1] & ~net_641 & ((~io_mcu_d[2] & net_972) | (io_mcu_d[2] & net_972))) | (~io_mcu_d[1] & net_641) | (io_mcu_d[1] & ~net_641 & ((~io_mcu_d[2] & net_972) | (io_mcu_d[2] & net_972))) | (io_mcu_d[1] & net_641 & ((io_mcu_d[2] & net_972)));
  assign sig_511_lut_1 = (~io_mcu_d[2] & ~net_641 & ((~io_mcu_d[1] & net_973) | (io_mcu_d[1] & net_973))) | (~io_mcu_d[2] & net_641) | (io_mcu_d[2] & ~net_641 & ((~io_mcu_d[1] & net_973) | (io_mcu_d[1] & net_973))) | (io_mcu_d[2] & net_641 & ((io_mcu_d[1] & net_973)));

  always @(posedge gclk_9)
  begin
    if(net_1117 == 1'b1)   //enable
     begin
      net_972 <= sig_511_lut_0;
      net_973 <= sig_511_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 512, MSLICE 1

  assign sig_512_lut_0 = (~net_994 & ~net_511 & ((~net_867 & net_974) | (net_867 & net_974))) | (~net_994 & net_511 & ((~net_867 & net_974) | (net_867 & net_974))) | (net_994 & ~net_511 & ((net_867 & ~net_974) | (net_867 & net_974))) | (net_994 & net_511 & ((net_867 & ~net_974) | (net_867 & net_974)));
  assign sig_512_lut_1 = (~net_974 & ~net_994 & ((~net_511 & ~net_867) | (~net_511 & net_867))) | (~net_974 & net_994 & ((~net_511 & ~net_867) | (~net_511 & net_867))) | (net_974 & ~net_994 & ((~net_511 & ~net_867) | (~net_511 & net_867))) | (net_974 & net_994 & ((~net_511 & ~net_867) | (~net_511 & net_867)));
  assign sig_512_ff0_d = (~net_445 & sig_512_lut_0) | (net_445 & sig_512_lut_1);

  always @(posedge gclk_4)
  begin
    net_974 <= sig_512_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 513, LSLICE 2

  assign net_976 = (~net_978 & ~net_884) | (~net_978 & net_884 & ((net_982 | net_746))) | (net_978 & ~net_884 & ((~net_982 & net_746) | (net_982 & net_746))) | (net_978 & net_884 & ((net_982 & net_746)));
  assign net_975 = ((net_630 & net_881));

//---------------------------------------------------------------------------
//Block 514, MSLICE 1

  assign sig_514_lut_0 = (~net_975 & net_1085 & ((net_631 & ~net_1097))) | (net_975 & ~net_1085 & ((net_631 & ~net_1097))) | (net_975 & net_1085 & ((~net_631 & ~net_1097) | (net_631 & ~net_1097)));
  assign sig_514_lut_1 = (~net_975 & ~net_1085 & ((net_631 & ~net_1097))) | (~net_975 & net_1085 & ((~net_631 & ~net_1097) | (net_631 & ~net_1097))) | (net_975 & ~net_1085 & ((net_631 & ~net_1097))) | (net_975 & net_1085 & ((~net_631 & ~net_1097) | (net_631 & ~net_1097)));
  assign net_977 = (~net_980 & sig_514_lut_0) | (net_980 & sig_514_lut_1);

//---------------------------------------------------------------------------
//Block 515, LSLICE 3

  assign net_979 = (~net_884 & ~net_975 & ~net_781 & (~(net_636 & net_978))) | (~net_884 & ~net_975 & net_781 & (~(net_636 & net_978))) | (net_884 & ~net_975 & ~net_781 & (~(net_636 & net_978))) | (net_884 & ~net_975 & net_781 & ((~net_636 & ~net_978)));
  assign net_980 = (~net_884 & ~net_978 & ~net_883 & ((net_636 & net_781))) | (~net_884 & net_978 & ~net_883 & ((net_636 | net_781))) | (net_884 & ~net_978 & ~net_883 & ((net_636 & ~net_781) | (net_636 & net_781))) | (net_884 & net_978 & ~net_883);

  always @(posedge gclk_9)
  begin
    if(net_882 == 1'b1)   //enable
     begin
      net_978 <= io_mcu_d[1];
    end
  end

//---------------------------------------------------------------------------
//Block 516, MSLICE 0

  assign sig_516_lut_0 = (~net_994 & ~net_511 & ((~net_630 & net_981) | (net_630 & net_981))) | (~net_994 & net_511 & ((~net_630 & net_981) | (net_630 & net_981))) | (net_994 & ~net_511 & ((~net_630 & ~net_981) | (~net_630 & net_981))) | (net_994 & net_511 & ((~net_630 & ~net_981) | (~net_630 & net_981)));
  assign sig_516_lut_1 = (~net_981 & ~net_511) | (net_981 & ~net_511);
  assign sig_516_ff0_d = (~net_445 & sig_516_lut_0) | (net_445 & sig_516_lut_1);

  always @(posedge gclk_4)
  begin
    net_981 <= sig_516_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 517, LSLICE 2

  assign net_987 = (~net_1551 & ~net_1044 & ~net_189 & ((~net_1541 & ~net_984) | (net_1541 & ~net_984))) | (~net_1551 & ~net_1044 & net_189 & ((net_1541 & ~net_984))) | (~net_1551 & net_1044 & ~net_189 & ((~net_1541 & ~net_984) | (net_1541 & ~net_984))) | (net_1551 & ~net_1044 & ~net_189 & ((~net_1541 & ~net_984) | (net_1541 & ~net_984))) | (net_1551 & ~net_1044 & net_189 & ((net_1541 & ~net_984))) | (net_1551 & net_1044 & ~net_189 & ((~net_1541 & ~net_984) | (net_1541 & ~net_984))) | (net_1551 & net_1044 & net_189 & ((~net_1541 & ~net_984) | (net_1541 & ~net_984)));
  assign net_984 = (~net_707 & ~net_189 & (~(net_695 & ~net_1044))) | (net_707 & ~net_189 & ((~net_695 & ~net_1044)));

  always @(negedge gclk_4)
  begin
    net_988 <= net_1232;
  end

//---------------------------------------------------------------------------
//Block 518, LSLICE 3

  assign net_985 = (~net_1044 & ~net_983 & ~net_189) | (~net_1044 & ~net_983 & net_189 & ((~net_1542 & ~net_1550) | (~net_1542 & net_1550))) | (net_1044 & ~net_983 & ~net_189) | (net_1044 & ~net_983 & net_189 & ((~net_1542 & ~net_1550) | (net_1542 & ~net_1550)));
  assign net_983 = (~net_696 & net_1044 & ((net_706 & ~net_189))) | (net_696 & ~net_1044 & ((~net_706 & ~net_189) | (net_706 & ~net_189))) | (net_696 & net_1044 & ((net_706 & ~net_189)));

  always @(negedge gclk_4)
  begin
    net_986 <= net_1223;
  end

//---------------------------------------------------------------------------
//Block 519, MSLICE 1

  assign sig_519_lut_0 = (~net_994 & ~net_511 & ((~net_989 & net_982) | (net_989 & net_982))) | (~net_994 & net_511 & ((~net_989 & net_982) | (net_989 & net_982))) | (net_994 & ~net_511 & ((net_989 & ~net_982) | (net_989 & net_982))) | (net_994 & net_511 & ((net_989 & ~net_982) | (net_989 & net_982)));
  assign sig_519_lut_1 = (~net_982 & ~net_994 & ((~net_511 & ~net_989) | (~net_511 & net_989))) | (~net_982 & net_994 & ((~net_511 & ~net_989) | (~net_511 & net_989))) | (net_982 & ~net_994 & ((~net_511 & ~net_989) | (~net_511 & net_989))) | (net_982 & net_994 & ((~net_511 & ~net_989) | (~net_511 & net_989)));
  assign sig_519_ff0_d = (~net_445 & sig_519_lut_0) | (net_445 & sig_519_lut_1);

  always @(posedge gclk_4)
  begin
    net_982 <= sig_519_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 520, LSLICE 2

  assign sig_520_lut_0 = (~net_894 & ~net_893 & ~net_784) | (~net_894 & ~net_893 & net_784) | (~net_894 & net_893 & ~net_784 & ((net_776 & ~net_760))) | (~net_894 & net_893 & net_784);

  always @(posedge gclk_5)
  begin
    if(net_880 == 1'b0)   //enable
     begin
      net_990 <= sig_520_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 521, MSLICE 1

  assign sig_521_lut_0 = (~net_994 & ~net_511 & ((~net_781 & net_989) | (net_781 & net_989))) | (~net_994 & net_511 & ((~net_781 & net_989) | (net_781 & net_989))) | (net_994 & ~net_511 & ((~net_781 & ~net_989) | (~net_781 & net_989))) | (net_994 & net_511 & ((~net_781 & ~net_989) | (~net_781 & net_989)));
  assign sig_521_lut_1 = (~net_989 & ~net_994 & ((~net_781 & ~net_511) | (net_781 & ~net_511))) | (~net_989 & net_994 & ((~net_781 & ~net_511) | (net_781 & ~net_511))) | (net_989 & ~net_994 & ((~net_781 & ~net_511) | (net_781 & ~net_511))) | (net_989 & net_994 & ((~net_781 & ~net_511) | (net_781 & ~net_511)));
  assign sig_521_ff0_d = (~net_445 & sig_521_lut_0) | (net_445 & sig_521_lut_1);

  always @(posedge gclk_4)
  begin
    net_989 <= sig_521_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 522, LSLICE 3

  assign net_991 = (net_189 & ~net_1044 & ~net_904) | (net_189 & ~net_1044 & net_904 & ((~net_1540 & ~net_1549) | (~net_1540 & net_1549))) | (net_189 & net_1044 & ~net_904) | (net_189 & net_1044 & net_904 & ((~net_1540 & ~net_1549) | (net_1540 & ~net_1549)));
  assign net_993 = (~net_629 & ~net_1048 & ~net_523 & ((net_614 | net_991))) | (~net_629 & net_1048 & ~net_523 & ((net_614 | net_991))) | (~net_629 & net_1048 & net_523 & ((net_614 & ~net_991) | (net_614 & net_991))) | (net_629 & ~net_1048 & ~net_523 & ((net_614 | net_991))) | (net_629 & ~net_1048 & net_523 & ((~net_614 & net_991) | (net_614 & net_991))) | (net_629 & net_1048 & ~net_523 & ((net_614 | net_991))) | (net_629 & net_1048 & net_523 & ((net_614 | net_991)));

  always @(negedge gclk_4)
  begin
    net_992 <= net_1226;
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 523, 525, 527, 529, 530

  always @(posedge gclk_5)
  begin
    if(net_785 == 1'b1)   //reset
    begin
      { net_1009, net_1001, net_1003, net_1002, net_1005, net_995, net_997, net_996 } <= { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      { net_1009, net_1001, net_1003, net_1002, net_1005, net_995, net_997, net_996 } <= { net_1009, net_1001, net_1003, net_1002, net_1005, net_995, net_997, net_996 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
    end
  end

//---------------------------------------------------------------------------
//Block 524, LSLICE 2

  assign sig_524_lut_0 = (~net_1241 & ((net_1222 | net_994))) | (net_1241);
  assign net_1000 = (~net_718 & (~(net_710 & ~net_1044))) | (net_718 & ((~net_710 & ~net_1044)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_994 <= 1'b0;
    end
    else
    begin
      net_994 <= sig_524_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 526, LSLICE 3

  assign net_998 = (net_1111 & net_647 & ((~net_181 & ~net_180)));
  assign net_999 = (net_1111 & net_647 & ((net_181 & ~net_180)));

//---------------------------------------------------------------------------
//Block 528, LSLICE 2

  assign net_1004 = (net_181 & net_1111 & net_309 & ((~net_180 & ~net_1496)));
  assign net_1008 = (net_1258 & ~net_1004 & ~net_796 & ((~net_1167 & net_780) | (net_1167 & net_780))) | (net_1258 & ~net_1004 & net_796 & ((~net_1167 & net_780)));

  always @(negedge gclk_4)
  begin
    net_1006 <= net_1227;
    net_1007 <= i_adc1B_d[0];
  end

//---------------------------------------------------------------------------
//Block 531, LSLICE 3

  assign net_1010 = (~net_796 & ~net_896 & ~net_1244 & (~(net_647 & net_1111)));
  assign net_1013 = (~net_1242 & ~i_adc2B_d[1] & (~(net_1244 & i_adc1A_d[1]))) | (~net_1242 & i_adc2B_d[1] & (~(net_1244 & i_adc1A_d[1]))) | (net_1242 & ~i_adc2B_d[1] & (~(net_1244 & i_adc1A_d[1])));

  always @(negedge gclk_4)
  begin
    net_1012 <= i_adc2B_d[1];
    net_1011 <= i_adc1A_d[1];
  end

//---------------------------------------------------------------------------
//Block 532, MSLICE 0

  assign net_1020 = (~net_247 & ((net_1067 & net_1523)));
  assign net_1021 = (~net_1014 & ~net_1519) | (~net_1014 & net_1519 & ((~net_999 & ~net_998) | (~net_999 & net_998))) | (net_1014 & ~net_1519 & ((~net_999 & ~net_998) | (net_999 & ~net_998))) | (net_1014 & net_1519 & ((~net_999 & ~net_998)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1014 <= 1'b1;
    end
    else
    begin
      if(net_1020 == 1'b1)   //enable
       begin
        net_1014 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 533, LSLICE 2

  assign net_1018 = (net_584 & ((net_847 & ~net_247)));
  assign net_1017 = (~net_1166 & ~net_1015) | (~net_1166 & net_1015 & ((~net_999 & ~net_796) | (net_999 & ~net_796))) | (net_1166 & ~net_1015 & ((~net_999 & ~net_796) | (~net_999 & net_796))) | (net_1166 & net_1015 & ((~net_999 & ~net_796)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1015 <= 1'b1;
    end
    else
    begin
      if(net_1018 == 1'b1)   //enable
       begin
        net_1015 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 534, LSLICE 3

  assign net_1016 = (net_1247 & ~net_1283 & ~net_1349) | (net_1247 & ~net_1283 & net_1349 & (~(net_908 & ~net_1141))) | (net_1247 & net_1283 & ~net_1349);
  assign net_1022 = (~net_1028 & net_815 & net_551 & ((net_902 & net_1016)));

  always @(posedge gclk_9)
  begin
    if(net_1156 == 1'b1)   //enable
     begin
      net_1019 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 535, MSLICE 0

  assign net_1028 = (~net_1023 & net_439 & (~(net_1283 & ~net_1025)));
  assign net_1023 = (~net_908 & ~net_1283 & (~(net_1141 & net_1152))) | (net_908 & ~net_1283 & ((net_1141 & ~net_1152)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1025 <= 1'b0;
    end
    else
    begin
      if(net_1291 == 1'b1)   //enable
       begin
        net_1025 <= net_1279;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 536, LSLICE 2

  assign net_1027 = (~net_247 & ((net_951 & net_1067)));
  assign net_1026 = (~net_906 & ~net_1024) | (~net_906 & net_1024 & ((~net_923 & ~net_547) | (net_923 & ~net_547))) | (net_906 & ~net_1024 & ((~net_923 & ~net_547) | (~net_923 & net_547))) | (net_906 & net_1024 & ((~net_923 & ~net_547)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1024 <= 1'b0;
    end
    else
    begin
      if(net_1027 == 1'b1)   //enable
       begin
        net_1024 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 537, LSLICE 3

  assign net_1030 = (~net_1141 & ~net_1029 & net_256 & ((net_439 | net_916))) | (~net_1141 & net_1029 & net_256 & ((net_439 | net_916))) | (net_1141 & ~net_1029 & ~net_256 & ((~net_439 & net_916) | (net_439 & net_916))) | (net_1141 & ~net_1029 & net_256 & ((~net_439 & net_916) | (net_439 & net_916))) | (net_1141 & net_1029 & ~net_256 & ((net_439 | net_916))) | (net_1141 & net_1029 & net_256 & ((net_439 | net_916)));
  assign net_1031 = (~net_527 & ((~net_1181 & net_1274) | (net_1181 & net_1274))) | (net_527 & ((net_1181 & ~net_1274) | (net_1181 & net_1274)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1029 <= 1'b0;
    end
    else
    begin
      if(net_1291 == 1'b1)   //enable
       begin
        net_1029 <= net_1274;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 538, MSLICE 0

  assign net_1040 = (net_1032 & ((~net_247 & net_1276)));
  assign net_1032 = ((net_1525 & net_1289));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1043 <= 1'b0;
    end
    else
    begin
      if(net_1040 == 1'b1)   //enable
       begin
        net_1043 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 539, LSLICE 2

  assign net_1036 = (net_920 & net_948 & ((net_963 & ~net_1302)));
  assign net_1038 = (~net_1302 & net_948 & ((net_1289 & net_935)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1042 <= 1'b1;
    end
    else
    begin
      if(net_1036 == 1'b1)   //enable
       begin
        net_1042 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 540, LSLICE 3

  assign net_1033 = (~net_1330 & ~net_896 & ((~i_mcu_rws & ~net_1180) | (~i_mcu_rws & net_1180))) | (~net_1330 & net_896 & ((~i_mcu_rws & ~net_1180))) | (net_1330 & net_896 & ((~i_mcu_rws & ~net_1180)));
  assign net_1041 = (~net_329 & ~net_95 & ((net_180 & net_896))) | (~net_329 & net_95 & ((~net_180 & net_896) | (net_180 & net_896))) | (net_329 & net_95 & ((~net_180 & net_896)));

//---------------------------------------------------------------------------
//Block 541, MSLICE 1

  assign net_1034 = (~net_1141 & ~net_1283 & ((~net_911 & ~net_1297) | (~net_911 & net_1297))) | (net_1141 & ~net_1283 & ((~net_911 & ~net_1297) | (net_911 & ~net_1297)));
  assign net_1035 = (~net_911 & ~net_1283 & (~(net_1141 & net_538))) | (net_911 & ~net_1283 & ((net_1141 & ~net_538)));

  always @(posedge gclk_9)
  begin
    if(net_1149 == 1'b1)   //enable
     begin
      net_1039 <= io_mcu_d[2];
      net_1037 <= io_mcu_d[5];
    end
  end

//---------------------------------------------------------------------------
//Block 542, LSLICE 2

  assign net_1049 = (~net_794 & ~net_241 & ~net_922 & ((~i_adc1B_d[4] & net_1045) | (i_adc1B_d[4] & net_1045))) | (net_794 & ~net_241 & ~net_922 & ((~i_adc1B_d[4] & net_1045)));
  assign net_1045 = (~net_1244 & ~net_796) | (~net_1244 & net_796 & ((~net_1058 & ~i_adc1A_d[4]) | (~net_1058 & i_adc1A_d[4]))) | (net_1244 & ~net_796 & ((~net_1058 & ~i_adc1A_d[4]) | (net_1058 & ~i_adc1A_d[4]))) | (net_1244 & net_796 & ((~net_1058 & ~i_adc1A_d[4])));

  always @(negedge gclk_4)
  begin
    net_1051 <= i_adc1B_d[4];
    net_1046 <= i_adc1A_d[4];
  end

//---------------------------------------------------------------------------
//Block 543, MSLICE 1

  assign net_1050 = (~net_1195 & ((net_1279 & ~net_527))) | (net_1195 & ((net_1279 | net_527)));
  assign net_1048 = (~net_1044 & ((~net_735 & ~net_726) | (~net_735 & net_726))) | (net_1044 & ((~net_735 & ~net_726) | (net_735 & ~net_726)));

  always @(posedge gclk_3)
  begin
    net_1044 <= net_1050;
  end

//---------------------------------------------------------------------------
//Block 544, MSLICE 0

  assign sig_544_lut_0 = 1'b0;
  assign sig_544_lut_1 = (~net_1300 & net_1301 & ((net_1289 & ~net_1532)));
  assign net_1047 = (~net_1299 & sig_544_lut_0) | (net_1299 & sig_544_lut_1);

//---------------------------------------------------------------------------
//Block 545, LSLICE 3

  assign net_1054 = (~net_247 & ((net_1032 & net_929)));
  assign net_1052 = (~net_1055 & net_1186 & ((net_1287 & net_1314)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1053 <= 1'b0;
    end
    else
    begin
      if(net_1054 == 1'b1)   //enable
       begin
        net_1053 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 546, MSLICE 0

  assign sig_546_lut_0 = (~net_1189 & ~net_1186) | (~net_1189 & net_1186) | (net_1189 & ~net_1186) | (net_1189 & net_1186);
  assign sig_546_lut_1 = (~net_1189 & net_1186 & (~(net_1055 & net_247))) | (net_1189 & ~net_1186) | (net_1189 & net_1186);
  assign sig_546_ff0_d = (~net_1295 & sig_546_lut_0) | (net_1295 & sig_546_lut_1);

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1062 <= 1'b0;
    end
    else
    begin
      net_1062 <= sig_546_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 547, LSLICE 2

  assign net_1061 = (~net_247 & ((net_584 & net_1056)));
  assign net_1056 = (net_1077 & ((~net_1532 & net_1301)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1058 <= 1'b0;
    end
    else
    begin
      if(net_1061 == 1'b1)   //enable
       begin
        net_1058 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 548, LSLICE 3

  assign net_1063 = (~net_247 & ((net_1067 & net_1333)));
  assign net_1057 = ((net_1077 & net_1333));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1059 <= 1'b0;
    end
    else
    begin
      if(net_1063 == 1'b1)   //enable
       begin
        net_1059 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 549, MSLICE 1

  assign net_1055 = (~net_1302 & ((net_963 & ~net_948)));
  assign net_1060 = ((net_1289 & net_1055));

//---------------------------------------------------------------------------
//Block 550, LSLICE 2

  assign net_1065 = (~net_966 & ~net_1532 & ((~net_1055 & ~net_1057) | (~net_1055 & net_1057))) | (~net_966 & net_1532 & ((~net_1055 & net_1057) | (net_1055 & net_1057)));
  assign net_1064 = (net_966 & ((~net_948 & net_963)));

//---------------------------------------------------------------------------
//Block 551, MSLICE 1

  assign sig_551_lut_0 = 1'b0;
  assign sig_551_lut_1 = (~net_967 & ~net_670 & ((net_961 & net_1303))) | (~net_967 & net_670 & ((net_961 & net_1303))) | (net_967 & ~net_670 & ((net_961 & net_1303))) | (net_967 & net_670);
  assign net_1066 = (~net_247 & sig_551_lut_0) | (net_247 & sig_551_lut_1);

//---------------------------------------------------------------------------
//Block 552, LSLICE 3

  assign net_1067 = (~net_1532 & ((~net_1301 & net_1077)));
  assign net_1068 = (net_1301 & ((net_584 & net_1077)));

//---------------------------------------------------------------------------
//Block 553, LSLICE 2

  assign sig_553_lut_0 = (~io_mcu_d[2] & ~net_453 & ~i_mcu_rws & ((~net_1070 & ~net_1072) | (net_1070 & ~net_1072))) | (~io_mcu_d[2] & ~net_453 & i_mcu_rws & ((net_1070 & ~net_1072))) | (~io_mcu_d[2] & net_453 & ~i_mcu_rws & ((~net_1070 & ~net_1072) | (net_1070 & ~net_1072))) | (io_mcu_d[2] & ~net_453 & ~i_mcu_rws & ((~net_1070 & ~net_1072) | (net_1070 & ~net_1072))) | (io_mcu_d[2] & ~net_453 & i_mcu_rws & ((net_1070 & ~net_1072))) | (io_mcu_d[2] & net_453 & ~i_mcu_rws & ((~net_1070 & ~net_1072) | (net_1070 & ~net_1072))) | (io_mcu_d[2] & net_453 & i_mcu_rws & ((~net_1070 & ~net_1072) | (net_1070 & ~net_1072)));
  assign net_1072 = (~i_mcu_rws & ~net_1070 & (~(net_896 & net_1191))) | (~i_mcu_rws & net_1070 & ((net_896 & ~net_1191)));

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1070 <= sig_553_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 554, LSLICE 3

  assign sig_554_lut_0 = (~net_453 & ~net_1071 & ~i_mcu_rws) | (~net_453 & ~net_1071 & i_mcu_rws & ((~io_mcu_d[0] & net_1069) | (io_mcu_d[0] & net_1069))) | (net_453 & ~net_1071 & ~i_mcu_rws) | (net_453 & ~net_1071 & i_mcu_rws & ((io_mcu_d[0] & ~net_1069) | (io_mcu_d[0] & net_1069)));
  assign net_1071 = (~net_1194 & ~net_1069 & ((~i_mcu_rws & ~net_896) | (~i_mcu_rws & net_896))) | (~net_1194 & net_1069 & ((~i_mcu_rws & net_896))) | (net_1194 & ~net_1069 & ((~i_mcu_rws & ~net_896)));

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1069 <= sig_554_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 555, MSLICE 1

  assign sig_555_lut_0 = (~net_1521 & ~net_963) | (~net_1521 & net_963 & (~(net_470 & net_1302))) | (net_1521 & ~net_963) | (net_1521 & net_963 & (~(net_470 & net_1302)));
  assign sig_555_lut_1 = (~net_1302 & ~net_1521) | (net_1302 & ~net_1521 & (~(net_470 & net_963)));
  assign net_1073 = (~net_847 & sig_555_lut_0) | (net_847 & sig_555_lut_1);

//---------------------------------------------------------------------------
//Block 556, MSLICE 0

  assign net_1077 = ((~net_1300 & ~net_1299));
  assign net_1078 = ((net_1532 & net_1077));

//---------------------------------------------------------------------------
//Block 557, LSLICE 2

  assign sig_557_lut_0 = (~io_mcu_d[1] & ~net_453 & ~i_mcu_rws & ((~net_1075 & ~net_1076) | (net_1075 & ~net_1076))) | (~io_mcu_d[1] & ~net_453 & i_mcu_rws & ((net_1075 & ~net_1076))) | (~io_mcu_d[1] & net_453 & ~i_mcu_rws & ((~net_1075 & ~net_1076) | (net_1075 & ~net_1076))) | (io_mcu_d[1] & ~net_453 & ~i_mcu_rws & ((~net_1075 & ~net_1076) | (net_1075 & ~net_1076))) | (io_mcu_d[1] & ~net_453 & i_mcu_rws & ((net_1075 & ~net_1076))) | (io_mcu_d[1] & net_453 & ~i_mcu_rws & ((~net_1075 & ~net_1076) | (net_1075 & ~net_1076))) | (io_mcu_d[1] & net_453 & i_mcu_rws & ((~net_1075 & ~net_1076) | (net_1075 & ~net_1076)));
  assign net_1076 = (~net_1188 & ~net_1075 & ((~i_mcu_rws & ~net_896) | (~i_mcu_rws & net_896))) | (~net_1188 & net_1075 & ((~i_mcu_rws & net_896))) | (net_1188 & ~net_1075 & ((~i_mcu_rws & ~net_896)));

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1075 <= sig_557_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 558, MSLICE 1

  assign sig_558_lut_0 = (~net_453 & ~i_mcu_rws) | (~net_453 & i_mcu_rws & ((~io_mcu_d[3] & net_1074) | (io_mcu_d[3] & net_1074))) | (net_453 & ~i_mcu_rws) | (net_453 & i_mcu_rws & ((io_mcu_d[3] & ~net_1074) | (io_mcu_d[3] & net_1074)));
  assign sig_558_lut_1 = 1'b0;
  assign sig_558_ff0_d = (~net_1201 & sig_558_lut_0) | (net_1201 & sig_558_lut_1);

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1074 <= sig_558_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 559, MSLICE 0

  assign sig_559_lut_0 = (~net_1205 & net_976 & (~(net_1085 & ~net_974))) | (net_1205 & ~net_976 & (~(net_1085 & ~net_974))) | (net_1205 & net_976 & (~(net_1085 & ~net_974)));
  assign sig_559_lut_1 = (net_1205 & net_976 & (~(net_1085 & ~net_974)));
  assign net_1081 = (~net_881 & sig_559_lut_0) | (net_881 & sig_559_lut_1);

//---------------------------------------------------------------------------
//Block 560, LSLICE 2

  assign net_1082 = (~net_746 & ~net_978 & ~net_881 & ((~net_1205 & ~net_1080))) | (~net_746 & ~net_978 & net_881 & ((~net_1205 & ~net_1080) | (net_1205 & ~net_1080))) | (~net_746 & net_978 & ~net_881 & ((~net_1205 & ~net_1080) | (~net_1205 & net_1080))) | (~net_746 & net_978 & net_881) | (net_746 & net_978 & ~net_881 & ((~net_1205 & ~net_1080))) | (net_746 & net_978 & net_881 & ((~net_1205 & ~net_1080) | (net_1205 & ~net_1080)));
  assign net_1080 = ((~net_884 & net_982));

//---------------------------------------------------------------------------
//Block 561, MSLICE 1

  assign sig_561_lut_0 = (~net_994 & ~net_511 & ((~net_870 & net_1079) | (net_870 & net_1079))) | (~net_994 & net_511 & ((~net_870 & net_1079) | (net_870 & net_1079))) | (net_994 & ~net_511 & ((net_870 & ~net_1079) | (net_870 & net_1079))) | (net_994 & net_511 & ((net_870 & ~net_1079) | (net_870 & net_1079)));
  assign sig_561_lut_1 = (~net_1079 & ~net_994 & ((~net_511 & ~net_870) | (~net_511 & net_870))) | (~net_1079 & net_994 & ((~net_511 & ~net_870) | (~net_511 & net_870))) | (net_1079 & ~net_994 & ((~net_511 & ~net_870) | (~net_511 & net_870))) | (net_1079 & net_994 & ((~net_511 & ~net_870) | (~net_511 & net_870)));
  assign sig_561_ff0_d = (~net_445 & sig_561_lut_0) | (net_445 & sig_561_lut_1);

  always @(posedge gclk_4)
  begin
    net_1079 <= sig_561_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 562, MSLICE 0

  assign sig_562_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_1535 & ~net_1543) | (net_1535 & net_1543))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_1535 & net_1543) | (net_1535 & net_1543)));
  assign sig_562_lut_1 = 1'b0;
  assign net_1083 = (~net_868 & sig_562_lut_0) | (net_868 & sig_562_lut_1);

//---------------------------------------------------------------------------
//Block 563, LSLICE 2

  assign net_1087 = (~net_1099 & ~net_883 & ~net_979 & ((~net_631 & ~net_1085))) | (~net_1099 & ~net_883 & net_979 & (~(net_631 & net_1085))) | (~net_1099 & net_883 & ~net_979 & (~(net_631 & net_1085))) | (~net_1099 & net_883 & net_979 & (~(net_631 & net_1085)));
  assign net_1089 = (~net_1097 & ~net_1087 & ~net_1098 & ((~net_624 & ~net_1086))) | (~net_1097 & net_1087 & ~net_1098 & (~(net_624 & net_1086))) | (net_1097 & ~net_1087 & ~net_1098 & (~(net_624 & net_1086))) | (net_1097 & net_1087 & ~net_1098 & (~(net_624 & net_1086)));

  always @(posedge gclk_9)
  begin
    if(net_882 == 1'b1)   //enable
     begin
      net_1085 <= io_mcu_d[3];
      net_1086 <= io_mcu_d[5];
    end
  end

//---------------------------------------------------------------------------
//Block 564, LSLICE 3

  assign net_1090 = (~net_977 & ~net_1088 & ~net_624 & ((net_1086 & net_1099))) | (~net_977 & ~net_1088 & net_624 & ((net_1086 | net_1099))) | (net_977 & ~net_1088 & ~net_624 & ((net_1086 & ~net_1099) | (net_1086 & net_1099))) | (net_977 & ~net_1088 & net_624);
  assign net_1088 = ((~net_1092 & ~net_903));

//---------------------------------------------------------------------------
//Block 565, MSLICE 1

  assign sig_565_lut_0 = (~net_994 & ~net_511 & ((~net_783 & net_1084) | (net_783 & net_1084))) | (~net_994 & net_511 & ((~net_783 & net_1084) | (net_783 & net_1084))) | (net_994 & ~net_511 & ((~net_783 & ~net_1084) | (~net_783 & net_1084))) | (net_994 & net_511 & ((~net_783 & ~net_1084) | (~net_783 & net_1084)));
  assign sig_565_lut_1 = (~net_1084 & ~net_994 & ((~net_511 & ~net_783) | (~net_511 & net_783))) | (~net_1084 & net_994 & ((~net_511 & ~net_783) | (~net_511 & net_783))) | (net_1084 & ~net_994 & ((~net_511 & ~net_783) | (~net_511 & net_783))) | (net_1084 & net_994 & ((~net_511 & ~net_783) | (~net_511 & net_783)));
  assign sig_565_ff0_d = (~net_445 & sig_565_lut_0) | (net_445 & sig_565_lut_1);

  always @(posedge gclk_4)
  begin
    net_1084 <= sig_565_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 566, MSLICE 0

  assign net_1097 = ((~net_783 & ~net_1091));
  assign net_1099 = ((net_1091 & net_783));

  always @(posedge gclk_9)
  begin
    if(net_882 == 1'b1)   //enable
     begin
      net_1091 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 567, LSLICE 3

  assign net_1093 = (net_189 & ~net_1044 & ~net_904) | (net_189 & ~net_1044 & net_904 & ((~net_1534 & ~net_1544) | (~net_1534 & net_1544))) | (net_189 & net_1044 & ~net_904) | (net_189 & net_1044 & net_904 & ((~net_1534 & ~net_1544) | (net_1534 & ~net_1544)));
  assign net_1095 = (~net_1000 & ~net_925 & ~net_523 & ((net_750 | net_1093))) | (~net_1000 & net_925 & ~net_523 & ((net_750 | net_1093))) | (~net_1000 & net_925 & net_523 & ((net_750 & ~net_1093) | (net_750 & net_1093))) | (net_1000 & ~net_925 & ~net_523 & ((net_750 | net_1093))) | (net_1000 & ~net_925 & net_523 & ((~net_750 & net_1093) | (net_750 & net_1093))) | (net_1000 & net_925 & ~net_523 & ((net_750 | net_1093))) | (net_1000 & net_925 & net_523 & ((net_750 | net_1093)));

  always @(negedge gclk_4)
  begin
    net_1096 <= net_1224;
  end

//---------------------------------------------------------------------------
//Block 568, MSLICE 1

  assign net_1098 = ((net_903 & net_1092));
  assign net_1094 = (~net_1092 & ~net_1213 & ((~net_1482 & ~net_875))) | (~net_1092 & net_1213 & ((~net_1482 & net_875))) | (net_1092 & ~net_1213 & ((net_1482 & ~net_875))) | (net_1092 & net_1213 & ((net_1482 & net_875)));

  always @(posedge gclk_9)
  begin
    if(net_882 == 1'b1)   //enable
     begin
      net_1092 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 569, MSLICE 0

  assign sig_569_lut_0 = (~net_994 & ~net_511 & ((~net_903 & net_1100) | (net_903 & net_1100))) | (~net_994 & net_511 & ((~net_903 & net_1100) | (net_903 & net_1100))) | (net_994 & ~net_511 & ((~net_903 & ~net_1100) | (~net_903 & net_1100))) | (net_994 & net_511 & ((~net_903 & ~net_1100) | (~net_903 & net_1100)));
  assign sig_569_lut_1 = (~net_1100 & ~net_511) | (net_1100 & ~net_511);
  assign sig_569_ff0_d = (~net_445 & sig_569_lut_0) | (net_445 & sig_569_lut_1);

  always @(posedge gclk_4)
  begin
    net_1100 <= sig_569_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 570, LSLICE 2

  assign net_1105 = (~net_1214 & ~net_1226 & ((~net_1227 & ~net_1224)));
  assign net_1108 = (~i_adc1B_d[7] & ((~net_794 & net_820) | (net_794 & net_820))) | (i_adc1B_d[7] & ((~net_794 & net_820)));

  always @(negedge gclk_4)
  begin
    net_1103 <= net_1214;
    net_1104 <= i_adc1B_d[7];
  end

//---------------------------------------------------------------------------
//Block 571, LSLICE 3

  assign net_1107 = (net_180 & net_895 & net_181 & ((~net_643 & ~net_644)));
  assign net_1106 = (~net_1358 & ~net_1102 & ~net_1229 & ((net_1355 & ~net_1101))) | (~net_1358 & ~net_1102 & net_1229 & (~(~net_1355 & net_1101))) | (net_1358 & ~net_1102 & ~net_1229) | (net_1358 & ~net_1102 & net_1229) | (net_1358 & net_1102 & ~net_1229 & ((net_1355 & ~net_1101))) | (net_1358 & net_1102 & net_1229 & (~(~net_1355 & net_1101)));

  always @(posedge gclk_9)
  begin
    if(net_897 == 1'b1)   //enable
     begin
      net_1102 <= io_mcu_d[5];
      net_1101 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 572, MSLICE 0

  assign sig_572_lut_0 = 1'b0;
  assign sig_572_lut_1 = (~net_1552 & ~net_904 & (~(net_1212 & net_905))) | (~net_1552 & net_904 & (~(net_1212 & net_905))) | (net_1552 & ~net_904 & (~(net_1212 & net_905)));
  assign net_1114 = (~net_1490 & sig_572_lut_0) | (net_1490 & sig_572_lut_1);

//---------------------------------------------------------------------------
//Block 573, LSLICE 2

  assign sig_573_lut_0 = (~net_1370 & ~net_1354 & ~net_1110 & (~(~net_1109 & net_1106))) | (~net_1370 & ~net_1354 & net_1110) | (~net_1370 & net_1354 & ~net_1110 & ((net_1109 & ~net_1106) | (net_1109 & net_1106))) | (~net_1370 & net_1354 & net_1110 & (~(~net_1109 & net_1106))) | (net_1370 & ~net_1354 & ~net_1110 & ((net_1109 & ~net_1106))) | (net_1370 & ~net_1354 & net_1110 & ((net_1109 & ~net_1106) | (net_1109 & net_1106))) | (net_1370 & net_1354 & net_1110 & ((net_1109 & ~net_1106)));
  assign net_1112 = (~net_1370 & net_1354 & ((net_1358 & ~net_892))) | (net_1370 & ~net_1354) | (net_1370 & net_1354);

  always @(posedge gclk_6)
  begin
    if(net_1112 == 1'b0)   //enable
     begin
      net_1118 <= sig_573_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 574, LSLICE 3

  assign net_1111 = ((net_643 & ~net_644));
  assign net_1117 = ((net_249 & net_895));

  always @(posedge gclk_9)
  begin
    if(net_897 == 1'b1)   //enable
     begin
      net_1109 <= io_mcu_d[7];
      net_1110 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 575, MSLICE 1

  assign net_1116 = (net_181 & net_1111 & ((net_222 & ~net_180)));
  assign net_1113 = (net_181 & net_1111 & ((net_647 & net_180)));

  always @(posedge gclk_9)
  begin
    if(net_1116 == 1'b1)   //enable
     begin
      net_1115 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 576, MSLICE 0

  assign net_1120 = (~net_247 & ((net_668 & net_929)));
  assign net_1121 = (~net_1119 & ~net_1113 & (~(net_1553 & net_904))) | (~net_1119 & net_1113 & (~(net_1553 & net_904))) | (net_1119 & ~net_1113 & (~(net_1553 & net_904)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1119 <= 1'b0;
    end
    else
    begin
      if(net_1120 == 1'b1)   //enable
       begin
        net_1119 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 577, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_640 == 1'b1)   //enable
     begin
      net_1130 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 579, MSLICE 1

  always @(posedge gclk_9)
  begin
    if(net_1259 == 1'b1)   //enable
     begin
      net_1123 <= io_mcu_d[1];
      net_1124 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 580, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_1259 == 1'b1)   //enable
     begin
      net_1138 <= io_mcu_d[6];
      net_1137 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 577, 579, 580

  assign { net_1132, net_1127, net_1128, net_1129 } = { net_1508, net_1264, net_1263, net_1507 } + { 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 578, LSLICE 2

  assign net_1126 = (net_1523 & ((~net_247 & net_1056)));
  assign net_1125 = ((net_1122 & net_998));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1122 <= 1'b1;
    end
    else
    begin
      if(net_1126 == 1'b1)   //enable
       begin
        net_1122 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 581, LSLICE 2

  assign net_1136 = (~net_1244 & ~net_1242 & ~i_adc2B_d[0] & ((~i_adc1A_d[0] & net_1131) | (i_adc1A_d[0] & net_1131))) | (~net_1244 & ~net_1242 & i_adc2B_d[0] & ((~i_adc1A_d[0] & net_1131) | (i_adc1A_d[0] & net_1131))) | (~net_1244 & net_1242 & ~i_adc2B_d[0] & ((~i_adc1A_d[0] & net_1131) | (i_adc1A_d[0] & net_1131))) | (net_1244 & ~net_1242 & ~i_adc2B_d[0] & ((~i_adc1A_d[0] & net_1131))) | (net_1244 & ~net_1242 & i_adc2B_d[0] & ((~i_adc1A_d[0] & net_1131))) | (net_1244 & net_1242 & ~i_adc2B_d[0] & ((~i_adc1A_d[0] & net_1131)));
  assign net_1131 = (~net_831 & ~net_999) | (~net_831 & net_999 & ((~net_998 & ~net_845) | (net_998 & ~net_845))) | (net_831 & ~net_999 & ((~net_998 & ~net_845) | (~net_998 & net_845))) | (net_831 & net_999 & ((~net_998 & ~net_845)));

  always @(negedge gclk_4)
  begin
    net_1139 <= i_adc1A_d[0];
  end

//---------------------------------------------------------------------------
//Block 582, MSLICE 1

  assign net_1140 = ((~net_1348 & net_994));
  assign net_1135 = (~net_794 & ~net_1244) | (~net_794 & net_1244 & ((~i_adc1B_d[3] & ~i_adc1A_d[3]) | (i_adc1B_d[3] & ~i_adc1A_d[3]))) | (net_794 & ~net_1244 & ((~i_adc1B_d[3] & ~i_adc1A_d[3]) | (~i_adc1B_d[3] & i_adc1A_d[3]))) | (net_794 & net_1244 & ((~i_adc1B_d[3] & ~i_adc1A_d[3])));

  always @(negedge gclk_4)
  begin
    net_1133 <= net_1241;
    net_1134 <= i_adc1B_d[3];
  end

//---------------------------------------------------------------------------
//Block 583, MSLICE 0

  assign net_1141 = (net_1507 & ~net_1508 & ((~net_1264 & ~net_1263)));
  assign net_1142 = ((net_525 & net_1141));

  always @(posedge gclk_9)
  begin
    if(net_1269 == 1'b1)   //enable
     begin
      net_1143 <= io_mcu_d[6];
    end
  end

//---------------------------------------------------------------------------
//Block 584, LSLICE 2

  assign net_1145 = (net_643 & net_644 & net_181 & ((net_224 & ~net_180)));
  assign net_1149 = ((net_1145 & net_1141));

  always @(posedge gclk_9)
  begin
    if(net_1149 == 1'b1)   //enable
     begin
      net_1153 <= io_mcu_d[1];
      net_1151 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 585, LSLICE 3

  assign net_1147 = (~net_1272 & ((net_527 & net_1177))) | (net_1272 & (~(net_527 & ~net_1177)));
  assign net_1148 = (net_439 & ~net_1144 & ((~net_1141 & net_190))) | (net_439 & net_1144 & ((net_1141 | net_190)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1144 <= 1'b0;
    end
    else
    begin
      if(net_1291 == 1'b1)   //enable
       begin
        net_1144 <= net_1272;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 586, MSLICE 1

  assign net_1154 = (~net_1187 & ((~net_527 & net_1282))) | (net_1187 & ((net_527 | net_1282)));
  assign net_1146 = (~net_1170 & ((~net_527 & net_1265))) | (net_1170 & ((net_527 | net_1265)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1150 <= 1'b0;
      net_1152 <= 1'b0;
    end
    else
    begin
      if(net_1291 == 1'b1)   //enable
       begin
        net_1150 <= net_1282;
        net_1152 <= net_1265;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 587, LSLICE 2

  assign net_1160 = (~net_1283 & ~net_1141 & ~net_1296 & ((net_662 & ~net_1293) | (net_662 & net_1293))) | (~net_1283 & ~net_1141 & net_1296 & ((net_662 & ~net_1293) | (net_662 & net_1293))) | (~net_1283 & net_1141 & ~net_1296 & ((~net_662 & net_1293) | (net_662 & net_1293))) | (~net_1283 & net_1141 & net_1296 & ((~net_662 & net_1293) | (net_662 & net_1293))) | (net_1283 & ~net_1141 & net_1296) | (net_1283 & net_1141 & net_1296);
  assign net_1156 = ((net_1283 & net_1145));

  always @(posedge gclk_9)
  begin
    if(net_1156 == 1'b1)   //enable
     begin
      net_1158 <= io_mcu_d[5];
      net_1157 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//Block 588, LSLICE 3

  assign net_1165 = ((net_920 & net_1155));
  assign net_1161 = (~net_948 & net_1312 & ((~net_1182 & ~net_1302)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1166 <= 1'b1;
    end
    else
    begin
      if(net_1165 == 1'b1)   //enable
       begin
        net_1166 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 589, MSLICE 0

  assign net_1162 = (net_1155 & ((net_1047 & ~net_247)));
  assign net_1155 = (net_948 & ~net_1302 & ((net_1182 & ~net_1312)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1163 <= 1'b1;
    end
    else
    begin
      if(net_1162 == 1'b1)   //enable
       begin
        net_1163 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 590, MSLICE 1

  assign net_1164 = (~net_247 & ((net_1047 & net_961)));
  assign net_1159 = (~net_247 & ((~net_961 & ~net_960))) | (net_247 & ((~net_961 & ~net_960) | (net_961 & ~net_960)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1167 <= 1'b1;
    end
    else
    begin
      if(net_1164 == 1'b1)   //enable
       begin
        net_1167 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 591, MSLICE 0

  always @(negedge gclk_9)
  begin
    net_1173 <= net_1461;
  end

//---------------------------------------------------------------------------
//Block 592, MSLICE 1

  always @(negedge gclk_9)
  begin
    net_1172 <= net_1460;
    net_1170 <= net_1324;
  end

//---------------------------------------------------------------------------
//Block 593, MSLICE 0

  always @(negedge gclk_9)
  begin
    net_1175 <= net_1198;
    net_1176 <= net_1331;
  end

//---------------------------------------------------------------------------
//Block 594, MSLICE 1

  always @(negedge gclk_9)
  begin
    net_1181 <= net_1203;
    net_1177 <= net_1330;
  end

//---------------------------------------------------------------------------
//Block 595, MSLICE 0

  always @(negedge gclk_9)
  begin
    net_1187 <= net_1202;
    net_1193 <= net_1069;
  end

//---------------------------------------------------------------------------
//Block 598, MSLICE 1

  always @(negedge gclk_9)
  begin
    net_1195 <= net_1070;
    net_1190 <= net_1075;
  end

//---------------------------------------------------------------------------
//Block 599, MSLICE 0

  always @(negedge gclk_9)
  begin
    net_1197 <= net_1074;
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 591, 592, 593, 594, 595, 598, 599

  assign { net_1196, net_1191, net_1188, net_1194, net_1185, net_1180, net_1174, net_1178, net_1179, net_1171, net_1169, net_1168 } = { net_1074, net_1070, 1'b0, 1'b0, net_1202, net_1330, 1'b0, 1'b0, 1'b0, net_1324, 1'b0, net_1461 } + { 1'b0, 1'b0, net_1075, net_1069, 1'b0, 1'b0, net_1203, net_1331, net_1198, 1'b0, net_1460, 1'b1 };

//---------------------------------------------------------------------------
//Block 596, LSLICE 2

  assign net_1189 = (net_1299 & ~net_1186 & ~net_1301 & ((~net_1300 & net_1184) | (net_1300 & net_1184))) | (net_1299 & ~net_1186 & net_1301 & ((~net_1300 & net_1184) | (net_1300 & net_1184))) | (net_1299 & net_1186 & ~net_1301 & ((net_1300 | net_1184))) | (net_1299 & net_1186 & net_1301);
  assign net_1184 = (~net_247 & ~net_1301 & ~net_1532 & ((net_1300 & net_967))) | (~net_247 & ~net_1301 & net_1532 & ((net_1300 & net_967))) | (~net_247 & net_1301 & ~net_1532 & ((net_1300 & net_967))) | (~net_247 & net_1301 & net_1532 & ((~net_1300 & net_967) | (net_1300 & net_967)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1186 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_1186 <= net_1320;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 597, LSLICE 3

  assign net_1183 = (~net_1312 & ~net_1302 & ~net_1078 & ((net_948 | net_1182))) | (~net_1312 & ~net_1302 & net_1078 & ((net_948 | net_1182))) | (~net_1312 & net_1302 & ~net_1078) | (~net_1312 & net_1302 & net_1078) | (net_1312 & ~net_1302 & ~net_1078 & (~(net_948 ^ net_1182))) | (net_1312 & ~net_1302 & net_1078 & (~(net_948 ^ net_1182))) | (net_1312 & net_1302 & ~net_1078) | (net_1312 & net_1302 & net_1078 & ((net_948 | net_1182)));
  assign net_1192 = (~net_1064 & ~net_1057 & net_859 & (~(net_1289 & ~net_1183)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1182 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_1182 <= net_1309;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 600, LSLICE 2

  assign sig_600_lut_0 = (~io_mcu_d[3] & ~net_1142 & ~i_mcu_rws & ((~net_1198 & ~net_1199) | (net_1198 & ~net_1199))) | (~io_mcu_d[3] & ~net_1142 & i_mcu_rws & ((net_1198 & ~net_1199))) | (~io_mcu_d[3] & net_1142 & ~i_mcu_rws & ((~net_1198 & ~net_1199) | (net_1198 & ~net_1199))) | (io_mcu_d[3] & ~net_1142 & ~i_mcu_rws & ((~net_1198 & ~net_1199) | (net_1198 & ~net_1199))) | (io_mcu_d[3] & ~net_1142 & i_mcu_rws & ((net_1198 & ~net_1199))) | (io_mcu_d[3] & net_1142 & ~i_mcu_rws & ((~net_1198 & ~net_1199) | (net_1198 & ~net_1199))) | (io_mcu_d[3] & net_1142 & i_mcu_rws & ((~net_1198 & ~net_1199) | (net_1198 & ~net_1199)));
  assign net_1199 = (~net_1179 & ~net_1198 & ((~i_mcu_rws & ~net_896) | (~i_mcu_rws & net_896))) | (~net_1179 & net_1198 & ((~i_mcu_rws & net_896))) | (net_1179 & ~net_1198 & ((~i_mcu_rws & ~net_896)));

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1198 <= sig_600_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 601, MSLICE 1

  assign net_1201 = (~net_896 & ~i_mcu_rws & ((~net_1074 & ~net_1196) | (~net_1074 & net_1196))) | (net_896 & ~i_mcu_rws & ((~net_1074 & ~net_1196) | (net_1074 & ~net_1196)));
  assign net_1200 = (~net_896 & ~i_mcu_rws & ((~net_1202 & ~net_1185) | (~net_1202 & net_1185))) | (net_896 & ~i_mcu_rws & ((~net_1202 & ~net_1185) | (net_1202 & ~net_1185)));

//---------------------------------------------------------------------------
//Block 602, MSLICE 0

  assign sig_602_lut_0 = (~net_1142 & ~i_mcu_rws) | (~net_1142 & i_mcu_rws & ((~io_mcu_d[7] & net_1202) | (io_mcu_d[7] & net_1202))) | (net_1142 & ~i_mcu_rws) | (net_1142 & i_mcu_rws & ((io_mcu_d[7] & ~net_1202) | (io_mcu_d[7] & net_1202)));
  assign sig_602_lut_1 = 1'b0;
  assign sig_602_ff0_d = (~net_1200 & sig_602_lut_0) | (net_1200 & sig_602_lut_1);

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1202 <= sig_602_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 603, LSLICE 2

  assign sig_603_lut_0 = (~io_mcu_d[5] & ~net_1142 & ~i_mcu_rws & ((~net_1203 & ~net_1204) | (net_1203 & ~net_1204))) | (~io_mcu_d[5] & ~net_1142 & i_mcu_rws & ((net_1203 & ~net_1204))) | (~io_mcu_d[5] & net_1142 & ~i_mcu_rws & ((~net_1203 & ~net_1204) | (net_1203 & ~net_1204))) | (io_mcu_d[5] & ~net_1142 & ~i_mcu_rws & ((~net_1203 & ~net_1204) | (net_1203 & ~net_1204))) | (io_mcu_d[5] & ~net_1142 & i_mcu_rws & ((net_1203 & ~net_1204))) | (io_mcu_d[5] & net_1142 & ~i_mcu_rws & ((~net_1203 & ~net_1204) | (net_1203 & ~net_1204))) | (io_mcu_d[5] & net_1142 & i_mcu_rws & ((~net_1203 & ~net_1204) | (net_1203 & ~net_1204)));
  assign net_1204 = (~net_896 & ~net_1203 & ((~i_mcu_rws & ~net_1174) | (~i_mcu_rws & net_1174))) | (net_896 & ~net_1203 & ((~i_mcu_rws & ~net_1174))) | (net_896 & net_1203 & ((~i_mcu_rws & ~net_1174)));

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1203 <= sig_603_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 608, MSLICE 0

  assign sig_608_lut_0 = (~net_1091 & ~net_1334 & (~(net_974 & ~net_1085))) | (net_1091 & ~net_1334 & (~(net_974 & ~net_1085))) | (net_1091 & net_1334 & (~(net_974 & ~net_1085)));
  assign sig_608_lut_1 = 1'b0;
  assign net_1208 = (~net_1081 & sig_608_lut_0) | (net_1081 & sig_608_lut_1);

//---------------------------------------------------------------------------
//Block 609, LSLICE 2

  assign net_1207 = (~net_1091 & ~net_1334 & ~net_974 & ((~net_1085 & ~net_1206) | (net_1085 & ~net_1206))) | (~net_1091 & ~net_1334 & net_974 & ((net_1085 & ~net_1206))) | (net_1091 & ~net_1334 & ~net_974) | (net_1091 & ~net_1334 & net_974) | (net_1091 & net_1334 & ~net_974 & ((~net_1085 & ~net_1206) | (net_1085 & ~net_1206))) | (net_1091 & net_1334 & net_974 & ((net_1085 & ~net_1206)));
  assign net_1206 = (~net_1082 & ~net_1205 & ~net_974 & ((~net_1085 & ~net_881))) | (~net_1082 & ~net_1205 & net_974 & ((~net_1085 & ~net_881) | (net_1085 & ~net_881))) | (~net_1082 & net_1205 & ~net_974 & ((~net_1085 & ~net_881) | (~net_1085 & net_881))) | (~net_1082 & net_1205 & net_974);

//---------------------------------------------------------------------------
//Block 610, MSLICE 1

  assign sig_610_lut_0 = (~net_994 & ~net_511 & ((~net_981 & net_1205) | (net_981 & net_1205))) | (~net_994 & net_511 & ((~net_981 & net_1205) | (net_981 & net_1205))) | (net_994 & ~net_511 & ((net_981 & ~net_1205) | (net_981 & net_1205))) | (net_994 & net_511 & ((net_981 & ~net_1205) | (net_981 & net_1205)));
  assign sig_610_lut_1 = (~net_1205 & ~net_511) | (net_1205 & ~net_511);
  assign sig_610_ff0_d = (~net_445 & sig_610_lut_0) | (net_445 & sig_610_lut_1);

  always @(posedge gclk_4)
  begin
    net_1205 <= sig_610_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 611, MSLICE 0

  assign sig_611_lut_0 = (~net_1044 & ~net_189) | (~net_1044 & net_189 & ((net_1538 & ~net_1545) | (net_1538 & net_1545))) | (net_1044 & ~net_189) | (net_1044 & net_189 & ((~net_1538 & net_1545) | (net_1538 & net_1545)));
  assign sig_611_lut_1 = 1'b0;
  assign net_1209 = (~net_869 & sig_611_lut_0) | (net_869 & sig_611_lut_1);

//---------------------------------------------------------------------------
//Block 612, LSLICE 3

  assign net_1212 = (~net_1044 & ~net_1210 & ~net_189) | (~net_1044 & ~net_1210 & net_189 & ((net_1539 & ~net_1548) | (net_1539 & net_1548))) | (net_1044 & ~net_1210 & ~net_189) | (net_1044 & ~net_1210 & net_189 & ((~net_1539 & net_1548) | (net_1539 & net_1548)));
  assign net_1210 = (~net_698 & ~net_704 & ((~net_1044 & ~net_189) | (net_1044 & ~net_189))) | (~net_698 & net_704 & ((~net_1044 & ~net_189))) | (net_698 & ~net_704 & ((net_1044 & ~net_189)));

  always @(negedge gclk_4)
  begin
    net_1211 <= net_1234;
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 613, 616, 617, 619, 620, 621, 623

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      { net_1241, net_1231, net_1233, net_1232, net_1234, net_1223, net_1226, net_1224, net_1227, net_1214, net_1216, net_1215 } <= { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      { net_1241, net_1231, net_1233, net_1232, net_1234, net_1223, net_1226, net_1224, net_1227, net_1214, net_1216, net_1215 } <= { net_1241, net_1231, net_1233, net_1232, net_1234, net_1223, net_1226, net_1224, net_1227, net_1214, net_1216, net_1215 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
    end
  end

//---------------------------------------------------------------------------
//Block 614, LSLICE 2

  assign net_1220 = (net_1344 & ~net_1089 & ~net_1088 & ((~net_623 & ~net_1213))) | (net_1344 & ~net_1089 & net_1088 & (~(net_623 & net_1213))) | (net_1344 & net_1089 & ~net_1088 & (~(net_623 & net_1213))) | (net_1344 & net_1089 & net_1088 & (~(net_623 & net_1213)));
  assign net_1221 = (~net_623 & net_1213 & ~net_1098 & ((net_1090 & net_1343))) | (~net_623 & net_1213 & net_1098 & ((~net_1090 & net_1343) | (net_1090 & net_1343))) | (net_623 & ~net_1213 & ~net_1098 & ((net_1090 & net_1343))) | (net_623 & ~net_1213 & net_1098 & ((~net_1090 & net_1343) | (net_1090 & net_1343))) | (net_623 & net_1213 & ~net_1098 & ((~net_1090 & net_1343) | (net_1090 & net_1343))) | (net_623 & net_1213 & net_1098 & ((~net_1090 & net_1343) | (net_1090 & net_1343)));

  always @(posedge gclk_9)
  begin
    if(net_882 == 1'b1)   //enable
     begin
      net_1213 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//Block 615, LSLICE 3

  assign net_1222 = (net_1233 & ~net_1217 & ~net_1232 & ((net_1234 & net_1231))) | (net_1233 & ~net_1217 & net_1232 & ((~net_1234 & net_1231) | (net_1234 & net_1231))) | (net_1233 & net_1217 & ~net_1232 & ((~net_1234 & net_1231) | (net_1234 & net_1231))) | (net_1233 & net_1217 & net_1232 & ((~net_1234 & net_1231) | (net_1234 & net_1231)));
  assign net_1217 = (net_1223 & ~net_1216 & (~(net_1105 & ~net_1215))) | (net_1223 & net_1216);

  always @(negedge gclk_4)
  begin
    net_1218 <= net_1231;
    net_1219 <= net_1215;
  end

//---------------------------------------------------------------------------
//Block 618, LSLICE 2

  assign net_1229 = (~net_1230 & ~net_1351 & ~net_1359 & ((~net_899 & net_1228))) | (~net_1230 & ~net_1351 & net_1359 & (~(net_899 & ~net_1228))) | (~net_1230 & net_1351 & ~net_1359 & ((~net_899 & ~net_1228) | (~net_899 & net_1228))) | (~net_1230 & net_1351 & net_1359) | (net_1230 & ~net_1351 & net_1359 & ((~net_899 & ~net_1228) | (~net_899 & net_1228))) | (net_1230 & net_1351 & ~net_1359 & ((~net_899 & net_1228))) | (net_1230 & net_1351 & net_1359 & (~(net_899 & ~net_1228)));
  assign net_1228 = (~net_898 & ~net_1353 & ((~net_1352 & ~net_1225) | (net_1352 & ~net_1225))) | (~net_898 & net_1353) | (net_898 & ~net_1353 & ((net_1352 & ~net_1225))) | (net_898 & net_1353 & (~(~net_1352 & net_1225)));

  always @(posedge gclk_9)
  begin
    if(net_897 == 1'b1)   //enable
     begin
      net_1230 <= io_mcu_d[2];
      net_1225 <= io_mcu_d[1];
    end
  end

//---------------------------------------------------------------------------
//Block 622, LSLICE 3

  assign net_1238 = (~net_1244 & net_1235 & ~i_adc1A_d[5] & (~(net_1043 & net_906))) | (~net_1244 & net_1235 & i_adc1A_d[5] & (~(net_1043 & net_906))) | (net_1244 & net_1235 & ~i_adc1A_d[5] & (~(net_1043 & net_906)));
  assign net_1235 = (~i_adc2A_d[5] & ~net_1242) | (~i_adc2A_d[5] & net_1242 & ((~i_adc2B_d[5] & ~net_1251) | (~i_adc2B_d[5] & net_1251))) | (i_adc2A_d[5] & ~net_1242 & ((~i_adc2B_d[5] & ~net_1251) | (i_adc2B_d[5] & ~net_1251))) | (i_adc2A_d[5] & net_1242 & ((~i_adc2B_d[5] & ~net_1251)));

  always @(negedge gclk_4)
  begin
    net_1237 <= i_adc1A_d[5];
    net_1236 <= i_adc2A_d[5];
  end

//---------------------------------------------------------------------------
//Block 624, LSLICE 2

  assign net_1240 = (net_1017 & ~net_1251 & ~i_adc2B_d[2]) | (net_1017 & ~net_1251 & i_adc2B_d[2] & ((~i_adc2A_d[2] & ~net_1242) | (i_adc2A_d[2] & ~net_1242))) | (net_1017 & net_1251 & ~i_adc2B_d[2] & ((~i_adc2A_d[2] & ~net_1242) | (~i_adc2A_d[2] & net_1242))) | (net_1017 & net_1251 & i_adc2B_d[2] & ((~i_adc2A_d[2] & ~net_1242)));
  assign net_1247 = (~net_1513 & net_1240 & ~net_1125 & (~(i_adc1A_d[2] & net_1244)));

  always @(negedge gclk_4)
  begin
    net_1248 <= i_adc2A_d[2];
    net_1250 <= i_adc1A_d[2];
  end

//---------------------------------------------------------------------------
//Block 625, MSLICE 1

  assign net_1244 = (net_536 & net_308 & ((~net_181 & ~net_180)));
  assign net_1242 = (net_536 & net_180 & ((net_181 & net_308)));

  always @(negedge gclk_4)
  begin
    net_1246 <= i_adc2B_d[0];
    net_1243 <= i_adc2B_d[5];
  end

//---------------------------------------------------------------------------
//Block 626, LSLICE 3

  assign net_1249 = (~net_1360 & ~net_1255 & ((~net_1356 & ~net_1239)));
  assign net_1245 = ((net_823 & net_1500));

  always @(posedge gclk_0)
  begin
    if(net_1498 == 1'b1)   //reset
    begin
      net_1239 <= 1'b0;
    end
    else
    begin
      net_1239 <= net_1366;
    end
  end

//---------------------------------------------------------------------------
//Block 627, MSLICE 0

  assign net_1258 = (~net_1251 & ~i_adc2A_d[0] & (~(i_adc1B_d[0] & net_794))) | (~net_1251 & i_adc2A_d[0] & (~(i_adc1B_d[0] & net_794))) | (net_1251 & ~i_adc2A_d[0] & (~(i_adc1B_d[0] & net_794)));
  assign net_1251 = ((net_536 & net_249));

  always @(negedge gclk_4)
  begin
    net_1257 <= i_adc2A_d[0];
    net_1254 <= i_adc2B_d[2];
  end

//---------------------------------------------------------------------------
//Block 628, LSLICE 2

  assign net_1253 = (~net_1372 & ~net_1382 & ~net_1256 & ((~net_1497 & net_1252)));
  assign net_1252 = (~net_1369 & ~net_1381 & ((~net_1363 & ~net_1357)));

  always @(posedge gclk_0)
  begin
    if(net_1498 == 1'b1)   //reset
    begin
      net_1256 <= 1'b0;
      net_1255 <= 1'b0;
    end
    else
    begin
      net_1256 <= net_1374;
      net_1255 <= net_1365;
    end
  end

//---------------------------------------------------------------------------
//Block 629, LSLICE 3

  assign net_1262 = (~i_mcu_rws & ~net_1127 & ~net_632) | (~i_mcu_rws & ~net_1127 & net_632) | (~i_mcu_rws & net_1127 & ~net_632 & ((~net_1264 & net_778) | (net_1264 & net_778))) | (~i_mcu_rws & net_1127 & net_632 & ((~net_1264 & net_778) | (net_1264 & net_778))) | (i_mcu_rws & ~net_1127 & ~net_632) | (i_mcu_rws & ~net_1127 & net_632 & ((~net_1264 & ~net_778) | (~net_1264 & net_778))) | (i_mcu_rws & net_1127 & net_632 & ((~net_1264 & ~net_778) | (~net_1264 & net_778)));
  assign net_1259 = (net_1507 & net_1145 & net_1263 & ((~net_1508 & ~net_1264)));

  always @(posedge gclk_9)
  begin
    if(net_1259 == 1'b1)   //enable
     begin
      net_1261 <= io_mcu_d[5];
      net_1260 <= io_mcu_d[0];
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 630, 633, 634, 636, 637, 638, 640

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      { net_1288, net_1279, net_1281, net_1280, net_1282, net_1272, net_1274, net_1273, net_1275, net_1265, net_1267, net_1266 } <= { 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      if(net_994 == 1'b1)   //enable
      begin
        { net_1288, net_1279, net_1281, net_1280, net_1282, net_1272, net_1274, net_1273, net_1275, net_1265, net_1267, net_1266 } <= { net_1288, net_1279, net_1281, net_1280, net_1282, net_1272, net_1274, net_1273, net_1275, net_1265, net_1267, net_1266 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
      end
    end
  end

//---------------------------------------------------------------------------
//Block 631, LSLICE 2

  assign sig_631_lut_0 = (~net_778 & ~i_mcu_dcs & ~i_mcu_rws & ((~net_1262 & ~net_1264) | (~net_1262 & net_1264))) | (~net_778 & ~i_mcu_dcs & i_mcu_rws & ((~net_1262 & ~net_1264) | (~net_1262 & net_1264))) | (~net_778 & i_mcu_dcs & ~i_mcu_rws & ((~net_1262 & net_1264) | (net_1262 & net_1264))) | (net_778 & ~i_mcu_dcs & ~i_mcu_rws & (~(net_1262 & ~net_1264))) | (net_778 & ~i_mcu_dcs & i_mcu_rws & ((~net_1262 & ~net_1264) | (~net_1262 & net_1264))) | (net_778 & i_mcu_dcs & ~i_mcu_rws & ((~net_1262 & net_1264) | (net_1262 & net_1264)));
  assign sig_631_lut_1 = (~net_778 & ~i_mcu_dcs & ~i_mcu_rws & ((~net_1268 & ~net_1263) | (~net_1268 & net_1263))) | (~net_778 & ~i_mcu_dcs & i_mcu_rws & ((~net_1268 & ~net_1263) | (~net_1268 & net_1263))) | (~net_778 & i_mcu_dcs & ~i_mcu_rws & ((~net_1268 & net_1263) | (net_1268 & net_1263))) | (net_778 & ~i_mcu_dcs & ~i_mcu_rws & (~(net_1268 & ~net_1263))) | (net_778 & ~i_mcu_dcs & i_mcu_rws & ((~net_1268 & ~net_1263) | (~net_1268 & net_1263))) | (net_778 & i_mcu_dcs & ~i_mcu_rws & ((~net_1268 & net_1263) | (net_1268 & net_1263)));

  always @(posedge gclk_9)
  begin
    net_1264 <= sig_631_lut_0;
    net_1263 <= sig_631_lut_1;
  end

//---------------------------------------------------------------------------
//Block 632, LSLICE 3

  assign net_1268 = (~i_mcu_rws & ~net_1128 & ~net_632) | (~i_mcu_rws & ~net_1128 & net_632) | (~i_mcu_rws & net_1128 & ~net_632 & ((~net_1263 & net_778) | (net_1263 & net_778))) | (~i_mcu_rws & net_1128 & net_632 & ((~net_1263 & net_778) | (net_1263 & net_778))) | (i_mcu_rws & ~net_1128 & ~net_632) | (i_mcu_rws & ~net_1128 & net_632 & ((~net_1263 & ~net_778) | (~net_1263 & net_778))) | (i_mcu_rws & net_1128 & net_632 & ((~net_1263 & ~net_778) | (~net_1263 & net_778)));
  assign net_1269 = (~net_1508 & net_1145 & ~net_1264 & ((net_1263 & ~net_1507)));

  always @(posedge gclk_9)
  begin
    if(net_1269 == 1'b1)   //enable
     begin
      net_1271 <= io_mcu_d[1];
      net_1270 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 635, LSLICE 2

  assign net_1277 = (net_1521 & ((~net_247 & net_1276)));
  assign net_1276 = (~net_1532 & ~net_1299 & ((net_1300 & ~net_1301)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1278 <= 1'b1;
    end
    else
    begin
      if(net_1277 == 1'b1)   //enable
       begin
        net_1278 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 639, LSLICE 3

  assign net_1283 = (~net_1264 & ~net_1508 & ((~net_1507 & ~net_1263)));
  assign net_1286 = (~net_1292 & ~net_1034 & ((net_439 & ~net_1283))) | (net_1292 & ~net_1034 & ((net_439 & ~net_1283) | (net_439 & net_1283)));

  always @(posedge gclk_9)
  begin
    if(net_1156 == 1'b1)   //enable
     begin
      net_1285 <= io_mcu_d[1];
      net_1284 <= io_mcu_d[2];
    end
  end

//---------------------------------------------------------------------------
//Block 641, LSLICE 2

  assign net_1294 = (~net_1190 & ((net_1281 & ~net_527))) | (net_1190 & ((net_1281 | net_527)));
  assign net_1291 = ~net_1348;

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1296 <= 1'b0;
      net_1297 <= 1'b0;
    end
    else
    begin
      if(net_1291 == 1'b1)   //enable
       begin
        net_1296 <= net_1281;
        net_1297 <= net_1266;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 642, LSLICE 3

  assign net_1295 = (net_1531 & ~net_1062 & ~net_1314 & ((~net_1311 & ~net_1287)));
  assign net_1289 = (net_1531 & ~net_1287 & ~net_1186 & ((~net_1311 & ~net_1314)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1287 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_1287 <= net_1316;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 643, MSLICE 1

  assign net_1298 = (~net_1193 & ((~net_527 & net_1280))) | (net_1193 & ((net_527 | net_1280)));
  assign net_1290 = (~net_1172 & ((~net_527 & net_1267))) | (net_1172 & ((net_527 | net_1267)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1292 <= 1'b0;
      net_1293 <= 1'b0;
    end
    else
    begin
      if(net_1291 == 1'b1)   //enable
       begin
        net_1292 <= net_1280;
        net_1293 <= net_1267;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 644, LSLICE 2

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1301 <= 1'b0;
      net_1300 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_1301 <= net_1305;
        net_1300 <= net_1304;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 645, LSLICE 3

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1299 <= 1'b0;
      net_1302 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_1299 <= net_1307;
        net_1302 <= net_1306;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 647, LSLICE 2

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1314 <= 1'b0;
      net_1312 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_1314 <= net_1322;
        net_1312 <= net_1318;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 648, LSLICE 3

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1311 <= 1'b0;
      net_1313 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_1311 <= net_1321;
        net_1313 <= net_1317;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 649, LSLICE 2

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1323 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_1323 <= net_1328;
      end
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 644, 645, 647, 648, 649

  assign { net_1328, net_1315, net_1319, net_1317, net_1321, net_1322, net_1316, net_1320, net_1318, net_1309, net_1310, net_1306, net_1307, net_1304, net_1305, net_1308 } = { net_1323, net_1529, net_1325, net_1313, net_1311, net_1314, net_1287, net_1186, net_1312, net_1182, net_948, net_1302, net_1299, net_1300, net_1301, net_1532 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 646, MSLICE 1

  assign sig_646_lut_0 = 1'b0;
  assign sig_646_lut_1 = (net_1300 & ~net_1532 & ((net_1289 & ~net_1301)));
  assign net_1303 = (~net_1299 & sig_646_lut_0) | (net_1299 & sig_646_lut_1);

//---------------------------------------------------------------------------
//Block 650, LSLICE 3

  assign sig_650_lut_0 = (~net_1142 & ~net_1326 & ~i_mcu_rws) | (~net_1142 & ~net_1326 & i_mcu_rws & ((~io_mcu_d[2] & net_1324) | (io_mcu_d[2] & net_1324))) | (net_1142 & ~net_1326 & ~i_mcu_rws) | (net_1142 & ~net_1326 & i_mcu_rws & ((io_mcu_d[2] & ~net_1324) | (io_mcu_d[2] & net_1324)));
  assign net_1326 = (~net_896 & ~net_1324 & ((~net_1171 & ~i_mcu_rws) | (net_1171 & ~i_mcu_rws))) | (net_896 & ~net_1324 & ((~net_1171 & ~i_mcu_rws))) | (net_896 & net_1324 & ((~net_1171 & ~i_mcu_rws)));

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1324 <= sig_650_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 651, MSLICE 1

  assign net_1327 = (~net_1313 & ~net_1311 & ((net_1052 & net_1325))) | (~net_1313 & net_1311 & ((~net_1052 & net_1325) | (net_1052 & net_1325))) | (net_1313 & ~net_1311 & ((~net_1052 & net_1325) | (net_1052 & net_1325))) | (net_1313 & net_1311 & ((~net_1052 & net_1325) | (net_1052 & net_1325)));
  assign net_1329 = (net_1302 & net_1312 & ((~net_948 & ~net_1182)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1325 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_1325 <= net_1319;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 652, MSLICE 0

  assign sig_652_lut_0 = (~net_1142 & ~i_mcu_rws) | (~net_1142 & i_mcu_rws & ((~io_mcu_d[6] & net_1330) | (io_mcu_d[6] & net_1330))) | (net_1142 & ~i_mcu_rws) | (net_1142 & i_mcu_rws & ((io_mcu_d[6] & ~net_1330) | (io_mcu_d[6] & net_1330)));
  assign sig_652_lut_1 = 1'b0;
  assign sig_652_ff0_d = (~net_1033 & sig_652_lut_0) | (net_1033 & sig_652_lut_1);

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1330 <= sig_652_ff0_d;
    end
  end

//---------------------------------------------------------------------------
//Block 653, LSLICE 2

  assign sig_653_lut_0 = (~io_mcu_d[4] & ~net_1142 & ~i_mcu_rws & ((~net_1331 & ~net_1332) | (net_1331 & ~net_1332))) | (~io_mcu_d[4] & ~net_1142 & i_mcu_rws & ((net_1331 & ~net_1332))) | (~io_mcu_d[4] & net_1142 & ~i_mcu_rws & ((~net_1331 & ~net_1332) | (net_1331 & ~net_1332))) | (io_mcu_d[4] & ~net_1142 & ~i_mcu_rws & ((~net_1331 & ~net_1332) | (net_1331 & ~net_1332))) | (io_mcu_d[4] & ~net_1142 & i_mcu_rws & ((net_1331 & ~net_1332))) | (io_mcu_d[4] & net_1142 & ~i_mcu_rws & ((~net_1331 & ~net_1332) | (net_1331 & ~net_1332))) | (io_mcu_d[4] & net_1142 & i_mcu_rws & ((~net_1331 & ~net_1332) | (net_1331 & ~net_1332)));
  assign net_1332 = (~net_896 & ~net_1331 & ((~i_mcu_rws & ~net_1178) | (~i_mcu_rws & net_1178))) | (net_896 & ~net_1331 & ((~i_mcu_rws & ~net_1178))) | (net_896 & net_1331 & ((~i_mcu_rws & ~net_1178)));

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1331 <= sig_653_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 654, MSLICE 1

  assign sig_654_lut_0 = 1'b0;
  assign sig_654_lut_1 = (net_1302 & net_948 & ((~net_1312 & net_1182)));
  assign net_1333 = (~net_1289 & sig_654_lut_0) | (net_1289 & sig_654_lut_1);

//---------------------------------------------------------------------------
//Block 655, MSLICE 0

  assign sig_655_lut_0 = (~net_994 & ~net_511 & ((~net_1084 & net_1334) | (net_1084 & net_1334))) | (~net_994 & net_511 & ((~net_1084 & net_1334) | (net_1084 & net_1334))) | (net_994 & ~net_511 & ((net_1084 & ~net_1334) | (net_1084 & net_1334))) | (net_994 & net_511 & ((net_1084 & ~net_1334) | (net_1084 & net_1334)));
  assign sig_655_lut_1 = (~net_1334 & ~net_511) | (net_1334 & ~net_511);
  assign sig_655_ff0_d = (~net_445 & sig_655_lut_0) | (net_445 & sig_655_lut_1);

  always @(posedge gclk_4)
  begin
    net_1334 <= sig_655_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 656, LSLICE 3

  assign net_1335 = (~net_1208 & ~net_1477 & net_1086 & ((~net_1079 & net_1094))) | (~net_1208 & net_1477 & ~net_1086 & ((~net_1079 & net_1094))) | (~net_1208 & net_1477 & net_1086 & ((~net_1079 & net_1094) | (net_1079 & net_1094))) | (net_1208 & ~net_1477 & ~net_1086 & ((~net_1079 & net_1094))) | (net_1208 & ~net_1477 & net_1086 & ((~net_1079 & net_1094) | (net_1079 & net_1094))) | (net_1208 & net_1477 & ~net_1086 & ((~net_1079 & net_1094))) | (net_1208 & net_1477 & net_1086 & ((~net_1079 & net_1094) | (net_1079 & net_1094)));
  assign net_1336 = (~net_1086 & ~net_1079 & net_1342 & (~(~net_1207 & net_1094))) | (~net_1086 & net_1079 & net_1342 & ((~net_1207 & ~net_1094) | (net_1207 & ~net_1094))) | (net_1086 & ~net_1079 & net_1342) | (net_1086 & net_1079 & net_1342 & (~(~net_1207 & net_1094)));

//---------------------------------------------------------------------------
//Block 657, MSLICE 0

  assign sig_657_lut_0 = ~net_1337;
  assign net_1338 = (~net_1473 & (~(net_1476 & ~net_1481))) | (net_1473);

  always @(posedge gclk_2)
  begin
    if(net_1338 == 1'b1)   //enable
     begin
      net_1337 <= sig_657_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 658, LSLICE 2

  assign net_1339 = (~net_1092 & ~net_1213 & ~net_1482 & ((~net_875 & ~net_1350) | (net_875 & ~net_1350))) | (~net_1092 & ~net_1213 & net_1482 & ((~net_875 & ~net_1350) | (net_875 & ~net_1350))) | (~net_1092 & net_1213 & ~net_1482 & ((net_875 & ~net_1350))) | (~net_1092 & net_1213 & net_1482 & ((net_875 & ~net_1350))) | (net_1092 & ~net_1213 & ~net_1482 & ((net_875 & ~net_1350))) | (net_1092 & ~net_1213 & net_1482 & ((~net_875 & ~net_1350) | (net_875 & ~net_1350))) | (net_1092 & net_1213 & net_1482 & ((net_875 & ~net_1350)));
  assign net_1342 = (~net_1213 & ~net_875 & ~net_1482 & ((~net_1092 & ~net_1350) | (net_1092 & ~net_1350))) | (~net_1213 & ~net_875 & net_1482 & ((net_1092 & ~net_1350))) | (net_1213 & ~net_875 & ~net_1482 & ((~net_1092 & ~net_1350) | (net_1092 & ~net_1350))) | (net_1213 & ~net_875 & net_1482 & ((~net_1092 & ~net_1350) | (net_1092 & ~net_1350))) | (net_1213 & net_875 & ~net_1482 & ((~net_1092 & ~net_1350) | (net_1092 & ~net_1350))) | (net_1213 & net_875 & net_1482 & ((net_1092 & ~net_1350)));

//---------------------------------------------------------------------------
//Block 659, LSLICE 3

  assign net_1341 = (net_778 & net_649 & ~net_1242 & ((~net_1251 & ~net_794)));
  assign net_1345 = (net_1021 & ~i_adc2B_d[3] & ~net_1242 & (~(i_adc2A_d[3] & net_1251))) | (net_1021 & ~i_adc2B_d[3] & net_1242 & (~(i_adc2A_d[3] & net_1251))) | (net_1021 & i_adc2B_d[3] & ~net_1242 & (~(i_adc2A_d[3] & net_1251)));

  always @(negedge gclk_4)
  begin
    net_1346 <= i_adc2B_d[3];
    net_1340 <= i_adc2A_d[3];
  end

//---------------------------------------------------------------------------
//Block 660, MSLICE 1

  assign net_1344 = (~net_1335 & ((~net_511 & ~net_1339))) | (net_1335 & ((~net_511 & ~net_1339) | (~net_511 & net_1339)));
  assign net_1343 = ((~net_1336 & net_511));

//---------------------------------------------------------------------------
//Block 661, LSLICE 2

  assign sig_661_lut_0 = ~net_1347;
  assign net_1349 = ((net_249 & net_309));

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //enable
     begin
      net_1347 <= sig_661_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 662, LSLICE 3

  assign sig_662_lut_0 = (~net_1221 & ((net_1220 | net_1348))) | (net_1221);
  assign sig_662_lut_1 = ((net_1343 | net_1344));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1348 <= 1'b0;
      net_1350 <= 1'b0;
    end
    else
    begin
      if(net_1140 == 1'b1)   //enable
       begin
        net_1348 <= sig_662_lut_0;
        net_1350 <= sig_662_lut_1;
      end
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 663, 664, 665, 667, 669

  always @(posedge gclk_6)
  begin
    if(net_1112 == 1'b1)   //reset
    begin
      { net_1370, net_1354, net_1358, net_1355, net_1359, net_1351, net_1353, net_1352 } <= { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      { net_1370, net_1354, net_1358, net_1355, net_1359, net_1351, net_1353, net_1352 } <= { net_1370, net_1354, net_1358, net_1355, net_1359, net_1351, net_1353, net_1352 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
    end
  end

//---------------------------------------------------------------------------
//Block 666, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_1498 == 1'b1)   //reset
    begin
      net_1363 <= 1'b0;
      net_1357 <= 1'b0;
    end
    else
    begin
      net_1363 <= net_1368;
      net_1357 <= net_1361;
    end
  end

//---------------------------------------------------------------------------
//Block 668, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_1498 == 1'b1)   //reset
    begin
      net_1356 <= 1'b0;
      net_1360 <= 1'b0;
    end
    else
    begin
      net_1356 <= net_1367;
      net_1360 <= net_1364;
    end
  end

//---------------------------------------------------------------------------
//Block 670, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_1498 == 1'b1)   //reset
    begin
      net_1381 <= 1'b0;
      net_1371 <= 1'b0;
    end
    else
    begin
      net_1381 <= net_1380;
      net_1371 <= net_1376;
    end
  end

//---------------------------------------------------------------------------
//Block 671, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_1498 == 1'b1)   //reset
    begin
      net_1369 <= 1'b0;
      net_1372 <= 1'b0;
    end
    else
    begin
      net_1369 <= net_1379;
      net_1372 <= net_1375;
    end
  end

//---------------------------------------------------------------------------
//Block 673, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_1498 == 1'b1)   //reset
    begin
      net_1382 <= 1'b0;
      net_1385 <= 1'b0;
    end
    else
    begin
      net_1382 <= net_1384;
      net_1385 <= net_1378;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 666, 668, 670, 671, 673

  assign { net_1384, net_1374, net_1377, net_1375, net_1379, net_1380, net_1373, net_1378, net_1376, net_1362, net_1365, net_1364, net_1367, net_1366, net_1361, net_1368 } = { net_1382, net_1256, net_1497, net_1372, net_1369, net_1381, net_1494, net_1385, net_1371, net_1493, net_1255, net_1360, net_1356, net_1239, net_1357, net_1363 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 674, MSLICE 1

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1383 <= 1'b0;
    end
    else
    begin
      net_1383 <= net_1398;
    end
  end

//---------------------------------------------------------------------------
//Block 675, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_1259 == 1'b1)   //enable
     begin
      net_1387 <= io_mcu_d[3];
      net_1386 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 677, MSLICE 1

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1391 <= 1'b0;
      net_1388 <= 1'b0;
    end
    else
    begin
      net_1391 <= net_1404;
      net_1388 <= net_1401;
    end
  end

//---------------------------------------------------------------------------
//Block 678, MSLICE 0

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1403 <= 1'b0;
    end
    else
    begin
      net_1403 <= net_1415;
    end
  end

//---------------------------------------------------------------------------
//Block 681, MSLICE 1

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1400 <= 1'b0;
    end
    else
    begin
      net_1400 <= net_1414;
    end
  end

//---------------------------------------------------------------------------
//Block 682, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_1269 == 1'b1)   //enable
     begin
      net_1409 <= io_mcu_d[3];
      net_1407 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 685, MSLICE 1

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1411 <= 1'b0;
      net_1410 <= 1'b0;
    end
    else
    begin
      net_1411 <= net_1419;
      net_1410 <= net_1416;
    end
  end

//---------------------------------------------------------------------------
//Block 686, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_1269 == 1'b1)   //enable
     begin
      net_1425 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//Block 689, MSLICE 1

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1429 <= 1'b0;
      net_1432 <= 1'b0;
    end
    else
    begin
      net_1429 <= net_1433;
      net_1432 <= net_1428;
    end
  end

//---------------------------------------------------------------------------
//Block 690, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_1149 == 1'b1)   //enable
     begin
      net_1441 <= io_mcu_d[3];
      net_1439 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 693, MSLICE 1

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1446 <= 1'b0;
      net_1449 <= 1'b0;
    end
    else
    begin
      net_1446 <= net_1426;
      net_1449 <= net_1431;
    end
  end

//---------------------------------------------------------------------------
//Block 694, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_1149 == 1'b1)   //enable
     begin
      net_1455 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//Block 696, MSLICE 1

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1458 <= 1'b0;
      net_1456 <= 1'b0;
    end
    else
    begin
      net_1458 <= net_1447;
      net_1456 <= net_1445;
    end
  end

//---------------------------------------------------------------------------
//Block 697, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_1156 == 1'b1)   //enable
     begin
      net_1462 <= io_mcu_d[3];
      net_1459 <= io_mcu_d[4];
    end
  end

//---------------------------------------------------------------------------
//Block 700, MSLICE 1

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1466 <= 1'b0;
      net_1465 <= 1'b0;
    end
    else
    begin
      net_1466 <= net_1442;
      net_1465 <= net_1450;
    end
  end

//---------------------------------------------------------------------------
//Block 701, MSLICE 0

  always @(posedge gclk_9)
  begin
    if(net_1156 == 1'b1)   //enable
     begin
      net_1467 <= io_mcu_d[7];
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 672, 674, 675, 677, 678, 681, 682, 685, 686, 689, 690, 693, 694, 696, 697, 700, 701

  assign { net_1469, open_32, open_33, open_34, open_35, open_36, open_37, open_38, open_39, open_40, open_41, open_42, open_43, open_44, open_45, open_46, open_47, open_48, open_49, open_50, open_51, open_52, open_53, open_54, open_55, open_56, open_57, open_58, open_59, open_60, open_61, open_62, open_63 } = { 1'b0, net_1467, net_1019, net_1158, net_1459, net_1462, net_1284, net_1285, net_1157, net_1455, net_917, net_1037, net_1439, net_1441, net_1039, net_1153, net_1151, net_1425, net_1143, net_1389, net_1407, net_1409, net_1270, net_1271, net_1393, net_1137, net_1138, net_1261, net_1386, net_1387, net_1124, net_1123, net_1260 } - { net_1454, net_1465, net_1466, net_1444, net_1440, net_1456, net_1458, net_1443, net_1438, net_1449, net_1446, net_1427, net_1424, net_1432, net_1429, net_1434, net_1423, net_1410, net_1411, net_1422, net_1408, net_1412, net_1400, net_1403, net_1413, net_1388, net_1391, net_1397, net_1394, net_1383, net_1395, net_1396 };

//---------------------------------------------------------------------------
//Block 676, LSLICE 2

  assign net_1392 = (~i_mcu_rws & ~net_1132 & ~net_632) | (~i_mcu_rws & ~net_1132 & net_632) | (~i_mcu_rws & net_1132 & ~net_632 & ((~net_1508 & net_778) | (net_1508 & net_778))) | (~i_mcu_rws & net_1132 & net_632 & ((~net_1508 & net_778) | (net_1508 & net_778))) | (i_mcu_rws & ~net_1132 & ~net_632) | (i_mcu_rws & ~net_1132 & net_632 & ((~net_1508 & ~net_778) | (~net_1508 & net_778))) | (i_mcu_rws & net_1132 & net_632 & ((~net_1508 & ~net_778) | (~net_1508 & net_778)));
  assign net_1390 = (~i_mcu_rws & ~net_632 & ~net_1129) | (~i_mcu_rws & ~net_632 & net_1129 & ((~net_1507 & net_778) | (net_1507 & net_778))) | (~i_mcu_rws & net_632 & ~net_1129) | (~i_mcu_rws & net_632 & net_1129 & ((~net_1507 & net_778) | (net_1507 & net_778))) | (i_mcu_rws & ~net_632 & ~net_1129) | (i_mcu_rws & net_632 & ~net_1129 & ((~net_1507 & ~net_778) | (~net_1507 & net_778))) | (i_mcu_rws & net_632 & net_1129 & ((~net_1507 & ~net_778) | (~net_1507 & net_778)));

  always @(posedge gclk_9)
  begin
    if(net_1269 == 1'b1)   //enable
     begin
      net_1393 <= io_mcu_d[0];
      net_1389 <= io_mcu_d[5];
    end
  end

//---------------------------------------------------------------------------
//Block 679, LSLICE 2

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1396 <= 1'b0;
      net_1395 <= 1'b0;
    end
    else
    begin
      net_1396 <= net_1405;
      net_1395 <= net_1399;
    end
  end

//---------------------------------------------------------------------------
//Block 680, LSLICE 3

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1394 <= 1'b0;
      net_1397 <= 1'b0;
    end
    else
    begin
      net_1394 <= net_1406;
      net_1397 <= net_1402;
    end
  end

//---------------------------------------------------------------------------
//Block 683, LSLICE 2

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1412 <= 1'b0;
      net_1413 <= 1'b0;
    end
    else
    begin
      net_1412 <= net_1421;
      net_1413 <= net_1418;
    end
  end

//---------------------------------------------------------------------------
//Block 684, LSLICE 3

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1408 <= 1'b0;
      net_1422 <= 1'b0;
    end
    else
    begin
      net_1408 <= net_1420;
      net_1422 <= net_1417;
    end
  end

//---------------------------------------------------------------------------
//Block 687, LSLICE 2

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1423 <= 1'b0;
      net_1434 <= 1'b0;
    end
    else
    begin
      net_1423 <= net_1430;
      net_1434 <= net_1436;
    end
  end

//---------------------------------------------------------------------------
//Block 688, LSLICE 3

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1424 <= 1'b0;
      net_1427 <= 1'b0;
    end
    else
    begin
      net_1424 <= net_1437;
      net_1427 <= net_1435;
    end
  end

//---------------------------------------------------------------------------
//Block 691, LSLICE 2

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1438 <= 1'b0;
      net_1443 <= 1'b0;
    end
    else
    begin
      net_1438 <= net_1448;
      net_1443 <= net_1452;
    end
  end

//---------------------------------------------------------------------------
//Block 692, LSLICE 3

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1440 <= 1'b0;
      net_1444 <= 1'b0;
    end
    else
    begin
      net_1440 <= net_1453;
      net_1444 <= net_1451;
    end
  end

//---------------------------------------------------------------------------
//Block 695, LSLICE 2

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1454 <= 1'b0;
    end
    else
    begin
      net_1454 <= net_1457;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 679, 680, 683, 684, 687, 688, 691, 692, 695

  assign { net_1457, net_1450, net_1442, net_1451, net_1453, net_1445, net_1447, net_1452, net_1448, net_1431, net_1426, net_1435, net_1437, net_1428, net_1433, net_1436, net_1430, net_1416, net_1419, net_1417, net_1420, net_1421, net_1414, net_1415, net_1418, net_1401, net_1404, net_1402, net_1406, net_1398, net_1399, net_1405 } = { net_1454, net_1465, net_1466, net_1444, net_1440, net_1456, net_1458, net_1443, net_1438, net_1449, net_1446, net_1427, net_1424, net_1432, net_1429, net_1434, net_1423, net_1410, net_1411, net_1422, net_1408, net_1412, net_1400, net_1403, net_1413, net_1388, net_1391, net_1397, net_1394, net_1383, net_1395, net_1396 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 698, LSLICE 2

  assign sig_698_lut_0 = (~io_mcu_d[0] & ~net_1142 & ~i_mcu_rws & ((~net_1461 & ~net_1464) | (net_1461 & ~net_1464))) | (~io_mcu_d[0] & ~net_1142 & i_mcu_rws & ((net_1461 & ~net_1464))) | (~io_mcu_d[0] & net_1142 & ~i_mcu_rws & ((~net_1461 & ~net_1464) | (net_1461 & ~net_1464))) | (io_mcu_d[0] & ~net_1142 & ~i_mcu_rws & ((~net_1461 & ~net_1464) | (net_1461 & ~net_1464))) | (io_mcu_d[0] & ~net_1142 & i_mcu_rws & ((net_1461 & ~net_1464))) | (io_mcu_d[0] & net_1142 & ~i_mcu_rws & ((~net_1461 & ~net_1464) | (net_1461 & ~net_1464))) | (io_mcu_d[0] & net_1142 & i_mcu_rws & ((~net_1461 & ~net_1464) | (net_1461 & ~net_1464)));
  assign net_1464 = (~i_mcu_rws & ~net_1461 & (~(net_896 & net_1168))) | (~i_mcu_rws & net_1461 & ((net_896 & ~net_1168)));

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1461 <= sig_698_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 699, LSLICE 3

  assign sig_699_lut_0 = (~net_1142 & ~net_1463 & ~i_mcu_rws) | (~net_1142 & ~net_1463 & i_mcu_rws & ((~io_mcu_d[1] & net_1460) | (io_mcu_d[1] & net_1460))) | (net_1142 & ~net_1463 & ~i_mcu_rws) | (net_1142 & ~net_1463 & i_mcu_rws & ((io_mcu_d[1] & ~net_1460) | (io_mcu_d[1] & net_1460)));
  assign net_1463 = (~i_mcu_rws & ~net_1460 & (~(net_896 & net_1169))) | (~i_mcu_rws & net_1460 & ((net_896 & ~net_1169)));

  always @(posedge gclk_9)
  begin
    if(i_mcu_dcs == 1'b0)   //enable
     begin
      net_1460 <= sig_699_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 702, MSLICE 1

  assign sig_702_lut_0 = 1'b0;
  assign sig_702_lut_1 = (~net_1312 & net_1289 & ((~net_948 & net_1182)));
  assign net_1468 = (~net_1302 & sig_702_lut_0) | (net_1302 & sig_702_lut_1);

//---------------------------------------------------------------------------
//Block 707, LSLICE 3

  assign sig_707_lut_0 = (~(net_901 & ~net_1471));
  assign sig_707_lut_1 = ~net_1471;

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //enable
     begin
      net_1472 <= sig_707_lut_0;
      net_1471 <= sig_707_lut_1;
    end
  end

//---------------------------------------------------------------------------
//MSLICE adder blocks 708, 710, 711, 712, 713

  always @(posedge gclk_2)
  begin
    if(net_1338 == 1'b1)   //reset
    begin
      { net_1483, net_1478, net_1480, net_1479, net_1481, net_1473, net_1475, net_1474 } <= { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
    end
    else
    begin
      { net_1483, net_1478, net_1480, net_1479, net_1481, net_1473, net_1475, net_1474 } <= { net_1483, net_1478, net_1480, net_1479, net_1481, net_1473, net_1475, net_1474 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
    end
  end

//---------------------------------------------------------------------------
//Block 709, LSLICE 2

  assign net_1476 = (~net_1479 & ~net_1483 & ((~net_1478 & ~net_1480)));
  assign net_1477 = ((net_1091 & ~net_1334));

//---------------------------------------------------------------------------
//Block 714, LSLICE 2

  assign net_1490 = (~net_1251 & ~net_1242 & ~i_adc2B_d[7] & ((~i_adc2A_d[7] & net_1485) | (i_adc2A_d[7] & net_1485))) | (~net_1251 & ~net_1242 & i_adc2B_d[7] & ((~i_adc2A_d[7] & net_1485) | (i_adc2A_d[7] & net_1485))) | (~net_1251 & net_1242 & ~i_adc2B_d[7] & ((~i_adc2A_d[7] & net_1485) | (i_adc2A_d[7] & net_1485))) | (net_1251 & ~net_1242 & ~i_adc2B_d[7] & ((~i_adc2A_d[7] & net_1485))) | (net_1251 & ~net_1242 & i_adc2B_d[7] & ((~i_adc2A_d[7] & net_1485))) | (net_1251 & net_1242 & ~i_adc2B_d[7] & ((~i_adc2A_d[7] & net_1485)));
  assign net_1485 = (~net_1278 & ~net_999 & (~(net_827 & net_998))) | (~net_1278 & net_999 & (~(net_827 & net_998))) | (net_1278 & ~net_999 & (~(net_827 & net_998)));

  always @(negedge gclk_4)
  begin
    net_1489 <= i_adc2A_d[7];
    net_1488 <= i_adc2B_d[7];
  end

//---------------------------------------------------------------------------
//Block 715, LSLICE 3

  assign net_1491 = (~net_1163 & net_1484 & ~net_999 & (~(i_adc2A_d[4] & net_1251))) | (~net_1163 & net_1484 & net_999 & (~(i_adc2A_d[4] & net_1251))) | (net_1163 & net_1484 & ~net_999 & (~(i_adc2A_d[4] & net_1251)));
  assign net_1484 = (~i_adc2B_d[4] & ~net_1242 & (~(net_998 & net_1042))) | (~i_adc2B_d[4] & net_1242 & (~(net_998 & net_1042))) | (i_adc2B_d[4] & ~net_1242 & (~(net_998 & net_1042)));

  always @(negedge gclk_4)
  begin
    net_1487 <= i_adc2A_d[4];
    net_1486 <= i_adc2B_d[4];
  end

//---------------------------------------------------------------------------
//Block 716, MSLICE 1

  assign sig_716_lut_0 = (~net_994 & ~net_511 & ((~net_1100 & net_1482) | (net_1100 & net_1482))) | (~net_994 & net_511 & ((~net_1100 & net_1482) | (net_1100 & net_1482))) | (net_994 & ~net_511 & ((net_1100 & ~net_1482) | (net_1100 & net_1482))) | (net_994 & net_511 & ((net_1100 & ~net_1482) | (net_1100 & net_1482)));
  assign sig_716_lut_1 = (~net_1482 & ~net_994 & ((~net_511 & ~net_1100) | (~net_511 & net_1100))) | (~net_1482 & net_994 & ((~net_511 & ~net_1100) | (~net_511 & net_1100))) | (net_1482 & ~net_994 & ((~net_511 & ~net_1100) | (~net_511 & net_1100))) | (net_1482 & net_994 & ((~net_511 & ~net_1100) | (~net_511 & net_1100)));
  assign sig_716_ff0_d = (~net_445 & sig_716_lut_0) | (net_445 & sig_716_lut_1);

  always @(posedge gclk_4)
  begin
    net_1482 <= sig_716_ff0_d;
  end

//---------------------------------------------------------------------------
//Block 717, LSLICE 2

  assign sig_717_lut_0 = ~net_1492;

  always @(posedge gclk_0)
  begin
    if(net_1498 == 1'b1)   //enable
     begin
      net_1492 <= sig_717_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 718, MSLICE 0

  assign net_1499 = (~net_1469 & ((~net_1348 & ~net_1115) | (~net_1348 & net_1115))) | (net_1469 & ((~net_1348 & net_1115)));
  assign net_1501 = (~i_mcu_clk & ((~net_527 & net_1617))) | (i_mcu_clk & ((net_527 | net_1617)));

  always @(posedge gclk_4)
  begin
    if(net_445 == 1'b1)   //reset
    begin
      net_1496 <= 1'b1;
    end
    else
    begin
      if(net_1499 == 1'b0)   //enable
       begin
        net_1496 <= 1'b0;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 719, LSLICE 2

  assign net_1495 = (net_1249 & ~net_1371 & ~net_1385 & ((~net_1494 & ~net_1493)));
  assign net_1498 = (~(net_1495 & net_1253));

  always @(posedge gclk_0)
  begin
    if(net_1498 == 1'b1)   //reset
    begin
      net_1493 <= 1'b0;
      net_1497 <= 1'b0;
    end
    else
    begin
      net_1493 <= net_1362;
      net_1497 <= net_1377;
    end
  end

//---------------------------------------------------------------------------
//Block 720, MSLICE 1

  assign sig_720_lut_0 = (~(net_901 & ~net_1618));
  assign net_1500 = (net_952 & ((net_1289 & net_1648)));

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //enable
     begin
      net_1502 <= sig_720_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 721, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_1498 == 1'b1)   //reset
    begin
      net_1494 <= 1'b0;
    end
    else
    begin
      net_1494 <= net_1373;
    end
  end

//---------------------------------------------------------------------------
//Block 722, LSLICE 2

  assign net_1505 = (net_1026 & ~net_1242 & ~net_1148 & ((~i_adc2B_d[6] & net_1503) | (i_adc2B_d[6] & net_1503))) | (net_1026 & net_1242 & ~net_1148 & ((~i_adc2B_d[6] & net_1503)));
  assign net_1503 = (~i_adc2A_d[6] & ~net_1522) | (~i_adc2A_d[6] & net_1522 & ((~net_1251 & ~net_998) | (net_1251 & ~net_998))) | (i_adc2A_d[6] & ~net_1522 & ((~net_1251 & ~net_998) | (~net_1251 & net_998))) | (i_adc2A_d[6] & net_1522 & ((~net_1251 & ~net_998)));

  always @(negedge gclk_4)
  begin
    net_1506 <= i_adc2B_d[6];
    net_1504 <= i_adc2A_d[6];
  end

//---------------------------------------------------------------------------
//Block 723, LSLICE 3

  assign sig_723_lut_0 = (~net_778 & ~i_mcu_dcs & ~i_mcu_rws & ((~net_1392 & ~net_1508) | (~net_1392 & net_1508))) | (~net_778 & ~i_mcu_dcs & i_mcu_rws & ((~net_1392 & ~net_1508) | (~net_1392 & net_1508))) | (~net_778 & i_mcu_dcs & ~i_mcu_rws & ((~net_1392 & net_1508) | (net_1392 & net_1508))) | (net_778 & ~i_mcu_dcs & ~i_mcu_rws & (~(net_1392 & ~net_1508))) | (net_778 & ~i_mcu_dcs & i_mcu_rws & ((~net_1392 & ~net_1508) | (~net_1392 & net_1508))) | (net_778 & i_mcu_dcs & ~i_mcu_rws & ((~net_1392 & net_1508) | (net_1392 & net_1508)));
  assign sig_723_lut_1 = (~net_1390 & ~i_mcu_dcs & ~i_mcu_rws) | (~net_1390 & ~i_mcu_dcs & i_mcu_rws) | (~net_1390 & i_mcu_dcs & ~i_mcu_rws & ((~net_778 & net_1507) | (net_778 & net_1507))) | (net_1390 & ~i_mcu_dcs & ~i_mcu_rws & ((net_778 & net_1507))) | (net_1390 & i_mcu_dcs & ~i_mcu_rws & ((~net_778 & net_1507) | (net_778 & net_1507)));

  always @(posedge gclk_9)
  begin
    net_1508 <= sig_723_lut_0;
    net_1507 <= sig_723_lut_1;
  end

//---------------------------------------------------------------------------
//Block 724, MSLICE 0

  assign net_1514 = (~net_247 & ((net_584 & net_1276)));
  assign net_1515 = (~net_1509 & ((net_1135 & ~net_796) | (net_1135 & net_796))) | (net_1509 & ((net_1135 & ~net_796)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1509 <= 1'b0;
    end
    else
    begin
      if(net_1514 == 1'b1)   //enable
       begin
        net_1509 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 725, LSLICE 2

  assign net_1512 = (~net_527 & ((net_1266 & ~net_1173) | (net_1266 & net_1173))) | (net_527 & ((~net_1266 & net_1173) | (net_1266 & net_1173)));
  assign net_1513 = ((net_794 & i_adc1B_d[2]));

  always @(negedge gclk_4)
  begin
    net_1511 <= net_1216;
    net_1517 <= i_adc1B_d[2];
  end

//---------------------------------------------------------------------------
//Block 726, LSLICE 3

  assign net_1516 = (net_1523 & ((~net_247 & net_1276)));
  assign net_1518 = (~net_998 & ~net_1510 & (~(net_1059 & net_999))) | (~net_998 & net_1510 & (~(net_1059 & net_999))) | (net_998 & ~net_1510 & (~(net_1059 & net_999)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1510 <= 1'b1;
    end
    else
    begin
      if(net_1516 == 1'b1)   //enable
       begin
        net_1510 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 727, MSLICE 1

  assign net_1520 = (~net_247 & ((net_1303 & net_1155)));
  assign net_1521 = ((net_1289 & net_1155));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1519 <= 1'b0;
    end
    else
    begin
      if(net_1520 == 1'b1)   //enable
       begin
        net_1519 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 728, LSLICE 3

  assign net_1524 = (net_963 & net_948 & net_1047 & ((~net_247 & ~net_1302)));
  assign net_1523 = (net_948 & net_963 & ((net_1302 & net_1289)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1522 <= 1'b1;
    end
    else
    begin
      if(net_1524 == 1'b1)   //enable
       begin
        net_1522 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 729, MSLICE 0

  assign net_1526 = (net_1525 & ((net_1047 & ~net_247)));
  assign net_1525 = (net_1312 & ~net_1302 & ((~net_1182 & net_948)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1527 <= 1'b0;
    end
    else
    begin
      if(net_1526 == 1'b1)   //enable
       begin
        net_1527 <= io_i2c_sda;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 730, MSLICE 1

  assign sig_730_lut_0 = 1'b0;
  assign sig_730_lut_1 = (net_1301 & net_1300 & ((net_1289 & ~net_1532)));
  assign net_1528 = (~net_1299 & sig_730_lut_0) | (net_1299 & sig_730_lut_1);

//---------------------------------------------------------------------------
//Block 731, LSLICE 3

  assign net_1530 = (~net_1529 & ((~net_1327 & ~net_1323)));
  assign net_1531 = (~net_1323 & ~net_1313 & ((~net_1325 & ~net_1529)));

  always @(posedge gclk_8)
  begin
    if(net_182 == 1'b0)   //reset
    begin
      net_1532 <= 1'b0;
      net_1529 <= 1'b0;
    end
    else
    begin
      if(net_1530 == 1'b1)   //enable
       begin
        net_1532 <= net_1308;
        net_1529 <= net_1315;
      end
    end
  end

//---------------------------------------------------------------------------
//Block 771, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1568 <= 1'b0;
      net_1559 <= 1'b0;
    end
    else
    begin
      net_1568 <= net_1567;
      net_1559 <= net_1563;
    end
  end

//---------------------------------------------------------------------------
//Block 772, LSLICE 3

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1558 <= 1'b0;
      net_1562 <= 1'b0;
    end
    else
    begin
      net_1558 <= net_1566;
      net_1562 <= net_1564;
    end
  end

//---------------------------------------------------------------------------
//Block 773, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1570 <= 1'b0;
      net_1571 <= 1'b0;
    end
    else
    begin
      net_1570 <= net_1580;
      net_1571 <= net_1575;
    end
  end

//---------------------------------------------------------------------------
//Block 774, LSLICE 3

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1569 <= 1'b0;
      net_1572 <= 1'b0;
    end
    else
    begin
      net_1569 <= net_1579;
      net_1572 <= net_1574;
    end
  end

//---------------------------------------------------------------------------
//Block 775, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1581 <= 1'b0;
      net_1592 <= 1'b0;
    end
    else
    begin
      net_1581 <= net_1590;
      net_1592 <= net_1594;
    end
  end

//---------------------------------------------------------------------------
//Block 776, LSLICE 3

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1582 <= 1'b0;
      net_1585 <= 1'b0;
    end
    else
    begin
      net_1582 <= net_1595;
      net_1585 <= net_1593;
    end
  end

//---------------------------------------------------------------------------
//Block 778, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1596 <= 1'b0;
      net_1606 <= 1'b0;
    end
    else
    begin
      net_1596 <= net_1604;
      net_1606 <= net_1608;
    end
  end

//---------------------------------------------------------------------------
//Block 779, LSLICE 3

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1597 <= 1'b0;
      net_1598 <= 1'b0;
    end
    else
    begin
      net_1597 <= net_1609;
      net_1598 <= net_1607;
    end
  end

//---------------------------------------------------------------------------
//Block 781, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1611 <= 1'b0;
      net_1616 <= 1'b0;
    end
    else
    begin
      net_1611 <= net_1614;
      net_1616 <= net_1587;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 771, 772, 773, 774, 775, 776, 778, 779, 781

  assign { net_1614, net_1605, net_1600, net_1607, net_1609, net_1601, net_1599, net_1608, net_1604, net_1588, net_1586, net_1593, net_1595, net_1587, net_1591, net_1594, net_1590, net_1576, net_1578, net_1574, net_1579, net_1580, net_1573, net_1577, net_1575, net_1561, net_1565, net_1564, net_1566, net_1560, net_1563, net_1567 } = { net_1611, net_1603, net_1583, net_1598, net_1597, net_1602, net_1612, net_1606, net_1596, net_1671, net_1610, net_1585, net_1582, net_1616, net_1655, net_1592, net_1581, net_1663, net_1666, net_1572, net_1569, net_1570, net_1656, net_1658, net_1571, net_1672, net_1657, net_1562, net_1558, net_1589, net_1559, net_1568 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 777, MSLICE 0

  assign net_1584 = (net_1615 & ~net_1611 & ((~net_1603 & ~net_1583)));

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1583 <= 1'b0;
      net_1589 <= 1'b0;
    end
    else
    begin
      net_1583 <= net_1600;
      net_1589 <= net_1560;
    end
  end

//---------------------------------------------------------------------------
//Block 780, MSLICE 1

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1603 <= 1'b0;
      net_1602 <= 1'b0;
    end
    else
    begin
      net_1603 <= net_1605;
      net_1602 <= net_1601;
    end
  end

//---------------------------------------------------------------------------
//Block 782, LSLICE 3

  assign net_1615 = (~net_1598 & net_1613 & ~net_1597 & ((~net_1602 & ~net_1612)));
  assign net_1613 = (~net_1606 & ~net_1596 & ((~net_1671 & ~net_1610)));

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1612 <= 1'b0;
      net_1610 <= 1'b0;
    end
    else
    begin
      net_1612 <= net_1599;
      net_1610 <= net_1586;
    end
  end

//---------------------------------------------------------------------------
//Block 783, LSLICE 2

  assign sig_783_lut_0 = ~net_1617;
  assign sig_783_lut_1 = ~net_1618;

  always @(posedge gclk_0)
  begin
    if(net_451 == 1'b1)   //enable
     begin
      net_1617 <= sig_783_lut_0;
      net_1618 <= sig_783_lut_1;
    end
  end

//---------------------------------------------------------------------------
//Block 784, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_1669 == 1'b1)   //reset
    begin
      net_1629 <= 1'b0;
      net_1620 <= 1'b0;
    end
    else
    begin
      net_1629 <= net_1628;
      net_1620 <= net_1624;
    end
  end

//---------------------------------------------------------------------------
//Block 785, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_1669 == 1'b1)   //reset
    begin
      net_1619 <= 1'b0;
      net_1622 <= 1'b0;
    end
    else
    begin
      net_1619 <= net_1627;
      net_1622 <= net_1626;
    end
  end

//---------------------------------------------------------------------------
//Block 786, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_1669 == 1'b1)   //reset
    begin
      net_1638 <= 1'b0;
      net_1633 <= 1'b0;
    end
    else
    begin
      net_1638 <= net_1643;
      net_1633 <= net_1636;
    end
  end

//---------------------------------------------------------------------------
//Block 787, LSLICE 3

  always @(posedge gclk_0)
  begin
    if(net_1669 == 1'b1)   //reset
    begin
      net_1630 <= 1'b0;
      net_1634 <= 1'b0;
    end
    else
    begin
      net_1630 <= net_1642;
      net_1634 <= net_1639;
    end
  end

//---------------------------------------------------------------------------
//Block 789, LSLICE 2

  always @(posedge gclk_0)
  begin
    if(net_1669 == 1'b1)   //reset
    begin
      net_1644 <= 1'b0;
      net_1650 <= 1'b0;
    end
    else
    begin
      net_1644 <= net_1649;
      net_1650 <= net_1621;
    end
  end

//---------------------------------------------------------------------------
//LSICE adder blocks 784, 785, 786, 787, 789

  assign { net_1649, net_1635, net_1641, net_1639, net_1642, net_1643, net_1637, net_1640, net_1636, net_1623, net_1621, net_1626, net_1627, net_1625, net_1624, net_1628 } = { net_1644, net_1645, net_1670, net_1634, net_1630, net_1638, net_1632, net_1631, net_1633, net_1647, net_1650, net_1622, net_1619, net_1667, net_1620, net_1629 } + { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };

//---------------------------------------------------------------------------
//Block 788, MSLICE 1

  always @(posedge gclk_0)
  begin
    if(net_1669 == 1'b1)   //reset
    begin
      net_1632 <= 1'b0;
      net_1631 <= 1'b0;
    end
    else
    begin
      net_1632 <= net_1637;
      net_1631 <= net_1640;
    end
  end

//---------------------------------------------------------------------------
//Block 790, MSLICE 1

  assign sig_790_lut_0 = ~net_1646;
  assign net_1648 = (net_1302 & net_1312 & ((net_948 & ~net_1182)));

  always @(posedge gclk_0)
  begin
    if(net_1669 == 1'b1)   //enable
     begin
      net_1646 <= sig_790_lut_0;
    end
  end

//---------------------------------------------------------------------------
//Block 791, MSLICE 0

  assign net_1652 = (~net_1632 & ~net_1631 & ((~net_1633 & ~net_1647)));
  assign net_1651 = (~net_1670 & ~net_1634 & ((~net_1644 & ~net_1645)));

  always @(posedge gclk_0)
  begin
    if(net_1669 == 1'b1)   //reset
    begin
      net_1647 <= 1'b0;
      net_1645 <= 1'b0;
    end
    else
    begin
      net_1647 <= net_1623;
      net_1645 <= net_1635;
    end
  end

//---------------------------------------------------------------------------
//Block 796, LSLICE 2

  assign net_1659 = (~net_1570 & ~net_1572 & ((~net_1569 & ~net_1656)));
  assign net_1661 = (net_1659 & ~net_1571) | (net_1659 & net_1571 & (~(~net_1660 & net_1658)));

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1656 <= 1'b0;
      net_1658 <= 1'b0;
    end
    else
    begin
      net_1656 <= net_1573;
      net_1658 <= net_1577;
    end
  end

//---------------------------------------------------------------------------
//Block 797, LSLICE 3

  assign net_1660 = (~net_1558 & ~net_1672 & (~(net_1562 & net_1657))) | (net_1558 & ~net_1672 & ((~net_1562 & ~net_1657) | (net_1562 & ~net_1657)));
  assign net_1662 = (~net_1585 & ~net_1582 & ((~net_1616 & ~net_1655)));

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1657 <= 1'b0;
      net_1655 <= 1'b0;
    end
    else
    begin
      net_1657 <= net_1565;
      net_1655 <= net_1591;
    end
  end

//---------------------------------------------------------------------------
//Block 798, LSLICE 2

  assign net_1665 = (~net_1663 & ~net_1666 & ((~net_1661 & ~net_1664) | (net_1661 & ~net_1664))) | (~net_1663 & net_1666 & ((~net_1661 & ~net_1664) | (net_1661 & ~net_1664))) | (net_1663 & ~net_1666 & ((~net_1661 & ~net_1664) | (net_1661 & ~net_1664))) | (net_1663 & net_1666 & (~(net_1661 & net_1664)));
  assign net_1664 = (net_1662 & ~net_1592 & ((~net_1581 & net_1584)));

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1666 <= 1'b0;
      net_1663 <= 1'b0;
    end
    else
    begin
      net_1666 <= net_1578;
      net_1663 <= net_1576;
    end
  end

//---------------------------------------------------------------------------
//Block 799, LSLICE 3

  assign net_1668 = (net_1652 & ~net_1619 & ~net_1650) | (net_1652 & ~net_1619 & net_1650) | (net_1652 & net_1619 & ~net_1650) | (net_1652 & net_1619 & net_1650 & (~(net_1622 & net_1667)));
  assign net_1669 = (~net_1638 & ~net_1651) | (~net_1638 & net_1651 & (~(~net_1630 & net_1668))) | (net_1638 & ~net_1651) | (net_1638 & net_1651);

  always @(posedge gclk_0)
  begin
    if(net_1669 == 1'b1)   //reset
    begin
      net_1667 <= 1'b0;
      net_1670 <= 1'b0;
    end
    else
    begin
      net_1667 <= net_1625;
      net_1670 <= net_1641;
    end
  end

//---------------------------------------------------------------------------
//Block 800, LSLICE 2

  always @(posedge gclk_5)
  begin
    if(net_1665 == 1'b1)   //reset
    begin
      net_1672 <= 1'b0;
      net_1671 <= 1'b0;
    end
    else
    begin
      net_1672 <= net_1561;
      net_1671 <= net_1588;
    end
  end

//---------------------------------------------------------------------------
//Block 61, EMB 3

  assign sig_61_cea = ground & ~ground & ~ground;
  assign sig_61_ceb = ~ground & ~ground;

  sample_memory_9 samples_block_61
  (
    .dia({open_n64,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
    .addra({net_76,net_74,net_77,net_70,net_72,net_71,net_73,net_67,net_69,net_68}),
    .cea(sig_61_cea),
    .clka(gclk_7),
    .addrb({net_126,net_128,net_130,net_119,net_118,net_117,net_120,net_111,net_110,net_112}),
    .ceb(sig_61_ceb),
    .clkb(gclk_9)
  );

//---------------------------------------------------------------------------
//Block 69, EMB 0

  assign sig_69_cea = net_1496 & net_1133 & ~net_1218;
  assign sig_69_ceb = net_193 & ~net_1050;

  sample_memory_9 samples_block_69
  (
    .dia({net_1007,net_819,net_933,net_1237,net_1046,net_799,net_1250,net_1011,net_1139}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_69_cea),
    .clka(gclk_4),
    .dob({net_33,net_37,net_35,net_36,net_34,net_30,net_29,net_31,net_32}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_69_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 70, EMB 1

  assign sig_70_cea = net_1496 & net_1133 & net_1218;
  assign sig_70_ceb = net_193 & net_1050;

  sample_memory_9 samples_block_70
  (
    .dia({net_1007,net_819,net_933,net_1237,net_1046,net_799,net_1250,net_1011,net_1139}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_70_cea),
    .clka(gclk_4),
    .dob({net_43,net_46,net_42,net_45,net_44,net_41,net_38,net_39,net_40}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_70_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 71, EMB 2

  assign sig_71_cea = net_1496 & ~net_1133 & ~net_1218;
  assign sig_71_ceb = ~net_193 & ~net_1050;

  sample_memory_9 samples_block_71
  (
    .dia({net_1007,net_819,net_933,net_1237,net_1046,net_799,net_1250,net_1011,net_1139}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_71_cea),
    .clka(gclk_4),
    .dob({net_52,net_53,net_51,net_55,net_54,net_47,net_48,net_49,net_50}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_71_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 88, EMB 0

  assign sig_88_cea = net_1496 & ~net_1133 & net_1218;
  assign sig_88_ceb = ~net_193 & net_1050;

  sample_memory_9 samples_block_88
  (
    .dia({net_1007,net_819,net_933,net_1237,net_1046,net_799,net_1250,net_1011,net_1139}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_88_cea),
    .clka(gclk_4),
    .dob({net_58,net_64,net_61,net_63,net_62,net_56,net_57,net_60,net_59}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_88_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 390, EMB 3

  assign sig_390_cea = net_1496 & ~net_1133 & ~net_1218;
  assign sig_390_ceb = ~net_193 & ~net_1050;

  sample_memory_9 samples_block_390
  (
    .dia({net_1254,net_1012,net_1246,net_1489,net_1504,net_1236,net_1487,net_1340,net_1248}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_390_cea),
    .clka(gclk_4),
    .dob({net_690,net_697,net_696,net_698,net_695,net_693,net_694,net_691,net_692}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_390_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 398, EMB 0

  assign sig_398_cea = net_1496 & ~net_1133 & net_1218;
  assign sig_398_ceb = ~net_193 & net_1050;

  sample_memory_9 samples_block_398
  (
    .dia({net_1254,net_1012,net_1246,net_1489,net_1504,net_1236,net_1487,net_1340,net_1248}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_398_cea),
    .clka(gclk_4),
    .dob({net_702,net_705,net_706,net_704,net_707,net_703,net_699,net_701,net_700}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_398_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 399, EMB 1

  assign sig_399_cea = net_1496 & net_1133 & ~net_1218;
  assign sig_399_ceb = net_193 & ~net_1050;

  sample_memory_9 samples_block_399
  (
    .dia({net_806,net_1257,net_1104,net_938,net_818,net_1051,net_1134,net_1517,net_944}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_399_cea),
    .clka(gclk_4),
    .dob({net_712,net_714,net_715,net_716,net_713,net_711,net_708,net_710,net_709}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_399_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 400, EMB 2

  assign sig_400_cea = net_1496 & net_1133 & net_1218;
  assign sig_400_ceb = net_193 & net_1050;

  sample_memory_9 samples_block_400
  (
    .dia({net_806,net_1257,net_1104,net_938,net_818,net_1051,net_1134,net_1517,net_944}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_400_cea),
    .clka(gclk_4),
    .dob({net_722,net_725,net_721,net_723,net_724,net_717,net_720,net_718,net_719}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_400_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 401, EMB 3

  assign sig_401_cea = net_1496 & ~net_1133 & net_1218;
  assign sig_401_ceb = ~net_193 & net_1050;

  sample_memory_9 samples_block_401
  (
    .dia({net_806,net_1257,net_1104,net_938,net_818,net_1051,net_1134,net_1517,net_944}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_401_cea),
    .clka(gclk_4),
    .dob({net_728,net_732,net_733,net_734,net_731,net_730,net_729,net_727,net_726}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_401_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 406, EMB 0

  assign sig_406_cea = net_1496 & ~net_1133 & ~net_1218;
  assign sig_406_ceb = ~net_193 & ~net_1050;

  sample_memory_9 samples_block_406
  (
    .dia({net_806,net_1257,net_1104,net_938,net_818,net_1051,net_1134,net_1517,net_944}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_406_cea),
    .clka(gclk_4),
    .dob({net_738,net_741,net_743,net_740,net_742,net_739,net_737,net_736,net_735}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_406_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 732, EMB 3

  assign sig_732_cea = net_1496 & net_1133 & ~net_1218;
  assign sig_732_ceb = net_193 & ~net_1050;

  sample_memory_9 samples_block_732
  (
    .dia({net_1254,net_1012,net_1246,net_1489,net_1504,net_1236,net_1487,net_1340,net_1248}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_732_cea),
    .clka(gclk_4),
    .dob({net_1534,net_1540,net_1542,net_1539,net_1541,net_1537,net_1538,net_1535,net_1536}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_732_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 738, EMB 0

  assign sig_738_cea = net_1496 & net_1133 & net_1218;
  assign sig_738_ceb = net_193 & net_1050;

  sample_memory_9 samples_block_738
  (
    .dia({net_1254,net_1012,net_1246,net_1489,net_1504,net_1236,net_1487,net_1340,net_1248}),
    .addra({net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(sig_738_cea),
    .clka(gclk_4),
    .dob({net_1544,net_1549,net_1550,net_1548,net_1551,net_1546,net_1545,net_1543,net_1547}),
    .addrb({net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(sig_738_ceb),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 739, EMB 1

  sample_memory_2 samples_block_739
  (
    .dia({ net_1488 }),
    .addra({net_1133,net_1218,net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(net_1496),
    .clka(gclk_4),
    .dob({open_n65,net_1552}),
    .addrb({net_193,net_1050,net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(1'b1),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 740, EMB 2

  sample_memory_2 samples_block_740
  (
    .dia({ net_1486, net_1346 }),
    .addra({net_1133,net_1218,net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(net_1496),
    .clka(gclk_4),
    .dob({net_1553,net_1554}),
    .addrb({net_193,net_1050,net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(1'b1),
    .clkb(gclk_3)
  );

//---------------------------------------------------------------------------
//Block 757, EMB 0

  sample_memory_2 samples_block_757
  (
    .dia({ net_1506, net_1243 }),
    .addra({net_1133,net_1218,net_872,net_988,net_1211,net_986,net_992,net_1096,net_1006,net_1103,net_1511,net_1219}),
    .cea(net_1496),
    .clka(gclk_4),
    .dob({net_1555,net_1556}),
    .addrb({net_193,net_1050,net_1294,net_1298,net_1154,net_1147,net_1031,net_921,net_924,net_1146,net_1290,net_1512}),
    .ceb(1'b1),
    .clkb(gclk_3)
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

