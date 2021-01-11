clear all;
clc;
%selecting input data set
datapath = uigetdir('.\train','select path of training images');

%count no. of images in dataset
D = dir(datapath);  % D is a Lx1 structure with 4 fields as: name,date,byte,isdir of all L files present in the directory 'datapath'
imgcount = 0;
for i=1 : size(D,1)
    if not(strcmp(D(i).name,'.')|strcmp(D(i).name,'..')|strcmp(D(i).name,'Thumbs.db'))
        imgcount = imgcount + 1; % Number of all images in the training database
    end
end

%creating the image matrix X of column matrix
X = [];
for i = 1 : imgcount
    str = strcat(datapath,'/in00000',int2str(i),'.jpg');%%>>
    img = imread(str);
    img = rgb2gray(img);
    img= im2double(img);%**
    [r, c] = size(img);
    temp = reshape(img',r*c,1); 
    X = [X temp];              
end

%converting column to row matrix
X=X'; 

%calculating SVD of X
[U,S,V] = svd(X,'econ');


%background and foreground calculation
vt= V';
A_back = U(:,1:1) .* S(1:1,1:1) .* vt(1:1,:);
A_fore = U(:,2:9) * S(2:9,2:9) * vt(2:9,:); 


% original, background and foreground image of 9th image

i_org = reshape(X(9,:), c, r);
figure; imshow(i_org');
i_back = reshape(A_back(9,:),c,r); 
figure; imshow(i_back');
i_fore = reshape(A_fore(9,:),c,r); 
figure; imshow(i_fore');







