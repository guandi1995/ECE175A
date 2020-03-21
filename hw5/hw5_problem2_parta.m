%problem 2
clear
clc
%part a
x1=linspace(-5,5);
x2=x1;
[X1,X2]=meshgrid(x1,x2);
sigma=2;
cov=[sigma 0;0 sigma];
inverse=inv(cov);
constant=1/(2*pi*sqrt(det(cov)));
z1=constant*exp(-0.5*((X1-2).^2*inverse(1,1)+(X2).^2*inverse(2,2)));
z2=constant*exp(-0.5*((X1+2).^2*inverse(1,1)+(X2).^2*inverse(2,2)));
z=log(0.5*z1+0.5*z2);
figure(1)
surfc(X1,X2,z);
xlabel('x1');
ylabel('x2');
zlabel('logP_D(X)');
title(['sigma^2=',num2str(sigma),' mu_1=[-2,0]; mu_2=[2,0]']);
