function rejects=plx570_LFPs(files)
%%%%%%%%%%%%%%%%%%%%%%%
% plx570_LFPs(files); %
%%%%%%%%%%%%%%%%%%%%%%%
% written by AHB, Sept2010, based on plx500_LFPs
% Analyzes data for FACES570 task
% Incoming files must be run first through plx_processnexfile and then plx_processLFPs
% before analysis is possible
% files = optional argument, list files as strings.

%%% SETUP DEFAULTS
warning off;
%close all
hmiconfig=generate_hmi_configplex; % generates and loads config file
parnumlist=570; % list of paradigm numbers
xscale=[-400 600]; % default time window for LFPs, +/-400ms from stim onset/offset
channels={'LFP1','LFP2','LFP3','LFP4'};
%%% CURRENT METRICS (used to define "response")
rect_epoch=[50 300]; % same as spikes

disp('*****************************************************************')
disp('* plx570_LFP.m - Analysis program for neural and behavioural    *')
disp('*  data from FACES570-series datafiles.  This program will scan *')
disp('*  and analyze all the files flagged in the default filelist    *')
disp('*  (specified in generate_hmi_configplex.m                      *')
disp('*****************************************************************')

if nargin==0,
    error('You must specify an individual filename or monkey initial (''S''/''W'').')
elseif strcmp(files,'S')==1
    disp('Analyzing all F570 files for Stewie...')
    % Pulls files from HMI_PhysiologyNotes
    include=xlsread(hmiconfig.excelfile,'Faces570','C10:C1000'); % alphanumeric, Gridlocation
    [crap,filest]=xlsread(hmiconfig.excelfile,'Faces570','B10:B1000');
    filesx=filest(find(include==1)); clear include; clear files
    for ff=1:size(filesx,1),
        temp=char(filesx(ff)); files(ff)=cellstr(temp(1:12));
    end
elseif strcmp(files,'W')==1
    disp('Analyzing all F570 files for Wiggum...')
    % Pulls files from HMI_PhysiologyNotes
    include=xlsread(hmiconfig.excelfile,'Faces570','F10:F1000'); % alphanumeric, Gridlocation
    [crap,filest]=xlsread(hmiconfig.excelfile,'Faces570','E10:E1000');
    filesx=filest(find(include==1)); clear include; clear files
    for ff=1:size(filesx,1),
        temp=char(filesx(ff));
        files(ff)=cellstr(temp(1:12));
    end
end

%%% ANALYZE INDIVIDUAL FILES
for f=1:length(files), % perform following operations on each nex file listed
    filename=char(files(f));
    disp(['Analyzing local field potentials from ',filename])
    disp('...Finding spike matrix...')
    if exist([hmiconfig.spikedir,filename,'_spkmat.mat'])==2,
        disp('...Found! Continuing analysis...')
    else
        disp('...File Not Found! Attempting to process nexfile...')
        try
            plx_processnexfile({filename},0);
        catch
            error('...Unable to processnexfile.  Please mark this file to continue...')
        end
    end

    %%% setup structures
    tempstruct=load([hmiconfig.spikedir,filename,'_spkmat.mat']);
    tempbehav=tempstruct.behav_matrix(:,[1 3 4 30 40 44]); % load behavioural data
    clear tempstruct
    tempbehav(:,7)=tempbehav(:,6)-tempbehav(:,5); % solve for cue onset time (aligned to the beginning of each trial, in ms?)
    tempbehav(:,8)=ceil(tempbehav(:,6)*1000); % converts raw cue onset times to rounded ms
    pointer=find(ismember(tempbehav(:,2),parnumlist));
    numtrials=length(pointer);
    if numtrials<1,
        disp('...No FACES570 trials found!!  Skipping this file.')
    else
        disp(['...found ',num2str(numtrials),' 570-series trials...'])
        pointer=find(ismember(tempbehav(:,2),parnumlist)&tempbehav(:,4)==6); % select only correct trials
        disp(['...found ',num2str(length(pointer)),' correct trials...'])
        numtrials=length(pointer);
        tempbehav=tempbehav(pointer,:);
        
        %%% Find available channels
        chan_anal=[];
        for ch=1:length(channels),
            % See if channel exists in CORRECTED directory
            corrname=strcat(hmiconfig.LFPdir_corr,files(f),'-',channels(ch),'c.mat');
            if exist(char(corrname))==2,
                chan_anal=[chan_anal ch];
            end
        end
        disp(['...found ',num2str(length(chan_anal)),' LFP channels...'])

        %%% Begin channel analysis
        for ch=1:length(chan_anal), % scroll through each channel
            lfpstructsingle=struct('label',[]);
            chan=channels(chan_anal(ch)); % channel name
            disp(['...analyzing ',char(chan),'...'])
            lfpstructsingle.label=channels(chan_anal(ch)); % paste channel label into lfpstruct
            corrname=strcat(hmiconfig.LFPdir_corr,files(f),'-',chan,'c.mat');
            lfpdata=load(char(corrname));
            disp('......Evoked Potential Analysis...')
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%% EVOKED POTENTIAL ANALYSIS %%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%% cut out individual trial LFPs
            for t=1:numtrials, % loop through each trial and paste lfp into trial matrix
                lfpstructsingle.lfp_trial(t,1:(length(xscale(1):xscale(2))))=lfpdata.LFPsignal(tempbehav(t,8)+xscale(1):tempbehav(t,8)+xscale(2));
                lfpstructsingle.lfp_trial_rect(t,:)=lfpstructsingle.lfp_trial(t,:).^2; % rectify each trial
               
                %%% Calculate evoked potential epoch (max between 50-300 following stim onset)
                lfpstructsingle.trial_epoch(t)=max(lfpstructsingle.lfp_trial(t,400+rect_epoch(1):400+rect_epoch(2)));
                lfpstructsingle.trial_epoch_rect(t)=max(lfpstructsingle.lfp_trial_rect(t,400+rect_epoch(1):400+rect_epoch(2)));
            end
            %%% generate average condition LFPs
            for cnd=1:88, % scroll through each condition
                pointer=find(tempbehav(:,3)==cnd);
                [lfpstructsingle.lfp_average(cnd,:) lfpstructsingle.lfp_sem(cnd,:)]=mean_sem(lfpstructsingle.lfp_trial(pointer,:));
                [lfpstructsingle.lfp_average_rect(cnd,:) lfpstructsingle.lfp_sem_rect(cnd,:)]=mean_sem(lfpstructsingle.lfp_trial_rect(pointer,:));
                lfpstructsingle.lfp_average_epoch(cnd)=max(lfpstructsingle.lfp_average(cnd,400+rect_epoch(1):400+rect_epoch(2)));
                lfpstructsingle.lfp_average_epoch_rect(cnd)=max(lfpstructsingle.lfp_average_rect(cnd,400+rect_epoch(1):400+rect_epoch(2)));
            end
            
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesND570)==1); %
            [lfpstructsingle.faces_avg(1,:),lfpstructsingle.faces_sem(1,:)]=mean_sem(lfpstructsingle.lfp_trial(pointer,:));
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesNA570)==1); %
            [lfpstructsingle.faces_avg(2,:),lfpstructsingle.faces_sem(2,:)]=mean_sem(lfpstructsingle.lfp_trial(pointer,:));
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesTD570)==1); %
            [lfpstructsingle.faces_avg(3,:),lfpstructsingle.faces_sem(3,:)]=mean_sem(lfpstructsingle.lfp_trial(pointer,:));
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesTA570)==1); %
            [lfpstructsingle.faces_avg(4,:),lfpstructsingle.faces_sem(4,:)]=mean_sem(lfpstructsingle.lfp_trial(pointer,:));
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesFD570)==1); %
            [lfpstructsingle.faces_avg(5,:),lfpstructsingle.faces_sem(5,:)]=mean_sem(lfpstructsingle.lfp_trial(pointer,:));
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesFA570)==1); %
            [lfpstructsingle.faces_avg(6,:),lfpstructsingle.faces_sem(6,:)]=mean_sem(lfpstructsingle.lfp_trial(pointer,:));
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.bodyp570)==1); %
            [lfpstructsingle.faces_avg(7,:),lfpstructsingle.faces_sem(7,:)]=mean_sem(lfpstructsingle.lfp_trial(pointer,:));
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.objct570)==1); %
            [lfpstructsingle.faces_avg(8,:),lfpstructsingle.faces_sem(8,:)]=mean_sem(lfpstructsingle.lfp_trial(pointer,:));


            disp('......Frequency Domain Analysis...')
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%% FREQUENCY DOMAIN ANALYSIS %%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%% Create spectrograms (multitaper function; Partha Mitra Chronux.org)
            disp('.........constructing spectrograms for each trial ...')
            params=hmiconfig.chronux_params;
            trial_specgramMT_S=zeros(numtrials,746,31);
            for tt=1:numtrials,
                [trial_specgramMT_S(tt,:,:),lfpstructsingle.trial_specgramMT_T(tt,:),lfpstructsingle.trial_specgramMT_F(tt,:)]=...
                    mtspecgramc(lfpstructsingle.lfp_trial(tt,:)',[0.256 0.001],params);
            end
            disp('.........constructing average spectrograms for each category ...')

            [cat_specgramMT_S(1,:,:),lfpstructsingle.cat_specgramMT_T(1,:),lfpstructsingle.cat_specgramMT_F(1,:)]=...
                mtspecgramc(lfpstructsingle.lfp_average(hmiconfig.facesND570,:)',[0.256 0.001],params);
            [cat_specgramMT_S(2,:,:),lfpstructsingle.cat_specgramMT_T(2,:),lfpstructsingle.cat_specgramMT_F(2,:)]=...
                mtspecgramc(lfpstructsingle.lfp_average(hmiconfig.facesNA570,:)',[0.256 0.001],params);
            [cat_specgramMT_S(3,:,:),lfpstructsingle.cat_specgramMT_T(3,:),lfpstructsingle.cat_specgramMT_F(3,:)]=...
                mtspecgramc(lfpstructsingle.lfp_average(hmiconfig.facesTD570,:)',[0.256 0.001],params);
            [cat_specgramMT_S(4,:,:),lfpstructsingle.cat_specgramMT_T(4,:),lfpstructsingle.cat_specgramMT_F(4,:)]=...
                mtspecgramc(lfpstructsingle.lfp_average(hmiconfig.facesTA570,:)',[0.256 0.001],params);
            [cat_specgramMT_S(5,:,:),lfpstructsingle.cat_specgramMT_T(5,:),lfpstructsingle.cat_specgramMT_F(5,:)]=...
                mtspecgramc(lfpstructsingle.lfp_average(hmiconfig.facesFD570,:)',[0.256 0.001],params);
            [cat_specgramMT_S(6,:,:),lfpstructsingle.cat_specgramMT_T(6,:),lfpstructsingle.cat_specgramMT_F(6,:)]=...
                mtspecgramc(lfpstructsingle.lfp_average(hmiconfig.facesFA570,:)',[0.256 0.001],params);
            [cat_specgramMT_S(7,:,:),lfpstructsingle.cat_specgramMT_T(7,:),lfpstructsingle.cat_specgramMT_F(7,:)]=...
                mtspecgramc(lfpstructsingle.lfp_average(hmiconfig.bodyp570,:)',[0.256 0.001],params);
            [cat_specgramMT_S(8,:,:),lfpstructsingle.cat_specgramMT_T(8,:),lfpstructsingle.cat_specgramMT_F(8,:)]=...
                mtspecgramc(lfpstructsingle.lfp_average(hmiconfig.objct570,:)',[0.256 0.001],params);

            %%% baseline subtraction - take average spectrum across ALL conditions (-100-0ms) and reduce to single function.
            %% Calculate baseline spectrum
            for cc=1:8,
                clear indexmark
                indexmark=abs((lfpstructsingle.cat_specgramMT_T(cc,1)*1000)-300);
                tempbase=squeeze(cat_specgramMT_S(cc,indexmark:indexmark+100,:));
                tempavg(cc,:)=mean(tempbase,1);
            end
            baseline=mean(tempavg); % average baseline across all categories

            %% Subtract baseline from trial spectrograms
            for tr=1:numtrials,
                tempS=squeeze(trial_specgramMT_S(tr,:,:));
                for tt=1:size(tempS,1),
                    tempS(tt,:)=tempS(tt,:)-baseline;
                end
                lfpstructsingle.trial_specgramMT_S_noB(tr,:,:)=tempS;
            end
            clear tr tt tempS tempavg tempbase trial_specgramMT_S

            %% Subtract baseline from average category spectrograms
            for cc=1:8,
                tempS=squeeze(cat_specgramMT_S(cc,:,:));
                for tt=1:size(tempS,1),
                    tempS(tt,:)=tempS(tt,:)-baseline;
                end
                lfpstructsingle.cat_specgramMT_S_noB(cc,:,:)=tempS;
            end
            clear cc tt tempS tempavg tempbase cat_specgramMT_S

            %%%% APPENDED FIELDS HERE %%%%
 
            
            
            %%%%%%%%%%%%%%%%%
            %%% SAVE DATA %%%
            %%%%%%%%%%%%%%%%%
            
            %% save data into single files per channel
            lfpstructsingle.xscale=xscale;
            outputfname = [hmiconfig.faces570lfps,filename,'-570-',char(chan),'.mat'];
            disp(['...saving local field potential data for ',char(chan),'...'])
            save(outputfname,'lfpstructsingle');

            f570_graphLFP(hmiconfig,char(files(f)),char(chan),lfpstructsingle,xscale);
            close all
            clear lfpstructsingle
            
            
        end % end of CHAN loop
    end % end of INDIVIDUAL FILE loop
end % end of FILES loop
return

%%%%%%%%%% NESTED FUNCTIONS %%%%%%%%%%


