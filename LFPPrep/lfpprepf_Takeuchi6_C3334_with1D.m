function [Flag]=lfpprepf_Takeuchi6_C3334_with1D(datfilenamebase,sr,srLFP,nChannels)
%
% [Flab]=lfpprepf_Takeuchi6_C3334_with1D(datfilenamebase,sr,srLFP,nChannels)
%
% This function removes a DC shift, extracts a dig channel from the
% original dat file
%
% INPUTS:
%   datfilenamebase: base name of the .dat file to be read
%   nChannels: total number of recording channels
% 
% Copyright (C) 2022 Yuichi Takeuchi
%

% Resampling dat file
disp('resampling dat file...')
m = memmapfile([datfilenamebase '.dat'], 'format', 'int16');
d = m.data;
d = reshape(d, nChannels, []);
dDs = d(:,1:floor(sr/srLFP):end);
disp('resampling done')
[Flag] = fileiof_writeInt16DatFile(dDs,[datfilenamebase '_DSampled.dat']);
fprintf('fileiof_writeInt16DatFile flag = %s\n', Flag)

% Extract the digital channel
disp('extracting a digital channel...')
apf_ExtractChannels([datfilenamebase '_DSampled.dat'],...
                    [datfilenamebase '_dig.dat'],...
                    17,...
                    nChannels);
disp('channel extraction done.')

channelvector = [1 2 3 ...
                4 5 6 ...
                7 8 9 ...
                10 11 12 ...
                13 14 ...
                15 16 ...
                ];

% Reorganize channels from .dat file without stim and digital input channels
disp('headstage inputs...')
apf_ExtractChannels([datfilenamebase '_DSampled.dat'],...
                    [datfilenamebase '_reorg.dat'],...
                    channelvector,...
                    nChannels);
disp('extraction of HS inputs done.')

% Remove DC from analog and headstage input channels file
disp('removing DC shifts from channels...')
% [returnVar,msg] = RemoveDCfromDat([datfilenamebase '_stim.dat'], 1);
[returnVar,msg] = RemoveDCfromDat([datfilenamebase '_reorg.dat'], 16);
disp('DC removal done.')

% Low-pass filtering LFP data
disp('Low-pass filtering...')
filtf_LowPassButter1([datfilenamebase '_reorg.dat'],...
                [datfilenamebase '_LFP_reorgtemp.dat'],...
                16,...
                floor(srLFP)/2,...
                3,...
                srLFP);
% or filtf_LowPassButter2 for previous Matlab version
disp('Low-pass filtering of subject done.')

% High-pass filtering LFP data
disp('High-pass filtering...')
filtf_HighPassButter1([datfilenamebase '_LFP_reorgtemp.dat'],...
                [datfilenamebase '_LFP_reorg.dat'],...
                16,...
                0.3,...
                3,...
                srLFP);
% or filtf_LowPassButter2 for previous Matlab version
disp('Hight-pass filtering done.')

% deleting unnecessary files
delete([datfilenamebase '_DSampled.dat'])
delete([datfilenamebase  '_reorg.dat'])
delete([datfilenamebase '_LFP_reorgtemp.dat'])

Flag = 1;