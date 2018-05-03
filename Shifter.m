function [Q_abs, Q_abs_Bitsize] = Shifter(AXD, AXD_Bitsize, K, L) %Must be barrel shifter
    AXD((AXD_Bitsize+1):(AXD_Bitsize+1+L))=0; 
   
    Q_abs= f_d2b(bitshift(f_b2d(AXD), -(K+L)));
    %Q_abs=  circshift(AXD,-(K+L));
    Q_abs_Bitsize = length(Q_abs);
end