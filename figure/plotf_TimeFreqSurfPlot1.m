function [hs]=plotf_TimeFreqSurfPlot1(t,f,data,fignum,hax,nrmlzres,scaleFactor)
% plots time-frequency surface plot 
%
% Usage:
% [ hs ] = plotf_TimeFreqSurfPlot1( t, f, data, haxes )
% Input: 
%   t: time in second
%   f: frequency in Hz
%   data: f x t, normalized at color resolution
%   fignum: number of a target figure
%   hax: handle of the target axis
%   nrmlzres: resolution for normalization
%   scaleFactor: 1 for whole colormap range, 2 for the half
% Output:
%   hs: strucure of handles
%   
% Copyright (C) 2018-2022 Yuichi Takeuchi

hfig=figure(fignum);
hcm=colormap(jet(nrmlzres));

hsrf=pcolor(hax,t,f,data);
caxis([0 nrmlzres/scaleFactor]);
axis tight;
shading interp;  
set(hsrf,...
    'EdgeColor', 'none');

hylbl=ylabel('');
hxlbl=xlabel('');
httl=title('');

% building handle structure
hs.fig=hfig;
hs.ax=hax;
hs.srf=hsrf;
hs.ylbl=hylbl;
hs.xlbl=hxlbl;
hs.ttl=httl;
hs.hcm=hcm;

end

