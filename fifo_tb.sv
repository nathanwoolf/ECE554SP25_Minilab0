module FIFO_tb
#(
  parameter DEPTH=8,
  parameter DATA_WIDTH=8
);
    reg clk, rst_n;
    reg rden; 
    reg wren; 
    reg [DATA_WIDTH-1:0] i_data;
    reg [DATA_WIDTH-1:0] o_data;
    reg full;
    reg empty;

    FIFO #(.DEPTH(DEPTH), .DATA_WIDTH(DATA_WIDTH)) FIFO_DUT(.clk(clk), .rst_n(rst_n), .rden(rden), .wren(wren), .i_data(i_data), 
                    .o_data(o_data), .full(full), .empty(empty));

initial begin
    clk = 0; 
    rst_n = 0; 
    rden = 0; 
    wren = 0;
    i_data = {DEPTH{1'b0}};

    @(negedge clk) rst_n = 1;   //deassert rst_n


    // ***************** TEST 1 *****************
    @(negedge clk) begin
        if(empty !== 1) begin
            $display("Test 1 failed: empty not set when there was no write.");
            $stop();
        end
        if(full !== 0) begin
            $display("Test 1 failed: full set when array should be empty.");
            $stop();
        end
    end

    // ***************** TEST 2 *****************
    i_data = 8'h01;
    @(negedge clk) begin
        if(empty !== 1) begin
            $display("Test 2 failed: empty not set when there was no write.");
            $stop();
        end
        if(full !== 0) begin
            $display("Test 2 failed: full set when array should be empty.");
            $stop();
        end
    end

    // ***************** TEST 3 *****************
    i_data = 8'h01;
    wren = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 3 failed: empty still set after data write.");
            $stop();
        end
    end
    wren = 0;
    rden = 1;
    @(negedge clk)
    rden = 0;
    begin
        if (o_data !== 8'h01) begin
            $display("Test 3 failed: failed to write then read the same data.");
            $stop();
        end
    end

    // ***************** TEST 4 *****************
    @(negedge clk) begin
        if (empty !== 1) begin
            $display("Test 4 failed: empty not reset when queue emptied.");
            $stop();
        end
    end

    // ***************** TEST 5 *****************
    i_data = 8'h02;
    wren = 1;
    @(negedge clk)
    i_data = 8'h03;
    wren = 1;
    @(negedge clk)
    wren = 0;
    rden = 1;
    @(negedge clk)
    rden = 0;
    begin
        if (o_data !== 8'h02) begin
            $display("Test 5 failed: failed to write twice then read the first written data.");
            $stop();
        end
    end

    // ***************** TEST 6 *****************
    @(negedge clk)
    begin
        if (o_data !== 8'h02) begin
            $display("Test 6 failed: read data not on the output after a cycle of no read.");
            $stop();
        end
    end

    // ***************** TEST 7 *****************
    rden = 1;
    @(negedge clk)
    rden = 0;
    begin
        if (o_data !== 8'h03) begin
            $display("Test 7 failed: out data not correct after second read.");
            $stop();
        end
    end

    // ***************** TEST 8 *****************
    wren = 1;
    i_data = 8'h01;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 8 failed: empty set after write 1.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 8 failed: full set after write 1.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h02;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 8 failed: empty set after write 2.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 8 failed: full set after write 2.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h03;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 8 failed: empty set after write 3.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 8 failed: full set after write 3.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h04;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 8 failed: empty set after write 4.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 8 failed: full set after write 4.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h05;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 8 failed: empty set after write 5.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 8 failed: full set after write 5.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h06;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 8 failed: empty set after write 6.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 8 failed: full set after write 6.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h07;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 8 failed: empty set after write 7.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 8 failed: full set after write 7.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h08;
    @(negedge clk)
    wren = 0;
    begin
        if (empty !== 0) begin
            $display("Test 8 failed: empty set after write 8.");
            $stop();
        end
        if (full !== 1) begin
            $display("Test 8 failed: full not set after write 8.");
            $stop();
        end
    end

    // ***************** TEST 9 *****************
    wren = 1;
    rden = 1;
    i_data = 8'h09;
    @(negedge clk)
    wren = 0;
    rden = 0;
    begin
        if (empty !== 0) begin
            $display("Test 9 failed: empty set when reading and writing on full queue.");
            $stop();
        end
        if (full !== 1) begin
            $display("Test 9 failed: full not set after read and write on full queue.");
            $stop();
        end
        if (o_data !== 8'h01) begin
            $display("Test 9 failed: read data not valid after read and write on full queue.");
            $stop();
        end
    end

    // ***************** TEST 10 *****************
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 10 failed: empty set after read 1.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 10 failed: full set after read 1.");
            $stop();
        end
        if (o_data !== 8'h02) begin
            $display("Test 10 failed: read data not valid after read 1.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 10 failed: empty set after read 2.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 10 failed: full set after read 2.");
            $stop();
        end
        if (o_data !== 8'h03) begin
            $display("Test 10 failed: read data not valid after read 2.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 10 failed: empty set after read 3.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 10 failed: full set after read 3.");
            $stop();
        end
        if (o_data !== 8'h04) begin
            $display("Test 10 failed: read data not valid after read 3.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 10 failed: empty set after read 4.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 10 failed: full set after read 4.");
            $stop();
        end
        if (o_data !== 8'h05) begin
            $display("Test 10 failed: read data not valid after read 4.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 10 failed: empty set after read 5.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 10 failed: full set after read 5.");
            $stop();
        end
        if (o_data !== 8'h06) begin
            $display("Test 10 failed: read data not valid after read 5.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 10 failed: empty set after read 6.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 10 failed: full set after read 6.");
            $stop();
        end
        if (o_data !== 8'h07) begin
            $display("Test 10 failed: read data not valid after read 6.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 10 failed: empty set after read 7.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 10 failed: full set after read 7.");
            $stop();
        end
        if (o_data !== 8'h08) begin
            $display("Test 10 failed: read data not valid after read 7.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 1) begin
            $display("Test 10 failed: empty not set after read 8.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 10 failed: full set after read 8.");
            $stop();
        end
        if (o_data !== 8'h09) begin
            $display("Test 10 failed: read data not valid after read 8.");
            $stop();
        end
    end
    rden = 0;

    // ***************** TEST 11 *****************
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 1) begin
            $display("Test 11 failed: empty not set after read on empty.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 11 failed: full set after read on empty.");
            $stop();
        end
        if (o_data !== 8'h09) begin
            $display("Test 11 failed: previous read data not valid after read on empty.");
            $stop();
        end
    end

    $display("HOORAY ALL TESTS PASSED!!!!");
end

always 
    #5 clk = ~clk;

endmodule