vlib work
vlog part3.v
vsim posControl

log -r {/*}
add wave {/*}

force clock 0 0ns, 1 5ns -r 10ns

force iResetn 0
force frames  4'b0 
force xPos    4'b0
force yPos    4'b0
run 10ns

force iResetn 1
run 450ns

force iResetn 1
run 450ns