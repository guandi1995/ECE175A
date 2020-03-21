%%%problem 3
%%%(1).
data=load('HW3_Data\data.mat');
label=load('HW3_Data\label.mat');
imageTest=data.imageTest;
imageTrain=data.imageTrain;
labelTest=label.labelTest;
labelTrain=label.labelTrain;

%initialization 
all_sample_mean=zeros(784,10);
stat_test=tabulate(labelTest);

%calculate and display the sample mean 
figure
for i=0:1:9
     %find the location where labelTrain is equal to the class i,
     loc=find(labelTrain==i);
     %restore the images of the same class into variable class_i
     class_i = imageTrain(:,:,loc);
     %reshape the image dimension from 28*28*size(loc) to 784*size(loc)
     class_i=reshape(class_i,[28*28,size(loc)]);
     %obtain the sample mean for each class
     sample_image=sum(class_i,2)./size(loc,1);
     %restore each class to all_sample_mean with dimension of 784*10
     all_sample_mean(:,i+1)=sample_image;
     %reshape it back to the dimension of 28*28 for each image
     sample_image_original=reshape(sample_image,[28,28]);
     %plot the sample mean for each class
     subplot(3,4,i+1)
     imagesc(sample_image_original)
     title(i)
end
sgtitle('Sample Mean for Each Class')

%%%(2).perform the classification by BDR
%part(a)
%initialization
i_x=zeros(1,10);
predict_label=zeros(500,1);
error_class=zeros(10,1);

%calculate i_x for each testing image from 1 to 500 wrt those 10 classes, find 
%the maximum i_x within those 10 classes and assign the class value and
%restore the value to the repository predict_label
for i=1:500
    for j=0:9
        %reshape each image in testing image to the size of 784*1
        image=reshape(imageTest(:,:,i), [28*28,1]);
        %each class mean from class 0 to 9
        class_mean=all_sample_mean(:,j+1);
        %calculate the value of i_x, each tesing image wrt 10 class sample
        %mean and restore to variable i_x
        i_x(1,j+1)=(image-class_mean)'*(image-class_mean);
        %find the minimum value and location within i_x for each testImage
        [val,loc]=min(i_x);
        %restore the value of class to variable predict_label(500*1)
        predict_label(i,1)=loc-1;
    end
    %calculate the error
    if labelTest(i) ~= predict_label(i)
        error_class(labelTest(i)+1)=error_class(labelTest(i)+1)+1;
    end
end
%calculate error rate for each class
error_rate_class=error_class./stat_test(:,2);

%plot error rate for each class
figure
x=(0:9);
plot(x,error_rate_class);
ylim([0,0.5])
xlabel('i')
ylabel('P(Error|i)')
title('PoE')

%part(b)
count=500-sum(labelTest==predict_label);
total_error_rate=count/500;

%%%%(3).
imageTrain=reshape(imageTrain,784,5000);

figure
for i=0:9
    a=find(labelTrain==i)';
    b=imageTrain(:,a);
    b=b';
    c=cov(b);
    subplot(3,4,i+1)
    imshow(c)
    title(i)
end
sgtitle('Covariance matrix for each clas')
