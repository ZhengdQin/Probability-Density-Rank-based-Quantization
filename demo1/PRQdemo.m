%% data formating
% clusters = rand(1,2000);
% data = randn(1,2000);
% for i=1:2000
%     if clusters(i)>=0.4
%         data(i) = data(i)*0.5+2.5;
%     end
% end
%% PRQ
load 1D_Gaussian
dataSize = length(data);
para.approxType = 'Parzen';
codeBookNum = 5;
sigma = 0.4;
[quantInput,quantSerial,seq,parzenRst] = PRQ(data',sigma,codeBookNum);

probDensity = parzenRst/sum(parzenRst);

%% Estimated Prob Density and Codebook
figure; 
k = round(1:dataSize/codeBookNum:dataSize);
k = [k,dataSize];
for i = 1:codeBookNum
   plot(data(seq(k(i):k(i+1))),probDensity(seq(k(i):k(i+1))),'.')
   hold on
   plot(data(seq(k(i))),probDensity(seq(k(i))),'o')
end
xlabel('1-D Gaussian data')
ylabel('Estimated Probability Densities')

%% Ranked Sequence and Codebook
figure;
for i = 1:codeBookNum
   plot(k(i):k(i+1),probDensity(seq(k(i):k(i+1))),'.')
   hold on
   plot(k(i),probDensity(seq(k(i))),'o')
end
xlabel('Ranked Sequence')
ylabel('Estimated Probability Densities')