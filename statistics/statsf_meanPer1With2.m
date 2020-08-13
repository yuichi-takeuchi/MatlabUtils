function [MeanVec, dstId, dstCndtnVec] = statsf_meanPer1With2(data, cndtn1, cndtn2)
% Copyright (c) Yuichi Takeuchi

unq1 = unique(cndtn1); % animal id
unq2 = unique(cndtn2); % experimental condition goes to x axis of anova1 lator
ref1 = sort(unq1);
ref2 = sort(unq2);
MeanVec = [];
dstId = [];
dstCndtnVec = [];
for i = 1:length(ref2)
    for j = 1:length(ref1)
        cCond{j} = data(cndtn1 == ref1(j) & cndtn2 == ref2(i));
        dstId = [dstId ref1(j)];
        dstCndtnVec = [dstCndtnVec ref2(i)];
    end    
    tmpMean = cellfun(@mean, cCond);
    MeanVec = [MeanVec tmpMean];
end

end
