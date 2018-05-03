function [Q,Q_Bitsize] = ErrorCorrector(Qs, Qs_Bitsize)

%Qs_bitsize(n+1 bits) - 1 = n bits


%Finally,  the  error  correction  circuit  uses n OR  gates  to perform qi = qsi ? qsn,
% for i= 0,1,···, n?1, where qi and qsi are the ith LSBs of Q and Qs, respectively. 
%This circuit corrects the  erroneous  results  that  are  larger  than 2n?1(qsn= 1) to 
%2n?1(qsi= 1 for i= 0,1,···, n?1), which ensures that an n-bit approximate quotient is obtained.

%Basically if Qsn is 1.. then all of the LSBs (n-1 to 0) will be set to 1,
%since 1 ORd with anything is 1.

n=Qs_Bitsize-1;
if(Qs(n)==1)
    Q(1:n)='1';
else
    Q=Qs(2:length(Qs));
end

Q_Bitsize=length(Q);
end