onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /binarydisplay_tb/DUT/clk
add wave -noupdate /binarydisplay_tb/DUT/clk_output
add wave -noupdate /binarydisplay_tb/DUT/reset
add wave -noupdate /binarydisplay_tb/DUT/State
add wave -noupdate /binarydisplay_tb/DUT/intertotalVal
add wave -noupdate /binarydisplay_tb/DUT/totalVal
add wave -noupdate /binarydisplay_tb/DUT/SW
add wave -noupdate /binarydisplay_tb/DUT/interSeg
add wave -noupdate /binarydisplay_tb/DUT/segmentDisplay
add wave -noupdate /binarydisplay_tb/DUT/an
add wave -noupdate /binarydisplay_tb/DUT/dp
add wave -noupdate -expand -group Variables /binarydisplay_tb/DUT/line__90/onePos
add wave -noupdate -expand -group Variables /binarydisplay_tb/DUT/line__90/tenPos
add wave -noupdate -expand -group Variables /binarydisplay_tb/DUT/line__90/hundredPos
add wave -noupdate -expand -group Variables /binarydisplay_tb/DUT/line__90/thousandPos
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {554263885 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits sec
update
WaveRestoreZoom {0 ps} {11675532750 ps}
