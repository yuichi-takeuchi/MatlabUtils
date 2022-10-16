function [tR,ccgR,ccgJM,pt,gb,GSPExc,GSPInh] = unf_CCG_jitter(spiket,spikeind,clu1,clu2,ccgBinSize,ccgHalfBins,jscale,njitter,sr)
%
%   [t,ccgR,ccgSM,pt,gb,GSPExc,GSPInh] = unf_CCG_jitter(spiket,spikeind,clu1,clu2,ccgBinSize,ccgHalfBins,jscale,njitter)
%  spiket, spikeind  : res file, clu file
%  clu1, clu2        : the cell numbers
%  ccgBizsize, ccgHalfBins : --> see 'CCG.m'
%  jscale            : jittering scale, unit is 'ms'
%  njitter           : # of jittering
%  sr: sampling rate
%  ccgR: ccg real
%  ccgJM: ccg jittered mean
%  pt = [pMax(:), pMin(:)];
%  gb = [gMax(:), pMin(:)];
%
% (C) 2022 Yuichi Takeuchi
% inspired by Shigeyoshi Fujisawa

alpha = 0.05;

% CCG for real
res1 = spiket(spikeind == clu1);
res2 = spiket(spikeind == clu2);

[ccg,tR,~,~] = CCG(double([res1; res2]), [ones(size(res1));2*ones(size(res2))], ccgBinSize, ccgHalfBins, sr, [1 2],'count');
ccgR = ccg(:,1,2);

% CCG for jittering data
ccgjmax = zeros(1,njitter);
ccgjmin = zeros(1,njitter);
for i=1:njitter
   res2_jitter = res2 + 2*((sr/1000)*jscale)*rand(size(res2))-1*(sr/1000)*jscale; 
   [ccg, tJ] = CCG([res1;res2_jitter],[ones(size(res1));2*ones(size(res2))], ccgBinSize, ccgHalfBins, sr,[1,2],'count');
   ccgj(:,i)=ccg(:,1,2);
   ccgjmax(i)=max(ccgj(:,i));
   ccgjmin(i)=min(ccgj(:,i));
end

%  Compute the pointwise line
signifpoint = njitter*alpha;
ccgjptMax = zeros(1,length(tJ));
ccgjptMin = zeros(1,length(tJ));
for i=1:length(tJ)
   sortjitterDescend  = sort(ccgj(i,:),'descend');
   sortjitterAscend   = sort(ccgj(i,:),'ascend');
   ccgjptMax(i) = sortjitterDescend(signifpoint);
   ccgjptMin(i) = sortjitterAscend(signifpoint);
end
pt = [ccgjptMax', ccgjptMin'];

%  Compute the global line
sortgbDescend   = sort(ccgjmax,'descend');
sortgbAscend    = sort(ccgjmin,'ascend');
ccgjgbMax  = sortgbDescend(signifpoint)*ones(size(tJ));
ccgjgbMin  = sortgbAscend(signifpoint)*ones(size(tJ));
gb = [ccgjgbMax', ccgjgbMin'];

% Mean
ccgJM  = mean(ccgj,2);

% Find significant period 
findExc = ccgR >= ccgjgbMax' & ccgR > 0;
findInh = ccgR <= ccgjgbMin' & ccgjgbMin' > 0;

GSPExc = zeros(size(tR));  % Global Significant Period of Excitation
GSPInh = zeros(size(tR));  % Global Significant Period of Inhibition

GSPExc(findExc) = 1;
GSPInh(findInh) = 1;

