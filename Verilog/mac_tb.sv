module mac_tb #
(
parameter DATA_WIDTH = 8
); 

logic clk, rst_n,
    En, 
    Clr; 
logic [DATA_WIDTH-1:0] Ain;
logic [DATA_WIDTH-1:0] Bin;
logic [DATA_WIDTH*3-1:0] Cout;

MAC mac_DUT(.clk(clk), .rst_n(rst_n), .En(En), .Clr(Clr), .Ain(Ain), .Bin(Bin), .Cout(Cout)); 

initial begin
    clk = 0;
    rst_n = 0;
    Ain = {DATA_WIDTH{1'b0}}; 
    Bin = {DATA_WIDTH{1'b0}};
    Clr = 1'b0;
    En = 1'b0;


    @(posedge clk);
    @(negedge clk) rst_n = 1;

	/////////////////////////////
	//TEST1: try multiplying two numbers together
	/////////////////////////////
    @(negedge clk) 
    
    Ain = 8'h2;
    Bin = 8'h2;
    En = 1'b1;

    @(negedge clk) begin
        if (Cout === 4)  
            $display("1.PASS"); 
        else begin
            $display("1.FAIL: first MAC does not equal expected value"); 
            $stop();
        end
    end


	/////////////////////////////
	//TEST2: set en low -make sure Cout doesn't inc 
    /////////////////////////////
    En = 0;
    @(negedge clk) begin
        if (Cout === 4)  
            $display("2.PASS"); 
        else begin
            $display("2.FAIL: En went low and Cout changed"); 
            $stop();
        end
    end
    
    /////////////////////////////
	//TEST3: add some more values
    /////////////////////////////
    Ain = 8'h4;
    Bin = 8'h4;
    En = 1'b1;

    @(negedge clk) begin
        if (Cout === 20)  
            $display("3.PASS"); 
        else begin
            $display("3.FAIL: MAC does not equal expected value"); 
            $stop();
        end
    end

    /////////////////////////////
	//TEST4: try multiplying in zero
    /////////////////////////////
    Ain = 8'h8;
    Bin = 8'h0;

    @(negedge clk) begin
        if (Cout === 20)
            $display("4.PASS");
        else begin
            $display("4.FAIL: MAC does not equal expected value");
            $stop();
        end
    end

    /////////////////////////////
	//TEST5: set clr -> make sure Cout goes to zero
    /////////////////////////////
    Clr = 1'b1;
    @(negedge clk) begin
        if (Cout === 0)  
            $display("5.PASS"); 
        else begin
            $display("5.FAIL: MAC does not equal expected value"); 
            $stop();
        end
    end

	$display("Passed all tests"); 
	$stop(); 



end

always 
    #5 clk = ~clk;

endmodule