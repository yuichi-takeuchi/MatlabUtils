function [ sStatsTest ] = statsf_getKruskalWallisStatsStructs1( dataVec, grpVec, ctype, display)
% 
% INPUTS:
%    dataVec: data vecotr to be analyzed
%    grpVec: grouping vector
%
% Copyright(c) 2021 Yuichi Takeuchi
%

% statistical test
[p, tbl, stats] = kruskalwallis(dataVec, grpVec, display);
c = multcompare(stats, 'CType', ctype, 'display', display);
sStatsTest.PValues = p;
sStatsTest.Table = tbl;
sStatsTest.Structure = stats;
sStatsTest.MultiComp = c;


