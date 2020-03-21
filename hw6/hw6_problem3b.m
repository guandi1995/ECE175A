%%problem 3 part 2
clear 
clc

data=load('HW6_Data\data.mat');
label=load('HW6_Data\label.mat');
imageTest=data.imageTest;
imageTrain=data.imageTrain;
labelTest=label.labelTest;
labelTrain=label.labelTrain;

dim=[5, 10, 20, 30, 40, 60,90, 130, 180, 250, 350];
imageTrain_reshape=reshape(imageTrain,[784,5000]);
imageTest_reshape=reshape(imageTest,[784,500]);
[V,D]=eigenfigure(imageTrain_reshape);
error_list=zeros(1,length(dim));

for iteration =1:1
    s=dim(iteration)-1;
    %obtain the first K dimensions
    eigenfigureset = V(:,(end:-1:end-s));
    %compute the average eigenfigure
    avg_eigenfigure=mean(imageTrain_reshape,2);
    %project testing data onto K dimension subspace
    Y=eigenfigureset'*(imageTest_reshape-repmat(avg_eigenfigure,1,500));
    %project training data onto K dimension subspace
    Z=eigenfigureset'*(imageTrain_reshape-repmat(avg_eigenfigure,1,5000));

    error=0;
    predicted_label=zeros(500,1);
    for i =1:500
        reduced_imageTest=Y(:,i);
        reduced_imageTest=repmat(reduced_imageTest,1,5000);
        dif=Z-reduced_imageTest;
        dif=sqrt(sum(dif.^2));
        [~,index]=min(dif);
        label=labelTrain(index);
        predicted_label(i)=label;
        if predicted_label(i) ~= labelTest(i)
            error=error+1;
        end
    end
    error_list(iteration)=error;
end

figure
plot(dim,error_list/500,'.-');
title('PoE versus # of dimensions by using NN');
