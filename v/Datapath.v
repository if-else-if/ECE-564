module Datapath (

    clock,reset,
    line_data_input,weight_data_input,
    data_output,dim_x_0_flag,dim_x_2_flag,pause,
    //control
    data_or_dim_sel,x_or_y_sel,weight_data_sel,y_sel,select,flush
);
    input[15:0] line_data_input,weight_data_input;
    input clock,reset;
    output[15:0] data_output;
    output dim_x_0_flag;
    output dim_x_2_flag;
    output pause;

     //wires
    reg[15:0] instruction_wire;
    reg[4:0] SRAM_input_wire,x_wire,y_wire;
    reg[15:0] data_xnor;
    reg[15:0] C_out_wire;
    reg[47:0] sum_wire;
    reg[15:0] padded_data_wire;

    //local storage
    reg[15:0] weight_data;
    reg[4:0] dim_x,dim_y;
    reg[15:0] A,B,C;


    //control signals
    input data_or_dim_sel,x_or_y_sel,weight_data_sel,y_sel;
    input flush;
    input[1:0] select;

    //output
    reg[15:0] data_output;
    reg dim_x_0_flag;
    reg dim_x_2_flag;
    reg pause;

    //A Table implementation
    wire[47:0] A_reg_xnor;
    reg[2:0] xnor_a_0,xnor_a_1,xnor_a_2,xnor_a_3,xnor_a_4,xnor_a_5,xnor_a_6,xnor_a_7,xnor_a_8,xnor_a_9,xnor_a_10,xnor_a_11,xnor_a_12,xnor_a_13;
    Table A1(A_reg_xnor[2:0],xnor_a_0[0],xnor_a_0[1],xnor_a_0[2]);
    Table A2(A_reg_xnor[5:3],xnor_a_1[0],xnor_a_1[1],xnor_a_1[2]);
    Table A3(A_reg_xnor[8:6],xnor_a_2[0],xnor_a_2[1],xnor_a_2[2]);
    Table A4(A_reg_xnor[11:9],xnor_a_3[0],xnor_a_3[1],xnor_a_3[2]);
    Table A5(A_reg_xnor[14:12],xnor_a_4[0],xnor_a_4[1],xnor_a_4[2]);
    Table A6(A_reg_xnor[17:15],xnor_a_5[0],xnor_a_5[1],xnor_a_5[2]);
    Table A7(A_reg_xnor[20:18],xnor_a_6[0],xnor_a_6[1],xnor_a_6[2]);
    Table A8(A_reg_xnor[23:21],xnor_a_7[0],xnor_a_7[1],xnor_a_7[2]);
    Table A9(A_reg_xnor[26:24],xnor_a_8[0],xnor_a_8[1],xnor_a_8[2]);
    Table A10(A_reg_xnor[29:27],xnor_a_9[0],xnor_a_9[1],xnor_a_9[2]);
    Table A11(A_reg_xnor[32:30],xnor_a_10[0],xnor_a_10[1],xnor_a_10[2]);
    Table A12(A_reg_xnor[35:33],xnor_a_11[0],xnor_a_11[1],xnor_a_11[2]);
    Table A13(A_reg_xnor[38:36],xnor_a_12[0],xnor_a_12[1],xnor_a_12[2]);
    Table A14(A_reg_xnor[41:39],xnor_a_13[0],xnor_a_13[1],xnor_a_13[2]);
    assign A_reg_xnor[47:42] = 6'b000000;


    //B Table implementation
    wire[47:0] B_reg_xnor;
    reg[2:0] xnor_b_0,xnor_b_1,xnor_b_2,xnor_b_3,xnor_b_4,xnor_b_5,xnor_b_6,xnor_b_7,xnor_b_8,xnor_b_9,xnor_b_10,xnor_b_11,xnor_b_12,xnor_b_13;
    Table B1(B_reg_xnor[2:0],xnor_b_0[0],xnor_b_0[1],xnor_b_0[2]);
    Table B2(B_reg_xnor[5:3],xnor_b_1[0],xnor_b_1[1],xnor_b_1[2]);
    Table B3(B_reg_xnor[8:6],xnor_b_2[0],xnor_b_2[1],xnor_b_2[2]);
    Table B4(B_reg_xnor[11:9],xnor_b_3[0],xnor_b_3[1],xnor_b_3[2]);
    Table B5(B_reg_xnor[14:12],xnor_b_4[0],xnor_b_4[1],xnor_b_4[2]);
    Table B6(B_reg_xnor[17:15],xnor_b_5[0],xnor_b_5[1],xnor_b_5[2]);
    Table B7(B_reg_xnor[20:18],xnor_b_6[0],xnor_b_6[1],xnor_b_6[2]);
    Table B8(B_reg_xnor[23:21],xnor_b_7[0],xnor_b_7[1],xnor_b_7[2]);
    Table B9(B_reg_xnor[26:24],xnor_b_8[0],xnor_b_8[1],xnor_b_8[2]);
    Table B10(B_reg_xnor[29:27],xnor_b_9[0],xnor_b_9[1],xnor_b_9[2]);
    Table B11(B_reg_xnor[32:30],xnor_b_10[0],xnor_b_10[1],xnor_b_10[2]);
    Table B12(B_reg_xnor[35:33],xnor_b_11[0],xnor_b_11[1],xnor_b_11[2]);
    Table B13(B_reg_xnor[38:36],xnor_b_12[0],xnor_b_12[1],xnor_b_12[2]);
    Table B14(B_reg_xnor[41:39],xnor_b_13[0],xnor_b_13[1],xnor_b_13[2]);
    assign B_reg_xnor[47:42] = 6'b000000;

    //C Table implementction
    wire[47:0] C_reg_xnor;
    reg[2:0] xnor_c_0,xnor_c_1,xnor_c_2,xnor_c_3,xnor_c_4,xnor_c_5,xnor_c_6,xnor_c_7,xnor_c_8,xnor_c_9,xnor_c_10,xnor_c_11,xnor_c_12,xnor_c_13;
    Table C1(C_reg_xnor[2:0],xnor_c_0[0],xnor_c_0[1],xnor_c_0[2]);
    Table C2(C_reg_xnor[5:3],xnor_c_1[0],xnor_c_1[1],xnor_c_1[2]);
    Table C3(C_reg_xnor[8:6],xnor_c_2[0],xnor_c_2[1],xnor_c_2[2]);
    Table C4(C_reg_xnor[11:9],xnor_c_3[0],xnor_c_3[1],xnor_c_3[2]);
    Table C5(C_reg_xnor[14:12],xnor_c_4[0],xnor_c_4[1],xnor_c_4[2]);
    Table C6(C_reg_xnor[17:15],xnor_c_5[0],xnor_c_5[1],xnor_c_5[2]);
    Table C7(C_reg_xnor[20:18],xnor_c_6[0],xnor_c_6[1],xnor_c_6[2]);
    Table C8(C_reg_xnor[23:21],xnor_c_7[0],xnor_c_7[1],xnor_c_7[2]);
    Table C9(C_reg_xnor[26:24],xnor_c_8[0],xnor_c_8[1],xnor_c_8[2]);
    Table C10(C_reg_xnor[29:27],xnor_c_9[0],xnor_c_9[1],xnor_c_9[2]);
    Table C11(C_reg_xnor[32:30],xnor_c_10[0],xnor_c_10[1],xnor_c_10[2]);
    Table C12(C_reg_xnor[35:33],xnor_c_11[0],xnor_c_11[1],xnor_c_11[2]);
    Table C13(C_reg_xnor[38:36],xnor_c_12[0],xnor_c_12[1],xnor_c_12[2]);
    Table C14(C_reg_xnor[41:39],xnor_c_13[0],xnor_c_13[1],xnor_c_13[2]);
    assign C_reg_xnor[47:42] = 6'b000000;

    always @(posedge clock or negedge reset) begin
        if(!reset)begin
            dim_x <= 5'b00000;
            dim_y <= 5'b00000;
            A <= 16'h0000;
            B <= 16'h0000;
            C <= 16'h0000;
            data_output <= 16'h0000;
            dim_x_0_flag <= 1'b0;
            dim_x_2_flag <= 1'b0;
            pause <= 1'b0; 
        end

        else if(flush == 1'b1)begin
            dim_x <= 5'b00000;
            dim_y <= 5'b00000;
            A <= 16'h0000;
            B <= 16'h0000;
            C <= 16'h0000;
            data_output <= 16'h0000;
            dim_x_0_flag <= 1'b0;
            dim_x_2_flag <= 1'b0;
            pause <= 1'b0; 
        end
        else begin
            dim_y <= (y_sel == 1'b1) ? y_wire  : dim_y;

            weight_data <= (weight_data_sel == 1'b1) ? weight_data_input : weight_data;

            //dim_x <= (select == 2'b00) ? x_wire : (dim_x <= (select == 2'b01) ? ( dim_x - 1'b1) :  dim_x));
            if(select == 2'b00)begin
                dim_x <= x_wire;
                
            end
            else if (select == 2'b01) begin
                dim_x <= dim_x -1'b1;
                
            end

            dim_x_0_flag <= (dim_x == 5'b00000) ? 1'b1 : 1'b0;
            dim_x_2_flag <= (dim_x == 5'b00010) ? 1'b1 : 1'b0;

            // Shift Register 
            C <= instruction_wire;
            B <= C;
            A <= B;
            data_output <= padded_data_wire;

            if((~C[15]) && (~C[14]) && (~C[13]) && (~C[14]) && (~C[13]) && (~C[12]) && (~C[11]) && (~C[10]) && (~C[9]) && (~C[8]) && (C[7]) && (C[6]) && (C[5]) && (C[4]) && (C[3]) && (C[2]) && (C[1]) && (C[0])) begin
                pause <= 1'b1;                
            end          

        end
    end


    always @(*) begin
        casex(data_or_dim_sel)
            1'b1: begin
                //data
                instruction_wire = line_data_input;
                SRAM_input_wire = 4'b0000;
            end
            1'b0: begin
                //dim
                instruction_wire = 16'h0000;
                SRAM_input_wire = line_data_input[4:0];
            end
        endcase

        casex (x_or_y_sel)
            1'b0:begin
                //x
                x_wire = SRAM_input_wire;
                y_wire = 4'b0000;
            end
            1'b1:begin
                //y
                x_wire = 4'b0000;
                y_wire = SRAM_input_wire;
            end
        endcase

         //C XNOR computation
        xnor_c_0 <= ~((weight_data[8:6]) ^ (C[2:0]));
        xnor_c_1 <= ~((weight_data[8:6]) ^ (C[3:1]));
        xnor_c_2 <= ~((weight_data[8:6]) ^ (C[4:2]));
        xnor_c_3 <= ~((weight_data[8:6]) ^ (C[5:3]));
        xnor_c_4 <= ~((weight_data[8:6]) ^ (C[6:4]));
        xnor_c_5 <= ~((weight_data[8:6]) ^ (C[7:5]));
        xnor_c_6 <= ~((weight_data[8:6]) ^ (C[8:6]));
        xnor_c_7 <= ~((weight_data[8:6]) ^ (C[9:7]));
        xnor_c_8 <= ~((weight_data[8:6]) ^ (C[10:8]));
        xnor_c_9 <= ~((weight_data[8:6]) ^ (C[11:9]));
        xnor_c_10 <= ~((weight_data[8:6]) ^ (C[12:10]));
        xnor_c_11 <= ~((weight_data[8:6]) ^ (C[13:11]));
        xnor_c_12 <= ~((weight_data[8:6]) ^ (C[14:12]));
        xnor_c_13 <= ~((weight_data[8:6]) ^ (C[15:13]));  


        //B XNOR computation
        xnor_b_0 <= ~((weight_data[5:3]) ^ (B[2:0]));
        xnor_b_1 <= ~((weight_data[5:3]) ^ (B[3:1]));
        xnor_b_2 <= ~((weight_data[5:3]) ^ (B[4:2]));
        xnor_b_3 <= ~((weight_data[5:3]) ^ (B[5:3]));
        xnor_b_4 <= ~((weight_data[5:3]) ^ (B[6:4]));
        xnor_b_5 <= ~((weight_data[5:3]) ^ (B[7:5]));
        xnor_b_6 <= ~((weight_data[5:3]) ^ (B[8:6]));
        xnor_b_7 <= ~((weight_data[5:3]) ^ (B[9:7]));
        xnor_b_8 <= ~((weight_data[5:3]) ^ (B[10:8]));
        xnor_b_9 <= ~((weight_data[5:3]) ^ (B[11:9]));
        xnor_b_10 <= ~((weight_data[5:3]) ^ (B[12:10]));
        xnor_b_11 <= ~((weight_data[5:3]) ^ (B[13:11]));
        xnor_b_12 <= ~((weight_data[5:3]) ^ (B[14:12]));
        xnor_b_13 <= ~((weight_data[5:3]) ^ (B[15:13])); 


        //A XNOR computation
        xnor_a_0 <= ~((weight_data[2:0]) ^ (A[2:0]));
        xnor_a_1 <= ~((weight_data[2:0]) ^ (A[3:1]));
        xnor_a_2 <= ~((weight_data[2:0]) ^ (A[4:2]));
        xnor_a_3 <= ~((weight_data[2:0]) ^ (A[5:3]));
        xnor_a_4 <= ~((weight_data[2:0]) ^ (A[6:4]));
        xnor_a_5 <= ~((weight_data[2:0]) ^ (A[7:5]));
        xnor_a_6 <= ~((weight_data[2:0]) ^ (A[8:6]));
        xnor_a_7 <= ~((weight_data[2:0]) ^ (A[9:7]));
        xnor_a_8 <= ~((weight_data[2:0]) ^ (A[10:8]));
        xnor_a_9 <= ~((weight_data[2:0]) ^ (A[11:9]));
        xnor_a_10 <= ~((weight_data[2:0]) ^ (A[12:10]));
        xnor_a_11 <= ~((weight_data[2:0]) ^ (A[13:11]));
        xnor_a_12 <= ~((weight_data[2:0]) ^ (A[14:12]));
        xnor_a_13 <= ~((weight_data[2:0]) ^ (A[15:13])); 


        // Addition of XNORs 
        {C_out_wire[0], sum_wire[2:0]} <= A_reg_xnor[2:0] + B_reg_xnor[2:0] + C_reg_xnor[2:0];
        {C_out_wire[1], sum_wire[5:3]} <= A_reg_xnor[5:3] + B_reg_xnor[5:3] + C_reg_xnor[5:3];
        {C_out_wire[2], sum_wire[8:6]} <= A_reg_xnor[8:6] + B_reg_xnor[8:6] + C_reg_xnor[8:6];
        {C_out_wire[3], sum_wire[11:9]} <= A_reg_xnor[11:9] + B_reg_xnor[11:9] + C_reg_xnor[11:9];
        {C_out_wire[4], sum_wire[14:12]} <= A_reg_xnor[14:12] + B_reg_xnor[14:12] + C_reg_xnor[14:12];
        {C_out_wire[5], sum_wire[17:15]} <= A_reg_xnor[17:15] + B_reg_xnor[17:15] + C_reg_xnor[17:15];
        {C_out_wire[6], sum_wire[20:18]} <= A_reg_xnor[20:18] + B_reg_xnor[20:18] + C_reg_xnor[20:18];
        {C_out_wire[7], sum_wire[23:21]} <= A_reg_xnor[23:21] + B_reg_xnor[23:21] + C_reg_xnor[23:21];
        {C_out_wire[8], sum_wire[26:24]} <= A_reg_xnor[26:24] + B_reg_xnor[26:24] + C_reg_xnor[26:24];
        {C_out_wire[9], sum_wire[29:27]} <= A_reg_xnor[29:27] + B_reg_xnor[29:27] + C_reg_xnor[29:27];
        {C_out_wire[10], sum_wire[32:30]} <= A_reg_xnor[32:30] + B_reg_xnor[32:30] + C_reg_xnor[32:30];
        {C_out_wire[11], sum_wire[35:33]} <= A_reg_xnor[35:33] + B_reg_xnor[35:33] + C_reg_xnor[35:33];
        {C_out_wire[12], sum_wire[38:36]} <= A_reg_xnor[38:36] + B_reg_xnor[38:36] + C_reg_xnor[38:36];
        {C_out_wire[13], sum_wire[41:39]} <= A_reg_xnor[41:39] + B_reg_xnor[41:39] + C_reg_xnor[41:39];
        {C_out_wire[14], sum_wire[44:42]} <= A_reg_xnor[44:42] + B_reg_xnor[44:42] + C_reg_xnor[44:42];
        {C_out_wire[15], sum_wire[47:45]} <= A_reg_xnor[47:45] + B_reg_xnor[47:45] + C_reg_xnor[47:45];

        data_xnor[0] <= ((C_out_wire[0]) || (sum_wire[2:0] > 3'b100)) ? 1'b1 : 1'b0;
        data_xnor[1] <= ((C_out_wire[1]) || (sum_wire[5:3] > 3'b100)) ? 1'b1 : 1'b0;
        data_xnor[2] <= ((C_out_wire[2]) || (sum_wire[8:6] > 3'b100)) ? 1'b1 : 1'b0;
        data_xnor[3] <= ((C_out_wire[3]) || (sum_wire[11:9] > 3'b100)) ? 1'b1 : 1'b0;
        data_xnor[4] <= ((C_out_wire[4]) || (sum_wire[14:12] > 3'b100)) ?  1'b1 : 1'b0;
        data_xnor[5] <= ((C_out_wire[5]) || (sum_wire[17:15] > 3'b100)) ? 1'b1 : 1'b0;
        data_xnor[6] <= ((C_out_wire[6]) || (sum_wire[20:18] > 3'b100)) ? 1'b1 : 1'b0;
        data_xnor[7] <= ((C_out_wire[7]) || (sum_wire[23:21] > 3'b100)) ? 1'b1 : 1'b0;
        data_xnor[8] <= ((C_out_wire[8]) || (sum_wire[26:24] > 3'b100)) ? 1'b1 :  1'b0;
        data_xnor[9] <= ((C_out_wire[9]) || (sum_wire[29:27] > 3'b100)) ? 1'b1 : 1'b0;
        data_xnor[10] <= ((C_out_wire[10]) || (sum_wire[32:30] > 3'b100)) ? 1'b1 : 1'b0;
        data_xnor[11] <= ((C_out_wire[11]) || (sum_wire[35:33] > 3'b100)) ? 1'b1 :  1'b0;
        data_xnor[12] <= ((C_out_wire[12]) || (sum_wire[38:36] > 3'b100)) ? 1'b1 : 1'b0;
        data_xnor[13] <= ((C_out_wire[13]) || (sum_wire[41:39] > 3'b100)) ? 1'b1 : 1'b0;

        data_xnor[14] <= 1'b0;
        data_xnor[15] <= 1'b0;

        if(dim_y == 5'b10000) begin
            padded_data_wire <= data_xnor;
        end
        else if(dim_y == 5'b01100) begin
            padded_data_wire <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,data_xnor[9:0]};
        end
        else if(dim_y == 5'b01010) begin
            padded_data_wire <= {1'h0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,data_xnor[7:0]};
        end
        else begin
            padded_data_wire <= 16'h0;
        end
    end
    
endmodule


module Table(out,in1,in2,in3);
    input in1,in2,in3;
    output[2:0] out;
    reg[2:0] out;
    always @(*) begin
        casex ({in3,in2,in1})
        3'b000: out<= 3'b000; 
        3'b001: out<= 3'b001;
        3'b010: out<= 3'b001;
        3'b011: out<= 3'b010;
        3'b100: out<= 3'b001;
        3'b101: out<= 3'b010;
        3'b110: out<= 3'b010;
        3'b111: out<= 3'b011;
    endcase
    end
    
endmodule