function [ hs ] = figf_BarAsStackedHist1( hax, data, idVec, edges, normalization)
% Copyright (C) 2020 Yuichi Takeuchi

unqIdVec = unique(idVec);
N = zeros(length(edges)-1, length(unqIdVec));
for i = 1:length(unqIdVec)
    idx = idVec == unqIdVec(i);
    trgtData = data(idx);
    switch normalization
        case 'probability'
            [n,~] = histcounts(trgtData,edges, 'Normalization', normalization);
            n = n./length(unqIdVec);
        otherwise
            [n,~] = histcounts(trgtData,edges);
    end
	N(:,i) = n';
end

ctrs = (edges(1:end-1)+edges(2:end))/2;

hold(hax,'on');
hbr = bar(hax, ctrs, N, 1, 'stacked');
hold(hax,'off');
box('off')

hylabel = ylabel('');
hxlabel = xlabel('');
htitle = title('');

% Building the output handle structure
hs.ax = hax;
hs.bar = hbr;
hs.ylbl = hylabel;
hs.xlbl = hxlabel;
hs.ttl = htitle;

end

