 clc;
 clear all;
%AAXD Adaptive Approximation High Level Implementation: the inputs
%a(dividend) b(divisor) are the simulation parameters as well as the desired reduced bit width of truncation (k).
%For when Lb > k-1 : (A/B)app = [Ap/Bp]2^(La-Lb-k)
%For when Lb < k-1 : (A/B)app = (a(la-1)....a(la-2k+1)2)/((b(k-1)...b0)2)

%Different from multiplication  and addition, the inputs of division have a strict range requirement. In a
%2n/n divider,  the n most  significant  bits  (MSBs)  of  the  dividend A
%must be smaller than the divisor B to guarantee that no overflow occurs [1].

%CREATE PARAMETERS FIRST (A,B,k): 
%%UNSIGNED OPERANDS ONLY%%
A='001101011110111011'; %2n
B='010001111';  %n
nA=length(A);
nB=length(B);
k=8; %The reduced width bit for tuncation and divider 2(k+1)/k+1





%Block1_LOPD --  INPUT(2n(dividend) and n(divisor) bits): A and B
%OUTPUT(LogBase2(2n) (or LogBase2(n) for divisor) bits): La and Lb
%Similar to SEERAD and TRUNCAPP Leading detector, but needs output a LogBase2(2n) (or LogBase2(n) for divisor) bit number which is equal to the index
%of the leading MSB. SEERAD and Truncapp leave the original bit format and
%sets all lsbs to 0. Need to clone and adjust AAXD version.
[Ka, Ka_bitsize, La] = Rounding(A);   %La is the log2(2n) representation of the MSB index position in decimal value
[Kb, Kb_bitsize, Lb] = Rounding(B);


%Block2_MUX -- INPUT: A,La,  B,Lb (Different MUX for A and B)  and k
%OUTPUT: Ap (2k bits) for A and Bp (k bits) for B
%depending on parameter k, and how the input compares with the individual
%constraints, LSBs will be truncated if they are > 2k for dividend or >k 
%for divisor... or  if  the number  of  remaining  LSBs  is  smaller 
%than 2k for  the  dividend or k for  the  divisor,  ‘0’s are  appended  to  the  LSBs  of  the  input.

%The Main GOAL HERE IS TO HAVE A 2K bit Dividend and a K bit Divisor as output of the MUX.%
[Ap, Bp, Ap_Bitsize, Bp_Bitsize] = MUX(A, La, B, Lb, k);

%Block3_Divider(2(k+1)/(k+1)) -- Input(2k bit Dividend and K bit Divisor): Ap and Bp  
%Output(k+1 bit Quotient): Qp
%This Performs Regular Divison of the Pruned-Bit Division operands to yield Qp.
[Qp, Qp_Bitsize] = ReducedWithDivider(Bp, Ap,k);

%Block4_Subtractor -- Input(LogBase2(2n) bits): La and Lb    OUTPUT(LogBase2(2n)+1 bits): La-Lb 
%this is used to shift the quotient in the next block
La_minus_Lb = La-Lb;


%Block5_Shifter -- Inputs(LogNase2(2n)+1 bit and k+1 bit): (La-Lb) and Qp
%OUTPUT(n+1 bit):Qs
%Barrel Shift Qp to the left or right depeneding on La-Lb subtraction.
%Qs_Bitsize needs to be 2n+2t-4 bits use t and nA to enforce/ check this.
[Qs, Qs_Bitsize] = Shifter_AAXD(Qp,La_minus_Lb,k,nB);

%Block6_ErrorCorrection -- Input(n+1 bit):Qs   OUTPUT(n bit): Q

%An error correction circuit using OR gates is utilized for achieving
% a high accuracy at a very small hardware overhead. Compared  with the
%exact 16/8 array  divider,  the  proposed adaptive approximation-based 
%divider (denoted as AAXD) using an 8/4 divider  achieves  a  speedup by  
% 60.51%,  a  reduction  in power  dissipation  by  65.88%  and  in  area  
% by 38.63%.  For  a more  accurate  configuration  using  a 12/6 divider,  
%the  AAXD is  26.54%  faster  and  34.13%  more  power  efficient  than  the accurate  design
[Q,Q_Bitsize] = ErrorCorrector(Qs, Qs_Bitsize);
Q
Q_dec=f_b2d(Q)

%Error
ADivB_Exact_bin=f_d2b((f_b2d(A)./f_b2d(B)))
ADivB_Exact=(f_b2d(A)./f_b2d(B))
MRE= abs(Q_dec-ADivB_Exact)/ADivB_Exact %MRE in Decimal format