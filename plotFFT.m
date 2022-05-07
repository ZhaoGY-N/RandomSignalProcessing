function [f,Y] = plotFFT(fftraw,fs,ifplot)
%PLOTFFT 以FFT应有的横纵坐标显示
%   返回一个fft结果以频率(Hz)为单位的横坐标以及经过规整后的纵坐标
if (nargin<3)
    ifplot = true;
end
N = max(size(fftraw));

Y = fftshift(abs(fftraw./N));
f = (-N/2+1:N/2)*fs/N;

if (ifplot)
    plot(f,Y)
    xlabel("freq/Hz")
end

end

