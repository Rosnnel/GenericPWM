// SPDX-License-Identifier: CERN-OHL-S-2.0
// © 2025 Rosnnel Moncada

module Generic_PWM #(parameter SysClk = 125000000, NPWM = 5, PWMFreq = 50, Resolution = 8)
(clk,reset,FreqSel,DC_bus,PWMOut);

    input clk,reset;
    input [1:0]FreqSel;
    input [NPWM*Resolution-1:0]DC_bus;
    output [NPWM-1:0]PWMOut;

    wire Flag;   

    FlagGnerator #(.PWMFreq(PWMFreq),.SysClock(SysClk), .Resolution(Resolution)) FlgGen
    (.reset(reset),.clk(clk),.FreqSel(FreqSel),.Flag(Flag));
    
    wire [NPWM*Resolution-1:0]Cnt;  
    
    genvar i;
    generate
        for (i=0; i<NPWM; i=i+1)
        begin
            Counter #(.Resolution(Resolution))Counteri
            (.clk(clk),.reset(reset),.Enable(Flag),.Count(Cnt[i*Resolution +: Resolution]));
            
            assign PWMOut[i] = 
            (DC_bus[i*Resolution +: Resolution] > Cnt[i*Resolution +: Resolution]) ? 1'b1:1'b0;
        end
    endgenerate      
endmodule

