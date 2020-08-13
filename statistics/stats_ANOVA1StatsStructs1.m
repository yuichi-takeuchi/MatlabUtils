function [ sStatsTest ] = stats_ANOVA1StatsStructs1( y, group)
% 
% INPUTS:
%    y: data vecotr to be analyzed
%    group: linear factor
% OUTPUT:
%    sStatsTest: structure for statistical tests
%
% Copyright(c) 2020 Yuichi Takeuchi
%

[p,tbl,stats] = anova1(y, group, 'off') ;
c = multcompare(stats, 'display', 'off');

sStatsTest.PValues = p;
sStatsTest.Table = tbl;
sStatsTest.Structure = stats;
sStatsTest.MultiComp = c;


