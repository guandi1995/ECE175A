%%%%ECE175 hw2 problem 3

%%%%part(a)
%load data and assign variable
data=load('HW2_Data\data.mat');
label=load('HW2_Data\label.mat');
imageTest=data.imageTest;
imageTrain=data.imageTrain;
labelTest=label.labelTest;
labelTrain=label.labelTrain;
%initialize the error i=list
error=zeros(10,1);
misclassified=[];
%use tabulate to conduct stats on label test data
stats_test=tabulate(labelTest);
for i =1:500
    [min_euclidean_dis,index]=euclidean_dis(imageTest(:,:,i),imageTrain);
    if labelTest(i) ~= labelTrain(index)
        error(labelTest(i)+1)=error(labelTest(i)+1)+1;
        misclassified(1,end+1)=i;
        misclassified(2,end)=index;
    end
end

%obtain the error rate for each class
error_rate=error./stats_test(:,2);

%plot the PoE for each class
figure
plot(0:9,error_rate)
xlabel('class')
ylabel('P(error|class)')
title('PoE')

%%%%part(b)

%obtain the total error rate
total_error_rate=sum(error)/500;

%%%%part(c)
figure
for i=1:5
    subplot(2,5,i)
    title('first 5 misclassi?ed test images')
    imshow(imageTest(:,:,misclassified(1,i)));
    title(labelTest(misclassified(1,i)))
    subplot(2,5,i+5)
    title('corresponding closest images in training database')
    imshow(imageTrain(:,:,misclassified(2,i)));
    title(labelTrain(misclassified(2,i)))
end
