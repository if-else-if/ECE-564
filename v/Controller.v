module Controller (
    dim_x_0_flag,
    dim_x_2_flag,
    clock,reset,
    dut_run,
    pause,
    increment,PC_output,decrement,
    data_or_dim_sel,x_or_y_sel,weight_data_sel,y_sel,
    select,
    write_EN,
    output_pc_increment,output_pc_out,
    weight_PC,
    dut_busy,
    flush
);
    input dim_x_0_flag;
    input dim_x_2_flag;
    input clock,reset;
    input dut_run;
    input pause;

    output increment,PC_output,decrement;
    output data_or_dim_sel,x_or_y_sel,weight_data_sel,y_sel;
    output[1:0] select;
    output write_EN;
    output output_pc_increment,output_pc_out;
    output[11:0] weight_PC;
    output dut_busy;
    output flush;

     parameter [3:0]
        S0 = 4'b0000,
        S1 = 4'b0001,
        S2 = 4'b0010,
        S3 = 4'b0011,
        S4 = 4'b0100,
        S5 = 4'b0101,
        S6 = 4'b0110,
        S7 = 4'b0111,
        S8 = 4'b1000,
        S9 = 4'b1001,
        S10 = 4'b1010,
        S11 = 4'b1011,
        S12 = 4'b1100,
        S13 = 4'b1101,
        S14 = 4'b1110,
        S15 = 4'b1111;

    reg [3:0] current_state, next_state;

    reg increment,PC_output,decrement;
    reg data_or_dim_sel,x_or_y_sel,weight_data_sel,y_sel;
    reg[1:0] select;
    reg write_EN;
    reg output_pc_increment,output_pc_out;
    reg[11:0] weight_PC;
    reg dut_busy;
    reg flush;
    reg dut_busy_wire;

    always @(posedge clock or negedge reset) begin
        if(!reset)begin
            current_state <= S0;
            dut_busy <= 1'b0;
        end
        else begin
            current_state <= next_state;
            dut_busy <= dut_busy_wire;
        end
    end

    always @(*) begin
        increment = 0;
        PC_output = 0;
        decrement = 0;
        data_or_dim_sel = 0;
        x_or_y_sel = 0;
        weight_data_sel = 0;
        y_sel = 0;
        select = 0;
        write_EN = 0;
        output_pc_increment = 0;
        output_pc_out = 0;
        weight_PC = 0;
        dut_busy_wire = 0;
        flush = 0;
        next_state = S0;

        case (current_state)
            S0: begin
                increment = 0;
                PC_output = 0;
                decrement = 0;
                data_or_dim_sel = 0;
                x_or_y_sel = 0;
                weight_data_sel = 0;
                y_sel = 0;
                select = 0;
                write_EN = 0;
                output_pc_increment = 0;
                output_pc_out = 0;
                weight_PC = 0;
                dut_busy_wire = 0;

                if(dut_run == 1'b0 || reset == 1'b0) begin
                    next_state = S0;
                end
                else if(dut_run == 1'b1 && reset == 1'b1) begin
                    next_state = S1;
                end
            end 

            S1: begin
                increment = 1;
                PC_output = 1;
                decrement = 0;
                data_or_dim_sel = 0;
                x_or_y_sel = 0;
                weight_data_sel = 0;
                y_sel = 0;
                select = 0;
                write_EN = 0;
                output_pc_increment = 0;
                output_pc_out = 0;
                weight_PC = 12'b000000000001;
                dut_busy_wire = 1;

                if(pause == 1'b1) begin
                    next_state = S0;
                    flush = 1'b1;
                end
                else begin
                    next_state = S2;
                end
                
            end

            S2: begin
                increment = 1;
                PC_output = 1;
                decrement = 0;
                data_or_dim_sel = 0;
                x_or_y_sel = 0;
                weight_data_sel = 1;
                y_sel = 0;
                select = 0;
                write_EN = 0;
                output_pc_increment = 0;
                output_pc_out = 0;
                weight_PC = 12'b000000000001;
                dut_busy_wire = 1;

                next_state = S3;
            end

            S3:begin
                increment = 1;
                PC_output = 1;
                decrement = 0;
                data_or_dim_sel = 0;
                x_or_y_sel = 1;
                weight_data_sel = 1;
                y_sel = 1;
                select = 2'b10;
                write_EN = 0;
                output_pc_increment = 0;
                output_pc_out = 0;
                weight_PC = 12'b000000000001;
                dut_busy_wire = 1;

                next_state = S4;
            end

            S4:begin
                increment = 1;
                PC_output = 1;
                decrement = 0;
                data_or_dim_sel = 1;
                x_or_y_sel = 1;
                weight_data_sel = 0;
                y_sel = 0;
                select = 2'b01;
                write_EN = 0;
                output_pc_increment = 0;
                output_pc_out = 0;
                weight_PC = 12'b000000000001;
                dut_busy_wire = 1;

                next_state = S5;
            end

            S5:begin
                increment = 1;
                PC_output = 1;
                decrement = 0;
                data_or_dim_sel = 1;
                x_or_y_sel = 1;
                weight_data_sel = 0;
                y_sel = 0;
                select = 1;
                write_EN = 0;
                output_pc_increment = 0;
                output_pc_out = 0;
                weight_PC = 12'b000000000001;
                dut_busy_wire = 1;

                next_state = S6;
            end

            S6:begin
                increment = 1;
                PC_output = 1;
                decrement = 0;
                data_or_dim_sel = 1;
                x_or_y_sel = 1;
                weight_data_sel = 0;
                y_sel = 0;
                select = 1;
                write_EN = 0;
                output_pc_increment = 0;
                output_pc_out = 0;
                weight_PC = 12'b000000000001;
                dut_busy_wire = 1;

                next_state = S7;
            end

            S7:begin
                increment = 1;
                PC_output = 1;
                decrement = 0;
                data_or_dim_sel = 1;
                x_or_y_sel = 1;
                weight_data_sel = 0;
                y_sel = 0;
                select = 1;
                write_EN = 0;
                output_pc_increment = 0;
                output_pc_out = 0;
                weight_PC = 12'b000000000001;
                dut_busy_wire = 1;

                next_state = S8;
            end

            S8:begin

                if(dim_x_2_flag == 1'b0) begin
                    increment = 1; 
                    decrement = 0;   
                end
                else begin
                    increment = 0;
                    decrement = 1;
                end
                
                PC_output = 1;
                data_or_dim_sel = 1;
                x_or_y_sel = 1;
                weight_data_sel = 0;
                y_sel = 0;
                select = 1;
                write_EN = 1;
                output_pc_increment = 1;
                output_pc_out = 1;
                weight_PC = 12'b000000000001;
                dut_busy_wire = 1;

                if(!dim_x_0_flag) begin
                    next_state = S8;
                end
                else begin
                    next_state = S9;
                end
            end

            S9:begin
                increment = 0;
                PC_output = 1;
                decrement = 1;
                data_or_dim_sel = 1;
                x_or_y_sel = 1;
                weight_data_sel = 0;
                y_sel = 0;
                select = 0;
                write_EN = 0;
                output_pc_increment = 0;
                output_pc_out = 0;
                weight_PC = 12'b000000000001;
                dut_busy_wire = 1;

                next_state = S1;
            end

        endcase

    end
endmodule