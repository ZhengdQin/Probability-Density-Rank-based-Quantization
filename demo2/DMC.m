function [WCenNum,chooseSeries] = DMC(input,KNNpara)
[inputSet,inputDimension] = size(input);
[IDX,dis] = knnsearch(input,input,'k',4*KNNpara);
probx = 1./dis(:,KNNpara).^inputDimension/sum(1./dis(:,KNNpara).^inputDimension);
% prob2 = sum(probx(IDX),2);
% prob3 = sum(prob2(IDX),2);
[sortInput,seq] = sort(probx,'descend');
WCenNum = 0;
seq_term = seq;
chooseSeries = [];



while ~isempty(seq_term)
    r_term = dis(seq_term(1),KNNpara+1);
    [~,r2_term_data] = find(dis(seq_term(1),:)<2*r_term);
    [cover_data,~] = find(seq_term == IDX(seq_term(1),r2_term_data));
    chooseSeries = [chooseSeries,seq_term(1)];
    seq_term(cover_data) = [];
    WCenNum = WCenNum+1;
end


if inputDimension==2
    figure;
    hold on
    plot(input(:,1),input(:,2),'*')
    plot(input(chooseSeries,1),input(chooseSeries,2),'ro')
end
end