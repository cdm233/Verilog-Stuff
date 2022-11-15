vlib work

vlog ECE241Lab2Part3.v

vsim hex_decoder

log {/*}
add wave {/*}

force {c[0]} 0
force {c[1]} 0
force {c[2]} 0
force {c[3]} 0
run 10ns

force {c[0]} 1
force {c[1]} 0
force {c[2]} 0
force {c[3]} 0
run 10ns

force {c[0]} 0
force {c[1]} 1
force {c[2]} 0
force {c[3]} 0
run 10ns

force {c[0]} 1
force {c[1]} 1
force {c[2]} 0
force {c[3]} 0
run 10ns

force {c[0]} 0
force {c[1]} 0
force {c[2]} 1
force {c[3]} 0
run 10ns

force {c[0]} 1
force {c[1]} 0
force {c[2]} 1
force {c[3]} 0
run 10ns

force {c[0]} 0
force {c[1]} 1
force {c[2]} 1
force {c[3]} 0
run 10ns

force {c[0]} 1
force {c[1]} 1
force {c[2]} 1
force {c[3]} 0
run 10ns

force {c[0]} 0
force {c[1]} 0
force {c[2]} 0
force {c[3]} 1
run 10ns

force {c[0]} 1
force {c[1]} 0
force {c[2]} 0
force {c[3]} 1
run 10ns

force {c[0]} 0
force {c[1]} 1
force {c[2]} 0
force {c[3]} 1
run 10ns

force {c[0]} 1
force {c[1]} 1
force {c[2]} 0
force {c[3]} 1
run 10ns

force {c[0]} 0
force {c[1]} 0
force {c[2]} 1
force {c[3]} 1
run 10ns

force {c[0]} 1
force {c[1]} 0
force {c[2]} 1
force {c[3]} 1
run 10ns

force {c[0]} 0
force {c[1]} 1
force {c[2]} 1
force {c[3]} 1
run 10ns

force {c[0]} 1
force {c[1]} 1
force {c[2]} 1
force {c[3]} 1
run 10ns

