function faces570_paper(analyses)
%%%%%%%%%%%%%%%%%%
% faces570_paper %
%%%%%%%%%%%%%%%%%%
% written by AHB, Feb 2012, updated October 2012 (Brief Communication Version)
% Code adjusted to work under Mac OSX, Matlab v2013b
% Program to compile all FACES570 neurons and generate summary figures.
% This program requires data from XP version of faces570_population for both monkeys

%Your monkey 1: female, mid-age
%Your monkey 2: female, mid-age
%Your monkey 3: male, mid-age
%Your monkey 4: male, mid-age
%Your monkey 5: female, young
%Your monkey 6: female, mid-ge
%Your monkey 7: female, can't tell the age
%Your monkey 8: female, 20 years old

%%% SETUP DEFAULTS
global xldata monkeyname hmiconfig anterior posterior S_xldata W_xldata
close all;
hmiconfig=generate_f570_config; % generates and loads config file
warning off
if nargin==0, analyses=0:9; end
hmiconfig.fontsize_sml=10; hmiconfig.fontsize_med=12; hmiconfig.fontsize_lrg=14;
hmiconfig.xrange=[-100 400];

disp('+----------------------------------------------------------------+')
disp('| faces570_paper.m - Program to generate figures for manuscript. |')
disp('+----------------------------------------------------------------+')

program_version='2013-11-23'

hmiconfig.figurepath='/Users/ab03/Documents/_Current_Projects/Faces_Manuscript/figure_source_images';
cd(hmiconfig.figurepath)

% Add any additional fields to RESPSTRUCTSINGLE
%f570_AddFields('S'); % add new fields
%f570_AddFields('W'); % add new fields

% Compile Data
%f570_compiledata(hmiconfig,'S');
%f570_compiledata(hmiconfig,'W');
%f570_compiledata(hmiconfig,'B');

% Load Data
load('/Users/ab03/Documents/PlexonData/faces570spks/Faces570data_Stewie.mat');
S_xldata=xldata; S_facegrids=facegrids;
load('/Users/ab03/Documents/PlexonData/faces570spks/Faces570data_Wiggum.mat');
W_xldata=xldata; W_facegrids=facegrids;
facegrids=[S_facegrids,W_facegrids];

load('/Users/ab03/Documents/PlexonData/faces570spks/Faces570data_BothMonkeys.mat');

% Append A/P Index
for unit=1:length(xldata.gridloc),
    xldata.apindex(unit,:)=plx_convertgrid2ap(char(xldata.gridloc(unit)));
end
for unit=1:length(S_xldata.gridloc),
    S_xldata.apindex(unit,:)=plx_convertgrid2ap(char(S_xldata.gridloc(unit)));
end
for unit=1:length(W_xldata.gridloc),
    W_xldata.apindex(unit,:)=plx_convertgrid2ap(char(W_xldata.gridloc(unit)));
end
anterior=[19 18 17 16 15 14];
posterior=[5 6 7 8 9 10];

% Generate Figures - See Projects.docx for details

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 1.1 - Methods, Descriptive Stats, and Examples %
% Figure 1.2 - Descriptives broken down into individual monkey %
% Figure 1.3 - Descriptive Stats, and Examples according to Location %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(ismember(analyses,[1 1.1])==1,1))==0,
    f570_descriptives;
end
if isempty(find(ismember(analyses,[1 1.2])==1,1))==0,
    f570_descriptives_monkey;
end
if isempty(find(ismember(analyses,[1 1.3])==1,1))==0,
    f570_descriptives_ant_post;
end
if isempty(find(ismember(analyses,[1 1.4])==1,1))==0,
    f570_descriptives_ant_post_nonface;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 2.1 - Sample Curves for different neuron types 
% Figure 2.2 - Population Curves and Effect of Facial Expression on face neurons%
% Figure 2.3 - Population Curves and Effect of Facial Expression on other neuron types 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(ismember(analyses,[2 2.1])==1,1))==0,
    f570_sample_spden;
end    
if isempty(find(ismember(analyses,[2 2.2])==1,1))==0,
    f570_socialcue_response; % includes new tuning width for Identity
end
if isempty(find(ismember(analyses,[2 2.3])==1,1))==0,
   % f570_socialcue_response_nonface('Bodyparts')
   % f570_socialcue_response_nonface('Objects')
   % f570_socialcue_response_nonface('Non-responsive')
   % f570_socialcue_response_nonface({'Objects' 'Bodyparts'})
   f570_socialcue_response_nonface({'Objects' 'Bodyparts' 'Non-responsive'})
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 3.1 - Intersecting vs. Independent Pathways            %
% Figure 3.2 - Intersecting vs. Independent Pathways (Advanced) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(ismember(analyses,[3 3.1])==1,1))==0,
    f570_venndiagrams;
    f570_venndiagrams_nonface;
end
if isempty(find(ismember(analyses,[3 3.2])==1,1))==0,
    f570_cell_progression
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 4.1 - New Analysis Identity Tuning Width %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(ismember(analyses,[4 4.1])==1,1))==0,
    mean(reshape(xldata.trialcounts_all,1,637*88))
    sem(reshape(xldata.trialcounts_all,1,637*88))
    median(reshape(xldata.trialcounts_all,1,637*88))
    
    mean(reshape(xldata.trialcounts_id,1,637*8))
    sem(reshape(xldata.trialcounts_id,1,637*8))
    median(reshape(xldata.trialcounts_id,1,637*8))

    mean(reshape(xldata.trialcounts_expression,1,637*3))
    sem(reshape(xldata.trialcounts_expression,1,637*3))
    median(reshape(xldata.trialcounts_expression,1,637*3))

    mean(reshape(xldata.trialcounts_gaze,1,637*2))
    sem(reshape(xldata.trialcounts_gaze,1,637*2))
    median(reshape(xldata.trialcounts_gaze,1,637*2))
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 5 - Pattern Classifier Analysis %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(ismember(analyses,[5])==1,1))==0,
    disp('Figures 5 - Pattern Classifier Analysis, according to A/P')
    reload=1; repetition=0;
    % Prepare Correlation Matrix for All
    if reload~=1,
        [cm_all,cm_trials]=f570_PatternClass_PrepMatrix(hmiconfig,xldata,['AllNeurons-',monkeyname],hmiconfig.figurepath);
        [~,~,cm_fish]=f570_PatternClass_BootStrap(hmiconfig,cm_all,cm_trials,['AllNeurons-',monkeyname]);
    else
        load([hmiconfig.faces570spks,filesep,'AllNeurons-',monkeyname,'-570cmAll.mat']);
        load([hmiconfig.faces570spks,filesep,'AllNeurons-',monkeyname,'-570_BootStrap.mat']);
    end
    % All Neurons
    neuron_pointer=1:637; % all neurons
    f570_PatternClass_Contrasts_new(hmiconfig,cm_all,cm_trials,monkeyname,hmiconfig.figurepath,neuron_pointer,'All');
    % Face Responsive Neurons
    neuron_pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1);
    f570_PatternClass_Contrasts_new(hmiconfig,cm_all,cm_trials,monkeyname,hmiconfig.figurepath,neuron_pointer,'FR');
    % Non-Face/Visually Responsive Neurons
    neuron_pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1);
    f570_PatternClass_Contrasts_new(hmiconfig,cm_all,cm_trials,monkeyname,hmiconfig.figurepath,neuron_pointer,'NR');
        
    % Contrast ANTERIOR vs. POSTERIOR
    neuron_pointer=find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1);
    [post_output]=f570_PatternClass_Contrasts_new(hmiconfig,cm_all,cm_trials,monkeyname,hmiconfig.figurepath,neuron_pointer,'FR-posterior');
    
    neuron_pointer=find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1);
    [ant_output]=f570_PatternClass_Contrasts_new(hmiconfig,cm_all,cm_trials,monkeyname,hmiconfig.figurepath,neuron_pointer,'FR-anterior');
    
    % Area Under the Curve Analysis
    bardata=zeros(4,2);
    bardata(1,1)=sum(ant_output.Fish(2,16:51));
    bardata(2,1)=sum(ant_output.Fish(3,16:51));
    bardata(3,1)=sum(ant_output.Fish(10,16:51));
    bardata(4,1)=sum(ant_output.Fish(12,16:51));
    bardata(1,2)=sum(post_output.Fish(2,16:51));
    bardata(2,2)=sum(post_output.Fish(3,16:51));
    bardata(3,2)=sum(post_output.Fish(10,16:51));
    bardata(4,2)=sum(post_output.Fish(12,16:51));
    
    figure; bar(bardata);
    ylabel('area under the curve (50-400ms)'); legend('Ant','Post')
    set(gca,'XTickLabels',{'FvNF','GD','Ex','ID*'}); 
    export_fig Faces570_Fig4_AUC_Analysis.eps -eps -transparent -rgb
    
    
    if repetition==1,
        % Contrast different number of neurons in population (randomly selected 100 times)
        f570_PatternClass_GenFigure_Repetition(hmiconfig,xldata,monkeyname,cm_all,cm_trials,'Repetition',hmiconfig.figurepath,reload,'Repetition')
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 5 - Response Latency %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==9, 1))==0,
    disp('Figures 5 - Response Latency')
    
    face_pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1);
    bodypart_pointer=find(xldata.validbodyp<0.05 & strcmp(xldata.confneur,'Sensory')==1);
    object_pointer=find(xldata.validobject<0.05 & strcmp(xldata.confneur,'Sensory')==1);
    
    % need to find just the responsive neurons, clip for latencies too early (and late)
    % mean latency for:
    % 6 different face responses
    % two non face categories
    bardata=zeros(6,2);
    bardata(1,1)=mean(mean_noncol(xldata.latency(face_pointer,hmiconfig.facesND570)));
    bardata(2,1)=mean(mean_noncol(xldata.latency(face_pointer,hmiconfig.facesNA570)));
    bardata(3,1)=mean(mean_noncol(xldata.latency(face_pointer,hmiconfig.facesTD570)));
    bardata(4,1)=mean(mean_noncol(xldata.latency(face_pointer,hmiconfig.facesTA570)));
    bardata(5,1)=mean(mean_noncol(xldata.latency(face_pointer,hmiconfig.facesFD570)));
    bardata(6,1)=mean(mean_noncol(xldata.latency(face_pointer,hmiconfig.facesFA570)));
    bardata(7,1)=mean(mean_noncol(xldata.latency(bodypart_pointer,hmiconfig.bodyp570)));
    bardata(8,1)=mean(mean_noncol(xldata.latency(object_pointer,hmiconfig.objct570)));
    figure
    bar(bardata(:,1))
    ylim([110 170])
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 7 - Compare Critical Phases of Response %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==10, 1))==0,
    disp('Figure 6 - Compare Critical Phases of Response')
    
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    binsize=10;
    
    subplot(1,2,1); hold on % Facial Expression (only SIG neurons)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
    floatdata=f570_floatANOVAnorm(hmiconfig,xldata,pointer,hmiconfig.xrange,binsize);
    [hax,h1,h2]=plotyy(hmiconfig.xrange(1):binsize:hmiconfig.xrange(end)-binsize,mean(floatdata.facesND),hmiconfig.xrange(1):binsize:hmiconfig.xrange(end)-binsize,floatdata.anova(:,1));
    xlabel('Time from Stimulus Onset (ms)','FontSize',hmiconfig.fontsize_med)
    title('Face Responsive Neurons with Significant FE Effect (Normalized)','FontSize',10,'FontWeight','Bold')
    axes(hax(1)); hold on %#ok
    plot(hmiconfig.xrange(1):binsize:hmiconfig.xrange(end)-binsize,mean(floatdata.facesTD),'k-','LineWidth',1)
    plot(hmiconfig.xrange(1):binsize:hmiconfig.xrange(end)-binsize,mean(floatdata.facesFD),'r-','LineWidth',1)
    set(h1,'LineStyle','-'); set(gca,'XLim',[-100 400])
    set(h2,'LineWidth',1)
    ylabel('Mean Activity (sp/s)','FontSize',hmiconfig.fontsize_sml)
    axes(hax(2)); hold on %#ok
    plot(hmiconfig.xrange,[0.05 0.05],'k:')
    set(h2,'LineStyle','-','LineWidth',1); set(gca,'YLim',[0 0.50],'XLim',[-100 400])
    ylabel('p-value (ANOVA)','FontSize',hmiconfig.fontsize_sml)
    
    subplot(1,2,2); hold on % Gaze Direction (only SIG neurons)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
    floatdata=f570_floatANOVAnorm(hmiconfig,xldata,pointer,hmiconfig.xrange,binsize);
    [hax,h1,h2]=plotyy(hmiconfig.xrange(1):binsize:hmiconfig.xrange(end)-binsize,mean(floatdata.facesND),hmiconfig.xrange(1):binsize:hmiconfig.xrange(end)-binsize,floatdata.anova(:,2));
    xlabel('Time from Stimulus Onset (ms)','FontSize',hmiconfig.fontsize_med)
    title('Face Responsive Neurons with Significant GD Effect (Normalized)','FontSize',10,'FontWeight','Bold')
    axes(hax(1)); hold on %#ok
    plot(hmiconfig.xrange(1):binsize:hmiconfig.xrange(end)-binsize,mean(floatdata.facesNA),'r-','LineWidth',1)
    set(h1,'LineStyle','-'); set(gca,'XLim',[-100 400])
    set(h2,'LineWidth',1)
    ylabel('Mean Activity (sp/s)','FontSize',hmiconfig.fontsize_sml)
    axes(hax(2)); hold on %#ok
    plot(hmiconfig.xrange,[0.05 0.05],'k:')
    set(h2,'LineStyle','-','LineWidth',1); set(gca,'YLim',[0 0.50],'XLim',[-100 400])
    ylabel('p-value (ANOVA)','FontSize',hmiconfig.fontsize_sml)
    
    jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig6_floatANOVA.jpg'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    export_fig Faces570_Fig6_floatANOVA -eps -rgb -transparent
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 8 - Repetition Suppression/Adaptation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==11, 1))==0,
    disp('Figure 8 - Evidence of Repetition Suppression/Adaptation to Social Stimuli')
    
    % Analysis No.1 - Adaptation to all different categories of stimuli for different neuronal populations
    % This will examine RS to INDIVDIDUAL stimuli, grouped according to category
    % May need to think about the logic of this - after all, faces were presented many times more than other stimuli
    
    figure; clf; cla; hold on %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    % Show proportion of neurons that show adaptation (defined as index greater than something certain)
    
    pointerFS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1); % face-selective
    pointerBS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Bodyparts')==1); % bodypart-selective
    pointerOS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Objects')==1); % objet-selective
    [bardata1,fa_pref_adapt]=f570_AdaptPop(xldata,pointerFS,'trial_id11','trial_id5',1); % select only face responses
    [bardata2,bp_pref_adapt]=f570_AdaptPop(xldata,pointerBS,'trial_id11','trial_id5',2); % select only bp responses
    [bardata3,ob_pref_adapt]=f570_AdaptPop(xldata,pointerOS,'trial_id11','trial_id5',3); % select on object responses
    
    pointerFS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05); % face-responsive
    pointerBS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validbodyp<0.05); % bodypart-responsive
    pointerOS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validobject<0.05); % objet-responsive
    [bardata1,fa_all_adapt]=f570_AdaptPop(xldata,pointerFS,'trial_id11','trial_id5',1); % select only face responses
    [bardata2,bp_all_adapt]=f570_AdaptPop(xldata,pointerBS,'trial_id11','trial_id5',2); % select only bp responses
    [bardata3,ob_all_adapt]=f570_AdaptPop(xldata,pointerOS,'trial_id11','trial_id5',3); % select on object responses
    
    
    data1=fa_pref_adapt.baseline; num_units1=size(data1,1);
    data2=bp_pref_adapt.baseline; num_units2=size(data2,1);
    data3=ob_pref_adapt.baseline; num_units3=size(data3,1);
    data4=fa_all_adapt.baseline; num_units4=size(data4,1);
    data5=bp_all_adapt.baseline; num_units5=size(data5,1);
    data6=ob_all_adapt.baseline; num_units6=size(data6,1);
    for rr=2:5, % solve for proportion of neurons that have index > 0.20
        bd(1,rr)=length(find(data1(:,rr)>0.2))/num_units1;
        bd(2,rr)=length(find(data2(:,rr)>0.2))/num_units2;
        bd(3,rr)=length(find(data3(:,rr)>0.2))/num_units3;
        bd(4,rr)=length(find(data4(:,rr)>0.2))/num_units4;
        bd(5,rr)=length(find(data5(:,rr)>0.2))/num_units5;
        bd(6,rr)=length(find(data6(:,rr)>0.2))/num_units6;
        
        bd(7,rr)=length(find(data1(:,rr)>0.2));
        bd(8,rr)=length(find(data2(:,rr)>0.2));
        bd(9,rr)=length(find(data3(:,rr)>0.2));
        bd(9,rr)=length(find(data4(:,rr)>0.2));
        bd(10,rr)=length(find(data5(:,rr)>0.2));
        bd(11,rr)=length(find(data6(:,rr)>0.2));
        
        bd(12,rr)=chi2_test(bd(7:11,rr)); % assumes equal distribution
        
    end
    plot(bd(1:6,:)','LineWidth',2);
    for cs=2:5,
        text(cs,0.35,['p=',num2str(bd(12,cs),'%.2g')],'FontSize',hmiconfig.fontsize_med)
    end
    xlim([2 5]); ylim([0 0.4]); xlabel('Presentation Number','FontSize',11); ylabel('Proportion of Neurons with Aind > 0.20','FontSize',11)
    legend('Fpref','Bpref','Opref','Fall','Ball','Oall')
    
    jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig8_repetitionsuppression.jpg'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    export_fig Faces570_Fig8_repetitionsuppression -eps -rgb -transparent
    
end

return