//name: ram_test
//By: Harlan Ye
//2013.6.24

module ram_test(
				input clk, 
				input nreset,
				//input
				input info_en, 
				input para_en,
//				inclk,
//				indata_voltagelevel,
//				indata_duration,
//				indata_voltagevalue, 
				
//				indata_duration_part1,
//				indata_duration_part2,
				
//				indata_voltagevalue_part1,
//				indata_voltagevalue_part2,
				input indata_GPBCON3,
				input indata_GPBCON4,
				input indata_GPBCON5,
				input indata_GPBCON6,
				input indata_GPBCON7,
				input indata_GPBCON8,
				input indata_GPBCON9,
				input indata_GPBCON10,
				
				input indata_GPCCON0,
				input indata_GPCCON5,
				input indata_GPCCON6,
				input indata_GPCCON7,
				
				input indata_GPECON1,
				input indata_GPECON7,
				input indata_GPECON8,
				input indata_GPECON9,
				input indata_GPECON10,
				
				input indata_GPGCON1,
				input indata_GPGCON3,
				input indata_GPGCON6,
				input indata_GPGCON8,
				input indata_GPGCON11,
				
				input indata_GPHCON5_clk,     // input clk from ARM				
				input indata_GPJCON0,
				input indata_GPJCON1,
				input indata_GPJCON2,
				input indata_GPJCON3,
				input indata_GPJCON4,
				input indata_GPJCON7,
				input indata_GPJCON8,
				
				//output
				output voltage_out,
				output voltage_out_part1,
				output voltage_out_part2
				);
//define I/O port
//input			clk, nreset;
//input 			info_en, para_en;
//input			inclk;
//input 			indata_voltagelevel;

//input	[9:0]	indata_duration;
//input	[1:0]	indata_voltagevalue;
//input	[9:0]	indata_duration_part1;
//input	[9:0]	indata_duration_part2;
//input	[1:0]	indata_voltagevalue_part1;
//input	[1:0]	indata_voltagevalue_part2;

//define register and wire
wire clk_200M;
wire clk_200M_n;
wire			inclk;
wire 	[1:0] 	indata_time_unit;
wire 	[9:0]	indata_accuracy;
wire 	[9:0]   indata_circletime;
wire 			indata_voltagelevel;
wire 	[1:0]	indata_voltagevalue;
wire 	[1:0]   indata_voltagevalue_part1;
wire 	[1:0]   indata_voltagevalue_part2;
wire 	[9:0]	indata_duration;
wire 	[9:0]	indata_duration_part1;
wire 	[9:0]	indata_duration_part2;

wire	[1:0]	enable;
wire	[1:0]	state/*synthesis noprune*/;
wire			read_posedge_initial;
wire			negedge_clkin/*synthesis noprune*/;
wire			clk_nege;
wire	[9:0]	q_duration;
wire	[1:0]	q_voltage_value;
wire	[9:0]	q_duration_part1;
wire	[9:0]	q_duration_part2;
wire	[1:0]	q_voltage_value_part1;
wire	[1:0]	q_voltage_value_part2;
wire			q_duration_pose;
reg		[3:0]	read_en_2level_pipe;
reg		[4:0]	read_en_3level_pipe;
//wire			areset_sig;
//wire			locked_sig;
//reg				areset_sig_reg;
reg		[1:0]	state_reg;
reg		[5:0]	state_pipe;
reg				voltage_level_reg;
reg		[9:0]	q_duration_reg;

reg		[9:0]	data_ram_duration;
reg		[1:0]	data_ram_voltagevalue;
reg		[9:0]	data_ram_duration_part1;
reg		[9:0]	data_ram_duration_part2;
reg		[1:0]	data_ram_voltagevalue_part1;
reg		[1:0]	data_ram_voltagevalue_part2;

reg		[9:0]	address_write_info_2level;
reg		[9:0]	address_write_info_3level;
reg		[9:0]	address_read_info_2_level;
reg		[9:0]	address_read_info_3_level;

reg				write_en_info_3level;
reg				write_en_info_2level;
reg				read_en_2level;
reg				read_en_3level;
reg				ram_in_clk_info;
reg				read_ram_reg1;
reg				read_ram_reg2;
reg		[29:0]	cnt_duration;
reg		[29:0]	cnt_duration_3level;
reg				read_posedge;
reg		[1:0]	voltage_ram;
reg				inclk_reg1;
reg				inclk_reg2;
reg				q_duration_pose_reg1;
reg				q_duration_pose_reg2;
reg				q_duration_pose_part1_reg1;
reg				q_duration_pose_part1_reg2;

reg		[1:0]	voltage_out_reg;
reg		[1:0]	voltage_out_reg_part1;
reg		[1:0]	voltage_out_reg_part2;

reg		[1:0]	indata_time_unit_reg;
reg		[9:0]	indata_accuracy_reg;
reg		[9:0]	indata_circletime_reg;

wire			read_en_2level_3pipe;
wire			read_en_3level_3pipe;

reg		[29:0]	coefficient;

reg				flag_reg1;
reg				flag_reg2;
wire			flag;
//assign flag = flag_reg1 & (~flag_reg2);

assign inclk = indata_GPHCON5_clk;
//assign in_enable = {in_info_en,in_des_en};

assign indata_time_unit = {indata_GPBCON4,indata_GPBCON3};
assign indata_accuracy = {indata_GPGCON11,indata_GPGCON8,indata_GPGCON6,indata_GPGCON3,indata_GPGCON1,indata_GPECON10,indata_GPECON9,indata_GPECON8,indata_GPECON7,indata_GPECON1};
assign indata_circletime = {indata_GPCCON6,indata_GPCCON5,indata_GPCCON0,indata_GPJCON8,indata_GPJCON7,indata_GPJCON4,indata_GPJCON3,indata_GPJCON2,indata_GPJCON1,indata_GPJCON0};
assign indata_voltagelevel = indata_GPCCON7;

assign indata_voltagevalue = {indata_GPCCON5,indata_GPCCON0};
assign indata_duration = {indata_GPJCON1,indata_GPJCON0,indata_GPBCON10,indata_GPBCON9,indata_GPBCON8,indata_GPBCON7,indata_GPBCON6,indata_GPBCON5,indata_GPBCON4,indata_GPBCON3};
assign indata_voltagevalue_part1 = {indata_GPCCON5,indata_GPCCON0};
assign indata_duration_part1 = {indata_GPJCON1,indata_GPJCON0,indata_GPBCON10,indata_GPBCON9,indata_GPBCON8,indata_GPBCON7,indata_GPBCON6,indata_GPBCON5,indata_GPBCON4,indata_GPBCON3};
assign indata_voltagevalue_part2 = {indata_GPECON10,indata_GPECON9};
assign indata_duration_part2 = {indata_GPECON8,indata_GPECON7,indata_GPECON1,indata_GPCCON7,indata_GPCCON6,indata_GPJCON8,indata_GPJCON7,indata_GPJCON4,indata_GPJCON3,indata_GPJCON2};

assign q_duration_pose = q_duration_pose_reg1 & (~q_duration_pose_reg2);	
assign q_duration_part1_pose = q_duration_pose_part1_reg1 & (~q_duration_pose_part1_reg2);
			
assign enable = {info_en, para_en};
assign state = state_pipe[5:4];
assign read_posedge_initial = read_ram_reg1 & (!read_ram_reg2);
assign clear_begin	= read_ram_reg2 & (!read_ram_reg1);
assign negedge_clkin = inclk_reg2 & (!inclk_reg1);

assign read_en_2level_3pipe = read_en_2level_pipe[3];
assign read_en_3level_3pipe = read_en_3level_pipe[3];

assign voltage_out = (voltage_out_reg == 2'b11)? 1'b1 : 1'b0;

assign voltage_out_part1 = (voltage_out_reg_part1 == 2'd3)? 1'b1 : 1'b0;
assign voltage_out_part2 = (voltage_out_reg_part2 == 2'd3)? 1'b1 : 1'b0;
//assign areset_sig_ = areset_sig_reg;


always @(posedge clk_200M, negedge nreset)
	begin
		if(!nreset)
			begin
				state_pipe[5:0] <= 6'h0;
				read_en_2level_pipe <= 4'd0;
				read_en_3level_pipe <= 4'd0;
			end
		else
			begin
				read_en_2level_pipe <= {read_en_2level_pipe[2:0],read_en_2level}; 
				read_en_3level_pipe <= {read_en_3level_pipe[2:0],read_en_3level};
				state_pipe[5:2] <= state_pipe[3:0];
				state_pipe[1:0] <= enable;
			end
	end

always @(posedge clk_200M, negedge nreset)
		begin
			if(!nreset)
				begin
					inclk_reg1 <= 1'b0;
					inclk_reg2 <= 1'b0;
				end
			else
				begin
					if(inclk)
						begin
							inclk_reg1 <= 1'b1;
							inclk_reg2 <= inclk_reg1;
						end
					else
						begin
							inclk_reg1 <= 1'b0;
							inclk_reg2 <= inclk_reg1;
						end
				end
		end
	
always @(posedge clk_200M, negedge nreset)
	begin
		if(!nreset)
			begin
				//read_ram_reg2 <= 1'b0;
				//read_ram_reg1 <= 1'b0;
				voltage_level_reg <= 1'b0;
				indata_time_unit_reg <= 2'd0;
				indata_accuracy_reg <= 10'd0;
				indata_circletime_reg <= 10'd0;
				
				read_posedge <= 1'b0;
				cnt_duration <= 30'h0;
				cnt_duration_3level <= 30'h0;
				read_en_2level <= 1'b0;
				read_en_3level <= 1'b0;
				
				address_read_info_2_level <= 10'h0;
				address_read_info_3_level <= 10'h0;
				address_write_info_2level <= 10'h0;
				address_write_info_3level <= 10'h0;
				
				data_ram_duration <= 10'd0;
				data_ram_voltagevalue <= 2'b1;
				data_ram_duration_part1 <= 10'd0;
				data_ram_duration_part2 <= 10'd0;
				data_ram_voltagevalue_part1 <= 2'd1;
				data_ram_voltagevalue_part2 <= 2'd1;
				
				voltage_out_reg <= 2'd1;
				voltage_out_reg_part1 <= 2'd1;
				voltage_out_reg_part2 <= 2'd1;
			end
		else
			begin
				case(state)
					2'b00: 
						begin
						
							//voltage_out_reg <= 2'd1;
							//cnt_duration <= 16'd0;
							
							if(clear_begin)
								begin
									address_write_info_2level <= address_write_info_2level + 1'b1;
									address_write_info_3level <= address_write_info_3level + 1'b1;
								end
							if(inclk_reg1)
								begin	
									voltage_level_reg <= 1'b0;
									indata_time_unit_reg <= 2'd0;
									indata_accuracy_reg <= 10'd0;
									indata_circletime_reg <= 10'd0;		
									
									voltage_out_reg <= 2'd1;
									voltage_out_reg_part1 <= 2'd1;
									voltage_out_reg_part2 <= 2'd1;
									
									cnt_duration <= 30'd0;	
									cnt_duration_3level <= 30'd0;
									
									address_read_info_2_level <= 10'd0;
									address_read_info_3_level <= 10'd0;
									
									voltage_out_reg_part1 <= 2'b1;
									voltage_out_reg_part2 <= 2'b1;
									
									if(address_write_info_2level > 0)
										begin
											write_en_info_2level <= 1'b1;
											data_ram_duration <= 10'd0;
											data_ram_voltagevalue <= 2'b1;
											address_write_info_2level <= address_write_info_2level - 1'b1;
										end				
									else
										begin
											write_en_info_2level <= 1'b0;
										end
										
									if(address_write_info_3level > 0)
										begin
											write_en_info_3level <= 1'b1;
											data_ram_duration_part1 <= 10'd0;
											data_ram_duration_part2 <= 10'd0;
											data_ram_voltagevalue_part1 <= 2'd1;
											data_ram_voltagevalue_part2 <= 2'd1;
											address_write_info_3level <= address_write_info_3level - 1'b1;
										end
									else
										begin
											write_en_info_3level <= 1'b0;
										end
								end		
						end
					
					2'b01:
						begin	
							if(negedge_clkin)
								begin
									voltage_level_reg <= indata_voltagelevel;
									indata_time_unit_reg <= indata_time_unit;
									indata_accuracy_reg <= indata_accuracy / 100;
									indata_circletime_reg <= indata_circletime / 100;
								end
						end
						
					2'b10:
						begin						
							if(!voltage_level_reg)								
								begin
									data_ram_duration <= indata_duration;
									data_ram_voltagevalue <= indata_voltagevalue;
									if(negedge_clkin)
										begin
											address_write_info_2level <= address_write_info_2level + 1'b1;
											write_en_info_2level <= 1'b1;													
											//cnt_2level <= cnt_2level + 1'b1;
										end
									else
										begin
											write_en_info_2level <= 1'b0;
										end
								end
							else
								begin						
									data_ram_duration_part1 <= indata_duration_part1;
									data_ram_duration_part2 <= indata_duration_part2;
									data_ram_voltagevalue_part1 <= indata_voltagevalue_part1;
									data_ram_voltagevalue_part2 <= indata_voltagevalue_part2;
									
									if(negedge_clkin)
										begin
											address_write_info_3level <= address_write_info_3level + 1'b1;
											write_en_info_3level <= 1'b1;											
											//cnt_3level <= cnt_3level + 1'b1;
										end
									else
										begin
											write_en_info_3level <= 1'b0;
										end
								end
								
						end
					
					2'b11:
						begin
							//q_duration_reg = q_duration;
	
							if(!voltage_level_reg)
								begin
									if(cnt_duration == 30'd0)
										begin									
											if(read_posedge_initial)
												read_posedge <= 1'b1;
											else
												read_posedge <= 1'b0;
										end
									else
										begin
											cnt_duration <= cnt_duration - 1'b1;
											//voltage_out <= voltage_ram;
											if(cnt_duration == 30'd6)
												begin
													read_posedge <= 1'b1;
													
													if(address_read_info_2_level == address_write_info_2level - 1'b1)
														address_read_info_2_level <= 0;
													else
														address_read_info_2_level <= address_read_info_2_level + 1'b1;
												end
											else
												read_posedge <= 1'b0;
										end
																								
									if(read_posedge)
										read_en_2level <= 1'b1;
									else
										read_en_2level <= 1'b0;	
										
									if(q_duration > 0)
										begin
											q_duration_pose_reg1 <= 1'b1;
											q_duration_pose_reg2 <= q_duration_pose_reg1;
											//address_read_info_2_level <= address_read_info_2_level + 1'b1;
										end	
									else if(q_duration == 0)
										begin
											q_duration_pose_reg1 <= 1'b0;
											q_duration_pose_reg2 <= q_duration_pose_reg1;
										end
										
									if(read_en_2level_3pipe | (cnt_duration == 30'd1))
										cnt_duration <= q_duration * coefficient;
									
									//if(read_en_2level_3pipe)
									if((cnt_duration == 30'd1) | read_en_2level_3pipe)
										begin
											voltage_out_reg <= q_voltage_value;
										end
								end
							else
								begin
									if(cnt_duration_3level == 30'd0)
										begin									
											if(read_posedge_initial)
												read_posedge <= 1'b1;
											else
												read_posedge <= 1'b0;
										end
									else
										begin
											cnt_duration_3level <= cnt_duration_3level - 1'b1;
											//voltage_out <= voltage_ram;
											if(cnt_duration_3level == 30'd6)
												begin
													read_posedge <= 1'b1;
													
													if(address_read_info_3_level == address_write_info_3level - 1'b1)
														address_read_info_3_level <= 10'd0;
													else
														address_read_info_3_level <= address_read_info_3_level + 1'b1;
												end
											else
												read_posedge <= 1'b0;
										end
																								
									if(read_posedge)
										read_en_3level <= 1'b1;
									else
										read_en_3level <= 1'b0;	
										
									if(q_duration_part1 > 0)
										begin
											q_duration_pose_part1_reg1 <= 1'b1;
											q_duration_pose_part1_reg2 <= q_duration_pose_part1_reg1;
											//address_read_info_2_level <= address_read_info_2_level + 1'b1;
										end	
									else if(q_duration_part1 == 0)
										begin
											q_duration_pose_part1_reg1 <= 1'b0;
											q_duration_pose_part1_reg2 <= q_duration_pose_part1_reg1;
										end
										
									if(read_en_3level_3pipe | (cnt_duration_3level == 30'd1))
										cnt_duration_3level <= q_duration_part1 * coefficient;
										
									if((cnt_duration_3level == 30'd1) | read_en_3level_3pipe)
										begin
											voltage_out_reg_part1 <= q_voltage_value_part1;
											voltage_out_reg_part2 <= q_voltage_value_part2;
										end
									
								end
						end	
				endcase
			end
	end 	
	
	always @(posedge clk_200M, negedge nreset)
		begin
			if(!nreset)
				begin
					read_ram_reg1 <= 1'b0;
					read_ram_reg2 <= 1'b0;
				end
			else
				begin
					if(state == 2'b11)
						begin
							read_ram_reg1 <= 1'b1;
							read_ram_reg2 <= read_ram_reg1; 
						end
					else
						begin
							read_ram_reg1 <= 1'b0;
							read_ram_reg2 <= read_ram_reg1; 	
						end
				end
		end
		
always @(posedge clk_200M, negedge nreset)
	begin
		if(!nreset)
			begin
				coefficient <= 30'd0;
			end
		else
			begin
				if(indata_time_unit_reg == 2'd1)
					coefficient <= 2 * indata_accuracy_reg * indata_circletime_reg;
				else if(indata_time_unit_reg == 2'd2)
					coefficient <= 2000 * indata_accuracy_reg * indata_circletime_reg;
				else if(indata_time_unit_reg == 2'd3)
					coefficient <= 2000000 * indata_accuracy_reg * indata_circletime_reg;
			end
end	
	
ram	ram_duration (
	.clock ( CLK_200M_n ),
	.data ( data_ram_duration ),
	.rdaddress ( address_read_info_2_level ),
	.rden ( read_en_2level ),
	.wraddress ( address_write_info_2level - 1'b1),
	.wren ( write_en_info_2level ),
	.q ( q_duration )
	);
	

ram_vol	ram_voltagevalue (
	.clock ( CLK_200M_n ),
	.data ( data_ram_voltagevalue ),
	.rdaddress ( address_read_info_2_level ),
	.rden ( read_en_2level ),
	.wraddress ( address_write_info_2level - 1'b1),
	.wren ( write_en_info_2level ),
	.q ( q_voltage_value )
	);


ram	ram_duration_part1 (
	.clock ( CLK_200M_n ),
	.data ( data_ram_duration_part1 ),
	.rdaddress ( address_read_info_3_level ),
	.rden ( read_en_3level ),
	.wraddress ( address_write_info_3level - 1'b1),
	.wren ( write_en_info_3level ),
	.q ( q_duration_part1 )
	);

ram	ram_duration_part2 (
	.clock ( CLK_200M_n ),
	.data ( data_ram_duration_part2 ),
	.rdaddress ( address_read_info_3_level ),
	.rden ( read_en_3level ),
	.wraddress ( address_write_info_3level - 1'b1),
	.wren ( write_en_info_3level ),
	.q ( q_duration_part2 )
	);
	
ram_vol	ram_voltagevalue_part1 (
	.clock ( CLK_200M_n ),
	.data ( data_ram_voltagevalue_part1 ),
	.rdaddress ( address_read_info_3_level ),
	.rden ( read_en_3level ),
	.wraddress ( address_write_info_3level - 1'b1),
	.wren ( write_en_info_3level ),
	.q ( q_voltage_value_part1 )
	);


ram_vol	ram_voltagevalue_part2 (
	.clock ( CLK_200M_n ),
	.data ( data_ram_voltagevalue_part2 ),
	.rdaddress ( address_read_info_3_level ),
	.rden ( read_en_3level ),
	.wraddress ( address_write_info_3level - 1'b1),
	.wren ( write_en_info_3level ),
	.q ( q_voltage_value_part2 )
	);	
	
pll	pll_inst (
	.areset ( ~nreset ),
	.inclk0 ( clk ),
	.c0 ( clk_200M ),
	.c1 ( CLK_200M_n ),
	.locked ( locked_sig )
	);



	endmodule 
	

		