function [ sBasicStats, sStatsTest ] = statsf_getBasicStatsAndTestStructs2( data1, data2 )
%
% This function returns structures containing results of discriptive
% statistics and statistical tests.
% 
% Usage:
%   [ sBasicStats, sStatsTest ] = statsf_getBasicStatsAndTestStructs2( data1, data2 )
%
% INPUTS:
%    data1,2 (vector): data with independent values
% OUTPUT:
%    sBasicStats: Cell vector, each element of which contains
%    sStatsTest: structure for statistical tests
%
% Copyright (c) 2019, 2020 Yuichi Takeuchi
%
    
% calculating basic statistics
[ Mean, Std, Sem, Prctile ] = stats_Summary3( data1, data2 );
sBasicStats.Mean = Mean;
sBasicStats.Std = Std;
sBasicStats.Sem = Sem;
sBasicStats.Prctile = Prctile;

% statistical test
sStatsTest.TTest2 = stats_BuildStructTTest2(data1, data2);
sStatsTest.RankSum = stats_BuildStructRankSum(data1, data2);
sStatsTest.KSTest2 = stats_BuildStructKSTest2(data1, data2);

end


