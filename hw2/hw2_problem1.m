%%%%%%%ECE175 hw2 Problem 1
%%(a)surface and contour plot of function f(x)=x'Ax
[x1,x2]=meshgrid(-100:1:100);
%when b=1;A=[5 1;1 5]
fx=2.*x1.*x2+5*x1.^2+5*x2.^2;
figure
subplot(2,1,1)
meshc(x1,x2,fx);
subplot(2,1,2)
contour(x1,x2,fx);
sgtitle('surface and contour plot when b=1')

%when b=5;A=[5 5;5 5]
fx=10.*x1.*x2+5*x1.^2+5*x2.^2;
figure
subplot(2,1,1)
meshc(x1,x2,fx);
subplot(2,1,2)
contour(x1,x2,fx);
sgtitle('surface and contour plot when b=5')

%when b=10; A=[5 10;10 5]
fx=20.*x1.*x2+5*x1.^2+5*x2.^2;
figure
subplot(2,1,1)
meshc(x1,x2,fx);
subplot(2,1,2)
contour(x1,x2,fx);
sgtitle('surface and contour plot when b=10')

%%(b)eigenvalues of A
%when b=1, the result returns eigenvalues of 4 and 6
A=[5 1;1 5];
e1=eig(A);
%when b=5, the result returns eigenvalues of 0 and 10
A=[5 5;5 5];
e2=eig(A);
%when b=1, the result returns eigenvalues of -5 and 15
A=[5 10;10 5];
e3=eig(A);
