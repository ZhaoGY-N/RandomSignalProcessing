clear all;
clc

N = 50000;
tmax = 0.25;
fs = N/tmax;

t = (0:N-1)*(1/fs);

x = square(1e3*2*pi*t)+randn(1,N);
figure(10)
plotMany(x,t,N,fs);


%wp和ws分别是通带和阻带的频率(截止频率)。当wp和ws为二元矢量时，为带通或带阻滤波器，这时求出的Wn也是二元矢量；当wp和ws为一元矢量时，为低通或高通滤波器：当wp<ws时为低通滤波器，当wp>ws时为高通滤波器。
%wp和ws为二元矢量
wp = [800/(fs/2),1200/(fs/2)];                %设置通带频率，注意进行归一化
ws = [200/(fs/2),1800/(fs/2)];                %设置阻带频率

% 这两个滤波器设计成低通和高通都会把大量的噪声留下，所以还是设计成带通比较合适

Rp=1;                                   %设置通带波纹系数
Rs=20;                                  %设置阻带波纹系数

%巴特沃斯滤波器设计
[n,Wn]=buttord(wp,ws,Rp,Rs);
%求巴特沃斯滤波器阶数，输出参数N代表满足设计要求的滤波器的最小阶数，Wn是等效低通滤波器的截止频率
%无论是高通、带通和带阻滤波器，在设计中最终都等效于一个截止频率为Wn的低通滤波器
fprintf('巴特沃斯滤波器 N= %4d\n',n);    %显示滤波器阶数

[b1,a1]=butter(n,Wn);               %求巴特沃斯滤波器系数，即求传输函数的分子和分母的系数向量

x_a=filter(b1,a1,x);                 % 经过低通滤波器之后的时域波形


% 滤波器相关的部分
figure(1)
freqz(b1,a1,0.2*N,fs);                % 求滤波器的幅频特性
subplot(2,1,1)
xlim([0,1e4]);
ylim([-100,10]);
subplot(2,1,2)
xlim([0,1e4]);
figure(2)
impz(b1,a1);                      % 滤波器的单位冲击响应

figure(3)
plotMany(x_a,t,N,fs);

x_b = zeros(1,length(x_a));
for i = 1:length(x_a)
    x_b(i) = squareLaw(x_a(i));
end

figure(4)
plotMany(x_b,t,N,fs);

%wp和ws分别是通带和阻带的频率(截止频率)。当wp和ws为二元矢量时，为带通或带阻滤波器，这时求出的Wn也是二元矢量；当wp和ws为一元矢量时，为低通或高通滤波器：当wp<ws时为低通滤波器，当wp>ws时为高通滤波器。
%wp和ws为二元矢量
wp = [800/(fs/2),3200/(fs/2)];                %设置通带频率，注意进行归一化
ws = [200/(fs/2),3800/(fs/2)];                %设置阻带频率

Rp=1;                                   %设置通带波纹系数
Rs=20;                                  %设置阻带波纹系数

%巴特沃斯滤波器设计
[n,Wn]=buttord(wp,ws,Rp,Rs);

%求巴特沃斯滤波器阶数，输出参数N代表满足设计要求的滤波器的最小阶数，Wn是等效低通滤波器的截止频率
%无论是高通、带通和带阻滤波器，在设计中最终都等效于一个截止频率为Wn的低通滤波器
fprintf('巴特沃斯滤波器 N= %4d\n',n);    %显示滤波器阶数

[n,Wp] = cheb1ord(wp,ws,Rp,Rs);
[b2,a2] = cheby1(n,Rp,Wp);

% [b2,a2]=butter(n,Wn);               %求巴特沃斯滤波器系数，即求传输函数的分子和分母的系数向量

% 滤波器相关的部分
figure(5)
freqz(b2,a2,N,fs);                % 求滤波器的幅频特性
subplot(2,1,1)
xlim([0,1e4]);
ylim([-100,10]);
subplot(2,1,2)
xlim([0,1e4]);
figure(6)
impz(b2,a2);                      % 滤波器的单位冲击响应

x_c=filter(b2,a2,x);                 % 经过高通滤波器之后的时域波形
figure(7)
plotMany(x_c,t,N,fs);

y = x_b+x_c;
figure(8)
plotMany(y,t,N,fs);
