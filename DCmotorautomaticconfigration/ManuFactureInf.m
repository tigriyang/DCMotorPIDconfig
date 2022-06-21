function [Un,Uf,Pn,Nn,NF,In,Pf,Ra,La,GD2,Ts,Uom]=ManuFactureInf(auto)

%copyright 2022 @多韭
%交流程序联系qq：1929533246
%此程序遵循GPL3.0协议,不得使用于商业，转载需说明出处。

%subfunction for input motor manufacture information
%电机铭牌信息子程序
confirm=0;
Un=-5000;        %电枢电压
Uf=-5000;       %励磁电压
Pn=-5000;        %额定功率
Nn=-5000 ;       %额定转速
NF=-5000  ;      %弱磁转速
In=-5000   ;     %额定电枢电流
Pf=-5000    ;    %励磁功率
Ra=-5000     ;   %电枢电阻
La=-5000      ;  %电枢回路电感
GD2=-5000      ; %惯量矩
Ts=-5000;        %电源时间常数
Uom=-5000;       %信号范围

situ=0   
while confirm==0
    
    switch situ
        case 0
            disp("电机参数将以Z4-132-1为例参与计算")
            %1.基础数据集
            Un=400;           %电枢电压
            Uf=180;           %励磁电压
            Pn=18.5;          %额定功率
            Nn=2610;          %额定转速
            NF=4000;          %弱磁转速
            In=52.2;         %额定电枢电流
            Pf=650;           %励磁功率
            Ra=0.368;         %电枢电阻
            La=5.3e-3;        %电枢回路电感
            GD2=0.32*9.8;     %惯量矩
            
            
            %2.补充数据集
            %电流滞后环节
            fs=8e+3;%pwm开关频率;
            Ts=1/fs;
            %如果用的是晶闸管，直接填入死区时间
            %Ts=
            
            Uom=10;%电流电压环节限流值
            if auto==1,confirm=1
            end
            
        case 1
            disp('请输入电机铭牌信息')
            Un=input('电枢电压为V');
            Uf=input('励磁电压为V');
            Pn=input('额定功率为Kw');
            Nn=input('额定转速rpm');
            NF=input('弱磁转速rpm');
            In=input('电枢电流A');
            Pf=input('励磁功率w');
            Ra=input('电枢电阻(OM)');
            La=input('电枢电感(H)');
            GD2=input('惯量矩(kg*m^20)');
            select=input("电源方案 1-相控 2-pwm控制");
            if select==1
                Ts=input('晶闸管的死区时间');
            elseif select==0
                fs=input('开关频率');
                Ts=1/fs
            else
                disp('无效输入，默认为8k的pwm控制')
                fs=8e+3%pwm开关频率
                Ts=1/fs
                Uom=input('请输入信号范围（Max-min）')
            end
    end
    
    disp('请确认当前电机的铭牌信息设定为：');
    disp('电枢电压为'),disp(Un);
    disp('额定功率为'),disp(Pn);
    disp('励磁电压为') ,disp(Uf);
    disp('额定转速'),disp(Nn);
    disp('弱磁转速'),disp(NF);
    disp('电枢电流'),disp(In);
    disp('励磁功率'),disp(Pf);
    disp('电枢电阻'),disp(Ra);
    disp('电枢电感'),disp(La);
    disp('惯量矩'),disp(GD2);
    disp('时间常数'),disp(Ts);
    disp('信号范围'),disp(Uom);
    confirm=input('输入1以继续，输入0重新输入完整数据');
    if confirm==0
        situ=1
    end
end
end