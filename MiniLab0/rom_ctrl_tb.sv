`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/26/2026 08:31:30 PM
// Design Name: 
// Module Name: rom_ctrl_tb
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


module rom_ctrl_tb();

    logic clk, en;
    logic [7:0] addr;
    logic [7:0] data;
    
    rom_ctrl iDUT(.clk(clk), .en(en), .addr(addr), .data(data));
    
    initial begin
        clk = 0;
        en = 0;
        addr = 8'b0000_0001;
        
        @(posedge clk);
        @(posedge clk);
        if (data !== 8'h00)begin
            $display("data should be all 0's when not enabled");
            $stop();
        end
        
        @(negedge clk);
        
        en = 1;
        @(negedge clk);
        
        if (data !== 8'h11) begin
            $display("error on 1st read");
            $stop();
        end
        
        addr = 8'b0000_0010;
        @(negedge clk);
        
        if (data !== 8'h22) begin
            $display("error on 2nd read");
            $stop();
        end
        
        addr = 8'b0000_0100;
        @(negedge clk);
        
        if (data !== 8'h33) begin
            $display("error on 3rd read");
            $stop();
        end
        
        addr = 8'b0000_1000;
        @(negedge clk);
        
        if (data !== 8'h44) begin
            $display("error on 4th read");
            $stop();
        end
        
        addr = 8'b0001_0000;
        @(negedge clk);
        
        if (data !== 8'h55) begin
            $display("error on 5th read");
            $stop();
        end
        
        addr = 8'b0010_0000;
        @(negedge clk);
        
        if (data !== 8'h66) begin
            $display("error on 6th read");
            $stop();
        end
        
        addr = 8'b0100_0000;
        @(negedge clk);
        
        if (data !== 8'h77) begin
            $display("error on 7th read");
            $stop();
        end
        
        addr = 8'b1000_0000;
        @(negedge clk);
        
        if (data !== 8'h88) begin
            $display("error on 8th read");
            $stop();
        end
        
        $display("All tests passed");
        $stop();
        
    end
    
    always
        #5 clk = ~clk;

endmodule
