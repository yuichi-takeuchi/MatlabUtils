function [ hs ] = figf_ScatGroupedRefline1( hax, xData, yData, idVec, coef, R )
%
% Copyright (C) 2020 Yuichi Takeuchi

hold(hax,'on');
unqIdVec = unique(idVec);
for i = 1:length(unqIdVec)
    idx = idVec == unqIdVec(i);
    switch mod(i,12)
        case 1
            hscttr(i) = scatter(hax, xData(idx), yData(idx), 'o');
        case 2
            hscttr(i) = scatter(hax, xData(idx), yData(idx), '+');
        case 3
            hscttr(i) = scatter(hax, xData(idx), yData(idx), '*');
        case 4
            hscttr(i) = scatter(hax, xData(idx), yData(idx), 'x');
        case 5 
            hscttr(i) = scatter(hax, xData(idx), yData(idx), 's');
        case 6
            hscttr(i) = scatter(hax, xData(idx), yData(idx), 'd');
        case 7
            hscttr(i) = scatter(hax, xData(idx), yData(idx), '^');
        case 8
            hscttr(i) = scatter(hax, xData(idx), yData(idx), 'v');
        case 9
            hscttr(i) = scatter(hax, xData(idx), yData(idx), '>');
        case 10
            hscttr(i) = scatter(hax, xData(idx), yData(idx), '<');
        case 11
            hscttr(i) = scatter(hax, xData(idx), yData(idx), 'p');
        case 12
            hscttr(i) = scatter(hax, xData(idx), yData(idx), 'h');
        otherwise
            hscttr(i) = scatter(hax, xData(idx), yData(idx), '.');
    end
end

hrl = refline(coef(1), coef(2));

hold(hax,'off');

str = ['   {\it r} = ', num2str(R(1,2))];
htxt = text(min(get(gca, 'xlim')), max(get(gca, 'ylim')), str);

hylbl = ylabel('');
hxlbl = xlabel('');
httl = title('');

% Building the output handle structure
hs.ax = hax;
hs.scttr = hscttr;
hs.rl = hrl;
hs.txt = htxt;
hs.ylbl = hylbl;
hs.xlbl = hxlbl;
hs.ttl = httl;

end

