%function [Kpi,Kii,Kpn,Kin]=construct(auto)
%copyright 2022 @多韭 
%控制系统仿真 课程设计
%此程序遵循GPL3.0协议,不得使用于商业，转载需说明出处。
%双闭环直流调速自动设计 主程序
%main program for DC speed control system automaticly designning program
%内置z4-132-1电机的demo
%intergrate the model of Z4-132-1 dc motor
%have fun ;)


[Un,Uf,Pn,Nn,Nf,In,Pf,Ra,La,GD2,Ts,Uom]=ManuFactureInf(1)
[Ce,Cm,n0,tn,J,If,Lf]=tuning(Un,In,Ra,Nn,GD2,Pf,Uf)
%机电惯性和电磁惯性计算
%电枢时间常数Tl=C/R
Tl=La/Ra;
Tm=GD2*Ra/375/Ce/Cm;

h=5;
Ks=Un/Uom;



%电流环配置计算
%1.
beta=Uom/1.5/In;

%滤波器常数等于1-2倍电源开关时间常数
Toi=Ts;
Tsigmai=Toi+Ts;
Ti=5*Tsigmai;


Kpi=(h+1)/(2*h)*Ra/Ks/beta*Tl/Tsigmai

KIi=Kpi*Ti*beta*Ks/Ti/Ra/Tl;


Kii=1/Ti
Tin=4*Tsigmai;
s=tf('s');
disp('电流环传递函数')
Wpii=Kpi*(1+Kii/s)
disp('电流环滤波器')
Wfi=1/(Tin*s+1)

Wopi=Wpii*Wfi;

%速度环配置计算
alpha=Uom/Nn;
Tsigman=2*Tsigmai;
Tn=h*Tsigman;

Kpn=(h+1)*beta*Ce*Tm/2/h/Ra/Tsigman/alpha

Kin=1/Tn
disp('速度环传递函数')
Wpn=Kpn*(1+Kin/s)
Ton=4*Tsigman;
disp('速度环滤波器')
Wfn=1/(Ton*s+1)
%记得pi调节器选择parllel，输入所有数据
%没有考虑测速发电机的时间常数速度环的影响，因为仿真用不到
[ac,bc,cc,dc]=tfmotor2(Tn,Tm,Kpn,Tsigman,Ra,beta,alpha,Ce)
disp('展示包括2IN1OUt系统的波特图，还有simulink环境下限流启动以及满负载静差展示')
speed_ctrl_sysbench(ac,bc,cc,dc)
save('result.mat')
%end
