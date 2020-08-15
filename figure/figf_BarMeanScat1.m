function [ hs ] = figf_BarMeanScat1( idVec, dataVec, cndtnVec, fignum )
%
% Copyright (C) 2020 Yuichi Takeuchi

unqX = unique(cndtnVec);
indX = 1:length(unqX);
for i = indX
    cdata{i} = dataVec(cndtnVec == i);
end
barY = cellfun(@mean, cdata);

hfig = figure(fignum);
hax = axes; % subplot
hold(hax,'on');
hb = bar(hax, indX, barY);

unqIdVec = unique(idVec);

for i = 1:length(unqIdVec)
    idx = idVec == unqIdVec(i);
    xpi = cndtnVec(idx) + 0.25*(rand(size(cndtnVec(idx)))-0.5);
    switch mod(i,12)
        case 1
            hsct(i) = plot(hax, xpi, dataVec(idx), 'o');
        case 2
            hsct(i) = plot(hax, xpi, dataVec(idx), '+');
        case 3
            hsct(i) = plot(hax, xpi, dataVec(idx), '*');
        case 4
            hsct(i) = plot(hax, xpi, dataVec(idx), 'x');
        case 5 
            hsct(i) = plot(hax, xpi, dataVec(idx), 's');
        case 6
            hsct(i) = plot(hax, xpi, dataVec(idx), 'd');
        case 7
            hsct(i) = plot(hax, xpi, dataVec(idx), '^');
        case 8
            hsct(i) = plot(hax, xpi, dataVec(idx), 'v');
        case 9
            hsct(i) = plot(hax, xpi, dataVec(idx), '>');
        case 10
            hsct(i) = plot(hax, xpi, dataVec(idx), '<');
        case 11
            hsct(i) = plot(hax, xpi, dataVec(idx), 'p');
        case 12
            hsct(i) = plot(hax, xpi, dataVec(idx), 'h');
        otherwise
            hsct(i) = plot(hax, xpi, dataVec(idx), '.');
    end
end

hold(hax,'off');

hylabel = ylabel('');
hxlabel = xlabel('');
htitle = title('');

% Building the output handle structure
hs.fig = hfig;
hs.ax = hax;
hs.bar = hb;
hs.sct = hsct;
hs.ylbl = hylabel;
hs.xlbl = hxlabel;
hs.ttl = htitle;

end

