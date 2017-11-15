onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Datapath_testbench/reset
add wave -noupdate /Datapath_testbench/clk
add wave -noupdate -radix binary /Datapath_testbench/dut/instruction
add wave -noupdate -radix decimal -childformat {{{/Datapath_testbench/dut/PC[63]} -radix decimal} {{/Datapath_testbench/dut/PC[62]} -radix decimal} {{/Datapath_testbench/dut/PC[61]} -radix decimal} {{/Datapath_testbench/dut/PC[60]} -radix decimal} {{/Datapath_testbench/dut/PC[59]} -radix decimal} {{/Datapath_testbench/dut/PC[58]} -radix decimal} {{/Datapath_testbench/dut/PC[57]} -radix decimal} {{/Datapath_testbench/dut/PC[56]} -radix decimal} {{/Datapath_testbench/dut/PC[55]} -radix decimal} {{/Datapath_testbench/dut/PC[54]} -radix decimal} {{/Datapath_testbench/dut/PC[53]} -radix decimal} {{/Datapath_testbench/dut/PC[52]} -radix decimal} {{/Datapath_testbench/dut/PC[51]} -radix decimal} {{/Datapath_testbench/dut/PC[50]} -radix decimal} {{/Datapath_testbench/dut/PC[49]} -radix decimal} {{/Datapath_testbench/dut/PC[48]} -radix decimal} {{/Datapath_testbench/dut/PC[47]} -radix decimal} {{/Datapath_testbench/dut/PC[46]} -radix decimal} {{/Datapath_testbench/dut/PC[45]} -radix decimal} {{/Datapath_testbench/dut/PC[44]} -radix decimal} {{/Datapath_testbench/dut/PC[43]} -radix decimal} {{/Datapath_testbench/dut/PC[42]} -radix decimal} {{/Datapath_testbench/dut/PC[41]} -radix decimal} {{/Datapath_testbench/dut/PC[40]} -radix decimal} {{/Datapath_testbench/dut/PC[39]} -radix decimal} {{/Datapath_testbench/dut/PC[38]} -radix decimal} {{/Datapath_testbench/dut/PC[37]} -radix decimal} {{/Datapath_testbench/dut/PC[36]} -radix decimal} {{/Datapath_testbench/dut/PC[35]} -radix decimal} {{/Datapath_testbench/dut/PC[34]} -radix decimal} {{/Datapath_testbench/dut/PC[33]} -radix decimal} {{/Datapath_testbench/dut/PC[32]} -radix decimal} {{/Datapath_testbench/dut/PC[31]} -radix decimal} {{/Datapath_testbench/dut/PC[30]} -radix decimal} {{/Datapath_testbench/dut/PC[29]} -radix decimal} {{/Datapath_testbench/dut/PC[28]} -radix decimal} {{/Datapath_testbench/dut/PC[27]} -radix decimal} {{/Datapath_testbench/dut/PC[26]} -radix decimal} {{/Datapath_testbench/dut/PC[25]} -radix decimal} {{/Datapath_testbench/dut/PC[24]} -radix decimal} {{/Datapath_testbench/dut/PC[23]} -radix decimal} {{/Datapath_testbench/dut/PC[22]} -radix decimal} {{/Datapath_testbench/dut/PC[21]} -radix decimal} {{/Datapath_testbench/dut/PC[20]} -radix decimal} {{/Datapath_testbench/dut/PC[19]} -radix decimal} {{/Datapath_testbench/dut/PC[18]} -radix decimal} {{/Datapath_testbench/dut/PC[17]} -radix decimal} {{/Datapath_testbench/dut/PC[16]} -radix decimal} {{/Datapath_testbench/dut/PC[15]} -radix decimal} {{/Datapath_testbench/dut/PC[14]} -radix decimal} {{/Datapath_testbench/dut/PC[13]} -radix decimal} {{/Datapath_testbench/dut/PC[12]} -radix decimal} {{/Datapath_testbench/dut/PC[11]} -radix decimal} {{/Datapath_testbench/dut/PC[10]} -radix decimal} {{/Datapath_testbench/dut/PC[9]} -radix decimal} {{/Datapath_testbench/dut/PC[8]} -radix decimal} {{/Datapath_testbench/dut/PC[7]} -radix decimal} {{/Datapath_testbench/dut/PC[6]} -radix decimal} {{/Datapath_testbench/dut/PC[5]} -radix decimal} {{/Datapath_testbench/dut/PC[4]} -radix decimal} {{/Datapath_testbench/dut/PC[3]} -radix decimal} {{/Datapath_testbench/dut/PC[2]} -radix decimal} {{/Datapath_testbench/dut/PC[1]} -radix decimal} {{/Datapath_testbench/dut/PC[0]} -radix decimal}} -subitemconfig {{/Datapath_testbench/dut/PC[63]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[62]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[61]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[60]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[59]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[58]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[57]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[56]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[55]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[54]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[53]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[52]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[51]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[50]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[49]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[48]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[47]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[46]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[45]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[44]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[43]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[42]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[41]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[40]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[39]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[38]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[37]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[36]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[35]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[34]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[33]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[32]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[31]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[30]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[29]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[28]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[27]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[26]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[25]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[24]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[23]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[22]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[21]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[20]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[19]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[18]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[17]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[16]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[15]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[14]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[13]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[12]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[11]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[10]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[9]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[8]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[7]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[6]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[5]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[4]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[3]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[2]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[1]} {-height 15 -radix decimal} {/Datapath_testbench/dut/PC[0]} {-height 15 -radix decimal}} /Datapath_testbench/dut/PC
add wave -noupdate /Datapath_testbench/dut/mreg/ReadData1
add wave -noupdate /Datapath_testbench/dut/mreg/ReadData2
add wave -noupdate /Datapath_testbench/dut/setFlag
add wave -noupdate /Datapath_testbench/dut/flags
add wave -noupdate /Datapath_testbench/dut/ALUFlags_EXE
add wave -noupdate -radix unsigned {/Datapath_testbench/dut/mmem/mem[0]}
add wave -noupdate -radix unsigned {/Datapath_testbench/dut/mmem/mem[8]}
add wave -noupdate -radix unsigned {/Datapath_testbench/dut/mmem/mem[16]}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mmem/mem[24]}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mmem/mem[32]}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mmem/mem[40]}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mmem/mem[48]}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mmem/mem[56]}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mmem/mem[64]}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mmem/mem[72]}
add wave -noupdate /Datapath_testbench/dut/mreg/x31/DataOut
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[30]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[29]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[28]/R/DataOut}
add wave -noupdate {/Datapath_testbench/dut/mreg/x[27]/R/DataOut}
add wave -noupdate {/Datapath_testbench/dut/mreg/x[26]/R/DataOut}
add wave -noupdate {/Datapath_testbench/dut/mreg/x[25]/R/DataOut}
add wave -noupdate {/Datapath_testbench/dut/mreg/x[24]/R/DataOut}
add wave -noupdate {/Datapath_testbench/dut/mreg/x[23]/R/DataOut}
add wave -noupdate {/Datapath_testbench/dut/mreg/x[22]/R/DataOut}
add wave -noupdate {/Datapath_testbench/dut/mreg/x[21]/R/DataOut}
add wave -noupdate -radix unsigned {/Datapath_testbench/dut/mreg/x[20]/R/DataOut}
add wave -noupdate -radix unsigned {/Datapath_testbench/dut/mreg/x[19]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[18]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[17]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[16]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[15]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[14]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[13]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[12]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[11]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[10]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[9]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[8]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[7]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[6]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[5]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[4]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[3]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[2]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[1]/R/DataOut}
add wave -noupdate -radix decimal {/Datapath_testbench/dut/mreg/x[0]/R/DataOut}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {236303384 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 344
configure wave -valuecolwidth 104
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1116035261 ps}
