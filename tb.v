module tb();
	reg clk_in = 0;
	reg rst;
	integer i;

	initial begin
		$dumpfile("tb.out.vcd");
		$dumpvars(0, tb);
		rst = 1;
		#1 rst = 0;
	end

	initial begin
		for (i = 0; i < 128; i++) begin
			#1 clk_in = ~clk_in;
		end
	end

	core u_core (
		.clk_in(clk_in),
		.rst_ext(rst)
	);
endmodule
