function speed_ctrl_sysbench(ac,bc,cc,dc)
%copyright 2022 @多韭 
%此程序遵循GPL3.0协议,不得使用于商业，转载需说明出处。
%系统评估 主程序
sys=ss(ac,bc,cc,dc);
sys=minreal(sys);

ctrlable=ctrb(ac,bc);
[mc,nc]=size(ctrlable);
i=min(mc,nc);
rank(ctrlable);
if i==rank(ctrlable)
    disp('系统能控')
else disp('系统不能控')
end

obsveable=obsv(ac,cc);
[mo,no]=size(obsveable);
i=min(mo,no);
rank(obsveable);
if i==rank(obsveable)
    disp('系统能观')
else disp('系统不能观')
end
disp('IN1：扰动，IN2：被控量')
disp(' 阶跃响应与波特图展示')
figure(1)
subplot(2,1,1);
step(sys)
subplot (2,1,2);
bode(sys)
end
