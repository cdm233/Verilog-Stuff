vlib work

vlog part3.v
vsim posDataPath

log -r {/*}
add wave {/*}

force {iClock} 0 0ns, 1 5ns -r 10ns
force {iResetX} 	0
force {iResetY} 	0
force {iResetCounter} 	0
force {DirH}		1
force {DirY}		0
force {iColour}		3'd5
force {upDateX}		0
force {upDateY}		0
force {iPlot}		0
run 20ns

force {iPlot}		1
force {upDateX}		1
force {upDateY}		1
force {iResetX} 	1
force {iResetY} 	1
force {iResetCounter} 	1
run 200ns