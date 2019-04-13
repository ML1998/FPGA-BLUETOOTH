`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/23 23:00:27
// Design Name: 
// Module Name: bclk_gen_tb
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


module bclk_gen_tb;

   reg clk;
   wire clk_t;
   parameter PERIOD = 2;
  reg rst;
   
   initial begin
       clk = 1'b0;
       #(PERIOD/2);
       forever
           #(PERIOD/2) clk = ~clk;
   end
   
   initial
       begin
           #60 rst = 0;
           #60 rst = 1;        
           #60 rst = 0;
           #500 rst = 1;        
           #60 rst = 0;         
       end 
       
   assign clk_t = clk;


   baud_gnr tb_baud_gnr(
       .sysclk(clk),
       .rst(rst)

);
endmodule