function [AXD, AXD_bitsize] = multiplier(A_abs, D)
   % i=1;
    %while (i < length(A_abs)) 
        A_dec = bin2dec(A_abs);              
      AXD_dec = A_dec .* D;
       AXD = flip(de2bi(AXD_dec)); %Flip the bit order so MSB is the first bit.
    AXD_bitsize = length(AXD);
   %i = i+1;     
    end    
   
%b10hex = dec2hex(bin2dec(b10str)) %
 %dec2hex%
 %hex2dec%
     %bin2dec%
     %de2bi% 
     %mat2str