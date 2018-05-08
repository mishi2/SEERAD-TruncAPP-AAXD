function [XAtDIVXBt, XAtDIVXBt_Bitsize] = multiplier_TruncAPP(XBt_Inverse, XAt,t)
  
XADIVXB = f_d2b(f_b2d(XAt).*f_b2d(XBt_Inverse));
   %i = i+1;     
   if (length(XADIVXB)>=(2*t+1))
   XAtDIVXBt=XADIVXB(1:(2*t+1));
   else
      XAtDIVXBt=XADIVXB;
       XAtDIVXBt(((2*t+1)-length(XADIVXB)):(2*t+1))='0';
   end 
       XAtDIVXBt_Bitsize = length(XAtDIVXBt);
      
    end    