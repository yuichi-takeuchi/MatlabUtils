function [ hs ] = figf_BarMeanIndpndPlot3( idVec, dataVec, cndtnVec1, cndtnVec2, randCoeff, hax )
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
hb = bar(hax, indX, barY, 'stacked');

unqIdVec = unique(idVec);
unqCndtn2 = unique(cndtnVec2);
for i = 1:length(unqIdVec)
    for j = 1:length(unqCndtn2)
        idx = idVec == unqIdVec(i) & cndtnVec2 == j;
        xpi = cndtnVec1(idx) + randCoeff*(rand(size(cndtnVec1(idx)))-0.5);
        xmat = reshape(xpi, 2, []);
        ymat = reshape(dataVec(idx), 2, []);
        switch mod(i,12)
            case 1
                chplt{j,i} = plot(hax, xmat, ymat, '--o', 'Color', defaultColor(1));
            case 2
                chplt{j,i} = plot(hax, xmat, ymat, '--+', 'Color', defaultColor(2));
            case 3
                chplt{j,i} = plot(hax, xmat, ymat, '--*', 'Color', defaultColor(3));
            case 4
                chplt{j,i} = plot(hax, xmat, ymat, '--x', 'Color', defaultColor(4));
            case 5 
                chplt{j,i} = plot(hax, xmat, ymat, '--s', 'Color', defaultColor(5));
            case 6
                chplt{j,i} = plot(hax, xmat, ymat, '--d', 'Color', defaultColor(6));
            case 7
                chplt{j,i} = plot(hax, xmat, ymat, '--^', 'Color', defaultColor(7));
            case 8
                chplt{j,i} = plot(hax, xmat, ymat, '--v', 'Color', mean([defaultColor(1);defaultColor(2)]));
            case 9
                chplt{j,i} = plot(hax, xmat, ymat, '-->', 'Color', mean([defaultColor(3);defaultColor(4)]));
            case 10
                chplt{j,i} = plot(hax, xmat, ymat, '--<', 'Color', mean([defaultColor(5);defaultColor(6)]));
            case 11
                chplt{j,i} = plot(hax, xmat, ymat, '--p', 'Color', mean([defaultColor(7);defaultColor(1)]));
            case 12
                chplt{j,i} = plot(hax, xmat, ymat, '--h', 'Color', mean([defaultColor(2);defaultColor(3)]));
            otherwise
                chplt{j,i} = plot(hax, xmat, ymat, '--.', 'Color', [0 0 0]);
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

