function outputArg = mcIntxyz(func,N,a,b,c,d)
%MCINT 此处显示有关此函数的摘要
%   此处显示详细说明
xyz = unifrnd(0,1,[3,N]);
x = a + (b-a).*xyz(1,:);
y = c + (d-c).*xyz(2,:);
z = xyz(3,:);

f = func(x,y);
m = min(f);
M = max(f);
f = (f - m)/(M-m);
n0 = sum(z<f);
outputArg = (M-m)*(b-a)*(n0/N)+m*(b-a);

end

