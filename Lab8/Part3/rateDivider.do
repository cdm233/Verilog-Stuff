vlib work

vlog part3.v
vsim delayCounter

log -r {/*}
add wave {/*}

force {clock} 0 0ns, 1 5ns -r 10ns 

force {resetn} 0
run 10ns

force {resetn} 1
force {enable} 1
run 420ns