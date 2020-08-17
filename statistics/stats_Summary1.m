function [ Mean, Std, Sem, Prctile ] = stats_Summary1( srcMat )
%
% [ Mean, Std, Sem, Prctile ] = stats_Summary1( srcMat )
%
% caluculation arong column
%   
% Copyright (C) 20017, 2020Yuichi Takeuchi
%

Mean = mean(srcMat,'omitnan');
Std = std(srcMat, 'omitnan');
Sem = sem(srcMat);
Prctile = prctile(srcMat, [0 10 25 50 75 90 100]);

end

