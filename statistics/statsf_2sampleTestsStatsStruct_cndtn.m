function [ sStatsTest ] = statsf_2sampleTestsStatsStruct_cndtn( dataVec, cndtnVec )
%
% This function returns structures statistical tests.
%
% INPUTS:
%    dataVec: 
%    cndtnVec: grouping vector
% OUTPUT:
%    sStatsTest: structure for statistical tests
%
% Copyright (c) 2020 Yuichi Takeuchi
%

data1 = dataVec(cndtnVec == 0);
data2 = dataVec(cndtnVec == 1);

% statistical test
sStatsTest.TTest2 = stats_BuildStructTTest2(data1, data2);
sStatsTest.RankSum = stats_BuildStructRankSum(data1, data2);
sStatsTest.KSTest2 = stats_BuildStructKSTest2(data1, data2);

end


