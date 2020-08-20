function [ hs ] = figf_BarPlot2(hax, srcX, srcY)
%
% Copyright (C) 2019, 2020 Yuichi Takeuchi

hold(hax,'on');
hb = bar(srcX, srcY);
hold(hax,'off');

hylbl = ylabel('');
hxlbl = xlabel('');
httl = title('');
hlgnd = legend('');

% Building the output handle structure
hs.ax = hax;
hs.bar = hb;
hs.ylbl = hylbl;
hs.xlbl = hxlbl;
hs.ttl = httl;
hs.lgnd = hlgnd;

end

