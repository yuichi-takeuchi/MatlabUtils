function [TSCell]=digchf_dig2TimestampCell2(digch)
%
% [ TSCell ] = digchf_dig2Timestamp2( digch )
%
% This function gives an index matrix for the three brain states of two rats from input
% logical vector matrix.
%
% INPUT:
%   digch: time series vector of a 4 bit digital channel
% OUTPUT:
%   TSCell: time * channel (logical matrix)
% 
% Copyright (C) 2018-2022 Yuichi Takeuchi
%

% Get binary vector
vect_x = zeros(length(digch),4);
for i = 1:length(digch)
    vect_x(i,1:4)=bitget(digch(i),1:4);
% bin_x=dec2bin(digch);
% [num bits]=size(bin_x);
% vect_x=str2num(bin_x(:));
% vect_x=reshape(vect_x,num,bits);
% flp_vect_x=flip(vect_x,2);
end
digBinaryVector = logical(vect_x); 

% Get timestamps and build a timestamp structure
for i = 4:-1:1
    [~,tempR,tempF] = ssf_FindConsecutiveTrueChunks(digBinaryVector(:,i)');
    tempRF = uint64([tempR' tempF']);
    TSCell{i} = tempRF;
end

% Save
% TSStruct = TSStruct(1:3);
% save([datfilenamebase '_1_Timestamp.mat'], 'TSStruct', '-v7.3')





