function [outmean,outmeanSq,outvar]= plotMany(x,t,N,fs,plotRate)
%PLOTMANY 此处显示有关此函数的摘要
%   此处显示详细说明
if (nargin<5)
    plotRate = 0.05;
end

subplot(2,2,1)
plot(t(1:round(end*plotRate)),x(1:round(end*plotRate)))
title("波形(部分)");
xlabel("t/s");
subplot(2,2,2)
[R_x,lag] = xcorr(x,N/2,'unbiased'); % 自相关函数
tempx = lag/fs;
plot(tempx(round(end/2-end*plotRate):round(end/2+end*plotRate)),R_x(round(end/2-end*plotRate):round(end/2+end*plotRate)))
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
xlim([0,8000])

outmean = mean(x);
outmeanSq = mean(x.^2);
outvar = var(x);
end

