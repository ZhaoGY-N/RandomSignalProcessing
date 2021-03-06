clear all
clc
close all

N = 20000;
maxlag = 10000;

x = rand(N,1);

mu = mean(x)
myvar = var(x)

figure(1);
[f,xi]=ksdensity(x);
plot(xi,f);


[R_x,lags]=xcorr(x,maxlag,"unbiased");
%{
这里之所以除了正态分布之外，没有在其他位置直接变为0，而是形成了一个近似三角形的一个区域；
是因为各个偏移量能使用的数据数量是不同的，而且均值不为零，所以有些地方叠加的多，有些地方叠加的少，才导致这个样子。
使用unbiased参数，可以做一个对不同数量的样本的平均，这样我们就能得到一个较为合理的数据。
但是这样会有一个问题就是，在两端由于数据量太小，会有很大的误差，导致两端会有翘起。
所以我们将原本的数据扩大，然后设置最大偏移，这样相当于只取中间的数据。
%}
figure(2);
plot(lags,R_x);

G_X_1 = fftshift(abs(fft(R_x)));
% 对自相关函数进行傅里叶变换可以得到其功率谱密度，但是由于其自相关函数中的直流分量导致在0频率出有一个冲击函数
% 为了让图片更加清晰，我们将靠近0频的部分进行了去除
figure(3);
subplot(2,1,1)
plot(G_X_1)
xlim([0,2e4])
G_X_1(round((1+end)/2-10:round((1+end)/2+10))) = 0;
subplot(2,1,2)
plot(G_X_1);
xlim([0,2e4])