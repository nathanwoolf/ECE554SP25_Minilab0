module MAC_IP #
(
parameter DATA_WIDTH = 8
)
(
input clk,
input rst_n,
input En,
input Clr,
input [DATA_WIDTH-1:0] Ain,
input [DATA_WIDTH-1:0] Bin,
output [DATA_WIDTH*3-1:0] Cout
);

reg [DATA_WIDTH*2-1:0]mult_int;
reg [DATA_WIDTH*3-1:0]sum_int;
reg [DATA_WIDTH*3-1:0]flopped_int;

MULT MULT_inst (
	.dataa ( Ain ),
	.datab ( Bin ),
	.result ( mult_int ));

ADD	ADD_inst (
	.dataa ( mult_int ),
	.datab ( flopped_int ),
	.result ( sum_int ));


always_ff @(posedge clk, negedge rst_n) begin 
    if (!rst_n) begin 
        flopped_int = 0;
    end
    else if (Clr) begin
        flopped_int = 0;
    end
    else if (En) begin
        flopped_int = sum_int;
    end
end

assign Cout = flopped_int;



endmodule