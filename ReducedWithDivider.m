function [Qp, Qp_Bitsize] = ReducedWithDivider(Bp, Ap,k) %k bit output

%2 Different Divison Formulas (3) or (4), depending on the inequalities of La and
%Lb with 2k-1 and k-1 respectively..
%If Lb<k-1, formula (4)
%If Lb>k-1, formula (3)   
%REGARDLESS of La.. All four combinations of La/Lb formula choice depend on its Lb inequality.

%As the bit-width of the output for a 2k/k divider is k,
%overflow  occurs  when  the  quotient  is  larger  than 2k?1. This indicates that overflow is possible when using a
%2k/k divider to compute Ap/Bp even when there is no overflow for a 2n/n divider computing
%A/B. As per (2), the output of the reduced-width divider should use at least k+1 bits
%to  avoid  overflow.  Therefore,  the 2k-bit  pruned  dividend is  expanded  to (2k+ 2)-bit  
%by  adding  two  ‘0’s  at  the (2k+ 2)th and (2k+ 1)th bit positions; a ‘0’ is added to the(k+ 1)th
%bit  position  of  the  pruned  divisor.  Then,  a 2(k+ 1)/(k+ 1)divider is used to compute the division

Ap_Appended(1:2)='0';   %For the 2k+2 bits setup for divider to ensure we keep the ratio of bits and deduce a 2(k+1)/k+1 bit quotient
Ap_Appended(3:(length(Ap)+2))=Ap; 
 
Bp_Appended(1)='0';  %For the k+1 bits setup for divider
Bp_Appended(2:(length(Bp)+1))=Bp; 
 

Qp_unreduced= f_d2b((f_b2d(Ap_Appended))./(f_b2d(Bp_Appended)));

Qp=Qp_unreduced(1:k+1);

decimal=0;
i=1;
while(i<=length(Qp))
         if(Qp(i)=='.')
             decimal=1;
         end
   i=i+1;
end

if(decimal==1)
Qp_Bitsize = (length(Qp)-1);
else
Qp_Bitsize = length(Qp);
end

end