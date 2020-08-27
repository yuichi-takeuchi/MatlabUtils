function [ Mean, Std, Sem, Prctile ] = stats_Summary3( data1, data2 )
%
% [ Mean, Std, Sem, Prctile ] = stats_Summary3( data1, data2 )
%   
% caluculation on two independent data
%   
% Copyright (C) 2019, 2020 Yuichi Takeuchi
%

data1 = data1(:);
data2 = data2(:);

Mean = zeros(1, 2);
Std = zeros(1, 2);
Sem = zeros(1, 2);
Prctile = zeros(7, 2);

Mean(1) = mean(data1, 'omitnan');
Std(1) = std(data1, 'omitnan');
Sem(1) = sem(data1);
Prctile(:,1) = prctile(data1, [0 10 25 50 75 90 100]);

Mean(2) = mean(data2, 'omitnan');
Std(2) = std(data2, 'omitnan');
Sem(2) = sem(data2);
Prctile(:,2) = prctile(data2, [0 10 25 50 75 90 100]);
