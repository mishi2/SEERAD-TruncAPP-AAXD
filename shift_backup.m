if (La>((2*k)-1))    % Fig 3 Pruning Scheme -- Truncation required    
Ap(1:2)='0';   %For the 2k+2 bits setup for divider
Ap(3:(3+(2*k)))= A((length(A)-La):((length(A)-La)+(2*k)));  %Truncated bits

else          % Fig 4 Pruning Scheme --- Appending Required
Ap(1:2)='0';   %For the 2k+2 bits setup for divider    
Ap(3:length(a))= A((length(A)-La):length(A));   %No binary Decimals yet   
   if ((length(A)+3)<(2*k))
   Ap((length(A)+3):(2*k))='0';    %Appended Bits 
   end
   if ((length(A)+3)==(2*k))
   Ap((2*k))='0'; 
   end

end 

Ap_Bitsize = length(Ap);

%Divisor Pruning
if(Lb>(k-1))  % Fig 3 Pruning Scheme -- Truncation required
   Bp(1)='0';
    Bp(2:length((length(B)-Lb):((length(B)-Lb)+k))+1)= B((length(B)-Lb):((length(B)-Lb)+k));  %Truncated bits

else             % Fig 4 Pruning Scheme --- Appending Required
 Bp(1)='0';
    Bp(2:length((length(B)-Lb):(length(B)+1))) = B((length(B)-Lb):length(B));
  if (length(Bp+2)<k)
  Bp((length(B)+2):k)='0';    %Appended Bits 
  end
   if ((length(B)+2)==k)
   Bp(k)='0'; 
   end
 
end
Bp_Bitsize= length(Bp);
end