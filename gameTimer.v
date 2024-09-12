module display
#(parameter CLOCK_FREQUENCY=500000000)(ClockIn, nReset, hex0, hex1, hex2, hex3, hex4, hex5);

input wire ClockIn;
input wire nReset;
reg [23:0] timeElapsed;
output reg [6:0] hex0;
output reg [6:0] hex1;
output reg [6:0] hex2;
output reg [6:0] hex3;
output reg [6:0] hex4;
output reg [6:0] hex5;

wire Enable;

RateDivider #(CLOCK_FREQUENCY) rate(ClockIn, nReset, Enable);

//when !reset and posedge Start, accept Letter.
always @ (posedge ClockIn)
//if Start and posedge of clock, I want to accept letter.
begin 
 if(!nReset)
 begin
	timeElapsed<=24'b0;
	hex0=7'b0000001;
	hex1=7'b0000001;
	hex2=7'b0000001;
	hex3=7'b0000001;
	hex4=7'b0000001;
	hex5=7'b0000001;
	end

else if(Enable)
begin
timeElapsed=timeElapsed+1'b1;

	case(timeElapsed[3:0])
		4'h0: hex0= 7'b1000000;
		4'h1: hex0= 7'b1111001;
		4'h2: hex0= 7'b0100100;
		4'h3: hex0= 7'b0110000;
		4'h4: hex0= 7'b0011001;
		4'h5: hex0= 7'b0010010;
		4'h6: hex0= 7'b0000010;
		4'h7: hex0= 7'b1111000;
		4'h8: hex0= 7'b0000000;
		4'h9: hex0= 7'b0010000;
		4'hA: hex0= 7'b0001000;
		4'hB: hex0= 7'b0000011;
		4'hC: hex0= 7'b1000110;
		4'hD: hex0= 7'b0100001;
		4'hE: hex0= 7'b0000110;
		4'hF: hex0= 7'b0001110;
endcase
	
case(timeElapsed[7:4])
		4'h0: hex1= 7'b1000000;
		4'h1: hex1= 7'b1111001;
		4'h2: hex1= 7'b0100100;
		4'h3: hex1= 7'b0110000;
		4'h4: hex1= 7'b0011001;
		4'h5: hex1= 7'b0010010;
		4'h6: hex1= 7'b0000010;
		4'h7: hex1= 7'b1111000;
		4'h8: hex1= 7'b0000000;
		4'h9: hex1= 7'b0010000;
		4'hA: hex1= 7'b0001000;
		4'hB: hex1= 7'b0000011;
		4'hC: hex1= 7'b1000110;
		4'hD: hex1= 7'b0100001;
		4'hE: hex1= 7'b0000110;
		4'hF: hex1= 7'b0001110;
endcase

case(timeElapsed[11:8])
		4'h0: hex2= 7'b1000000;
		4'h1: hex2= 7'b1111001;
		4'h2: hex2= 7'b0100100;
		4'h3: hex2= 7'b0110000;
		4'h4: hex2= 7'b0011001;
		4'h5: hex2= 7'b0010010;
		4'h6: hex2= 7'b0000010;
		4'h7: hex2= 7'b1111000;
		4'h8: hex2= 7'b0000000;
		4'h9: hex2= 7'b0010000;
		4'hA: hex2= 7'b0001000;
		4'hB: hex2= 7'b0000011;
		4'hC: hex2= 7'b1000110;
		4'hD: hex2= 7'b0100001;
		4'hE: hex2= 7'b0000110;
		4'hF: hex2= 7'b0001110;
endcase

case(timeElapsed[15:12])
		4'h0: hex3= 7'b1000000;
		4'h1: hex3= 7'b1111001;
		4'h2: hex3= 7'b0100100;
		4'h3: hex3= 7'b0110000;
		4'h4: hex3= 7'b0011001;
		4'h5: hex3= 7'b0010010;
		4'h6: hex3= 7'b0000010;
		4'h7: hex3= 7'b1111000;
		4'h8: hex3= 7'b0000000;
		4'h9: hex3= 7'b0010000;
		4'hA: hex3= 7'b0001000;
		4'hB: hex3= 7'b0000011;
		4'hC: hex3= 7'b1000110;
		4'hD: hex3= 7'b0100001;
		4'hE: hex3= 7'b0000110;
		4'hF: hex3= 7'b0001110;
endcase

case(timeElapsed[19:16])
		4'h0: hex4= 7'b1000000;
		4'h1: hex4= 7'b1111001;
		4'h2: hex4= 7'b0100100;
		4'h3: hex4= 7'b0110000;
		4'h4: hex4= 7'b0011001;
		4'h5: hex4= 7'b0010010;
		4'h6: hex4= 7'b0000010;
		4'h7: hex4= 7'b1111000;
		4'h8: hex4= 7'b0000000;
		4'h9: hex4= 7'b0010000;
		4'hA: hex4= 7'b0001000;
		4'hB: hex4= 7'b0000011;
		4'hC: hex4= 7'b1000110;
		4'hD: hex4= 7'b0100001;
		4'hE: hex4= 7'b0000110;
		4'hF: hex4= 7'b0001110;
endcase

case(timeElapsed[22:19])
		4'h0: hex5= 7'b1000000;
		4'h1: hex5= 7'b1111001;
		4'h2: hex5= 7'b0100100;
		4'h3: hex5= 7'b0110000;
		4'h4: hex5= 7'b0011001;
		4'h5: hex5= 7'b0010010;
		4'h6: hex5= 7'b0000010;
		4'h7: hex5= 7'b1111000;
		4'h8: hex5= 7'b0000000;
		4'h9: hex5= 7'b0010000;
		4'hA: hex5= 7'b0001000;
		4'hB: hex5= 7'b0000011;
		4'hC: hex5= 7'b1000110;
		4'hD: hex5= 7'b0100001;
		4'hE: hex5= 7'b0000110;
		4'hF: hex5= 7'b0001110;
endcase

end

	
end
endmodule


module RateDivider
#(parameter CLOCK_FREQUENCY) (
input ClockIn,
input nReset,
output Enable
);
reg [26:0] actual;

always@ (posedge ClockIn) 
begin

begin
// set up our counter: actual
if(actual==0 || !nReset) 

	actual<=CLOCK_FREQUENCY/4; //want 1Hz, once in a second.

else
actual=actual-1; //countdown
end
end

assign Enable= ( actual == 'b0)? 1'b1: 1'b0;

endmodule