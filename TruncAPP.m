clc;
clear all;
%TruncAPP High Level Implementation Code the input bit length N, truncation length t, and inputs a(dividend) b(divisor) are the simulation parameters
%4 FUNCTIONS ARE Identically From SEERAD IMPLEMENTATION%
% (A/B)app = 2^ Ka-Kb X (Xa)t X (1/(Xb)t)app



%CREATE PARAMETERS FIRST (A,B, n,t)   (n MAY NOT be needed to be a
%parameter.. could be implicit from given inputs. May be more
%efficient/accurate however to make it output of the first sign detection function:
A='00110101';  %Makesure bitsize are the same
B='00001101';  %Makesure bitsize are the same
t=6; %truncation length






%Block1_SignDetector -- functions to represent each block of circuit diagram.
% Inputs: A, B (n bits)    Outputs: [A] and [B] absolute value (n-1 bits)
%Compares inputs' MSBs, compares them (same = positive,
% different=negative), and truncates the sign msb to yield absolute values
% [A] and [B]
[A_app,B_app,sign, nA,nB]=SignDetector(A,B); %nA and nB are the bitsizes of the inputs


%Block2_Rounding(Leading One Detector Unit) -- Inputs(n-1 bits): [A] and [B] %
%Output: Ka and Kb (All Bits after the MSb '1' set to zero)
%Basically the floor minimum value of B looking at only the MSB, 0s follow
%the msb.. Same rounding function from seerad, but as opposed to seerad, this output is derived for both the
%dividend and the divisor... NEED to run this function twice, once for each operand ([A] and [B]).
[Ka, Ka_bitsize, ka_Index] = Rounding(A_app);   %Ka is the log2(2n) representation of the MSB position K
[Kb, Kb_bitsize, kb_Index] = Rounding(B_app);


%Block3_TruncationUnit -- Inputs(n-1 bits): Ka,Kb,[A],[B]  Outputs(t bits):
%[Xa]t and [Xb]t in Decimal format
%Truncation Formula is: t[i] = V(from J=0 to j=n-1) (K[j] AND I[j+i-(t-1)]) for i<t
%This will give the outputs of the LSBs of the A's and B's bits with a
%scaled value of between 1-2. X will be 1 if all the lsbs are 0, and X will
%be Close to 2 if all the LSBs are 1.. and the values in between 1 and 2
%for mixtures of 1's and 0's for LSBs.
%XAt and XBt will be in t-bit string binary representation of the integer and
%fraction parts.
[XAt,XBt,XAt_Bitsize,XBt_Bitsize] = TruncationUnit(Ka,Kb,A_app, B_app,t);

%Block4_InverseUnit -- Input(t bits): [Xb]t     Output(t bits): 1/[Xb]t
%B inversion: (1/(Xb)t)app  = Bit-Inverse(Xb + 1) / 2 this is the inverse
%formula used by the designers to invert Xb without using division.. small error is yielded
[XBt_Inverse,XBt_Inverse_Bitsize] = InverseUnit(XBt,t); %Binary String Inversion using design approximate formula

%XBt_Inverse_Bitsize is to check the inverse is still t bits

%Block5_Multiplier -- Inputs(t bits): [Xa]t and 1/[Xb]t  Outputs: 2t bits product of ([Xa] X 1/[Xb]) 
%Bitwise multiplication of dividend factor [Xa] with inverse divisor factor 1/[Xb] 
[XAtDIVXBt, XAtDIVXBt_Bitsize] = multiplier_TruncAPP(XBt_Inverse, XAt,t); %Yields [Xa] X 1/[Xb]


%Block6_ShiftUnit  -- Input(2t bits):  [Xa]t/[Xb]t  and ka and kb    
%Output(2n+2t-4 bits): (2^(Ka-Kb) X [Xa]t)/[Xb]t 
%The  output  of  the  Multiplication  unit  should  be  shifted  to  the  right  by  
% Kb-Ka or be shifted to the left by Ka-Kb depending on which value is
% greater in  the  Shift  unit.  
%*** Might Be able to interchangeably use Block4 SEERAD Multiplier for this Function.***%
[Q_abs, Q_abs_Bitsize,i] = Shifter_TruncAPP(XAtDIVXBt, ka_Index, kb_Index,t,nA);
%Q_abs_Bitsize needs to be 2n+2t-4 bits use t and nA to enforce/ check this.

%Block7_SignSet -- Input (2n+2t-4 bits): (2^(Ka-Kb) X [Xa]t)/[Xb]t
%Output((2n+2t-3 bits): (A/B)app  
%Finally,  the  Sign  unit  fixes  the  sign  of  the  final  
%output.  If  the  divider  input  operands  have  the  same  sign,  this  
%unit passes its input to the output. In the other case, the bits of 
%the input is inverted and passed to the output. 
[Q_app, Q_Bitsize] = SignSet_TruncAPP(Q_abs, sign);
Q_app
Q_app_dec=f_b2d(Q_app)



%Error
ADivB_Exact=(f_b2d(A)./f_b2d(B))
ADivB_Exact_bin=f_d2b((f_b2d(A)./f_b2d(B)))
MRE= abs(f_b2d(Q_app)-ADivB_Exact)/ADivB_Exact %MRE in Decimal format