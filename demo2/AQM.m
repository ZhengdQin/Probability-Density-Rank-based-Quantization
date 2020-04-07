function [WCenNum,chooseSeries] = AQM(input,d1,d2,KNNpara)
[inputSet,inputDimension] = size(input);
[IDX,dis] = knnsearch(input,input,'k',10*KNNpara);
probx = sum(dis<d1,2)/inputSet;

[sortInput,seq] = sort(probx,'descend');
WCenNum = 0;
seq_term = seq;
chooseSeries = [];




while ~isempty(seq_term)
    [~,r2_term_data] = find(dis(seq_term(1),:)<d2);
    [cover_data,~] = find(seq_term == IDX(seq_term(1),r2_term_data));
    chooseSeries = [chooseSeries,seq_term(1)];
    seq_term(cover_data) = [];
    WCenNum = WCenNum+1;
end

% 
% % [~,order] = sort(seq,'descend');
% interval = inputSet/quantNum;
% series = round(1+(0:quantNum-1)*interval);
% series = [series,inputSet];
% 
% 
% quantSerial = seq(series(1:end-1));
% quantInput = input(quantSerial,:);
% quantProb = prob3(quantSerial);


if inputDimension==2
    figure;
    hold on
    plot(input(:,1),input(:,2),'*')
    plot(input(chooseSeries,1),input(chooseSeries,2),'ro')
end
end