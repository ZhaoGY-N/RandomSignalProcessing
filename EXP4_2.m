clear all;
clc

N = 10000;
tmax = 0.5;
fs = N/tmax;

t = (0:N-1)*(1/fs);

x = sin(1e3*2*pi*t)+sin(2e3*2*pi*t)+normrnd(0,1,1,N);

figure(10)
plotMany(x,t,N,fs);

%wp和ws分别是通带和阻带的频率(截止频率)。当wp和ws为二元矢量时，为带通或带阻滤波器，这时求出的Wn也是二元矢量；当wp和ws为一元矢量时，为低通或高通滤波器：当wp<ws时为低通滤波器，当wp>ws时为高通滤波器。
%wp和ws为二元矢量
wp = [900/(fs/2),1100/(fs/2)];                %设置通带频率，注意进行归一化
ws = [500/(fs/2),1500/(fs/2)];                %设置阻带频率

% 这两个滤波器设计成低通和高通都会把大量的噪声留下，所以还是设计成带通比较合适

Rp=1;                                   %设置通带波纹系数
Rs=20;                                  %设置阻带波纹系数

%巴特沃斯滤波器设计
[n,Wn]=buttord(wp,ws,Rp,Rs);
%求巴特沃斯滤波器阶数，输出参数N代表满足设计要求的滤波器的最小阶数，Wn是等效低通滤波器的截止频率
%无论是高通、带通和带阻滤波器，在设计中最终都等效于一个截止频率为Wn的低通滤波器
fprintf('巴特沃斯滤波器 N= %4d\n',n);    %显示滤波器阶数

[b1,a1]=butter(n+1,Wn);               %求巴特沃斯滤波器系数，即求传输函数的分子和分母的系数向量

x_a=filter(b1,a1,x);                 % 经过低通滤波器之后的时域波形


% 滤波器相关的部分
figure(1)
freqz(b1,a1,N,fs);                % 求滤波器的幅频特性
subplot(2,1,1)
xlim([0 2500])
subplot(2,1,2)
xlim([0 2500])
figure(2)
impz(b1,a1);                      % 滤波器的单位冲击响应

figure(3)
plotMany(x_a,t,N,fs);

%wp和ws分别是通带和阻带的频率(截止频率)。当wp和ws为二元矢量时，为带通或带阻滤波器，这时求出的Wn也是二元矢量；当wp和ws为一元矢量时，为低通或高通滤波器：当wp<ws时为低通滤波器，当wp>ws时为高通滤波器。
%wp和ws为二元矢量
wp = [1800/(fs/2),2200/(fs/2)];                %设置通带频率，注意进行归一化
ws = [1500/(fs/2),2500/(fs/2)];                %设置阻带频率

Rp=1;                                   %设置通带波纹系数
Rs=20;                                  %设置阻带波纹系数

%巴特沃斯滤波器设计
[n,Wn]=buttord(wp,ws,Rp,Rs);
%求巴特沃斯滤波器阶数，输出参数N代表满足设计要求的滤波器的最小阶数，Wn是等效低通滤波器的截止频率
%无论是高通、带通和带阻滤波器，在设计中最终都等效于一个截止频率为Wn的低通滤波器
fprintf('巴特沃斯滤波器 N= %4d\n',n);    %显示滤波器阶数

[b2,a2]=butter(n+1,Wn);               %求巴特沃斯滤波器系数，即求传输函数的分子和分母的系数向量
% 滤波器相关的部分
figure(4)
freqz(b2,a2,N,fs);                % 求滤波器的幅频特性
subplot(2,1,1)
xlim([1000 3000])
subplot(2,1,2)
xlim([1000 3000])
figure(5)
impz(b2,a2);                      % 滤波器的单位冲击响应

x_b=filter(b2,a2,x);                 % 经过高通滤波器之后的时域波形

figure(6)
plotMany(x_b,t,N,fs);

x_c = zeros(1,length(x));
for i = 1:length(x)
    x_c(i) = squareLaw(x(i));
end

figure(7)
plotMany(x_c,t,N,fs);

y = x_a+x_b+ x_c;

figure(8)
plotMany(y,t,N,fs);

