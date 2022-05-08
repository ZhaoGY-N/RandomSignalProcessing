N = 10000;
tmax = 0.5;
fs = N/tmax;
t = (1:N)/fs;
omega = 1e3*2*pi;

temp = sin(rand(1,N)*2*pi)+1;
mean(temp)
var(temp)

a = 0;
b = 2*pi;
m = -1;
M = 1;

xy = unifrnd(0,1,[2,N]);
x = xy(1,:);
y = xy(2,:);

E_x = zeros(1,N);
Var_x = zeros(1,N);
for i = 1:N
    f = (sin(omega*t(i) + (a + (b-a)*x)))/(2*pi) / (1/pi);
    n0 = sum(y<f);
    E_x(i) = (1/pi)*(2*pi)*n0/N + 0;
    
    f = (sin(omega*t(i) + x*2*pi)).^2/(2*pi) / (2/pi);
    n0 = sum(y<f);
    Var_x(i) = (2/pi)*(2*pi)*n0/N + 0 - E_x.^2;
end

C
for i = 
