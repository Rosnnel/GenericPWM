// SPDX-License-Identifier: CERN-OHL-S-2.0
// © 2025 Rosnnel Moncada

module FlagGnerator #(parameter PWMFreq=500, SysClock=100000000, Resolution = 8)
(reset,clk,FreqSel,Flag);

    localparam preescaler = (1<<Resolution);
    localparam Ticks0 = SysClock/(preescaler*PWMFreq),
               Ticks1 = SysClock/(preescaler*PWMFreq*2),
               Ticks2 = SysClock/(preescaler*1000),
               Ticks3 = SysClock/(preescaler*5000);
    
    input reset,clk;
    input [1:0]FreqSel;
    output reg Flag;    
    
    reg[31:0] Cnt,Cmp;
    
    
    always@(*)
    begin
        case(FreqSel)
            2'b00: Cmp = Ticks0;
            2'b01: Cmp = Ticks1;
            2'b10: Cmp = Ticks2;
            2'b11: Cmp = Ticks3;
        endcase
    end
    
    always@(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            Cnt <= 32'b0;
            Flag <= 1'b0;
        end
        else
        begin
            if(Cnt >= Cmp)
            begin
                Cnt <= 32'b0;
                Flag <= 1'b1;
            end
            else
            begin
                Cnt <= Cnt + 1;
                Flag <= 1'b0;
            end       
        end
    end
endmodule
