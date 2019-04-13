`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/24 15:35:48
// Design Name: 
// Module Name: tb_receiver
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


module tb_receiver;
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
        #500 rst = 1;        
        #60 rst = 0;         
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
        
receiver tb_receiver(
    .baudclk(clk),
    .rst(rst),
    .rxd(uart_in),
    .RX_data(data),
    .RX_status(ack)
);

endmodule
