function [ hs ] = figf_BarMeanScat1( idVec, dataVec, cndtnVec, fignum )
%
% Copyright (C) 2020 Yuichi Takeuchi

unqX = unique(cndtnVec);
indX = 1:length(unqX);
cdata{indX} = dataVec(cndtnVec == indX);
barY = cellfun(@mean, cdata);

hfig = figure(fignum);
hax = axes; % subplot
hold(hax,'on');
hb = bar(hax, indX, barY);

unqIdVec = unique(idVec);

for i = 1:length(unqIdVec)
    xpi = cndtnVec + 0.25*(rand(size(cndtnVec))-0.5);
    switch mod(i,12)
        case 1
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), 'o');
        case 2
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), '+');
        case 3
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), '*');
        case 4
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), 'x');
        case 5 
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), 's');
        case 6
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), 'd');
        case 7
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), '^');
        case 8
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), 'v');
        case 9
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), '>');
        case 10
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), '<');
        case 11
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), 'p');
        case 12
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), 'h');
        otherwise
            hsct(i) = plot(hax, xpi, dataVec(idVec == unqIDVec(i)), '.');
    end
end

hold(hax,'off');

hylabel = ylabel('');
hxlabel = xlabel('');
htitle = title('');

% Building the output handle structure
hs.hfig = hfig;
hs.hax = hax;
hs.hb = hb;
hs.hsct = hsct;
hs.hylabel = hylabel;
hs.hxlabel = hxlabel;
hs.htitle = htitle;

end

