function faces570(files);
%%%%%%%%%%%%%%%%%%%%%%%%
% faces570(files); %
%%%%%%%%%%%%%%%%%%%%%%%%
% written by AHB, Sept 2011, updated version of plx570 to account for new
% analyses (specifically, adaptation and LDA).
% Analyzes data for FACES570 (faces570.tim, faces570.tim) task
% files = optional argument, list files as strings.  Otherwise, program
% will load files listed in default XL sheet, as listed in
% generate_hmi_configplex.

%%% SETUP DEFAULTS
warning off; dbstop error;
hmiconfig=generate_hmi_configplex; % generates and loads config file
parnumlist=[570]; % list of paradigm numbers
xscale=-100:500; % default time window
minlatency=50; % minimum latencies

%%% CURRENT METRICS (used to define "response")
%% to add more epochs, make changes to RESPSTRUCT
baseline=[-100 0]; % window over which baseline response is calculated
epoch1=[50 400]; % early cue response window

%%%  LOAD FILE LIST
if nargin==0,
    error('You must specify an individual filename or monkey initial (''S''/''W'').')
elseif strcmp(files,'S')==1
    disp('Analyzing all F570 files for Stewie...')
    % Pulls files from HMI_PhysiologyNotes
    include=xlsread(hmiconfig.excelfile,'Faces570','A9:A1000'); % alphanumeric, Gridlocation
    [crap,filest]=xlsread(hmiconfig.excelfile,'Faces570','B9:B1000');
    filesx=filest(find(include==1)); clear include; clear files
    for ff=1:size(filesx,1),
        temp=char(filesx(ff)); files(ff)=cellstr(temp(1:12));
    end
elseif strcmp(files,'W')==1
    disp('Analyzing all F570 files for Wiggum...')
    % Pulls files from HMI_PhysiologyNotes
    include=xlsread(hmiconfig.excelfile,'Faces570','D9:D1000'); % alphanumeric, Gridlocation
    [crap,filest]=xlsread(hmiconfig.excelfile,'Faces570','E9:E1000');
    filesx=filest(find(include==1)); clear include; clear files
    for ff=1:size(filesx,1),
        temp=char(filesx(ff)); files(ff)=cellstr(temp(1:12));
    end
end


%%% ANALYZE INDIVIDUAL FILES
disp('***********************************************************************')
disp('faces570.m - Analysis program for FACES570-series datafiles (Sept 2011)')
disp('***********************************************************************')
for f=1:length(files), % perform following operations on each nex file listed
    close all % close all figure windows
    filename=char(files(f));
    disp(['Analyzing spike activity from ',filename])
    disp('...Removing previous files...')
    % remove previous files
    killfiles=dir([hmiconfig.faces570spks,filename,'*-570*data.mat']); % graphstructs
    for kf=1:size(killfiles,1),
        disp(['......deleting ',killfiles(kf).name])
        delete([hmiconfig.faces570spks,killfiles(kf).name]);
    end
    killfilesfig=dir([hmiconfig.figure_dir,'faces570',filesep,filename,'-*.*']); % figures
    for kf=1:size(killfilesfig,1),
        disp(['......deleting ',killfilesfig(kf).name])
        delete([hmiconfig.figure_dir,'faces570',filesep,killfilesfig(kf).name]);
    end
    % Test to see if plx_processnexfile has been run...
    disp('...Finding spike matrix...')
    if exist([hmiconfig.spikedir,filename,'_spkmat.mat'])==2,
        disp('......Found! Continuing analysis...')
    else
        disp('......File Not Found! Attempting to process nexfile...')
        try
            plx_processnexfile({filename},0);
        catch
            error('...Unable to processnexfile.  Please mark this file to continue...')
        end
    end

    % Begin analysis
    tempstruct=load([hmiconfig.spikedir,filename,'_spkmat.mat']);
    tempbehav=tempstruct.behav_matrix(:,[1 3 4 30 40 44 41 42 43]); % load behavioural data
    tempbehav(:,7)=tempbehav(:,6)-tempbehav(:,5); % solve for cue onset time (aligned to the beginning of each trial, in ms?)
    tempspike=tempstruct.spikesig;
    clear tempstruct
    foundunits=size(tempspike,2);
    if length(find(ismember(tempbehav(:,2),parnumlist)))<1,
        disp(['...No FACES570 trials found!!  Skipping this file.'])
    else
        disp(['...found ',num2str(size(tempbehav,1)),' trials...'])
        disp(['...found ',num2str(foundunits),' units...'])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Unit loop
        for un=1:foundunits, % performed for each unit
            disp(['...analyzing ',char(tempspike(un).labels)])
            %%% setup structures
            spikestructsingle=struct('label',[],'facesND_spk',[],'facesNA_spk',[],'facesTD_spk',[],'facesTA_spk',[],'facesFD_spk',[],'facesFA_spk',[],...
                'bodyp_spk',[],'objct_spk',[],...
                'facesND_ts',[],'facesNA_ts',[],'facesTD_ts',[],'facesTA_ts',[],'facesFD_ts',[],'facesFA_ts',[],...
                'bodyp_ts',[],'objct_ts',[]);
            graphstructsingle=struct('label',[],...
                'facesND_avg',[],'facesNA_avg',[],'facesTD_avg',[],'facesTA_avg',[],'facesFD_avg',[],'facesFA_avg',[],'bodyp_avg',[],'objct_avg',[],...
                'facesND_sem',[],'facesNA_sem',[],'facesTD_sem',[],'facesTA_sem',[],'facesFD_sem',[],'facesFA_sem',[],'bodyp_sem',[],'objct_sem',[],...
                'allconds',[],'allconds_avg',[],'allconds_sem',[],'spden_trial',[]);
            respstructsingle=struct('label',[],'wf_params',[],'m_baseline',[],'m_epoch1',[],'latency',[],'validrsp',[],'m_epoch1_nobase',[],...
                'response_type',[],'pref_cat',[],'anova_expression',[],'anova_identity',[],'anova_gaze_dir',[],'trial_m_baseline',[],...
                'trial_m_epoch1',[],'trial_id',[]);
            spikestructsingle.label=tempspike(un).labels; % paste label into SPIKE structure
            graphstructsingle.label=tempspike(un).labels; % paste label into GRAPH structure
            respstructsingle.label=tempspike(un).labels; % paste label into RESPONSE structure
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%% GENERATE SPIKE DENSITY FUNCTIONS %%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            disp('......generating spike density functions and graphstruct...')
            %%% paste individual trial info into SPIKESTRUCT structure
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesND570)==1); % select only correct 500 series trials - faces
            spikestructsingle.facesND_spk=tempspike(un).spikes(pointer,:);
            spikestructsingle.facesND_ts=ceil(tempbehav(pointer,7)*1000); % round cue onset timestamps to nearest ms
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesNA570)==1); % select only correct 500 series trials - faces
            spikestructsingle.facesNA_spk=tempspike(un).spikes(pointer,:);
            spikestructsingle.facesNA_ts=ceil(tempbehav(pointer,7)*1000); % round cue onset timestamps to nearest ms
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesTD570)==1); % select only correct 500 series trials - faces
            spikestructsingle.facesTD_spk=tempspike(un).spikes(pointer,:);
            spikestructsingle.facesTD_ts=ceil(tempbehav(pointer,7)*1000); % round cue onset timestamps to nearest ms
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesTA570)==1); % select only correct 500 series trials - faces
            spikestructsingle.facesTA_spk=tempspike(un).spikes(pointer,:);
            spikestructsingle.facesTA_ts=ceil(tempbehav(pointer,7)*1000); % round cue onset timestamps to nearest ms
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesFD570)==1); % select only correct 500 series trials - faces
            spikestructsingle.facesFD_spk=tempspike(un).spikes(pointer,:);
            spikestructsingle.facesFD_ts=ceil(tempbehav(pointer,7)*1000); % round cue onset timestamps to nearest ms
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.facesFA570)==1); % select only correct 500 series trials - faces
            spikestructsingle.facesFA_spk=tempspike(un).spikes(pointer,:);
            spikestructsingle.facesFA_ts=ceil(tempbehav(pointer,7)*1000); % round cue onset timestamps to nearest ms
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.bodyp570)==1); % select only correct 500 series trials - faces
            spikestructsingle.bodyp_spk=tempspike(un).spikes(pointer,:);
            spikestructsingle.bodyp_ts=ceil(tempbehav(pointer,7)*1000); % round cue onset timestamps to nearest ms
            pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),hmiconfig.objct570)==1); % select only correct 500 series trials - faces
            spikestructsingle.objct_spk=tempspike(un).spikes(pointer,:);
            spikestructsingle.objct_ts=ceil(tempbehav(pointer,7)*1000); % round cue onset timestamps to nearest ms

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%% Generate average spike density functions for each CONDITION (listed in CAT_avg/CAT_sem)
            [graphstructsingle.facesND_avg,graphstructsingle.facesND_sem]=plx_avgspden(spikestructsingle.facesND_spk,spikestructsingle.facesND_ts,5000,1,hmiconfig.gausskernel);
            [graphstructsingle.facesNA_avg,graphstructsingle.facesNA_sem]=plx_avgspden(spikestructsingle.facesNA_spk,spikestructsingle.facesNA_ts,5000,1,hmiconfig.gausskernel);
            [graphstructsingle.facesTD_avg,graphstructsingle.facesTD_sem]=plx_avgspden(spikestructsingle.facesTD_spk,spikestructsingle.facesTD_ts,5000,1,hmiconfig.gausskernel);
            [graphstructsingle.facesTA_avg,graphstructsingle.facesTA_sem]=plx_avgspden(spikestructsingle.facesTA_spk,spikestructsingle.facesTA_ts,5000,1,hmiconfig.gausskernel);
            [graphstructsingle.facesFD_avg,graphstructsingle.facesFD_sem]=plx_avgspden(spikestructsingle.facesFD_spk,spikestructsingle.facesFD_ts,5000,1,hmiconfig.gausskernel);
            [graphstructsingle.facesFA_avg,graphstructsingle.facesFA_sem]=plx_avgspden(spikestructsingle.facesFA_spk,spikestructsingle.facesFA_ts,5000,1,hmiconfig.gausskernel);
            [graphstructsingle.bodyp_avg,graphstructsingle.bodyp_sem]=plx_avgspden(spikestructsingle.bodyp_spk,spikestructsingle.bodyp_ts,5000,1,hmiconfig.gausskernel);
            [graphstructsingle.objct_avg,graphstructsingle.objct_sem]=plx_avgspden(spikestructsingle.objct_spk,spikestructsingle.objct_ts,5000,1,hmiconfig.gausskernel);

            %%%%%%%%%%%%%%%%%%
            %%% Trial loop %%%
            %%%%%%%%%%%%%%%%%%
            disp('......analyzing each TRIAL...')
            for tr=1:size(tempspike(un).spikes,1),
                %%% Generate spike density function for each TRIAL
                tempspikes=tempspike(un).spikes(tr,:);
                temp_ts=ceil(tempbehav(tr,7)*1000); % round cue onset timestamps to nearest ms
                [graphstructsingle.spden_trial(tr,:),junk]=plx_avgspden(tempspikes,temp_ts,5000,1,hmiconfig.gausskernel);
                respstructsingle.trial_m_baseline(tr)=mean(graphstructsingle.spden_trial(tr,baseline(1)+1000:baseline(2)+1000)');
                respstructsingle.trial_m_epoch1(tr)=mean(graphstructsingle.spden_trial(tr,epoch1(1)+1000:epoch1(2)+1000)');
                respstructsingle.trial_id(tr,1)=tempbehav(tr,3); % paste stimulus number
                respstructsingle.trial_resp_nobaseline(tr)=respstructsingle.trial_m_epoch1(tr)-respstructsingle.trial_m_baseline(tr);
                % Sort Expression (1=neutral,2=threat,3=fear,0=object/bodypart)
                if ismember(respstructsingle.trial_id(tr,1),[hmiconfig.facesND570 hmiconfig.facesNA570])==1,
                    respstructsingle.trial_id(tr,2)=1;
                elseif ismember(respstructsingle.trial_id(tr,1),[hmiconfig.facesTD570 hmiconfig.facesTA570])==1,
                    respstructsingle.trial_id(tr,2)=2;
                elseif ismember(respstructsingle.trial_id(tr,1),[hmiconfig.facesFD570 hmiconfig.facesFA570])==1,
                    respstructsingle.trial_id(tr,2)=3;
                else
                    respstructsingle.trial_id(tr,2)=0;
                end

                % Sort Identity (1-8 identity 1-8, 0=object/bodypart)
                switch respstructsingle.trial_id(tr,1)
                    case {1 2 3 4 5 6} % Identity 1
                        respstructsingle.trial_id(tr,3)=1;
                    case {7 8 9 10 11 12} % Identity 2
                        respstructsingle.trial_id(tr,3)=2;
                    case {13 14 15 16 17 18} % Identity 3
                        respstructsingle.trial_id(tr,3)=3;
                    case {19 20 21 22 23 24} % Identity 4
                        respstructsingle.trial_id(tr,3)=4;
                    case {25 26 27 28 29 30} % Identity 5
                        respstructsingle.trial_id(tr,3)=5;
                    case {31 32 33 34 35 36} % Identity 6
                        respstructsingle.trial_id(tr,3)=6;
                    case {37 38 39 40 41 42} % Identity 7
                        respstructsingle.trial_id(tr,3)=7;
                    case {43 44 45 46 47 48} % Identity 8
                        respstructsingle.trial_id(tr,3)=8;
                    otherwise % other
                        respstructsingle.trial_id(tr,3)=0;
                end

                % Sort Gaze Direction (1=directed,2=averted,0=object/bodypart)
                if ismember(respstructsingle.trial_id(tr,1),[hmiconfig.facesND570 hmiconfig.facesTD570 hmiconfig.facesFD570])==1,
                    respstructsingle.trial_id(tr,4)=1;
                elseif ismember(respstructsingle.trial_id(tr,1),[hmiconfig.facesNA570 hmiconfig.facesTA570 hmiconfig.facesFA570])==1,
                    respstructsingle.trial_id(tr,4)=2;
                else respstructsingle.trial_id(tr,4)=0; end

                % Sort Category (1=face,2=object,3=bodypart)
                if ismember(respstructsingle.trial_id(tr,1),1:48)==1,
                    respstructsingle.trial_id(tr,5)=1;
                elseif ismember(respstructsingle.trial_id(tr,1),hmiconfig.bodyp570)==1,
                    respstructsingle.trial_id(tr,5)=2;
                elseif ismember(respstructsingle.trial_id(tr,1),hmiconfig.objct570)==1,
                    respstructsingle.trial_id(tr,5)=3;
                end


                % Adaptation Loop (Identifies repetitions and interstimulus intervals)
                % Note - this step currently does not discriminate between correct and incorrect trials...

                % Stimulus repetition
                pointer=find(respstructsingle.trial_id(:,1)==respstructsingle.trial_id(tr,1) & tempbehav(tr,4)>2);
                if isempty(pointer)==0, respstructsingle.trial_id(tr,6)=find(tr==pointer);
                else respstructsingle.trial_id(tr,6)=0; end

                % Category repetition (faces, objects, body-parts)
                pointer=find(respstructsingle.trial_id(:,5)==respstructsingle.trial_id(tr,5) & tempbehav(tr,4)>2);
                if isempty(pointer)==0, respstructsingle.trial_id(tr,7)=find(tr==pointer);
                else respstructsingle.trial_id(tr,7)=0; end

                % Identity repetition (face 1-8)
                pointer=find(respstructsingle.trial_id(:,3)==respstructsingle.trial_id(tr,3) & tempbehav(tr,4)>2);
                if isempty(pointer)==0, respstructsingle.trial_id(tr,8)=find(tr==pointer);
                else respstructsingle.trial_id(tr,8)=0; end

                % Expression repetition (1-3)
                pointer=find(respstructsingle.trial_id(:,2)==respstructsingle.trial_id(tr,2) & tempbehav(tr,4)>2);
                if isempty(pointer)==0, respstructsingle.trial_id(tr,9)=find(tr==pointer);
                else respstructsingle.trial_id(tr,9)=0; end

                % Gaze Direction repetition (1 or 2)
                pointer=find(respstructsingle.trial_id(:,4)==respstructsingle.trial_id(tr,4) & tempbehav(tr,4)>2);
                if isempty(pointer)==0, respstructsingle.trial_id(tr,10)=find(tr==pointer);
                else respstructsingle.trial_id(tr,10)=0; end

                 % Adaptation Loop 2 (Identifies repetitions and interstimulus intervals)
                % Note - this step selects ONLY CORRECT TRIALS

                % Stimulus repetition
                pointer=find(respstructsingle.trial_id(:,1)==respstructsingle.trial_id(tr,1) & tempbehav(tr,4)==6);
                if isempty(pointer)==0, respstructsingle.trial_id(tr,11)=find(tr==pointer);
                else respstructsingle.trial_id(tr,11)=0; end

                % Category repetition (faces, objects, body-parts)
                pointer=find(respstructsingle.trial_id(:,5)==respstructsingle.trial_id(tr,5) & tempbehav(tr,4)==6);
                if isempty(pointer)==0, respstructsingle.trial_id(tr,12)=find(tr==pointer);
                else respstructsingle.trial_id(tr,12)=0; end

                % Identity repetition (face 1-8)
                pointer=find(respstructsingle.trial_id(:,3)==respstructsingle.trial_id(tr,3) & tempbehav(tr,4)==6);
                if isempty(pointer)==0, respstructsingle.trial_id(tr,13)=find(tr==pointer);
                else respstructsingle.trial_id(tr,13)=0; end

                % Expression repetition (1-3)
                pointer=find(respstructsingle.trial_id(:,2)==respstructsingle.trial_id(tr,2) & tempbehav(tr,4)==6);
                if isempty(pointer)==0, respstructsingle.trial_id(tr,14)=find(tr==pointer);
                else respstructsingle.trial_id(tr,14)=0; end

                % Gaze Direction repetition (1 or 2)
                pointer=find(respstructsingle.trial_id(:,4)==respstructsingle.trial_id(tr,4) & tempbehav(tr,4)==6);
                if isempty(pointer)==0, respstructsingle.trial_id(tr,15)=find(tr==pointer);
                else respstructsingle.trial_id(tr,15)=0; end

                
                % Calculate time between each stimulus
                if tr==1, 
                    respstructsingle.trial_id(tr,16)=0;
                else respstructsingle.trial_id(tr,16)=tempbehav(tr,6)-tempbehav(tr-1,6); % Interstimulus Interval in MS
                end
            end

            %%%%%%%%%%%%%%%%
            %%% ANALYSIS %%%
            %%%%%%%%%%%%%%%%
            %%% Condition loop
            disp('......analyzing each CONDITION...')
            for cnd=1:88, % first loop creates average spike density function for each condition
                %%% Generate average spike density functions for each STIMULUS (graphstruct.allconds_avg(cnd,:) and graphstruct.allconds_sem(cnd,:))
                pointer=find(ismember(tempbehav(:,2),parnumlist)==1 & tempbehav(:,4)==6 & ismember(tempbehav(:,3),cnd)==1); % locate all correct trials that match condition number
                if isempty(pointer)==1, % if no trials are found, paste zero values
                    graphstructsingle.allconds_avg(cnd,:)=zeros(1,5000);
                    graphstructsingle.allconds_sem(cnd,:)=zeros(1,5000);
                else
                    tempspikes=tempspike(un).spikes(pointer,:);
                    temp_ts=ceil(tempbehav(pointer,7)*1000); % round cue onset timestamps to nearest ms
                    [graphstructsingle.allconds_avg(cnd,:),graphstructsingle.allconds_sem(cnd,:)]=plx_avgspden(tempspikes,temp_ts,5000,1,hmiconfig.gausskernel);
                    if isnan(graphstructsingle.allconds_avg(cnd,1))==1, % fills in empty rows
                        graphstructsingle.allconds_avg(cnd,:)=zeros(1,5000);
                    end
                end
            end
            for cnd=1:88, % first loop creates average spike density function for each condition
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%% calculate mean baseline measures
                respstructsingle.m_baseline(cnd)=mean(mean(graphstructsingle.allconds_avg(:,baseline(1)+1000:baseline(2)+1000)')); % average baseline rate
                respstructsingle.m_epoch1(cnd)=mean(graphstructsingle.allconds_avg(cnd,epoch1(1)+1000:epoch1(2)+1000)');
                respstructsingle.latency(cnd)=plx_calclatency(graphstructsingle.allconds_avg(cnd,:),...
                    mean(graphstructsingle.allconds_sem(cnd,:)),1000,respstructsingle.m_baseline(cnd),size(tempspikes,1));
                if respstructsingle.latency(cnd)<minlatency, respstructsingle.latency(cnd)=0; end % remove any latencies less than 50ms
                if respstructsingle.m_epoch1(cnd) < (2*respstructsingle.m_baseline(cnd)),
                    respstructsingle.validrsp(cnd,1)=0; % classifies as valid/invalid (>2X baseline)
                else respstructsingle.validrsp(cnd,1)=1; end
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%% Subtract Baseline and repeat epoch quantification
            m_avgbaseline=mean(respstructsingle.m_baseline);
            for cnd=1:88, % third condition loop subtracts average baseline and recalculates analysis parameters
                respstructsingle.m_epoch1_nobase(cnd)=respstructsingle.m_epoch1(cnd)-m_avgbaseline;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%% Solve for waveform parameters
            signame=char(respstructsingle.label);
            wavedata=load([hmiconfig.wave_raw,signame(1:20),'_raw.mat']);
            wf_data=mean(wavedata.waverawdata');
            [respstructsingle.wf_params(1) respstructsingle.wf_params(2)]=min(wf_data);
            [respstructsingle.wf_params(3) respstructsingle.wf_params(4)]=max(wf_data);
            respstructsingle.wf_params(5)=(respstructsingle.wf_params(4)-respstructsingle.wf_params(2))*25;

            %%% Identify neuron type (Sensory vs. Non-Responsive)
            pointerNF=find(ismember(respstructsingle.trial_id(:,1),hmiconfig.facesND570)==1);
            respstructsingle.valid_faces=signrank(respstructsingle.trial_m_epoch1(pointerNF),respstructsingle.trial_m_baseline(pointerNF));
            pointerBP=find(ismember(respstructsingle.trial_id(:,1),hmiconfig.bodyp570)==1);
            respstructsingle.valid_bodyp=signrank(respstructsingle.trial_m_epoch1(pointerBP),respstructsingle.trial_m_baseline(pointerBP));
            pointerOB=find(ismember(respstructsingle.trial_id(:,1),hmiconfig.objct570)==1);
            respstructsingle.valid_objct=signrank(respstructsingle.trial_m_epoch1(pointerOB),respstructsingle.trial_m_baseline(pointerOB));
            if respstructsingle.valid_faces<0.05|respstructsingle.valid_bodyp<0.05|respstructsingle.valid_objct<0.05,
                respstructsingle.response_type='Sensory';
            else
                respstructsingle.response_type='Non-responsive';
            end
            
            %%% Calculate average category & baseline responses
            [respstructsingle.cat_rsp_avg(1),respstructsingle.cat_rsp_sem(1)]=mean_sem(respstructsingle.trial_m_epoch1(pointerNF));
            [respstructsingle.cat_rsp_avg(2),respstructsingle.cat_rsp_sem(2)]=mean_sem(respstructsingle.trial_m_epoch1(pointerBP));
            [respstructsingle.cat_rsp_avg(3),respstructsingle.cat_rsp_sem(3)]=mean_sem(respstructsingle.trial_m_epoch1(pointerOB));
            [respstructsingle.baseline_avg,respstructsingle.baseline_sem]=mean_sem(respstructsingle.m_baseline);
            
            %%% Calculate facial expression, gaze direction, and identity
            [respstructsingle.expr_rsp_avg(1),respstructsingle.expr_rsp_sem(1)]=mean_sem(respstructsingle.trial_m_epoch1(find(respstructsingle.trial_id(:,2)==1)));
            [respstructsingle.expr_rsp_avg(2),respstructsingle.expr_rsp_sem(2)]=mean_sem(respstructsingle.trial_m_epoch1(find(respstructsingle.trial_id(:,2)==2)));
            [respstructsingle.expr_rsp_avg(3),respstructsingle.expr_rsp_sem(3)]=mean_sem(respstructsingle.trial_m_epoch1(find(respstructsingle.trial_id(:,2)==3)));
            for id=1:8
                [respstructsingle.id_rsp_avg(id),respstructsingle.id_rsp_sem(id)]=mean_sem(respstructsingle.trial_m_epoch1(find(respstructsingle.trial_id(:,3)==id)));
            end
            [respstructsingle.gaze_rsp_avg(1),respstructsingle.gaze_rsp_sem(1)]=mean_sem(respstructsingle.trial_m_epoch1(find(respstructsingle.trial_id(:,4)==1)));
            [respstructsingle.gaze_rsp_avg(2),respstructsingle.gaze_rsp_sem(2)]=mean_sem(respstructsingle.trial_m_epoch1(find(respstructsingle.trial_id(:,4)==2)));

            %%% Calculate category selectivity indices
            respstructsingle.catsi=zeros(1,3);
            respstructsingle.catsi(1)=(respstructsingle.cat_rsp_avg(1)-mean(respstructsingle.cat_rsp_avg([2 3])))/(respstructsingle.cat_rsp_avg(1)+mean(respstructsingle.cat_rsp_avg([2 3])));
            respstructsingle.catsi(2)=(respstructsingle.cat_rsp_avg(2)-mean(respstructsingle.cat_rsp_avg([1 3])))/(respstructsingle.cat_rsp_avg(2)+mean(respstructsingle.cat_rsp_avg([1 3])));
            respstructsingle.catsi(3)=(respstructsingle.cat_rsp_avg(3)-mean(respstructsingle.cat_rsp_avg([1 2])))/(respstructsingle.cat_rsp_avg(3)+mean(respstructsingle.cat_rsp_avg([1 2])));
                      
            %%% Calculate expr/id/gaze indices
            respstructsingle.expr_si(1)=(respstructsingle.expr_rsp_avg(2)-mean(respstructsingle.expr_rsp_avg(1)))/(respstructsingle.expr_rsp_avg(2)+mean(respstructsingle.expr_rsp_avg(1))); % neutral vs. threat
            respstructsingle.expr_si(2)=(respstructsingle.expr_rsp_avg(3)-mean(respstructsingle.expr_rsp_avg(1)))/(respstructsingle.expr_rsp_avg(3)+mean(respstructsingle.expr_rsp_avg(1))); % neutral vs. fear
            respstructsingle.expr_si(3)=(mean(respstructsingle.expr_rsp_avg([2 3]))-respstructsingle.expr_rsp_avg(1))/(mean(respstructsingle.expr_rsp_avg([2 3]))+respstructsingle.expr_rsp_avg(1)); % neutral vs. avg(threat/fear)
            respstructsingle.expr_si(4)=(max(respstructsingle.expr_rsp_avg([2 3]))-respstructsingle.expr_rsp_avg(1))/(max(respstructsingle.expr_rsp_avg([2 3]))+respstructsingle.expr_rsp_avg(1)); % neutral vs. max(threat/fear)            
            
            respstructsingle.id_si=(max(respstructsingle.id_rsp_avg(1:8))-mean(respstructsingle.id_rsp_avg(1:8)))/(max(respstructsingle.id_rsp_avg(1:8))+mean(respstructsingle.id_rsp_avg(1:8)));             
            respstructsingle.gaze_si=(respstructsingle.gaze_rsp_avg(2)-respstructsingle.gaze_rsp_avg(1))/(respstructsingle.gaze_rsp_avg(2)+respstructsingle.gaze_rsp_avg(1)); % averted vs. directed
            
            %%% Identify preferred category and response type (excite, suppress, both)
            clear temp tempind excitemarker suppressmarker
            excitemarker=0; suppressmarker=0;
            [junk,tempind]=max(respstructsingle.cat_rsp_avg);
            if tempind==1, respstructsingle.pref_cat='Faces';
                if abs(respstructsingle.catsi(1))>0.15, respstructsingle.catselect='Selective'; else respstructsingle.catselect='Non-selective'; end
            end;
            if tempind==2, respstructsingle.pref_cat='Bodyparts';
                if abs(respstructsingle.catsi(2))>0.15, respstructsingle.catselect='Selective'; else respstructsingle.catselect='Non-selective'; end
            end;
            if tempind==3, respstructsingle.pref_cat='Objects';
                if abs(respstructsingle.catsi(3))>0.15, respstructsingle.catselect='Selective'; else respstructsingle.catselect='Non-selective'; end
            end;
            if strcmp(respstructsingle.response_type,'Sensory')==1,
                if respstructsingle.valid_faces<0.05,
                    if respstructsingle.cat_rsp_avg(1)>respstructsingle.baseline_avg,
                        excitemarker=excitemarker+1;
                    else
                        suppressmarker=suppressmarker+1;
                    end
                end
                if respstructsingle.valid_bodyp<0.05,
                    if respstructsingle.cat_rsp_avg(2)>respstructsingle.baseline_avg,
                        excitemarker=excitemarker+1;
                    else
                        suppressmarker=suppressmarker+1;
                    end
                end
                if respstructsingle.valid_objct<0.05,
                    if respstructsingle.cat_rsp_avg(3)>respstructsingle.baseline_avg,
                        excitemarker=excitemarker+1;
                    else
                        suppressmarker=suppressmarker+1;
                    end
                end
                if excitemarker>0 & suppressmarker==0, respstructsingle.excitetype='Excite';
                elseif excitemarker==0 & suppressmarker>0, respstructsingle.excitetype='Suppress';
                elseif excitemarker>0 & suppressmarker>0, respstructsingle.excitetype='Both';
                end
            else
                respstructsingle.pref_cat='Non-responsive';
                respstructsingle.excitetype='Non-responsive';
                respstructsingle.catselect='Non-responsive';
            end
            clear tempind
            
            %%% ANOVA: Facial Expression
            pointer=find(respstructsingle.trial_id(:,2)>0);
            respstructsingle.anova_fe=anova1(respstructsingle.trial_m_epoch1(pointer),respstructsingle.trial_id(pointer,2),'off');

            %%% ANOVA: Identity
            pointer=find(respstructsingle.trial_id(:,3)>0);
            respstructsingle.anova_id=anova1(respstructsingle.trial_m_epoch1(pointer),respstructsingle.trial_id(pointer,3),'off');
            
            %%% ANOVA: Gaze Direction
            pointer=find(respstructsingle.trial_id(:,4)>0);
            respstructsingle.anova_gd=anova1(respstructsingle.trial_m_epoch1(pointer),respstructsingle.trial_id(pointer,4),'off');
            
            % create trial_id vectors (to use condition averages instead of
            % individual trials
            FEpointer=[1 1 2 2 3 3 1 1 2 2 3 3 1 1 2 2 3 3 1 1 2 2 3 3 1 1 2 2 3 3 1 1 2 2 3 3 1 1 2 2 3 3 1 1 2 2 3 3];
            IDpointer=[1 1 1 1 1 1 2 2 2 2 2 2 3 3 3 3 3 3 4 4 4 4 4 4 5 5 5 5 5 5 6 6 6 6 6 6 7 7 7 7 7 7 8 8 8 8 8 8];
            GDpointer=[1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2];
            
            %%% ANOVA: FExID
            respstructsingle.anovam_fe_id=anovan(respstructsingle.m_epoch1(1:48),{FEpointer,IDpointer},'model','interaction','varnames',{'FE','ID'});

            %%% ANOVA: FExGD
            respstructsingle.anovam_fe_gd=anovan(respstructsingle.m_epoch1(1:48),{FEpointer,GDpointer},'model','interaction','varnames',{'FE','GD'});
            
            %%% ANOVA: IDxGD
            respstructsingle.anovam_id_gd=anovan(respstructsingle.m_epoch1(1:48),{IDpointer,GDpointer},'model','interaction','varnames',{'ID','GD'});
            
            %%% ANOVA: FExIDxGD
            respstructsingle.anovam_fe_id_gd=anovan(respstructsingle.m_epoch1(1:48),{FEpointer,IDpointer,GDpointer},'model',3,'varnames',{'FE','ID','GD'});

            %%% ANOVA: FExID
            pointer=find(respstructsingle.trial_id(:,3)>0);
            respstructsingle.anova_fe_id=anovan(respstructsingle.trial_m_epoch1(pointer),{respstructsingle.trial_id(pointer,2),respstructsingle.trial_id(pointer,3)},'interaction');

            %%% ANOVA: FExGD
            pointer=find(respstructsingle.trial_id(:,3)>0);
            respstructsingle.anova_fe_gd=anovan(respstructsingle.trial_m_epoch1(pointer),{respstructsingle.trial_id(pointer,2),respstructsingle.trial_id(pointer,4)},'interaction');
            
            %%% ANOVA: IDxGD
            pointer=find(respstructsingle.trial_id(:,3)>0);
            respstructsingle.anova_id_gd=anovan(respstructsingle.trial_m_epoch1(pointer),{respstructsingle.trial_id(pointer,3),respstructsingle.trial_id(pointer,4)},'interaction');

            %%% ANOVA: FExIDxGD
            pointer=find(respstructsingle.trial_id(:,3)>0);
            respstructsingle.anova_fe_id_gd=anovan(respstructsingle.trial_m_epoch1(pointer),{respstructsingle.trial_id(pointer,2),respstructsingle.trial_id(pointer,3),respstructsingle.trial_id(pointer,4)},'full');
                        
            try close Figure 1; end
            try close Figure 2; end
            try close Figure 3; end 
            try close Figure 4; end
            try close Figure 5; end
            try close Figure 6; end
            try close Figure 7; end
            try close Figure 8; end
            try close Figure 9; end
            try close Figure 10; end
            close all
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%% Save output file for population analysis
            respstructsingle.datemodified=date;
            unitname=char(respstructsingle.label);
            outputfname = [hmiconfig.faces570spks,unitname(1:end-4),'-570responsedata.mat'];
            save(outputfname,'respstructsingle')
            outputfname = [hmiconfig.faces570spks,unitname(1:end-4),'-570graphdata.mat'];
            disp('...Saving average spike density functions...')
            save(outputfname,'graphstructsingle');
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%% graph the file
            disp('...Graphing data...')
            f570_plotneuron(hmiconfig,xscale,graphstructsingle,respstructsingle,char(files(f)))
        end % end loop for each unit
        clear tempbehav tempspike spk_avgbaseline m_avgbaseline p_avgbaseline
    end
end
return

function plotneuron(hmiconfig,xscale,graphstruct,respstruct,fname)
fontsize_sml=7; fontsize_med=8; fontsize_lrg=9;
%%% determining baseline %%%
avg_baseline=mean(respstruct.m_baseline); avg_baseline1=mean(respstruct.m_baseline);
figure
clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.1 0.1 0.8 0.8]); set(gca,'FontName','Arial')
xrange=(1000+xscale(1)):(1000+xscale(end));
subplot(3,3,[1 4 7]) % colour plot
plotorder=[hmiconfig.facesND570 hmiconfig.facesNA570 hmiconfig.facesTD570 hmiconfig.facesTA570 hmiconfig.facesFD570 hmiconfig.facesFA570 hmiconfig.bodyp570 hmiconfig.objct570];
pcolor(xscale,1:88,graphstruct.allconds_avg(plotorder,xrange))
shading flat
%caxis([10 90])
hold on
plot([xscale(1) xscale(end)],[9 9],'w-','LineWidth',1)
plot([xscale(1) xscale(end)],[17 17],'w-','LineWidth',1)
plot([xscale(1) xscale(end)],[25 25],'w-','LineWidth',1)
plot([xscale(1) xscale(end)],[33 33],'w-','LineWidth',1)
plot([xscale(1) xscale(end)],[41 41],'w-','LineWidth',1)
plot([xscale(1) xscale(end)],[49 49],'w-','LineWidth',2)
plot([xscale(1) xscale(end)],[69 69],'w-','LineWidth',2)
plot([0 0],[0 100],'w:','LineWidth',1)
colorbar('SouthOutside')
text(0,101.5,'0','FontSize',fontsize_sml,'HorizontalAlignment','Center')
text(xscale(1),101.5,num2str(xscale(1)),'FontSize',fontsize_sml,'HorizontalAlignment','Center')
text(xscale(end),101.5,num2str(xscale(end)),'FontSize',fontsize_sml,'HorizontalAlignment','Center')
text(xscale(1)-(abs(xscale(1))*.2),4,'Neutral (D)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.2),12,'Neutral (A)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.2),20,'Threat (D)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.2),28,'Threat (A)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.2),36,'Fear Grin (D)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.2),44,'Fear Grin (A)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.2),58,'Bodyparts','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.2),78,'Objects','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
set(gca,'FontSize',7); xlim([xscale(1) xscale(end)]); box off; axis off; axis ij; ylim([0 88]);
signame=char(graphstruct.label);

%%% Text Properties
text(1700,40,['Neuron Properties'],'FontWeight','Bold');
text(1700,42,['+--------------------------------------+'],'FontWeight','Bold');
text(1700,46,['Neuron Type:      ',respstruct.response_type]);
text(1700,49,['Preferred Category: ',respstruct.pref_cat]);
text(1700,52,['Response Type: ',respstruct.excitetype]);
text(1700,55,['CategorySelect: ',respstruct.catselect]);
text(1700,61,['  Face SI: ',num2str(respstruct.catsi(1),'%1.2g')])
text(1700,64,['  Bodyparts SI: ',num2str(respstruct.catsi(2),'%1.2g')])
text(1700,67,['  Objects SI: ',num2str(respstruct.catsi(3),'%1.2g')])
text(1700,73,['   Valid Faces?: p=',num2str(respstruct.valid_faces,'%1.2g')]);
text(1700,76,['   Valid Bodyparts?: p= ',num2str(respstruct.valid_bodyp,'%1.2g')]);
text(1700,79,['   Valid Objects?: p=',num2str(respstruct.valid_objct,'%1.2g')]);
text(1700,85,['ANOVA (Expression): p=',num2str(respstruct.anova_fe,'%1.2g')])
text(1700,88,['ANOVA (Identity): p=',num2str(respstruct.anova_id,'%1.2g')])
text(1700,91,['ANOVA (Gaze Direction): p=',num2str(respstruct.anova_gd,'%1.2g')])
text(1700,94,['ANOVA (FE x ID): p=',num2str(respstruct.anova_fe_id(3),'%1.2g')])
text(1700,97,['ANOVA (FE x GD): p=',num2str(respstruct.anova_fe_gd(3),'%1.2g')])
text(1700,100,['ANOVA (ID x GD): p=',num2str(respstruct.anova_id_gd(3),'%1.2g')])
text(1700,103,['ANOVA (FE x ID x GD): p=',num2str(respstruct.anova_fe_id_gd(7),'%1.2g')])

subplot(3,3,2) % CATEGORY effect, average spike density functions
hold on
plot(xscale,graphstruct.facesND_avg(xrange),'r-','LineWidth',2)
plot(xscale,graphstruct.bodyp_avg(xrange),'y-','LineWidth',2)
plot(xscale,graphstruct.objct_avg(xrange),'g-','LineWidth',2)
plot([xscale(1) xscale(end)],[avg_baseline avg_baseline],'k--','LineWidth',0.25)
h=axis;
plot([0 0],[0 h(4)],'k:','LineWidth',0.5)
plot([xscale(1) xscale(end)],[0 0],'k-');
%legend('Neutral','BodyP','Objects')
ylabel('sp/s','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); xlim([xscale(1) xscale(end)]);
try
    title([signame(1:end-4),': FACES570 Task ',...
        char(respstruct.gridlocation),' (',char(respstruct.APIndex),') - ',num2str(respstruct.depth),'um'],'FontSize',10,'FontWeight','Bold');
catch
    title([signame(1:end-4),': FACES570 Task'],'FontSize',10,'FontWeight','Bold'); % if unable to sync
end

subplot(3,3,5) % EXPRESSION effect, average spike density functions
hold on
temp=mean(graphstruct.allconds_avg([hmiconfig.facesND570;hmiconfig.facesNA570],:));
plot(xscale,temp(xrange),'r-','LineWidth',2)
temp=mean(graphstruct.allconds_avg([hmiconfig.facesTD570;hmiconfig.facesTA570],:));
plot(xscale,temp(xrange),'k-','LineWidth',2)
temp=mean(graphstruct.allconds_avg([hmiconfig.facesFD570;hmiconfig.facesFA570],:));
plot(xscale,temp(xrange),'b-','LineWidth',2)
h=axis;
plot([0 0],[0 h(4)],'k:','LineWidth',0.5)
plot([xscale(1) xscale(end)],[0 0],'k-');
%legend('Neutral','Threat','FearGrin')
ylabel('sp/s','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); xlim([xscale(1) xscale(end)]);
title({'Facial Expression','(Collapsed Across Gaze Direction)'},'FontSize',10,'FontWeight','Bold'); % if unable to sync

subplot(3,3,8) % EXPRESSION effect, average spike density functions
hold on
temp=mean(graphstruct.allconds_avg([hmiconfig.facesND570;hmiconfig.facesTD570;hmiconfig.facesFD570],:));
plot(xscale,temp(xrange),'r-','LineWidth',2)
temp=mean(graphstruct.allconds_avg([hmiconfig.facesNA570;hmiconfig.facesTA570;hmiconfig.facesFA570],:));
plot(xscale,temp(xrange),'k-','LineWidth',2)
h=axis;
plot([0 0],[0 h(4)],'k:','LineWidth',0.5)
plot([xscale(1) xscale(end)],[0 0],'k-');
%legend('Directed','Averted')
ylabel('sp/s','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); xlim([xscale(1) xscale(end)]);
title({'Gaze Direction Expression','(Collapsed Across Expression)'},'FontSize',10,'FontWeight','Bold'); % if unable to sync
subplot(3,3,3)
wavedata=load([hmiconfig.wave_raw,signame(1:20),'_raw.mat']);
hold on
try plot(-200:25:575,wavedata.waverawdata(:,1:end)','-','Color',[0.5 0.5 0.5],'LineWidth',0.01); end
minval=min(min(wavedata.waverawdata));
maxval=max(max(wavedata.waverawdata));
rangeadj=abs(minval-maxval)*0.1;
plot([(respstruct.wf_params(2)*25)-200 (respstruct.wf_params(2)*25)-200],[minval maxval],'g-')
plot([(respstruct.wf_params(4)*25)-200 (respstruct.wf_params(4)*25)-200],[minval maxval],'g-')
text(200,-1.6,['Duration: ',num2str(respstruct.wf_params(5)),' us'],'FontSize',7)
plot([-200 600],[0 0],'k:'); xlim([-200 600]);
plot(-200:25:575,mean(wavedata.waverawdata'),'r-','LineWidth',2); ylim([minval-rangeadj maxval+rangeadj]);
xlabel('Time (us)'); ylabel('Amplitude (mV)'); set(gca,'FontSize',fontsize_med)
title('Unit Waveforms','FontSize',fontsize_lrg)

%matfigname=[hmiconfig.figure_dir,'faces570',filesep,signame(1:end-4),'_faces570.fig'];
jpgfigname=[hmiconfig.figure_dir,'faces570',filesep,signame(1:end-4),'_faces570.jpg'];
%illfigname=['C:\Documents and Settings\Andrew Bell\Desktop\',signame(1:end-4),'_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
%print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure
%hgsave(matfigname);
if hmiconfig.printer==1, % prints the figure to the default printer (if printer==1)
    print
end
return

function [av,sm,bst]=rsp_avgbest(data,stim_no);
%%% one column for each metric (currently 3)
%[av(1),sm(1)]=mean_sem(data.spk_epoch1(stim_no));
[av(2),sm(2)]=mean_sem(data.m_epoch1(stim_no));
%[av(3),sm(3)]=mean_sem(data.p_epoch1(stim_no));
%[av(4),sm(4)]=mean_sem(data.mp_epoch1(stim_no));
%[av(5),sm(5)]=mean_sem(data.area_epoch1(stim_no));
%bst(1)=max(data.spk_epoch1(stim_no));
bst(2)=max(data.m_epoch1(stim_no));
%bst(3)=max(data.p_epoch1(stim_no));
%bst(4)=max(data.mp_epoch1(stim_no));
%bst(5)=max(data.area_epoch1(stim_no));
return

function [av,sm,bst]=rsp_avgbest_nobase(data,stim_no);
%%% one column for each metric (currently 3)
%[av(1),sm(1)]=mean_sem(data.spk_epoch1_nobase(stim_no));
[av(2),sm(2)]=mean_sem(data.m_epoch1_nobase(stim_no));
%[av(3),sm(3)]=mean_sem(data.p_epoch1_nobase(stim_no));
%[av(4),sm(4)]=mean_sem(data.mp_epoch1_nobase(stim_no));
%[av(5),sm(5)]=mean_sem(data.area_epoch1_nobase(stim_no));
%bst(1)=max(data.spk_epoch1_nobase(stim_no));
bst(2)=max(data.m_epoch1_nobase(stim_no));
%bst(3)=max(data.p_epoch1_nobase(stim_no));
%bst(4)=max(data.mp_epoch1_nobase(stim_no));
%bst(5)=max(data.area_epoch1_nobase(stim_no));
return

function si=calc_si(data,ind_col,metric_col)
[numcol,junk]=size(data);
cols=1:numcol;
othercols=find(cols~=ind_col);
non_ind=mean(data(othercols,metric_col));
maincol=data(ind_col,metric_col);
si=(maincol-non_ind)/(maincol+non_ind);
return

function si=calc_si_nofruit(data,ind_col,metric_col)
[numcol,junk]=size(data);
cols=1:numcol;
non_ind=mean(data([2 3 4],metric_col));
maincol=data(ind_col,metric_col);
si=(maincol-non_ind)/(maincol+non_ind);
return

function si=calc_rawsi(data,metric_col)
[numcol,junk]=size(data);
cols=1:numcol;
[val,ind]=max(data(:,metric_col));
othercols=find(cols~=ind);
non_ind=mean(data(othercols,metric_col));
maincol=data(ind,metric_col);
si=(maincol-non_ind)/(maincol+non_ind);
return

function output=calc_puresi(data,metric_col,refcol);
maincol=data(refcol,metric_col);
for cc=1:5,
    noncol=data(cc,metric_col);
    output(cc)=(maincol-noncol)/(maincol+noncol);
end
return