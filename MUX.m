function [Ap, Bp, Ap_Bitsize, Bp_Bitsize] = MUX(A, La, B, Lb, k) %2k Bit Output vs K bit output
%Constraints: if Lb<k-1: 
%2different pruning schemes: one for A and one for B 
%If La(Lb) > 2k-1(k-1) Use Fig 3 Pruning Scheme
%If La(Lb) < 2k-1(k-1) Use Fig 4 Pruning Scheme

%As the bit-width of the output for a 2k/k divider is k,
%overflow  occurs  when  the  quotient  is  larger  than 2k?1. This indicates that overflow is possible when using a
%2k/k divider to compute Ap/Bp even when there is no overflow for a 2n/n divider computing
%A/B. As per (2), the output of the reduced-width divider should use at least k+1 bits
%to  avoid  overflow.  Therefore,  the 2k-bit  pruned  dividend is  expanded  to (2k+ 2)-bit  
%by  adding  two  ‘0’s  at  the (2k+ 2)th and (2k+ 1)th bit positions; a ‘0’ is added to the(k+ 1)th
%bit  position  of  the  pruned  divisor.  Then,  a 2(k+ 1)/(k+ 1)divider is used to compute the division

if (La>((2*k)-1))    % Fig 3 Pruning Scheme -- Truncation required     
Ap= A((length(A)-La):((length(A)-La)+(2*k)));  %Truncated bits

else          % Fig 4 Pruning Scheme --- Appending Required
Ap= A((length(A)-La):length(A));   %No binary Decimals yet   
   if ((length(A)+1)<(2*k))
   Ap((length(A)+1):(2*k))='0';    %Appended Bits 
   end
   if ((length(A)+1)==(2*k))
   Ap((2*k))='0'; 
   end

end 

Ap_Bitsize = length(Ap);

%Divisor Pruning
if(Lb>(k-1))  % Fig 3 Pruning Scheme -- Truncation required
Bp= B((length(B)-Lb):((length(B)-Lb)+k));  %Truncated bits

else             % Fig 4 Pruning Scheme --- Appending Required
 Bp = B((length(B)-Lb):length(B));
  if (length(Bp+1)<k)
  Bp((length(B)+1):k)='0';    %Appended Bits 
  end
   if ((length(B)+1)==k)
   Bp(k)='0'; 
   end
 
end
Bp_Bitsize= length(Bp);
end