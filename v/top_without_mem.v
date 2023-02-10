module MyDesign (
    //---------------------------------------------------------------------------
//Control signals
        dut_run, 
        dut_busy,
        reset_b,  
        clk,
 
//---------------------------------------------------------------------------
//input and output SRAM interface
        dut_sram_write_address,
        dut_sram_write_data,
        dut_sram_write_enable,
        dut_sram_read_address,
        sram_dut_read_data,
//---------------------------------------------------------------------------
//weights SRAM interface                                                       
        dut_wmem_read_address,
        wmem_dut_read_data
);

    input dut_run,reset_b,clk;
    output dut_busy;
    output[11:0] dut_sram_write_address;
    output[15:0] dut_sram_write_data;
    output dut_sram_write_enable;
    output[11:0] dut_sram_read_address;
    input[15:0] sram_dut_read_data;
    output[11:0] dut_wmem_read_address;
    input[15:0] wmem_dut_read_data;

    wire dim_x_0_flag;
    wire dim_x_2_flag;
    wire increment,PC_output,decrement;
    wire data_or_dim_sel,x_or_y_sel,weight_data_sel,y_sel;
    wire[1:0] select;
    wire write_EN;
    wire output_pc_increment,output_pc_out;
    wire weight_PC;
    // wire dut_busy;
    wire pause;
	wire flush;

    Program_Counter P1(.clock(clk),.reset(reset_b),.increment(increment),.decrement(decrement),.flush(flush),.PC_out_EN(PC_output),.PC_output(dut_sram_read_address));

    Datapath D2(
    .line_data_input(sram_dut_read_data),.weight_data_input(wmem_dut_read_data),
    .clock(clk),.reset(reset_b),
    .data_output(dut_sram_write_data),.dim_x_0_flag(dim_x_0_flag),.dim_x_2_flag(dim_x_2_flag),.pause(pause),
    //control
    .data_or_dim_sel(data_or_dim_sel),.x_or_y_sel(x_or_y_sel),.weight_data_sel(weight_data_sel),.y_sel(y_sel),.select(select),.flush(flush));  


    Controller C3(
    .dim_x_0_flag(dim_x_0_flag),
    .dim_x_2_flag(dim_x_2_flag),
    .clock(clk),.reset(reset_b),
    .dut_run(dut_run),
    .pause(pause),
    .increment(increment),.PC_output(PC_output),.decrement(decrement),
    .data_or_dim_sel(data_or_dim_sel),.x_or_y_sel(x_or_y_sel),.weight_data_sel(weight_data_sel),.y_sel(y_sel),
    .select(select),
    .write_EN(dut_sram_write_enable),
    .output_pc_increment(output_pc_increment),.output_pc_out(output_pc_out),
    .weight_PC(dut_wmem_read_address),
    .dut_busy(dut_busy),
    .flush(flush));

    Program_Counter P4(.clock(clk),.reset(reset_b),.increment(output_pc_increment),.decrement(1'b0),.flush(flush),.PC_out_EN(output_pc_out),.PC_output(dut_sram_write_address));
endmodule
