function f570_PatternClass_Contrasts(hmiconfig,cm_all,cm_trials,figlabel,figurepath,neuron_filter,neuron_label)
% function to conduct Pattern Classifier Analysis
% as per M.Stokes, script by AHB, June 2012

reload=0;

% establish variables
time_range=hmiconfig.pClass_time_range;
nTrials=8;
nTrials_lrg=20;
nNeurons=length(neuron_filter);
ID_index=[1:6; 7:12; 13:18; 19:24; 25:30; 31:36; 37:42; 43:48];
nID_stim=3; % number of ID stimuli

if reload==0,
    cm=struct('AFvNF',zeros(length(time_range)-1),'AFvNF_pval',zeros(length(time_range)-1),'AFvNF_Fish',zeros(length(time_range)-1),...
    'FvNF',zeros(length(time_range)-1),'FvNF_pval',zeros(length(time_range)-1),'FvNF_Fish',zeros(length(time_range)-1),...
        'NDvNA',zeros(length(time_range)-1),'NDvNA_pval',zeros(length(time_range)-1),'NDvNA_Fish',zeros(length(time_range)-1),...
        'NvExp',zeros(length(time_range)-1),'NvExp_pval',zeros(length(time_range)-1),'NvExp_Fish',zeros(length(time_range)-1),...
        'ID',zeros(length(time_range)-1),'ID_pval',zeros(length(time_range)-1),'ID_Fish',zeros(length(time_range)-1));
    
    disp('%%% Step 1 - Compile contrast data')
    disp('... Perform data compilation with a limit of 8 trials per condition')
    for un=1:nNeurons,
        unit_data=squeeze(cm_all(un,:,:)); % isolate data for current unit
        unit_trials=find(isnan(unit_data(1,:))==1, 1 )-1; % determine number of trials for current unit
        unit_id=squeeze(cm_trials(un,1:unit_trials));
        
        % Contrasts
        % ALL Faces vs. Non-Faces (All different expressions, etc.) (added August 14th, 2012)
        [corrdata.AFvNFe(1,un,1:length(time_range)-1),corrdata.AFvNFo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.faces,hmiconfig.non_faces,nTrials);
        
        % Faces vs. Non-Faces (All different expressions, etc.)
        temp=randperm(40); nonface_index=temp(1:size(hmiconfig.facesND570,2))+48; clear temp
        [corrdata.FvNFe(1,un,1:length(time_range)-1),corrdata.FvNFo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,nonface_index,nTrials);
        
         % Bodyparts vs. Objects
        [corrdata.BPvOBe(1,un,1:length(time_range)-1),corrdata.BPvOBo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.bodyp570,hmiconfig.objct570,nTrials);
        
        % Neutral Directed vs. Neutral Averted (Neutral Gaze Only)
        [corrdata.NDvNAe(1,un,1:length(time_range)-1),corrdata.NDvNAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,hmiconfig.facesNA570,nTrials);
        % Threat Directed vs. Threat Averted (added August 14th, 2012)
        [corrdata.TDvTAe(1,un,1:length(time_range)-1),corrdata.TDvTAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesTD570,hmiconfig.facesTA570,nTrials);
        % Fear Directed vs. Fear Averted (added August 14th, 2012)
        [corrdata.FDvFAe(1,un,1:length(time_range)-1),corrdata.FDvFAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesFD570,hmiconfig.facesFA570,nTrials);
               
        % Neutral Directed vs. Threat Directed
        [corrdata.NDvTDe(1,un,1:length(time_range)-1),corrdata.NDvTDo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,hmiconfig.facesTD570,nTrials);
         % Neutral Averted vs. Threat Averted (added August 14th, 2012)
        [corrdata.NAvTAe(1,un,1:length(time_range)-1),corrdata.NAvTAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesNA570,hmiconfig.facesTA570,nTrials);
        % Neutral Directed vs. Fear Grin Directed
        [corrdata.NDvFDe(1,un,1:length(time_range)-1),corrdata.NDvFDo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,hmiconfig.facesFD570,nTrials);
        % Neutral Averted vs. Fear Grin Averted (added August 14th, 2012)
        [corrdata.NAvFAe(1,un,1:length(time_range)-1),corrdata.NAvFAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesNA570,hmiconfig.facesFA570,nTrials);
        
        
        % THIS IS LIKELY FLAWED!!
        % Identity Contrasts (using ALL directions, expressions, etc.)
        [corrdata.IDe(1,un,1:length(time_range)-1),corrdata.IDo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,7:12,nTrials);
        [corrdata.IDe(2,un,1:length(time_range)-1),corrdata.IDo(2,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,13:18,nTrials);
        [corrdata.IDe(3,un,1:length(time_range)-1),corrdata.IDo(3,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,19:24,nTrials);
        [corrdata.IDe(4,un,1:length(time_range)-1),corrdata.IDo(4,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,25:30,nTrials);
        [corrdata.IDe(5,un,1:length(time_range)-1),corrdata.IDo(5,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,31:36,nTrials);
        [corrdata.IDe(6,un,1:length(time_range)-1),corrdata.IDo(6,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,37:42,nTrials);
        [corrdata.IDe(7,un,1:length(time_range)-1),corrdata.IDo(7,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,43:48,nTrials);
        [corrdata.IDe(8,un,1:length(time_range)-1),corrdata.IDo(8,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,13:18,nTrials);
        [corrdata.IDe(9,un,1:length(time_range)-1),corrdata.IDo(9,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,19:24,nTrials);
        [corrdata.IDe(10,un,1:length(time_range)-1),corrdata.IDo(10,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,25:30,nTrials);
        [corrdata.IDe(11,un,1:length(time_range)-1),corrdata.IDo(11,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,31:36,nTrials);
        [corrdata.IDe(12,un,1:length(time_range)-1),corrdata.IDo(12,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,37:42,nTrials);
        [corrdata.IDe(13,un,1:length(time_range)-1),corrdata.IDo(13,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,43:48,nTrials);
        [corrdata.IDe(14,un,1:length(time_range)-1),corrdata.IDo(14,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,19:24,nTrials);
        [corrdata.IDe(15,un,1:length(time_range)-1),corrdata.IDo(15,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,25:30,nTrials);
        [corrdata.IDe(16,un,1:length(time_range)-1),corrdata.IDo(16,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,31:36,nTrials);
        [corrdata.IDe(17,un,1:length(time_range)-1),corrdata.IDo(17,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,37:42,nTrials);
        [corrdata.IDe(18,un,1:length(time_range)-1),corrdata.IDo(18,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,43:48,nTrials);
        [corrdata.IDe(19,un,1:length(time_range)-1),corrdata.IDo(19,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,25:30,nTrials);
        [corrdata.IDe(20,un,1:length(time_range)-1),corrdata.IDo(20,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,31:36,nTrials);
        [corrdata.IDe(21,un,1:length(time_range)-1),corrdata.IDo(21,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,37:42,nTrials);
        [corrdata.IDe(22,un,1:length(time_range)-1),corrdata.IDo(22,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,43:48,nTrials);
        [corrdata.IDe(23,un,1:length(time_range)-1),corrdata.IDo(23,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,25:30,31:36,nTrials);
        [corrdata.IDe(24,un,1:length(time_range)-1),corrdata.IDo(24,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,25:30,37:42,nTrials);
        [corrdata.IDe(25,un,1:length(time_range)-1),corrdata.IDo(25,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,25:30,43:48,nTrials);
        [corrdata.IDe(26,un,1:length(time_range)-1),corrdata.IDo(26,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,31:36,37:42,nTrials);
        [corrdata.IDe(27,un,1:length(time_range)-1),corrdata.IDo(27,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,31:36,43:48,nTrials);
        [corrdata.IDe(28,un,1:length(time_range)-1),corrdata.IDo(28,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,37:42,43:48,nTrials);
        
        % Equate the number of stimuli for identity contrast
        temp=randperm(8); un_id_stim=temp(1:nID_stim); clear temp
        index1=ID_index(un_id_stim(1),:);
        index2=ID_index(un_id_stim(2),:);
        index3=ID_index(un_id_stim(3),:);
        [corrdata.IDmin_e(1,un,1:length(time_range)-1),corrdata.IDmin_o(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index1,index2,nTrials);
        [corrdata.IDmin_e(2,un,1:length(time_range)-1),corrdata.IDmin_o(2,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index1,index3,nTrials);
        [corrdata.IDmin_e(3,un,1:length(time_range)-1),corrdata.IDmin_o(3,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index2,index3,nTrials);
    end
    
    disp('... Repeat data compilation with an unlimited number of trials per condition')
    for un=1:nNeurons,
        unit_data=squeeze(cm_all(un,:,:)); % isolate data for current unit
        unit_trials=find(isnan(unit_data(1,:))==1, 1 )-1; % determine number of trials for current unit
        unit_id=squeeze(cm_trials(un,1:unit_trials));
        
        % Contrasts
        % ALL Faces vs. Non-Faces (All different expressions, etc.) (added August 14th, 2012)
        [corrdataNT.AFvNFe(1,un,1:length(time_range)-1),corrdataNT.AFvNFo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.faces,hmiconfig.non_faces);
        
        % Faces vs. Non-Faces (All different expressions, etc.)
        temp=randperm(40); nonface_index=temp(1:size(hmiconfig.facesND570,2))+48; clear temp
        [corrdataNT.FvNFe(1,un,1:length(time_range)-1),corrdataNT.FvNFo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,nonface_index);
        
        % Bodyparts vs. Objects
        [corrdataNT.BPvOBe(1,un,1:length(time_range)-1),corrdataNT.BPvOBo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.bodyp570,hmiconfig.objct570);
        
        % Neutral Directed vs. Neutral Averted (Neutral Gaze Only)
        [corrdataNT.NDvNAe(1,un,1:length(time_range)-1),corrdataNT.NDvNAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,hmiconfig.facesNA570);
        % Threat Directed vs. Threat Averted (added August 14th, 2012)
        [corrdataNT.TDvTAe(1,un,1:length(time_range)-1),corrdataNT.TDvTAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesTD570,hmiconfig.facesTA570);
        % Fear Directed vs. Fear Averted (added August 14th, 2012)
        [corrdataNT.FDvFAe(1,un,1:length(time_range)-1),corrdataNT.FDvFAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesFD570,hmiconfig.facesFA570);
               
        % Neutral Directed vs. Threat Directed
        [corrdataNT.NDvTDe(1,un,1:length(time_range)-1),corrdataNT.NDvTDo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,hmiconfig.facesTD570);
         % Neutral Averted vs. Threat Averted (added August 14th, 2012)
        [corrdataNT.NAvTAe(1,un,1:length(time_range)-1),corrdataNT.NAvTAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesNA570,hmiconfig.facesTA570);
        % Neutral Directed vs. Fear Grin Directed
        [corrdataNT.NDvFDe(1,un,1:length(time_range)-1),corrdataNT.NDvFDo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,hmiconfig.facesFD570);
        % Neutral Averted vs. Fear Grin Averted (added August 14th, 2012)
        [corrdataNT.NAvFAe(1,un,1:length(time_range)-1),corrdataNT.NAvFAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesNA570,hmiconfig.facesFA570);
        
        % Identity Contrasts (using ALL directions, expressions, etc.)
        [corrdataNT.IDe(1,un,1:length(time_range)-1),corrdataNT.IDo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,7:12);
        [corrdataNT.IDe(2,un,1:length(time_range)-1),corrdataNT.IDo(2,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,13:18);
        [corrdataNT.IDe(3,un,1:length(time_range)-1),corrdataNT.IDo(3,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,19:24);
        [corrdataNT.IDe(4,un,1:length(time_range)-1),corrdataNT.IDo(4,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,25:30);
        [corrdataNT.IDe(5,un,1:length(time_range)-1),corrdataNT.IDo(5,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,31:36);
        [corrdataNT.IDe(6,un,1:length(time_range)-1),corrdataNT.IDo(6,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,37:42);
        [corrdataNT.IDe(7,un,1:length(time_range)-1),corrdataNT.IDo(7,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,43:48);
        [corrdataNT.IDe(8,un,1:length(time_range)-1),corrdataNT.IDo(8,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,13:18);
        [corrdataNT.IDe(9,un,1:length(time_range)-1),corrdataNT.IDo(9,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,19:24);
        [corrdataNT.IDe(10,un,1:length(time_range)-1),corrdataNT.IDo(10,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,25:30);
        [corrdataNT.IDe(11,un,1:length(time_range)-1),corrdataNT.IDo(11,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,31:36);
        [corrdataNT.IDe(12,un,1:length(time_range)-1),corrdataNT.IDo(12,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,37:42);
        [corrdataNT.IDe(13,un,1:length(time_range)-1),corrdataNT.IDo(13,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,43:48);
        [corrdataNT.IDe(14,un,1:length(time_range)-1),corrdataNT.IDo(14,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,19:24);
        [corrdataNT.IDe(15,un,1:length(time_range)-1),corrdataNT.IDo(15,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,25:30);
        [corrdataNT.IDe(16,un,1:length(time_range)-1),corrdataNT.IDo(16,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,31:36);
        [corrdataNT.IDe(17,un,1:length(time_range)-1),corrdataNT.IDo(17,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,37:42);
        [corrdataNT.IDe(18,un,1:length(time_range)-1),corrdataNT.IDo(18,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,43:48);
        [corrdataNT.IDe(19,un,1:length(time_range)-1),corrdataNT.IDo(19,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,25:30);
        [corrdataNT.IDe(20,un,1:length(time_range)-1),corrdataNT.IDo(20,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,31:36);
        [corrdataNT.IDe(21,un,1:length(time_range)-1),corrdataNT.IDo(21,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,37:42);
        [corrdataNT.IDe(22,un,1:length(time_range)-1),corrdataNT.IDo(22,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,43:48);
        [corrdataNT.IDe(23,un,1:length(time_range)-1),corrdataNT.IDo(23,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,25:30,31:36);
        [corrdataNT.IDe(24,un,1:length(time_range)-1),corrdataNT.IDo(24,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,25:30,37:42);
        [corrdataNT.IDe(25,un,1:length(time_range)-1),corrdataNT.IDo(25,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,25:30,43:48);
        [corrdataNT.IDe(26,un,1:length(time_range)-1),corrdataNT.IDo(26,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,31:36,37:42);
        [corrdataNT.IDe(27,un,1:length(time_range)-1),corrdataNT.IDo(27,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,31:36,43:48);
        [corrdataNT.IDe(28,un,1:length(time_range)-1),corrdataNT.IDo(28,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,37:42,43:48);
        
        % Equate the number of stimuli for identity contrast
        temp=randperm(8); un_id_stim=temp(1:nID_stim); clear temp
        index1=ID_index(un_id_stim(1),:);
        index2=ID_index(un_id_stim(2),:);
        index3=ID_index(un_id_stim(3),:);
        [corrdataNT.IDmin_e(1,un,1:length(time_range)-1),corrdataNT.IDmin_o(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index1,index2,nTrials);
        [corrdataNT.IDmin_e(2,un,1:length(time_range)-1),corrdataNT.IDmin_o(2,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index1,index3,nTrials);
        [corrdataNT.IDmin_e(3,un,1:length(time_range)-1),corrdataNT.IDmin_o(3,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index2,index3,nTrials);
    end
    
    disp('... Repeat data compilation with 20 trials per condition')
    for un=1:nNeurons,
        unit_data=squeeze(cm_all(un,:,:)); % isolate data for current unit
        unit_trials=find(isnan(unit_data(1,:))==1, 1 )-1; % determine number of trials for current unit
        unit_id=squeeze(cm_trials(un,1:unit_trials));
        
        % Contrasts
        % ALL Faces vs. Non-Faces (All different expressions, etc.) (added August 14th, 2012)
        [corrdataALL.AFvNFe(1,un,1:length(time_range)-1),corrdataALL.AFvNFo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.faces,hmiconfig.non_faces,nTrials_lrg);
        
        % Faces vs. Non-Faces (All different expressions, etc.)
        temp=randperm(40); nonface_index=temp(1:size(hmiconfig.facesND570,2))+48; clear temp
        [corrdataALL.FvNFe(1,un,1:length(time_range)-1),corrdataALL.FvNFo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,nonface_index,nTrials_lrg);
        
        % Bodyparts vs. Objects
        [corrdataALL.BPvOBe(1,un,1:length(time_range)-1),corrdataALL.BPvOBo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.bodyp570,hmiconfig.objct570,nTrials_lrg); 
       
        % Neutral Directed vs. Neutral Averted (Neutral Gaze Only)
        [corrdataALL.NDvNAe(1,un,1:length(time_range)-1),corrdataALL.NDvNAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,hmiconfig.facesNA570,nTrials_lrg);
        % Threat Directed vs. Threat Averted (added August 14th, 2012)
        [corrdataALL.TDvTAe(1,un,1:length(time_range)-1),corrdataALL.TDvTAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesTD570,hmiconfig.facesTA570,nTrials_lrg);
        % Fear Directed vs. Fear Averted (added August 14th, 2012)
        [corrdataALL.FDvFAe(1,un,1:length(time_range)-1),corrdataALL.FDvFAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesFD570,hmiconfig.facesFA570,nTrials_lrg);
               
        % Neutral Directed vs. Threat Directed
        [corrdataALL.NDvTDe(1,un,1:length(time_range)-1),corrdataALL.NDvTDo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,hmiconfig.facesTD570,nTrials_lrg);
         % Neutral Averted vs. Threat Averted (added August 14th, 2012)
        [corrdataALL.NAvTAe(1,un,1:length(time_range)-1),corrdataALL.NAvTAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesNA570,hmiconfig.facesTA570,nTrials_lrg);
        % Neutral Directed vs. Fear Grin Directed
        [corrdataALL.NDvFDe(1,un,1:length(time_range)-1),corrdataALL.NDvFDo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesND570,hmiconfig.facesFD570,nTrials_lrg);
        % Neutral Averted vs. Fear Grin Averted (added August 14th, 2012)
        [corrdataALL.NAvFAe(1,un,1:length(time_range)-1),corrdataALL.NAvFAo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,hmiconfig.facesNA570,hmiconfig.facesFA570,nTrials_lrg);;
        
        % Identity Contrasts (using ALL directions, expressions, etc.)
        [corrdataALL.IDe(1,un,1:length(time_range)-1),corrdataALL.IDo(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,7:12,nTrials_lrg);
        [corrdataALL.IDe(2,un,1:length(time_range)-1),corrdataALL.IDo(2,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,13:18,nTrials_lrg);
        [corrdataALL.IDe(3,un,1:length(time_range)-1),corrdataALL.IDo(3,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,19:24,nTrials_lrg);
        [corrdataALL.IDe(4,un,1:length(time_range)-1),corrdataALL.IDo(4,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,25:30,nTrials_lrg);
        [corrdataALL.IDe(5,un,1:length(time_range)-1),corrdataALL.IDo(5,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,31:36,nTrials_lrg);
        [corrdataALL.IDe(6,un,1:length(time_range)-1),corrdataALL.IDo(6,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,37:42,nTrials_lrg);
        [corrdataALL.IDe(7,un,1:length(time_range)-1),corrdataALL.IDo(7,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,1:6,43:48,nTrials_lrg);
        [corrdataALL.IDe(8,un,1:length(time_range)-1),corrdataALL.IDo(8,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,13:18,nTrials_lrg);
        [corrdataALL.IDe(9,un,1:length(time_range)-1),corrdataALL.IDo(9,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,19:24,nTrials_lrg);
        [corrdataALL.IDe(10,un,1:length(time_range)-1),corrdataALL.IDo(10,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,25:30,nTrials_lrg);
        [corrdataALL.IDe(11,un,1:length(time_range)-1),corrdataALL.IDo(11,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,31:36,nTrials_lrg);
        [corrdataALL.IDe(12,un,1:length(time_range)-1),corrdataALL.IDo(12,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,37:42,nTrials_lrg);
        [corrdataALL.IDe(13,un,1:length(time_range)-1),corrdataALL.IDo(13,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,7:12,43:48,nTrials_lrg);
        [corrdataALL.IDe(14,un,1:length(time_range)-1),corrdataALL.IDo(14,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,19:24,nTrials_lrg);
        [corrdataALL.IDe(15,un,1:length(time_range)-1),corrdataALL.IDo(15,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,25:30,nTrials_lrg);
        [corrdataALL.IDe(16,un,1:length(time_range)-1),corrdataALL.IDo(16,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,31:36,nTrials_lrg);
        [corrdataALL.IDe(17,un,1:length(time_range)-1),corrdataALL.IDo(17,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,37:42,nTrials_lrg);
        [corrdataALL.IDe(18,un,1:length(time_range)-1),corrdataALL.IDo(18,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,13:18,43:48,nTrials_lrg);
        [corrdataALL.IDe(19,un,1:length(time_range)-1),corrdataALL.IDo(19,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,25:30,nTrials_lrg);
        [corrdataALL.IDe(20,un,1:length(time_range)-1),corrdataALL.IDo(20,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,31:36,nTrials_lrg);
        [corrdataALL.IDe(21,un,1:length(time_range)-1),corrdataALL.IDo(21,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,37:42,nTrials_lrg);
        [corrdataALL.IDe(22,un,1:length(time_range)-1),corrdataALL.IDo(22,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,19:24,43:48,nTrials_lrg);
        [corrdataALL.IDe(23,un,1:length(time_range)-1),corrdataALL.IDo(23,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,25:30,31:36,nTrials_lrg);
        [corrdataALL.IDe(24,un,1:length(time_range)-1),corrdataALL.IDo(24,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,25:30,37:42,nTrials_lrg);
        [corrdataALL.IDe(25,un,1:length(time_range)-1),corrdataALL.IDo(25,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,25:30,43:48,nTrials_lrg);
        [corrdataALL.IDe(26,un,1:length(time_range)-1),corrdataALL.IDo(26,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,31:36,37:42,nTrials_lrg);
        [corrdataALL.IDe(27,un,1:length(time_range)-1),corrdataALL.IDo(27,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,31:36,43:48,nTrials_lrg);
        [corrdataALL.IDe(28,un,1:length(time_range)-1),corrdataALL.IDo(28,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,37:42,43:48,nTrials_lrg);
    
        % Equate the number of stimuli for identity contrast
        temp=randperm(8); un_id_stim=temp(1:nID_stim); clear temp
        index1=ID_index(un_id_stim(1),:);
        index2=ID_index(un_id_stim(2),:);
        index3=ID_index(un_id_stim(3),:);
        [corrdataALL.IDmin_e(1,un,1:length(time_range)-1),corrdataALL.IDmin_o(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index1,index2,nTrials);
        [corrdataALL.IDmin_e(2,un,1:length(time_range)-1),corrdataALL.IDmin_o(2,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index1,index3,nTrials);
        [corrdataALL.IDmin_e(3,un,1:length(time_range)-1),corrdataALL.IDmin_o(3,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index2,index3,nTrials);
    end
    
    disp('%%% Step 2 - Construct correlation matrices')
    % Set1
    [cm.AFvNF,cm.AFvNF_pval,cm.AFvNF_Fish]=f570_mCorr(time_range,squeeze(corrdata.AFvNFe),squeeze(corrdata.AFvNFo));
    [cm.FvNF, cm.FvNF_pval,  cm.FvNF_Fish]=f570_mCorr(time_range,squeeze(corrdata.FvNFe),squeeze(corrdata.FvNFo));
    [cm.BPvOB,cm.BPvOB_pval,cm.BPvOB_Fish]=f570_mCorr(time_range,squeeze(corrdata.BPvOBe),squeeze(corrdata.BPvOBo));
    [cm.NDvNA,cm.NDvNA_pval,cm.NDvNA_Fish]=f570_mCorr(time_range,squeeze(corrdata.NDvNAe),squeeze(corrdata.NDvNAo));
    [cm.TDvTA,cm.TDvTA_pval,cm.TDvTA_Fish]=f570_mCorr(time_range,squeeze(corrdata.TDvTAe),squeeze(corrdata.TDvTAo));
    [cm.FDvFA,cm.FDvFA_pval,cm.FDvFA_Fish]=f570_mCorr(time_range,squeeze(corrdata.FDvFAe),squeeze(corrdata.FDvFAo));
    [cm.NDvTD,cm.NDvTD_pval,cm.NDvTD_Fish]=f570_mCorr(time_range,squeeze(corrdata.NDvTDe),squeeze(corrdata.NDvTDo));
    [cm.NDvFD,cm.NDvFD_pval,cm.NDvFD_Fish]=f570_mCorr(time_range,squeeze(corrdata.NDvFDe),squeeze(corrdata.NDvFDo));
    [cm.NAvTA,cm.NAvTA_pval,cm.NAvTA_Fish]=f570_mCorr(time_range,squeeze(corrdata.NAvTAe),squeeze(corrdata.NAvTAo));
    [cm.NAvFA,cm.NAvFA_pval,cm.NAvFA_Fish]=f570_mCorr(time_range,squeeze(corrdata.NAvFAe),squeeze(corrdata.NAvFAo));
    % Average Expressions
    tempeven=(squeeze(corrdata.NDvTDe)+squeeze(corrdata.NDvFDe))/2;
    tempodd=(squeeze(corrdata.NDvTDo)+squeeze(corrdata.NDvFDo))/2;
    [cm.NvExp,cm.NvExp_pval,cm.NvExp_Fish]=f570_mCorr(time_range,tempeven,tempodd);
    % Average Identity
    tempeven=squeeze(mean(corrdata.IDe,1));
    tempodd=squeeze(mean(corrdata.IDo,1));
    [cm.ID,cm.ID_pval,cm.ID_Fish]=f570_mCorr(time_range,tempeven,tempodd);
    % Average Corrected Identity
    tempeven=squeeze(mean(corrdata.IDmin_e,1));
    tempodd=squeeze(mean(corrdata.IDmin_o,1));
    [cm.IDmin,cm.IDmin_pval,cm.IDmin_Fish]=f570_mCorr(time_range,tempeven,tempodd);    
    
    % Set2
    [cmNT.AFvNF,cmNT.AFvNF_pval,cmNT.AFvNF_Fish]=f570_mCorr(time_range,squeeze(corrdataNT.AFvNFe),squeeze(corrdataNT.AFvNFo));
    [cmNT.FvNF,cmNT.FvNF_pval,cmNT.FvNF_Fish]=f570_mCorr(time_range,squeeze(corrdataNT.FvNFe),squeeze(corrdataNT.FvNFo));
    [cmNT.BPvOB,cmNT.BPvOB_pval,cmNT.BPvOB_Fish]=f570_mCorr(time_range,squeeze(corrdataNT.BPvOBe),squeeze(corrdataNT.BPvOBo));
    [cmNT.NDvNA,cmNT.NDvNA_pval,cmNT.NDvNA_Fish]=f570_mCorr(time_range,squeeze(corrdataNT.NDvNAe),squeeze(corrdataNT.NDvNAo));
    [cmNT.TDvTA,cmNT.TDvTA_pval,cmNT.TDvTA_Fish]=f570_mCorr(time_range,squeeze(corrdataNT.TDvTAe),squeeze(corrdataNT.TDvTAo));
    [cmNT.FDvFA,cmNT.FDvFA_pval,cmNT.FDvFA_Fish]=f570_mCorr(time_range,squeeze(corrdataNT.FDvFAe),squeeze(corrdataNT.FDvFAo));
    [cmNT.NAvTA,cmNT.NAvTA_pval,cmNT.NAvTA_Fish]=f570_mCorr(time_range,squeeze(corrdataNT.NAvTAe),squeeze(corrdataNT.NAvTAo));
    [cmNT.NAvFA,cmNT.NAvFA_pval,cmNT.NAvFA_Fish]=f570_mCorr(time_range,squeeze(corrdataNT.NAvFAe),squeeze(corrdataNT.NAvFAo));
    [cmNT.NDvTD,cmNT.NDvTD_pval,cmNT.NDvTD_Fish]=f570_mCorr(time_range,squeeze(corrdataNT.NDvTDe),squeeze(corrdataNT.NDvTDo));
    [cmNT.NDvFD,cmNT.NDvFD_pval,cmNT.NDvFD_Fish]=f570_mCorr(time_range,squeeze(corrdataNT.NDvFDe),squeeze(corrdataNT.NDvFDo));

    % Average Expressions
    tempeven=(squeeze(corrdataNT.NDvTDe)+squeeze(corrdataNT.NDvFDe))/2;
    tempodd=(squeeze(corrdataNT.NDvTDo)+squeeze(corrdataNT.NDvFDo))/2;
    [cmNT.NvExp,cmNT.NvExp_pval,cmNT.NvExp_Fish]=f570_mCorr(time_range,tempeven,tempodd);
    % Average Identity
    tempeven=squeeze(mean(corrdataNT.IDe,1));
    tempodd=squeeze(mean(corrdataNT.IDo,1));
    [cmNT.ID,cmNT.ID_pval,cmNT.ID_Fish]=f570_mCorr(time_range,tempeven,tempodd);
    % Average Corrected Identity
    tempeven=squeeze(mean(corrdataNT.IDmin_e,1));
    tempodd=squeeze(mean(corrdataNT.IDmin_o,1));
    [cmNT.IDmin,cmNT.IDmin_pval,cmNT.IDmin_Fish]=f570_mCorr(time_range,tempeven,tempodd);    
    
    % Set3
    [cmALL.AFvNF,cmALL.AFvNF_pval,cmALL.AFvNF_Fish]=f570_mCorr(time_range,squeeze(corrdataALL.AFvNFe),squeeze(corrdataALL.AFvNFo));
    [cmALL.FvNF,cmALL.FvNF_pval,cmALL.FvNF_Fish]=f570_mCorr(time_range,squeeze(corrdataALL.FvNFe),squeeze(corrdataALL.FvNFo));
    [cmALL.BPvOB,cmALL.BPvOB_pval,cmALL.BPvOB_Fish]=f570_mCorr(time_range,squeeze(corrdataALL.BPvOBe),squeeze(corrdataALL.BPvOBo));
    [cmALL.NDvNA,cmALL.NDvNA_pval,cmALL.NDvNA_Fish]=f570_mCorr(time_range,squeeze(corrdataALL.NDvNAe),squeeze(corrdataALL.NDvNAo));
    [cmALL.TDvTA,cmALL.TDvTA_pval,cmALL.TDvTA_Fish]=f570_mCorr(time_range,squeeze(corrdataALL.TDvTAe),squeeze(corrdataALL.TDvTAo));
    [cmALL.FDvFA,cmALL.FDvFA_pval,cmALL.FDvFA_Fish]=f570_mCorr(time_range,squeeze(corrdataALL.FDvFAe),squeeze(corrdataALL.FDvFAo));
    [cmALL.NAvTA,cmALL.NAvTA_pval,cmALL.NAvTA_Fish]=f570_mCorr(time_range,squeeze(corrdataALL.NAvTAe),squeeze(corrdataALL.NAvTAo));
    [cmALL.NAvFA,cmALL.NAvFA_pval,cmALL.NAvFA_Fish]=f570_mCorr(time_range,squeeze(corrdataALL.NAvFAe),squeeze(corrdataALL.NAvFAo));
    [cmALL.NDvTD,cmALL.NDvTD_pval,cmALL.NDvTD_Fish]=f570_mCorr(time_range,squeeze(corrdataALL.NDvTDe),squeeze(corrdataALL.NDvTDo));
    [cmALL.NDvFD,cmALL.NDvFD_pval,cmALL.NDvFD_Fish]=f570_mCorr(time_range,squeeze(corrdataALL.NDvFDe),squeeze(corrdataALL.NDvFDo));
    % Average Expressions
    tempeven=(squeeze(corrdataALL.NDvTDe)+squeeze(corrdataALL.NDvFDe))/2;
    tempodd=(squeeze(corrdataALL.NDvTDo)+squeeze(corrdataALL.NDvFDo))/2;
    [cmALL.NvExp,cmALL.NvExp_pval,cmALL.NvExp_Fish]=f570_mCorr(time_range,tempeven,tempodd);
    % Average Identity
    tempeven=squeeze(mean(corrdataALL.IDe,1));
    tempodd=squeeze(mean(corrdataALL.IDo,1));
    [cmALL.ID,cmALL.ID_pval,cmALL.ID_Fish]=f570_mCorr(time_range,tempeven,tempodd);
    % Average Corrected Identity
    tempeven=squeeze(mean(corrdataALL.IDmin_e,1));
    tempodd=squeeze(mean(corrdataALL.IDmin_o,1));
    [cmALL.IDmin,cmALL.IDmin_pval,cmALL.IDmin_Fish]=f570_mCorr(time_range,tempeven,tempodd);     
    
    disp('%%% Step 3 - Solve for Diagonals')
    for x=1:size(cm.FvNF,1),
        diagonals.rho(1,x)=cm.AFvNF(x,x);  diagonals.pval(1,x)=cm.AFvNF_pval(x,x);  diagonals.Fish(1,x)=cm.AFvNF_Fish(x,x);
        diagonals.rho(2,x)=cm.FvNF(x,x);   diagonals.pval(2,x)=cm.FvNF_pval(x,x);   diagonals.Fish(2,x)=cm.FvNF_Fish(x,x);
        diagonals.rho(3,x)=cm.NDvNA(x,x);  diagonals.pval(3,x)=cm.NDvNA_pval(x,x);  diagonals.Fish(3,x)=cm.NDvNA_Fish(x,x);
        diagonals.rho(4,x)=cm.TDvTA(x,x);  diagonals.pval(4,x)=cm.TDvTA_pval(x,x);  diagonals.Fish(4,x)=cm.TDvTA_Fish(x,x);
        diagonals.rho(5,x)=cm.FDvFA(x,x);  diagonals.pval(5,x)=cm.FDvFA_pval(x,x);  diagonals.Fish(5,x)=cm.FDvFA_Fish(x,x);
        diagonals.rho(6,x)=cm.NDvTD(x,x);  diagonals.pval(6,x)=cm.NDvTD_pval(x,x);  diagonals.Fish(6,x)=cm.NDvTD_Fish(x,x);
        diagonals.rho(7,x)=cm.NAvTA(x,x);  diagonals.pval(7,x)=cm.NAvTA_pval(x,x);  diagonals.Fish(7,x)=cm.NAvTA_Fish(x,x);
        diagonals.rho(8,x)=cm.NDvFD(x,x);  diagonals.pval(8,x)=cm.NDvFD_pval(x,x);  diagonals.Fish(8,x)=cm.NDvFD_Fish(x,x);
        diagonals.rho(9,x)=cm.NAvFA(x,x);  diagonals.pval(9,x)=cm.NAvFA_pval(x,x);  diagonals.Fish(9,x)=cm.NAvFA_Fish(x,x);
        diagonals.rho(10,x)=cm.NvExp(x,x); diagonals.pval(10,x)=cm.NvExp_pval(x,x); diagonals.Fish(10,x)=cm.NvExp_Fish(x,x);
        diagonals.rho(11,x)=cm.ID(x,x);    diagonals.pval(11,x)=cm.ID_pval(x,x);    diagonals.Fish(11,x)=cm.ID_Fish(x,x);
        diagonals.rho(12,x)=cm.IDmin(x,x); diagonals.pval(12,x)=cm.IDmin_pval(x,x); diagonals.Fish(12,x)=cm.IDmin_Fish(x,x);
        diagonals.rho(13,x)=cm.BPvOB(x,x); diagonals.pval(13,x)=cm.BPvOB_pval(x,x); diagonals.Fish(13,x)=cm.BPvOB_Fish(x,x);
    end
    
    for x=1:size(cmNT.FvNF,1),
        diagonalsNT.rho(1,x)=cmNT.AFvNF(x,x);  diagonalsNT.pval(1,x)=cmNT.AFvNF_pval(x,x);  diagonalsNT.Fish(1,x)=cmNT.AFvNF_Fish(x,x);
        diagonalsNT.rho(2,x)=cmNT.FvNF(x,x);   diagonalsNT.pval(2,x)=cmNT.FvNF_pval(x,x);   diagonalsNT.Fish(2,x)=cmNT.FvNF_Fish(x,x);
        diagonalsNT.rho(3,x)=cmNT.NDvNA(x,x);  diagonalsNT.pval(3,x)=cmNT.NDvNA_pval(x,x);  diagonalsNT.Fish(3,x)=cmNT.NDvNA_Fish(x,x);
        diagonalsNT.rho(4,x)=cmNT.TDvTA(x,x);  diagonalsNT.pval(4,x)=cmNT.TDvTA_pval(x,x);  diagonalsNT.Fish(4,x)=cmNT.TDvTA_Fish(x,x);
        diagonalsNT.rho(5,x)=cmNT.FDvFA(x,x);  diagonalsNT.pval(5,x)=cmNT.FDvFA_pval(x,x);  diagonalsNT.Fish(5,x)=cmNT.FDvFA_Fish(x,x);
        diagonalsNT.rho(6,x)=cmNT.NDvTD(x,x);  diagonalsNT.pval(6,x)=cmNT.NDvTD_pval(x,x);  diagonalsNT.Fish(6,x)=cmNT.NDvTD_Fish(x,x);
        diagonalsNT.rho(7,x)=cmNT.NAvTA(x,x);  diagonalsNT.pval(7,x)=cmNT.NAvTA_pval(x,x);  diagonalsNT.Fish(7,x)=cmNT.NAvTA_Fish(x,x);
        diagonalsNT.rho(8,x)=cmNT.NDvFD(x,x);  diagonalsNT.pval(8,x)=cmNT.NDvFD_pval(x,x);  diagonalsNT.Fish(8,x)=cmNT.NDvFD_Fish(x,x);
        diagonalsNT.rho(9,x)=cmNT.NAvFA(x,x);  diagonalsNT.pval(9,x)=cmNT.NAvFA_pval(x,x);  diagonalsNT.Fish(9,x)=cmNT.NAvFA_Fish(x,x);
        diagonalsNT.rho(10,x)=cmNT.NvExp(x,x); diagonalsNT.pval(10,x)=cmNT.NvExp_pval(x,x); diagonalsNT.Fish(10,x)=cmNT.NvExp_Fish(x,x);
        diagonalsNT.rho(11,x)=cmNT.ID(x,x);    diagonalsNT.pval(11,x)=cmNT.ID_pval(x,x);    diagonalsNT.Fish(11,x)=cmNT.ID_Fish(x,x);
        diagonalsNT.rho(12,x)=cmNT.IDmin(x,x); diagonalsNT.pval(12,x)=cmNT.IDmin_pval(x,x); diagonalsNT.Fish(12,x)=cmNT.IDmin_Fish(x,x);
        diagonalsNT.rho(13,x)=cmNT.BPvOB(x,x); diagonalsNT.pval(13,x)=cmNT.BPvOB_pval(x,x); diagonalsNT.Fish(13,x)=cmNT.BPvOB_Fish(x,x);
end
    
    for x=1:size(cmALL.FvNF,1),
        diagonalsALL.rho(1,x)=cmALL.AFvNF(x,x);  diagonalsALL.pval(1,x)=cmALL.AFvNF_pval(x,x);  diagonalsALL.Fish(1,x)=cmALL.AFvNF_Fish(x,x);
        diagonalsALL.rho(2,x)=cmALL.FvNF(x,x);   diagonalsALL.pval(2,x)=cmALL.FvNF_pval(x,x);   diagonalsALL.Fish(2,x)=cmALL.FvNF_Fish(x,x);
        diagonalsALL.rho(3,x)=cmALL.NDvNA(x,x);  diagonalsALL.pval(3,x)=cmALL.NDvNA_pval(x,x);  diagonalsALL.Fish(3,x)=cmALL.NDvNA_Fish(x,x);
        diagonalsALL.rho(4,x)=cmALL.TDvTA(x,x);  diagonalsALL.pval(4,x)=cmALL.TDvTA_pval(x,x);  diagonalsALL.Fish(4,x)=cmALL.TDvTA_Fish(x,x);
        diagonalsALL.rho(5,x)=cmALL.FDvFA(x,x);  diagonalsALL.pval(5,x)=cmALL.FDvFA_pval(x,x);  diagonalsALL.Fish(5,x)=cmALL.FDvFA_Fish(x,x);
        diagonalsALL.rho(6,x)=cmALL.NDvTD(x,x);  diagonalsALL.pval(6,x)=cmALL.NDvTD_pval(x,x);  diagonalsALL.Fish(6,x)=cmALL.NDvTD_Fish(x,x);
        diagonalsALL.rho(7,x)=cmALL.NAvTA(x,x);  diagonalsALL.pval(7,x)=cmALL.NAvTA_pval(x,x);  diagonalsALL.Fish(7,x)=cmALL.NAvTA_Fish(x,x);
        diagonalsALL.rho(8,x)=cmALL.NDvFD(x,x);  diagonalsALL.pval(8,x)=cmALL.NDvFD_pval(x,x);  diagonalsALL.Fish(8,x)=cmALL.NDvFD_Fish(x,x);
        diagonalsALL.rho(9,x)=cmALL.NAvFA(x,x);  diagonalsALL.pval(9,x)=cmALL.NAvFA_pval(x,x);  diagonalsALL.Fish(9,x)=cmALL.NAvFA_Fish(x,x);
        diagonalsALL.rho(10,x)=cmALL.NvExp(x,x); diagonalsALL.pval(10,x)=cmALL.NvExp_pval(x,x); diagonalsALL.Fish(10,x)=cmALL.NvExp_Fish(x,x);
        diagonalsALL.rho(11,x)=cmALL.ID(x,x);    diagonalsALL.pval(11,x)=cmALL.ID_pval(x,x);    diagonalsALL.Fish(11,x)=cmALL.ID_Fish(x,x);
        diagonalsALL.rho(12,x)=cmALL.IDmin(x,x); diagonalsALL.pval(12,x)=cmALL.IDmin_pval(x,x); diagonalsALL.Fish(12,x)=cmALL.IDmin_Fish(x,x);
        diagonalsALL.rho(13,x)=cmALL.BPvOB(x,x); diagonalsALL.pval(13,x)=cmALL.BPvOB_pval(x,x); diagonalsALL.Fish(13,x)=cmALL.BPvOB_Fish(x,x);
    end
    save([hmiconfig.faces570spks,filesep,figlabel,'-',neuron_label,'-570cm.mat'],'cm','cmNT','cmALL','diagonals','diagonalsNT','diagonalsALL')
    
else
    load([hmiconfig.faces570spks,filesep,figlabel,'-',neuron_label,'-570cm.mat'])
end

%f570_PatternClass_GenFigure(hmiconfig,figlabel,figurepath,cm,diagonals,['8trials-',neuron_label])
%export_fig Faces570_Fig7b_pClass_part1_8Trials -eps -rgb -transparent
%f570_PatternClass_GenFigure2(hmiconfig,figlabel,figurepath,cm,diagonals,['8trials-',neuron_label])
%export_fig Faces570_Fig7b_pClass_part2_8Trials -eps -rgb -transparent

f570_PatternClass_GenFigure(hmiconfig,figlabel,figurepath,cmNT,diagonalsNT,['NoLimit-',neuron_label])
export_fig Faces570_Fig7b_pClass_part1_NoLimit -eps -rgb -transparent
f570_PatternClass_GenFigure2(hmiconfig,[figlabel,'_p2'],figurepath,cmNT,diagonalsNT,['NoLimit-',neuron_label])
export_fig Faces570_Fig7b_pClass_part2_NoLimit -eps -rgb -transparent

%f570_PatternClass_GenFigure(hmiconfig,figlabel,figurepath,cmALL,diagonalsALL,['20trials-',neuron_label])
%export_fig Faces570_Fig7b_pClass_part1_20Trials -eps -rgb -transparent
%f570_PatternClass_GenFigure2(hmiconfig,figlabel,figurepath,cmALL,diagonalsALL,['20trials-',neuron_label])
%export_fig Faces570_Fig7b_pClass_part2_20Trials -eps -rgb -transparent




return



