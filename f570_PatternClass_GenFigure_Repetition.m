function f570_PatternClass_GenFigure_Repetition(hmiconfig,xldata,monkeyname,cm_all,cm_trials,figlabel,figurepath,reload,graphlabel)
% Function to create figure of bootstrap/repetition data

% load data

if reload~=1,
    neuron_pointer=1:637; % all neurons
    ALL_all=load([hmiconfig.faces570spks,filesep,monkeyname,'-All-570cm.mat']);
    ALL_10=f570_PatternClass_Contrasts_Boot(hmiconfig,cm_all,cm_trials,neuron_pointer,'All',10);
    ALL_50=f570_PatternClass_Contrasts_Boot(hmiconfig,cm_all,cm_trials,neuron_pointer,'All',50);
    ALL_100=f570_PatternClass_Contrasts_Boot(hmiconfig,cm_all,cm_trials,neuron_pointer,'All',100);
    ALL_300=f570_PatternClass_Contrasts_Boot(hmiconfig,cm_all,cm_trials,neuron_pointer,'All',300);
    
    neuron_pointer=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1);
    FACES_all=load([hmiconfig.faces570spks,filesep,monkeyname,'-FR-570cm.mat']);
    FACES_10=f570_PatternClass_Contrasts_Boot(hmiconfig,cm_all,cm_trials,neuron_pointer,'FR',10);
    FACES_50=f570_PatternClass_Contrasts_Boot(hmiconfig,cm_all,cm_trials,neuron_pointer,'FR',50);
    FACES_100=f570_PatternClass_Contrasts_Boot(hmiconfig,cm_all,cm_trials,neuron_pointer,'FR',100);
else
    ALL_all=load([hmiconfig.faces570spks,filesep,monkeyname,'-All-570cm.mat']);
    ALL_10=load([hmiconfig.faces570spks,filesep,'All10-570repdata.mat']);
    ALL_50=load([hmiconfig.faces570spks,filesep,'All50-570repdata.mat']);
    ALL_100=load([hmiconfig.faces570spks,filesep,'All100-570repdata.mat']);
    ALL_300=load([hmiconfig.faces570spks,filesep,'All300-570repdata.mat']);
    
    FACES_all=load([hmiconfig.faces570spks,filesep,monkeyname,'-FR-570cm.mat']);
    FACES_10=load([hmiconfig.faces570spks,filesep,'FR10-570repdata.mat']);
    FACES_50=load([hmiconfig.faces570spks,filesep,'FR50-570repdata.mat']);
    FACES_100=load([hmiconfig.faces570spks,filesep,'FR100-570repdata.mat']);
end



figuredata_fr=struct('average',zeros(4,13,60),'stddev',zeros(4,13,60));
figuredata_fr.average(1,:,:)=FACES_all.diagonalsNT.Fish(1,:);
figuredata_fr.average(2,:,:)=squeeze(mean(FACES_10.repdata,1));
figuredata_fr.average(3,:,:)=squeeze(mean(FACES_50.repdata,1));
figuredata_fr.average(4,:,:)=squeeze(mean(FACES_100.repdata,1));

figuredata_fr.stddev(2,:,:)=squeeze(std(FACES_10.repdata,1));
figuredata_fr.stddev(3,:,:)=squeeze(std(FACES_50.repdata,1));
figuredata_fr.stddev(4,:,:)=squeeze(std(FACES_100.repdata,1));

% Graph that bitch!
time_skip=hmiconfig.pClass_time_skip;
time_range=hmiconfig.pClass_time_range;

%%% Step x - Load bootstrap data
figure; clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.1 0.1 0.8 0.8]); set(gca,'FontName','Arial')
time_range=hmiconfig.pClass_time_range;
% Faces vs. Non Faces (diag row1)
subplot(2,2,1); hold on; col=1;
plot(time_range(1:end-1),ALL_all.diagonalsNT.Fish(col,:),'k-','LineWidth',1.0); % all
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_10.repdata(:,col,:))),std(squeeze(ALL_10.repdata(:,col,:))),0.25,'m'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_50.repdata(:,col,:))),std(squeeze(ALL_50.repdata(:,col,:))),0.25,'b'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_100.repdata(:,col,:))),std(squeeze(ALL_100.repdata(:,col,:))),0.25,'r'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_300.repdata(:,col,:))),std(squeeze(ALL_300.repdata(:,col,:))),0.25,'g'); % all face vs non-face 
title('Faces vs. Non-Faces (All Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','','n=300','');

%subplot(2,2,2); hold on
%plot(time_range(1:end-1),squeeze(figuredata_fr.average(1,1,:)),'k-','LineWidth',1.0); % all
%plx_shade_spden(time_range(1:end-1),squeeze(figuredata_fr.average(2,1,:))',squeeze(figuredata_fr.stddev(2,1,:))',0.25,'m'); % all face vs non-face 
%plx_shade_spden(time_range(1:end-1),squeeze(figuredata_fr.average(3,1,:))',squeeze(figuredata_fr.stddev(3,1,:))',0.25,'b'); % all face vs non-face 
%plx_shade_spden(time_range(1:end-1),squeeze(figuredata_fr.average(4,1,:))',squeeze(figuredata_fr.stddev(4,1,:))',0.25,'r'); % all face vs non-face 
%title('Faces vs. Non-Faces (Face Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
%xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
%ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','');

% Faces vs. Non Faces (min) (diag row2)
subplot(2,2,3); hold on; col=2;
plot(time_range(1:end-1),ALL_all.diagonalsNT.Fish(col,:),'k-','LineWidth',1.0); % all
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_10.repdata(:,col,:))),std(squeeze(ALL_10.repdata(:,col,:))),0.25,'m'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_50.repdata(:,col,:))),std(squeeze(ALL_50.repdata(:,col,:))),0.25,'b'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_100.repdata(:,col,:))),std(squeeze(ALL_100.repdata(:,col,:))),0.25,'r'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_300.repdata(:,col,:))),std(squeeze(ALL_300.repdata(:,col,:))),0.25,'g'); % all face vs non-face 
title('Faces* vs. Non-Faces (All Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','','n=300','');

subplot(2,2,4); hold on
plot(time_range(1:end-1),FACES_all.diagonalsNT.Fish(2,:),'k-','LineWidth',1.0); % all
plot(time_range(1:end-1), FACES_10.diagonalsNT.Fish(2,:),'m-','LineWidth',1.0); % 10
plot(time_range(1:end-1), FACES_50.diagonalsNT.Fish(2,:),'b-','LineWidth',1.0); % 50
plot(time_range(1:end-1),FACES_100.diagonalsNT.Fish(2,:),'r-','LineWidth',1.0); % 100
title('Faces* vs. Non-Faces (Face Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','');



figure; clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.1 0.1 0.8 0.8]); set(gca,'FontName','Arial')
% Neutral vs. Expressions (diag row10)
subplot(2,4,1); hold on; col=10;
plot(time_range(1:end-1),ALL_all.diagonalsNT.Fish(col,:),'k-','LineWidth',1.0); % all
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_10.repdata(:,col,:))),std(squeeze(ALL_10.repdata(:,col,:))),0.25,'m'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_50.repdata(:,col,:))),std(squeeze(ALL_50.repdata(:,col,:))),0.25,'b'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_100.repdata(:,col,:))),std(squeeze(ALL_100.repdata(:,col,:))),0.25,'r'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_300.repdata(:,col,:))),std(squeeze(ALL_300.repdata(:,col,:))),0.25,'g'); % all face vs non-face 
title('Neut v Expr (All Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','','n=300','');

subplot(2,4,2); hold on
plot(time_range(1:end-1),FACES_all.diagonalsNT.Fish(10,:),'k-','LineWidth',1.0); % all
plot(time_range(1:end-1), FACES_10.diagonalsNT.Fish(10,:),'m-','LineWidth',1.0); % 10
plot(time_range(1:end-1), FACES_50.diagonalsNT.Fish(10,:),'b-','LineWidth',1.0); % 50
plot(time_range(1:end-1),FACES_100.diagonalsNT.Fish(10,:),'r-','LineWidth',1.0); % 100
title('Neut v Expr (Face Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','');

% Directed vs. Averted (diag row3)
subplot(2,4,3); hold on; col=3;
plot(time_range(1:end-1),ALL_all.diagonalsNT.Fish(col,:),'k-','LineWidth',1.0); % all
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_10.repdata(:,col,:))),std(squeeze(ALL_10.repdata(:,col,:))),0.25,'m'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_50.repdata(:,col,:))),std(squeeze(ALL_50.repdata(:,col,:))),0.25,'b'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_100.repdata(:,col,:))),std(squeeze(ALL_100.repdata(:,col,:))),0.25,'r'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_300.repdata(:,col,:))),std(squeeze(ALL_300.repdata(:,col,:))),0.25,'g'); % all face vs non-face 
title('Gaze Directed (All Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','','n=300','');

subplot(2,4,4); hold on
plot(time_range(1:end-1),FACES_all.diagonalsNT.Fish(3,:),'k-','LineWidth',1.0); % all
plot(time_range(1:end-1), FACES_10.diagonalsNT.Fish(3,:),'m-','LineWidth',1.0); % 10
plot(time_range(1:end-1), FACES_50.diagonalsNT.Fish(3,:),'b-','LineWidth',1.0); % 50
plot(time_range(1:end-1),FACES_100.diagonalsNT.Fish(3,:),'r-','LineWidth',1.0); % 100
title('Gaze Directed (Face Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','');

% ID contrasts (diag row11)
subplot(2,4,5); hold on; col=11;
plot(time_range(1:end-1),ALL_all.diagonalsNT.Fish(col,:),'k-','LineWidth',1.0); % all
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_10.repdata(:,col,:))),std(squeeze(ALL_10.repdata(:,col,:))),0.25,'m'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_50.repdata(:,col,:))),std(squeeze(ALL_50.repdata(:,col,:))),0.25,'b'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_100.repdata(:,col,:))),std(squeeze(ALL_100.repdata(:,col,:))),0.25,'r'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_300.repdata(:,col,:))),std(squeeze(ALL_300.repdata(:,col,:))),0.25,'g'); % all face vs non-face 
title('ID contrasts (All Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','','n=300','');

subplot(2,4,6); hold on
plot(time_range(1:end-1),FACES_all.diagonalsNT.Fish(11,:),'k-','LineWidth',1.0); % all
plot(time_range(1:end-1), FACES_10.diagonalsNT.Fish(11,:),'m-','LineWidth',1.0); % 10
plot(time_range(1:end-1), FACES_50.diagonalsNT.Fish(11,:),'b-','LineWidth',1.0); % 50
plot(time_range(1:end-1),FACES_100.diagonalsNT.Fish(11,:),'r-','LineWidth',1.0); % 100
title('ID contrasts (Face Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','');

% ID contrasts (min) (diag row12)
subplot(2,4,7); hold on; col=12;
plot(time_range(1:end-1),ALL_all.diagonalsNT.Fish(col,:),'k-','LineWidth',1.0); % all
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_10.repdata(:,col,:))),std(squeeze(ALL_10.repdata(:,col,:))),0.25,'m'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_50.repdata(:,col,:))),std(squeeze(ALL_50.repdata(:,col,:))),0.25,'b'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_100.repdata(:,col,:))),std(squeeze(ALL_100.repdata(:,col,:))),0.25,'r'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_300.repdata(:,col,:))),std(squeeze(ALL_300.repdata(:,col,:))),0.25,'g'); % all face vs non-face 
title('ID contrasts* (All Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','','n=300','');

subplot(2,4,8); hold on
plot(time_range(1:end-1),FACES_all.diagonalsNT.Fish(12,:),'k-','LineWidth',1.0); % all
plot(time_range(1:end-1), FACES_10.diagonalsNT.Fish(12,:),'m-','LineWidth',1.0); % 10
plot(time_range(1:end-1), FACES_50.diagonalsNT.Fish(12,:),'b-','LineWidth',1.0); % 50
plot(time_range(1:end-1),FACES_100.diagonalsNT.Fish(12,:),'r-','LineWidth',1.0); % 100
title('ID contrasts* (Face Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','');

figure; clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.1 0.1 0.8 0.8]); set(gca,'FontName','Arial')
% Body-parts vs. Objects (diag row13)
subplot(2,2,1); hold on; col=13;
plot(time_range(1:end-1),ALL_all.diagonalsNT.Fish(col,:),'k-','LineWidth',1.0); % all
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_10.repdata(:,col,:))),std(squeeze(ALL_10.repdata(:,col,:))),0.25,'m'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_50.repdata(:,col,:))),std(squeeze(ALL_50.repdata(:,col,:))),0.25,'b'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_100.repdata(:,col,:))),std(squeeze(ALL_100.repdata(:,col,:))),0.25,'r'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),mean(squeeze(ALL_300.repdata(:,col,:))),std(squeeze(ALL_300.repdata(:,col,:))),0.25,'g'); % all face vs non-face 
title('BodyP v Obj (All Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','','n=300','');

subplot(2,2,2); hold on
plot(time_range(1:end-1),FACES_all.diagonalsNT.Fish(13,:),'k-','LineWidth',1.0); % all
plot(time_range(1:end-1), FACES_10.diagonalsNT.Fish(13,:),'m-','LineWidth',1.0); % 10
plot(time_range(1:end-1), FACES_50.diagonalsNT.Fish(13,:),'b-','LineWidth',1.0); % 50
plot(time_range(1:end-1),FACES_100.diagonalsNT.Fish(13,:),'r-','LineWidth',1.0); % 100
title('BodyP v Obj (Face Neurons)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('All','n=10','','n=50','','n=100','');



jpgfigname=[figurepath,filesep,figlabel,'-',graphlabel,'.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
% export_fig Faces570_Fig3_IntersectingPathways.eps -eps -transparent -rgb
return
