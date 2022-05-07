clear all;
clc

Nraw = 20000;
N = 10000;
tmax = 0.5;
fs = N/tmax;

t = (0:N-1)*(1/fs);

x = sin(1e3*2*pi*t)+sin(2e3*2*pi*t)+sin(3e3*2*pi*t)+normrnd(0,1,1,N);
% x = 1*sin(2*pi*t)+3*sin(50*pi*t);


x_mean = mean(x); % 均值
x2_mean = mean(x.^2); % 均方值
[R_x,lag] = xcorr(x,N/2,'unbiased'); % 自相关函数
[p_x,xi] = ksdensity(x); % 概率密度
X = fft(x); % 频谱
G_x = fft(R_x); % 功率谱密度


%wp和ws分别是通带和阻带的频率(截止频率)。当wp和ws为二元矢量时，为带通或带阻滤波器，这时求出的Wn也是二元矢量；当wp和ws为一元矢量时，为低通或高通滤波器：当wp<ws时为低通滤波器，当wp>ws时为高通滤波器。

%wp和ws为二元矢量
wp=[1900/(fs/2),2100/(fs/2)];                %设置通带频率，注意进行归一化
ws=[1500/(fs/2),2500/(fs/2)];                %设置阻带频率

Rp=1;                                   %设置通带波纹系数
Rs=20;                                  %设置阻带波纹系数

%巴特沃斯滤波器设计
[n,Wn]=buttord(wp,ws,Rp,Rs);
%求巴特沃斯滤波器阶数，输出参数N代表满足设计要求的滤波器的最小阶数，Wn是等效低通滤波器的截止频率
%无论是高通、带通和带阻滤波器，在设计中最终都等效于一个截止频率为Wn的低通滤波器
fprintf('巴特沃斯滤波器 N= %4d\n',n);    %显示滤波器阶数

[b,a]=butter(n+1,Wn);               %求巴特沃斯滤波器系数，即求传输函数的分子和分母的系数向量

x_a=filter(b,a,x);                 % 经过带通滤波器之后的时域波形

% 限幅器直接使用循环实现
y_1 = zeros(1,max(size(x_a)));
ALimit = 0.3;
for i = 1:max(size(x_a))
    if x_a(i) > ALimit
        y_1(i) = ALimit;
    else
        if x_a(i) < -ALimit
            y_1(i) = -ALimit;
        else
            y_1(i) = x_a(i);
        end
    end
end

% 平方律
x_b = zeros(1,max(size(x)));
for i = 1:max(size(x))
    x_b(i) = squareLaw(x(i));
end

% 显示x的原始波形，自相关函数，频谱(幅度谱)，功率谱密度

figure(1)
subplot(2,2,1)
plot(t(1:400),x(1:400))
title("波形(部分)");
xlabel("t/s");
subplot(2,2,2)
tempx = lag/fs;
plot(tempx(round(end/2)-100:round(end/2)+100),R_x(round(end/2)-100:round(end/2)+100))
title("自相关函数(部分)")
xlabel("t/s")
subplot(2,2,3)
plotFFT(fft(x),fs);
title("频谱（幅度谱）")
xlim([-8000 8000])
subplot(2,2,4)
% [G_x,G_x_f] = pwelch(x,[],[],[],fs);
[G_x,G_x_f] = periodogram(x,[],[],fs);
plot(G_x_f(1:round(end*0.5)),G_x(1:round(end*0.5)));
title("功率谱密度") 
xlabel("f/Hz")

% 滤波器相关的部分
figure(4)
freqz(b,a,N,fs);                % 求滤波器的幅频特性
figure(5)
impz(b,a);                      % 滤波器的单位冲击响应

% 显示a的原始波形，自相关函数，频谱(幅度谱)，功率谱密度
figure(2)
subplot(2,2,1)
plot(t(1:400),x_a(1:400))
title("波形(部分)");
xlabel("t/s");
subplot(2,2,2)
[R_x_a,lag_a] = xcorr(x_a,N/2,'unbiased'); % 自相关函数
tempx = lag_a/fs;
plot(tempx(round(end/2)-100:round(end/2)+100),R_x_a(round(end/2)-100:round(end/2)+100))
title("自相关函数(部分)")
xlabel("t/s")
subplot(2,2,3)
plotFFT(fft(x_a),fs);
title("频谱（幅度谱）")
xlim([-8000 8000])
subplot(2,2,4)
% [G_x,G_x_f] = pwelch(x,[],[],[],fs);
[G_x_a,G_x_a_f] = periodogram(x_a,[],[],fs);
plot(G_x_a_f(1:round(end*0.5)),G_x_a(1:round(end*0.5)));
title("功率谱密度") 
xlabel("f/Hz")

% 显示Y_1的原始波形，自相关函数，频谱(幅度谱)，功率谱密度
figure(3)
subplot(2,2,1)
plot(t(1:400),y_1(1:400))
title("波形(部分)");
xlabel("t/s");
subplot(2,2,2)
[R_y_1,lag_y_1] = xcorr(y_1,N/2,'unbiased'); % 自相关函数
tempx = lag_y_1/fs;
plot(tempx(round(end/2)-100:round(end/2)+100),R_y_1(round(end/2)-100:round(end/2)+100))
title("自相关函数(部分)")
xlabel("t/s")
subplot(2,2,3)
plotFFT(fft(y_1),fs);
title("频谱（幅度谱）")
xlim([-8000 8000])
subplot(2,2,4)
[G_y_1,G_y_1_f] = periodogram(y_1,[],[],fs);
plot(G_y_1_f(1:round(end*0.5)),G_y_1(1:round(end*0.5)));
title("功率谱密度") 
xlabel("f/Hz")



pause()
close all;
