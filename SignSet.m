function [Q, Q_Bitsize] = SignSet(Q_abs, sign)
  
if(sign=='0') 
      Q(1)='0';     %positive
      Q(2:length(Q_abs)+1)=Q_abs;

else
    Q(1)='1'; %negative
    i=2;
     Q(2:(length(Q_abs)+1))='0';
while i<=length(Q_abs)
    if Q_abs(i-1)=='1'
        Q(i)='0';
        elseif Q_abs(i-1)=='0' 
        Q(i)='1';
    end
   i=i+1;
end
    
end  
     
Q_Bitsize = length(Q)-1; %ignore decimal place when counting bitsize
end

% Q(1)=1; %Negative
%        Q(2:length(Q_abs))=bitcmp(Q_abs); %bitwise complement of the Q_abs bit values