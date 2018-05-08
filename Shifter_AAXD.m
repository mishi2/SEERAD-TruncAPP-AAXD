function [Qs_pre, Qs_Bitsize] = Shifter_AAXD(Qp,La_minus_Lb,k,nB) %Maintain Bitsize when shifting regardless of integer/fraction input
 

%aRE YOU SHIFTING rIGHT OR lEFT(adding or dropping bits)
%Is there a decimal fraction bits involved?%
%Cases:
%Right Shift non fraction
%Left Shift non fraction
%Right shift fraction
%Leftshift fraction

a= La_minus_Lb - k;
leftshift=0;
rightshift=0;
if(a>0)
leftshift=1;
elseif(a<0)
rightshift=1;
else
  noshift=1;
end


decimal=0;
i=1;
while(i<=length(Qp))
         if(Qp(i)=='.')
             decimal=1;
            i; %index where the '.' is located
      frac_bits=Qp(i+1+a:length(Qp)); % Saved fraction portion (after shift) of Qp bits -- add to after the decimal..
             break
         end
   i=i+1;
end

if(decimal==1) %FRACTION%
  %% HOW TO SHIFT when Decimal/Fraction binary value  
  
  Qs_abs_shift=f_d2b(bitshift(f_b2d(Qp(1:i-1)),a));  %Take care of bitshifting the non decimal part of Qp  
  b= length(Qs_abs_shift);
  if(leftshift==1) %Leftshift fraction  -- bitsize enlarges by 1 for each integer shif (a) replace (b-a:b) bits with the first a bits in fracbits (take account decimal)
        Qs_abs_shift(b-a+1:b)=Qp(i+1:i+a); %index to the right of (integer Qs bits-shifting digits) to index of (last bit of integer Qs bits) 
        Qs_abs_shift(b+1)='.';
        d=i+a+1; %the index after decimal '.' plus the shifted amount 
        Qs_abs_shift(b+2:b+1+length(frac_bits))=frac_bits;
        %Q_abs_shift(b+2:b+1+length(Qp(d:length(Qp))))=Qp(d:length(Qp));
      
  elseif(rightshift==1)  %Right shift fraction   ---- bitsize decreases by 1 for each integer shift (a)
     shifted=Qp(length(Qp)-(a-1):length(Qp));  % Since we will lose bits from shifting right, retrieve them from the input, add a decimal to the front, and append it to the end of Q_abs 
    append_bits(1)='.';
     append_bits(2:length(shifted)+1)=shifted;  
     Qs_abs_shift((b+a+1):(b+a+length(append_bits)))=append_bits;
  
  end
Qs_pre=Qs_abs_shift;     
Qs_Bitsize = length(Qs_pre)-1;
Qp_Bitsize = (length(Qp)-1);

%%%%%%%%%%%%%%%%%%%%%%%% end of fraction cases (decimal ==1) %%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%

elseif(leftshift==1) %Left Shift non fraction
Qs_pre= f_d2b(bitshift(f_b2d(Qp),a));
 Qs_Bitsize = length(Qs_pre);
else  %Rightshift non fraction
    Qs_shift= f_d2b(bitshift(f_b2d(Qp),a));
Qp_Bitsize = length(Qp);
 bit_append_Qp = length(Qp);
    bit_append_Qs = length(Qs_shift);
    diffbit=abs(bit_append_Qs-bit_append_Qp)+1; %CHANGED to ABS make sure its not wrong to do so
    Qs_pre(1:diffbit)='0';
    Qs_pre(diffbit+1:diffbit+length(Qs_shift))=Qs_shift;
    %Qs_pre(diffbit:(length(nA)+1))='0'; %use bitlength or t?
     Qs_Bitsize = length(Qs_pre);
end
   
   if length(Qs_pre)> nB+1
   Qs=Qs_pre(1:nB+1);
   elseif length(Qs_pre)< nB+1
     Qs(1:(nB+1)-length(Qs_pre))='0';
     Qs((nB+2)-length(Qs_pre):nB+1)=Qs_pre;
   else
       Qs=Qs_pre;
   end
    Qs_Bitsize = length(Qs);
%output needs to be n+1 bits.. use t and nA to enforce this
end


%   j=1;
%   while(j<=length(Qp))
%   if(Qp(i)=='1' || Qp(i)=='0')
%       
%   end
%    j=j+1;
%   end
