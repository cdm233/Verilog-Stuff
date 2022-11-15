vlib work

vlog part2.v

vsim part2

log -r {/*}

add wave {/*}

force {iClock} 0 0ns, 1 {5ns} -r 10ns

force {iResetn} 0
force {iBlack} 0
force {iLoadX} 0
force {iPlotBox} 0
force {iColour} 3'd5
force {iXY_Coord} 7'd3
run 40ns

force {iResetn} 1
force {iLoadX} 1
run 20ns

force {iLoadX} 0
run 20ns

force {iXY_Coord} 7'd1
run 20ns

force {iPlotBox} 1
run 20ns

force {iPlotBox} 0
force {iBlack} 0
run 500ns
