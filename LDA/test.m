
load('PCARes161.mat');% PCA�����Ľ��������ttls trls tt_dat tr_dat �ɻ������Լ�����Ľ��


%LDA��ά
Ldim=200;                                     %LDAά��
Class=161;                                    %ѵ���������Ŀ
NumPerClass=100;                              %ѵ����ÿ���ͼƬ��Ŀ
[sw sb]=computswb(tr_dat',Class,NumPerClass);           %�������/����ɢ�����ԭ���밴��Ϊ������������Ҫת�ú�����
vsort1=projectto(sw,sb,Ldim);                 %LDAͶӰ����
tt_dat=(tt_dat'*vsort1)';                     %ͶӰ��ת�û���
tr_dat=(tr_dat'*vsort1)';                     %ͶӰ��ת�û���
