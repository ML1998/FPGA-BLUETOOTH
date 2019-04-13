`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/24 19:10:10
// Design Name: 
// Module Name: tb_top
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


module tb_top;

    reg clk;
    reg rst;
    reg uart_in;
    wire ack;
    wire [7:0] data;
    parameter period = 10;
    
initial
    begin
        #30 clk = 0;
    forever
        #(period/2) clk = ~clk;
    end
    
initial
    begin
        #60 rst = 0;
        #60 rst = 1;        
        #60 rst = 0;
        #10000 rst = 1;        
        #60 rst = 1;        
        #60 rst = 0;        
        #80 rst = 1;        
        #80 rst = 0;       
    end 
    
initial
        begin
            #30  uart_in = 1;
            #578 uart_in = 0;   
            #(period*16)  uart_in = 1;  
            #(period*16)  uart_in = 0; 
            #(period*16)  uart_in = 0;  
            #(period*16)  uart_in = 1;      
            #(period*16)  uart_in = 1;  
            #(period*16)  uart_in = 0; 
            #(period*16)  uart_in = 0;  
            #(period*16)  uart_in = 1; 
            #(period*16)  uart_in = 1; 
        end 

wire uart_out;
wire [1:0] an_rx;
wire [1:0] an_tx;
wire [7:0] sseg;

top tt_top(
    .sysclk(clk),
    .rst_n(rst),
    .uart_in(uart_in),
    .uart_out(uart_out),
    .an_rx(an_rx),
    .an_tx(an_tx),
    .sseg(sseg)
);
    
endmodule
