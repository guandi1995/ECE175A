function [V,D] = eigenfigure(input)
n=size(input,2);

%compute the mean
avg=mean(input,2);
%comoute the covariance
avg_reshape=repmat(avg,1,n);
covariance=(input-avg_reshape)*(input-avg_reshape)';
covariance=covariance/n;
% covariance=zeros(784,784);
% for i=1:5000
%     covariance=covariance+(imageTrain_reshape(:,i)-avg)*((imageTrain_reshape(:,i)-avg))';
% end

%compute the eigenvalues and eigenvectors of covariance matrix
[V,D]=eig(covariance);
%[d,ind] = sort(diag(D));
%select the top 10 eigenvectors as eigenfigures

end