function [DataOut] = filtf_BandStopIIR3(DataIn, filtorder, lowlimit, highlimit, fs)
%
% default
% [DataOut] = filtf_BandStopIIR3(DataIn, lowlimit, highlimit, fs)
% fs = sampling frequency
% DataIn: (channels, time series)
%
% Copyright (C) 2021 Yuichi Takeuchi

% [lowpasscutoff, lowpassorder, fs] = DefaultArgs(varargin, {300, 3, 2e4});
% nyquistfreq = fs/2;
% fNorm = lowpasscutoff / (fs /2);
% [d,e] = butter(lowpassorder, fNorm, 'low');
   
d = designfilt('bandstopiir','FilterOrder',filtorder, ...
               'HalfPowerFrequency1',lowlimit,'HalfPowerFrequency2',highlimit, ...
               'DesignMethod','butter','SampleRate',fs);

for i = 1:size(DataIn, 1)
%     waitbar(i/size(DataIn, 1))
    DataOut(i,:) = filtfilt(d, double(DataIn(i,:)));
end
