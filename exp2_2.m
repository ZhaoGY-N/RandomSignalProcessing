clear all;
clc

N = 10000;
sig = 1;
mu = 5;

p = unifrnd(0,1,1,N);

x = norminv(p,mu,sig);
E_x = mean(x);
Var_x = var(x);

[R_x,lag]=xcorr(x,'unbiased');
plot(lag,R_x);
xlim([round(-N*0.7),round(N*0.7)])