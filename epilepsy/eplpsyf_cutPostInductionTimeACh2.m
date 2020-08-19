function [ flag ] = eplpsyf_cutPostInductionTimeACh2(DataStruct, cParams)
% for open-loop interventions
% Copyright (C) 2020 Yuichi Takeuchi

% Main procedure
disp('start analysis...');tic
flag = 0;
nChannel = 1;
for RatNo = 1:length(DataStruct)
    Data = DataStruct(RatNo);
    Timestamp = Data.Timestamp;
    if isempty(Timestamp{1,cParams.TSbit})
        continue
    end
    datafilenamebase = Data.datafilenamebase;
    disp(datafilenamebase)
    fprintf('RatNo: %d\n', RatNo)
    idx = find(Data.idxslct);
    for TrialNo = 1:length(idx) % TrialNo = 1:size(Timestamp{1,cParams.TSbit},1)-1
        fprintf('TrialNo: %d\n', TrialNo)
        % Data access, extraction of a period
        TS = Timestamp{1,cParams.TSbit}(idx(TrialNo),:);
        Segment = [TS(1)-cParams.BaselineDrtn+2*cParams.sr, TS(1)+cParams.TestDrtn+2*cParams.sr]; % stimulus duration: 2 s
        switch RatNo
            case 1
                theOtherRatNo = 2;
            case 2
                theOtherRatNo = 1;
            otherwise
                therOtherRatNo = RatNo;
        end
               
        [ segData ] = fileiof_getSegmentFromBinary1( ['tmp/' datafilenamebase '_adc_' num2str(theOtherRatNo) '.dat'], Segment, nChannel );
        % write a dat file
        [flag] = fileiof_writeInt16DatFile(segData, ['tmp/' datafilenamebase '_adc_' num2str(RatNo) '_trial' num2str(TrialNo) '.dat']);
    end
end
flag = 1;
disp('done');toc
