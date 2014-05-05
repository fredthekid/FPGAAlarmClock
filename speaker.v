module speaker(
        input wire clk,         // main clk
        output wire speaker,    // used for outputting speaker
        output wire vcc         // powering the output
        );
        
assign vcc = 1'b1;        //power

reg [4:0] cmpSecOnes = 0; //for comparing ones digit of second
reg [2:0] cmpSecTens = 1; //for comparing tens digit of second

reg [16:0] alarmCounter = 0;
reg [16:0] alarmCompare = 67568;
reg alarmToggle = 0;
reg alarmTrig = 0;

assign speaker = alarmToggle;


//For outputting alarm
always@(posedge clk)
begin
	if((cmpSecOnes != secOnesDig) || (cmpSecTens != secTensDig))
	begin
	   alarmToggle <= 0;
	end
	
	else if((cmpSecOnes == secOnesDig) && (cmpSecTens == secTensDig))
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
