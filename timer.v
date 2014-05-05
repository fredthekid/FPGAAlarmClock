module timer(
        input wire clk,
        
        );

reg [26:0] secondDivideCount = 0; //after 99999999 100MHz counts, 1 second has passed
reg incrementSecond = 0; //if 1, ones place for second needs to be incremented
