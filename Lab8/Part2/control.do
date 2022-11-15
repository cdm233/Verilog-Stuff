vlib work

vlog part2.v

vsim control

log -r {/*}

add wave {/*}

force {clock} 0 0ns, 1 {5ns} -r 10ns

force {resetn} 0
force {iBlack} 0
force {iLoadx} 0
force {iPlotBox} 0
run 50ns

force {resetn} 1
force {iLoadx} 1
run 50ns

force {iLoadx} 0
run 50ns

force {iPlotBox} 1
run 50ns

force {iPlotBox} 0
run 200ns
