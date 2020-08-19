function [ hs ] = figf_BarMeanIndpndPlot2( idVec, dataVec, cndtnVec1, cndtnVec2,  hax )
%
% Copyright (C) 2020 Yuichi Takeuchi

unqX = unique(cndtnVec1);
indX = 1:length(unqX);
for i = indX
    cdata{i} = dataVec(cndtnVec1 == i);
end

tmpbarY = cellfun(@mean, cdata);

barY = zeros(numel(tmpbarY));
for i = 1:length(tmpbarY)
    barY(i,i) = tmpbarY(i);
end

hold(hax,'on');
hb = bar(hax, indX, barY, 0.7, 'stacked');

unqIdVec = unique(idVec);
unqCndtn2 = unique(cndtnVec2);
for i = 1:length(unqIdVec)
    for j = 1:length(unqCndtn2)
        idx = idVec == unqIdVec(i) & cndtnVec2 == j;
        xpi = cndtnVec1(idx) + 0.45*(rand(size(cndtnVec1(idx)))-0.5);
        xmat = reshape(xpi, length(unqX), []);
        ymat = reshape(dataVec(idx), length(unqX), []);
        switch mod(i,12)
            case 1
                chplt{j,i} = plot(hax, xmat, ymat, '--o', 'Color', [0 0.4470 0.7410]);
            case 2
                chplt{j,i} = plot(hax, xmat, ymat, '--+', 'Color', [0.8500 0.3250 0.0980]);
            case 3
                chplt{j,i} = plot(hax, xmat, ymat, '--*', 'Color', [0.9290 0.6940 0.1250]);
            case 4
                chplt{j,i} = plot(hax, xmat, ymat, '--x', 'Color', [0.4940 0.1840 0.5560]);
            case 5 
                chplt{j,i} = plot(hax, xmat, ymat, '--s', 'Color', [0.4660 0.6740 0.1880]);
            case 6
                chplt{j,i} = plot(hax, xmat, ymat, '--d', 'Color', [0.3010 0.7450 0.9330]);
            case 7
                chplt{j,i} = plot(hax, xmat, ymat, '--^', 'Color', [0.6350 0.0780 0.1840]);
            case 8
                chplt{j,i} = plot(hax, xmat, ymat, '--v', 'Color', [1 0 0]);
            case 9
                chplt{j,i} = plot(hax, xmat, ymat, '-->', 'Color', [0 1 0]);
            case 10
                chplt{j,i} = plot(hax, xmat, ymat, '--<', 'Color', [0 0 1]);
            case 11
                chplt{j,i} = plot(hax, xmat, ymat, '--p', 'Color', [0 1 1]);
            case 12
                chplt{j,i} = plot(hax, xmat, ymat, '--h', 'Color', [1 0 1]);
            otherwise
                chplt{j,i} = plot(hax, xmat, ymat, '--.', 'Color', [1 1 0]);
        end
    end
end

hold(hax,'off');

hylabel = ylabel('');
hxlabel = xlabel('');
htitle = title('');

% Building the output handle structure
hs.ax = hax;
hs.bar = hb;
hs.cplt = chplt;
hs.ylbl = hylabel;
hs.xlbl = hxlabel;
hs.ttl = htitle;

end

