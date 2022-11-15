vlib work

vlog part3.v
vsim draw

log -r {/*}
add wave {/*}

force iClock 0 0ns, 1 5ns -r 10ns

force iResetn 0
force xPos 7'd3
force yPos 7'd1
run 10ns

force iResetn 1
force iBlack 0
run 10ns

force iPlot 1
run 200ns

force iPlot 0
run 50ns

force iBlack 1
force iPlot 1
run 690ns