% =========================================================================
%   Lei Zhang, Meng Yang, and Xiangchu Feng,
%   "Sparse Representation or Collaborative Representation: Which Helps Face
%    Recognition?" in ICCV 2011.
%
%
% Written by Meng Yang @ COMP HK-PolyU
% July, 2011.
% =========================================================================
                      
%close all;
%clear all;
%
% -------------------------------------------------------------------------
% parameter setting
par.nClass        =   100;                 % the number of classes in the subset of AR database
par.nDim          =   400;                 % the eigenfaces dimension
kappa             =   [0.001];             % l2 regularized parameter value

%--------------------------------------------------------------------------
%data loading (here we use the AR dataset as an example)
load(['AR_DAT']);
%load('img438.mat');
%load('discNew400.mat');%PCA project matrix
%tic;
%Tr_DAT   =   double(NewTrain_DAT(:,trainlabels<=par.nClass));
%trls     =   trainlabels(trainlabels<=par.nClass);
%Tt_DAT   =   double(NewTest_DAT(:,testlabels<=par.nClass));
%ttls     =   testlabels(testlabels<=par.nClass);
%clear NewTest_DAT NewTrain_DAT testlabels trainlabels

%--------------------------------------------------------------------------
%eigenface extracting
[disc_set,disc_value,Mean_Image]  =  Eigenface_f(Tr_DAT,par.nDim);
tr_dat  =  disc_set'*Tr_DAT;
tt_dat  =  disc_set'*Tt_DAT;
tr_dat  =  tr_dat./( repmat(sqrt(sum(tr_dat.*tr_dat)), [par.nDim,1]) );
tt_dat  =  tt_dat./( repmat(sqrt(sum(tt_dat.*tt_dat)), [par.nDim,1]) );

%-------------------------------------------------------------------------
%projection matrix computing
%Proj_M = inv(tr_dat'*tr_dat+kappa*eye(size(tr_dat,2)))*tr_dat';

%-------------------------------------------------------------------------
%testing
ID = [];
cor= [];
Er=[];

for indTest = 1:size(tt_dat,2)
    cor=[];
    for kk=1:size(tr_dat,2)
        y=tt_dat(:,indTest);
        x=tr_dat(:,kk);
        score=dot(x,y)/(norm(x)*norm(y));
        cor= [cor score];
    end
        [cdis,order]=sort(cor,'descend');
        ID      =   [ID trls(order(1))];
        Er      =   [Er;cor];  %纵坐标样本，横坐标类别
end
cornum      =   sum(ID==ttls);
Rec         =   [cornum/length(ttls)]; % recognition rate

fprintf(['recogniton rate is ' num2str(Rec),'\n']);
%fprintf(['Average residual is ' num2str(sum(Er)/size(Er,2)),'\n']);
%save('disc400New2.mat','disc_set','disc_value','Mean_Image');
