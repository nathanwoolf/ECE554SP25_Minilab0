module Minilab0_tb();
//////////// CLOCK //////////
logic 		          		CLOCK2_50;
logic 		          		CLOCK3_50;
logic 		          		CLOCK4_50;
logic 		          		CLOCK_50;

//////////// SEG7 //////////
reg	     [6:0]		HEX0;
reg	     [6:0]		HEX1;
reg	     [6:0]		HEX2;
reg	     [6:0]		HEX3;
reg	     [6:0]		HEX4;
reg	     [6:0]		HEX5;
	
//////////// LED //////////
logic		     [9:0]		LEDR;

//////////// KEY //////////
logic 		     [3:0]		KEY;

//////////// SW //////////
logic 		     [9:0]		SW;

Minilab0 Minilab0(.*); 

initial begin
    CLOCK_50 = 0;
    KEY[0] = 0;

    @(negedge CLOCK_50)

    KEY[0] = 1;
end

always 
    #5 CLOCK_50 = ~CLOCK_50;

endmodule
