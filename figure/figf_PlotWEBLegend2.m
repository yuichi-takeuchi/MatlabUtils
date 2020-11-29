function [ hs ] = figf_PlotWEBLegend2( hax, srcMatX, srcMatY, srcMatEB, CLeg)
%
%
% Copyright (C) 2020 Yuichi Takeuchi

hold(hax,'on');
for i = 1:size(srcMatY,2)
    heb(i) = errorbar(hax, srcMatX, srcMatY(:,i), srcMatEB(:,i), 'k-o');
end
hold(hax,'off');
hylbl = ylabel('');
hxlbl = xlabel('');
httl = title('');
hlgnd = legend(CLeg, 'Box', 'Off');

% building handle structure
hs.eb = heb;
hs.ylbl = hylbl;
hs.xlbl = hxlbl;
hs.ttl = httl;
hs.lgnd = hlgnd;

end

