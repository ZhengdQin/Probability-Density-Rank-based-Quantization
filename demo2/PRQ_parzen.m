%数据的输入为（数据量*数据维度）

function [quantInput,quantSerial,seq,parzenRst] = PRQ_parzen(input,sigma,codeBookNum)
%sort quantizing
[inputSet,~] = size(input);
parzenRst = zeros(inputSet,1);
for ii = 1:inputSet
    parzenRst(ii) = sum(exp(-sum((ones(inputSet,1)...
        *input(ii,:)-input).^2/(2*sigma^2),2)));
end
[~,seq] = sort(parzenRst,'descend');
interval = inputSet/codeBookNum;
series = round(1+(0:codeBookNum-1)*interval);
quantInput = input(seq(series),:);
quantSerial = seq(series);
quantSerial = quantSerial';


% if inputDimension==2
%     figure;
%     hold on
%     plot(input(:,1),input(:,2),'*')
%     plot(quantInput(:,1),quantInput(:,2),'ro')
% end
end

