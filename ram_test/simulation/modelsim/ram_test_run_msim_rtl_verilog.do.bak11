transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/7.5/ram_test {D:/7.5/ram_test/ram_test.v}
vlog -vlog01compat -work work +incdir+D:/7.5/ram_test {D:/7.5/ram_test/ram.v}
vlog -vlog01compat -work work +incdir+D:/7.5/ram_test {D:/7.5/ram_test/ram_vol.v}
vlog -vlog01compat -work work +incdir+D:/7.5/ram_test {D:/7.5/ram_test/pll.v}
vlog -vlog01compat -work work +incdir+D:/7.5/ram_test/db {D:/7.5/ram_test/db/pll_altpll.v}

vlog -vlog01compat -work work +incdir+D:/7.5/ram_test {D:/7.5/ram_test/ram_test.v}
vlog -vlog01compat -work work +incdir+D:/7.5/ram_test/simulation/modelsim {D:/7.5/ram_test/simulation/modelsim/ram_test.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc" ram_test_vlg_tst

add wave *
view structure
view signals
run -all
