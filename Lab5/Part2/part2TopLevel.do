vlib work

vlog part2.v

vsim part2

log -r {/*}

add wave {/*}

force {ClockIn} 0 0ns, 1 {5ns} -r 10ns

force {Reset} 1
force {Speed} 2'b00

run 10ns

force {Reset} 0
force {Speed} 2'b01


run 200ns

force {Speed} 2'b10

run 280ns

force {Speed} 2'b11

run 560ns

force {Speed} 2'b00

run 180ns