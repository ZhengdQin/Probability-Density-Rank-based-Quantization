function [WCenter,WCenNum,chooseSeries] = QuantW(W,epsInitial,delta)
Dimension = size(W,1);
D = size(W,2);
WCenter = zeros(Dimension,D);
epsilon = zeros(Dimension,1);
L = zeros(Dimension,1);

%initial
WCenter(:,1) = W(:,1);
L(1) = 1;
epsilon(1) = epsInitial;
WCenNum = 1;
chooseSeries = ones(1,length(W));
%iteration
for i = 2:D
    dimension = sum((W(:,i)*ones(1,WCenNum)-WCenter(:,1:WCenNum)).^2);
    [va,index] = min(dimension);
    if va >= epsilon(index)
        WCenNum = WCenNum+1;
        WCenter(:,WCenNum) = W(:,i);
        L(WCenNum) = 1;
        epsilon(WCenNum) = epsInitial;
        chooseSeries(WCenNum) = i;
    elseif (L(index) > delta)&&(va >= (epsilon(index)/2))
        epsilon(index) = epsilon(index)/2;
        WCenNum = WCenNum+1;
        chooseSeries(WCenNum) = i;
        WCenter(:,WCenNum) = W(:,i);
        L(WCenNum) = 1;
        epsilon(WCenNum) = epsilon(index);
    else
        L(WCenNum) = L(WCenNum)+1;
    end
end
chooseSeries = chooseSeries(1:WCenNum);
end