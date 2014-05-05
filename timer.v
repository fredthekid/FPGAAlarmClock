module timer(
        input wire clk,
        
        );
reg [26:0] secondDivideCount = 0; //after 99999999 100MHz counts, 1 second has passed

reg incrementSecond = 0; //if 1, ones place for second needs to be incremented

//This block increments secondDivideCount up to 99999999 then resets to zero. when secondDivideCount == 999999999, an interrupt occurs
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
	if(secOnesDig == 9 && incrementSecond) secOnesDig <= 0; //reset counter at 9
	else if(secOnesDig != 9 && incrementSecond)  secOnesDig <= secOnesDig +1;
	else secOnesDig <= secOnesDig;
end

//For incrementing Second(Tens place)
always @(posedge clk)
begin
	if(secTensDig == 5 && secOnesDig == 9 && incrementSecond) secTensDig <= 0; //reset counter at 6
	else if(secTensDig != 5 && secOnesDig == 9 && incrementSecond) secTensDig <= secTensDig +1;
	else secTensDig <= secTensDig;
end

//For incrementing Minute(Ones place)
always @(posedge clk)
begin
	if(minOnesDig == 9 && secTensDig == 5 && secOnesDig == 9 && incrementSecond) minOnesDig <= 0; //reset counter at 9
	else if(minOnesDig != 9 && secTensDig == 5 && secOnesDig == 9 && incrementSecond) minOnesDig <= minOnesDig +1;
	else minOnesDig <= minOnesDig;
end

//For incrementing Minute(Tens place)
always @(posedge clk)
begin
	if(minTensDig == 5 && minOnesDig == 9 && secTensDig == 5 && secOnesDig == 9 && incrementSecond) minTensDig <= 0; //reset counter at 9
	else if(minTensDig != 5 && minOnesDig == 9 && secTensDig == 5 && secOnesDig == 9 && incrementSecond) minTensDig <= minTensDig +1;
	else minTensDig <= minTensDig;
end

//For incrementing Hour(Ones place)
always @(posedge clk)
begin
	if((hrOnesDig == 9 || (hrTensDig == 2 && hrOnesDig == 3)) && (minTensDig == 5 && minOnesDig == 9 && secTensDig == 5 && secOnesDig == 9 && incrementSecond)) hrOnesDig <= 0; //reset counter at 9
	else if(hrOnesDig != 9 && minTensDig == 5 && minOnesDig == 9 && secTensDig == 5 && secOnesDig == 9 && incrementSecond) hrOnesDig <= hrOnesDig +1;
	else hrOnesDig <= hrOnesDig;
end

//For incrementing Hour(Tens place)
always @(posedge clk)
begin
	if(hrTensDig == 2 && hrOnesDig == 3 && minTensDig == 5 && minOnesDig == 9 && secTensDig == 5 && secOnesDig == 9 && incrementSecond) hrTensDig <= 0; //reset counter at 9
	else if(hrOnesDig == 9 && minTensDig == 5 && minOnesDig == 9 && secTensDig == 5 && secOnesDig == 9 && incrementSecond && hrOnesDig == 9) hrTensDig <= hrTensDig +1;
	else hrTensDig <= hrTensDig;
end

endmodule
