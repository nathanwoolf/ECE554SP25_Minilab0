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
    $display("Test 1: test full and empty when there is no write.");
    @(negedge clk) begin
        if(empty !== 1) begin
            $display("Test 1 failed: empty not set when there was no write.");
            $stop();
        end
        else if(full !== 0) begin
            $display("Test 1 failed: full set when array should be empty.");
            $stop();
        end
    end
    $display("Test 1 passed\n");

    // ***************** TEST 2 *****************
    $display("Test 2: test full and empty data appears on i_data.");
    i_data = 8'h01;
    @(negedge clk) begin
        if(empty !== 1) begin
            $display("Test 2 failed: empty not set when there was no write.");
            $stop();
        end
        else if(full !== 0) begin
            $display("Test 2 failed: full set when array should be empty.");
            $stop();
        end
    end
    $display("Test 2 passed\n");

    // ***************** TEST 3 *****************
    $display("Test 3: test a write then read of data value 1.");
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
    $display("Test 3 passed\n");

    // ***************** TEST 4 *****************
    $display("Test 4: test that empty is reset when fifo is emptied.");
    @(negedge clk) begin
        if (empty !== 1) begin
            $display("Test 4 failed: empty not reset when queue emptied.");
            $stop();
        end
    end
    $display("Test 4 passed\n");

    // ***************** TEST 5 *****************
    $display("Test 5: test a write of data value 2, write of data value 3, then read of data value 2.");
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
    $display("Test 5 passed\n");

    // ***************** TEST 6 *****************
    $display("Test 6: test that o_data stays at the same value after a cycle of no read.");
    @(negedge clk)
    begin
        if (o_data !== 8'h02) begin
            $display("Test 6 failed: read data not on the output after a cycle of no read.");
            $stop();
        end
    end
    $display("Test 6 passed\n");

    // ***************** TEST 7 *****************
    $display("Test 7: test read of the previous data value 3.");
    rden = 1;
    @(negedge clk)
    rden = 0;
    begin
        if (o_data !== 8'h03) begin
            $display("Test 7 failed: out data not correct after second read.");
            $stop();
        end
    end
    $display("Test 7 passed\n");

    // ***************** TEST 8 *****************
    $display("Test 8: test write of 8 consecutive data values and that read and write are correct at all times.");
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
    $display("Test 8 passed\n");

    // ***************** TEST 9 *****************
    $display("Test 9: test reading and writing at the same time on a full queue.");
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
    $display("Test 9 passed\n");

    // ***************** TEST 10 *****************
    $display("Test 10: test reading 8 last 8 written values on full queue.");
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
    $display("Test 10 passed\n");

    // ***************** TEST 11 *****************
    $display("Test 11: test reading on empty.");
    rden = 1;
    @(negedge clk)
    rden = 0;
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
    $display("Test 11 passed\n");

    // ***************** TEST 12 *****************
    $display("Test 12: test writing value to fill queue from the start of the queue.");
    @(negedge clk)
    rst_n = 0;
    @(negedge clk)
    rst_n = 1;
    wren = 1;
    i_data = 8'h01;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 12 failed: empty set after write 1.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 12 failed: full set after write 1.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h02;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 12 failed: empty set after write 2.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 12 failed: full set after write 2.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h03;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 12 failed: empty set after write 3.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 12 failed: full set after write 3.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h04;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 12 failed: empty set after write 4.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 12 failed: full set after write 4.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h05;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 12 failed: empty set after write 5.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 12 failed: full set after write 5.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h06;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 12 failed: empty set after write 6.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 12 failed: full set after write 6.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h07;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 12 failed: empty set after write 7.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 12 failed: full set after write 7.");
            $stop();
        end
    end
    wren = 1;
    i_data = 8'h08;
    @(negedge clk)
    wren = 0;
    begin
        if (empty !== 0) begin
            $display("Test 12 failed: empty set after write 8.");
            $stop();
        end
        if (full !== 1) begin
            $display("Test 12 failed: full not set after write 8.");
            $stop();
        end
    end
    $display("Test 12 passed\n");

    // ***************** TEST 12.5 *****************
    $display("Test 12.5: make sure no values are written if attempting to write on full queue.");
    wren = 1;
    i_data = 8'h09;
    @(negedge clk)
    wren = 0;
    begin
        if (empty !== 0) begin
            $display("Test 12.5 failed: empty set after attempted write 9.");
            $stop();
        end
        if (full !== 1) begin
            $display("Test 12.5 failed: full not set after attempted write 9.");
            $stop();
        end
    end
    $display("Test 12.5 passed\n");

    // ***************** TEST 13 *****************
    $display("Test 13: test reading and writing on full queue when pointers start at 0.");
    wren = 1;
    rden = 1;
    i_data = 8'h09;
    @(negedge clk)
    wren = 0;
    rden = 0;
    begin
        if (empty !== 0) begin
            $display("Test 13 failed: empty set when reading and writing on full queue.");
            $stop();
        end
        if (full !== 1) begin
            $display("Test 13 failed: full not set after read and write on full queue.");
            $stop();
        end
        if (o_data !== 8'h01) begin
            $display("Test 13 failed: read data not valid after read and write on full queue.");
            $stop();
        end
    end
    $display("Test 13 passed\n");

    // ***************** TEST 14 *****************
    $display("Test 14: read previous 8 values with pointers across queue boundary.");
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 14 failed: empty set after read 1.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 14 failed: full set after read 1.");
            $stop();
        end
        if (o_data !== 8'h02) begin
            $display("Test 14 failed: read data not valid after read 1.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 14 failed: empty set after read 2.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 14 failed: full set after read 2.");
            $stop();
        end
        if (o_data !== 8'h03) begin
            $display("Test 14 failed: read data not valid after read 2.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 14 failed: empty set after read 3.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 14 failed: full set after read 3.");
            $stop();
        end
        if (o_data !== 8'h04) begin
            $display("Test 14 failed: read data not valid after read 3.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 14 failed: empty set after read 4.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 14 failed: full set after read 4.");
            $stop();
        end
        if (o_data !== 8'h05) begin
            $display("Test 14 failed: read data not valid after read 4.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 14 failed: empty set after read 5.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 14 failed: full set after read 5.");
            $stop();
        end
        if (o_data !== 8'h06) begin
            $display("Test 14 failed: read data not valid after read 5.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 14 failed: empty set after read 6.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 14 failed: full set after read 6.");
            $stop();
        end
        if (o_data !== 8'h07) begin
            $display("Test 14 failed: read data not valid after read 6.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 0) begin
            $display("Test 14 failed: empty set after read 7.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 14 failed: full set after read 7.");
            $stop();
        end
        if (o_data !== 8'h08) begin
            $display("Test 14 failed: read data not valid after read 7.");
            $stop();
        end
    end
    rden = 1;
    @(negedge clk)
    begin
        if (empty !== 1) begin
            $display("Test 14 failed: empty not set after read 8.");
            $stop();
        end
        if (full !== 0) begin
            $display("Test 14 failed: full set after read 8.");
            $stop();
        end
        if (o_data !== 8'h09) begin
            $display("Test 14 failed: read data not valid after read 8.");
            $stop();
        end
    end
    rden = 0;
    $display("Test 14 passed\n");

    $display("HOORAY ALL TESTS PASSED!!!!");
    $stop();
end

always 
    #5 clk = ~clk;

endmodule