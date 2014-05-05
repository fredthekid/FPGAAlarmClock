`timescale 1ns / 1ps

module main(
		input wire clk,          // main clk
	    input wire up,           // increment in set modes
        input wire down,         // decrement in set modes
        input wire left,         // cycle between place values
        input wire right,        // cycle between place values
        //input wire middle,       // disbling the alarm
        input wire [1:0] switch,  // picking modes
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
		output reg ce,           // lighting up segments for 7seg
		output reg cf,	         // lighting up segments for 7seg
		output reg cg,	         // lighting up segments for 7seg
		output wire speaker,     // used for outputting speaker
		output wire vcc          // powering stuff
		);


//******************************************************************//
// START Instantiation of PicoBlaze and the Instruction ROM.        //
//******************************************************************//

wire [11:0] address;
wire [17:0] instruction;
wire        bram_enable;
wire [7:0]  port_id;
wire [7:0]  out_port;
reg  [7:0]  in_port;
wire        write_strobe;
wire        k_write_strobe;
wire        read_strobe;
wire        interrupt;


kcpsm6 kcpsm6_inst (
        .address(address),
        .instruction(instruction),
        .bram_enable(bram_enable),
        .port_id(port_id),
        .write_strobe(write_strobe),
        .k_write_strobe(k_write_strobe),
        .out_port(out_port),
        .read_strobe(read_strobe),
        .in_port(in_port),
        .interrupt(interrupt),
        .interrupt_ack(1'b0),
        .reset(1'b0),
        .sleep(1'b0),
        .clk(clk)); 

software software_inst (
        .address(address),
        .instruction(instruction),
        .bram_enable(bram_enable),
        .clk(clk));
        
//***************************************************************//
// END Instantiation of PicoBlaze and the Instruction ROM.       //
//***************************************************************//

//*********************//
// START OF MAIN CODE  //
//*********************//

//////////////////////////////
// START OF DISPLAY SECTION //
//////////////////////////////

reg [4:0] secOnesDig; //for displaying ones digit of second
reg [2:0] secTensDig; //for displaying tens digit of second

reg [4:0] minOnesDig; //for displaying ones digit of minute
reg [2:0] minTensDig; //for displaying tens digit of minute

reg [4:0] hrOnesDig; //for displaying ones digit of hour
reg [1:0] hrTensDig; //for displaying tens digit of hour

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
    if(ledChoose == 6) ledChoose <= 0;
    else ledChoose <= ledChoose + 1;
end

//This block enables the ones digit of 'second' for 7seg
always@(posedge clk)
begin
    if(ledChoose == 0)
    begin
        an0 <= blinkSecOnes; //needs to be configured later
        an1 <= 1;
        an2 <= 1; 
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
        an1 <= blinkSecTens;//needs to be configured later
        an2 <= 1;
        an3 <= 1; 
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
        an2 <= blinkMinOnes; //needs to be configured later
        an3 <= 1;
        an4 <= 1; 
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
        an3 <= blinkMinTens; //needs to be configured later
        an4 <= 1;
        an5 <= 1;
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
        an4 <= blinkHrOnes;//needs to be configured later
        an5 <= 1;
        an6 <= 1;
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
        an5 <= blinkHrTens;//needs to be configured later
        an6 <= 1;
        an7 <= 1;
        {ca,cb,cc,cd,ce,cf,cg} = inputto7seg(hrTensDig);
    end
    
    else if(ledChoose == 6)
    begin
        an0 <= 1;
        an1 <= 1;
        an2 <= 1;
        an3 <= 1;
        an4 <= 1;
        an5 <= 1;//needs to be configured later
        an6 <= 1;
        an7 <= 0;
        {ca,cb,cc,cd,ce,cf,cg} = modeto7seg(mode);
    end
end

always@(posedge clk)
begin   
    if(mode == 2'b10)
    begin
        secOnesDig <= alarmSecOnes;
        secTensDig <= alarmSecTens;
    
        minOnesDig <= alarmMinOnes;
        minTensDig <= alarmMinTens;
    
        hrOnesDig <= alarmHrOnes;
        hrTensDig <= alarmHrTens;
    end
    
    else
    begin
        secOnesDig <= mainSecOnes;
        secTensDig <= mainSecTens;
    
        minOnesDig <= mainMinOnes;
        minTensDig <= mainMinTens;
    
        hrOnesDig <= mainHrOnes;
        hrTensDig <= mainHrTens;
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

function [6:0] modeto7seg;
input [1:0] convert;
begin
    case(convert)
        4'b0000: modeto7seg = 7'b1111111; //0
        4'b0001: modeto7seg = 7'b0100100; //1
        4'b0010: modeto7seg = 7'b0001000; //2
        default: modeto7seg = 7'b1111111; //blank
	endcase
end
endfunction
////////////////////////////
// END OF DISPLAY SECTION //
////////////////////////////

////////////////////////////
// START OF TIMER SECTION //
////////////////////////////
reg [26:0] secondDivideCount = 0; //after 99999999 100MHz counts, 1 second has passed
reg incrementSecond = 0; //if 1, ones place for second needs to be incremented

reg [4:0] mainSecOnes = 0; //for displaying ones digit of second
reg [2:0] mainSecTens = 0; //for displaying tens digit of second

reg [4:0] mainMinOnes = 0; //for displaying ones digit of minute
reg [2:0] mainMinTens = 0; //for displaying tens digit of minute

reg [4:0] mainHrOnes = 0; //for displaying ones digit of hour
reg [1:0] mainHrTens = 0; //for displaying tens digit of hour

//This block increments secondDivideCount up to 99999999 then resets to zero
always @(posedge clk)
begin
    if(secondDivideCount == 99999999) 
    begin
		secondDivideCount <= 0;
		incrementSecond <= 1;
	end
	
	else 
	begin
	   incrementSecond <= 0;
	   secondDivideCount <= secondDivideCount +1;
	end
end

//For incrementing Second(Ones place)
always @(posedge clk)
begin
    if(mode == 2'b01)
    begin
        mainSecOnes <= mainSecOnes; 
    end

    else
    begin
        if(mainSecOnes == 9 && incrementSecond) mainSecOnes <= 0; //reset counter at 9
        else if(mainSecOnes != 9 && incrementSecond)  mainSecOnes <= mainSecOnes +1;
        else mainSecOnes <= mainSecOnes;
    end
end

//For incrementing Second(Tens place)
always @(posedge clk)
begin
	if(mode == 2'b01)
    begin
        mainSecTens <= mainSecTens; 
    end

    else
    begin
	   if(mainSecTens == 5 && mainSecOnes == 9 && incrementSecond) mainSecTens <= 0; //reset counter at 6
	   else if(mainSecTens != 5 && mainSecOnes == 9 && incrementSecond) mainSecTens <= mainSecTens +1;
	   else mainSecTens <= mainSecTens;
	end
end

//For incrementing Minute(Ones place)
always @(posedge clk)
begin
    if(mode == 2'b01)
    begin
        mainMinOnes <= setMinOnes; 
    end

    else
    begin
	   if(mainMinOnes == 9 && mainSecTens == 5 && mainSecOnes == 9 && incrementSecond) mainMinOnes <= 0; //reset counter at 9
	   else if(mainMinOnes != 9 && mainSecTens == 5 && mainSecOnes == 9 && incrementSecond) mainMinOnes <= mainMinOnes +1;
	   else mainMinOnes <= mainMinOnes;
	end
end

//For incrementing Minute(Tens place)
always @(posedge clk)
begin
    if(mode == 2'b01)
    begin
        mainMinTens <= setMinTens; 
    end
    
    else
    begin
        if(mainMinTens == 5 && mainMinOnes == 9 && mainSecTens == 5 && mainSecOnes == 9 && incrementSecond) mainMinTens <= 0; //reset counter at 9
        else if(mainMinTens != 5 && minOnesDig == 9 && mainSecTens == 5 && mainSecOnes == 9 && incrementSecond) mainMinTens <= mainMinTens +1;
        else mainMinTens <= mainMinTens;
    end
end

//For incrementing Hour(Ones place)
always @(posedge clk)
begin
    if(mode == 2'b01)
    begin
        mainHrOnes <= setHrOnes; 
    end
    
    else
    begin
        if((mainHrOnes== 9 || (mainHrTens == 2 && mainHrOnes== 3)) && (mainMinTens == 5 && minOnesDig == 9 && mainSecTens == 5 && mainSecOnes == 9 && incrementSecond)) mainHrOnes<= 0; //reset counter at 9
        else if(mainHrOnes!= 9 && mainMinTens == 5 && minOnesDig == 9 && mainSecTens == 5 && mainSecOnes == 9 && incrementSecond) mainHrOnes<= mainHrOnes+1;
        else mainHrOnes<= mainHrOnes;
    end
end

//For incrementing Hour(Tens place)
always @(posedge clk)
begin
    if(mode == 2'b01)
    begin
        mainHrTens <= setHrTens;    
    end
    
    else
    begin
        if(mainHrTens == 2 && mainHrOnes== 3 && mainMinTens == 5 && minOnesDig == 9 && mainSecTens == 5 && mainSecOnes == 9 && incrementSecond) mainHrTens <= 0; //reset counter at 9
        else if(mainHrOnes== 9 && mainMinTens == 5 && minOnesDig == 9 && mainSecTens == 5 && mainSecOnes == 9 && incrementSecond && mainHrOnes== 9) mainHrTens <= mainHrTens +1;
        else mainHrTens <= mainHrTens;
    end
end

////////////////////////////
// END OF TIMER SECTION   //
////////////////////////////

////////////////////////////
// START OF ALARM SECTION //
////////////////////////////

assign vcc = 1'b1;          //power

reg [4:0] alarmSecOnes = 0; //for comparing ones digit of second
reg [2:0] alarmSecTens = 0; //for comparing tens digit of second

reg [4:0] alarmMinOnes = 0; //for displaying ones digit of minute
reg [2:0] alarmMinTens = 0; //for displaying tens digit of minute

reg [4:0] alarmHrOnes = 0; //for displaying ones digit of hour
reg [1:0] alarmHrTens = 0; //for displaying tens digit of hour

/*
reg [16:0] alarmCounter = 0;
reg [16:0] alarmCompare = 67568;
reg alarmToggle = 0;
reg alarmTrig = 0;

assign speaker = alarmToggle;

//For outputting alarm
always@(posedge clk)
begin
	if(alarmSecOnes != mainSecOnes || alarmSecTens != mainSecTens || alarmMinOnes != mainMinOnes || alarmMinTens != mainMinTens || alarmHrOnes != mainHrOnes || alarmHrTens != mainHrTens)
	begin
	   alarmToggle <= 0;
	end
	
	else if(alarmSecOnes == mainSecOnes && alarmSecTens == mainSecTens && alarmMinOnes != mainMinOnes || alarmMinTens != mainMinTens || alarmHrOnes != mainHrOnes || alarmHrTens != mainHrTens)
	begin
	   alarmToggle <= alarmTrig;
	end
	
	else
	begin
        alarmToggle <= 0;
    end
end

always@(posedge clk)
begin
    if(alarmCounter < alarmCompare) alarmCounter <= alarmCounter + 1;
    else if(alarmCounter >= alarmCompare)
    begin
        alarmCounter <= 0;
        alarmTrig <= ~(alarmTrig);
    end
end
*/
//////////////////////////
// END OF ALARM SECTION //
//////////////////////////

///////////////////////////////
// START OF SET TIME SECTION //
///////////////////////////////
reg [4:0] setSecOnes = 0;
reg [2:0] setSecTens = 0;
reg [4:0] setMinOnes = 0; //for displaying ones digit of minute
reg [2:0] setMinTens = 0; //for displaying tens digit of minute
reg [4:0] setHrOnes = 0; //for displaying ones digit of hour
reg [1:0] setHrTens = 0; //for displaying tens digit of hour

always @ (posedge clk)
begin
    if (mode == 2'b00)
    begin
        setSecOnes <= mainSecOnes;
        setSecTens <= mainSecTens;
        setMinOnes <= mainMinOnes;
        setMinTens <= mainMinTens;
        setHrOnes <= mainHrOnes;
        setHrTens <= mainHrTens;
    end
    
    else if(mode == 2'b01)
    begin
        setMinOnes <= mainMinOnes;
        setMinOnes <= mainMinOnes;
        setMinTens <= mainMinTens;
        setHrOnes <= mainHrOnes;
        setHrTens <= mainHrTens;
    end
end
/////////////////////////////
// END OF SET TIME SECTION //
/////////////////////////////

///////////////////////////////////////////////////
// START OF MODE-SELECT and DIGIT-SELECT SECTION //
///////////////////////////////////////////////////

reg [1:0] mode = 0;  //00 = Display Regular Time Mode
                     //01 = Display Set-Time Mode
                     //10 = Display Alarm-Set Mode
always @(posedge clk)
begin
    mode[0] <= switch[0];
    mode[1] <= switch[1];
end

reg [7:0] digitSelect = 0; //1 = SecOnes
                           //2 = SecTens
                           //3 = MinOnes
                           //4 = MinTens
                           //5 = HrOnes
                           //6 = HrTens
                       
/////////////////////////////////////////////////
// END OF MODE-SELECT and DIGIT-SELECT SECTION //
/////////////////////////////////////////////////

///////////////////////////////////
// START OF BLINK-SELECT SECTION //
///////////////////////////////////
reg blinkSecOnes = 0;
reg blinkSecTens = 0;
reg blinkMinOnes = 0;
reg blinkMinTens = 0;
reg blinkHrOnes = 0;
reg blinkHrTens = 0;

reg blinkSelectSO = 0;
reg blinkSelectST = 0;
reg blinkSelectMO = 0;
reg blinkSelectMT = 0;
reg blinkSelectHO = 0;
reg blinkSelectHT = 0;

reg [25:0] blinkCount = 0; 
reg blinkToggle = 0;

always@(posedge clk)
begin
    if(blinkCount >= 49999999) 
    begin
        blinkCount <= 0;
        blinkToggle <= ~(blinkToggle);
    end
    else blinkCount <= blinkCount + 1;
end

always@(posedge clk)
begin
    if(mode == 2'b00)
    begin
        blinkSecOnes <= 0;
        blinkSecTens <= 0;
        blinkMinOnes <= 0;
        blinkMinTens <= 0;
        blinkHrOnes <= 0;
        blinkHrTens <= 0;
    end
    
    else if(mode == 2'b01 || mode == 2'b10)
    begin
        blinkSecOnes <= blinkSelectSO;
        blinkSecTens <= blinkSelectST;
        blinkMinOnes <= blinkSelectMO;
        blinkMinTens <= blinkSelectMT;
        blinkHrOnes <= blinkSelectHO;
        blinkHrTens <= blinkSelectHT;
    end
    
    else
    begin
        blinkSecOnes <= 0;
        blinkSecTens <= 0;
        blinkMinOnes <= 0;
        blinkMinTens <= 0;
        blinkHrOnes <= 0;
        blinkHrTens <= 0;
    end
end

always@(posedge clk)
begin
    if(digitSelect == 0)
    begin
        blinkSelectSO <= blinkToggle;
        blinkSelectST <= 0;
        blinkSelectMO <= 0;
        blinkSelectMT <= 0;
        blinkSelectHO <= 0;
        blinkSelectHT <= 0;
    end
    
    else if(digitSelect == 1)
    begin
        blinkSelectSO <= 0;
        blinkSelectST <= blinkToggle;
        blinkSelectMO <= 0;
        blinkSelectMT <= 0;
        blinkSelectHO <= 0;   
        blinkSelectHT <= 0; 
    end
    
    else if(digitSelect == 2)
    begin
        blinkSelectSO <= 0;
        blinkSelectST <= 0;
        blinkSelectMO <= 0;
        blinkSelectMT <= blinkToggle;
        blinkSelectHO <= 0;   
        blinkSelectHT <= 0; 
    end
    
    else if(digitSelect == 3)
    begin
        blinkSelectSO <= 0;
        blinkSelectST <= 0;
        blinkSelectMO <= blinkToggle;
        blinkSelectMT <= 0;
        blinkSelectHO <= 0;   
        blinkSelectHT <= 0; 
    end
    
    else if(digitSelect == 4)
    begin
        blinkSelectSO <= 0;
        blinkSelectST <= 0;
        blinkSelectMO <= 0;
        blinkSelectMT <= 0;
        blinkSelectHO <= blinkToggle;   
        blinkSelectHT <= 0; 
    end
    
    else if(digitSelect == 5)
    begin
        blinkSelectSO <= 0;
        blinkSelectST <= 0;
        blinkSelectMO <= 0;
        blinkSelectMT <= 0;
        blinkSelectHO <= 0;   
        blinkSelectHT <= blinkToggle; 
    end
    
    else
    begin
        blinkSelectSO <= 0;
        blinkSelectST <= 0;
        blinkSelectMO <= 0;
        blinkSelectMT <= 0;
        blinkSelectHO <= 0;
        blinkSelectHT <= 0;
    end
end
/////////////////////////////////
// END OF BLINK-SELECT SECTION //
/////////////////////////////////

////////////////////////////////
// START OF INTERRUPT SECTION //
////////////////////////////////
reg [7:0] interruptReg = 8'b00000000; // bit mapping: h g f e d c b a, alphabetically prioritized
                                      // a = digit increase
                                      // b = digit decrease
                                      // c = digit left
                                      // d = digit right
                                      // e = disable alarm
                                      // f = nothingyet
                                      // g = nothingyet
                                      // h = nothingyet

assign interrupt = (up || down || left || right);

always @(posedge clk)
begin
    if(write_strobe)
    begin
        if(port_id == 8'h03) digitSelect [7:0] <= out_port;
        else if (port_id == 8'h04) 
        begin
            interruptReg <= out_port;
        end
    end
    
    else
    begin
        if(mode == 2'b01 || mode == 2'b10)
        begin
            if(left == 1) interruptReg <= interruptReg | 8'b00000100;
            else if(right == 1) interruptReg <= interruptReg | 8'b00001000;
        end
    end
end

always @*
begin
    case(port_id)
        8'h00: in_port <= interruptReg[7:0];
        8'h01: in_port <= {0,0,0,0,0,0,mode[1],mode[0]};
        8'h02: in_port <= {0,0,0,0,0,0,digitSelect[1],digitSelect[0]};
        default: in_port <= 8'h00;
    endcase
end
////////////////////////////
//END OF INTERRUPT SECTION//
////////////////////////////
endmodule
