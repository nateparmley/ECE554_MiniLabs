module Minilab0_tb();

logic clk;
logic [3:0] key;
logic [9:0] sw, ledr;
logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5;

Minilab0 iDUT(.CLOCK_50(clk), .KEY(key), .SW(sw), .LEDR(ledr),
    .HEX0(hex0), .HEX1(hex1), .HEX2(hex2), .HEX3(hex3), .HEX4(hex4), .HEX5(hex5));

initial begin
    clk = 0;
    key = 4'b1110; //reset
    sw = 10'b0000000001;

    @(posedge clk);
    @(posedge clk);

    key = 4'b1111;

    // compuation complete (DONE state)
    @(posedge ledr[1]);
    @(posedge clk);
    @(posedge clk);

    // result should be 7000 (dec) --> 0x001B58 
    if ((hex0 !== 7'b0000000) || (hex1 !== 7'b0010010) || (hex2 !== 7'b0000011) 
        || (hex3 !== 7'b1111001) || (hex4 !== 7'b1000000) || (hex5 !== 7'b1000000)) begin

            $display("ERROR: wrong result");
            $stop();
    end

    $display("All tests passed");
    $stop();
end

always 
    #5 clk = ~clk;

endmodule