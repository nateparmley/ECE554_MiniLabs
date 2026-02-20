module lab1_spart_tb();

 //////////// CLOCK //////////
    logic               CLOCK_50;
    logic               CLOCK2_50;
    logic               CLOCK3_50;
    logic               CLOCK4_50;

 //////////// SEG7 //////////
    logic   [6:0]  HEX0;
    logic   [6:0]  HEX1;
    logic   [6:0]  HEX2;
    logic   [6:0]  HEX3;
    logic   [6:0]  HEX4;
    logic   [6:0]  HEX5;

//////////// KEY //////////
    logic        [3:0]  KEY;

 //////////// LED //////////
    logic		   [9:0]		LEDR;

 //////////// SW //////////
    logic        [9:0]  SW;

 //////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
    logic        GPIO_TX;
    logic        GPIO_RX;

    lab1_spart iDUT(.*);

    logic iorw, rda, tbr, txd, rxd;
    logic [1:0] ioaddr;
    logic [7:0] databus;
    logic [15:0] baud_cnt;

    assign GPIO_RX = txd;
    assign rxd = GPIO_TX;

    localparam FREQUENCY = 25000000;

    spart spart1(.clk(CLOCK_50),
                .rst(~KEY[0]),
                .iocs(1'b0),
                .iorw(iorw),
                .rda(rda),
                .tbr(tbr),
                .ioaddr(ioaddr),
                .databus(databus),
                .txd(txd),
                .rxd(rxd)
            );

    always_comb begin : decoder
        unique case(SW[9:8])
           2'b00: baud_cnt = int'((FREQUENCY/(16*4800)) - 1);
           2'b01: baud_cnt = int'((FREQUENCY/(16*9600)) - 1);
           2'b10: baud_cnt = int'((FREQUENCY/(16*19200)) - 1);
           2'b11: baud_cnt = int'((FREQUENCY/(16*38400)) - 1);
        endcase  
    end

    string str1 = "hello";
    string return_char;

    logic [7:0] send_data;

    initial begin
        // SET BAUD RATE TO 4800
        SW[9:8] = 2'b00;

        databus = 8'hzz;
        CLOCK_50 = 1'b0;
        KEY[0] = 1'b1; //RESET

        @(negedge CLOCK_50);
        @(negedge CLOCK_50);
        KEY[0] = 1'b0;

        // LOAD BAUD RATE TO OUR SPART
        @(posedge CLOCK_50);
        ioaddr = 2'b10;
        databus = baud_cnt[7:0];

        @(posedge CLOCK_50);
        ioaddr = 2'b11;
        databus = baud_cnt[15:8];

        // SEND FIRST CHARACTER
        @(posedge CLOCK_50);
        iorw = 1'b0;
        ioaddr = 2'b00;
        databus = str1[0];
        @(posedge CLOCK_50);
        databus = 8'hzz;
        @(posedge tbr);

        // RECEIVE FIRST CHARACTER
        @(posedge CLOCK_50);
        iorw = 1'b1;
        ioaddr = 2'b00;
        databus = 8'hzz;
        @(posedge CLOCK_50);
        @(posedge rda);
        //return_char = string'(databus);
        $display("%c", spart1.databus);

        repeat(50) @(posedge CLOCK_50);

        /*

        // SEND SECOND CHARACTER
        @(posedge CLOCK_50);
        iorw = 1'b0;
        ioaddr = 2'b00;
        databus = str1[1];
        @(posedge CLOCK_50);
        @(posedge tbr);

        // RECEIVE SECOND CHARACTER
        @(posedge CLOCK_50);
        iorw = 1'b1;
        ioaddr = 2'b00;
        databus = 8'hzz;
        @(posedge CLOCK_50);
        @(posedge rda);
        return_char = string'(databus);
        $write(return_char);

        // SEND THIRD CHARACTER
        @(posedge CLOCK_50);
        iorw = 1'b0;
        ioaddr = 2'b00;
        databus = str1[2];
        @(posedge CLOCK_50);
        @(posedge tbr);

        // RECEIVE THIRD CHARACTER
        @(posedge CLOCK_50);
        iorw = 1'b1;
        ioaddr = 2'b00;
        databus = 8'hzz;
        @(posedge CLOCK_50);
        @(posedge rda);
        return_char = string'(databus);
        $write(return_char);

        // SEND FOURTH CHARACTER
        @(posedge CLOCK_50);
        iorw = 1'b0;
        ioaddr = 2'b00;
        databus = str1[3];
        @(posedge CLOCK_50);
        @(posedge tbr);

        // RECEIVE FOURTH CHARACTER
        @(posedge CLOCK_50);
        iorw = 1'b1;
        ioaddr = 2'b00;
        databus = 8'hzz;
        @(posedge CLOCK_50);
        @(posedge rda);
        return_char = string'(databus);
        $write(return_char);

        // SEND FIFTH CHARACTER
        @(posedge CLOCK_50);
        iorw = 1'b0;
        ioaddr = 2'b00;
        databus = str1[4];
        @(posedge CLOCK_50);
        @(posedge tbr);

        // RECEIVE FIFTH CHARACTER
        @(posedge CLOCK_50);
        iorw = 1'b1;
        ioaddr = 2'b00;
        databus = 8'hzz;
        @(posedge CLOCK_50);
        @(posedge rda);
        return_char = string'(databus);
        $write(return_char);

        */

        $stop();


    end
    

    always 
        #5 CLOCK_50 = ~CLOCK_50;

endmodule