function [XAt,XBt] = TruncationUnit(Ka,Kb,A_app, B_app,t)

XA=f_d2b(bin2dec(A_app)./bin2dec(Ka)); % Will always be between 1 and 2

XB=f_d2b(bin2dec(B_app)./bin2dec(Kb)); % Will always be between 1 and 2

XAt=XA(1:(t+1));   %the extra 'bit' is for the . index 

XBt=XB(1:(t+1));
%f_d2b converts the final decimal result back into a string of the
%fractional binary format. i.e. '1001.1101'
end