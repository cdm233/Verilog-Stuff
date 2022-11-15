vlib work

vlog part2.v

vsim part2

log {/*}
add wave {/*}

force {Reset_b} 0
force {Clock} 0
run 10ns

force {Clock} 1
run 10ns

force {Clock} 0
run 10ns


force {Data[0]} 1
force {Data[1]} 0
force {Data[2]} 0
force {Data[3]} 1

force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 0

force {Reset_b} 1

run 10ns

force {Clock} 1 0ns, 0 {10ns} -r 20 ns
run 40ns