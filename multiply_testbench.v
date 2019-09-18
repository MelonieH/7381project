module test_multiply;
   reg clk;
   reg [31:0]  multiplier, multiplicand;
   wire [63:0] product;
   wire ready;

    initial
    begin
        clk <= 0; forever #1 clk <= ~clk;
    end

   multiply u1(.clk(clk), .multiplier(multiplier), .multiplicand(multiplicand), .product(product), .ready(ready));

    always @(posedge clk)
    begin

     multiplier = 32'b00000000000000000000000000000011;  	// 3 * 20 using complement code
     multiplicand = 32'b00000000000000000000000000010100;
     #90
     $display($time, " multiplier = %b, multiplicand = %b, product=%b", multiplier, multiplicand, product);	// product is 0000000000000000000000000000000000000000000000000000000000111100 = 60

     multiplier = 32'b00000000000000000000000000000011;  	// 3 * -2
     multiplicand = 32'b11111111111111111111111111111110;
     #90
     $display($time, " multiplier = %b, multiplicand = %b, product=%b", multiplier, multiplicand, product); // product is 1111111111111111111111111111111111111111111111111111111111111010 = -6

     multiplier = 32'b11111111111111111111111111111110;  	// -2 * 1
     multiplicand = 32'b00000000000000000000000000000001;
     #99
     $display($time, " multiplier = %b, multiplicand = %b, product=%b", multiplier, multiplicand, product); // product is 1111111111111111111111111111111111111111111111111111111111111110 = -2

     multiplier = 32'b11111111111111111111111111111111;		// -1 * -23
     multiplicand = 32'b11111111111111111111111111101001;
     #90
     $display($time, " multiplier = %b, multiplicand = %b, product=%b", multiplier, multiplicand, product); // product is 0000000000000000000000000000000000000000000000000000000000010111 = 23

     multiplier = 32'b00000000000000000000000000000001;		// 1 * 0
     multiplicand = 32'b00000000000000000000000000000000;
     #90
     $display($time, " multiplier = %b, multiplicand = %b, product=%b", multiplier, multiplicand, product); // product is 0000000000000000000000000000000000000000000000000000000000000000 = 0

     multiplier = 32'b11111111111111111111111111111110;		// -2 * 0
     multiplicand = 32'b00000000000000000000000000000000;
     #90
     $display($time, " multiplier = %b, multiplicand = %b, product=%b", multiplier, multiplicand, product); // product is 0000000000000000000000000000000000000000000000000000000000000000 = 0

     multiplier = 32'b00000000000000000000000000000000;		// 0 * 0
     multiplicand = 32'b00000000000000000000000000000000;
     #90
     $display($time, " multiplier = %b, multiplicand = %b, product=%b", multiplier, multiplicand, product); // product is 0000000000000000000000000000000000000000000000000000000000000000 = 0

     multiplier = 32'b00000000000000000000000000000000;		// 0 * 2
     multiplicand = 32'b00000000000000000000000000000010;
     #90
     $display($time, " multiplier = %b, multiplicand = %b, product=%b", multiplier, multiplicand, product); // product is 0000000000000000000000000000000000000000000000000000000000000000 = 0

     multiplier = 32'b00000000000000000000000000000000;		// 0 * -1
     multiplicand = 32'b11111111111111111111111111111111;
     #90
     $display($time, " multiplier = %b, multiplicand = %b, product=%b", multiplier, multiplicand, product); // product is 0000000000000000000000000000000000000000000000000000000000000000 = 0

     multiplier = 32'b01111111111111111111111111111111;		// 2147483647 * 2147483647
     multiplicand = 32'b01111111111111111111111111111111;
     #500
     $display($time, " multiplier = %b, multiplicand = %b, product=%b", multiplier, multiplicand, product); // product is 0011111111111111111111111111111100000000000000000000000000000001 = 4611686014132420609


     $stop;

    end


endmodule


   
