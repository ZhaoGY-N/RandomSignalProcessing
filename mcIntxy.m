function outputArg = mcIntxy(func,N,a,b)
%MCINT 此处显示有关此函数的摘要
%   此处显示详细说明
xy = unifrnd(0,1,[2,N]);
x = a + (b-a).*xy(1,:);
y = xy(2,:);

f = func(x);
m = min(f);
M = max(f);
f = (f - m)/(M-m);
n0 = sum(y<f);
outputArg = (M-m)*(b-a)*(n0/N)+m*(b-a);

end

