`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/01 10:50:05
// Design Name: 
// Module Name: controller
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


module controller(
    input [7:0] rx_data,    //并行数据
    input baudclk, 
    input rx_status,        //receiver 高电平指示脉冲表示有data进入
    input tx_status,        //sender 若为高电平则处于空闲状态
    input rst,
    output reg tx_en,
    output [7:0] data_out
    );
    
reg edgecatch1;
reg edgecatch2;
wire pos;
assign pos = (~edgecatch2) && edgecatch1;

always@(posedge baudclk or posedge rst)  // 检查rx_status沿
begin
    if(rst)
        begin
            edgecatch1 <= 1'b0;
            edgecatch2 <= 1'b0;
        end
    else 
        begin
            edgecatch1 <= rx_status;
            edgecatch2 <= edgecatch1;
        end
end


wire fifo_full;             
wire fifo_empty;            
wire [7:0] data_fifo;
reg wr_en;
always@(posedge baudclk)
begin
    if(~fifo_full)
        wr_en <= rx_status;
    else
        wr_en <= 1'b0;
end

reg rd_en;
always@(posedge baudclk)
begin
    if(rd_en)
        rd_en <= 1'b0;
    else if(tx_status && (~fifo_empty))
        rd_en <= 1'b1;
    else
        rd_en <= 1'b0;
end

fifo_generator_0 fifo (
  .clk(baudclk),         // input wire clk
  .srst(rst),            // input wire srst
  .din(rx_data),         // input wire [7 : 0] din
  .wr_en(wr_en),         // input wire wr_en
  .rd_en(rd_en),         // input wire rd_en  
  .dout(data_fifo),        // output wire [7 : 0] dout
  .full(fifo_full),      // output wire full
  .empty(fifo_empty)     // output wire empty  
);

always@(posedge baudclk or posedge rst)
begin
    if(rst)
        tx_en <= 1'b0;
    else if(rd_en)
        tx_en <= 1'b1;
    else
        tx_en <= 1'b0;        
    
end

assign data_out = data_fifo;

endmodule
