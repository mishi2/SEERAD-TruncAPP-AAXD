function [Q, Q_Bitsize] = SignSet(Q_abs, sign)
  
if(sign=='0')
      Q(1)=0;
      Q(2:length(Q_abs))=Q_abs;

 else Q(1)=1; %Negative
       Q(2:length(Q_abs))=bitcmp(Q_abs); %bitwise complement of the Q_abs bit values
end  
     
Q_Bitsize = length(Q);
end