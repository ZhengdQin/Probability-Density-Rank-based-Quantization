%数据的输入为（数据量*数据维度）

function [quantInput,quantSerial,quantProb] = KNNSQF(input,KNNpara,quantNum)
%sort quantizing
[inputSet,inputDimension] = size(input);
[IDX,dis] = knnsearch(input,input,'k',KNNpara);
probx = 1./dis(:,KNNpara).^inputDimension/sum(1./dis(:,KNNpara).^inputDimension);
prob2 = sum(probx(IDX),2);
prob3 = sum(prob2(IDX),2);
[~,seq] = sort(prob3,'descend');
interval = inputSet/quantNum;
series = round(1+(0:quantNum-1)*interval);
series = [series,inputSet];


quantSerial = seq(series(1:end-1));
quantInput = input(quantSerial,:);
quantProb = prob3(quantSerial);

if inputDimension==2
    figure;
    hold on
    plot(input(:,1),input(:,2),'*')
    plot(quantInput(:,1),quantInput(:,2),'ro')
end
end

