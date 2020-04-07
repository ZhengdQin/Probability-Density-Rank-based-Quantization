function [DSQsp,DSQdt,emptyN] = DSQCV_gaussian(trainSet,epmin,epmax,dtmin,dtmax)
% data formating
for i = epmin:1:epmax
    for j = dtmin:0.2:dtmax

epsilon = i;
delta = j;
 [~,cNum((i-epmin)+1,floor((j-dtmin)*5+1)),~] = QuantW(trainSet,epsilon,delta);
    end
end
emptyN = 0;
  for ii = 20:30
      [a,b] = find(cNum == ii);
      if isempty(a)
          [a,b] = find(cNum == ii-1);
          DSQsp(ii-19) = (a(1)-1)*1+epmin;
          DSQdt(ii-19) = (b(1)-1)*0.2+dtmin;
          emptyN = emptyN+1;
      end
      DSQsp(ii-19) = (a(1)-1)*0.2+epmin;
      DSQdt(ii-19) = (b(1)-1)*0.2+dtmin;
  end
  end