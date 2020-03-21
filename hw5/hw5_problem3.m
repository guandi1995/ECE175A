%problem 3
clear
clc
data=load('HW5_Data\data.mat');
imageTest=data.imageTest;
imageTrain=data.imageTrain;
label=load('HW5_Data\label.mat');
labelTest=label.labelTest;
labelTrain=label.labelTrain;

%part 1&2&4

%choose those 10 random images as the initial class means
figure
sgtitle('Initial Class Means')
%initialize the class means
initial_means=zeros(28*28,10);

%%%part 1
%initialize random class means
% for i =1:10
%     single_initial_means=200*rand(28)+50;
%     subplot(2,5,i)
%     imagesc(single_initial_means)
%     title(['index=',num2str(i)])
%     %convert to (28*28)*10 vectors and store into initial_means
%     initial_means(:,i)=reshape(single_initial_means,[28*28,1]);
% end

%%%%%part 2&4
%generate random values from 1 to 5000
random_idx=round(10000*rand(10,1)/2);
%random_idx=[3431,3325,4111,4420,4491,659,2424,3513,3540,3946];
for i =1:10
    subplot(2,5,i)
    imagesc(imageTrain(:,:,random_idx(i)))
    title(['index=',num2str(random_idx(i))])
    %convert to (28*28)*10 vectors and store into initial_means
    initial_means(:,i)=reshape(imageTrain(:,:,random_idx(i)),[28*28,1]);
end

%convert imgaeTrain to the size of 784*5000
imageTrain_reshape=reshape(imageTrain,[784,5000]);
%K-means algorithm
image_means_distance=zeros(5000,10);
image_class=zeros(5000,1);
iteration=1;
%for iteration=1:30
while 1
    image_class_previous=image_class;
    for i =1:5000
        single_train_image=repmat(imageTrain_reshape(:,i),1,10);
        dif=single_train_image-initial_means;
        image_means_distance(i,:)=sqrt(sum(dif.^2));
        [~,index]=min(image_means_distance(i,:));
        image_class(i,1)=index;
    end
    %check the error
    count=find((image_class_previous==image_class)==0);
    count_size=size(count);
    count=count_size(1);
    if count<20
        break
    end
    for label=1:10
        x=find(image_class==label);
        y=imageTrain_reshape(:,x);
        initial_means(:,label)=mean(y,2);
    end
    
    iteration=iteration+1;
%     if iteration==1
%         initial_means_fisrt=reshape(initial_means,[28,28,10]);
%         figure
%         sgtitle('first iteration class means')
%         for first_iterate_i =1:10
%             subplot(2,5,first_iterate_i)
%             imagesc(initial_means_fisrt(:,:,first_iterate_i))
%             title(['index=',num2str(first_iterate_i)])
%         end
%     end
end

initial_means=reshape(initial_means,[28,28,10]);
figure
sgtitle('Final Class Means')
for i =1:10
    subplot(2,5,i)
    imagesc(initial_means(:,:,i))
    title(['index=',num2str(i)])
end



%part 3
assign_means=zeros(28,28,10);
assign_means(:,:,1)=initial_means(:,:,9);
assign_means(:,:,2)=initial_means(:,:,1);
assign_means(:,:,3)=initial_means(:,:,7);
assign_means(:,:,4)=initial_means(:,:,5);
assign_means(:,:,5)=initial_means(:,:,10);
assign_means(:,:,7)=initial_means(:,:,3);
assign_means(:,:,9)=initial_means(:,:,4);
assign_means(:,:,10)=initial_means(:,:,2);
figure
sgtitle('Mannually Assigned label')
for i =1:10
    subplot(2,5,i)
    imagesc(assign_means(:,:,i))
    title(['digits=',num2str(i-1)])
end
%initialization
stat_test=tabulate(labelTest);
i_x=zeros(1,10);
predict_label=zeros(500,1);
error_class=zeros(10,1);
assign_means=reshape(assign_means,[28*28,10]);
for i=1:500
    for j=0:9
        %reshape each image in testing image to the size of 784*1
        image=reshape(imageTest(:,:,i), [28*28,1]);
        %each class mean from class 0 to 9
        class_mean=assign_means(:,j+1);
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
ylim([0,1])
xlabel('i')
ylabel('P(Error|i)')
title('PoE')