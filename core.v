module core (
	input wire clk_in,
	input wire rst_ext
);
	wire hlt;
	reg clk_in_reg;
	wire clk;
	wire rst;

	assign rst = rst_ext;

	clock clock(
		.hlt(hlt),
		.clk_in(clk_in),
		.clk_out(clk)
	);

	wire[4:0] bus_en = {pc_en, mem_en, ir_en, a_en, adder_en};
	reg[7:0] bus;

	always @(*) begin
		case (bus_en)
			5'b00001: bus = adder_out;
			5'b00010: bus = a_out;
			5'b00100: bus = ir_out;
			5'b01000: bus = mem_out;
			5'b10000: bus = pc_out;
			default: bus = 8'b0;
		endcase
	end

	wire pc_inc;
	wire pc_en;
	wire[3:0] pc_out;
	pc pc(
		.clk(clk),
		.rst(rst),
		.inc(pc_inc),
		.out(pc_out)
	);

	wire mar_load;
	wire mem_en;
	wire[7:0] mem_out;
	mem mem(
		.clk(clk),
		.rst(rst),
		.load(mar_load),
		.bus(bus),
		.out(mem_out)
	);

	wire a_load;
	wire a_en;
	wire[7:0] a_out;
	a a(
		.clk(clk),
		.rst(rst),
		.load(a_load),
		.bus(bus),
		.out(a_out)
	);

	wire b_load;
	wire[7:0] b_out;
	b b(
		.clk(clk),
		.rst(rst),
		.load(b_load),
		.bus(bus),
		.out(b_out)
	);

	wire adder_sub;
	wire adder_en;
	wire[7:0] adder_out;
	alu alu(
		.a(a_out),
		.b(b_out),
		.sub(adder_sub),
		.out(adder_out)
	);

	wire ir_load;
	wire ir_en;
	wire[7:0] ir_out;
	ir ir(
		.clk(clk),
		.rst(rst),
		.load(ir_load),
		.bus(bus),
		.out(ir_out)
	);

	cu cu(
		.clk(clk),
		.rst(rst),
		.opcode(ir_out[7:4]),
		.out({
			hlt,
			pc_inc,
			pc_en,
			mar_load,
			mem_en,
			ir_load,
			ir_en,
			a_load,
			a_en,
			b_load,
			adder_sub,
			adder_en
		})
	);
endmodule