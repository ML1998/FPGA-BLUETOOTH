`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 20:08:42
// Design Name: 
// Module Name: arranger
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


module arranger(
    input clk,
    input rst,
    input [15:0] din_16,
    input din_en,
    output reg [7:0] dout_8,
    output reg dout_en
    );
reg [8:0] cnt; 
reg cnt_en;   
always@(posedge clk or posedge rst)
begin
    if(rst)
        cnt <= 9'b0;
    else if(cnt_en)
        cnt <= cnt + 9'b1;
    else
        cnt <= 9'b0;
end

always@(posedge clk or posedge rst)
begin
    if(rst)
        cnt_en <= 1'b0;
    else if(din_en)
        cnt_en <= 1'b1;
    else if(cnt == 9'b1_1111_1111)
        cnt_en <= 1'b0; 
    else 
        cnt_en <= cnt_en;
end

always@(posedge clk or posedge rst)
begin
    if(rst) begin
        dout_en <= 1'b0;
        dout_8  <= 8'b0;
    end
    else if(cnt == 9'b0_0000_0001) begin
        dout_en <= 1'b1;
        dout_8  <= din_16[15:8];
    end
    else if(cnt == 9'b1_1111_1111) begin
        dout_en <= 1'b1; 
        dout_8  <= din_16[7:0];
    end
    else begin
        dout_en <= 1'b0;
        dout_8  <= dout_8;
    end
end
endmodule
