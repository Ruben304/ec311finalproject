module stopwatch_ms(
    input clk_i, reset_i, start_stop, Timeset,
    input [4:0] Hourset,
    input [5:0] Minset,
    input [5:0] Secset,
    input [9:0] Msset,
    output reg [5:0] sec_o,
    output reg [5:0] min_o,
    output reg [4:0] hour_o,
    output reg [9:0] ms_o //counting till 999
                 );
  always @ (posedge clk_i)
    begin 
        if (Timeset==1) begin
            hour_o <= Hourset;
            min_o <= Minset;
            sec_o <= Secset;
            ms_o <=  Msset; 
        end

       if (start_stop)
         begin
             ms_o <= ms_o + 1;
             if (ms_o == 999)
                ms_o <= 0;
                sec_o <= sec_o + 1;
                if (sec_o == 59) //&& ms_o==999
                begin 
                    min_o <= min_o + 1;
                    sec_o <= 0;
                    if (min_o == 59) //&& ms_o==999
                        begin
                            hour_o <= hour_o + 1;
                            min_o <= 0;
                        end
                   end
             end
        end     
        
always @ (negedge reset_i) begin
        if(reset_i)
            begin 
                hour_o <= 0;
                min_o <= 0;
                sec_o <= 0;
                ms_o <= 0;
            end
end          
endmodule
