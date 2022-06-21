function [ac,bc,cc,dc]=tfmotor2(Tn,Tm,Kpn,Tsigman,Ra,beta,alpha,Ce)
%copyright 2022 @多韭 
%此程序遵循GPL3.0协议,不得使用于商业，转载需说明出处。
%精简过的系统模型 子程序
n1=1;
d1=1/alpha;
n2=[alpha*Kpn*Tn alpha*Kpn];
d2=[beta*Tn*Tsigman  beta*Tn 1];
n3=1;
d3=1;
n4=Ra;
d4=[Ce*Tm 1];
n5=1;
d5=1;

nblocks=5;
blkbuild;
q=[1 0 0 0
    2 1 -5 0
    3 0 0 0
    4 2 -3 0
    5 4 0 0
    ]
    inputs=[1 3] ;
    outputs=5;
    [ac,bc,cc,dc]=connect(a,b,c,d,q,inputs,outputs);
end

