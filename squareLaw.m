function outputArg = squareLaw(inputS,b)
%PINGFANG 此处显示有关此函数的摘要
%   此处显示详细说明
if(nargin<2)
    b = 1;
end
if(inputS<0)
    outputArg = 0;
else
    outputArg = b*inputS^2;
end
end

