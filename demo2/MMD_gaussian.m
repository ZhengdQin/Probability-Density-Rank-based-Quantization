function [MMDvalue, chooseSeries] = MMD_gaussian(trainSet,kernel,para)
trainNum = length(trainSet);
    
switch para.approxType
    case 'random'
        dataSeries = randperm(trainNum);
        chooseSeries = dataSeries(1:para.sampleNum);%para.M;
    case 'Parzen'
        [~,chooseSeries,~] = PRQ_parzen(trainSet',para.Param,...
            para.sampleNum);
    case 'KNN'
        [~,chooseSeries] = KNNSQF(trainSet',para.Param,para.sampleNum);
        chooseSeries = chooseSeries';
    case 'kmeansNearest'
        [~, ~,~,D] = kmeans(trainSet', para.sampleNum, 'Maxiter', 500);
        [~,chooseSeries] = min(D);
     case 'VQ'
         [~,~,~,~,~,chooseSeries] = VQ(trainSet,para.Param,zeros(1,length(trainSet)));
         chooseSeries = chooseSeries(1:para.sampleNum); 
     case 'DSQ'
         [~,~,chooseSeries] = QuantW(trainSet,para.Param(1),para.Param(2));
         para.sampleNum = length(chooseSeries); 
     case 'DMC'
         [~,chooseSeries] = DMC(trainSet',para.Param);
         para.sampleNum = length(chooseSeries); 
     case 'AQM'
         [~,chooseSeries] = AQM(trainSet',para.Param(1),para.Param(2),para.Param(3));
         para.sampleNum = length(chooseSeries); 
end
unchooseSeries = 1:trainNum;
unchooseSeries(:,chooseSeries) = [];
trainSetSeries = [chooseSeries,unchooseSeries];
linearKernelSort = kernel(trainSetSeries,trainSetSeries);
chosPart = sum(sum(linearKernelSort(1:para.sampleNum,1:para.sampleNum)));
alldata = sum(sum(linearKernelSort));
corrPart = sum(sum(linearKernelSort(1:para.sampleNum,:)));
MMDvalue = sqrt(chosPart/(para.sampleNum^2)+alldata/(trainNum^2)-2*corrPart/(trainNum*para.sampleNum));

end

