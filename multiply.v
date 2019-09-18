module multiply(ready,product,multiplier,multiplicand,clk);

   input         clk;
   input [31:0]  multiplier, multiplicand;  // The inputs should be twos complement numbers
   output [63:0] product;
   output        ready;

   reg [63:0]    product, product_temp;

   reg [31:0]    multiplier_copy;  // Temporary registers for the multiply
   reg [63:0]    multiplicand_copy;
   reg           isNeg;  // Determine the sign by XOR the leftmost bit of multiplier and multiplicand

   reg [5:0]     bit;  // For repeating 32 times
   wire          ready = !bit;

   // Initialization
   initial bit <= 0;
   initial isNeg <= 0;

   always @( posedge clk )

     if( ready ) begin

        bit               <= 6'd32;
        product           <= 0;
        product_temp      <= 0;

        // Get the absolute value of multiplicand. Add 0 to the
        // left half because multiplicand_copy is 64 bits long.
        multiplicand_copy <= multiplicand[31] ?
                            { 32'd0, ~multiplicand + 1'b1 } :
                            { 32'd0, multiplicand };

        // Get the absolute value of multiplier. If the leftmost bit
        // of multiplier is 1 which represent a negative number,
        // multiplier_copy equals to the twos complement of multiplier.
        multiplier_copy <= multiplier[31] ? (~multiplier + 1'b1) : multiplier;

        // XOR operation to determine the sign of the product
        isNeg <= multiplicand[31] ^ multiplier[31];

     end

     else if ( bit > 0 ) begin

        // If the rightmost bit of current multiplier_copy is 1,
        // then add the current multiplicand_copy to product_temp
        if( multiplier_copy[0] == 1'b1 )
           product_temp <= product_temp + multiplicand_copy;

        // If isNeg = 1, which means that the product should be
        // a negative number, then product equals to the
        // twos complement of product_temp. If isNeg = 0, product
        // equals to product_temp.
        product <= isNeg ? (~product_temp + 1'b1) : product_temp;

        // Shift right multiplier 1 bit
        multiplier_copy <= multiplier_copy >> 1;

        // Shift left multiplicand 1 bit
        multiplicand_copy <= multiplicand_copy << 1;

        bit <= bit - 1'b1;  // repeat 32 times

     end

endmodule
