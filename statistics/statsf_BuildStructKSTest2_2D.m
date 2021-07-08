function [ destStruct ] = statsf_BuildStructKSTest2_2D( srcMat1, srcMat2 )
%
%   two-sample KS test along the 3rd dimension
% 
% Output arg
%     destStruct = struct(...
%         'h', h_2D,...
%         'p', p_2D,...
%         'stats', stats_2D...
%         );
%   
% Copyright (C) 2021 Yuichi Takeuchi
%

[dimnum1,dimnum2,~] = size(srcMat1);
[h_2D,p_2D,stats_2D] = deal(zeros(dimnum1,dimnum2));

for i = 1:dimnum1
    for j = 1:dimnum2
        srcVec1 = squeeze(srcMat1(i,j,:));
        srcVec2 = squeeze(srcMat2(i,j,:));

        [h,p,ks2stat] = kstest2(srcVec1, srcVec2);

        h_2D(i,j) = h;
        p_2D(i,j) = p;
        stats_2D(i,j) = ks2stat;        
    end
end

destStruct = struct(...
    'h', h_2D,...
    'p', p_2D,...
    'stats', stats_2D...
    );

end

