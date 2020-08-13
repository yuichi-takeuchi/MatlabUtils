function [sBasicStats] = stats_sBasicStats_anova1( dataVec, cndtnVec )
%   
% Copyright (C) 2020 Yuichi Takeuchi
%

Mean = zeros(1, length(unique(cndtnVec)));
Std = zeros(1, length(unique(cndtnVec)));
Sem = zeros(1, length(unique(cndtnVec)));
Prctile = zeros(7, length(unique(cndtnVec)));

RefValue = sort(unique(cndtnVec));

for i = 1:length(unique(cndtnVec))
    Value = dataVec(cndtnVec == RefValue(i));
    
    Mean(i) = nanmean(Value);
    Std(i) = nanstd(Value);
    Sem(i) = nansem(Value);
    Prctile(:,i) = prctile(Value, [0 10 25 50 75 90 100]);
end

sBasicStats.Mean = Mean;
sBasicStats.Std = Std;
sBasicStats.Sem = Sem;
sBasicStats.Prctile = Prctile;

end

