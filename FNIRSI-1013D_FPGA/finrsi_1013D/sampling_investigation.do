onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /fnirsi_1013D_tb/io_mcu_data
add wave -noupdate /fnirsi_1013D_tb/mcu_clk
add wave -noupdate /fnirsi_1013D_tb/mcu_dcs
add wave -noupdate /fnirsi_1013D_tb/mcu_rws
add wave -noupdate /fnirsi_1013D_tb/clock_200MHz
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/sample_write_clock
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/sample_read_clock
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/trigger_edge
add wave -noupdate -radix unsigned /fnirsi_1013D_tb/fnirsi_test/trigger_level
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/trigger_mode
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/trigger_channel
add wave -noupdate -radix unsigned /fnirsi_1013D_tb/fnirsi_test/sample_write_address
add wave -noupdate -radix unsigned /fnirsi_1013D_tb/fnirsi_test/trigger_read_address
add wave -noupdate -radix unsigned /fnirsi_1013D_tb/fnirsi_test/sample_read_address
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/sample_write_enable
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/time_base_timeout
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/sampling_triggered
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/trigger_detect_enable
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/trigger_fall_enable
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/trigger_rise_enable
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/trigger_fall_detect
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/trigger_rise_detect
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/prev_less_equal_lev
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/cur_less_equal_lev
add wave -noupdate -format Analog-Step -height 84 -max 255.0 -radix unsigned /fnirsi_1013D_tb/fnirsi_test/i_adc1A_d
add wave -noupdate -format Analog-Step -height 84 -max 255.0 -radix unsigned /fnirsi_1013D_tb/fnirsi_test/trigger_data
add wave -noupdate -format Analog-Step -height 84 -max 255.0 -radix unsigned /fnirsi_1013D_tb/fnirsi_test/trigger_previous
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {98100000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 275
configure wave -valuecolwidth 45
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {126 us}
