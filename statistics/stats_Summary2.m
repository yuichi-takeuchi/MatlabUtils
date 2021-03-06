function [ Mean, Std, Sem, Prctile ] = stats_Summary2( dataVec, cndtnVec )
%
% stats_Summary2( dataVec, cndtnVec )
%   
% Copyright (C) 2017�2020 Yuichi Takeuchi
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

end

