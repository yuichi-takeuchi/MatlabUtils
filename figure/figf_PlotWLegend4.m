function [ hs ] = figf_PlotWLegend4( hax, srcMatX, srcMatY, CLeg)
% Copyright (C) 2020 Yuichi Takeuchi

hold(hax,'on');
for i = 1:size(srcMatY, 1)
    hplt(i) = plot(hax, srcMatX, srcMatY(i,:));
end
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
