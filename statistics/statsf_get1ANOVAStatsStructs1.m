function [ sStatsTest ] = statsf_get1ANOVAStatsStructs1( dataVec, grpVec, ctype, display)
% 
% INPUTS:
%    dataVec: data vecotr to be analyzed
%    grpVec: grouping vector
%
% Copyright(c) 2022 Yuichi Takeuchi
%

% statistical test
[p,tbl,stats] = anova1(dataVec, grpVec, display) ;
c = multcompare(stats, 'CType', ctype, 'display', display);
sStatsTest.PValues = p;
sStatsTest.Table = tbl;
sStatsTest.Structure = stats;
sStatsTest.MultiComp = c;


