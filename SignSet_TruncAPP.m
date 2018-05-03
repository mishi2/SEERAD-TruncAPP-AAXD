function [Q_app, Q_Bitsize] = SignSet_TruncAPP(Q_abs, sign)
  
if(sign=='0') %Positive
      Q_app(1)=0;
      Q_app(2:length(Q_abs))=Q_abs;

 else Q_app(1)=1; %Negative
      Q_app(2:(length(Q_abs)+1))='0';
     
      i=2;
while(i<=length(Q_abs))
    if(Q_abs(i-1)=='1')
        Q_app(i)='0';
    elseif(Q_abs(i-1)=='0') 
        Q_app(i)='1';
    end
   i=i+1;
end
 
     %Q(2:length(Q_abs))=bitcmp(Q_abs); %bitwise complement of the Q_abs bit values
end  
     
Q_Bitsize = length(Q_app);
end