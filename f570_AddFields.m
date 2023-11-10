function f570_AddFields(initial);
% f570_AddFields(files); %
% written by AHB, Sept 2011, updated version of plx570 to account for new analyses
% Updated Oct 2012, March 2014

%%% SETUP DEFAULTS
warning off;
hmiconfig=generate_f570_config; % generates and loads config file
num_id=3; % number of ID exemplars

%%%  LOAD FILE LIST
if nargin==0,
    error('You must specify an individual filename or monkey initial (''S''/''W'').')
elseif strcmp(initial,'S')==1
    disp('Analyzing all F570 files for Stewie...')
    % Pulls files from HMI_PhysiologyNotes
    include=xlsread(hmiconfig.excelfile,'Faces570','A9:A1000'); % alphanumeric, Gridlocation
    [crap,filest]=xlsread(hmiconfig.excelfile,'Faces570','B9:B1000');
    filesx=filest(find(ismember(include,[1 2])));
    for ff=1:size(filesx,1),
        temp=filesx{ff}; 
        files(ff)=cellstr(temp(1:12));
    end
elseif strcmp(initial,'W')==1
    disp('Analyzing all F570 files for Wiggum...')
    % Pulls files from HMI_PhysiologyNotes
    include=xlsread(hmiconfig.excelfile,'Faces570','D9:D1000'); % alphanumeric, Gridlocation
    [crap,filest]=xlsread(hmiconfig.excelfile,'Faces570','E9:E1000');
    filesx=filest(find(ismember(include,[1 2])));
    for ff=1:size(filesx,1),
        temp=filesx{ff}; 
        files(ff)=cellstr(temp(1:12));
    end
end
clear include; clear initial
 
disp('**********************************************************************************')
disp('f570_AddFields.m - Add fields to previously created F570 respstructsingle matrices')
disp('**********************************************************************************')
for f=1:length(files), % perform following operations on each nex file listed
    close all % close all figure windows
    filename=char(files(f));
    disp(['Modifying files from ',filename])

    % Begin analysis
    tempstruct=load([hmiconfig.spikedir,filename,'_spkmat.mat']);
    tempbehav=tempstruct.behav_matrix(:,[1 3 4 30 40 44 41 42 43]); % load behavioural data
    tempspike=tempstruct.spikesig;
    foundunits=size(tempspike,2);
        
    % Unit loop
    for un=1:foundunits, % performed for each unit
        disp(['...analyzing ',char(tempspike(un).labels)])
        newname=char(tempspike(un).labels);
        load([hmiconfig.faces570spks,filesep,newname(1:20),'-570graphdata.mat']);
        load([hmiconfig.faces570spks,filesep,newname(1:20),'-570responsedata.mat']);
 
        % Add Fields %
        % Add correct/incorrect field, Added Oct 2012
        respstructsingle.trial_id(:,17)=tempbehav(:,4); % paste correct/incorrect field
        graphstructsingle.trial_id=respstructsingle.trial_id;
       
        
        
        % ANOVA: Identity on limited exemplars, Added Oct 2012
        exemplar=randperm(8); id_index=exemplar(1:num_id);
        pointer=find(ismember(respstructsingle.trial_id(:,3),id_index));
        respstructsingle.anova_id_min=anova1(respstructsingle.trial_m_epoch1(pointer),respstructsingle.trial_id(pointer,3),'off');
        
        % Response Latency, Added Oct 2012
        for cnd=1:88,
            respstructsingle.latency(cnd)=plx_calclatency(graphstructsingle.allconds_avg(cnd,:),...
                (std(respstructsingle.trial_m_baseline)/sqrt(length(respstructsingle.trial_m_baseline))),1000,respstructsingle.m_baseline(cnd),length(respstructsingle.trial_m_baseline));
        end
        
        %%% Added March 2014:
        % Stimulus counts
        respstructsingle.percent_correct = length(find(respstructsingle.trial_id(:,17)==6))/size(respstructsingle.trial_id,1);
        for stim=1:88,
            respstructsingle.trialcounts_all(stim)=length(find(respstructsingle.trial_id(:,1)==stim));
        end % count for each stimulus type
        respstructsingle.trialcounts_id(1)=length(find(ismember(respstructsingle.trial_id(:,1),1:6)==1));
        respstructsingle.trialcounts_id(2)=length(find(ismember(respstructsingle.trial_id(:,1),7:12)==1));
        respstructsingle.trialcounts_id(3)=length(find(ismember(respstructsingle.trial_id(:,1),13:18)==1));
        respstructsingle.trialcounts_id(4)=length(find(ismember(respstructsingle.trial_id(:,1),19:24)==1));
        respstructsingle.trialcounts_id(5)=length(find(ismember(respstructsingle.trial_id(:,1),25:30)==1));
        respstructsingle.trialcounts_id(6)=length(find(ismember(respstructsingle.trial_id(:,1),31:36)==1));
        respstructsingle.trialcounts_id(7)=length(find(ismember(respstructsingle.trial_id(:,1),37:42)==1));
        respstructsingle.trialcounts_id(8)=length(find(ismember(respstructsingle.trial_id(:,1),43:48)==1));
        respstructsingle.trialcounts_expression(1)=length(find(ismember(respstructsingle.trial_id(:,1),hmiconfig.f570_neutral)==1));
        respstructsingle.trialcounts_expression(2)=length(find(ismember(respstructsingle.trial_id(:,1),hmiconfig.f570_threat)==1));
        respstructsingle.trialcounts_expression(3)=length(find(ismember(respstructsingle.trial_id(:,1),hmiconfig.f570_feargrin)==1));
        respstructsingle.trialcounts_gaze(1)=length(find(ismember(respstructsingle.trial_id(:,1),hmiconfig.f570_directed)==1));
        respstructsingle.trialcounts_gaze(2)=length(find(ismember(respstructsingle.trial_id(:,1),hmiconfig.f570_averted)==1));

        % Identity tuning width
        % step 1 order ID responses
        % step 2 calculate HALF max
        % step 3
        
        ordered_responses=sort(respstructsingle.id_rsp_avg);
        hm=max(respstructsingle.id_rsp_avg)/2;
        respstructsingle.identity_tuning_width=min(find(ordered_responses>hm));
                
        % Resave output file for population analysis
        respstructsingle.datemodified=date;
        graphstructsingle.datemodified=date;
        
        unitname=char(respstructsingle.label);
        outputfname = [hmiconfig.faces570spks,unitname(1:end-4),'-570responsedata.mat'];
        save(outputfname,'respstructsingle')
        outputfname = [hmiconfig.faces570spks,unitname(1:end-4),'-570graphdata.mat'];
        disp('...Saving average spike density functions...')
        save(outputfname,'graphstructsingle');

        clear respstructsingle graphstructsingle
    end % end loop for each unit
    clear tempbehav tempspike 
end
return
