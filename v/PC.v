module Program_Counter(

    clock,reset,
    increment,decrement,
    flush,
    PC_out_EN,PC_output
    
    );
    input clock;
    input increment;
    input decrement;
    input reset;
    input PC_out_EN;
    input flush;
    output[11:0] PC_output;

    

    reg[11:0] NPC;
    wire[11:0] PC_data;


    always @(posedge clock or negedge reset) begin

        if(!reset)
            NPC <= 12'b000000000000; 

        else if(flush)
            NPC <= 12'b0;

        else
        begin
            if(increment == 1'b1) begin
                NPC <= PC_data + 1'b1;
            end 

            if(decrement == 1'b1) begin
                NPC <= PC_data - 1'b1;
            end

        end

        


    end

    assign PC_data = NPC;    
    assign PC_output = PC_out_EN ? NPC : 12'bz;

endmodule
