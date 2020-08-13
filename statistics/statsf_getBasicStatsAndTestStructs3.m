function [ sBasicStats, sStatsTest ] = statsf_getBasicStatsAndTestStructs3( dataVec, cndtnVec )
%
% This function returns structures containing results of discriptive
% statistics and statistical tests.
% 
% Usage:
%   [ sBasicStats, sStatsTest ] = statsf_getBasicStatsAndTestStructs2( data1, data2 )
%
% INPUTS:
%    dataVec: 
%    cndtnVec: grouping vector
% OUTPUT:
%    sBasicStats: structure for basic statistics
%    sStatsTest: structure for statistical tests
%
% Copyright (c) 2020 Yuichi Takeuchi
%
    
% calculating basic statistics
[ Mean, Std, Sem, Prctile ] = stats_Summary2( dataVec, cndtnVec );
sBasicStats.Mean = Mean;
sBasicStats.Std = Std;
sBasicStats.Sem = Sem;
sBasicStats.Prctile = Prctile;

% statistical test
sStatsTest.TTest2 = stats_BuildStructTTest2(data1, data2);
sStatsTest.RankSum = stats_BuildStructRankSum(data1, data2);
sStatsTest.KSTest2 = stats_BuildStructKSTest2(data1, data2);

end


