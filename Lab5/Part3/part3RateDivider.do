vlib work

vlog part3.v

vsim rateDivider

log -r {/*}

add wave {/*}

force {clock_in} 0 0ns, 1 {5ns} -r 10ns

force {reset_n} 0
force {d} 4'b1010

run 10ns

force {reset_n} 1


run 200ns