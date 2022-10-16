function [ hstruct ] = unf_UnitCharactorization2( UnitInfo, fignum, outputfilenamebase )
%   
% (C) 2022 Yuichi Takeuchi
%

hfig = figure(fignum); arrayfun(@cla,gca)

% PSTH plot
% h(1).haxes = subplot(4,3,1);
t = UnitInfo.PSTH.Time;
CCGR = UnitInfo.PSTH.CCG;
CCGMean = UnitInfo.PSTH.CCGMean;
Global = UnitInfo.PSTH.Global;
Local = UnitInfo.PSTH.Local;
Title = 'PSTH';
[ hstruct ] = unf_CCG_PlotMeanGlbLcl1( t, CCGR, CCGMean, Global, Local, Title );
h.hylabel = ylabel('#Spikes');
h.hxlabel = xlabel('Time (ms)');
h.htitle = hstruct.htitle;
yl = get(gca, 'YLim');
p = patch([0 1000 1000 0],[yl(1) yl(1) yl(2) yl(2)],'r');
set(p,'FaceAlpha',0.25,'edgecolor','none');

% Parameter settings
% Parameters
fontname = 'Arial';
fontsize = 6;

set(hfig,...
    'PaperUnits', 'centimeters',...
    'PaperPosition', [0 00 6 6],...
    'PaperSize', [6 6]...
    );

set(h.htitle,...
    'FontName', fontname,...
    'FontSize', fontsize...
    );

% file output
print(['../results/' outputfilenamebase '.pdf'], '-dpdf');

hstruct.hfig = hfig;
end

