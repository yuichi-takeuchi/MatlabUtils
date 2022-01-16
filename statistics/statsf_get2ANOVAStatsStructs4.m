function [ sStatsTest ] = statsf_get2ANOVAStatsStructs4( dataVec, grpVec, linVec, Model, Ctype, Vernames, Display)
%
% This function returns structures containing results of discriptive
% statistics and statistical tests.
% 
% INPUTS:
%    dataVector: data vecter to be analyzed
%    grpVec: grouping vecter
%    linVector: linear factor
%
% Copyright(c) 2022 Yuichi Takeuchi
%

% statistical test (two-way ANOVA with multicompare)
[p, tbl, stats, terms] = anovan(dataVec, {grpVec, linVec}, 'model', Model, 'varnames', Vernames, 'display', Display);
c = multcompare(stats, 'Dimension',[1 2], 'CType', Ctype, 'display', Display);
sStatsTest.PValues = p;
sStatsTest.Table = tbl;
sStatsTest.Structure = stats;
sStatsTest.Terms = terms;
sStatsTest.MultiComp = c;


