onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /fnirsi_1013D_tb/io_mcu_data
add wave -noupdate /fnirsi_1013D_tb/mcu_clk
add wave -noupdate /fnirsi_1013D_tb/mcu_dcs
add wave -noupdate /fnirsi_1013D_tb/mcu_rws
add wave -noupdate -radix decimal /fnirsi_1013D_tb/fnirsi_test/ch1_offset
add wave -noupdate /fnirsi_1013D_tb/fnirsi_test/o_offset_1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {88100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {525 ns}
