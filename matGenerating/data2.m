%data for CRC 提取LBP特征
%训练集和测试集按数字编码身份；每个数字命名的文件夹里面为所有训练图片
%这里是mask FR项目专用，因此区分了mask和unmask，和实际用处有出入可以修改
Person=32;
%N=Person*Per;
A=[]; %temp train data
p=1;
trainlabels=[];
testlabels=[];
w=0;

for i1=1:Person
    %unmask6
    k1=i1;
    fileFolder=fullfile(['D:\imgCopy\mask\train\',num2str(k1)]);
    dirOutput=dir(fullfile(fileFolder,'*.jpg'));
    fileNames = {dirOutput.name};%6 imgs to A
    a=length(fileNames);
    %前30张
    Per=randi(a,1,100);
    for i2=1:a
        %i3= Per(i2);
        fileName = fileNames{1,i2};
        img = imread([fileFolder,'\',fileName]);
        %k1=(i1-1)*2+1;
        %img=imread(['E:\matlab\1projects\img\unmask_total\unmask (',num2str(k1),').jpg']);
        img1=rgb2gray(img);
        %img2=double(img1);
        img3 = imresize(img1,[100 100]);
        img3(55:100,:)=img3(55:100,:).*w;
        %imgg=lbp_rotation(img);
        img3=double(extractLBPFeatures(img3, 'CellSize', [20 20],'Normalization','None'));
        A(:,p)=img3(:);
        trainlabels=[trainlabels i1];
        p=p+1;
    end
    
end

for i1=162:Person
    %unmask6
    k1=i1;
    fileFolder=fullfile(['D:\imgCopy\mask_data\scheme2\train\',num2str(k1)]);
    dirOutput=dir(fullfile(fileFolder,'*.jpg'));
    fileNames = {dirOutput.name};%6 imgs to A
    a=length(fileNames);
    %前30张
    %Per=randi(a,1,100);
    for i2=1:a
        %i3=Per(i2);
        fileName = fileNames{1,i2};
        img = imread([fileFolder,'\',fileName]);
        %k1=(i1-1)*2+1;
        %img=imread(['E:\matlab\1projects\img\unmask_total\unmask (',num2str(k1),').jpg']);
        img1=rgb2gray(img);
        %img2=double(img1);
        img3 = imresize(img1,[100 100]);
        img3(55:100,:)=img3(55:100,:).*w;
        %imgg=lbp_rotation(img);
        img3=double(extractLBPFeatures(img3, 'CellSize', [20 20],'Normalization','None'));
        %A(:,p)=img3(:);
        trainlabels=[trainlabels i1];
       % p=p+1;
    end
    
end

%B
B=[];
p=1;
for i1=1:Person
    %mask3
    %k1=i1+72;
    fileFolder=fullfile(['D:\imgCopy\mask\test\',num2str(i1)]); %before
    dirOutput=dir(fullfile(fileFolder,'*.jpg'));
    fileNames = {dirOutput.name};%3 imgs to A
    a=length(fileNames);
    for i2=1:a
        %k2=i2+3;
        %k2=floor(a/2)+i2;
        fileName = fileNames{1,i2};
        img = imread([fileFolder,'\',fileName]);
        %k1=(i1-1)*2+1;
        %img=imread(['E:\matlab\1projects\img\unmask_total\unmask (',num2str(k1),').jpg']);
        img1=rgb2gray(img);
        %img2=double(img1);
        img3 = imresize(img1,[100 100]);
        img3(55:100,:)=img3(55:100,:).*w;
        %imgg=lbp_rotation(img);
        %img3=double(imgg(:));
        img3=double(extractLBPFeatures(img3, 'CellSize', [20 20],'Normalization','None'));
        B(:,p)=img3(:);
        testlabels=[testlabels i1];
        p=p+1;
    end
end

%[NewTest_DAT1,PS] = mapminmax(B');     %[NewTest_DAT,PS] = mapstd(B); mapminmax
%[NewTrain_DAT1,PS1] = mapminmax(A');     %[NewTrain_DAT,PS] = mapstd(A); 

%NewTest_DAT=B;
%NewTrain_DAT=A;

row=0;
NewTest_DAT=NormalizeFea(B,row);
NewTrain_DAT=NormalizeFea(A,row);


save('img32LBP.mat','NewTest_DAT','NewTrain_DAT','testlabels','trainlabels');



