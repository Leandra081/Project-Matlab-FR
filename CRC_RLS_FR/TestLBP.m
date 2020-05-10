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
load(['AR_DAT']);%LBP feature mat file
%load('img438.mat');
%tic;

tt_dat=NewTest_DAT;
tr_dat=NewTrain_DAT;
trls=trainlabels;
ttls=testlabels;

%projection matrix computing
Proj_M = inv(tr_dat'*tr_dat+kappa*eye(size(tr_dat,2)))*tr_dat';

%-------------------------------------------------------------------------
%testing
ID = [];
Er = [];
for indTest = 1:size(tt_dat,2)
    [id,error]    = CRC_RLS2(tr_dat,Proj_M,tt_dat(:,indTest),trls);
    ID      =   [ID id];
    Er      =   [Er,error'];  %横坐标样本，纵坐标类别
end
cornum      =   sum(ID==ttls);
Rec         =   [cornum/length(ttls)]; % recognition rate

fprintf(['recogniton rate is ' num2str(Rec),'\n']);
%fprintf(['Average residual is ' num2str(sum(Er)/size(Er,2)),'\n']);
%save('disc400LBP2.mat','disc_set','disc_value','Mean_Image');