vlib work

vlog Part3.v

vsim part3

log -r {/*}

add wave {/*}

force {ClockIn} 0 0ns, 1 {5ns} -r 10ns

force {Resetn} 0
force {Start} 0
force {Letter} 0

run 30ns

force {Resetn} 1
force {Start} 0
force {Letter} 0

run 200ns

force {Resetn} 1
force {Start} 1
force {Letter} 0

run 20ns

force {Resetn} 1
force {Start} 0
force {Letter} 0

run 640ns