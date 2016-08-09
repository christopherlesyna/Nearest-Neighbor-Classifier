clear all
data = load('data.mat');
label = load('label.mat');

imageTrain = data.imageTrain;
imageTest = data.imageTest;
labelTest = label.labelTest;
labelTrain = label.labelTrain;

nearest_neighbour = zeros(500,4);
for i=1:500  %Outer loop for 500 test images    
    distance = zeros(5000,2);
    for k=1:5000 %Inner loop computing distance between test image and all 5000 data points
        distance(k,1) = k;        
        sumtemp = (((abs((imageTest(:,:,i) - imageTrain(:,:,k)))).^2));
        sumfull = sum(sumtemp(:));
        distance(k,2) = sqrt(sumfull);                
        k=k+1;
    end    
    Minval = min(distance(:,2));
    [mindist,ind] = min(distance(:,2));
    [m,n] = ind2sub(size(distance(:,2)),ind);
        
    nearest_neighbour(i,1) = i; %Index of which of the 500 test images we're looking at
    nearest_neighbour(i,2) = m; %Index of which of the 5000 is closest
    nearest_neighbour(i,3) = mindist; %Distance From Closest Training to Test
    nearest_neighbour(i,4) = labelTrain(m); %Class of nearest neighbour and class that will be assigned
    
    i=i+1;
end

%Part 1
labelFound = nearest_neighbour(:,4);
graph = zeros(10,1);
for b=1:500
    if labelFound(b) ~= labelTest(b)
        graph(labelTest(b)) = graph(labelTest(b))+1;
    end
    b=b+1;
end
totals = [sum(labelTest(:)==0) sum(labelTest(:)==1) sum(labelTest(:)==2) sum(labelTest(:)==3) sum(labelTest(:)==4) sum(labelTest(:)==5) sum(labelTest(:)==6) sum(labelTest(:)==7) sum(labelTest(:)==8) sum(labelTest(:)==9)];
new_graph = graph./totals';
figure(1)
scatter([0:9],new_graph)
title('Part 1: Error Rate For Each Case')
xlabel('Classes, i=0 to i=9')
ylabel('Error Rates Per Class')

%Part 2
errors=zeros(500,1);
for a=1:500
    if nearest_neighbour(a,4) == labelTest(a)
        errors(a,1) = 0;
    else
        errors(a,1) = 1;
    end
    a=a+1;
end
sumerror = sum(errors); %sumerror is 47; 47 total errors out of 500
P_error = sumerror/500; %P_error is equal to .0940, or 9.4%

%Part 3
figure(2)
imshow(imageTest(:,:,7));
figure(3)
imshow(imageTrain(:,:,55));
%imwrite(imageTest(:,:,7),image_error_1,'png');
%imwrite(imageTrain(:,:,55),image_true_1,'png');
figure(4)
imshow(imageTest(:,:,17));
figure(5)
imshow(imageTrain(:,:,2053));
%imwrite(imageTest(:,:,7),image_error_1,'png');
%imwrite(imageTrain(:,:,55),image_true_1,'png');
figure(6)
imshow(imageTest(:,:,25));
figure(7)
imshow(imageTrain(:,:,4207));
%imwrite(imageTest(:,:,7),image_error_1,'png');
%imwrite(imageTrain(:,:,55),image_true_1,'png');
figure(8)
imshow(imageTest(:,:,44));
figure(9)
imshow(imageTrain(:,:,3593));
%imwrite(imageTest(:,:,7),image_error_1,'png');
%imwrite(imageTrain(:,:,55),image_true_1,'png');
figure(10)
imshow(imageTest(:,:,45));
figure(11)
imshow(imageTrain(:,:,133));
%imwrite(imageTest(:,:,7),image_error_1,'png');
%imwrite(imageTrain(:,:,55),image_true_1,'png');