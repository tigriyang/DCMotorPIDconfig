function [Ce,Cm,n0,tn,J,If,Lf]=tuning(Un,In,Ra,Nn,GD2,Pf,Uf)
%copyright 2022 @多韭 
%bilibili找@底格里斯扬，不过一直懒得更新视频就是了
%此程序遵循GPL3.0协议,不得使用于商业，转载需说明出处。
%subfunction for config tuning
%参数估算子程序
%求Ke电磁常数Ke=Ce·ϕn 单位福特每转
Ce=(Un-In*Ra)/Nn ;
%求Kt转矩常数Kt=9.55·Ke
Cm=30/pi*Ce;
%求理想空载转速
n0=Un/Ce;
%求额定转矩
tn=30/pi*Ce*In;


%转子转动惯量
J=GD2/4/9.8;

%互感
If=Pf/Uf;
Lf=30*Ce/pi/If;
end









