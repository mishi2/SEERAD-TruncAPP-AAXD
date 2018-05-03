function [XBt_Inverse, XBt_Inverse_Bitsize] = InverseUnit(XBt,t)

XBtplsone=f_b2d(XBt)+1;

XBtplsone_bin=f_d2b(XBtplsone);

i=1;
decimal=0;
while(i<=length(XBtplsone_bin))
    if(XBtplsone_bin(i)=='1')
        XBtplsone_bin(i)='0';
    end
    if(XBtplsone_bin(i)=='0') 
        XBtplsone_bin(i)='1';
    end
         if(XBtplsone_bin(i)=='.')
             decimal=1;
         end
   i=i+1;
end
 %bits have been flipped now convert back to dec to divide by 2 then
    %convert back to binary
 XB_Inverse_Dec=f_b2d(XBtplsone_bin)./2;
XB_Inverse=f_d2b(XB_Inverse_Dec);

if(decimal==1)
XBt_Inverse=XB_Inverse(1:t+1);  %to account for the '.' in the binary string
XBt_Inverse_Bitsize = (length(XBt_Inverse)-1);
else
XBt_Inverse=XB_Inverse(1:t);
XBt_Inverse_Bitsize = (length(XBt_Inverse);
end