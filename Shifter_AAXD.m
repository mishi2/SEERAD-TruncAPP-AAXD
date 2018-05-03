function [Qs, Qs_Bitsize] = Shifter_AAXD(Qp,La_minus_Lb,t,nA) %Must be barrel shifter
 

%aRE YOU SHIFTING rIGHT OR lEFT(adding or dropping bits)
%Is there a decimal fraction bits involved?%
%Cases:
%Right Shift non fraction
%Left Shift non fraction
%Right shift fraction
%Leftshift fraction

if(La_minus_Lb>0)
leftshift=1;
elseif(La_minus_Lb<0)
rightshift=1;
else
  noshift=1;
end

decimal=0;
i=1;
while(i<=length(Qp))
         if(Qp(i)=='.')
             decimal=1;
         end
   i=i+1;
end

if(decimal==1) %FRACTION%
  %% HOW TO SHIFT when Decimal/Fraction binary value 
  j=1;
  while(j<=length(Qp))
  if(Qp(i)=='1' || Qp(i)=='0')
      if(leftshift==1) %Leftshift fraction
      Qs
      end
  elseif(Qp(i)=='.')
      decimal_index=i;
  elseif(rightshift==1)  %Right shift fraction   
     
  end
   j=j+1;
  end
  
  
Qp_Bitsize = (length(Qp)-1);

elseif(leftshift==1) %Left Shift non fraction
Qs= f_d2b(bitshift(f_b2d(Qp),La_minus_Lb));

else  %Rightshift non fraction
    Qs= f_d2b(bitshift(f_b2d(Qp),La_minus_Lb));
Qp_Bitsize = length(Qp);
 bit_append_Qp = length(Qp);
    bit_append_Qs = length(Qs);
    diffbit=(bit_append_Qp-bit_append_Qs);
    Qs(diffbit:(length(nA)+1))='0'; %use bitlength or t?
end
   
   
    Qs_Bitsize = length(Qs);
%output needs to be n+1 bits.. use t and nA to enforce this
end
