function [diagonalsNT]=f570_PatternClass_Contrasts_new(hmiconfig,cm_all,cm_trials,figlabel,figurepath,neuron_filter,neuron_label,rep_option)
% function to conduct Pattern Classifier Analysis
% as per M.Stokes, script by AHB, June 2012
% Updated October 2012, for paper

% establish variables
time_range=hmiconfig.pClass_time_range;
nTrials=8;
nTrials_lrg=20;
nNeurons=length(neuron_filter);
ID_index=[1:6; 7:12; 13:18; 19:24; 25:30; 31:36; 37:42; 43:48];
nID_stim=3; % number of ID stimuli
if nargin<8, rep_option=0; end

cmNT=struct('AFvNF',zeros(length(time_range)-1),'AFvNF_pval',zeros(length(time_range)-1),'AFvNF_Fish',zeros(length(time_range)-1),...
    'FvNF',zeros(length(time_range)-1),'FvNF_pval',zeros(length(time_range)-1),'FvNF_Fish',zeros(length(time_range)-1),...
    'NDvNA',zeros(length(time_range)-1),'NDvNA_pval',zeros(length(time_range)-1),'NDvNA_Fish',zeros(length(time_range)-1),...
    'NvExp',zeros(length(time_range)-1),'NvExp_pval',zeros(length(time_range)-1),'NvExp_Fish',zeros(length(time_range)-1),...
    'ID',zeros(length(time_range)-1),'ID_pval',zeros(length(time_range)-1),'ID_Fish',zeros(length(time_range)-1));

disp('%%% Step 1 - Compile contrast data')

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
    [corrdataNT.IDmin_e(1,un,1:length(time_range)-1),corrdataNT.IDmin_o(1,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index1,index2);
    [corrdataNT.IDmin_e(2,un,1:length(time_range)-1),corrdataNT.IDmin_o(2,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index1,index3);
    [corrdataNT.IDmin_e(3,un,1:length(time_range)-1),corrdataNT.IDmin_o(3,un,1:length(time_range)-1)]=id_contrast(unit_id,unit_data,index2,index3);
end

disp('%%% Step 2 - Construct correlation matrices')
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

% Average corrected after JNeurosci Rejection
cmNT.avgExpression_Fish=mean(cat(3,cmNT.NDvFD_Fish,cmNT.NDvTD_Fish),3);

disp('%%% Step 3 - Solve for Diagonals')
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
    diagonalsNT.Fish(14,x)=cmNT.avgExpression_Fish(x,x);
end

save([hmiconfig.faces570spks,filesep,figlabel,'-',neuron_label,'-570cm.mat'],'cmNT','diagonalsNT')

figname=['Faces570_Fig4_',figlabel];
f570_PatternClass_GenFigure(hmiconfig,figlabel,figurepath,cmNT,diagonalsNT,['NoLimit-',neuron_label])

%export_fig(sprintf(figname), '-eps', '-rgb', '-transparent');
%export_fig Faces570_Fig7b_pClass_part1_NoLimit -eps -rgb -transparent
%f570_PatternClass_GenFigure2(hmiconfig,[figlabel,'_p2'],figurepath,cmNT,diagonalsNT,['NoLimit-',neuron_label])
%export_fig Faces570_Fig7b_pClass_part2_NoLimit -eps -rgb -transparent

return



