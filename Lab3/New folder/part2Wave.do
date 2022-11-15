vlib work

vlog part2.v

vsim part2

log {/*}
add wave {/*}

force {c_in} 0;

force {a[0]} 0 0ns, 1 {5ns} -r 10 ns
force {a[1]} 0 0ns, 1 {10ns} -r 20 ns
force {a[2]} 0 0ns, 1 {20ns} -r 40 ns
force {a[3]} 0 0ns, 1 {40ns} -r 80 ns

force {b[0]} 0 0ns, 1 {10ns} -r 20 ns
force {b[1]} 0 0ns, 1 {20ns} -r 40 ns
force {b[2]} 0 0ns, 1 {40ns} -r 80 ns
force {b[3]} 0 0ns, 1 {5ns} -r 10 ns

run 80ns