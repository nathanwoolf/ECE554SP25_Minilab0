module MAC #
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

reg [DATA_WIDTH*3-1:0]sum_int;

always_ff @(posedge clk, negedge rst_n) begin 
    if (!rst_n || Clr) begin 
        sum_int = 0;
    end
    if (En & !Clr) begin
        sum_int = sum_int + (Ain * Bin);
    end
end

assign Cout = sum_int;

endmodule