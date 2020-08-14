function [ hs ] = figf_BarMeanIndpndPlot1( idVec, dataVec, cndtnVec, hax )
%
% Copyright (C) 2020 Yuichi Takeuchi

unqX = unique(cndtnVec);
indX = 1:length(unqX);
for i = indX
    cdata{i} = dataVec(cndtnVec == i);
end

tmpbarY = cellfun(@mean, cdata);

barY = zeros(numel(tmpbarY));
for i = 1:length(numel(tmpbarY))
    barY(i,i) = tmpbarY(i);
end

hold(hax,'on');
hb = bar(hax, indX, barY, 0.5, 'stacked');

unqIdVec = unique(idVec);

for i = 1:length(unqIdVec)
    idx = idVec == unqIdVec(i);
    xpi = cndtnVec(idx) + 0.25*(rand(size(cndtnVec(idx)))-0.5);
    switch mod(i,12)
        case 1
            hplt(i) = plot(hax, xpi, dataVec(idx), '--o');
        case 2
            hplt(i) = plot(hax, xpi, dataVec(idx), '--+');
        case 3
            hplt(i) = plot(hax, xpi, dataVec(idx), '--*');
        case 4
            hplt(i) = plot(hax, xpi, dataVec(idx), '--x');
        case 5 
            hplt(i) = plot(hax, xpi, dataVec(idx), '--s');
        case 6
            hplt(i) = plot(hax, xpi, dataVec(idx), '--d');
        case 7
            hplt(i) = plot(hax, xpi, dataVec(idx), '--^');
        case 8
            hplt(i) = plot(hax, xpi, dataVec(idx), '--v');
        case 9
            hplt(i) = plot(hax, xpi, dataVec(idx), '-->');
        case 10
            hplt(i) = plot(hax, xpi, dataVec(idx), '--<');
        case 11
            hplt(i) = plot(hax, xpi, dataVec(idx), '--p');
        case 12
            hplt(i) = plot(hax, xpi, dataVec(idx), '--h');
        otherwise
            hplt(i) = plot(hax, xpi, dataVec(idx), '--.');
    end
end

hold(hax,'off');

hylabel = ylabel('');
hxlabel = xlabel('');
htitle = title('');

% Building the output handle structure
hs.ax = hax;
hs.bar = hb;
hs.plt = hplt;
hs.ylbl = hylabel;
hs.xlbl = hxlabel;
hs.ttl = htitle;

end

