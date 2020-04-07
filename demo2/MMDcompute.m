function MMDvalue = MMDcompute(trainSet,WQ_VQIT,kernelSize)
    trainNum = length(trainSet);
    dataAll = [trainSet,WQ_VQIT'];
    KernelAll = zeros(trainNum+30,trainNum+30);
	for i = 1:trainNum+30
        KernelAll(i,:) = ker_eval(dataAll(:,i),dataAll,'Gauss',kernelSize);
    end
    chooseSeries = 1:30;
    unchooseSeries = 31:trainNum+30;
    trainSetSeries = [chooseSeries,unchooseSeries];
    linearKernelSort = KernelAll(trainSetSeries,trainSetSeries);
    chosPart = sum(sum(linearKernelSort(1:30,1:30)));
    alldata = sum(sum(linearKernelSort));
    corrPart = sum(sum(linearKernelSort(1:30,:)));
    MMDvalue = sqrt(chosPart/(30^2)+alldata/(trainNum^2)-2*corrPart/(trainNum*30));
end
