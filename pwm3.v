module pwm3 ( 
//input 
input                    sys_clk        ,

//input        [3:0]       key          ,
output reg                 pwm            //把这个拓展成为三路信号
);

//output ports

//reg define 

reg 	 [25:0]     num =0         ;	 //num即为脉冲翻转次数，设定脉冲数为奇数即可保证结束后脉冲保持低电平	
reg    [25:0]     cnt1            ;

parameter nfreq =  1500                  ;
//*************************************************
always @(posedge sys_clk ) begin 
	if ( cnt1 == 25000)             //  nfreq=25000000/cnt
       cnt1 <= 26'b0;
	else
       cnt1 <= cnt1 + 26'b1;
end

always @(posedge sys_clk ) begin 
   if(cnt1 == (25000000/nfreq))begin
		if(num[15:0] <= 5000)begin
				pwm <= ~pwm    ;
				num  <= num+15'd1;
			end
		end
	
	if(num == 5000)begin	 // 脉冲发送完毕，拉低脉冲输出引脚
			pwm <= 0     ;
	end
	end
		




endmodule
//end of RTL code                       