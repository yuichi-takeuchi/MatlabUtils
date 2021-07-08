function [ destStruct ] = statsf_BuildStructTTest2_2D( srcMat1, srcMat2 )
%
%   ttest2 along the 3rd dimension
%
% Output arg
%     destStruct = struct(...
%         'h', h_2D,...
%         'p', p_2D,...
%         'ci', ci_2D,...
%         'stats', stats_2D...
%         );
%   
% Copyright (C) 2021 Yuichi Takeuchi
%

[dimnum1,dimnum2,~] = size(srcMat1);
[h_2D,p_2D] = deal(zeros(dimnum1,dimnum2));
[ci_2D,stats_2D] = deal(cell(dimnum1,dimnum2));

for i = 1:dimnum1
    for j = 1:dimnum2
        srcVec1 = squeeze(srcMat1(i,j,:));
        srcVec2 = squeeze(srcMat2(i,j,:));

        [h,p,ci,stats] = ttest2(srcVec1,srcVec2);

        h_2D(i,j) = h;
        p_2D(i,j) = p;
        ci_2D{i,j} = ci;
        stats_2D{i,j} = stats;      
    end
end

destStruct = struct(...
    'h', {h_2D},...
    'p', {p_2D},...
    'ci', {ci_2D},...
    'stats', {stats_2D}...
    );

end

