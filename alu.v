`timescale 1ns / 1ps

module ALU_32bit( 
//port declarations
                input [3:0]ALU_SEL,
                input [31:0]A,B,
                output reg [31:0]ALU_OUT,
                output  carry,
	        output  zero,negative,overflow,underflow

        );
		
		wire [32:0] tmp;
		assign tmp = {1'b0,A} + {1'b0,B};
                assign carry = tmp[32]; // Carryout flag
		assign zero = ~(|ALU_OUT); //zero flag
		assign negative = (ALU_OUT[31] == 1 && (ALU_SEL == 4'b0001));
		assign overflow = ({carry,ALU_OUT[31]} == 2'b01);
		assign underflow = ({carry,ALU_OUT[31]} == 2'b10);
		
	always@(*)
	begin
	
	case(ALU_SEL)
	
		4'b0000: // Addition
           ALU_OUT <= A + B ; 
		   
        4'b0001: // Subtraction
           ALU_OUT <= B - A ;
		   
        4'b0010: // Multiplication
           ALU_OUT <= A * B;
		   
        4'b0011: // Division
           ALU_OUT <= A/B;
		   
        4'b0100: // Logical shift left
           ALU_OUT <= A<<1;
		   
        4'b0101: // Logical shift right
           ALU_OUT <= A>>1;
		   
        4'b0110: // Rotate left
           ALU_OUT <= {A[30:0],A[31]};
		    
        4'b0111: // Rotate right
           ALU_OUT <= {A[0],A[31:1]};
		   
        4'b1000: //  Logical and 
           ALU_OUT <= A & B;
		   
        4'b1001: //  Logical or
           ALU_OUT <= A | B;
		   
        4'b1010: //  Logical xor 
           ALU_OUT <= A ^ B;
		   
        4'b1011: //  Logical nor
           ALU_OUT <= ~(A | B);
		   
        4'b1100: // Logical nand 
           ALU_OUT <= ~(A & B);
		   
        4'b1101: // Logical xnor
           ALU_OUT <= ~(A ^ B);
		   
        4'b1110: // Greater comparison
           ALU_OUT <= (A>B)?32'd1:32'd0;
		   
        4'b1111: // Equal comparison   
           ALU_OUT <= (A==B)?32'd1:32'd0;
		   
          default: ALU_OUT <= A + B; 
        endcase
    end

endmodule	
