clear all;
clc

N = 100000;
tmax = 0.5;
fs = N/tmax;
t = (1:N)/fs;
t1 = t;
t2 = t;

mu = 10;
sig = 2;

p = @(x)normpdf(x,mu,sig);

temp = normrnd(mu,sig,1,N);
a = min(temp)-3*sig;
b = max(temp)+3*sig;

f_ex = @(x)x.*p(x);
mx = mcIntxy(f_ex,N,a,b);

f_var = @(x)(x-mx).^2.*p(x);
varx = mcIntxy(f_var,N,a,b);


% 协方差，当t1 neq t2时，我们可以得到
f_Cx = @(x1,x2)(x1-mx).*(x2-mx).*normpdf(x1,mu,sig).*normpdf(x2,mu,sig);
Cx = mcIntxyz(f_Cx,N,a,b,a,b)
% 当t1 = t2时，我们有 x1 = x2，一定成立
f_Cx = @(x)(x-mx).^2.*p(x); % 与f_var相等
Cx = mcIntxy(f_Cx,N,a,b)

% 相关函数，当t1 neq t2时，我们可以得到
f_Rx = @(x1,x2)x1.*x2.*p(x1).*p(x2);
Rx = mcIntxyz(f_Rx,N,a,b,a,b)
% 当t1 = t2时，我们有 x1 = x2，一定成立
f_Rx = @(x)x.^2.*p(x);
Rx = mcIntxy(f_Rx,N,a,b)
