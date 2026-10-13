module a(input clk, input rst, input load, input[7:0] bus, output[7:0] out);
	reg[7:0] a;
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			a <= 8'b0;
		end else if (load) begin
			a <= bus;
		end
	end
	assign out = a;
endmodule