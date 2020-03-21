%problem 2
%part b
clear
clc
%data
D=[-2.5,-1;-2,0.5;-1,0;2.5,-1;2,1];
figure
x1=D(:,1);
x2=D(:,2);
plot(x1,x2,'black+')
xlim([-3,3])
ylim([-2,2])
grid on
hold on
%initialize the parameters, mu,cov,pi
mu_1_updated=zeros(20,2);
mu_2_updated=zeros(20,2);
weight=[0.5,0.5];
mu_1=[-0.1,0];
mu_2=[0.1,0];
mu_1_updated(1,:)=mu_1;
mu_2_updated(1,:)=mu_2;
cov_1=[1,0;0,1];
cov_2=cov_1;
plot(mu_1(1),mu_1(2),'ro')
hold on
plot(mu_2(1),mu_2(2),'bo')
hold on
%E-step
h_kj=zeros(5,2);
n_j_new=zeros(1,2);

%5 data points
for i = 1:1
%while 1   
    for k = 1:5
        pro_k1=weight(1)*gaussian_k(D,mu_1,cov_1,k);
        sum_pro_kj=weight(1)*gaussian_k(D,mu_1,cov_1,k)+weight(2)*gaussian_k(D,mu_2,cov_2,k);
        h_k1=pro_k1/sum_pro_kj;
        h_kj(k,1)=h_k1;

        pro_k2=weight(2)*gaussian_k(D,mu_2,cov_2,k);
        sum_pro_kj=weight(1)*gaussian_k(D,mu_1,cov_1,k)+weight(2)*gaussian_k(D,mu_2,cov_2,k);
        h_k2=pro_k2/sum_pro_kj;
        h_kj(k,2)=h_k2;

    end
    %%%%%M-step
    
    %calculate new n_j
    n_j_new(1,1)=sum(h_kj(:,1));
    n_j_new(1,2)=sum(h_kj(:,2));
    %calculate new mean
    mu_1=h_kj(:,1)'*D/n_j_new(1,1);
    mu_2=h_kj(:,2)'*D/n_j_new(1,2);
    mu_1_updated(i+1,:)=mu_1;
    mu_2_updated(i+1,:)=mu_2;
    dif= sqrt(sum((mu_2_updated(i+1,:)-mu_2_updated(i,:)).^2));
%     if dif<0.001
%         break
%     end
    %calculate new covariance
    %cov_1
    sigma1_11=0;
    sigma1_22=0;
    for index=1:5
        sigma1_11=sigma1_11+h_kj(index,1)*((D(index,1)-mu_1(1))^2);
        sigma1_22=sigma1_22+h_kj(index,1)*((D(index,2)-mu_1(2))^2);
    end
    cov_1=[sigma1_11,0;0,sigma1_22];
    cov_1=cov_1/n_j_new(1,1);
    
    %cov_2
    sigma2_11=0;
    sigma2_22=0;
    for index=1:5
        sigma2_11=sigma2_11+h_kj(index,2)*(D(index,1)-mu_1(1))^2;
        sigma2_22=sigma2_22+h_kj(index,2)*(D(index,2)-mu_1(2))^2;
    end
    cov_2=[sigma2_11,0;0,sigma2_22];
    cov_2=cov_2/n_j_new(1,2);
   
    %calculate new pi
    weight(1)=n_j_new(1,1)/5;
    weight(2)=n_j_new(1,2)/5;
    
    
%     plot(mu_1_updated(i+1,1),mu_1(i+1,2),'r.')
%     hold on
%     plot(mu_2_updated(i+1,1),mu_2_updated(i+1,2),'b.')
%     hold on
    
%     [fx1,fx2]=meshgrid(-3:0.1:3);
%     z=cov_1(1,1).*(fx1-mu_1_updated(i+1,1)).^2+cov_1(2,2).*(fx2-mu_1_updated(i+1,2)).^2;
%     contour(fx1,fx2,z,[1,1]);
%     hold on
%     z=cov_2(1,1).*(fx1-mu_2_updated(i+1,1)).^2+cov_2(2,2).*(fx2-mu_2_updated(i+1,2)).^2;
%     contour(fx1,fx2,z,[1,1])
%     title(['iteration',num2str(1)]);
    %mu_new=h_kj'*D./n_j_new';
end

syms x1 x2
constant_1=1/(2*pi*sqrt(det(cov_1)));
constant_2=1/(2*pi*sqrt(det(cov_2)));

%gaussian distribution
p_x1=weight(1)*constant_1*exp(-0.5.*([x1;x2]-mu_1')'*inv(cov_1)*([x1;x2]-mu_1'));
p_x2=weight(2)*constant_2*exp(-0.5.*([x1;x2]-mu_2')'*inv(cov_2)*([x1;x2]-mu_2'));

p=p_x1./(p_x1+p_x2);
[x1,x2]=meshgrid(-3:0.1:3);
z0=eval(p);
figure
surf(x1,x2,z0)
title('iteration 15')