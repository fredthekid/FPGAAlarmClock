module display(
		input wire clk,          // main clk
		output reg an0,          // enabling and disabling 7seg
		output reg an1,          // enabling and disabling 7seg
		output reg an2,          // enabling and disabling 7seg
		output reg an3,          // enabling and disabling 7seg
		output reg an4,          // enabling and disabling 7seg
		output reg an5,          // enabling and disabling 7seg
		output reg an6,          // enabling and disabling 7seg
		output reg an7,          // enabling and disabling 7seg
		output reg ca,           // lighting up segments for 7seg
		output reg cb,           // lighting up segments for 7seg
		output reg cc,	         // lighting up segments for 7seg
		output reg cd,	         // lighting up segments for 7seg
		output reg ce,	         // lighting up segments for 7seg
		output reg cf,	         // lighting up segments for 7seg
		output reg cg,	         // lighting up segments for 7seg
		);

reg [4:0] secOnesDig = 5; //for displaying ones digit of second
reg [2:0] secTensDig = 4; //for displaying tens digit of second

reg [4:0] minOnesDig = 8; //for displaying ones digit of minute
reg [2:0] minTensDig = 5; //for displaying tens digit of minute

reg [4:0] hrOnesDig = 9; //for displaying ones digit of hour
reg [1:0] hrTensDig = 1; //for displaying tens digit of hour

reg [2:0] ledChoose = 0;
reg [9:0] ledclk = 0; //to divide down clock

//Dividing clock down by 1024 to use to select 7seg display
always@(posedge clk)
begin
    ledclk <= ledclk + 1;
end

//For Cycling through 7 Seg to Display
always@(posedge ledclk[9])
begin
    if(ledChoose == 5) ledChoose <= 0;
    else ledChoose <= ledChoose + 1;
end

//This block cycles through the 7seg
always@(posedge clk)
begin
    if(ledChoose == 0)
    begin
        an0 <= 0;
        an1 <= 1;
        an2 <= 1; //needs to be configured later
        an3 <= 1;
        an4 <= 1;
        an5 <= 1;
        an6 <= 1;
        an7 <= 1;
        {ca,cb,cc,cd,ce,cf,cg} = inputto7seg(secOnesDig);
    end
    
    else if(ledChoose == 1)
    begin
        an0 <= 1;
        an1 <= 0;
        an2 <= 1;
        an3 <= 1; //needs to be configured later
        an4 <= 1;
        an5 <= 1;
        an6 <= 1;
        an7 <= 1;
        {ca,cb,cc,cd,ce,cf,cg} = inputto7seg(secTensDig);
    end
    
    else if(ledChoose == 2)
    begin
        an0 <= 1;
        an1 <= 1;
        an2 <= 0;
        an3 <= 1;
        an4 <= 1; //needs to be configured later
        an5 <= 1;
        an6 <= 1;
        an7 <= 1;
        {ca,cb,cc,cd,ce,cf,cg} = inputto7seg(minOnesDig);
    end
    
    else if(ledChoose == 3)
    begin
        an0 <= 1;
        an1 <= 1;
        an2 <= 1;
        an3 <= 0;
        an4 <= 1;
        an5 <= 1; //needs to be configured later
        an6 <= 1;
        an7 <= 1;
        {ca,cb,cc,cd,ce,cf,cg} = inputto7seg(minTensDig);
    end
    
    else if(ledChoose == 4)
    begin
        an0 <= 1;
        an1 <= 1;
        an2 <= 1;
        an3 <= 1;
        an4 <= 0;
        an5 <= 1;
        an6 <= 1; //needs to be configured later
        an7 <= 1;
        {ca,cb,cc,cd,ce,cf,cg} = inputto7seg(hrOnesDig);
    end
    
    else if(ledChoose == 5)
    begin
        an0 <= 1;
        an1 <= 1;
        an2 <= 1;
        an3 <= 1;
        an4 <= 1;
        an5 <= 0;
        an6 <= 1;
        an7 <= 1; //needs to be configured later
        {ca,cb,cc,cd,ce,cf,cg} = inputto7seg(hrTensDig);
    end
end

function [6:0] inputto7seg;
input [3:0] convert;
begin
    case(convert)
        4'b0000: inputto7seg = 7'b0000001; //0
        4'b0001: inputto7seg = 7'b1001111; //1
        4'b0010: inputto7seg = 7'b0010010; //2
        4'b0011: inputto7seg = 7'b0000110; //3
        4'b0100: inputto7seg = 7'b1001100; //4
        4'b0101: inputto7seg = 7'b0100100; //5
        4'b0110: inputto7seg = 7'b0100000; //6
        4'b0111: inputto7seg = 7'b0001111; //7
        4'b1000: inputto7seg = 7'b0000000; //8
        4'b1001: inputto7seg = 7'b0000100; //9
        4'b1010: inputto7seg = 7'b1111111; //blank
        4'b1011: inputto7seg = 7'b1111111; //blank
        4'b1100: inputto7seg = 7'b1111111; //blank
        4'b1101: inputto7seg = 7'b1111111; //blank
        4'b1110: inputto7seg = 7'b1111111; //blank
        4'b1111: inputto7seg = 7'b1111111; //blank
        default: inputto7seg = 7'b1111111; //blank
	endcase
end
endfunction

endmodule
