vlib work

vlog part3.v

vsim part3

log {/*}
add wave {/*}

force {A[0]} 0 0ns, 1 {5ns} -r 10 ns
force {A[1]} 0 0ns, 1 {10ns} -r 20 ns
force {A[2]} 0 0ns, 1 {20ns} -r 40 ns
force {A[3]} 0 0ns, 1 {40ns} -r 80 ns

force {B[0]} 0 0ns, 1 {10ns} -r 20 ns
force {B[1]} 0 0ns, 1 {20ns} -r 40 ns
force {B[2]} 0 0ns, 1 {40ns} -r 80 ns
force {B[3]} 0 0ns, 1 {5ns} -r 10 ns

force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 1
run 80ns

force {A[2]} 0 0ns, 1 {20ns} -r 40 ns
force {A[3]} 0 0ns, 1 {40ns} -r 80 ns
force {A[0]} 0 0ns, 1 {5ns} -r 10 ns
force {A[1]} 0 0ns, 1 {10ns} -r 20 ns

force {B[0]} 0 0ns, 1 {10ns} -r 20 ns
force {B[1]} 0 0ns, 1 {20ns} -r 40 ns
force {B[2]} 0 0ns, 1 {40ns} -r 80 ns
force {B[3]} 0 0ns, 1 {5ns} -r 10 ns

force {Function[0]} 1
force {Function[1]} 0
force {Function[2]} 1
run 80ns