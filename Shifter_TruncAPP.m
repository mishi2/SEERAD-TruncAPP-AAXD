function [Q_abs, Q_abs_Bitsize,i] = Shifter_TruncAPP(XAtDIVXBt, ka_Index, kb_Index,t,nA) %Must be barrel shifter
   %output needs to be 2n+2t-4 bits use t and nA to enforce this
    a=ka_Index-kb_Index;
    
    i=1; %If  XAtDIVXBt contains a fraction, i is the index of the decimal '.' append this and bits to the right to the end of the bitshifter integer part. 
decimal=0;
while i<=length(XAtDIVXBt)
    
       if XAtDIVXBt(i)=='.'
             decimal=1;
             break
       end
   i=i+1;
end
    
    if decimal==0
     Q_abs_shift= f_d2b(bitshift(f_b2d(XAtDIVXBt),(a)));
    else
        Q_abs_shift=f_d2b(bitshift(f_b2d(XAtDIVXBt(1:i-1)),(a)));
        b=length(Q_abs_shift);
        Q_abs_shift(b-a+1:b)=XAtDIVXBt(i+1:i+a);
        Q_abs_shift(b+1)='.';
        d=i+a+1;
        Q_abs_shift(b+2:b+1+length(XAtDIVXBt(d:length(XAtDIVXBt))))=XAtDIVXBt(d:length(XAtDIVXBt));
%         i
%         a
%         d
%         length(b+2:b+1+(length(XAtDIVXBt(d:length(XAtDIVXBt)))))
%         length(XAtDIVXBt(d:length(XAtDIVXBt)))
        %Q_abs_shift(b+1:(length(XAtDIVXBt)-i))= XAtDIVXBt(i:length(XAtDIVXBt));
    end
        
    c = length(Q_abs_shift);
    Q_abs=Q_abs_shift;  % This will be Q_abs if XAtDIVXBt initially contained decimal fraction
    
    
    %%%%%%THIS ENDS DECIMAL FRACTION CASE Assignment for Q_abs%%%%%%%%%%%%%%%%
    if (a)>0 %Shift Left
     
        if decimal==0
     Q_abs((c-a+2):(c+1))=Q_abs_shift((c-a+1):c); %Shifts new )'s one bit to the right before replacing the initial position with a '.'
     Q_abs(c-a+1)='.';   %Replaces the bit to the right of the original LSB bit with a decimal '.'
        end
%     else %If a is negative and we shift to the right
    else  %Shift Right
        
        if decimal==1  % Worked at 0 but changed to 1, may have been error
       shifted=XAtDIVXBt(length(XAtDIVXBt)-(a-1):length(XAtDIVXBt));  % Since we will lose bits from shifting right, retrieve them from the input, add a decimal to the front, and append it to the end of Q_abs 
    append_bits(1)='.';
     append_bits(2:length(shifted)+1)=shifted;  
     Q_abs((c+a+1):(c+a+length(append_bits)))=append_bits;
        end
    end
    Q_abs_Bitsize = length(Q_abs);
end

% function [Q_abs, Q_abs_Bitsize,AXD_zeros,i] = Shifter(AXD, AXD_Bitsize, K, L) %MUST BE BARREL SHIFTER
%     %AXD((AXD_Bitsize+1):(AXD_Bitsize+1+L))='0'; 
%    
%     [z,y,k,i] = Rounding(AXD); %%To find bit position of the msb so we know who many zeros are in front that we have to maintain
%     a=K+L;
%     AXD_zeros=i-1; %how many zeros before the msb in AXD
%     Q_abs_shift= f_d2b(bitshift(f_b2d(AXD),-a)); %IS THIS RESPECTING THE BARREL SHIFT PROCESS??
%     c=length(Q_abs_shift);
%     Q_abs(1:AXD_zeros+a)='0';
%     %lQ= length(Q_abs);
%     Q_abs(a+1+AXD_zeros:(c+a+AXD_zeros))=Q_abs_shift;
%     
%     if (K+L)>0  %K+L will never be negative or 0
% %     Q_abs((c-a+1):(c+1))=Q_abs_shift((c-a):c); %Shifts new )'s one bit to the right before replacing the initial position with a '.'
% %     Q_abs(c-a)='.';   %Replaces the bit to the right of the original LSB bit with a decimal '.'
% %     else %If K+L is negative and we shift to the left (because of division, its inverted)
%     shifted=AXD(AXD_Bitsize-(K+L-1):AXD_Bitsize);  % Since we will lose bits from shifting right, retrieve them from the input, add a decimal to the front, and append it to the end of Q_abs 
%     append_bits(1)='.';
%     append_bits(2:length(shifted)+1)=shifted;
%     %Q_abs((length(Q_abs_shift)+1):(length(Q_abs_shift)+length(append_bits)))=append_bits(1:length(append_bits));
%     Q_abs((c+a+AXD_zeros+1):(c+a+AXD_zeros+length(append_bits)))=append_bits;
%     end
%     %Q_abs=  circshift(AXD,-(K+L));
%     Q_abs_Bitsize = length(Q_abs)-1;  %dont count the decimal place for the bitsize
% end
% 
% 
% % % Q_abs_shift= f_d2b(bitshift(bi2de(AXD),(K+L))); %IS THIS RESPECTING THE BARREL SHIFT PROCESS??
% %     c=length(Q_abs_shift);
% %     if((K+L)>0)
% %     Q_abs=Q_abs_shift;
% %     Q_abs((c-a+1):(c+1))=Q_abs_shift((c-a):c); %Shifts new )'s one bit to the right before replacing the initial position with a '.'
% %     Q_abs(c-a)='.';   %Replaces the bit to the right of the original LSB bit with a decimal '.'
% %     else %If K+L is negative and we shift to the right
