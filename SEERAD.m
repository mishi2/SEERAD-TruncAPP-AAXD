%SEERAD High Level Implementation Code-  accuracy level (AL) and the inputs a(dividend) b(divisor) are the simulation parameters
%(D x A)/(2^L x Bf) --  D  L are constants derived from the Accuracy level table
%Figure out what the adder does to the n inputs of the bit by bit multiplication of A with D

%CREATE PARAMETERS FIRST (A,B, AL):
A='00110101';  %Makesure bitsize are the same
B='00001101';  %Makesure bitsize are the same
AL=1;  %1,2,3,4


%L(3bits) = Accuracy Level constant   AL=1,L=3 -- AL=2,L=4 -- AL=3,L=5 -- AL=4,L=7 

%BLOCK1_SignDetector --May be better to create function for each block of circuit diagram:
% Inputs: A, B (n bits)    Outputs: [A] and [B] absolute value (n-1 bits)
%Compares inputs' MSBs, compares them (same = positive,
% different=negative), and truncates the sign msb to yield absolute values
% [A] and [B]


[A_abs,B_abs,sign, A_bitsize, B_bitsize]=SignDetector(A,B); %% This will strip off the sign bit from the input operands and return 
% n-1 bit string of the operands' absolute values. 
% Sign Detector will output [A], [B], Sign(compares signs of a and b - 0
% for same, 1 for diff), A bitsize and B bitsize.



%Block2_Rounding -- Input: [B] Output: Bf (Bits set to zero except for the MSB)
%Basically the floor minimum value of B looking at only the MSB, 0s follow
%the msb
[Bf, Bf_bitsize, K] = Rounding(B_abs);  %% The Floor Rounding of B_abs


%Block3_IndexDetector -- Inputs: Bf and [B] (Also Needs to Know the
%Accuracy Level Chosen 1,2,3,4)   Output: D the so called optimal constant
%matched with the bit pattern found from [B].. Bf is there to indicate at
%which bit to start looking at the pattern. Accuracy Level is needed to
%know how many bits to consider in the pattern, and what D values are for each bit pattern in the accuracy level (may need array) 
[D ,L] = IndexDetector(Bf,B_abs, AL); % This Blocks Yields the Constants L & D for the 
%SEERAD Approximation Formula 


%Block4_Multiplier -- Input: D and [A]  Outputs: 2n-1 bits of A[0-n-1] X D[6:0] 
%Bitwise multiplication of dividend [A] with constant D (7 bits)
% the block Multiply, [A] x D is calculated through shift to left operation. Based on the D values 
%given in Table I, the number of shift units in the first, second, third and fourth accuracy levels 
%are 2, 2, 2,and 3, respectively. The outputs of these shifter units are summed in the block Adder. 
%It  is worth to mention that  the outputs bit length of the Multiply and Adder blocks are 2n bits. %
[AXD, AXD_bitsize] = multiplier(A_abs, D);  %returns the Product and product bit of dividend with constant D


%Block5_Adder -- Inputs:    Outputs:
% Next, the output of the Adder block is utilized by the block Shifter to calculate (D x A)/(2^L x Bf).
%This block shifts to right its input by K  +  L bits. The shift to right, for implementing 
%the division by 2^K, is implemented by a barrel shifter. In this case, no bits are shift out while the least significant 
%bits are considered as the fractional part of the result. Hence, the output width of this block is 2n +  L 
%bits where its n bits belong to the integer part and n +  L bits represent the fractional part of the result. 


%Block6_Shifter(2n+L-1 bits) -- Inputs:AXD,L,K   Outputs:[AXD/2^K+L]
%The shift to right, for implementing the division by 2^K+L, is implemented by a barrel shifter. 
%In this case, no bits are shift out while the least significant bits are considered as
%the fractional part of the result.
[Q_abs, Q_abs_Bitsize] = Shifter(AXD, AXD_Bitsize, K, L);


%Block7_SignSet -- Input: Sign(Same(Positive) or Diff(Negative))  Outputs:
%Same as Input if Sign is same.. Bits inverted if Sign is Diff
%Finally, the sign of the result is determined based on the sign 
%of the inputs. For this, only in the case where one of the inputs is negative, 
%the Sign Set block should complement the result. 
[Q, Q_Bitsize] = SignSet(Q_abs, sign); 






%Error Check Block ( 1- (A/Bapprox)/(A/Bexact))