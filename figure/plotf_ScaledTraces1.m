function [hp]=plotf_ScaledTraces1(hax,t,data,ChGroup)
%
% Copyright (C) 2018-2022 Yuichi Takeuchi

% axis off
hold(hax,'on')
for i=1:numel(ChGroup)
    srcWave=data(ChGroup(i),:);
    srcWave=srcWave+2*i-numel(ChGroup)-1;
    hp{i}=plot(t,srcWave,'k','LineWidth', 0.1);
end
hold(hax,'off')