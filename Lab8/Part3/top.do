vlib work
vlog part3.v
vsim part3

log -r {/*}
add wave {/*}

force iClock 0 0ns, 1 5ns -r 10ns

force iColour 3'd3
force iResetn 0
run 50ns

force iResetn 1
run 400ns