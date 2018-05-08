function [AXD, AXD_bitsize] = multiplier(A_abs, A_abs_bitsize, D)
   % i=1;
    %while (i < length(A_abs)) 
    bitlngth=2*A_abs_bitsize;  
    A_dec = f_b2d(A_abs);              
      AXD_dec = A_dec .* D;  %decimal multiplication of A and D%
      AXD_ext =de2bi(AXD_dec); 
      ae=length(AXD_ext);
      AXD(1:(bitlngth))='0';
      AXD((bitlngth-ae+1):bitlngth) = f_d2b(bi2de(AXD_ext));%Flip the bit order so MSB is the first bit.
      AXD_bitsize = length(AXD); %no need 2 flip array is read backwards and convered to decimal befoe converting into char value
   %i = i+1;     
end    
   
    
%f_b2d for Chars
%f_d2b for chars
%b10hex = dec2hex(bin2dec(b10str)) %
 %dec2hex%
 %hex2dec%
     %bin2dec%  For Char conversion '1001010'
     %de2bi% For Array conversion [1,0,1,0,0,1,0,1]
     %mat2str