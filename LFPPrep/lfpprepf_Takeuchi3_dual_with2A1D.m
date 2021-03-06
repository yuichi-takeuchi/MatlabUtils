function [ flag ] = lfpprepf_Takeuchi3_dual_with2A1D( datfilenamebase, sr, srLFP,  nChannels)
%
% [ flag ] = lfpprepf_Takeuchi3_dual_with2A1D( datfilenamebase, sr, srLFP, nChannels)
%
% This function DC removes, extracts dig and stim waves from the
% original dat file
%
% INPUTS:
%   datfilenamebase: base name of the .dat file to be read
%   nChannels: total number of recording channels
% 
% Copyright (C) 2017�2020 Yuichi Takeuchi
%

flag = 0;

% Resampling dat file
disp('resampling dat file...')
m = memmapfile([datfilenamebase '.dat'], 'format', 'int16');
d = m.data;
d = reshape(d, nChannels, []);
dDs = d(:,1:floor(sr/srLFP):end);
disp('resampling done')
[flag] = fileiof_writeInt16DatFile(dDs,[datfilenamebase '_DSampled.dat']);
fprintf('fileiof_writeInt16DatFile flag = %s\n', flag)

% Extract the digital channel
disp('extracting a digital channel...')
apf_ExtractChannels([datfilenamebase '_DSampled.dat'],...
                    [datfilenamebase '_dig.dat'],...
                    [63],...
                    nChannels);
disp('channel extraction done.')

% Extract the stim waveform channel
disp('extracting analog input channels...')
apf_ExtractChannels([datfilenamebase '_DSampled.dat'],...
                    [datfilenamebase '_adc_1.dat'],...
                    [61],...
                    nChannels);
apf_ExtractChannels([datfilenamebase '_DSampled.dat'],...
                    [datfilenamebase '_adc_2.dat'],...
                    [62],...
                    nChannels);
disp('extracting analog channels done.')

channelvector = [2 1 3 ...
                5 6 4 ...
                8 7 9 ...
                11 12 10 ...
                14 13 15 ...
                17 16 18 ...
                20 21 19 ...
                23 22 24 ...
                26 25 27 ...
                29 30 28;
                30 31 33 ...
                35 36 34 ...
                38 37 39 ...
                41 42 40 ...
                44 43 45 ...
                47 46 48 ...
                50 51 49 ...
                53 52 54 ...
                56 55 57 ...
                59 60 58 ...
                ];

for i = 1:2
    % Reorganize channels from .dat file without stim and digital input channels
    disp('headstage inputs...')
    apf_ExtractChannels([datfilenamebase '_DSampled.dat'],...
                        [datfilenamebase '_reorg.dat'],...
                        channelvector(i,:),...
                        nChannels);
	fprintf('extraction of HS inputs of subject%d done.\n', i)

    % Remove DC from analog and headstage input channels file
    disp('removing DC shifts from analog channels...')
    % [returnVar,msg] = RemoveDCfromDat([datfilenamebase '_stim.dat'], 1);
    [returnVar,msg] = RemoveDCfromDat([datfilenamebase '_reorg.dat'], 30);
    [returnVar,msg] = RemoveDCfromDat([datfilenamebase '_adc_' num2str(i) '.dat'], 1);
    fprintf('DC removals of subject%d done.\n', i)

    % Low-pass filtering LFP data
    disp('Low-pass filtering...')
    filtf_LowPassButter1([datfilenamebase '_reorg.dat'],...
                    [datfilenamebase '_LFP_reorgtemp.dat'],...
                    30,...
                    floor(srLFP)/2,...
                    3,...
                    srLFP);
    % or filtf_LowPassButter2 for previous Matlab version
    fprintf('Low-pass filtering of subject%d done.\n', i)

    % High-pass filtering LFP data
    disp('High-pass filtering...')
    filtf_HighPassButter1([datfilenamebase '_LFP_reorgtemp.dat'],...
                    [datfilenamebase '_LFP_reorg.dat'],...
                    30,...
                    0.3,...
                    3,...
                    srLFP);
    % or filtf_LowPassButter2 for previous Matlab version
    fprintf('Hight-pass filtering of subject%d done.\n', i)
    copyfile([datfilenamebase '_LFP_reorg.dat'], [datfilenamebase '_LFP_reorg_' num2str(i) '.dat'])
end

% deleting unnecessary files
delete([datfilenamebase '_DSampled.dat'])
delete([datfilenamebase  '_reorg.dat'])
delete([datfilenamebase '_LFP_reorgtemp.dat'])
delete([datfilenamebase '_LFP_reorg.dat'])

flag = 1;