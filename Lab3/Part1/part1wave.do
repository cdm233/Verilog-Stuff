vlib work

vlog part1.v

vsim part1

log {/*}
add wave {/*}

force {MuxSelect[0]} 1
force {MuxSelect[1]} 0
force {MuxSelect[2]} 0
force {Input[0]} 1
force {Input[1]} 1
force {Input[2]} 0
force {Input[3]} 1
force {Input[4]} 0
force {Input[5]} 1
force {Input[6]} 0
run 10ns

force {MuxSelect[0]} 1
force {MuxSelect[1]} 1
force {MuxSelect[2]} 0
force {Input[0]} 1
force {Input[1]} 1
force {Input[2]} 0
force {Input[3]} 1
force {Input[4]} 0
force {Input[5]} 1
force {Input[6]} 0
run 10ns

force {MuxSelect[0]} 1
force {MuxSelect[1]} 0
force {MuxSelect[2]} 1
force {Input[0]} 1
force {Input[1]} 1
force {Input[2]} 0
force {Input[3]} 1
force {Input[4]} 0
force {Input[5]} 0
force {Input[6]} 0
run 10ns

force {MuxSelect[0]} 1
force {MuxSelect[1]} 1
force {MuxSelect[2]} 1
force {Input[0]} 1
force {Input[1]} 1
force {Input[2]} 0
force {Input[3]} 1
force {Input[4]} 0
force {Input[5]} 1
force {Input[6]} 0
run 10ns