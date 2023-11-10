function faces570a_population(monkinitial,gridanal)
%%%%%%%%%%%%%%%%%%%%%%%
% faces570_population %
%%%%%%%%%%%%%%%%%%%%%%%
% written by AHB, Nov2009, modified July 2010, modified again Feb 2012
% Code adjusted to work under Mac OSX, Matlab v2011b
% Program to compile all FACES570 neurons and generate summary figures.
% MONKINITIAL (required) = 'W' or 'S'
% GRIDANAL (optional) = 1 if wish to analyze in/out patches, default off

%Your monkey 1: female, mid-age
%Your monkey 2: female, mid-age
%Your monkey 3: male, mid-age
%Your monkey 4: male, mid-age
%Your monkey 5: female, young
%Your monkey 6: female, mid-ge
%Your monkey 7: female, can't tell the age
%Your monkey 8: female, 20 years old

%%% SETUP DEFAULTS
warning off; close all;
hmiconfig=generate_f570_config; % generates and loads config file
if nargin==0, error('You must specify a monkey (''S''/''W''/''B'')'); end
switch monkinitial
    case 'S'
        monkeyname='Stewie'
    case 'W'
        monkeyname='Wiggum'
    case 'B'
        monkeyname='Both'
end


if nargin==1, gridanal=1; end
fontsize_med=8; fontsize_lrg=9;
xrange=[-100 500];

disp('+---------------------------------------------------------------------+')
disp('| faces570_population.m - Program to compile all FACES570 neurons and |')
disp('|        generate summary figures.                                    |')
disp('| NOTE:  This program works best if run AFTER plx570sync2excel.m      |')
disp('+---------------------------------------------------------------------+')



% Load Data



load(['/Users/ab03/Documents/PlexonData/faces570spks/Faces570data_',monkeyname,'.mat']);







% Generate Figures - See Projects.docx for details



%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question ? - Adaptation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

output=f570_adaptation(xldata); % adaptation for facial expression (trial_id,2)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 0 - Summary Statistics %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 0.1 - Summary Figure')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.05 0.15 0.6 0.7]); set(gca,'FontName','Arial','FontSize',8);
subplot(3,3,1); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(3)=length(find(strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(4)=length(find(strcmp(xldata.confneur,'Non-responsive')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title([monkeyname,' - (A) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('F','Bp','O','Nr','Location','Best'); set(gca,'FontSize',7)
subplot(3,3,2); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface>=0.05));
piedata(3)=length(find(strcmp(xldata.confneur,'Non-responsive')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title([monkeyname,' - (B) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('FResp','nonFRresp','Nr','Location','Best'); set(gca,'FontSize',7)
subplot(3,3,3); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confresptype,'Excite')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(2)=length(find(strcmp(xldata.confresptype,'Suppress')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(3)=length(find(strcmp(xldata.confresptype,'Both')==1 & strcmp(xldata.confneur,'Sensory')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(C) Excite/Suppress/Both (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('E','S','B','Location','Best'); set(gca,'FontSize',7)
%%% Face-Preferring Neurons
subplot(3,3,4); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(D) Facial Expression ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigFE','nonsig','Location','Best'); set(gca,'FontSize',7)
subplot(3,3,5); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(E) Gaze Direction ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigGD','nonsig','Location','Best'); set(gca,'FontSize',7)
subplot(3,3,6); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(F) Identity ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigI','nonsig','Location','Best'); set(gca,'FontSize',7)
%%% Face-Responsive Neurons (all neurons that have a valid face response)
subplot(3,3,7); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(G) Facial Expression ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigFE','nonsig','Location','Best'); set(gca,'FontSize',7)
subplot(3,3,8); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_gd'<0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_gd'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(H) Gaze Direction ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigGD','nonsig','Location','Best'); set(gca,'FontSize',7)
subplot(3,3,9); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id'<0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(I) Identity ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigI','nonsig','Location','Best'); set(gca,'FontSize',7)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig0.1_PieCharts_Faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig0.1_PieCharts_Faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 0.2 - Summary of Anova Effects of Face-Responsive Neurons')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.5]); set(gca,'FontName','Arial','FontSize',8);
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
set(gca,'XTickLabels',{'FE','ID','GD','FExID','GDxID','FExGD'})
title([monkeyname,' - ANOVA Main Effects & Interactions'],'FontSize',fontsize_lrg)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig0.2_AnovaEffects_Faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig0.2_AnovaEffects_Faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 1 - Effect of Facial Expression on Face Responses %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 1.1 - Effect of Facial Expression on Face Responses')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
fepointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
fepointerNS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05);
subplot(2,4,1); hold on % sig, raw, fe
[avgfunc semfunc]=f570_avg_spden(xldata,fepointerS,hmiconfig,xrange,monkeyname);
plot(xrange(1):xrange(2),avgfunc(17,:),'k-','LineWidth',1.5) % neutral directed
plot(xrange(1):xrange(2),avgfunc(18,:),'b-','LineWidth',1.5) % threat directed
plot(xrange(1):xrange(2),avgfunc(19,:),'r-','LineWidth',1.5) % fear grin directed
set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
title({'Facial Expression (F-Resp Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
subplot(2,4,2); hold on % sig, norm, fe
plot(xrange(1):xrange(2),avgfunc(22,:),'k-','LineWidth',1.5) % neutral directed
plot(xrange(1):xrange(2),avgfunc(23,:),'b-','LineWidth',1.5) % threat directed
plot(xrange(1):xrange(2),avgfunc(24,:),'r-','LineWidth',1.5) % fear grin directed
set(gca,'FontName','Arial','FontSize',7); ylim([0 1]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
title({'Facial Expression (F-Resp Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
subplot(2,4,3); hold on % non sig, raw, fe
[avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange,monkeyname);
plot(xrange(1):xrange(2),avgfunc(17,:),'k-','LineWidth',1.5) % neutral directed
plot(xrange(1):xrange(2),avgfunc(18,:),'b-','LineWidth',1.5) % threat directed
plot(xrange(1):xrange(2),avgfunc(19,:),'r-','LineWidth',1.5) % fear grin directed
set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
title({'Facial Expression (F-Resp Neurons)',['NS Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
subplot(2,4,4); hold on % non sig, norm, fe
plot(xrange(1):xrange(2),avgfunc(22,:),'k-','LineWidth',1.5) % neutral directed
plot(xrange(1):xrange(2),avgfunc(23,:),'b-','LineWidth',1.5) % threat directed
plot(xrange(1):xrange(2),avgfunc(24,:),'r-','LineWidth',1.5) % fear grin directed
set(gca,'FontName','Arial','FontSize',7); ylim([0 1]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
title({'Facial Expression (F-Resp Neurons)',['NS Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
legend('N','T','Fg')
subplot(2,5,6)
bardata=xldata.expr_rsp_avg(fepointerS,:);
[val,ind]=max(bardata(:,1:3),[],2); clear piedata
piedata(1)=length(find(ind==1));
piedata(2)=length(find(ind==2));
piedata(3)=length(find(ind==3));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Face Resp - Max Facial Expression',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
legend('Neutral','Threat','FearGrin','Best'); set(gca,'FontSize',7)
subplot(2,5,7); hold on % expression - average raw responses
bardata=xldata.expr_rsp_avg(fepointerS,:);
bar(1:3,mean(bardata,1));
errorbar(1:3,mean(bardata,1),sem(bardata));
ylabel('Average Response (sp/s)','FontSize',8); ylim([0 20])
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3); axis square
title('Face Resp (sig effect of FE)','FontSize',10)
[p,h]=ranksum(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(2,5,8); hold on % expression - normalized (to neutral)
bardata(:,4)=bardata(:,1)./bardata(:,1);
bardata(:,5)=bardata(:,2)./bardata(:,1);
bardata(:,6)=bardata(:,3)./bardata(:,1);
bar(1:3,mean(bardata(:,4:6),1));
errorbar(1:3,mean(bardata(:,4:6),1),sem(bardata(:,4:6)));
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3); axis square
title('Face Resp (sig effect of FE)','FontSize',10)
[p,h]=ranksum(bardata(:,4),bardata(:,5));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,5),bardata(:,6));
text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,4),bardata(:,6));
text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(2,5,9); hold on % expression - average raw responses
bardata=xldata.expr_rsp_avg(fepointerNS,:);
bar(1:3,mean(bardata,1));
errorbar(1:3,mean(bardata,1),sem(bardata));
ylabel('Average Response (sp/s)','FontSize',8); ylim([0 20])
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3); axis square
title('Face Resp (nonsig)','FontSize',10)
[p,h]=ranksum(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(2,5,10); hold on % expression - normalized (to neutral)
bardata(:,4)=bardata(:,1)./bardata(:,1);
bardata(:,5)=bardata(:,2)./bardata(:,1);
bardata(:,6)=bardata(:,3)./bardata(:,1);
bar(1:3,mean(bardata(:,4:6),1));
errorbar(1:3,mean(bardata(:,4:6),1),sem(bardata(:,4:6)));
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3); axis square
title('Face Resp (nonsig)','FontSize',10)
[p,h]=ranksum(bardata(:,4),bardata(:,5));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,5),bardata(:,6));
text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,4),bardata(:,6));
text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig1.1_FacialExpression_Faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig1.1_FacialExpression_Faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2 - Effect of Gaze Direction on Face Responses %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 2.1 - Effect of Gaze Direction on Face Responses')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
gdpointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
gdpointerNS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05);
subplot(2,4,1); hold on % sig, raw, gd
[avgfunc semfunc]=f570_avg_spden(xldata,gdpointerS,hmiconfig,xrange,monkeyname);
plot(xrange(1):xrange(2),avgfunc(20,:),'k-','LineWidth',1.5) % directed
plot(xrange(1):xrange(2),avgfunc(21,:),'r-','LineWidth',1.5) % averted
set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
title({'Gaze Direction (F-Resp Neurons)',['Sig Neurons (n=',num2str(length(gdpointerS)),')']},'FontSize',fontsize_lrg)
subplot(2,4,2); hold on % sig, norm, gd
plot(xrange(1):xrange(2),avgfunc(25,:),'k-','LineWidth',1.5) % directed
plot(xrange(1):xrange(2),avgfunc(26,:),'r-','LineWidth',1.5) % averted
set(gca,'FontName','Arial','FontSize',7); ylim([0 1.25]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
title({'Gaze Direction (F-Resp Neurons)',['Sig Neurons (n=',num2str(length(gdpointerS)),')']},'FontSize',fontsize_lrg)
subplot(2,4,3); hold on % sig, raw, gd
[avgfunc semfunc]=f570_avg_spden(xldata,gdpointerNS,hmiconfig,xrange,monkeyname);
plot(xrange(1):xrange(2),avgfunc(20,:),'k-','LineWidth',1.5) % directed
plot(xrange(1):xrange(2),avgfunc(21,:),'r-','LineWidth',1.5) % averted
set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
title({'Gaze Direction (F-Resp Neurons)',['NS Neurons (n=',num2str(length(gdpointerNS)),')']},'FontSize',fontsize_lrg)
subplot(2,4,4); hold on % sig, norm, gd
plot(xrange(1):xrange(2),avgfunc(25,:),'k-','LineWidth',1.5) % directed
plot(xrange(1):xrange(2),avgfunc(26,:),'r-','LineWidth',1.5) % averted
set(gca,'FontName','Arial','FontSize',7); ylim([0 1.25]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Normalized Firing Rate*','FontSize',fontsize_med)
title({'Gaze Direction (F-Resp Neurons)',['NS Neurons (n=',num2str(length(gdpointerNS)),')']},'FontSize',fontsize_lrg)
legend('D','A')
subplot(2,5,6)
bardata=xldata.gaze_rsp_avg(gdpointerS,:);
[val,ind]=max(bardata(:,1:2),[],2); clear piedata
piedata(1)=length(find(ind==1));
piedata(2)=length(find(ind==2));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Face Resp - Max Gaze Direction',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
legend('Directed','Averted','Best'); set(gca,'FontSize',7)
subplot(2,5,7); hold on % gaze - average raw responses
bardata=xldata.gaze_rsp_avg(gdpointerS,:);
bar(1:2,mean(bardata,1));
errorbar(1:2,mean(bardata,1),sem(bardata));
ylabel('Average Response (sp/s)','FontSize',8); ylim([0 20]); axis square
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Resp (sig effect of GD)','FontSize',10)
[p,h]=ranksum(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(2,5,8); hold on % gaze - normalized (to directed)
bardata(:,3)=bardata(:,1)./bardata(:,1);
bardata(:,4)=bardata(:,2)./bardata(:,1);
bar(1:2,mean(bardata(:,3:4),1))
errorbar(1:2,mean(bardata(:,3:4),1),sem(bardata(:,3:4)));
ylabel('Average Response (sp/s)','FontSize',8); axis square
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Resp (sig effect of GD)','FontSize',10)
[p,h]=ranksum(bardata(:,3),bardata(:,4));
text(1.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(2,5,9); hold on % gaze - average raw responses
bardata=xldata.gaze_rsp_avg(gdpointerNS,:);
bar(1:2,mean(bardata,1));
errorbar(1:2,mean(bardata,1),sem(bardata));
ylabel('Average Response (sp/s)','FontSize',8); ylim([0 20]); axis square
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Resp (nonsig)','FontSize',10)
[p,h]=ranksum(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(2,5,10); hold on % gaze - normalized (to directed)
bardata(:,3)=bardata(:,1)./bardata(:,1);
bardata(:,4)=bardata(:,2)./bardata(:,1);
bar(1:2,mean(bardata(:,3:4),1))
errorbar(1:2,mean(bardata(:,3:4),1),sem(bardata(:,3:4)));
ylabel('Average Response (sp/s)','FontSize',8); axis square
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Resp (nonsig)','FontSize',10)
[p,h]=ranksum(bardata(:,3),bardata(:,4));
text(1.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig2.1_GazeDirection_Faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig2.1_GazeDirection_Faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3 - Effect of Identity on Face Responses %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 3.1 - Effect of Identity on Face Responses')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
subplot(1,2,1);
clear piedata
piedata(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
piedata(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Identity Selectivity Among Face-Responsive Neurons',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
set(gca,'FontSize',7); legend('Sig','NonSig');
subplot(1,2,2);
clear piedata
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Identity Selectivity Among Face-Preferring Neurons',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
set(gca,'FontSize',7); legend('Sig','NonSig');
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig3.1_Identity_Faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig3.1_Identity_Faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 4 - Intersecting vs. Independent Pathways %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 4.1 - Intersecting vs. Independent Pathways')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
clear fe id ge feid fegd gdid feidgd
fe=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'>=0.05));
id=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
gd=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
feid=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
fegd=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
gdid=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
feidgd=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
if strcmp(monkinitial,'W')~=1,
    subplot(1,2,1)
    venndata=[fe id gd feid fegd gdid feidgd];
    [H,S]=venn(venndata);
    for i = 1:7, text(S.ZoneCentroid(i,1), S.ZoneCentroid(i,2), num2str(venndata(i))); end
    axis square; axis off
    legend('fe','id','ge','feid','fegd','gdid','feidgd'); set(gca,'FontSize',7)
    title([monkeyname,' - Neuron Distribution'],'FontSize',10)
    subplot(1,2,2)
    fe=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_gd'>=0.05));
    gd=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_gd'<0.05));
    fegd=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_gd'<0.05));
    venndata=[fe gd fegd];
    [H,S]=venn([fe gd],fegd);
    for i = 1:3, text(S.ZoneCentroid(i,1), S.ZoneCentroid(i,2), num2str(venndata(i))); end
    axis square; axis off
    legend('fe','gd','fegd'); set(gca,'FontSize',7)
    jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig4.1_VennDiagram_Faces570.jpg'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    %illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig4.1_VennDiagram_Faces570.ai'];
    %print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 5 - Interaction between Facial Expression and Identity %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 5.1 - Interaction between Facial Expression and Identity')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
subplot(1,2,1);
clear piedata
piedata(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_id(:,3)<0.05));
piedata(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_id(:,3)>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Interaction between FE vs ID Among Face-Responsive Neurons',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
set(gca,'FontSize',7); legend('Sig','NonSig');

%%% Single example?

jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig5.1_FExID_Faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig5.1_FExID_Faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 6 - Interaction between Gaze Direction and Identity %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 6.1 - Interaction between Facial Expression and Identity')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
subplot(1,2,1);
clear piedata
piedata(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_gd(:,3)<0.05));
piedata(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_gd(:,3)>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Interaction between GD vs ID Among Face-Responsive Neurons',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
set(gca,'FontSize',7); legend('Sig','NonSig');

%%% Single Example?

jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig6.1_GDxID_Faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig6.1_GDxID_Faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 7 - Interaction between Facial Expression and Gaze Direction %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 7.1 - Interaction between Facial Expression and Gaze Direction')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
subplot(3,1,1);
clear piedata
piedata(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05));
piedata(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Interaction between FE vs GD Among Face-Responsive Neurons',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
set(gca,'FontSize',7); legend('Sig','NonSig');
subplot(3,2,3); hold on % FE significant
pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05);
bar(1:8,mean(xldata.avg_rsp(pointer,:)))
errorbar(1:8,mean(xldata.avg_rsp(pointer,:)),sem(xldata.avg_rsp(pointer,:)))
for ns=1:2:7,
    [p,h]=ranksum(xldata.avg_rsp(pointer,ns),xldata.avg_rsp(pointer,ns+1));
    text(ns+0.5,18,['p=',num2str(p,'%0.2g')])
end
ylabel('Average Response (sp/s)','FontSize',8); ylim([0 20])
set(gca,'XTickLabel',{'Neut_D','Neut_A','Threat_D','Threat_A','Fear_D','Fear_A','BodyP','Objects'},'FontSize',7,'XTick',1:8)
title(['Face Responsive Neurons exhibiting Significant effect of Facial Expression (n=',num2str(length(pointer)),')'],'FontSize',10)
subplot(3,2,4); hold on % FE significant
pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05);
bar(1:8,mean(xldata.norm_avg_rsp(pointer,:)))
errorbar(1:8,mean(xldata.norm_avg_rsp(pointer,:)),sem(xldata.norm_avg_rsp(pointer,:)))
for ns=1:2:7,
    [p,h]=ranksum(xldata.avg_rsp(pointer,ns),xldata.avg_rsp(pointer,ns+1));
    text(ns+0.5,1.3,['p=',num2str(p,'%0.2g')])
end
ylabel('Average Response (sp/s)','FontSize',8); ylim([0 1.4]);
set(gca,'XTickLabel',{'Neut_D','Neut_A','Threat_D','Threat_A','Fear_D','Fear_A','BodyP','Objects'},'FontSize',7,'XTick',1:8)
title(['Face Responsive Neurons exhibiting Significant effect of Facial Expression (n=',num2str(length(pointer)),')'],'FontSize',10)
subplot(3,2,5); hold on % FE not significant
pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)>=0.05);
bar(1:8,mean(xldata.avg_rsp(pointer,:)))
errorbar(1:8,mean(xldata.avg_rsp(pointer,:)),sem(xldata.avg_rsp(pointer,:)))
for ns=1:2:7,
    [p,h]=ranksum(xldata.avg_rsp(pointer,ns),xldata.avg_rsp(pointer,ns+1));
    text(ns+0.5,18,['p=',num2str(p,'%0.2g')])
end
ylabel('Average Response (sp/s)','FontSize',8); ylim([0 20])
set(gca,'XTickLabel',{'Neut_D','Neut_A','Threat_D','Threat_A','Fear_D','Fear_A','BodyP','Objects'},'FontSize',7,'XTick',1:8)
title(['Face Responsive Neurons NOT exhibiting significant effect of Facial Expression (n=',num2str(length(pointer)),')'],'FontSize',10)
subplot(3,2,6); hold on % FE not significant
pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)>=0.05);
bar(1:8,mean(xldata.norm_avg_rsp(pointer,:)))
errorbar(1:8,mean(xldata.norm_avg_rsp(pointer,:)),sem(xldata.norm_avg_rsp(pointer,:)))
for ns=1:2:7,
    [p,h]=ranksum(xldata.avg_rsp(pointer,ns),xldata.avg_rsp(pointer,ns+1));
    text(ns+0.5,1.3,['p=',num2str(p,'%0.2g')])
end
ylabel('Average Response (sp/s)','FontSize',8); ylim([0 1.4]);
set(gca,'XTickLabel',{'Neut_D','Neut_A','Threat_D','Threat_A','Fear_D','Fear_A','BodyP','Objects'},'FontSize',7,'XTick',1:8)
title(['Face Responsive Neurons NOT exhibiting significant effect of Facial Expression (n=',num2str(length(pointer)),')'],'FontSize',10)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig7.1_FExGD_Faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig7.1_FExGD_Faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 8 - Compare Critical Phases of Response %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 8.1 - Compare Critical Phases of Response')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
binsize=5;
subplot(2,2,1); hold on % Facial Expression (only SIG neurons)
pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
floatdata=f570_floatANOVA(hmiconfig,xldata,pointer,xrange,binsize);
[hax,h1,h2]=plotyy(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesND),xrange(1):binsize:xrange(end)-binsize,floatdata.anova(:,1));
xlabel('Time from Stimulus Onset (ms)','FontSize',[10])
title('Face Responsive Neurons with Significant FE Effect','FontSize',10,'FontWeight','Bold')
axes(hax(1)); hold on
plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesTD),'k-','LineWidth',1)
plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesFD),'r-','LineWidth',1)
set(h1,'LineStyle','-')
set(h2,'LineWidth',1)
ylabel('Mean Activity (sp/s)','FontSize',[8])
axes(hax(2)); hold on
plot(xrange,[0.05 0.05],'k:')
set(h2,'LineStyle','-','LineWidth',1); set(gca,'YLim',[0 0.50])
ylabel('p-value (ANOVA)','FontSize',[8])
subplot(2,2,2); hold on % Gaze Direction (only SIG neurons)
pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
floatdata=f570_floatANOVA(hmiconfig,xldata,pointer,xrange,binsize);
[hax,h1,h2]=plotyy(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesND),xrange(1):binsize:xrange(end)-binsize,floatdata.anova(:,2));
xlabel('Time from Stimulus Onset (ms)','FontSize',[10])
title('Face Responsive Neurons with Significant GD Effect','FontSize',10,'FontWeight','Bold')
axes(hax(1)); hold on
plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesFA),'r-','LineWidth',1)
set(h1,'LineStyle','-')
set(h2,'LineWidth',1)
ylabel('Mean Activity (sp/s)','FontSize',[8])
axes(hax(2)); hold on
plot(xrange,[0.05 0.05],'k:')
set(h2,'LineStyle','-','LineWidth',1); set(gca,'YLim',[0 0.50])
ylabel('p-value (ANOVA)','FontSize',[8])
% Normalized
binsize=20;
subplot(2,2,3); hold on % Facial Expression (only SIG neurons)
pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
floatdata=f570_floatANOVAnorm(hmiconfig,xldata,pointer,xrange,binsize);
[hax,h1,h2]=plotyy(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesND),xrange(1):binsize:xrange(end)-binsize,floatdata.anova(:,1));
xlabel('Time from Stimulus Onset (ms)','FontSize',[10])
title('Face Responsive Neurons with Significant FE Effect (Normalized)','FontSize',10,'FontWeight','Bold')
axes(hax(1)); hold on
plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesTD),'k-','LineWidth',1)
plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesFD),'r-','LineWidth',1)
set(h1,'LineStyle','-'); set(gca,'XLim',[-100 500])
set(h2,'LineWidth',1)
ylabel('Mean Activity (sp/s)','FontSize',[8])
axes(hax(2)); hold on
plot(xrange,[0.05 0.05],'k:')
set(h2,'LineStyle','-','LineWidth',1); set(gca,'YLim',[0 0.50],'XLim',[-100 500])
ylabel('p-value (ANOVA)','FontSize',[8])
subplot(2,2,4); hold on % Gaze Direction (only SIG neurons)
pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
floatdata=f570_floatANOVAnorm(hmiconfig,xldata,pointer,xrange,binsize);
[hax,h1,h2]=plotyy(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesND),xrange(1):binsize:xrange(end)-binsize,floatdata.anova(:,2));
xlabel('Time from Stimulus Onset (ms)','FontSize',[10])
title('Face Responsive Neurons with Significant GD Effect (Normalized)','FontSize',10,'FontWeight','Bold')
axes(hax(1)); hold on
plot(xrange(1):binsize:xrange(end)-binsize,mean(floatdata.facesNA),'r-','LineWidth',1)
set(h1,'LineStyle','-'); set(gca,'XLim',[-100 500])
set(h2,'LineWidth',1)
ylabel('Mean Activity (sp/s)','FontSize',[8])
axes(hax(2)); hold on
plot(xrange,[0.05 0.05],'k:')
set(h2,'LineStyle','-','LineWidth',1); set(gca,'YLim',[0 0.50],'XLim',[-100 500])
ylabel('p-value (ANOVA)','FontSize',[8])
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig8.1_floatANOVA_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig8.1_floatANOVA_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 9 - Multivariate Analysis %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figures 9.x - Multivariate analysis of discrimination')
f570_multivariate(hmiconfig,xldata,['AllNeurons-',monkeyname]);
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1);
f570_multivariate(hmiconfig,xldata,['FaceSelect-',monkeyname],pointer);
pointer=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05);
f570_multivariate(hmiconfig,xldata,['FaceResponsive-',monkeyname],pointer);
pointer=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface>=0.25);
f570_multivariate(hmiconfig,xldata,['NonResponsiveSensory-',monkeyname],pointer);
pointer=find(strcmp(xldata.confresptype,'Excite')==1 & strcmp(xldata.confneur,'Sensory')==1);
f570_multivariate(hmiconfig,xldata,['Excitatory-',monkeyname],pointer);
pointer=find(strcmp(xldata.confresptype,'Suppress')==1 & strcmp(xldata.confneur,'Sensory')==1);
f570_multivariate(hmiconfig,xldata,['Suppressed-',monkeyname],pointer);
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
f570_multivariate(hmiconfig,xldata,['FEsig-',monkeyname],pointer);
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.15);
f570_multivariate(hmiconfig,xldata,['FEnonsig-',monkeyname],pointer);
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
f570_multivariate(hmiconfig,xldata,['GDsig-',monkeyname],pointer);
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.15);
f570_multivariate(hmiconfig,xldata,['GDnonsig-',monkeyname],pointer);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 10 - Effect of Rich Stimulus %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 10.1 - Effect of Rich Stimulus')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
subplot(1,2,1);
clear piedata
piedata(1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
piedata(2)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Identity Selectivity Among Face-Responsive Neurons (FACES570 Neurons)',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
set(gca,'FontSize',7); legend('Sig','NonSig');
subplot(1,2,2);

%%% LOAD DATA FROM RSVP500 - CORRECT FOR # OF STIMULI

pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Identity Selectivity Among Face-Responsive Neurons (RSVP Neurons)',['(n=',num2str(sum(piedata)),')']},'FontSize',fontsize_med,'FontWeight','Bold')
set(gca,'FontSize',7); legend('Sig','NonSig');
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig9.1_RichStimulus_Faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig9.1_RichStimulus_Faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 11 - Effect of Facial Expression on Non-Face Responsive Neurons %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 11.1 - Effect of Facial Expression on Non-Face Responsive Neurons')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if strcmp(monkinitial,'B')==0,
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Question 12 - Timeline of Selectivity %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 12.1 - Timeline of Selectivity')
    figure; clf; cla; hold on %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
    clear temp pointerFR temp1 temp2 temp3 groupsize numunits groups
    pointerFR=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1);
    temp1=xldata.unit_number(pointerFR)'; temp2=xldata.anova_id(pointerFR)';
    groupsize=20; % groupings of neurons
    numunits=length(pointerFR); temp3=1:numunits';
    groups=1:groupsize:numunits;
    for gg=1:length(groups),
        temp(gg,1)=length(find(ismember(temp3,groups(gg):(groups(gg)+groupsize-1))==1 & temp2'<0.05));
        temp(gg,2)=temp(gg,1)/groupsize*100;
    end
    plot(groups,temp(:,2),'k-'); plot(groups,temp(:,2),'ks');
    xlabel('Number of Units','FontSize',fontsize_med); ylabel('% ID Sensitivity','FontSize',fontsize_med);
    title([monkeyname,' - Timeline'],'FontSize',fontsize_lrg)
    jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig12.1_Timeline_Faces570.jpg'];
    illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig12.1_Timeline_Faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure
end


if strcmp(monkinitial,'B')==0 & gridanal==1,
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Question 13 - Effects Within/Outside %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.1 - Effects Within/Outside')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);

%     disp('Figure 2.1 - Distribution of Neurons relative to Face Patches)')
%     figure; clf; cla; %
%     set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.5]); set(gca,'FontName','Arial','FontSize',8);
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
%     ylabel('Distance from interaural axis (mm)','fontsize',8);
%     xlabel('Distance from midline (mm)','fontsize',8);
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
%     ylabel('Distance from interaural axis (mm)','fontsize',8);
%     xlabel('Distance from midline (mm)','fontsize',8);
%     title({['Location of Face Patches'],['# Grids IN: ',num2str(prop_in)]},'FontSize',fontsize_med,'FontWeight','Bold')
%     colorbar('SouthOutside','FontSize',6)
%     jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig12.1pop_faces570_patches.jpg'];
%     illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig12.1pop_faces570_patches.ai'];
%     print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
%     print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.2 - Summary Statistics of In vs. Out Face Patch(es)')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.7 0.8]); set(gca,'FontName','Arial','FontSize',8);

    subplot(3,3,1); piedata=[]; % number of neurons in vs. out
    piedata(1)=length(find(ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(ismember(xldata.gridloc,facegrids)~=1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(A)Neurons Inside vs. Outside Face Patch'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('IN','OUT','Location','Best'); set(gca,'FontSize',7)
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
    legend('F','Bp','O','NR','Location','Best'); set(gca,'FontSize',7)
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
    legend('F','Bp','O','NR','Location','Best'); set(gca,'FontSize',7)
    subplot(3,3,4)
    % Face Selectivity Index of all face preferring neurons
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.cat_rsp_avg(pointer,:); indata=[];
    for nn=1:length(pointer), indata(nn)=(temp_indata(nn,1)-(0.5*sum(temp_indata(nn,2:3))))/(temp_indata(nn,1)+(0.5*sum(temp_indata(nn,2:3)))); end
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.cat_rsp_avg(pointer,:); outdata=[];
    for nn=1:length(pointer), outdata(nn)=(temp_outdata(nn,1)-(0.5*sum(temp_outdata(nn,2:3))))/(temp_outdata(nn,1)+(0.5*sum(temp_outdata(nn,2:3)))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Face Selectivity Index for Face-Preferring Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',7)
    ylabel('Face Selectivity Index')
    p=ranksum(outdata,indata);
    text(1.5,0.5,['P=',num2str(p,'%1.2g')],'FontSize',7)
    subplot(3,3,5) % valence effect
    % Facial Expression Selectivity Index of all face preferring neurons
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.expr_rsp_avg(pointer,:); indata=[];
    for nn=1:length(pointer), indata(nn)=abs((temp_indata(nn,1)-(max(temp_indata(nn,2:3))))/(temp_indata(nn,1)+(max(temp_indata(nn,2:3))))); end
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.expr_rsp_avg(pointer,:); outdata=[];
    for nn=1:length(pointer), outdata(nn)=abs((temp_outdata(nn,1)-(max(temp_outdata(nn,2:3))))/(temp_outdata(nn,1)+(max(temp_outdata(nn,2:3))))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Valence Effect for Face-Preferring Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',7)
    ylabel('abs(Valence Effect)')
    p=ranksum(outdata,indata);
    text(1.5,0.15,['P=',num2str(p,'%1.2g')],'FontSize',7)
    subplot(3,3,6) % gaze direction effect
    % Gaze Direction Sensitivity Selectivity Index of all face preferring neurons
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.gaze_rsp_avg(pointer,:); indata=[];
    for nn=1:length(pointer), indata(nn)=abs((temp_indata(nn,1)-temp_indata(nn,2))/(temp_indata(nn,1)+temp_indata(nn,2))); end
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.gaze_rsp_avg(pointer,:); outdata=[];
    for nn=1:length(pointer), outdata(nn)=abs((temp_outdata(nn,1)-temp_outdata(nn,2))/(temp_outdata(nn,1)+temp_outdata(nn,2))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Gaze Direction Index for Face-Preferring Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',7)
    ylabel('abs(Gaze Direction Sensitivity)')
    p=ranksum(outdata,indata);
    text(1.5,0.15,['P=',num2str(p,'%1.2g')],'FontSize',7)
    subplot(3,3,7)
    % Face Selectivity Index of all face preferring neurons
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.cat_rsp_avg(pointer,:); indata=[];
    for nn=1:length(pointer), indata(nn)=(temp_indata(nn,1)-(0.5*sum(temp_indata(nn,2:3))))/(temp_indata(nn,1)+(0.5*sum(temp_indata(nn,2:3)))); end
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.cat_rsp_avg(pointer,:); outdata=[];
    for nn=1:length(pointer), outdata(nn)=(temp_outdata(nn,1)-(0.5*sum(temp_outdata(nn,2:3))))/(temp_outdata(nn,1)+(0.5*sum(temp_outdata(nn,2:3)))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Face Selectivity Index for Face-Responsive Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',7)
    ylabel('Face Selectivity Index')
    p=ranksum(outdata,indata);
    text(1.5,0.5,['P=',num2str(p,'%1.2g')],'FontSize',7)
    subplot(3,3,8) % valence effect
    % Facial Expression Selectivity Index of all face preferring neurons
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.expr_rsp_avg(pointer,:); indata=[];
    for nn=1:length(pointer), indata(nn)=abs((temp_indata(nn,1)-(max(temp_indata(nn,2:3))))/(temp_indata(nn,1)+(max(temp_indata(nn,2:3))))); end
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.expr_rsp_avg(pointer,:); outdata=[];
    for nn=1:length(pointer), outdata(nn)=abs((temp_outdata(nn,1)-(max(temp_outdata(nn,2:3))))/(temp_outdata(nn,1)+(max(temp_outdata(nn,2:3))))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Valence Effect for Face-Responsive Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',7)
    ylabel('abs(Valence Effect)')
    p=ranksum(outdata,indata);
    text(1.5,0.15,['P=',num2str(p,'%1.2g')],'FontSize',7)
    subplot(3,3,9) % gaze direction effect
    % Gaze Direction Sensitivity Selectivity Index of all face preferring neurons
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    temp_indata=xldata.gaze_rsp_avg(pointer,:); indata=[];
    for nn=1:length(pointer), indata(nn)=abs((temp_indata(nn,1)-temp_indata(nn,2))/(temp_indata(nn,1)+temp_indata(nn,2))); end
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    temp_outdata=xldata.gaze_rsp_avg(pointer,:); outdata=[];
    for nn=1:length(pointer), outdata(nn)=abs((temp_outdata(nn,1)-temp_outdata(nn,2))/(temp_outdata(nn,1)+temp_outdata(nn,2))); end
    hold on
    bar(1:2,[mean(indata) mean(outdata)])
    errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
    title({'Gaze Direction Index for Face-Responsive Neurons','Inside vs. Outside Patches'},'FontSize',fontsize_med)
    xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',7)
    ylabel('abs(Gaze Direction Sensitivity)')
    p=ranksum(outdata,indata);
    text(1.5,0.15,['P=',num2str(p,'%1.2g')],'FontSize',7)
    jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.2pop_patch_faces570.jpg'];
    illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.2pop_patch_faces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.3 - Social Effects Statistics of In vs. Out Face Patch(es) -- ALL FACE RESPONSIVE NEURONS')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);
    subplot(3,2,1); piedata=[]; % FE inside patch
    [junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
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
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,2); piedata=[]; % FE inside patch
    [junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
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
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,3); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA IN PATCH(All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,4); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_gd'<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA OUT PATCH (All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,5); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_id'>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_id'<0.05 & ismember(xldata.gridloc,facegrids)==1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA IN PATCH(All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,6); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_id'>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_id'<0.05 & ismember(xldata.gridloc,facegrids)~=1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA OUT PATCH (All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
    jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.3pop_patchfaces570.jpg'];
    illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.3pop_patchfaces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.4 - Social Effects Statistics of In vs. Out Face Patch(es) _Face Pref Neurons Only')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);
    subplot(3,2,1); piedata=[]; % FE inside patch
    [junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
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
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,2); piedata=[]; % FE inside patch
    [junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
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
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,3); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA IN PATCH(Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,4); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA OUT PATCH (Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,5); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id<0.05 & ismember(xldata.gridloc,facegrids)==1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA IN PATCH(Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,6); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id<0.05 & ismember(xldata.gridloc,facegrids)~=1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA OUT PATCH (Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
    jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.4pop_facespatch570.jpg'];
    illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.4pop_facespatch570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.5 - Social Effects Statistics of In vs. Out Face Patch(es) _Only Face-Responsive, no face pref Neurons Only')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);
    subplot(3,2,1); piedata=[]; % FE inside patch
    [junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
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
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,2); piedata=[]; % FE inside patch
    [junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
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
    legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,3); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA IN PATCH(only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,4); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
    piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_gaze<0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(B) GD ANOVA OUT PATCH (only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,5); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_id>=0.05 & ismember(xldata.gridloc,facegrids)==1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_id<0.05 & ismember(xldata.gridloc,facegrids)==1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA IN PATCH(only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
    subplot(3,2,6); piedata=[]; % GD inside patch
    [junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
    piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_id>=0.05 & ismember(xldata.gridloc,facegrids)~=1));
    piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<0.05 & xldata.anova_id<0.05 & ismember(xldata.gridloc,facegrids)~=1));
    pie(piedata,...
        {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
        ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
    title(['(C) ID ANOVA OUT PATCH (only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
    legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
    jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.5pop_facespatch570.jpg'];
    illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.5pop_facespatch570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.6 - Facial Expression Magnitude Effect')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);
    subplot(3,4,1); % average magnitude for face-preferring neurons (IN)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('Face Pref (IN) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,2); % average magnitude for face-preferring neurons (OUT)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('Face Pref (OUT) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,3); % average magnitude for face-preferring neurons (IN)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('Face Pref (IN) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 1.7])
    subplot(3,4,4); % average magnitude for face-preferring neurons (OUT)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('Face Pref (OUT) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 1.7])
    subplot(3,4,5); % average magnitude for face-responsive neurons (IN)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('Face Resp (IN) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,6); % average magnitude for face-responsive neurons (OUT)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('Face Resp (OUT) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,7); % average magnitude for face-responsive neurons (IN)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('Face Resp (IN) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 1.7])
    subplot(3,4,8); % average magnitude for face-responsive neurons (OUT)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('Face Resp (OUT) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 1.7])
    subplot(3,4,9); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('NonFace (IN) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,10); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:3)))
    errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('NonFace (OUT) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,11); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('NonFace (IN) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 1.7])
    subplot(3,4,12); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.expr_rsp_avg(pointer,:);
    bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
    hold on
    bar(mean(bardata(:,4:6)))
    errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
    ylabel('Normalized Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
    title('NonFace (OUT) - FE','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,2),bardata(:,3));
    text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    [p,h]=signrank(bardata(:,1),bardata(:,3));
    text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 1.7])
    jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.6pop_patchfaces570.jpg'];
    illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.6pop_patchfaces570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Figure 13.7 - Gaze Direction Magnitude Effect')
    figure; clf; cla; %
    set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);
    subplot(3,4,1); % average magnitude for face-preferring neurons (IN)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('Face Pref (IN) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,2); % average magnitude for face-preferring neurons (OUT)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('Face Pref (OUT) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,3); % average magnitude for face-preferring neurons (IN)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('Face Pref (IN) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 1.7])
    subplot(3,4,4); % average magnitude for face-preferring neurons (OUT)
    pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('Face Pref (OUT) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 1.7])
    subplot(3,4,5); % average magnitude for face-responsive neurons (IN)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('Face Resp (IN) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,6); % average magnitude for face-responsive neurons (OUT)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('Face Resp (OUT) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,7); % average magnitude for face-responsive neurons (IN)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('Face Resp (IN) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 1.7])
    subplot(3,4,8); % average magnitude for face-responsive neurons (OUT)
    pointer=find(xldata.validface<0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('Face Resp (OUT) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 1.7])
    subplot(3,4,9); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('NonFace (IN) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,10); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    hold on
    bar(mean(bardata(:,1:2)))
    errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('NonFace (OUT) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0 25])
    subplot(3,4,11); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('NonFace (IN) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 2.7])
    subplot(3,4,12); % average magnitude for non-face responsive (IN)
    pointer=find(xldata.validface>=0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
    bardata=xldata.gaze_rsp_avg(pointer,:);
    bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
    hold on
    bar(mean(bardata(:,3:4)))
    errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
    ylabel('Average Response (sp/s)','FontSize',8);
    set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
    title('NonFace (OUT) - GD','FontSize',10)
    [p,h]=signrank(bardata(:,1),bardata(:,2));
    text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
    ylim([0.7 2.7])
    jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.7pop_gazedirectionpatch570.jpg'];
    illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig13.7pop_gazedirectionpatch570.ai'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure
end % end grid anal

return


%%% OLD CODE %%%

%% After this, only works on single monkeys (spike density functions, etc.)

%     
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     disp('Figure 8 - Average spike density functions for non face responsive neurons - facial expression')
%     figure; clf; cla; %
%     set(gcf,'Units','Normalized','Position',[0.2 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
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
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Tuning (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     %%% Facial Expression
%     subplot(4,4,2); hold on % sig 
%     plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(3,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(5,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     subplot(4,4,4); hold on % sig 
%     plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(11,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(13,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 1]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     % NON SIG
%     clear avgfunc semfunc
%     subplot(4,4,5); hold on % neuron tuning
%     [avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange);
%     plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%     plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Tuning (non F-Resp, Bodypart Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     %%% Facial Expression
%     subplot(4,4,6); hold on % non sig 
%     plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(3,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(5,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Bodypart Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     subplot(4,4,8); hold on % non sig 
%     plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(11,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(13,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 1]); xlim([-100 400]);
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
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Tuning (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     %%% Facial Expression
%     subplot(4,4,10); hold on % sig 
%     plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(3,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(5,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     subplot(4,4,12); hold on % sig 
%     plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(11,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(13,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 1]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     % NON SIG
%     subplot(4,4,13); hold on % neuron tuning
%     [avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange);
%     plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%     plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Tuning (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%     %%% Facial Expression
%     subplot(4,4,14); hold on % non sig 
%     plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(3,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(5,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     subplot(4,4,16); hold on % non sig 
%     plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%     plot(xrange(1):xrange(2),avgfunc(11,:),'b-','LineWidth',1.5) % threat
%     plot(xrange(1):xrange(2),avgfunc(13,:),'r-','LineWidth',1.5) % fear grin
%     set(gca,'FontName','Arial','FontSize',7); ylim([0 1]); xlim([-100 400]);
%     xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%     title({'Facial Expression (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig8pop_avgspden_faces570.jpg'];
%     illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig8pop_avgspden_faces570.ai'];
%     print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
%     print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure
% 
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     disp('Figure 9 - Average spike density functions for non face responsive neurons - gaze direction')
%     figure; clf; cla; %
%     set(gcf,'Units','Normalized','Position',[0.2 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',8);
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
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Tuning (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         %%% Gaze Direction
%         subplot(4,4,2); hold on % sig
%         plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(2,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         subplot(4,4,4); hold on % sig
%         plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(10,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 1]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Bodypart Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         % NON SIG
%         clear avgfunc semfunc
%         subplot(4,4,5); hold on % neuron tuning
%         [avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange);
%         plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%         plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Tuning (non F-Resp, Bodypart Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%         %%% Gaze Direction
%         subplot(4,4,6); hold on % non sig
%         plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(2,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Bodypart Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%         subplot(4,4,8); hold on % non sig
%         plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(10,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 1]); xlim([-100 400]);
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
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Tuning (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         %%% Gaze Direction
%         subplot(4,4,10); hold on % sig
%         plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(2,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         subplot(4,4,12); hold on % sig
%         plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(10,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 1]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Object Neurons)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         % NON SIG
%         subplot(4,4,13); hold on % neuron tuning
%         [avgfunc semfunc]=f570_avg_spden(xldata,fepointerNS,hmiconfig,xrange);
%         plot(xrange(1):xrange(2),avgfunc(1,:),'r-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(7,:),'y-','LineWidth',1.5) % bodyparts
%         plot(xrange(1):xrange(2),avgfunc(8,:),'g-','LineWidth',1.5) % objects
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Tuning (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',fontsize_lrg)
%         %%% Gaze Direction
%         subplot(4,4,14); hold on % non sig
%         plot(xrange(1):xrange(2),avgfunc(1,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(2,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 30]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%         subplot(4,4,16); hold on % non sig
%         plot(xrange(1):xrange(2),avgfunc(9,:),'k-','LineWidth',1.5) % neutral face directed
%         plot(xrange(1):xrange(2),avgfunc(10,:),'b-','LineWidth',1.5) % neutral face averted
%         set(gca,'FontName','Arial','FontSize',7); ylim([0 1]); xlim([-100 400]);
%         xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); ylabel('Firing Rate (sp/s)','FontSize',fontsize_med)
%         title({'Gaze Direction (non F-Resp, Object Neurons)',['Nonsig Neurons (n=',num2str(length(fepointerNS)),')']},'FontSize',fontsize_lrg)
%     end
%     jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig9pop_avgspden_faces570.jpg'];
%     illfigname=[hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_Fig9pop_avgspden_faces570.ai'];
%     print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
%     print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure
% 
% 
% 

