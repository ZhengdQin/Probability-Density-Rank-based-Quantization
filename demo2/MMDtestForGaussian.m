%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PRQ comparison
%Copyright QZD 
%CNEL
%2016-8-16 15:47:32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear;
kernelType = 'Gauss';
load data 
MC = 1;
SNnum = 1;
for SN = 1:SNnum
trainNum = 1000;
dimension = 2;
trainSet = data;
desireTrain = zeros(1,trainNum);
dist = zeros(trainNum,trainNum);
for i = 1:trainNum
    dist(i,:) = sum(bsxfun(@minus,trainSet(:,i),trainSet).^2);
end
Kernel = zeros(trainNum,trainNum);
delta = sqrt(median(dist(:)));
kernelSize = 1/(2*delta^2);
tic;
for i = 1:trainNum
    Kernel(i,:) = ker_eval(trainSet(:,i),trainSet,kernelType,kernelSize);
end
sampleNum = 30;
lambda = 0.01;
%% ===========random appropriate==========
rdmpara.approxType = 'random';
rdmpara.Param = 0; %there is no parameter for rdm
rdmpara.sampleNum = sampleNum;
[MMDRdm,RmdChoose] = MMD_gaussian(trainSet,Kernel,rdmpara);

%% ============PRQ-parzen=========

KNNpara.approxType = 'Parzen';
KNNpara.Param = 0.8;  %this is delta for Parzen
KNNpara.sampleNum = sampleNum;
[MMDPRQ1,PRQChoose1] = MMD_gaussian(trainSet,Kernel,KNNpara);

%% ============PRQ-KNN=========

KNNpara.approxType = 'KNN';
KNNpara.Param = 50;  %this is delta for KNN
KNNpara.sampleNum = sampleNum;
[MMDPRQ2,PRQChoose2] = MMD_gaussian(trainSet,Kernel,KNNpara);

%% ===============VQ  ============

VQpara.approxType = 'VQ';
VQpara.Param = 0.85; 
VQpara.sampleNum = sampleNum;
[MMDVQ,VQChoose] =  MMD_gaussian(trainSet,Kernel,VQpara);

% ===============DSQ  ============
DSQpara.approxType = 'DSQ';
DSQpara.Param = [19,17.8]; 
DSQpara.sampleNum = sampleNum;
[MMDDQS,DQSChoose] = MMD_gaussian(trainSet,Kernel,DSQpara);

% ===============DMC  ============
DMCpara.approxType = 'DMC';
DMCpara.Param = 37;  
DMCpara.sampleNum = sampleNum;
[MMDDMC,DMCChoose] = MMD_gaussian(trainSet,Kernel,DMCpara);

% ===============AQM  ============
AQMpara.approxType = 'AQM';
AQMpara.Param = [0.6,0.95,30]; 
AQMpara.sampleNum = sampleNum;
[MMDAQM,AQMChoose] = MMD_gaussian(trainSet,Kernel,AQMpara);

%% ===============kmeans  ============

KMpara.approxType = 'kmeansNearest';
KMpara.sampleNum = sampleNum;
[MMDKM,KMChoose] =  MMD_gaussian(trainSet,Kernel,KMpara);

end

figure; 
subplot(2,4,1)
plot(data(1,:),data(2,:),'o')
hold on
plot(data(1,PRQChoose1),data(2,PRQChoose1),'*')
xlabel('x_1')
ylabel('x_2') 
title('PSQ-Parzen(M=30)')
subplot(2,4,2)
plot(data(1,:),data(2,:),'o')
hold on
plot(data(1,PRQChoose2),data(2,PRQChoose2),'*')
xlabel('x_1')
ylabel('x_2') 
title('PSQ-KNN(M=30)')
subplot(2,4,3)
plot(data(1,:),data(2,:),'o')
hold on
plot(data(1,RmdChoose),data(2,RmdChoose),'*')
xlabel('x_1')
ylabel('x_2') 
title('Random(M=30)')
subplot(2,4,4); plot(data(1,:),data(2,:),'o')
hold on
plot(data(1,VQChoose),data(2,VQChoose),'*')
xlabel('x_1')
ylabel('x_2') 
title('VQ(M=30)')
subplot(2,4,5);plot(data(1,:),data(2,:),'o')
hold on
plot(data(1,DQSChoose),data(2,DQSChoose),'*')
xlabel('x_1')
ylabel('x_2') 
title('DQS(M=30)')
subplot(2,4,6);plot(data(1,:),data(2,:),'o')
hold on
plot(data(1,KMChoose),data(2,KMChoose),'*')
xlabel('x_1')
ylabel('x_2') 
title('Kmeans(M=30)')
subplot(2,4,7);plot(data(1,:),data(2,:),'o')
hold on
plot(data(1,AQMChoose),data(2,AQMChoose),'*')
xlabel('x_1')
ylabel('x_2') 
title('AQM(M=30)')
subplot(2,4,8);plot(data(1,:),data(2,:),'o')
hold on
plot(data(1,DMCChoose),data(2,DMCChoose),'*')
xlabel('x_1')
ylabel('x_2') 
title('DMC(M=30)')
fprintf('MMD result: \nRdm: %.4f \nPRQ_Parzen: %.4f \nPRQ_KNN: %.4f \nVQ: %.4f \nDQS: %.4f \nKmeans: %.4f \nAQM: %.4f \nDMC: %.4f', MMDRdm, MMDPRQ1,MMDPRQ2,MMDVQ,MMDDQS,MMDKM,MMDAQM,MMDDMC)

