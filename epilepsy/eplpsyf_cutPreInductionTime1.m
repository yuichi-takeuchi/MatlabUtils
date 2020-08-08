function [ flag ] = eplpsyf_cutPreInductionTime1(DataStruct, cParams)
%
% Copyright (C) 2020 Yuichi Takeuchi

% Main procedure
disp('start analysis...');tic
flag = 0;
for DataNo = 1:length(DataStruct)
    Data = DataStruct(DataNo);
    Timestamp = Data.Timestamp;
    datfilenameVec = Data.datfilename;
    for RatNo = 1:length(datfilenameVec)
        datfilename = Data.datfilename{RatNo};
        disp(datfilename)
        fprintf('RatNo: %d\n', RatNo)
        for TrialNo = 1:size(Timestamp{1,cParams.TSbit},1) % TrialNo = 1:size(Timestamp{1,cParams.TSbit},1)-1
            fprintf('TrialNo: %d\n', TrialNo)
            % Data access, extraction of a period
            TS = Timestamp{1,cParams.TSbit}(TrialNo,:);
            Segment = [TS(1)-cParams.BaselineDrtn, TS(1)+cParams.TestDrtn];
            [ segData ] = fileiof_getSegmentFromBinary1( ['tmp/' datfilename], Segment, cParams.nChannel );
            % write a dat file
            [flag] = fileiof_writeInt16DatFile(segData, ['tmp/' datfilename(1:(end-4)) '_trial' num2str(TrialNo) '.dat']);
        end
    end
end
flag = 1;
disp('done');toc
