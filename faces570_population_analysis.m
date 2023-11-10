function faces570_paper(analyses)
%%%%%%%%%%%%%%%%%%
% faces570_paper %
%%%%%%%%%%%%%%%%%%
% written by AHB, Feb 2012
% Code adjusted to work under Mac OSX, Matlab v2011b
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
close all;
hmiconfig=generate_f570_config; % generates and loads config file

if nargin==0, analyses=0:9; end
fontsize_sml=10; fontsize_med=12; fontsize_lrg=14;
xrange=[-100 500];

disp('+---------------------------------------------------------------------+')
disp('| faces570_population.m - Program to compile all FACES570 neurons and |')
disp('|        generate summary figures.                                    |')
disp('| NOTE:  This program works best if run AFTER plx570sync2excel.m      |')
disp('+---------------------------------------------------------------------+')

figurepath='/Users/ab03/Documents/Manuscripts_Grants/Faces570/F570_MatlabData/f570_figures';

% Load Data
%load('/Users/ab03/Documents/PlexonData/faces570spks/Faces570data_Stewie.mat');
%S_xldata=xldata; S_facegrids=facegrids;
%load('/Users/ab03/Documents/PlexonData/faces570spks/Faces570data_Wiggum.mat');
%W_xldata=xldata; W_facegrids=facegrids;
load('/Users/ab03/Documents/PlexonData/faces570spks/Faces570data_BothMonkeys.mat');


% Generate Figures - See Projects.docx for details

faces570_paper_example;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 0 - Summary Statistics %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==0,1))==0,
    disp('Figure 0.1 - Summary Figure')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.05 0.15 0.4 0.7]); set(gca,'FontName','Arial','FontSize',10);
    subplot(3,3,1); piedata=[]; %
    piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1));
    piedata(2)=length(find(strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1));
    piedata(3)=length(find(strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1));
    piedata(4)=length(find(strcmp(xldata.confprefcat,'Non-responsive')==1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
    title([monkeyname,' - (A) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_lrg,'FontWeight','Bold')
    legend('F','Bp','O','Nr','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,3,2); piedata=[]; %
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface>=0.05));
    piedata(3)=length(find(strcmp(xldata.confneur,'Non-responsive')==1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title([monkeyname,' - (B) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_lrg,'FontWeight','Bold')
    legend('FResp','nonFRresp','Nr','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,3,3); piedata=[]; %
    piedata(1)=length(find(strcmp(xldata.confresptype,'Excite')==1 & strcmp(xldata.confneur,'Sensory')==1));
    piedata(2)=length(find(strcmp(xldata.confresptype,'Suppress')==1 & strcmp(xldata.confneur,'Sensory')==1));
    piedata(3)=length(find(strcmp(xldata.confresptype,'Both')==1 & strcmp(xldata.confneur,'Sensory')==1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) Excite/Suppress/Both (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_lrg,'FontWeight','Bold')
    legend('E','S','B','Location','Best'); set(gca,'FontSize',fontsize_sml)
    %%% Face-Preferring Neurons
    subplot(3,3,4); piedata=[]; %
    piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05));
    piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({['(D) Facial Expression ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',fontsize_lrg,'FontWeight','Bold')
    legend('sigFE','nonsig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,3,5); piedata=[]; %
    piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05));
    piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({['(E) Gaze Direction ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',fontsize_lrg,'FontWeight','Bold')
    legend('sigGD','nonsig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,3,6); piedata=[]; %
    piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
    piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({['(F) Identity ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',fontsize_lrg,'FontWeight','Bold')
    legend('sigI','nonsig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    %%% Face-Responsive Neurons (all neurons that have a valid face response)
    subplot(3,3,7); piedata=[]; %
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'>=0.05));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({['(G) Facial Expression ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',fontsize_lrg,'FontWeight','Bold')
    legend('sigFE','nonsig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,3,8); piedata=[]; %
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_gd'<0.05));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_gd'>=0.05));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({['(H) Gaze Direction ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',fontsize_lrg,'FontWeight','Bold')
    legend('sigGD','nonsig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,3,9); piedata=[]; %
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id'<0.05));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id'>=0.05));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({['(I) Identity ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',fontsize_lrg,'FontWeight','Bold')
    legend('sigI','nonsig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig0.1_PieCharts_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig0.1_PieCharts_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 0.2 - Summary of Anova Effects of Face-Responsive Neurons')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',10);
    subplot(2,2,1)
    totalunits=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1));
    clear bardata
    bardata(1,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05))/totalunits*100;
    bardata(2,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05))/totalunits*100;
    bardata(3,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05))/totalunits*100;
    bardata(4,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_id(:,3)<0.05))/totalunits*100;
    bardata(5,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_gd(:,3)<0.05))/totalunits*100;
    bardata(6,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05))/totalunits*100;
    bar(bardata); ylim([0 100]);
    ylabel('% Face Responsive Neurons','FontSize',fontsize_med)
    set(gca,'XTickLabel',{'FE','ID','GD','FExID','GDxID','FExGD'})
    title([monkeyname,' - ANOVA Main Effects & Interactions'],'FontSize',fontsize_lrg)
   
    subplot(2,1,2)
    bardata=[];
    [bardata(1,1),bardata(1,2)]=mean_sem(xldata.face_si(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1))); %#ok<*FNDSB>
    [bardata(2,1),bardata(2,2)]=mean_sem(xldata.bodyp_si(find(strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1)));
    [bardata(3,1),bardata(3,2)]=mean_sem(xldata.objct_si(find(strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1)));
    hold on;
    bar(1:3,bardata(:,1))
    errorbar(1:3,bardata(:,1),bardata(:,2))
    ylabel('% Category Selectivity (si)','FontSize',fontsize_med)
    set(gca,'XTickLabel',{'Faces','Bodyparts','Objects'},'XTick',1:3)
    %bar(histc(xldata.face_si(pointer),0:0.05:1))
    title([monkeyname,' - Average Selectivity'],'FontSize',fontsize_lrg)
    
    subplot(2,2,3); bardata=[];
    load([hmiconfig.rootdir,'rsvp500_project1',filesep,'Project1Data_BothMonks.mat']);
    % Data from RSVP500 Study (face, object, place, bodypart, fruit)
    pointer=find(strcmp(unit_index.CategoryConf,'Faces')==1 & strcmp(unit_index.SensoryConf,'Sensory')==1);
    [bardata(1,1),bardata(1,2)]=mean_sem(unitdata.cat_si(pointer,1));
    pointer=find(strcmp(unit_index.CategoryConf,'BodyParts')==1 & strcmp(unit_index.SensoryConf,'Sensory')==1);
    [bardata(2,1),bardata(2,2)]=mean_sem(unitdata.cat_si(pointer,4));
    pointer=find(strcmp(unit_index.CategoryConf,'Objects')==1 & strcmp(unit_index.SensoryConf,'Sensory')==1);
    [bardata(3,1),bardata(3,2)]=mean_sem(unitdata.cat_si(pointer,5));
    pointer=find(strcmp(unit_index.CategoryConf,'Places')==1 & strcmp(unit_index.SensoryConf,'Sensory')==1);
    [bardata(4,1),bardata(4,2)]=mean_sem(unitdata.cat_si(pointer,3));
    pointer=find(strcmp(unit_index.CategoryConf,'Fruit')==1 & strcmp(unit_index.SensoryConf,'Sensory')==1);
    [bardata(5,1),bardata(5,2)]=mean_sem(unitdata.cat_si(pointer,2));
    hold on; 
    bar(1:5,bardata(:,1))
    errorbar(1:5,bardata(:,1),bardata(:,2))
    ylabel('% Category Selectivity (si)','FontSize',fontsize_med)
    set(gca,'XTickLabel',{'Faces','Bodyparts','Objects','Place','Fruit'},'XTick',1:5)
    %bar(histc(xldata.face_si(pointer),0:0.05:1))
    title([monkeyname,' - Average Selectivity (RSVP500 Dataset with Fruit)'],'FontSize',fontsize_lrg)
    
    subplot(2,2,4); bardata=[];
    pointer=find(strcmp(unit_index.CategoryConf,'Faces')==1 & strcmp(unit_index.SensoryConf,'Sensory')==1);
    [bardata(1,1),bardata(1,2)]=mean_sem(unitdata.cat_si_nofruit(pointer,1));
    pointer=find(strcmp(unit_index.CategoryConf,'BodyParts')==1 & strcmp(unit_index.SensoryConf,'Sensory')==1);
    [bardata(2,1),bardata(2,2)]=mean_sem(unitdata.cat_si_nofruit(pointer,3));
    pointer=find(strcmp(unit_index.CategoryConf,'Objects')==1 & strcmp(unit_index.SensoryConf,'Sensory')==1);
    [bardata(3,1),bardata(3,2)]=mean_sem(unitdata.cat_si_nofruit(pointer,4));
    pointer=find(strcmp(unit_index.CategoryConf,'Places')==1 & strcmp(unit_index.SensoryConf,'Sensory')==1);
    [bardata(4,1),bardata(4,2)]=mean_sem(unitdata.cat_si_nofruit(pointer,2));
    hold on; 
    bar(1:4,bardata(:,1))
    errorbar(1:4,bardata(:,1),bardata(:,2))
    ylabel('% Category Selectivity (si)','FontSize',fontsize_med)
    set(gca,'XTickLabel',{'Faces','Bodyparts','Objects','Place'},'XTick',1:4)
    %bar(histc(xldata.face_si(pointer),0:0.05:1))
    title([monkeyname,' - Average Selectivity (RSVP500 Dataset without Fruit)'],'FontSize',fontsize_lrg)
    clear unitdata unit_index 
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig0.2_AnovaEffects_SI_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig0.2_AnovaEffects_SI_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure   
        
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 0 - Summary Statistics %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 1 - Effect of Facial Expression and Gaze Direction on Face Responses (spden)%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==1,1))==0,
    disp('Figure 1.1 - Effect of Facial Expression on Face Responses')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    fepointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
    fepointerNS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05);
    
    [avgfunc semfunc]=f570_avg_spden(xldata,fepointerS,hmiconfig,xrange,monkeyname);
    subplot(4,4,1); hold on % sig, raw, fe
    plx_shade_spden(xrange(1):xrange(2),avgfunc(17,:),semfunc(17,:),0.25,'k') % neutral directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(18,:),semfunc(18,:),0.25,'r') % threat directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(19,:),semfunc(19,:),0.25,'b') % fear grin directed
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
    title({'Facial Expression (F-Resp Neurons, grouped across Direction)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,2); hold on % sig, norm, fe
    plx_shade_spden(xrange(1):xrange(2),avgfunc(22,:),semfunc(22,:),0.25,'k') % neutral directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(23,:),semfunc(23,:),0.25,'r') % threat directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(24,:),semfunc(24,:),0.25,'b') % fear grin directed
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
    title({'Facial Expression (F-Resp Neurons grouped across Direction)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,3); hold on % sig, raw, fe
    plx_shade_spden(xrange(1):xrange(2),avgfunc(1,:),semfunc(1,:),0.25,'k') % neutral directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(3,:),semfunc(3,:),0.25,'r') % threat directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(4,:),semfunc(5,:),0.25,'b') % fear grin directed
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
    title({'Facial Expression (F-Resp Neurons, Direct Only)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,4); hold on % sig, norm, fe
    plx_shade_spden(xrange(1):xrange(2),avgfunc(9,:),semfunc(9,:),0.25,'k') % neutral directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(11,:),semfunc(11,:),0.25,'r') % threat directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(13,:),semfunc(13,:),0.25,'b') % fear grin directed
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
    title({'Facial Expression (F-Resp Neurons, Direct Only)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
    legend('N','','T','','Fg','')
    
    [avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange,monkeyname); %#ok
    subplot(4,4,5); hold on % non sig, raw, fe
    [avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange,monkeyname);
    plx_shade_spden(xrange(1):xrange(2),avgfunc(17,:),semfunc(17,:),0.25,'k') % neutral directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(18,:),semfunc(18,:),0.25,'r') % threat directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(19,:),semfunc(19,:),0.25,'b') % fear grin directed
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
    title({'Facial Expression (F-Resp Neurons)',['NS Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,6); hold on % non sig, norm, fe
    plx_shade_spden(xrange(1):xrange(2),avgfunc(22,:),semfunc(22,:),0.25,'k') % neutral directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(23,:),semfunc(23,:),0.25,'r') % threat directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(24,:),semfunc(24,:),0.25,'b') % fear grin directed
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
    title({'Facial Expression (F-Resp Neurons)',['NS Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,7); hold on % non sig, raw, fe
    plx_shade_spden(xrange(1):xrange(2),avgfunc(1,:),semfunc(1,:),0.25,'k') % neutral directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(3,:),semfunc(3,:),0.25,'r') % threat directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(4,:),semfunc(5,:),0.25,'b') % fear grin directed
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
    title({'Facial Expression (F-Resp Neurons, Direct Only)',['NS Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,8); hold on % non sig, norm, fe
    plx_shade_spden(xrange(1):xrange(2),avgfunc(9,:),semfunc(9,:),0.25,'k') % neutral directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(11,:),semfunc(11,:),0.25,'r') % threat directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(13,:),semfunc(13,:),0.25,'b') % fear grin directed
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
    title({'Facial Expression (F-Resp Neurons, Direct Only)',['NS Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
       
    % responses collapsed across gaze direction
    subplot(4,5,11) 
    bardataS=xldata.expr_rsp_avg(fepointerS,:);
    bardataNS=xldata.expr_rsp_avg(fepointerNS,:);
    [~,ind]=max(bardataS(:,1:3),[],2); clear val piedata %#ok
    piedata(1)=length(find(ind==1));
    piedata(2)=length(find(ind==2));
    piedata(3)=length(find(ind==3));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Face Resp - Max Facial Expression',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    legend('Neutral','Threat','FearGrin'); set(gca,'FontSize',fontsize_sml)
   
    subplot(4,5,[12 13]); hold on % average responses collapsed across gaze direction
    bar(1:6,[mean(bardataS,1) mean(bardataNS,1)]);
    errorbar(1:6,[mean(bardataS,1) mean(bardataNS,1)],[sem(bardataS) sem(bardataNS)]);
    ylabel('Average Response (sp/s)','FontSize',fontsize_med); ylim([0 20])
    set(gca,'XTickLabel',{'N-s','T-s','FG-s','N-ns','T-ns','FG-ns'},'FontSize',fontsize_sml,'XTick',1:6);
    title('Face Resp (sig effect of FE)','FontSize',10)
    [p,~]=ranksum(bardataS(:,1),bardataS(:,2)); %#ok
    text(1.5,mean(bardataS(:,1))+sem(bardataS(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataS(:,2),bardataS(:,3)); %#ok
    text(2.5,mean(bardataS(:,3))+sem(bardataS(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataS(:,1),bardataS(:,3)); %#ok
    text(2,mean(bardataS(:,2))+sem(bardataS(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,1),bardataNS(:,2)); %#ok
    text(4.5,mean(bardataNS(:,1))+sem(bardataNS(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,2),bardataNS(:,3)); %#ok
    text(5.5,mean(bardataNS(:,3))+sem(bardataNS(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,1),bardataNS(:,3)); %#ok
    text(5,mean(bardataNS(:,2))+sem(bardataNS(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    
    subplot(4,5,[14 15]); hold on % expression - normalized (to neutral)
    bardataS(:,4)=bardataS(:,1)./bardataS(:,1);
    bardataS(:,5)=bardataS(:,2)./bardataS(:,1);
    bardataS(:,6)=bardataS(:,3)./bardataS(:,1);
    bardataNS(:,4)=bardataNS(:,1)./bardataNS(:,1);
    bardataNS(:,5)=bardataNS(:,2)./bardataNS(:,1);
    bardataNS(:,6)=bardataNS(:,3)./bardataNS(:,1); 
    bar(1:6,[mean(bardataS(:,4:6),1) mean(bardataNS(:,4:6),1)]);
    errorbar(1:6,[mean(bardataS(:,4:6),1) mean(bardataNS(:,4:6),1)],[sem(bardataS(:,4:6)) sem(bardataNS(:,4:6))]);
    ylabel('Average Response (sp/s)','FontSize',fontsize_med); ylim([0.6 1.4])
    set(gca,'XTickLabel',{'N-s','T-s','FG-s','N-ns','T-ns','FG-ns'},'FontSize',fontsize_sml,'XTick',1:6);
    title('Face Resp (Normalized)','FontSize',10)
    [p,~]=ranksum(bardataS(:,4),bardataS(:,5)); %#ok
    text(1.5,mean(bardataS(:,4))+sem(bardataS(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataS(:,5),bardataS(:,6)); %#ok
    text(2.5,mean(bardataS(:,6))+sem(bardataS(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataS(:,4),bardataS(:,6)); %#ok
    text(2,mean(bardataS(:,5))+sem(bardataS(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,4),bardataNS(:,5)); %#ok
    text(4.5,mean(bardataNS(:,4))+sem(bardataNS(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,5),bardataNS(:,6)); %#ok
    text(5.5,mean(bardataNS(:,6))+sem(bardataNS(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,4),bardataNS(:,6)); %#ok
    text(5,mean(bardataNS(:,5))+sem(bardataNS(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    
    % responses for direct gaze only
    subplot(4,5,16) % average responses collapsed across gaze direction
    bardataS=xldata.avg_rsp(fepointerS,[1 3 5]);
    bardataNS=xldata.avg_rsp(fepointerNS,[1 3 5]);
    [~,ind]=max(bardataS(:,1:3),[],2); clear piedata
    piedata(1)=length(find(ind==1));
    piedata(2)=length(find(ind==2));
    piedata(3)=length(find(ind==3));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Face Resp - Max Facial Expression (direct gaze only)',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    legend('Neutral','Threat','FearGrin'); set(gca,'FontSize',fontsize_sml)
   
    subplot(4,5,[17 18]); hold on % average responses collapsed across gaze direction
    bar(1:6,[mean(bardataS,1) mean(bardataNS,1)]);
    errorbar(1:6,[mean(bardataS,1) mean(bardataNS,1)],[sem(bardataS) sem(bardataNS)]);
    ylabel('Average Response (sp/s)','FontSize',fontsize_med); ylim([0 20])
    set(gca,'XTickLabel',{'N-s','T-s','FG-s','N-ns','T-ns','FG-ns'},'FontSize',fontsize_sml,'XTick',1:6);
    title('Face Resp (sig effect of FE)','FontSize',10)
    [p,~]=ranksum(bardataS(:,1),bardataS(:,2));
    text(1.5,mean(bardataS(:,1))+sem(bardataS(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataS(:,2),bardataS(:,3));
    text(2.5,mean(bardataS(:,3))+sem(bardataS(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataS(:,1),bardataS(:,3));
    text(2,mean(bardataS(:,2))+sem(bardataS(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,1),bardataNS(:,2));
    text(4.5,mean(bardataNS(:,1))+sem(bardataNS(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,2),bardataNS(:,3));
    text(5.5,mean(bardataNS(:,3))+sem(bardataNS(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,1),bardataNS(:,3));
    text(5,mean(bardataNS(:,2))+sem(bardataNS(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    
    subplot(4,5,[19 20]); hold on % expression - normalized (to neutral)
    bardataS(:,4)=bardataS(:,1)./bardataS(:,1);
    bardataS(:,5)=bardataS(:,2)./bardataS(:,1);
    bardataS(:,6)=bardataS(:,3)./bardataS(:,1);
    bardataNS(:,4)=bardataNS(:,1)./bardataNS(:,1);
    bardataNS(:,5)=bardataNS(:,2)./bardataNS(:,1);
    bardataNS(:,6)=bardataNS(:,3)./bardataNS(:,1); 
    bar(1:6,[mean(bardataS(:,4:6),1) mean(bardataNS(:,4:6),1)]);
    errorbar(1:6,[mean(bardataS(:,4:6),1) mean(bardataNS(:,4:6),1)],[sem(bardataS(:,4:6)) sem(bardataNS(:,4:6))]);
    ylabel('Average Response (sp/s)','FontSize',fontsize_med); ylim([0.6 1.4])
    set(gca,'XTickLabel',{'N-s','T-s','FG-s','N-ns','T-ns','FG-ns'},'FontSize',fontsize_sml,'XTick',1:6);
    title('Face Resp (Normalized)(direct gaze only)','FontSize',10)
    [p,~]=ranksum(bardataS(:,4),bardataS(:,5));
    text(1.5,mean(bardataS(:,4))+sem(bardataS(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataS(:,5),bardataS(:,6));
    text(2.5,mean(bardataS(:,6))+sem(bardataS(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataS(:,4),bardataS(:,6));
    text(2,mean(bardataS(:,5))+sem(bardataS(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,4),bardataNS(:,5));
    text(4.5,mean(bardataNS(:,4))+sem(bardataNS(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,5),bardataNS(:,6));
    text(5.5,mean(bardataNS(:,6))+sem(bardataNS(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,4),bardataNS(:,6));
    text(5,mean(bardataNS(:,5))+sem(bardataNS(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig1.1_FacialExpression_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig1.1_FacialExpression_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Question 1.2 - Effect of Gaze Direction on Face Responses %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 1.2 - Effect of Gaze Direction on Face Responses')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    gdpointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
    gdpointerNS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05);
    
    [avgfunc semfunc]=f570_avg_spden(xldata,gdpointerS,hmiconfig,xrange,monkeyname);
    subplot(4,4,1); hold on % sig, raw, gd
    plx_shade_spden(xrange(1):xrange(2),avgfunc(20,:),semfunc(20,:),0.25,'k') % directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(21,:),semfunc(21,:),0.25,'b') % averted
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
    title({'Gaze Direction (F-Resp Neurons, grouped across Expression)',['Sig Neurons (n=',num2str(length(gdpointerS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,2); hold on % sig, norm, gd
    plx_shade_spden(xrange(1):xrange(2),avgfunc(25,:),semfunc(25,:),0.25,'k') % directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(26,:),semfunc(26,:),0.25,'b') % averted
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1.25]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
    title({'Gaze Direction (F-Resp Neurons, grouped across Expression)',['Sig Neurons (n=',num2str(length(gdpointerS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,3); hold on % sig, raw, gd
    plx_shade_spden(xrange(1):xrange(2),avgfunc(1,:),semfunc(1,:),0.25,'k') % directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(2,:),semfunc(2,:),0.25,'b') % averted
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
    title({'Gaze Direction (F-Resp Neurons, Neutral Only)',['Sig Neurons (n=',num2str(length(gdpointerS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,4); hold on % sig, norm, gd
    plx_shade_spden(xrange(1):xrange(2),avgfunc(9,:),semfunc(9,:),0.25,'k') % directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(10,:),semfunc(10,:),0.25,'b') % averted
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1.25]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
    title({'Gaze Direction (F-Resp Neurons, Neutral Only)',['Sig Neurons (n=',num2str(length(gdpointerS)),')']},'FontSize',fontsize_lrg)
    legend('D','','A','')
    
    [avgfunc semfunc]=f570_avg_spden(xldata,gdpointerNS,hmiconfig,xrange,monkeyname);
    subplot(4,4,5); hold on
    plx_shade_spden(xrange(1):xrange(2),avgfunc(20,:),semfunc(20,:),0.25,'k') % directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(21,:),semfunc(21,:),0.25,'b') % averted
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
    title({'Gaze Direction (F-Resp Neurons)',['NS Neurons (n=',num2str(length(gdpointerNS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,6); hold on % sig, norm, gd
    plx_shade_spden(xrange(1):xrange(2),avgfunc(25,:),semfunc(25,:),0.25,'k') % directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(26,:),semfunc(26,:),0.25,'b') % averted
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1.25]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
    title({'Gaze Direction (F-Resp Neurons)',['NS Neurons (n=',num2str(length(gdpointerNS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,7); hold on % sig, raw, gd
    plx_shade_spden(xrange(1):xrange(2),avgfunc(1,:),semfunc(1,:),0.25,'k') % directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(2,:),semfunc(2,:),0.25,'b') % averted
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
    title({'Gaze Direction (F-Resp Neurons, Neutral Only)',['NS Neurons (n=',num2str(length(gdpointerS)),')']},'FontSize',fontsize_lrg)
    subplot(4,4,8); hold on % sig, norm, gd
    plx_shade_spden(xrange(1):xrange(2),avgfunc(9,:),semfunc(9,:),0.25,'k') % directed
    plx_shade_spden(xrange(1):xrange(2),avgfunc(10,:),semfunc(10,:),0.25,'b') % averted
    set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1.25]); xlim([-100 400]);
    xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
    title({'Gaze Direction (F-Resp Neurons, Neutral Only)',['NS Neurons (n=',num2str(length(gdpointerS)),')']},'FontSize',fontsize_lrg)
    legend('D','','A','')
    
    % responses collapsed across facial expression
    subplot(4,5,11) 
    bardataS=xldata.gaze_rsp_avg(gdpointerS,:);
    bardataNS=xldata.gaze_rsp_avg(gdpointerNS,:);
    [~,ind]=max(bardataS(:,1:2),[],2); clear piedata val
    piedata(1)=length(find(ind==1));
    piedata(2)=length(find(ind==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Face Resp - Max Gaze Direction',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    legend('Directed','Averted'); set(gca,'FontSize',fontsize_sml)
   
    subplot(4,5,[12 13]); hold on % average responses collapsed across gaze direction
    bar(1:4,[mean(bardataS,1) mean(bardataNS,1)]);
    errorbar(1:4,[mean(bardataS,1) mean(bardataNS,1)],[sem(bardataS) sem(bardataNS)]);
    ylabel('Average Response (sp/s)','FontSize',fontsize_med); ylim([0 20])
    set(gca,'XTickLabel',{'D-s','A-s','D-ns','A-ns'},'FontSize',fontsize_sml,'XTick',1:4);
    title('Face Resp (sig effect of FE)','FontSize',10)
    [p,~]=ranksum(bardataS(:,1),bardataS(:,2));
    text(1.5,mean(bardataS(:,1))+sem(bardataS(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,1),bardataNS(:,2));
    text(3.5,mean(bardataNS(:,1))+sem(bardataNS(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    
    subplot(4,5,[14 15]); hold on % expression - normalized (to neutral)
    bardataS(:,3)=bardataS(:,1)./bardataS(:,1);
    bardataS(:,4)=bardataS(:,2)./bardataS(:,1);
    bardataNS(:,3)=bardataNS(:,1)./bardataNS(:,1);
    bardataNS(:,4)=bardataNS(:,2)./bardataNS(:,1);
    bar(1:4,[mean(bardataS(:,3:4),1) mean(bardataNS(:,3:4),1)]);
    errorbar(1:4,[mean(bardataS(:,3:4),1) mean(bardataNS(:,3:4),1)],[sem(bardataS(:,3:4)) sem(bardataNS(:,3:4))]);
    ylabel('Average Response (sp/s)','FontSize',fontsize_med); ylim([0.6 1.4])
    set(gca,'XTickLabel',{'D-s','A-s','D-ns','A-ns'},'FontSize',fontsize_sml,'XTick',1:4);
    title('Face Resp (Normalized)','FontSize',10)
    [p,~]=ranksum(bardataS(:,3),bardataS(:,4));
    text(1.5,mean(bardataS(:,3))+sem(bardataS(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,3),bardataNS(:,4));
    text(3.5,mean(bardataNS(:,3))+sem(bardataNS(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    
    % responses for neutral expression only
    subplot(4,5,16) 
    bardataS=xldata.avg_rsp(gdpointerS,[1 2]);
    bardataNS=xldata.avg_rsp(gdpointerNS,[1 2]);
    [~,ind]=max(bardataS(:,1:2),[],2); clear piedata val
    piedata(1)=length(find(ind==1));
    piedata(2)=length(find(ind==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Face Resp - Max Gaze Direction (Neutral Only)',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    legend('Directed','Averted'); set(gca,'FontSize',fontsize_sml)
 
    subplot(4,5,[17 18]); hold on % average responses collapsed across gaze direction
    bar(1:4,[mean(bardataS,1) mean(bardataNS,1)]);
    errorbar(1:4,[mean(bardataS,1) mean(bardataNS,1)],[sem(bardataS) sem(bardataNS)]);
    ylabel('Average Response (sp/s)','FontSize',fontsize_med); ylim([0 20])
    set(gca,'XTickLabel',{'D-s','A-s','D-ns','A-ns'},'FontSize',fontsize_sml,'XTick',1:4);
    title('Face Resp (sig effect of GD, Neutral Only)','FontSize',10)
    [p,~]=ranksum(bardataS(:,1),bardataS(:,2));
    text(1,mean(bardataS(:,1))+sem(bardataS(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,1),bardataNS(:,2));
    text(3,mean(bardataNS(:,1))+sem(bardataNS(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    
    subplot(4,5,[19 20]); hold on % expression - normalized (to neutral)
    bardataS(:,3)=bardataS(:,1)./bardataS(:,1);
    bardataS(:,4)=bardataS(:,2)./bardataS(:,1);
    bardataNS(:,3)=bardataNS(:,1)./bardataNS(:,1);
    bardataNS(:,4)=bardataNS(:,2)./bardataNS(:,1);
    bar(1:4,[mean(bardataS(:,3:4),1) mean(bardataNS(:,3:4),1)]);
    errorbar(1:4,[mean(bardataS(:,3:4),1) mean(bardataNS(:,3:4),1)],[sem(bardataS(:,3:4)) sem(bardataNS(:,3:4))]);
    ylabel('Average Response (sp/s)','FontSize',fontsize_med); ylim([0.6 1.4])
    set(gca,'XTickLabel',{'D-s','A-s','D-ns','A-ns'},'FontSize',fontsize_sml,'XTick',1:4);
    title('Face Resp (Normalized, Neutral Only)','FontSize',10)
    [p,~]=ttest2(bardataS(:,3),bardataS(:,4));
    text(1,mean(bardataS(:,3))+sem(bardataS(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=ranksum(bardataNS(:,3),bardataNS(:,4));
    text(3,mean(bardataNS(:,3))+sem(bardataNS(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig1.2_GazeDirection_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig1.2_GazeDirection_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2 - Effect of Facial Expression, Gaze Direction, Identity on Face Responses %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==2,1))==0,
    disp('Figure 2.1 - Effect of Gaze Direction on Face Responses')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.5 0.8]); set(gca,'FontName','Arial','FontSize',10);
    fepointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
    fepointerNS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05);
    subplot(3,3,1); clear piedata % single/average example
    piedata(1)=length(fepointerS);
    piedata(2)=length(fepointerNS);
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Face Resp - Max Facial Expression',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    legend('Sig','Non-Sig'); set(gca,'FontSize',fontsize_sml)
    
    subplot(3,3,2); clear piedata
    bardataS=xldata.expr_rsp_avg(fepointerS,:);
    [~,ind]=max(bardataS(:,1:3),[],2); clear piedata
    piedata(1)=length(find(ind==1));
    piedata(2)=length(find(ind==2));
    piedata(3)=length(find(ind==3));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Maximum Response (averaged across direction)',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    legend('Neutral','Threat','FearGrin'); set(gca,'FontSize',fontsize_sml)
    
    subplot(3,3,3); clear si % histogram
    si(:,1)=histc(abs(xldata.expr_si(fepointerS,4)),0:0.05:0.5); % currently using MAX response
    si(:,2)=histc(abs(xldata.expr_si(fepointerNS,4)),0:0.05:0.5); % currently using MAX response
    bar(0:0.05:0.5,si,'stacked'); axis square
    xlim([0 0.5]); xlabel('|SI|','FontSize',fontsize_med)
    ylabel('# Neurons')
    title('Selectivity Index - Facial Expression','FontSize',fontsize_lrg)
    text(0.3,30,['mean: ',num2str(mean(abs(xldata.expr_si([fepointerS;fepointerNS])))),' +/-',num2str(sem(abs(xldata.expr_si([fepointerS;fepointerNS]))))],'FontSize',fontsize_med)
    text(0.3,50,['mean: ',num2str(mean(abs(xldata.expr_si(fepointerS)))),' +/-',num2str(sem(abs(xldata.expr_si(fepointerS))))],'FontSize',fontsize_med)
    clear fepointerS fepointerNS si
    
    gdpointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
    gdpointerNS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05);
    subplot(3,3,4); clear piedata % single/average example
    piedata(1)=length(gdpointerS);
    piedata(2)=length(gdpointerNS);
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Face Resp - Max Gaze Direction',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    legend('Sig','Non-Sig'); set(gca,'FontSize',fontsize_sml)
    
    subplot(3,3,5); clear piedata
    bardataS=xldata.gaze_rsp_avg(gdpointerS,:);
    [~,ind]=max(bardataS(:,1:2),[],2); clear piedata
    piedata(1)=length(find(ind==1));
    piedata(2)=length(find(ind==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Maximum Response (averaged across expression)',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    legend('Directed','Averted'); set(gca,'FontSize',fontsize_sml)
    
    subplot(3,3,6); clear si % histogram
    si(:,1)=histc(abs(xldata.gaze_si(gdpointerS)),0:0.05:0.5); % currently using MAX response
    si(:,2)=histc(abs(xldata.gaze_si(gdpointerNS)),0:0.05:0.5); % currently using MAX response
    bar(0:0.05:0.5,si,'stacked'); axis square
    xlim([0 0.5]); xlabel('|SI|','FontSize',fontsize_med)
    ylabel('# Neurons')
    title('Selectivity Index - Gaze Direction','FontSize',fontsize_lrg)
    text(0.3,30,['mean: ',num2str(mean(abs(xldata.gaze_si([gdpointerS;gdpointerNS])))),' +/-',num2str(sem(abs(xldata.gaze_si([gdpointerS;gdpointerNS]))))],'FontSize',fontsize_med)
    text(0.3,50,['mean: ',num2str(mean(abs(xldata.gaze_si(gdpointerS)))),' +/-',num2str(sem(abs(xldata.gaze_si(gdpointerS))))],'FontSize',fontsize_med)
    clear gdpointerS gdpointerNS si
    
    idpointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05);
    idpointerNS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05);
    subplot(3,3,7); clear piedata % single/average example
    piedata(1)=length(idpointerS);
    piedata(2)=length(idpointerNS);
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Face Resp - Max Gaze Direction',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    legend('Sig','Non-Sig'); set(gca,'FontSize',fontsize_sml)
        
    subplot(3,3,9); clear si % histogram
    si(:,1)=histc(abs(xldata.id_si(idpointerS)),0:0.05:0.5); % currently using MAX response
    si(:,2)=histc(abs(xldata.id_si(idpointerNS)),0:0.05:0.5); % currently using MAX response
    bar(0:0.05:0.5,si,'stacked'); axis square
    xlim([0 0.5]); xlabel('|SI|','FontSize',fontsize_med)
    ylabel('# Neurons')
    title('Selectivity Index - Identity','FontSize',fontsize_lrg)
    text(0.3,30,['mean: ',num2str(mean(abs(xldata.id_si([idpointerS;idpointerNS])))),' +/-',num2str(sem(abs(xldata.id_si([idpointerS;idpointerNS]))))],'FontSize',fontsize_med)
    text(0.3,50,['mean: ',num2str(mean(abs(xldata.id_si(idpointerS)))),' +/-',num2str(sem(abs(xldata.id_si(idpointerS))))],'FontSize',fontsize_med)
    clear idpointerS idpointerNS si
    
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig1.2_GazeDirection_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig1.2_GazeDirection_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
end

    
%%%UNFINISHED !!!! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3 - Effect of Identity/Gender on Face Responses %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==3,1))==0,
    disp('Figure 3.1 - Effect of Identity on Face Responses')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    subplot(2,2,1);
    clear piedata
    piedata(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
    piedata(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Identity Selectivity Among Face-Responsive Neurons',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    set(gca,'FontSize',fontsize_sml); legend('Sig','NonSig');
    subplot(2,2,2);
    clear piedata
    piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
    piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Identity Selectivity Among Face-Preferring Neurons',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    set(gca,'FontSize',fontsize_sml); legend('Sig','NonSig');
    subplot(2,1,2);            
    idpointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05);
    [~, output_mean]=f570_extractMonkID(xldata,idpointerS,hmiconfig);
    males=output_mean(:,:,1:2); % average of two middle aged males
    females=output_mean(:,:,3:4); % average of two middle aged females
    bardata=zeros(6,2); bardata2=zeros(6,2);
    for x=1:6,
        bardata(x,1)=mean(mean(squeeze(males(:,x,:))));
        bardata(x,2)=mean(mean(squeeze(females(:,x,:))));
        bardata2(x,1)=mean(sem(squeeze(males(:,x,:))));
        bardata2(x,2)=mean(sem(squeeze(females(:,x,:))));
    end    
    bar(1:6,bardata,'grouped')
    ylabel('Average Response (sp/s)','FontSize',fontsize_med); ylim([0 20])
    legend('Male','Female')
    set(gca,'XTickLabel',{'ND','NA','TD','TA','FD','FA'},'FontSize',fontsize_sml,'XTick',1:6);
    title('Effect of Gender','FontSize',fontsize_lrg)
   
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig1.3_Identity_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig1.3_Identity_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 4 - Intersecting vs. Independent Pathways %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==4,1))==0,
    disp('Figure 4.1 - Intersecting vs. Independent Pathways')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.5 0.5]); set(gca,'FontName','Arial','FontSize',fontsize_med);
    clear vn
    vn(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'>=0.05));
    vn(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
    vn(3)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
    vn(4)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
    vn(5)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
    vn(6)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
    vn(7)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
    subplot(2,2,1)
    [~,S]=venn(vn);
    for i = 1:7, text(S.ZoneCentroid(i,1), S.ZoneCentroid(i,2), num2str(vn(i))); end
    axis square; axis off
    legend('fe','id','ge'); set(gca,'FontSize',fontsize_sml)
    title({[monkeyname,' - Neuron Distribution (n=',num2str(length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1))),')'],...
        ['(sig n=',num2str(sum(vn)),')']},'FontSize',fontsize_lrg)
    subplot(2,2,2); clear vn
    vn(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_gd'>=0.05));
    vn(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_gd'<0.05));
    vn(3)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_gd'<0.05));
    vn(4)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_gd'>=0.05));
    [~,S]=venn(vn(1:2),vn(3));
    for i = 1:3, text(S.ZoneCentroid(i,1), S.ZoneCentroid(i,2), num2str(vn(i))); end
    axis square; axis off
    title({[monkeyname,' - Neuron Distribution (n=',num2str(length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1))),')'],...
        ['(sig n=',num2str(sum(vn(1:3))),')']},'FontSize',fontsize_lrg)
    legend('fe','gd'); set(gca,'FontSize',fontsize_sml)

    subplot(2,2,3); % sensitivity to facial expression
    clear piedata
    piedata(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_fe_gd(:,3)>=0.05 & xldata.anova_fe_id(:,3)>=0.05)); % not responsive
    piedata(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_fe_gd(:,3)>=0.05 & xldata.anova_fe_id(:,3)>=0.05)); % FE only
    piedata(3)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_fe_gd(:,3)<0.05 & xldata.anova_fe_id(:,3)>=0.05)); % FE+GD
    piedata(4)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_fe_gd(:,3)>=0.05 & xldata.anova_fe_id(:,3)<0.05)); % FE+ID
    piedata(5)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_fe_gd(:,3)<0.05 & xldata.anova_fe_id(:,3)<0.05)); % FE+ID+GD
    piedata(6)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_fe_gd(:,3)<0.05 & xldata.anova_fe_id(:,3)>=0.05)); % FE+GD only
    piedata(7)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_fe_gd(:,3)<0.05 & xldata.anova_fe_id(:,3)<0.05)); % FE+ID only
    piedata(8)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_fe_gd(:,3)<0.05 & xldata.anova_fe_id(:,3)<0.05)); % FE+GD/FE+ID only
    
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(5)),'(',num2str(piedata(5)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(6)),'(',num2str(piedata(6)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(7)),'(',num2str(piedata(7)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(8)),'(',num2str(piedata(8)/sum(piedata)*100,'%1.2g'),'%)']});
    title({'Interaction between FE among Face-Responsive Neurons',['(n=',num2str(sum(piedata(2:5))),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    set(gca,'FontSize',fontsize_sml); legend('Non','FE','FE+FE/GD','FE+FE/ID','FE+FE/GD+FE/ID','FE+GDonly','FE+IDonly','FE+ID/FE+GDonly');
    
    subplot(2,2,4); % sensitivity to facial expression
    clear piedata
    piedata(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05 & xldata.anova_fe_gd(:,3)>=0.05 & xldata.anova_id_gd(:,3)>=0.05)); % not responsive
    piedata(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05 & xldata.anova_fe_gd(:,3)>=0.05 & xldata.anova_id_gd(:,3)>=0.05)); % GD only
    piedata(3)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05 & xldata.anova_fe_gd(:,3)<0.05 & xldata.anova_id_gd(:,3)>=0.05)); % FE+GD
    piedata(4)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05 & xldata.anova_fe_gd(:,3)>=0.05 & xldata.anova_id_gd(:,3)<0.05)); % GD+ID
    piedata(5)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05 & xldata.anova_fe_gd(:,3)<0.05 & xldata.anova_id_gd(:,3)<0.05)); % FE+ID+GD
    piedata(6)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05 & xldata.anova_fe_gd(:,3)<0.05 & xldata.anova_id_gd(:,3)>=0.05)); % FE+GD only
    piedata(7)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05 & xldata.anova_fe_gd(:,3)<0.05 & xldata.anova_id_gd(:,3)<0.05)); % FE+ID only
    piedata(8)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05 & xldata.anova_fe_gd(:,3)<0.05 & xldata.anova_id_gd(:,3)<0.05)); % FE+GD/F    
    
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(5)),'(',num2str(piedata(5)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(6)),'(',num2str(piedata(6)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(7)),'(',num2str(piedata(7)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(8)),'(',num2str(piedata(8)/sum(piedata)*100,'%1.2g'),'%)']});
    title({'Interaction between GD Among Face-Responsive Neurons',['(n=',num2str(sum(piedata(2:5))),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    set(gca,'FontSize',fontsize_sml); legend('Non','GD','GD+GD/FE','GD+GD/ID','GD+GD/FE+GD/ID','FE+GDonly','FE+IDonly','FE+ID/FE+GDonly');
    
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig4.1_IndependentPaths_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig4.1_IndependentPaths_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 5 - Repetition Suppression/Adaptation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==5,1))==0,
    disp('Figure 5.1 - Repetition Suppression/Adaptation to Social Stimuli')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    % Analysis No.1A - Adaptation to all different categories of stimuli for different neuronal populations
    % This will examine RS to individual stimuli, grouped according to category
    
    subplot(4,3,1); hold on; rep_range=1:5;
    pointerFS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1); % face-selective
    pointerBS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Bodyparts')==1); % bodypart-selective
    pointerOS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Objects')==1); % objet-selective
    [bardata1,fa_pref_adapt]=f570_AdaptPop(xldata,pointerFS,'trial_id11','trial_id5',1); % select only face responses
    [bardata2,bp_pref_adapt]=f570_AdaptPop(xldata,pointerBS,'trial_id11','trial_id5',2); % select only bp responses
    [bardata3,ob_pref_adapt]=f570_AdaptPop(xldata,pointerOS,'trial_id11','trial_id5',3); % select on object responses
    plot(rep_range,bardata1(rep_range,1),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,1),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,1),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,1),bardata1(rep_range,2),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,1),bardata2(rep_range,2),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,1),bardata3(rep_range,2),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons - Absolute Firing Rate'},'FontSize',12,'FontWeight','Bold'); %
    
    subplot(4,3,2); hold on;
    plot(rep_range,bardata1(rep_range,4),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,4),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,4),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,4),bardata1(rep_range,5),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,4),bardata2(rep_range,5),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,4),bardata3(rep_range,5),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons - Normalised Firing Rate'},'FontSize',12,'FontWeight','Bold'); %
    
    subplot(4,3,3); hold on;
    plot(rep_range,bardata1(rep_range,6),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,6),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,6),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,6),bardata1(rep_range,7),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,6),bardata2(rep_range,7),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,6),bardata3(rep_range,7),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('RS Index','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons - RS Index'},'FontSize',12,'FontWeight','Bold'); %
    
    subplot(4,3,4); hold on;
    plot(rep_range,bardata1(rep_range,9),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,9),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,9),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,9),bardata1(rep_range,10),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,9),bardata2(rep_range,10),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,9),bardata3(rep_range,10),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons (noB) - Absolute Firing Rate'},'FontSize',12,'FontWeight','Bold'); %
    
    subplot(4,3,5); hold on;
    plot(rep_range,bardata1(rep_range,12),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,12),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,12),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,12),bardata1(rep_range,13),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,12),bardata2(rep_range,13),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,12),bardata3(rep_range,13),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons (noB) - Normalised Firing Rate'},'FontSize',12,'FontWeight','Bold'); %
    
    subplot(4,3,6); hold on;
    plot(rep_range,bardata1(rep_range,14),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,14),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,14),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,14),bardata1(rep_range,15),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,14),bardata2(rep_range,15),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,14),bardata3(rep_range,15),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('RS Index','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons (noB) - RS Index'},'FontSize',12,'FontWeight','Bold'); %
    
    % Analysis No.1B - Adaptation to all different categories of stimuli for different neuronal populations (ALL-RESPONSIVE NEURONS)
    % This will examine RS to individual stimuli, grouped according to category
    
    subplot(4,3,7); hold on; rep_range=1:5;
    pointerFS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05); % face-selective
    pointerBS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validbodyp<0.05); % bodypart-selective
    pointerOS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validobject<0.05); % objet-selective
    [bardata1,fa_all_adapt]=f570_AdaptPop(xldata,pointerFS,'trial_id11','trial_id5',1); % select only face responses
    [bardata2,bp_all_adapt]=f570_AdaptPop(xldata,pointerBS,'trial_id11','trial_id5',2); % select only bp responses
    [bardata3,ob_all_adapt]=f570_AdaptPop(xldata,pointerOS,'trial_id11','trial_id5',3); % select on object responses
    plot(rep_range,bardata1(rep_range,1),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,1),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,1),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,1),bardata1(rep_range,2),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,1),bardata2(rep_range,2),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,1),bardata3(rep_range,2),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons - Absolute Firing Rate'},'FontSize',12,'FontWeight','Bold'); %
    
    subplot(4,3,8); hold on;
    plot(rep_range,bardata1(rep_range,4),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,4),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,4),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,4),bardata1(rep_range,5),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,4),bardata2(rep_range,5),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,4),bardata3(rep_range,5),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons - Normalised Firing Rate'},'FontSize',12,'FontWeight','Bold'); %
    
    subplot(4,3,9); hold on;
    plot(rep_range,bardata1(rep_range,6),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,6),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,6),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,6),bardata1(rep_range,7),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,6),bardata2(rep_range,7),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,6),bardata3(rep_range,7),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('RS Index','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons - RS Index'},'FontSize',12,'FontWeight','Bold'); %
    
    subplot(4,3,10); hold on;
    plot(rep_range,bardata1(rep_range,9),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,9),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,9),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,9),bardata1(rep_range,10),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,9),bardata2(rep_range,10),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,9),bardata3(rep_range,10),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons (noB) - Absolute Firing Rate'},'FontSize',12,'FontWeight','Bold'); %
    
    subplot(4,3,11); hold on;
    plot(rep_range,bardata1(rep_range,12),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,12),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,12),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,12),bardata1(rep_range,13),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,12),bardata2(rep_range,13),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,12),bardata3(rep_range,13),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons (noB) - Normalised Firing Rate'},'FontSize',12,'FontWeight','Bold'); %
    
    subplot(4,3,12); hold on;
    plot(rep_range,bardata1(rep_range,14),'r-','LineWidth',2)
    plot(rep_range,bardata2(rep_range,14),'k-','LineWidth',2)
    plot(rep_range,bardata3(rep_range,14),'g-','LineWidth',2)
    errorbar(rep_range,bardata1(rep_range,14),bardata1(rep_range,15),'r-','LineWidth',2)
    errorbar(rep_range,bardata2(rep_range,14),bardata2(rep_range,15),'k-','LineWidth',2)
    errorbar(rep_range,bardata3(rep_range,14),bardata3(rep_range,15),'g-','LineWidth',2)
    legend('F','Bp','O');
    xlabel('# Exposures','FontSize',9); ylabel('RS Index','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
    set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons (noB) - RS Index'},'FontSize',12,'FontWeight','Bold'); %
        
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig5.1_Adaptation_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig5.1_Adaptation_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
    disp('Figure 5.2 - Proportion of neurons that show adaptation')
    figure; clf; cla; hold on %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    % Show proportion of neurons that show adaptation (defined as index greater than something certain)
    data1=fa_pref_adapt.baseline; num_units1=size(data1,1);
    data2=bp_pref_adapt.baseline; num_units2=size(data2,1);
    data3=ob_pref_adapt.baseline; num_units3=size(data3,1);
    data4=fa_all_adapt.baseline; num_units4=size(data4,1);
    data5=bp_all_adapt.baseline; num_units5=size(data5,1);
    data6=ob_all_adapt.baseline; num_units6=size(data6,1);
    for rr=1:length(rep_range),
        bd(1,rr)=length(find(data1(:,rr)>0.2))/num_units1;
        bd(2,rr)=length(find(data2(:,rr)>0.2))/num_units2;
        bd(3,rr)=length(find(data3(:,rr)>0.2))/num_units3;
        bd(4,rr)=length(find(data4(:,rr)>0.2))/num_units4;
        bd(5,rr)=length(find(data5(:,rr)>0.2))/num_units5;
        bd(6,rr)=length(find(data6(:,rr)>0.2))/num_units6;
    end
    plot(bd'); xlim([1 5]); xlabel('Presentation Number','FontSize',11); ylabel('Proportion of Neurons with Aind > 0.20','FontSize',11)
    legend('Fpref','Bpref','Opref','Fall','Ball','Oall')
    
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig5.2_Adaptation_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig5.2_Adaptation_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
    
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 6 - Effect of Stimulus History %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==6,1))==0,
    
    % Purpose of this analysis is to investigate the effect of the identity of the previous stimulus (category) on baseline and response
    % magnitude
    
    pointerFS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05); % face-responsive
    pointerBS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validbodyp<0.05); % bodypart-responsive
    pointerOS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validobject<0.05); % object-responsive
   
    [FSoutput_base,FSoutlineN_base,pFSb]=f570_stimhistory(xldata,hmiconfig,pointerFS,xldata.trial_baseline);
    [FSoutput_resp,FSoutputN_resp,pFSr]=f570_stimhistory(xldata,hmiconfig,pointerFS,xldata.trial_response);
    [FSoutput_respnobase,FSoutputN_respnobase,pFSnb]=f570_stimhistory(xldata,hmiconfig,pointerFS,xldata.trial_response_nobase);

    [BSoutput_base,BSoutlineN_base,pBSb]=f570_stimhistory(xldata,hmiconfig,pointerBS,xldata.trial_baseline);
    [BSoutput_resp,BSoutput_resp,pBSr]=f570_stimhistory(xldata,hmiconfig,pointerBS,xldata.trial_response);
    [BSoutput_respnobase,BSoutput_respnobase,pBSnb]=f570_stimhistory(xldata,hmiconfig,pointerBS,xldata.trial_response_nobase);
    
    [OSoutput_base,OSoutlineN_base,pOSb]=f570_stimhistory(xldata,hmiconfig,pointerOS,xldata.trial_baseline);
    [OSoutput_resp,OSoutput_resp,pOSr]=f570_stimhistory(xldata,hmiconfig,pointerOS,xldata.trial_response);
    [OSoutput_respnobase,OSoutput_respnobase,pOSnb]=f570_stimhistory(xldata,hmiconfig,pointerOS,xldata.trial_response_nobase);
    
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    subplot(3,3,1)
    bar(FSoutput_base(:,1));
    title('Baseline - Face-Responsive Neurons'); ylim([0 10])
    text(1,8,['p(anova)=',num2str(pFSb,2)])
    
    subplot(3,3,2)
    bar(BSoutput_base(:,1))
    title('Baseline - Bodypart-Responsive Neurons'); ylim([0 10])
    text(1,8,['p(anova)=',num2str(pOSb,2)])
    
    subplot(3,3,3)
    bar(OSoutput_base(:,1))
    title('Baseline - Object-Responsive Neurons'); ylim([0 10])
    text(1,8,['p(anova)=',num2str(pOSb,2)])
    
    subplot(3,3,4)
    bar(FSoutput_resp(:,1))
    title('Response - Face-Responsive Neurons'); ylim([0 10])
    text(1,8,['p(anova)=',num2str(pFSr,2)])
    
    subplot(3,3,5)
    bar(BSoutput_resp(:,1))
    title('Response - Bodypart-Responsive Neurons'); ylim([0 10])
    text(1,8,['p(anova)=',num2str(pBSr,2)])
    
    subplot(3,3,6)
    bar(OSoutput_resp(:,1))
    title('Response - Object-Responsive Neurons'); ylim([0 10])
    text(1,8,['p(anova)=',num2str(pOSr,2)])
    
    subplot(3,3,7)
    bar(FSoutput_respnobase(:,1))
    title('Response (No Baseline) - Face-Responsive Neurons'); ylim([0 10])
    text(1,8,['p(anova)=',num2str(pFSnb,2)])
    
    subplot(3,3,8)
    bar(BSoutput_respnobase(:,1))
    title('Response (No Baseline) - Bodypart-Responsive Neurons'); ylim([0 10])
    text(1,8,['p(anova)=',num2str(pBSnb,2)])
    
    subplot(3,3,9)
    bar(OSoutput_respnobase(:,1))
    title('Response (No Baseline) - Object-Responsive Neurons'); ylim([0 10])
    text(1,8,['p(anova)=',num2str(pOSnb,2)])
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 7 - Interaction between Facial Expression and Gaze Direction %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==5,1))==0,
    disp('Figure 5.1 - Interaction between Facial Expression and Gaze Direction')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
   
    
    
    
    
    subplot(3,2,1); hold on % FE significant
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05);
    bar(1:8,mean(xldata.avg_rsp(pointer,:)))
    errorbar(1:8,mean(xldata.avg_rsp(pointer,:)),sem(xldata.avg_rsp(pointer,:)))
    for ns=1:2:7,
        [p,~]=ranksum(xldata.avg_rsp(pointer,ns),xldata.avg_rsp(pointer,ns+1));
        text(ns+0.5,18,['p=',num2str(p,'%0.2g')])
    end
    ylabel('Average Response (sp/s)','FontSize',10); ylim([0 20])
    set(gca,'XTickLabel',{'Neut_D','Neut_A','Threat_D','Threat_A','Fear_D','Fear_A','BodyP','Objects'},'FontSize',fontsize_sml,'XTick',1:8)
    title(['Face Neurons with sig FExGD (n=',num2str(length(pointer)),')'],'FontSize',fontsize_med)
    
    subplot(3,2,2); hold on % FE significant
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
    bar(1:8,mean(xldata.avg_rsp(pointer,:)))
    errorbar(1:8,mean(xldata.avg_rsp(pointer,:)),sem(xldata.avg_rsp(pointer,:)))
    for ns=1:2:7,
        [p,~]=ranksum(xldata.avg_rsp(pointer,ns),xldata.avg_rsp(pointer,ns+1));
        text(ns+0.5,18,['p=',num2str(p,'%0.2g')])
    end
    ylabel('Average Response (sp/s)','FontSize',10); ylim([0 20])
    set(gca,'XTickLabel',{'Neut_D','Neut_A','Threat_D','Threat_A','Fear_D','Fear_A','BodyP','Objects'},'FontSize',fontsize_sml,'XTick',1:8)
    title(['Face Neurons with sig FE  (n=',num2str(length(pointer)),')'],'FontSize',fontsize_med)
    
    
    subplot(3,2,4); hold on % FE significant
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05);
    bar(1:8,mean(xldata.norm_avg_rsp(pointer,:)))
    errorbar(1:8,mean(xldata.norm_avg_rsp(pointer,:)),sem(xldata.norm_avg_rsp(pointer,:)))
    for ns=1:2:7,
        [p,~]=ranksum(xldata.avg_rsp(pointer,ns),xldata.avg_rsp(pointer,ns+1));
        text(ns+0.5,1.3,['p=',num2str(p,'%0.2g')])
    end
    ylabel('Average Response (sp/s)','FontSize',10); ylim([0 1.4]);
    set(gca,'XTickLabel',{'Neut_D','Neut_A','Threat_D','Threat_A','Fear_D','Fear_A','BodyP','Objects'},'FontSize',fontsize_sml,'XTick',1:8)
    title(['Face Responsive Neurons exhibiting Significant effect of Facial Expression (n=',num2str(length(pointer)),')'],'FontSize',10)
    subplot(3,2,5); hold on % FE not significant
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)>=0.05);
    bar(1:8,mean(xldata.avg_rsp(pointer,:)))
    errorbar(1:8,mean(xldata.avg_rsp(pointer,:)),sem(xldata.avg_rsp(pointer,:)))
    for ns=1:2:7,
        [p,~]=ranksum(xldata.avg_rsp(pointer,ns),xldata.avg_rsp(pointer,ns+1));
        text(ns+0.5,18,['p=',num2str(p,'%0.2g')])
    end
    ylabel('Average Response (sp/s)','FontSize',10); ylim([0 20])
    set(gca,'XTickLabel',{'Neut_D','Neut_A','Threat_D','Threat_A','Fear_D','Fear_A','BodyP','Objects'},'FontSize',fontsize_sml,'XTick',1:8)
    title(['Face Responsive Neurons NOT exhibiting significant effect of Facial Expression (n=',num2str(length(pointer)),')'],'FontSize',10)
    subplot(3,2,6); hold on % FE not significant
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)>=0.05);
    bar(1:8,mean(xldata.norm_avg_rsp(pointer,:)))
    errorbar(1:8,mean(xldata.norm_avg_rsp(pointer,:)),sem(xldata.norm_avg_rsp(pointer,:)))
    for ns=1:2:7,
        [p,~]=ranksum(xldata.avg_rsp(pointer,ns),xldata.avg_rsp(pointer,ns+1));
        text(ns+0.5,1.3,['p=',num2str(p,'%0.2g')])
    end
    ylabel('Average Response (sp/s)','FontSize',10); ylim([0 1.4]);
    set(gca,'XTickLabel',{'Neut_D','Neut_A','Threat_D','Threat_A','Fear_D','Fear_A','BodyP','Objects'},'FontSize',fontsize_sml,'XTick',1:8)
    title(['Face Responsive Neurons NOT exhibiting significant effect of Facial Expression (n=',num2str(length(pointer)),')'],'FontSize',10)
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig7.1_FExGD_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig7.1_FExGD_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
end








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 8 - Compare Critical Phases of Response %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==8, 1))==0,
    disp('Figure 8.1 - Compare Critical Phases of Response')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    binsize=5;
    subplot(2,2,1); hold on % Facial Expression (only SIG neurons)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
    floatdata=f570_floatANOVA(hmiconfig,xldata,pointer,xrange,binsize);
    [hax,h1,h2]=plotyy(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesND),xrange(1):binsize:xrange(end)-binsize,floatdata.anova(:,1));
    xlabel('Time from Stimulus Onset (ms)','FontSize',fontsize_med)
    title('Face Responsive Neurons with Significant FE Effect','FontSize',10,'FontWeight','Bold')
    axes(hax(1)); hold on %#ok
    plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesTD),'k-','LineWidth',1)
    plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesFD),'r-','LineWidth',1)
    set(h1,'LineStyle','-')
    set(h2,'LineWidth',1)
    ylabel('Mean Activity (sp/s)','FontSize',fontsize_sml)
    axes(hax(2)); hold on %#ok
    plot(xrange,[0.05 0.05],'k:')
    set(h2,'LineStyle','-','LineWidth',1); set(gca,'YLim',[0 0.50])
    ylabel('p-value (ANOVA)','FontSize',fontsize_sml)
    subplot(2,2,2); hold on % Gaze Direction (only SIG neurons)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
    floatdata=f570_floatANOVA(hmiconfig,xldata,pointer,xrange,binsize);
    [hax,h1,h2]=plotyy(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesND),xrange(1):binsize:xrange(end)-binsize,floatdata.anova(:,2));
    xlabel('Time from Stimulus Onset (ms)','FontSize',fontsize_med)
    title('Face Responsive Neurons with Significant GD Effect','FontSize',10,'FontWeight','Bold')
    axes(hax(1)); hold on %#ok
    plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesFA),'r-','LineWidth',1)
    set(h1,'LineStyle','-')
    set(h2,'LineWidth',1)
    ylabel('Mean Activity (sp/s)','FontSize',fontsize_sml)
    axes(hax(2)); hold on %#ok
    plot(xrange,[0.05 0.05],'k:')
    set(h2,'LineStyle','-','LineWidth',1); set(gca,'YLim',[0 0.50])
    ylabel('p-value (ANOVA)','FontSize',fontsize_sml)
    % Normalized
    binsize=20;
    subplot(2,2,3); hold on % Facial Expression (only SIG neurons)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
    floatdata=f570_floatANOVAnorm(hmiconfig,xldata,pointer,xrange,binsize);
    [hax,h1,h2]=plotyy(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesND),xrange(1):binsize:xrange(end)-binsize,floatdata.anova(:,1));
    xlabel('Time from Stimulus Onset (ms)','FontSize',fontsize_med)
    title('Face Responsive Neurons with Significant FE Effect (Normalized)','FontSize',10,'FontWeight','Bold')
    axes(hax(1)); hold on %#ok
    plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesTD),'k-','LineWidth',1)
    plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesFD),'r-','LineWidth',1)
    set(h1,'LineStyle','-'); set(gca,'XLim',[-100 500])
    set(h2,'LineWidth',1)
    ylabel('Mean Activity (sp/s)','FontSize',fontsize_sml)
    axes(hax(2)); hold on %#ok
    plot(xrange,[0.05 0.05],'k:')
    set(h2,'LineStyle','-','LineWidth',1); set(gca,'YLim',[0 0.50],'XLim',[-100 500])
    ylabel('p-value (ANOVA)','FontSize',fontsize_sml)
    subplot(2,2,4); hold on % Gaze Direction (only SIG neurons)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
    floatdata=f570_floatANOVAnorm(hmiconfig,xldata,pointer,xrange,binsize);
    [hax,h1,h2]=plotyy(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesND),xrange(1):binsize:xrange(end)-binsize,floatdata.anova(:,2));
    xlabel('Time from Stimulus Onset (ms)','FontSize',fontsize_med)
    title('Face Responsive Neurons with Significant GD Effect (Normalized)','FontSize',10,'FontWeight','Bold')
    axes(hax(1)); hold on %#ok
    plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesNA),'r-','LineWidth',1)
    set(h1,'LineStyle','-'); set(gca,'XLim',[-100 500])
    set(h2,'LineWidth',1)
    ylabel('Mean Activity (sp/s)','FontSize',fontsize_sml)
    axes(hax(2)); hold on %#ok
    plot(xrange,[0.05 0.05],'k:')
    set(h2,'LineStyle','-','LineWidth',1); set(gca,'YLim',[0 0.50],'XLim',[-100 500])
    ylabel('p-value (ANOVA)','FontSize',fontsize_sml)
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig8.1_floatANOVA_faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig8.1_floatANOVA_faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 9 - Multivariate Analysis %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==9,1))==0,
    disp('Figures 9.x - Multivariate analysis of discrimination')
    f570_multivariate(hmiconfig,xldata,['AllNeurons-',monkeyname],figurepath);
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1);
    f570_multivariate(hmiconfig,xldata,['FaceSelect-',monkeyname],figurepath,pointer);
    pointer=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05);
    f570_multivariate(hmiconfig,xldata,['FaceResponsive-',monkeyname],figurepath,pointer);
    pointer=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface>=0.25);
    f570_multivariate(hmiconfig,xldata,['NonResponsiveSensory-',monkeyname],figurepath,pointer);
    pointer=find(strcmp(xldata.confresptype,'Excite')==1 & strcmp(xldata.confneur,'Sensory')==1);
    f570_multivariate(hmiconfig,xldata,['Excitatory-',monkeyname],figurepath,pointer);
    pointer=find(strcmp(xldata.confresptype,'Suppress')==1 & strcmp(xldata.confneur,'Sensory')==1);
    f570_multivariate(hmiconfig,xldata,['Suppressed-',monkeyname],figurepath,pointer);
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
    f570_multivariate(hmiconfig,xldata,['FEsig-',monkeyname],figurepath,pointer);
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.15);
    f570_multivariate(hmiconfig,xldata,['FEnonsig-',monkeyname],figurepath,pointer);
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
    f570_multivariate(hmiconfig,xldata,['GDsig-',monkeyname],figurepath,pointer);
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.15);
    f570_multivariate(hmiconfig,xldata,['GDnonsig-',monkeyname],figurepath,pointer);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 10 - Effect of Rich Stimulus %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==10,1))==0,
    disp('Figure 10.1 - Effect of Rich Stimulus')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    subplot(1,2,1);
    clear piedata
    piedata(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
    piedata(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Identity Selectivity Among Face-Responsive Neurons (FACES570 Neurons)',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    set(gca,'FontSize',fontsize_sml); legend('Sig','NonSig');
    subplot(1,2,2);
    
    %%% LOAD DATA FROM RSVP500 - CORRECT FOR # OF STIMULI
    
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title({'Identity Selectivity Among Face-Responsive Neurons (RSVP Neurons)',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
    set(gca,'FontSize',fontsize_sml); legend('Sig','NonSig');
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig9.1_RichStimulus_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig9.1_RichStimulus_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 11 - Effect of Facial Expression on Non-Face Responsive Neurons %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(analyses==11,1))==0,
    disp('Figure 11.1 - Effect of Facial Expression on Non-Face Responsive Neurons')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if isempty(find(analyses==12,1))==0,
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Question 12 - Timeline of Selectivity %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 12.1 - Timeline of Selectivity')
    figure; clf; cla; hold on %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    clear temp pointerFR temp1 temp2 temp3 groupsize numunits groups
    pointerFR=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1);
    %temp1=xldata.unit_number(pointerFR)'; 
    temp2=xldata.anova_id(pointerFR)';
    groupsize=20; % groupings of neurons
    numunits=length(pointerFR); temp3=1:numunits;
    groups=1:groupsize:numunits; temp=zeros(length(groups,2));
    for gg=1:length(groups),
        temp(gg,1)=length(find(ismember(temp3,groups(gg):(groups(gg)+groupsize-1))==1 & temp2'<0.05));
        temp(gg,2)=temp(gg,1)/groupsize*100;
    end
    plot(groups,temp(:,2),'k-'); plot(groups,temp(:,2),'ks');
    xlabel('Number of Units','FontSize',fontsize_med); ylabel('% ID Sensitivity','FontSize',fontsize_med);
    title([monkeyname,' - Timeline'],'FontSize',fontsize_lrg)
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig12.1_Timeline_Faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig12.1_Timeline_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
end


if isempty(find(analyses==13,1))==0,
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Question 13 - Effects Within/Outside %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.1 - Effects Within/Outside')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
    
    %     disp('Figure 2.1 - Distribution of Neurons relative to Face Patches)')
    %     figure; clf; cla; %
    %     set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.5]); set(gca,'FontName','Arial','FontSize',10);
    %     subplot(1,2,1); % face neurons
    %     surfdata=[];
    %     numgrids=unique(xldata.gridloc);
    %     for g=1:length(numgrids),
    %         gridloc=numgrids(g);
    %         surfdata(g,1:2)=plx_convertgrid2ap(gridloc);
    %         temp1=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.gridloc,gridloc)==1 & xldata.validface<0.05));
    %         temp2=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.gridloc,gridloc)==1));
    %         surfdata(g,3)=temp1/temp2;
    %         clear temp1 temp2
    %         %if isinf(surfdata(g,3))==1, surfdata(g,3)=1; end
    %         if isnan(surfdata(g,3))==1, surfdata(g,3)=0; end
    %     end
    %     gridmap=plx500_surfdata2gridmap(surfdata);
    %     pcolor(gridmap); shading flat; set(gca,'XDir','reverse');
    %     axis square; set(gca,'CLim',[0 1])
    %     mp=colormap; mp(1,:)=[0.7529 0.7529 0.7529]; colormap(mp)
    %     set(gca,'YTick',1:15,'YTickLabel',5:19,'XTick',15:29,'XTickLabel',15:29)
    %     ylabel('Distance from interaural axis (mm)','FontSize',10);
    %     xlabel('Distance from midline (mm)','FontSize',10);
    %     title({['Distribution of Face-Responsive Neurons'],[]},'FontSize',fontsize_med,'FontWeight','Bold')
    %     colorbar('SouthOutside','FontSize',6)
    %     patchgrids=unique(facegrids);
    %     prop_in=length(intersect(patchgrids',numgrids));
    %     subplot(1,2,2); % face patches
    %     surfdata=[];
    %     numgrids=unique(facegrids);
    %     for g=1:length(numgrids),
    %         gridloc=numgrids(g);
    %         surfdata(g,1:2)=plx_convertgrid2ap(gridloc);
    %         surfdata(g,3)=1;
    %     end
    %     gridmap=plx500_surfdata2gridmap(surfdata);
    %     pcolor(gridmap); shading flat; set(gca,'XDir','reverse');
    %     axis square; set(gca,'CLim',[0 1])
    %     mp=colormap; mp(1,:)=[0.7529 0.7529 0.7529]; colormap(mp)
    %     set(gca,'YTick',1:15,'YTickLabel',5:19,'XTick',15:29,'XTickLabel',15:29)
    %     ylabel('Distance from interaural axis (mm)','FontSize',10);
    %     xlabel('Distance from midline (mm)','FontSize',10);
    %     title({['Location of Face Patches'],['# Grids IN: ',num2str(prop_in)]},'FontSize',fontsize_med,'FontWeight','Bold')
    %     colorbar('SouthOutside','FontSize',6)
    %     jpgfigname=[figure_path,filesep,monkeyname,'_Fig12.1pop_faces570_patches.jpg'];
    %     illfigname=[figure_path,filesep,monkeyname,'_Fig12.1pop_faces570_patches.ai'];
    %     print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    %     print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.2 - Summary Statistics of In vs. Out Face Patch(es)')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.7 0.8]); set(gca,'FontName','Arial','FontSize',10);
    
    subplot(3,3,1); piedata=[]; % number of neurons in vs. out
    piedata(1)=length(find(ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(ismember(xldata.gridloc,facegrids)~=1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title('(A)Neurons Inside vs. Outside Face Patch','FontSize',fontsize_med,'FontWeight','Bold')
    legend('IN','OUT','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,3,2); piedata=[]; % category selectivity for in vs. out patch
    piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1));
    piedata(3)=length(find(strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1));
    piedata(4)=length(find(strcmp(xldata.confprefcat,'Non-responsive')==1 & strcmp(xldata.confneur,'Sensory')~=1 & ismember(xldata.gridloc,facegrids)==1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) Inside Patch (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('F','Bp','O','NR','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,3,3); piedata=[]; % category selectivity for in vs. out patch
    piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(3)=length(find(strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(4)=length(find(strcmp(xldata.confprefcat,'Non-responsive')==1 & strcmp(xldata.confneur,'Sensory')~=1 & ismember(xldata.gridloc,facegrids)~=1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) Outside Patch (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('F','Bp','O','NR','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,3,4)
    % Face Selectivity Index of all face preferring neurons
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.cat_rsp_avg(pointer,:); indata=zeros(length(pointer),1);
    for nn=1:length(pointer), indata(nn)=(temp_indata(nn,1)-(0.5*sum(temp_indata(nn,2:3))))/(temp_indata(nn,1)+(0.5*sum(temp_indata(nn,2:3)))); end
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.cat_rsp_avg(pointer,:); outdata=zeros(length(pointer),1);
    for nn=1:length(pointer), outdata(nn)=(temp_outdata(nn,1)-(0.5*sum(temp_outdata(nn,2:3))))/(temp_outdata(nn,1)+(0.5*sum(temp_outdata(nn,2:3)))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Face Selectivity Index for Face-Preferring Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',fontsize_sml)
    ylabel('Face Selectivity Index')
    p=ranksum(outdata,indata);
    text(1.5,0.5,['P=',num2str(p,'%1.2g')],'FontSize',fontsize_sml)
    subplot(3,3,5) % valence effect
    % Facial Expression Selectivity Index of all face preferring neurons
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.expr_rsp_avg(pointer,:); indata=zeros(length(pointer),1);
    for nn=1:length(pointer), indata(nn)=abs((temp_indata(nn,1)-(max(temp_indata(nn,2:3))))/(temp_indata(nn,1)+(max(temp_indata(nn,2:3))))); end
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.expr_rsp_avg(pointer,:); outdata=zeros(length(pointer),1);
    for nn=1:length(pointer), outdata(nn)=abs((temp_outdata(nn,1)-(max(temp_outdata(nn,2:3))))/(temp_outdata(nn,1)+(max(temp_outdata(nn,2:3))))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Valence Effect for Face-Preferring Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',fontsize_sml)
    ylabel('abs(Valence Effect)')
    p=ranksum(outdata,indata);
    text(1.5,0.15,['P=',num2str(p,'%1.2g')],'FontSize',fontsize_sml)
    subplot(3,3,6) % gaze direction effect
    % Gaze Direction Sensitivity Selectivity Index of all face preferring neurons
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.gaze_rsp_avg(pointer,:); indata=zeros(length(pointer),1);
    for nn=1:length(pointer), indata(nn)=abs((temp_indata(nn,1)-temp_indata(nn,2))/(temp_indata(nn,1)+temp_indata(nn,2))); end
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.gaze_rsp_avg(pointer,:); outdata=zeros(length(pointer),1);
    for nn=1:length(pointer), outdata(nn)=abs((temp_outdata(nn,1)-temp_outdata(nn,2))/(temp_outdata(nn,1)+temp_outdata(nn,2))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Gaze Direction Index for Face-Preferring Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',fontsize_sml)
    ylabel('abs(Gaze Direction Sensitivity)')
    p=ranksum(outdata,indata);
    text(1.5,0.15,['P=',num2str(p,'%1.2g')],'FontSize',fontsize_sml)
    subplot(3,3,7)
    % Face Selectivity Index of all face preferring neurons
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.cat_rsp_avg(pointer,:); indata=zeros(length(pointer),1);
    for nn=1:length(pointer), indata(nn)=(temp_indata(nn,1)-(0.5*sum(temp_indata(nn,2:3))))/(temp_indata(nn,1)+(0.5*sum(temp_indata(nn,2:3)))); end
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.cat_rsp_avg(pointer,:); outdata=zeros(length(pointer),1);
    for nn=1:length(pointer), outdata(nn)=(temp_outdata(nn,1)-(0.5*sum(temp_outdata(nn,2:3))))/(temp_outdata(nn,1)+(0.5*sum(temp_outdata(nn,2:3)))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Face Selectivity Index for Face-Responsive Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',fontsize_sml)
    ylabel('Face Selectivity Index')
    p=ranksum(outdata,indata);
    text(1.5,0.5,['P=',num2str(p,'%1.2g')],'FontSize',fontsize_sml)
    subplot(3,3,8) % valence effect
    % Facial Expression Selectivity Index of all face preferring neurons
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.expr_rsp_avg(pointer,:); indata=zeros(length(pointer),1);
    for nn=1:length(pointer), indata(nn)=abs((temp_indata(nn,1)-(max(temp_indata(nn,2:3))))/(temp_indata(nn,1)+(max(temp_indata(nn,2:3))))); end
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.expr_rsp_avg(pointer,:); outdata=zeros(length(pointer),1);
    for nn=1:length(pointer), outdata(nn)=abs((temp_outdata(nn,1)-(max(temp_outdata(nn,2:3))))/(temp_outdata(nn,1)+(max(temp_outdata(nn,2:3))))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Valence Effect for Face-Responsive Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',fontsize_sml)
    ylabel('abs(Valence Effect)')
    p=ranksum(outdata,indata);
    text(1.5,0.15,['P=',num2str(p,'%1.2g')],'FontSize',fontsize_sml)
    subplot(3,3,9) % gaze direction effect
    % Gaze Direction Sensitivity Selectivity Index of all face preferring neurons
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.gaze_rsp_avg(pointer,:); indata=zeros(length(pointer),1);
    for nn=1:length(pointer), indata(nn)=abs((temp_indata(nn,1)-temp_indata(nn,2))/(temp_indata(nn,1)+temp_indata(nn,2))); end
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.gaze_rsp_avg(pointer,:); outdata=zeros(length(pointer),1);
    for nn=1:length(pointer), outdata(nn)=abs((temp_outdata(nn,1)-temp_outdata(nn,2))/(temp_outdata(nn,1)+temp_outdata(nn,2))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Gaze Direction Index for Face-Responsive Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',fontsize_sml)
    ylabel('abs(Gaze Direction Sensitivity)')
    p=ranksum(outdata,indata);
    text(1.5,0.15,['P=',num2str(p,'%1.2g')],'FontSize',fontsize_sml)
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig13.2pop_patch_faces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig13.2pop_patch_faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.3 - Social Effects Statistics of In vs. Out Face Patch(es) -- ALL FACE RESPONSIVE NEURONS')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',10);
    subplot(3,2,1); piedata=[]; % FE inside patch
    [~,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
    piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==3));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(A) FE ANOVA IN PATCH(All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,2); piedata=[]; % FE inside patch
    [~,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
    piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==3));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(A) FE ANOVA OUT PATCH (All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,3); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA IN PATCH(All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,4); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA OUT PATCH (All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,5); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_id'>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_id'<0.05 & ismember(xldata.gridloc,facegrids)==1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA IN PATCH(All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,6); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_id'>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_id'<0.05 & ismember(xldata.gridloc,facegrids)~=1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA OUT PATCH (All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig13.3pop_patchfaces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig13.3pop_patchfaces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.4 - Social Effects Statistics of In vs. Out Face Patch(es) _Face Pref Neurons Only')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',10);
    subplot(3,2,1); piedata=[]; % FE inside patch
    [~,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
    piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==3));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(A) FE ANOVA IN PATCH(Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,2); piedata=[]; % FE inside patch
    [~,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
    piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==3));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(A) FE ANOVA OUT PATCH (Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,3); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA IN PATCH(Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,4); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA OUT PATCH (Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,5); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id<0.05 & ismember(xldata.gridloc,facegrids)==1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA IN PATCH(Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,6); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id<0.05 & ismember(xldata.gridloc,facegrids)~=1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA OUT PATCH (Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig13.4pop_facespatch570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig13.4pop_facespatch570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.5 - Social Effects Statistics of In vs. Out Face Patch(es) _Only Face-Responsive, no face pref Neurons Only')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',10);
    subplot(3,2,1); piedata=[]; % FE inside patch
    [~,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_expr>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
    piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==3));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(A) FE ANOVA IN PATCH(only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,2); piedata=[]; % FE inside patch
    [~,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_expr>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
    piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_expr<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==3));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(A) FE ANOVA OUT PATCH (only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,3); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA IN PATCH(only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,4); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA OUT PATCH (only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,5); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_id>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_id<0.05 & ismember(xldata.gridloc,facegrids)==1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA IN PATCH(only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    subplot(3,2,6); piedata=[]; % GD inside patch
    [~,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex'; %#ok
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_id>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_id<0.05 & ismember(xldata.gridloc,facegrids)~=1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA OUT PATCH (only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',fontsize_sml)
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig13.5pop_facespatch570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig13.5pop_facespatch570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.6 - Facial Expression Magnitude Effect')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',10);
    subplot(3,4,1); % average magnitude for face-preferring neurons (IN)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('Face Pref (IN) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,2); % average magnitude for face-preferring neurons (OUT)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('Face Pref (OUT) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,3); % average magnitude for face-preferring neurons (IN)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('Face Pref (IN) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 1.7])
    subplot(3,4,4); % average magnitude for face-preferring neurons (OUT)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('Face Pref (OUT) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 1.7])
    subplot(3,4,5); % average magnitude for face-responsive neurons (IN)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('Face Resp (IN) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,6); % average magnitude for face-responsive neurons (OUT)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('Face Resp (OUT) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,7); % average magnitude for face-responsive neurons (IN)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('Face Resp (IN) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 1.7])
    subplot(3,4,8); % average magnitude for face-responsive neurons (OUT)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('Face Resp (OUT) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 1.7])
    subplot(3,4,9); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('NonFace (IN) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,10); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('NonFace (OUT) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,11); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('NonFace (IN) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 1.7])
    subplot(3,4,12); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',fontsize_sml,'XTick',1:3)
    title('NonFace (OUT) - FE','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 1.7])
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig13.6pop_patchfaces570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig13.6pop_patchfaces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.7 - Gaze Direction Magnitude Effect')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',10);
    subplot(3,4,1); % average magnitude for face-preferring neurons (IN)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('Face Pref (IN) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,2); % average magnitude for face-preferring neurons (OUT)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('Face Pref (OUT) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,3); % average magnitude for face-preferring neurons (IN)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('Face Pref (IN) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 1.7])
    subplot(3,4,4); % average magnitude for face-preferring neurons (OUT)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('Face Pref (OUT) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 1.7])
    subplot(3,4,5); % average magnitude for face-responsive neurons (IN)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('Face Resp (IN) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,6); % average magnitude for face-responsive neurons (OUT)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('Face Resp (OUT) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,7); % average magnitude for face-responsive neurons (IN)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('Face Resp (IN) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 1.7])
    subplot(3,4,8); % average magnitude for face-responsive neurons (OUT)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('Face Resp (OUT) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 1.7])
    subplot(3,4,9); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('NonFace (IN) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,10); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('NonFace (OUT) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0 25])
    subplot(3,4,11); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('NonFace (IN) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 2.7])
    subplot(3,4,12); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',10);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',fontsize_sml,'XTick',1:2)
    title('NonFace (OUT) - GD','FontSize',10)
    [p,~]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
    ylim([0.7 2.7])
    jpgfigname=[figurepath,filesep,monkeyname,'_Fig13.7pop_gazedirectionpatch570.jpg'];
    illfigname=[figurepath,filesep,monkeyname,'_Fig13.7pop_gazedirectionpatch570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
end % end grid anal

return


%%% OLD CODE %%%

%% After this, only works on single monkeys (spike density functions, etc.)

%
%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     disp('Figure 8 - Average spike density functions for non face responsive neurons - facial expression')
%     figure; clf; cla; %
%     set(gcf,'Units','Normalized','Position',[0.2 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
%     % Shows average spike density functions (normalized and raw) for all
%     % non face-responsive neurons showing significant (vs. not significant)
%     % effect
%     % Bodypart Selective Neurons
%     clear avgfunc semfunc
%     fepointerS=find(xldata.validface>0.1 & strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
%     fepointerNS=find(xldata.validface>0.1 & strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05);
%     subplot(4,4,1); hold on % neuron tuning
%     [avgfunc semfunc]=f570_avg_spden(xldata,fepointerS,hmiconfig,xrange);
%     plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%     plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Tuning (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     %%% Facial Expression
%     subplot(4,4,2); hold on % sig
%     plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(3,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(5,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     subplot(4,4,4); hold on % sig
%     plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(11,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(13,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     % NON SIG
%     clear avgfunc semfunc
%     subplot(4,4,5); hold on % neuron tuning
%     [avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange);
%     plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%     plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Tuning (non F-Resp, Bodypart Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     %%% Facial Expression
%     subplot(4,4,6); hold on % non sig
%     plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(3,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(5,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Bodypart Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     subplot(4,4,8); hold on % non sig
%     plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(11,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(13,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Bodypart Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     % Object Selective Neurons
%     fepointerS=find(xldata.validface>0.1 & strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
%     fepointerNS=find(xldata.validface>0.1 & strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05);
%     subplot(4,4,9); hold on % neuron tuning
%     [avgfunc semfunc]=f570_avg_spden(xldata,fepointerS,hmiconfig,xrange);
%     plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%     plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Tuning (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     %%% Facial Expression
%     subplot(4,4,10); hold on % sig
%     plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(3,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(5,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     subplot(4,4,12); hold on % sig
%     plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(11,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(13,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     % NON SIG
%     subplot(4,4,13); hold on % neuron tuning
%     [avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange);
%     plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%     plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Tuning (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     %%% Facial Expression
%     subplot(4,4,14); hold on % non sig
%     plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(3,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(5,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     subplot(4,4,16); hold on % non sig
%     plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(11,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(13,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     jpgfigname=[figure_path,filesep,monkeyname,'_Fig8pop_avgspden_faces570.jpg'];
%     illfigname=[figure_path,filesep,monkeyname,'_Fig8pop_avgspden_faces570.ai'];
%     print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
%     print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
%
%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     disp('Figure 9 - Average spike density functions for non face responsive neurons - gaze direction')
%     figure; clf; cla; %
%     set(gcf,'Units','Normalized','Position',[0.2 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
%     % Shows average spike density functions (normalized and raw) for all
%     % non face-responsive neurons showing significant (vs. not significant)
%     % effect
%     % Bodypart Selective Neurons
%     clear avgfunc semfunc
%     try
%         fepointerS=find(xldata.validface>0.1 & strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
%         fepointerNS=find(xldata.validface>0.1 & strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05);
%         subplot(4,4,1); hold on % neuron tuning
%         [avgfunc semfunc]=f570_avg_spden(xldata,fepointerS,hmiconfig,xrange);
%         plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%         plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Tuning (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         %%% Gaze Direction
%         subplot(4,4,2); hold on % sig
%         plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(2,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         subplot(4,4,4); hold on % sig
%         plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(10,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         % NON SIG
%         clear avgfunc semfunc
%         subplot(4,4,5); hold on % neuron tuning
%         [avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange);
%         plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%         plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Tuning (non F-Resp, Bodypart Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%         %%% Gaze Direction
%         subplot(4,4,6); hold on % non sig
%         plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(2,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Bodypart Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%         subplot(4,4,8); hold on % non sig
%         plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(10,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Bodypart Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     end
%     try
%         % Object Selective Neurons
%         fepointerS=find(xldata.validface>0.1 & strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
%         fepointerNS=find(xldata.validface>0.1 & strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05);
%         subplot(4,4,9); hold on % neuron tuning
%         [avgfunc semfunc]=f570_avg_spden(xldata,fepointerS,hmiconfig,xrange);
%         plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%         plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Tuning (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         %%% Gaze Direction
%         subplot(4,4,10); hold on % sig
%         plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(2,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         subplot(4,4,12); hold on % sig
%         plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(10,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         % NON SIG
%         subplot(4,4,13); hold on % neuron tuning
%         [avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange);
%         plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%         plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Tuning (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         %%% Gaze Direction
%         subplot(4,4,14); hold on % non sig
%         plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(2,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%         subplot(4,4,16); hold on % non sig
%         plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(10,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',fontsize_sml); ylim([0 1]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     end
%     jpgfigname=[figure_path,filesep,monkeyname,'_Fig9pop_avgspden_faces570.jpg'];
%     illfigname=[figure_path,filesep,monkeyname,'_Fig9pop_avgspden_faces570.ai'];
%     print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
%     print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure
%
%
%

