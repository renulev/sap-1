module b(input clk, input rst, input load, input[7:0] bus, output[7:0] out);
	reg[7:0] b;
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			b <= 8'b0;
		end else if (load) begin
			b <= bus;
		end
	end
	assign out = b;
endmodule
