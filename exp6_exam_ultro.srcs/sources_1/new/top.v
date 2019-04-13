`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/23 22:25:11
// Design Name: 
// Module Name: top
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


module top(
    input sysclk,						//FPGA 100MHz
    input rst_n,							//reset button
    input uart_in,						//串口输入 数据
    input [4:0] sw,
    output uart_out,						//串口输出 计数结果0~9999
    output [3:0] an_cnt,				//数码管片选
    output [7:0] sseg_cnt,				//数码管段选
    output [4:0] current_state,			//LED灯显示状态机状态
    output [4:0] bt_ctrl
    );
wire rst_n0;
     
wire rst; 

// reset button 防抖//////////////////////////////////////////////////////////////
db_fsm inst_db_fsm(
    .clk(sysclk),						//input
    .sw(rst_n),							//input
    .db(rst)								//ouput 防抖输出
);

//分频16 x baudclk////////////////////////////////////////////////////////////////
wire baudclk;
baud_gnr inst_baud_gnr(
    .sysclk(sysclk),						//input FPGA 100MHz
    .rst(rst),							//input 
    .baudclk(baudclk)					//output 16 x baudclk
);

//receiver 接收机/////////////////////////////////////////////////////////////////
wire [7:0] data_in;
wire rx_status;

receiver inst_receiver(
    .baudclk(baudclk),					//input 
    .rst(rst),							//input
    .rxd(uart_in),						//input
    .RX_data(data_in),					//output [7:0] 并行数据
    .RX_status(rx_status)				//output pulse status
);    


wire tx_status;
wire counter_en;
wire [15:0] counter_num;

// 检测有效数据 /////////////////////////////////////////////////////////////////
detect inst_detect(
    .clock(baudclk),						//input 				
    .reset(rst),							//input
    .rx_status(rx_status),				//input pulse status
    .rx_data(data_in),					//input [7:0] data
    .counter_en(counter_en),			//output pulse
    .counter_num(counter_num),			//output [15:0] 0~9999
    .current_state(current_state)		//output state 0~10
);

// 数码管显示有效数据计数结果 ///////////////////////////////////////////////////
sseg inst_sseg_cnt(
    .clk(sysclk),						//input
    .data_16(counter_num),				//input [15:0] 0~9999
    .rst(rst),							//input
    .an_rt(an_cnt),						//output [3:0] 片选
    .sseg(sseg_cnt)						//output [7:0] 段选
);

wire [7:0] send_data;
wire send_en;
wire [7:0] send_out;
wire tx_en;

// arranger 将[15:0]数据分成两组发送给controller ///////////////////////////////////////////////
arranger inst_arranger(
    .clk(baudclk),						//input 
    .din_en(counter_en),				//input
    .rst(rst),							//input
    .din_16(counter_num),				//input [15:0]
    .dout_8(send_data),					//output [7:0] 
    .dout_en(send_en)					//output pulse 
);

// 含有FIFO功能的controller，接受arranger的数据，并负责与sender的接口工作//////////////////////
controller sender_controller(
    .rx_data(send_data),				
    .baudclk(baudclk),
    .rx_status(send_en),
    .tx_status(tx_status),				
    .rst(rst),
    .tx_en(tx_en),						//output sender 使能
    .data_out(send_out)					//output sender 与使能同步发送的数据
);

// sender ////////////////////////////////////////////////////////////////////////////////////
sender inst_sender(
    .baudclk(baudclk),
    .rst(rst),
    .en(tx_en),
    .data(send_out),
    .status(tx_status),					//output free(1) or busy(0)
    .txd(uart_out)						//output 串行输出
);

assign bt_ctrl[0] = sw[0];
assign bt_ctrl[1] = sw[1];
assign bt_ctrl[2] = sw[2];
assign bt_ctrl[3] = sw[3];
assign bt_ctrl[4] = sw[4];
endmodule
