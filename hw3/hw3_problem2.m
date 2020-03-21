% %%problem 2
% %part(b)
syms x1 x2
I=[1 0;0 1];
cov=1/4*I;
var=1/4;
det_cov=det(cov);
constant_1=1./(2*pi*0.25^2);
constant_2=-1/(2*0.25);
mu_0=[-1;-1];
mu_1=[1;1];
%P0=0.25/0.5/0.75
P0=0.75;
%P1=0.25/0.5/0.75
P1=0.25;
%gaussian distribution
z_0=P0*constant_1*exp(constant_2.*([x1;x2]-mu_0)'*([x1;x2]-mu_0));
z_1=P1*constant_1*exp(constant_2.*([x1;x2]-mu_1)'*([x1;x2]-mu_1));

[x1,x2]=meshgrid(-3:0.1:3);
z_0=eval(z_0);
z_1=eval(z_1);
%optimal boundary hyperplane
[fx1,fx2]=meshgrid(-3:0.1:3);
boundary=-2*fx1-2*fx2+var*log(P0/P1);

figure
contour(x1,x2,z_0);
text(-1,-1,'class 0');
hold on 
contour(x1,x2,z_1);
text(1,1,'class 1');
hold on
contour(x1,x2,boundary,1);
text(1,-1,'boundary hyperplane')
xlabel('x1');
ylabel('x2');
title(['P_Y(0)=',num2str(P0),',P_Y(1)=',num2str(P1)]);