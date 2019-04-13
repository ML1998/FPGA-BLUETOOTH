`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/24 11:24:47
// Design Name: 
// Module Name: receiver
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


module receiver(
    input baudclk,
    input rst,
    input rxd,
    output reg [7:0] RX_data,
    output reg RX_status
);

reg negcatch1;
reg negcatch2;

always@(posedge baudclk or posedge rst)  // 检查下降沿
begin
    if(rst)
    begin
        negcatch1 <= 1'b1;
        negcatch2 <= 1'b1;
    end
    else 
    begin
        negcatch1 <= rxd;
        negcatch2 <= negcatch1;
    end
end

reg cnt_en;
reg [7:0] cnt;

always@(posedge baudclk or posedge rst)    
begin
    if(rst)
        cnt_en <= 1'b0;
    else if( (~negcatch1)&& negcatch2)  //捕获到下降沿，计数使能
        cnt_en <= 1'b1;
    else if((cnt == 8'd7) && (rxd == 1)) //假的start下降沿
        cnt_en <= 1'b0;
    else if(cnt == 8'd152)   //计满置零
        cnt_en <= 1'b0;
    else
        cnt_en <= cnt_en;
end  


always@(posedge baudclk or posedge rst)        //对采样时钟进行计数，cnt的赋值
begin
    if(rst)
        cnt <= 8'b0;
    else if((cnt == 8'd7) && (rxd == 1)) //假的start下降沿
        cnt <= 8'b0;
    else if((cnt == 8'd152) && (rxd == 0)) //stop位不等于1
        cnt <= 8'b0;
    else if(cnt_en)
        cnt <= cnt + 8'b1;
    else
        cnt <= 8'b0;
end  

reg [7:0] data = 8'b0;  //八个数据位的赋值

always@(posedge baudclk or posedge rst)
begin
    if(rst)
        data <= 8'd0;
    else if(cnt_en)
        case(cnt)
        8'd24:
            data[7:0] <= {rxd, data[7:1]};
        8'd40:
            data[7:0] <= {rxd, data[7:1]};
        8'd56:
            data[7:0] <= {rxd, data[7:1]}; 
        8'd72:
            data[7:0] <= {rxd, data[7:1]};
        8'd88:
            data[7:0] <= {rxd, data[7:1]};
        8'd104:
            data[7:0] <= {rxd, data[7:1]};
        8'd120:
            data[7:0] <= {rxd, data[7:1]};  
        8'd136:
            data[7:0] <= {rxd, data[7:1]};
        default:
            data[7:0] <= data[7:0];
        endcase
end
                             
always@(posedge baudclk or posedge rst) //stop位的赋值
begin
    if(rst) begin
        RX_status <= 1'b0;   
        RX_data   <= 8'b0;
    end
    else if((cnt == 8'd152) && (rxd)) begin
        RX_data   <= data;
        RX_status <= 1'b1;
    end
    else begin
        RX_status <= 1'b0;   
        RX_data   <= RX_data;    
    end            
end

endmodule
