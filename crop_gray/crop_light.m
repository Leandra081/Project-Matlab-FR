%a preprocessing code for FR which generates gray images
%need landmarks as the input, for LFW database

A=importdata('lfw_landmark.txt'); 
L=A.data;
NameList=A.textdata;
dir='D:/imgCopy/data_lfw_50/lfw';  %the path of original lfw images
newdir='D:/imgCopy/data_lfw_50/LFW_Test2'; %the saving path of cropped lfw images 
ec_mc_y=48;
ec_y=40;
crop_size=128;
img_size=128;


%提取眼睛嘴巴坐标  一行两个值xy，第一行左眼，第二行右眼，第三行鼻子 第四/五行嘴巴
num=size(L,1);
%num=1;
for i1=1:num
    n=[dir,'/',NameList{i1}];
    if (exist(n) == 0)
        continue;
    end
    img=imread(n);
    la=L(i1,:);
    f5pt=zeros(5,2);
    f5pt(1,:)=la(1,1:2);
    f5pt(2,:)=la(1,3:4);
    f5pt(3,:)=la(1,5:6);
    f5pt(4,:)=la(1,7:8);  
    f5pt(5,:)=la(1,9:10);
    
    %align
    [img2, eyec, img_cropped, resize_scale] = align(img, f5pt, crop_size, ec_mc_y, ec_y);
    img_final = imresize(img_cropped, [img_size img_size], 'Method', 'bicubic');
    if size(img_final,3)>1
        img_final = rgb2gray(img_final);
    end
    S = regexp(NameList{i1}, '/', 'split');
    save_path = [newdir,'/',S{1}];
    if ~exist(save_path,'file')
        mkdir(save_path);
    end
    save_name = [newdir,'/',NameList{i1}];
    imwrite(img_final, save_name);
end



