function [ flag ] = figsf_checkTimedTracesOfGroups2( RecInfo, DataStruct, cParams)
%
% Copyright (C) 2018–2020 Yuichi Takeuchi

disp('processing...');tic
flag = 0;
for DataNo = 1:length(DataStruct)
    Data = DataStruct(DataNo);
%     for RatNo = 1:length(Data.datfilename)
    RatNo = DataNo;
    % dat file data access
    datfilename = Data.datfilename{RatNo}; 
    disp(datfilename)
    fprintf('RatNo: %d\n', RatNo)
    for TrialNo = 1:size(Data.Timestamp{1,cParams.TSbit},1)
        fprintf('TrialNo: %d\n', TrialNo)
        % Cut the data and remove the stimulus artifact
        TS = Data.Timestamp{1,cParams.TSbit}(TrialNo,:);
        Segment = [TS(1)-cParams.BaselineDrtn, TS(1)+cParams.TestDrtn];
        [ segData ] = fileiof_getSegmentFromBinary1( ['tmp/' datfilename], Segment, cParams.nChannel );
        segData(:, [30*RecInfo.srLFP:(32*RecInfo.srLFP - 1)]) = 0;
        [ segDatasc ] = apf_ScaleUnitV( segData,  400, 16, 10, 1e3); % scaling to mV
        t = 0:1/cParams.sr:(size(segDatasc,2)-1)/cParams.sr;

        % figure
        fignum = 1;
        [ hs ] = figf_VoltageTracesOfSubGroups1( t, segDatasc, cParams.ChOrder, cParams.ChLabel, fignum);

        % figure title
%         Title = [RecInfo.datString{DataNo} '_Rat' num2str(RecInfo.LTR(RatNo)) '_Trial' num2str(TrialNo)];
        Title = [RecInfo.datString{1} '_Rat' num2str(RecInfo.LTR(RatNo)) '_Trial' num2str(TrialNo)];
        reptitle = strrep(Title, '_', '-');
        axes;
        htitle = title(reptitle);
        axis off;

        % Figure output
        print(['../results/Traces_' Title '.png'], '-dpng');
        set(gcf,'Renderer','Painters');
        print(['../results/Traces_' Title '.pdf'], '-dpdf');
        close(gcf)
    end
%     end
end
flag = 1;
disp('done');toc
