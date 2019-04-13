`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/24 14:43:41
// Design Name: 
// Module Name: sseg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sseg 
   ( input clk,
     input [15:0]data_16,
     input rst,
     output reg [3:0] an_rt,
     output reg [7:0] sseg         
     );


reg [3:0] dec_in;
reg dp;
wire [3:0] dp_in;
assign dp_in = 0;

localparam N = 18; 
reg [N-1:0] regN = 0;


always @(posedge clk) 
begin
    if(rst)
        regN <= 0;
    else
        regN <= regN + 1;
end

always @* 
begin
    case (regN[N-1:N-2])
		  2'b00:
			begin
				an_rt = 4'b0001;
				dec_in = data_16[3:0];
				dp = dp_in[0];
			end
		 2'b01:
			begin
				an_rt = 4'b0010;
				dec_in = data_16[7:4];
				dp = dp_in[1];
			end
		 2'b10:
			begin
				an_rt = 4'b0100;
				dec_in = data_16[11:8];
				dp = dp_in[2];
			end
		 default:
			begin
				an_rt = 4'b1000;
				dec_in = data_16[15:12];
				dp = dp_in[3];
			end
    endcase
end
	    
always @*
begin
	 case (dec_in)
		4'h0: sseg [6:0] = 7'b1111110;
        4'h1: sseg [6:0] = 7'b0110000;
        4'h2: sseg [6:0] = 7'b1101101;
        4'h3: sseg [6:0] = 7'b1111001;
        4'h4: sseg [6:0] = 7'b0110011;
        4'h5: sseg [6:0] = 7'b1011011;
        4'h6: sseg [6:0] = 7'b1011111;
        4'h7: sseg [6:0] = 7'b1110000;
        4'h8: sseg [6:0] = 7'b1111111;
        4'h9: sseg [6:0] = 7'b1111011;
        4'ha: sseg [6:0] = 7'b1110111;
        4'hb: sseg [6:0] = 7'b0011111;
        4'hc: sseg [6:0] = 7'b1001110;
        4'hd: sseg [6:0] = 7'b0111101;
        4'he: sseg [6:0] = 7'b1001111;
        default: sseg[6:0] = 7'b1000111;  //4'hf
    endcase
	sseg[7] = dp;
end
endmodule
