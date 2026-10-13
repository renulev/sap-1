all: run

run: sim
	vvp sim

sim: a.v alu.v b.v clock.v cu.v ir.v mem.v pc.v tb.v
	iverilog -o sim a.v alu.v b.v clock.v cu.v ir.v mem.v pc.v tb.v

wave: run
	gtkwave tb.out.vcd

clean:
	rm -f sim tb.out.vcd