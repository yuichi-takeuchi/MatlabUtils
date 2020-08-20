function [ hs ] = figf_PlotWLegend3( hax, srcMatX, srcMatY, CLeg)
% Copyright (C) 2020 Yuichi Takeuchi

hold(hax,'on');
hplt = plot(hax, srcMatX, srcMatY);
hold(hax,'off');
box('off')
hylbl = ylabel('');
hxlbl = xlabel('');
httl = title('');
hlgnd = legend(CLeg);

% building handle structure
hs.ax = hax;
hs.plt = hplt;
hs.ylbl = hylbl;
hs.xlbl = hxlbl;
hs.ttl = httl;
hs.lgnd = hlgnd;

end
