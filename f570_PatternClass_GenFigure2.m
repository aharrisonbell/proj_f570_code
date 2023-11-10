function f570_PatternClass_GenFigure2(hmiconfig,figlabel,figurepath,cm,diagonals,graphlabel)
time_skip=hmiconfig.pClass_time_skip; 
time_range=hmiconfig.pClass_time_range;

%%% Step x - Load bootstrap data
load([hmiconfig.faces570spks,filesep,'AllNeurons-BothMonkeys-570_BootStrap.mat'])

normdist=mean(abs(cm_rho));
normdist_fish=mean(abs(cm_fish));
clear cm_pval cm_rho cm_fish


%% DIFFERENCES
figure; clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.1 0.1 0.8 0.8]); set(gca,'FontName','Arial')
% Effect of adding face stimuli (AFvsNF VS. FvsNF)
subplot(2,5,1); hold on; colormap jet
pcolor(time_range(1:end-1),time_range(1:end-1),(cm.AFvNF_Fish - cm.FvNF_Fish))
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title({'Effect of Extra Face Stimuli',[figlabel,'-',graphlabel]},'FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([-0.75 0.75]);

% Comparing the influence of Gaze Direction on Expression
subplot(2,5,2); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),(cm.TDvTA_Fish - cm.NDvNA_Fish))
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('TDvTA_Fish - NDvNA_Fish','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([-0.75 0.75]);
subplot(2,5,3); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),(cm.FDvFA_Fish - cm.NDvNA_Fish))
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('FDvFA_Fish - NDvNA_Fish','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([-0.75 0.75]);

% Comparing the influence of Expression on Gaze Direction
subplot(2,5,4); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),(cm.NDvTD_Fish - cm.NAvTA_Fish))
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('TDvND_Fish - TAvNA_Fish','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([-0.75 0.75]);
subplot(2,5,5); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),(cm.NDvFD_Fish - cm.NAvFA_Fish))
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title({'FDvND_Fish - FAvNA_Fish',[figlabel,'-',graphlabel]},'FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([-0.75 0.75]);

% Effect of adding face stimuli (AFvsNF VS. FvsNF)
subplot(2,5,6); hold on
plot(time_range(1:end-1),(diagonals.Fish(1,:)-diagonals.Fish(2,:)),'k-','LineWidth',2); % AFvNF - FvNF
plot([-100 500],[0 0],'k:','LineWidth',0.5); plot([0 0],[-1 1],'k:','LineWidth',0.5); 
xlim([-100 500]); ylim([-1 1]);
title('AFvsNF VS. FvsNF (Diagonals)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Classifier Index','FontSize',10)

subplot(2,5,7); hold on
plot(time_range(1:end-1),(diagonals.Fish(4,:)-diagonals.Fish(3,:)),'r-','LineWidth',2); % TDvTA - NDvNA
plot(time_range(1:end-1),(diagonals.Fish(5,:)-diagonals.Fish(3,:)),'b-','LineWidth',2); % FDvFA - NDvNA
plot([-100 500],[0 0],'k:','LineWidth',0.5); plot([0 0],[-1 1],'k:','LineWidth',0.5); 
xlim([-100 500]); ylim([-1 1]);
title('TDvTA_Fish - NDvNA_Fish (Diagonals)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Classifier Index','FontSize',10)

subplot(2,5,9); hold on
plot(time_range(1:end-1),(diagonals.Fish(6,:)-diagonals.Fish(7,:)),'r-','LineWidth',2); % TDvND - TAvNA
plot(time_range(1:end-1),(diagonals.Fish(8,:)-diagonals.Fish(9,:)),'b-','LineWidth',2); % FDvND - FAvNA
plot([-100 500],[0 0],'k:','LineWidth',0.5); plot([0 0],[-1 1],'k:','LineWidth',0.5); 
xlim([-100 500]); ylim([-1 1]);
title('TDvND_Fish - TAvNA_Fish (Diagonals)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Classifier Index','FontSize',10)

jpgfigname=[figurepath,filesep,figlabel,'-',graphlabel,'.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
return
