function [ sBasicStats ] = statsf_sBasicStats1( data1, data2 )
%
% INPUTS:
%    data1,2 (vector): data with independent values
%
% Copyright (c) 2022 Yuichi Takeuchi
%
    
% calculating basic statistics
[ Mean, Std, Sem, Prctile ] = stats_Summary3( data1, data2 );
sBasicStats.Mean = Mean;
sBasicStats.Std = Std;
sBasicStats.Sem = Sem;
sBasicStats.Prctile = Prctile;

end


