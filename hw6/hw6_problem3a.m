clear 
clc

%%problem 3
data=load('HW6_Data\data.mat');
label=load('HW6_Data\label.mat');
imageTest=data.imageTest;
imageTrain=data.imageTrain;
labelTest=label.labelTest;
labelTrain=label.labelTrain;

%%%%%part 1
%reshape training images to 784*5000 dimensions 
imageTrain_reshape=reshape(imageTrain,[784,5000]);
imageTest_reshape=reshape(imageTest,[784,500]);
%%%%%compute the PC components for the training images
[V,D]=eigenfigure(imageTrain_reshape);
eigenfigureset = V(:,(end:-1:end-9));
[d,ind] = sort(diag(D),'descend');
%%%%%compute the PC components for digit 5
digit_ind=find(labelTrain==5);
digit_img=imageTrain_reshape(:,digit_ind);
[V,D]=eigenfigure(digit_img);
eigenfigureset = V(:,(end:-1:end-39));

figure
sgtitle('Top 10 eigenfigures for all training data')
for i =1:10
    subplot(2,5,i)
    eigenfigure=reshape(eigenfigureset(:,i),[28,28]);
    imagesc(eigenfigure)
    title(['Top',num2str(i)])
end

figure
plot(1:784,d)
title('Descending eigenvalues for all training image')

%%%%%part 3
%compute the average eigenfigure
avg_eigenfigure=mean(digit_img,2);
%project testing data onto K dimension subspace
Y=eigenfigureset'*(imageTest_reshape-repmat(avg_eigenfigure,1,500));

%obtain the average reduced dimensional feature of digits 5
%avg_digits_5=mean(eigenfigureset,2);
avg_digits_5=eigenfigureset'*(avg_eigenfigure);
avg_digits_5=repmat(avg_digits_5,1,500);
dif=Y-avg_digits_5;
dif=sqrt((sum(dif.^2)));
[B,I]=maxk(dif,10);

% for i =1:500
%     reduced_imageTest=Y(:,i);
%     reduced_imageTest=repmat(reduced_imageTest,1,length(digit_ind));
%     dif=Z-reduced_imageTest;
%     dif=sqrt(sum(dif.^2));
% end
figure
for i=1:10
    subplot(2,5,i)
    image=imageTest(:,:,I(i));
    imagesc(image)
    title(['index=',num2str(I(i))])
end
