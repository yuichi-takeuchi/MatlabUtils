function [ indForSeparation, gmdist ] = fitf_gmm2fitFor1DdataSeparation2( data, xRange )
%
% Copyright (c) 2019, 2020 Yuichi Takeuchi

numGaussian = 2;
gmdist = fitgmdist(data, numGaussian);
gmsigma = gmdist.Sigma;
gmmu = gmdist.mu;
gmwt = gmdist.ComponentProportion;
x = linspace(xRange(1), xRange(2), 1000);
fit1 = pdf(gmdist, x');
fit2 = pdf('Normal', x, gmmu(1), gmsigma(1)^0.5)*gmwt(1);
fit3 = pdf('Normal', x, gmmu(2), gmsigma(2)^0.5)*gmwt(2);

indForSeparation = find(diff(abs((fit2 > fit3))))-1;

end

