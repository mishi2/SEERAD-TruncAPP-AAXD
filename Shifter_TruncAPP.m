function [Q_abs, Q_abs_Bitsize] = Shifter_TruncAPP(XAtDIVXBt, ka_Index, kb_Index,t,nA) %Must be barrel shifter
   %output needs to be 2n+2t-4 bits use t and nA to enforce this
    Q_abs= f_d2b(bitshift(f_b2d(XAtDIVXBt),(ka_Index-kb_Index)));
    Q_abs_Bitsize = length(Q_abs);
end