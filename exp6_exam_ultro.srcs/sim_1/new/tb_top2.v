`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/01 14:13:41
// Design Name: 
// Module Name: tb_top2
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


module tb_top2;
    parameter   CLK100_PRID = 10;
    parameter   BaudRate = 9600;
    parameter   Bau16 = 1000_000_000 / BaudRate;    
    parameter   Reset_time = 100_000;

reg clk_100m;

initial
    begin
        clk_100m = 1'b0;
        #(CLK100_PRID/2)
        forever
            #(CLK100_PRID/2) clk_100m = ~clk_100m;
    end
    
reg rst;
initial
    begin
        rst = 1'b0;
        #500 rst = 1'b1;
        #(Reset_time)    rst = 1'b0;
    end 
    
reg clk_uart;
initial
    begin
       clk_uart = 1'b0;
       #500 clk_uart = 1'b0;
       #(Reset_time) clk_uart = 1'b0;
       #(Bau16)
       forever
            #(Bau16) clk_uart = ~clk_uart;
end

reg uart_in;
integer j, k;
initial
    begin
        uart_in = 1'b1;
        #600   uart_in = 1'b1;
        #(Reset_time)   uart_in = 1'b1;       
        #(Bau16 * 10)   uart_in = 1'b1;  
        for(k=0; k<20; k=k+1)
        begin
           //random num 1
			  uart_in = 1'b0;
            for(j=0; j<8; j=j+1)
                #(Bau16)    uart_in = ({$random}%2 - 1);
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1;
            
           //39
            uart_in = 1'b0;
                
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
                
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1;
           
           //30    
            uart_in = 1'b0;
               
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
                
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1;
         
         //31       
            uart_in = 1'b0;
               
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
              
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1;       
         
		 //31       
            uart_in = 1'b0;
                       
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
                       
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1; 
    
           //6D    
            uart_in = 1'b0;
                
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
                
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1;  
    
           //69    
            uart_in = 1'b0;
                
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
                
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1; 
    
           //6e    
            uart_in = 1'b0;
                
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
                
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1;
                
           //67    
            uart_in = 1'b0;
                     
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
                     
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1; 
           
		   //79                 
            uart_in = 1'b0;
                     
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
                     
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1; 
    
         // 75
            uart_in = 1'b0;
    
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b1;
            #(Bau16)    uart_in = 1'b0;
    
            #(Bau16)    uart_in = 1'b1;
            #(Bau16 * ({$random}%10))    uart_in = 1'b1; 
        
		end
       $finish;
   end
   
wire uart_out;
wire [3:0] an_rt;
wire [3:0] an_cnt;
wire [7:0] sseg;
wire [7:0] sseg_cnt;

top tb2_top(
        .sysclk(clk_100m),
        .rst_n(rst),
        .uart_in(uart_in),
        .uart_out(uart_out),
        .an_rt(an_rt),
        .an_cnt(an_cnt),
        .sseg(sseg),
        .sseg_cnt(sseg_cnt)
);
endmodule
