function [Bf, Bf_bitsize, K,i] = Rounding(B_abs)


i=1;
while i<length(B_abs)
if B_abs(i)=='1'
    B_abs((i+1):length(B_abs))='0';  %Floor Rounding LSBs
    K=length(B_abs)-i;  %The Bit position (from LSB) that the MSB 1 is located in (Decimal value) : Counting from 0-7 (2^k) change to 1-8 if need be..
    Bf=B_abs((i):length(B_abs));   
    break
end
i = i+1;
end
Bf_bitsize= length(Bf);

end