
load('PCARes161.mat');% PCA计算后的结果，包含ttls trls tt_dat tr_dat 可换成子自己计算的结果


%LDA降维
Ldim=200;                                     %LDA维度
Class=161;                                    %训练集类别数目
NumPerClass=100;                              %训练集每类的图片数目
[sw sb]=computswb(tr_dat',Class,NumPerClass);           %计算类间/类内散射矩阵原代码按行为样本，所以需要转置后输入
vsort1=projectto(sw,sb,Ldim);                 %LDA投影矩阵
tt_dat=(tt_dat'*vsort1)';                     %投影后转置回来
tr_dat=(tr_dat'*vsort1)';                     %投影后转置回来
