// SPDX-License-Identifier: CERN-OHL-S-2.0
// © 2025 Rosnnel Moncada

module GenericPWM_TB();

    parameter SysClk=100000000,NPWM=5,PWMFreq=50,Resolution=8;

    reg clk,reset;
    reg [1:0]FreqSel;
    reg [NPWM*Resolution-1:0]DC_bus;
    wire [NPWM-1:0]PWMOut;
    
    Generic_PWM #(SysClk,NPWM,PWMFreq,Resolution) DUT
    (clk,reset,FreqSel,DC_bus,PWMOut);
    
    initial 
    begin
        clk=0;
        forever #5 clk = ~clk;
    end
    
    initial
    begin
        #0; reset=1; FreqSel=2'b11;
        #10; reset=0; DC_bus[0 +: 8]=8'd127; DC_bus[8 +: 8]=8'd20; DC_bus[0*8 +: 8]=8'd127; 
             DC_bus[1*8 +: 8]=8'd20; DC_bus[2*8 +: 8]=8'd200; DC_bus[3*8 +: 8]=8'd100; 
             DC_bus[4*8 +: 8]=8'd220;
    end

endmodule
