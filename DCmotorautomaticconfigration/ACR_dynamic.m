function [sys,x0,str,ts,simStateCompliance] = ACR_dynamic(t,x,u,flag,Kii,Kpi)
% t：时间，就是一个增加的量，比如仿真时间0-0.2s，t就从0增加到0.2，就是我们一般认知上的仿真时间。这个量可以连续地与仿真时间一一对应，也可以是以离散形式对应。
% x：状态量。 
% u：输入量。状态方程中的输入。
% flag：标志%

switch flag,

  case 0,
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;
  
  case {1,2,4,9},
    sys=[];   %标志位2 4 9 暂时用不到

  case 3,
    sys=mdlOutputs(t,x,u);

  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes

% 为 size 结构调用 simsizes，将其填入并将其转换为 sizes 数组。

%请注意，在此示例中，这些值是硬编码的。 这不是一个
% 推荐的做法，因为块的特性通常是
% 由 S-Function 参数定义。
sizes = simsizes;

sizes.NumContStates  =0;   %连续变量的个数
sizes.NumDiscStates  = 0;   %离散变量的个数
sizes.NumOutputs     = 1;   %输出的变量的维数
sizes.NumInputs      = 2;   %输入的变量的维数
sizes.DirFeedthrough = 1;   %输出变量的关系式中是否直接出现u，是1，否0 
sizes.NumSampleTimes = 0;   % 采样时间个数at least one sample time is needed

sys = simsizes(sizes);

x0  = [];   %状态量的初值，没有就是空

str = [];   %总是空数组

ts  = [];   %【采样时间，偏移量】

simStateCompliance = 'UnknownSimState';
function sys=mdlOutputs(t,x,u,Kpi,Kii)
load('result.mat');
error=u(1);
ierror=u(2);
ut=Kpi*error+Kii*ierror;
sys(1)=ut;
