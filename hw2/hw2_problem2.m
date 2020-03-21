clear
clc
%%%%%%%ECE175 hw2 problem 2
%%(a)generate 500 points of 2-D Gaussian distribution with zero mean and
%%unit covariance
%number of datapoints
n=500;
%variable x1
x1=randn(n,1);
%variable x2
x2=randn(n,1);

%%%%check the covariance

%first, check the mean and variance of the variable x1 and x2
x1_bar=mean(x1);
%return the value of -0.0897, which is close to 0
x2_bar=mean(x2);
%return the value of -0.0466, which is close to 0
var_x1=sum((x1 - x1_bar).*(x1 - x1_bar))/(length(x1) - 1);
%return the value of 1.0578, which is close to 1
var_x2=sum((x2 - x2_bar).*(x2 - x2_bar))/(length(x2) - 1);
%return the value of 0.9508, which is close to 1

%second, check the covariance, cov(x1,x2)
%return the value of -0.0195, which is close to 0,implying that the varaible x1 and x2 is independent
cov_x1_x2=sum((x1 - x1_bar).*(x2 - x2_bar))/(n - 1);
%third, build the covariance matrix 
cov_matrix=cov(x1,x2);
%return the covariance matrix
% covariance =
% 
%     1.0578    -0.0195
%     -0.0195    0.9508
%it is close to an identity covariance matrix, which is
%     1     0
%     0     1

%plot the generated points
figure
scatter(x1,x2,'.black')
hold on
%plot the contour of mahalabonis distance
[fx1,fx2]=meshgrid(-9:0.1:9);
z=fx1.^2+fx2.^2;
contour(fx1,fx2,z)
title('original data points and the contour of Mahalabonis distance');
xlabel('x1');
ylabel('x2');

%%%(b)apply the transformation to the points
%obtain the new covariance matrix
T=[cos(pi/4) -sin(pi/4);sin(pi/4) cos(pi/4)]*[3 0;0 1];
new_cov_y=T*cov_matrix*T';
new_cov_y_truth=T*T';
inv_new_cov=inv(new_cov_y_truth);
X=[x1';x2'];
new_X=T*X;
figure
scatter(new_X(1,:),new_X(2,:),'.black')
hold on
[fx1,fx2]=meshgrid(-9:0.1:9);
z=inv_new_cov(1,1).*fx1.^2+inv_new_cov(2,2).*fx2.^2+(inv_new_cov(1,2)+inv_new_cov(2,1)).*fx1.*fx2;
contour(fx1,fx2,z)
title('transformed data points and the contour of Mahalabonis distance');
xlabel('x1');
ylabel('x2');

%%%(c)
A=[5 0;0 2];
new_cov_z_truth=inv(A);
T=new_cov_z_truth^(1/2);
new_X=T*X;
figure
scatter(new_X(1,:),new_X(2,:),'.black')
hold on
[fx1,fx2]=meshgrid(-9:0.1:9);
z=A(1,1).*fx1.^2+A(2,2).*fx2.^2+(A(1,2)+A(2,1)).*fx1.*fx2;
contour(fx1,fx2,z)
title('transformed data points and the contour of Mahalabonis distance');
xlabel('x1');
ylabel('x2');

