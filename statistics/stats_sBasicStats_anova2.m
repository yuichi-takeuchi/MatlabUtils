function [sBasicStats] = stats_sBasicStats_anova2( dataVec, linVec, logicalInd )
%   
% Copyright (C) 2022 Yuichi Takeuchi
%

Off = dataVec(~logicalInd);
OffLin = linVec(~logicalInd);
On  = dataVec(logicalInd);
OnLin = linVec(logicalInd);

% calculating basic statistics
[ MeanOff, StdOff, SemOff, PrctileOff ] = stats_Summary2( Off, OffLin );
[ MeanOn, StdOn, SemOn, PrctileOn ] = stats_Summary2( On, OnLin );

sBasicStats.Mean = [MeanOff; MeanOn];
sBasicStats.Std = [StdOff; StdOn];
sBasicStats.Sem = [SemOff; SemOn];
sBasicStats.Prctile = [PrctileOff; PrctileOn];
