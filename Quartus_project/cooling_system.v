module cooling_system(
	input		wire	[11:0]	min_temp,
	input		wire	[11:0]	max_temp,
	input 	wire  [11:0]	cur_temp,
	
	output	reg				fan_control
	);
parameter extra_res= 100000;
parameter voltage = 33;
parameter mult_voltage = 10;

wire [11:0]	at1;
wire [11:0]	at2;

temp_adctemp tat1(.clk(clk),
						.temp(min_temp),
						.res(extra_res),
						.voltage(voltage), //Напряжение, умноженное на k
						.k(mult_voltage),
						.adc_temp(at1));

temp_adctemp tat2(.clk(clk),
						.temp(max_temp),
						.res(extra_res),
						.voltage(voltage), //Напряжение, умноженное на k
						.k(mult_voltage),
						.adc_temp(at2));
						


wire start_cooling = cur_temp < at2;
wire stop_cooling = cur_temp > at1;


always @(posedge start_cooling or posedge stop_cooling)
begin
	if (start_cooling)
		fan_control = 1'b1;
	else
		fan_control = 1'b0;
end




endmodule
