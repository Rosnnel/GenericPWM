// SPDX-License-Identifier: CERN-OHL-S-2.0
// © 2025 Rosnnel Moncada

module Counter #(parameter Resolution = 8)(clk,reset,Enable,Count);

    input clk,reset,Enable;
    output reg [Resolution-1:0]Count;
    
    always@(posedge clk or posedge reset)
    begin
        if(reset)
            Count <= 0;
        else if (Enable)
            Count <= Count + 1;
    end

endmodule
