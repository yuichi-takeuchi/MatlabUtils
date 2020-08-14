function [ hs, hplt ] = figf_BarMeanIndpndPlot1( idVec, dataVec, cndtnVec, hax )
%
% Copyright (C) 2020 Yuichi Takeuchi

unqX = unique(cndtnVec);
indX = 1:length(unqX);
for i = indX
    cdata{i} = dataVec(cndtnVec == i);
end

tmpbarY = cellfun(@mean, cdata);

barY = zeros(numel(tmpbarY));
for i = 1:length(tmpbarY)
    barY(i,i) = tmpbarY(i);
end

hold(hax,'on');
hb = bar(hax, indX, barY, 0.5, 'stacked');

unqIdVec = unique(idVec);
hsplt = {};
for i = 1:length(unqIdVec)
    idx = idVec == unqIdVec(i);
    xpi = cndtnVec(idx) + 0.25*(rand(size(cndtnVec(idx)))-0.5);
    xmat = reshape(xpi, length(unqX), []);
    ymat = reshape(dataVec(idx), length(unqX), []);
%     for j = 1:size(xmat,2)
        switch mod(i,12)
            case 1
                hplt = plot(hax, xmat, ymat, '--o');
            case 2
                hplt = plot(hax, xmat, ymat, '--+');
            case 3
                hplt = plot(hax, xmat, ymat, '--*');
            case 4
                hplt = plot(hax, xmat, ymat, '--x');
            case 5 
                hplt = plot(hax, xmat, ymat, '--s');
            case 6
                hplt = plot(hax, xmat, ymat, '--d');
            case 7
                hplt = plot(hax, xmat, ymat, '--^');
            case 8
                hplt = plot(hax, xmat, ymat, '--v');
            case 9
                hplt = plot(hax, xmat, ymat, '-->');
            case 10
                hplt = plot(hax, xmat, ymat, '--<');
            case 11
                hplt = plot(hax, xmat, ymat, '--p');
            case 12
                hplt = plot(hax, xmat, ymat, '--h');
            otherwise
                hplt = plot(hax, xmat, ymat, '--.');
        end
        hsplt = [hsplt; hplt];
%     end
end

hold(hax,'off');

hylabel = ylabel('');
hxlabel = xlabel('');
htitle = title('');

% Building the output handle structure
hs.ax = hax;
hs.bar = hb;
hs.ylbl = hylabel;
hs.xlbl = hxlabel;
hs.ttl = htitle;

end

