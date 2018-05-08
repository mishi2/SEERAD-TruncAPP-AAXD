function [XBt_Inverse, XBt_Inverse_Bitsize] = InverseUnit(XBt,t)

XBt_one=f_b2d(XBt)-1;  %Thhe paper seems to contradict adding/subtracting one

XBt_one_bin=f_d2b(XBt_one);

i=1;
% decimal=0;
while(i<=length(XBt_one_bin))
    if XBt_one_bin(i)=='1'
        XBt_one_bin(i)='0';
    
    elseif XBt_one_bin(i)=='0'
        XBt_one_bin(i)='1';
    end
         %if(XBt_one_bin(i)=='.')
            % decimal=1;
         %end
   i=i+1;
end
%XBt_one_bin %test
 %bits have been flipped now convert back to dec to divide by 2 then
    %convert back to binary
 XB_Inverse_Dec=f_b2d(XBt_one_bin)/2;
XB_Inverse=f_d2b(XB_Inverse_Dec);

%if decimal==1
    if length(XB_Inverse)> (t+1)
XBt_Inverse=XB_Inverse(1:t+1);
    else
        XBt_Inverse=XB_Inverse;
    end
    XBt_Inverse_Bitsize = (length(XBt_Inverse)-1);%to account for the '.' in the binary string
% else
%      if length(XB_Inverse)> (t+1)
% XBt_Inverse=XB_Inverse(1:t);
%      else
%          XBt_Inverse=XB_Inverse;
%      end
% XBt_Inverse_Bitsize = (length(XBt_Inverse));
end