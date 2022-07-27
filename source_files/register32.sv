module register32(out, in, clk, we, clr);
    input logic [31:0] in;
    input logic clk, we, clr;
    output logic [31:0] out;

    genvar i;
    generate
        for(i=0; i<32; i=i+1) begin: loopDFF
            dffe_ref regDFF(out[i], in[i], clk, we, clr);
        end 
    endgenerate
endmodule

module dffe_ref (q, d, clk, en, clr);

   input logic d, clk, en, clr;

   //Output
   output logic q;
   
   //Set value of q on positive edge of the clock or clear
   always_ff @(posedge clk) begin
       //If clear is high, set q to 0
       if (clr) begin
           q <= 1'b0;
       //If enable is high, set q to the value of d
       end else if (en) begin
           q <= d;
       end
   end
endmodule