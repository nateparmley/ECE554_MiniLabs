`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/26/2026 08:12:33 PM
// Design Name: 
// Module Name: rom_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rom_ctrl(
    input logic clk,
    input logic [7:0] addr,
    input logic en,
    output logic [7:0] data
);

always_ff @(posedge clk) begin
    if (en) 
        case (addr) 
            8'b0000_0001: data <= 8'h11;
            8'b0000_0010: data <= 8'h22;
            8'b0000_0100: data <= 8'h33;
            8'b0000_1000: data <= 8'h44;
            8'b0001_0000: data <= 8'h55;
            8'b0010_0000: data <= 8'h66;
            8'b0100_0000: data <= 8'h77;
            8'b1000_0000: data <= 8'h88;
            default: data <= 8'h00;
        endcase
    
    else
        data <= 8'h00;
end


endmodule
