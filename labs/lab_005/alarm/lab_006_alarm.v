module lab_006_alarm (
  input alarm_set, alarm_stay,
  input [1:0] doors,
  input [2:0] windows,
  output reg secure, alarm
);

  always @* begin
    if( alarm_set == 0 ) begin
	secure <= 0;
	alarm <= 0;
    end
    else begin
	if( alarm_stay && doors || windows ) begin
	    secure <= 0;
	end
	else begin
	    secure <= 1;
	end
    end
  end

endmodule
