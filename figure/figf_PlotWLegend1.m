function [ hs ] = figf_PlotWLegend1( srcMatX, srcMatY, CLeg, fignum )
%
%
% Copyright (C) 2017, 2019 Yuichi Takeuchi

hfig = figure(fignum);
hax = axes; % subplot
hold(hax,'on');
for i = 1:size(srcMatY, 1)
    hp(i) = plot(hax, srcMatX, srcMatY(i,:),'-o');
end
hold(hax,'off');
box('off')
hylabel = ylabel('');
hxlabel = xlabel('');
htitle = title('');
hlgnd = legend(CLeg);

% building handle structure
hs.hfig = hfig;
hs.hax = hax;
hs.hp = hp;
hs.hylabel = hylabel;
hs.hxlabel = hxlabel;
hs.htitle = htitle;
hs.hlgnd = hlgnd;

end

