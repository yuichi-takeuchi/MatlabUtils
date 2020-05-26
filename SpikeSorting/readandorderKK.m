function readandorderKK(filebase, cluster_group)

% USAGE:
%     readandorderKK(filebase, cluster_group)
%
% INPUTS:
%     filename: base name of the .kwik file to be read
%     cluster_group: vector with the "name" of the different
%     cluster_group, it can either start with 0 or 1,
%     example: filename = 'hybrid_10sec'
% 
% Note! modified by Yuichi on 12th Oct 2015

% Starting...
tic % -> aprox 5-10min per shank but depending on recording time...
disp('...');
disp(['Organizing kwik files for ' filebase]);
disp('.........');

for j = cluster_group(1):cluster_group(end) % number of shank
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reading Time Stamps...
    SR = h5readatt([filebase '.kwik'], ['/recordings/' num2str(j)], 'sample_rate');
    spkts = h5read([filebase '.kwik'], ['/channel_groups/' num2str(j) '/spikes/time_samples']);
       
    %Reading dat files belonging...
    spktsdat = h5read([filebase '.kwik'],['/channel_groups/' num2str(j) '/spikes/recording']);    
    %Correcting offset of dat files...
%    kk=0;
%    for i=min(unique(spktsdat)):max(unique(spktsdat))
%        kk=kk+1;
%        spktsoff(kk)=h5readatt([filename '.kwik'],['/recordings/' num2str(i)],'start_time');
%        spkts(find(spktsdat==i)) = spkts(find(spktsdat==i)) + spktsoff(kk)*SR;
%    end
%    clear i kk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    % Reading and Renaming Clusters...
    clu = h5read([filebase '.kwik'],['/channel_groups/' num2str(j) '/spikes/clusters/main']);
    cluster_names = unique(clu);

    % setting noise as 0 and MUA as 1
    % if more groups: 3,4,5... and so on
    for ind = 1:length(cluster_names)
        % disp(cluster_names(ind));
        % when some files were corrupted I was able to still read them
        % with this, not sure if all the corruption are like this one...
        cluster_group(ind) = h5readatt([filebase '.kwik'],['/channel_groups/' num2str(j) '/clusters/main/' num2str(cluster_names(ind))],'cluster_group');

        if cluster_group(ind) == 0 % NOISE
            % spkts(find(clu==cluster_names(ind))) = []; % this option just if I want to remove the 0
            % waveform(:,:,find(clu==cluster_names(ind))) = [];
            % features(:,:,find(clu==cluster_names(ind))) = [];
            clu(clu == cluster_names(ind)) = 0;
        elseif cluster_group(ind) == 1 %MUA
            clu(clu == cluster_names(ind)) = 1;
        end
    end
    clear ind cluster_group
    
    % Rename and order name of clusters from 1 to n
    all_names = unique(clu);
    counter = 2;    % 0 and 1 already set!
    for ii = 1:length(all_names)    % todos los clusters
        if (all_names(ii) ~= 0) && (all_names(ii) ~= 1)
           clu(clu == all_names(ii),1) = counter;
           counter = counter + 1;
        end
    end
    clear ii counter
    cluster_names2 = unique(clu);   % cluster_names2 = renamed!
    clu2(2:length(clu)+1,1) = clu;    % clu2 = with the total number in position 1
    clu2(1) = length(cluster_names2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reading Waveforms... % Deprecated in phy!
    Waveforms = yfExtractWaveforms(filebase, spkts);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reading features...
    features = h5read([filebase '.kwx'],['/channel_groups/' num2str(j) '/features_masks']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    % SAVING tst and clu...
%    fid = fopen([filename '.' num2str(j) '.clu'],'w'); 
%    fprintf(fid,'%i\n',clu2);
%    fclose(fid);
%    clear fid
%    
%    fid = fopen([filename '.' num2str(j) '.tst'],'w'); 
%    fprintf(fid,'%i\n',spkts);
%    fclose(fid);
%    clear fid spkts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Saving tst and clu as mat files
    save([filebase '.clu.' num2str(j) '.mat'],'clu2');
    save([filebase '.tst.' num2str(j) '.mat'], 'spkts');
    clear spkts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Average waveform manually calculated from the imported ones 
    % This part is deprecated in phy
    counter=0;
    for ind=1:length(cluster_names2) % 0,1 = noise and MUA
        if ((cluster_names2(ind)~=0) && (cluster_names2(ind)~=1)) %clucid
            counter=counter+1; % number of cluster
            for s1 = 1:size(Waveforms, 1) % number of points
                for s2 = 1:size(Waveforms, 2) % number of channel on each shank
                    av_waveform{j+1, counter}(s1, s2) = mean(Waveforms(s1, s2, clu==cluster_names2(ind)),3);
                    % find = if the spike equal 
                    std_waveform{j+1, counter}(s1, s2) = std(double(Waveforms(s1, s2, clu==cluster_names2(ind))),1,3);
                end
            end
        end
    end
    clear counter
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SAVING average waveform and std...
    save([filebase '.av_waveform.' num2str(j) '.mat'],'av_waveform','-v7.3');
    save([filebase '.std_waveform.' num2str(j) '.mat'],'std_waveform','-v7.3');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SAVING spk and fet directly from the imported...
    save([filebase '.spk.' num2str(j) '.mat'],'Waveforms','-v7.3');
    save([filebase '.fet.' num2str(j) '.mat'],'features','-v7');

    clear features  clu clu2 cluster_names cluster_names2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

clear j av_waveform std_waveform Waveforms

%Finishing info
disp('...');
disp(['Done with ' filebase]);
disp('.........');
toc

return;
