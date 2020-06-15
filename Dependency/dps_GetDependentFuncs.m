% Copyright (c) 2017 Yuichi Takeuchi
%% get info
filename = 'lfppreps_Takeuchi5_Template_OpenEphys';
[fList,pList] = matlab.codetools.requiredFilesAndProducts(filename);
for i = 1:length(fList)
    disp(fList(i))
end

%%%
%Copy dependencies to dep sub folder made in current folder
mkdir dep
for i=1:length(fList)
    C = strsplit(fList{i},'\');
    system(['copy ' fList{i} ' ' pwd '\dep\' C{length(C)}]);
end

clear C i

%% deleting 
clear fList pList