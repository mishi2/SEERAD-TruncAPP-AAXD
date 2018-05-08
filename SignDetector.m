%%Block1 for SEERAD & TRUNCAPP:%%
% Inputs: A, B (n bits)    Outputs: [A] and [B] absolute value (n-1 bits)%
function [A_abs,B_abs,sign, A_bitsize, B_bitsize,A_abs_bitsize,B_abs_bitsize] = SignDetector(A,B)

A_abs = A(2:length(A));

B_abs = B(2:length(B));

A_bitsize = length(A); 

B_bitsize = length(B); 

A_abs_bitsize = length(A_abs); 

B_abs_bitsize = length(B_abs); 

if (A(1) == B(1))
sign = '0';
else sign ='1';

end