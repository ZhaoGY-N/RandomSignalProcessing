clear all;
clc

N = 10000;
sig = 1;
mu = 5;

p = unifrnd(0,1,1,N);

x = norminv(p,mu,sig);
E_x = mean(x);
fprintf("均值为：%f\n",E_x);

Var_x = var(x);
fprintf("方差为：%f\n",Var_x);

[R_x,lag]=xcorr(x,'unbiased');
figure(1)
plot(lag,R_x);
xlim([round(-N*0.7),round(N*0.7)])

C_x = R_x - E_x*E_x;
figure(2)
plot(lag,C_x);
xlim([round(-N*0.7),round(N*0.7)])