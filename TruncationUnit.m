function [XAt,XBt,XAt_Bitsize,XBt_Bitsize] = TruncationUnit(Ka,Kb,A_app, B_app,t)

XA=f_d2b(f_b2d(A_app)./f_b2d(Ka)); % Will always be between 1 and 2

XB=f_d2b(f_b2d(B_app)./f_b2d(Kb)); % Will always be between 1 and 2

if length(XA)>(t+1) 
XAt=XA(1:(t+1));   %the extra 'bit' is for the . index  Truncate
else
XAt=XB;    
end

if length(XB)>(t+1)
XBt=XB(1:(t+1));
else
XBt=XB;    
end
%f_d2b converts the final decimal result back into a string of the
%fractional binary format. i.e. '1001.1101'

XAt_Bitsize=length(XAt)-1; %for decimal index subtract one
XBt_Bitsize=length(XBt)-1;
end