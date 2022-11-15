vlib work

vlog Part2.v

vsim RateDivider

log -r {/*}

add wave {/*}

force {clock_in} 0 0ns, 1 {5ns} -r 10ns

force {reset_n} 0
force {speed} 2'b01
force {d} 4'b1011
force {reset_n} 1

run 10ns

force {reset_n} 0

run 200ns

force {speed} 2'b10

run 280ns

force {speed} 2'b11

run 560ns

force {speed} 2'b00

run 180ns