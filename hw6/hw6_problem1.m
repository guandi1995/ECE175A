%%% hw6 Problem 1
%%(a)
[x1,x2]=meshgrid(-100:1:100);
A1=[5 1;1 5];
[V1,D1]=eig(A1);
%when b=1;A=[5 1;1 5]
fx=2.*x1.*x2+5*x1.^2+5*x2.^2;
figure
subplot(2,1,1)
meshc(x1,x2,fx);
subplot(2,1,2)
contour(x1,x2,fx);
grid on
hold on
line([0 40*V1(1,1)],[0,40*V1(2,1)])
line([0 40*V1(1,2)],[0,40*V1(2,2)])
sgtitle('contour plot when b=1')

%when b=5;A=[5 5;5 5]
fx=10.*x1.*x2+5*x1.^2+5*x2.^2;
A2=[5 5;5 5];
[V2,D2]=eig(A2);
figure
subplot(2,1,1)
meshc(x1,x2,fx);
subplot(2,1,2)
contour(x1,x2,fx);
grid on
hold on
line([0 40*V2(1,1)],[0,40*V2(2,1)])
line([0 40*V2(1,2)],[0,40*V2(2,2)])
sgtitle('contour plot when b=5')

%when b=10; A=[5 10;10 5]
fx=20.*x1.*x2+5*x1.^2+5*x2.^2;
A3=[5 10;10 5];
[V3,D3]=eig(A3);
figure
subplot(2,1,1)
meshc(x1,x2,fx);
subplot(2,1,2)
contour(x1,x2,fx);
grid on 
hold on
line([0 40*V3(1,1)],[0,40*V3(2,1)])
line([0 40*V3(1,2)],[0,40*V3(2,2)])
sgtitle('contour plot when b=10')
 
%%(b)
y1=(-10:1:10);
y2=(-10:1:10);

figure
subplot(1,3,1)
f1_y=6*y2.^2;
f2_y=4*y1.^2;
plot(y2,f1_y)
grid on
hold on 
plot(y1,f2_y)
title('f(y) when b=1')
legend('y_1=0','y_2=0')

subplot(1,3,2)
f1_y=10*y2.^2;
f2_y=0*y1.^2;
plot(y2,f1_y)
grid on
hold on 
plot(y1,f2_y)
title('f(y) when b=5')
legend('y_1=0','y_2=0')

subplot(1,3,3)
f1_y=15*y2.^2;
f2_y=-5*y1.^2;
plot(y2,f1_y)
grid on
hold on 
plot(y1,f2_y)
title('f(y) when b=10')
legend('y_1=0','y_2=0')


