function [ DataOut ] = fileiof_getChannelsFromBinary1( srcName, Channels, nChannels )
%
% INPUTS:
%    srcName: Name string of source dat file (eg. 'source.dat')
%    Channels: Channels to take
%    nChannels: Total number of channels in the source dat file
% OUTPUT:
%    DataOut: Int16 output variable
%
% Copyright (c)2017, 2022 Yuichi Takeuchi
%

infoFile = dir(srcName);
nSamples = floor(infoFile.bytes/(nChannels*2));

m = memmapfile(srcName,'Format', {'int16', [nChannels nSamples], 'x'});

disp('getting channels...')
% h = waitbar(0,'getting channels...');
DataOut = zeros(length(Channels),nSamples);
for i = 1:length(Channels)
%     waitbar(i/length(Channels))
    DataOut(i,:) = m.Data.x(Channels(i),:);
end

% close(h)
disp('done')




