function f570_PatternClass_GenFigure(hmiconfig,figlabel,figurepath,cm,diagonals,graphlabel)
% updated Oct 2012
time_skip=hmiconfig.pClass_time_skip; 
time_range=hmiconfig.pClass_time_range;

%%% Step x - Load bootstrap data
load([hmiconfig.faces570spks,filesep,'AllNeurons-BothMonkeys-570_BootStrap.mat'])

normdist=mean(abs(cm_rho));
normdist_fish=mean(abs(cm_fish));
clear cm_pval cm_rho cm_fish

figure; clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.1 0.1 0.8 0.8]); set(gca,'FontName','Arial')
subplot(3,6,1); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.AFvNF_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title({'All Faces vs. NonFaces',[figlabel,'-',graphlabel]},'FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
% plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); 
colorbar('SouthOutside'); caxis([0 1]); set(gca,'FontSize',7)

subplot(3,6,2); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.FvNF_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title({'Faces(ND) vs. NonFaces',[figlabel,'-',graphlabel]},'FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
% plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:');
colorbar('SouthOutside'); caxis([0 1]); set(gca,'FontSize',7)

subplot(3,6,3); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.avgExpression_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('Neu vs. Expr (Dir-only)','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
% plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:');
colorbar('SouthOutside'); caxis([0 1]); set(gca,'FontSize',7)

subplot(3,6,4); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.NDvNA_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('Neut-Dir vs. Neut-Avert','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
% plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); 
colorbar('SouthOutside'); caxis([0 1]); set(gca,'FontSize',7)

subplot(3,6,5); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.IDmin_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title({'Random ID Selection',[figlabel,'-',graphlabel]},'FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
% plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:');
colorbar('SouthOutside'); caxis([0 1]); set(gca,'FontSize',7)

subplot(3,6,6); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.BPvOB_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title({'Bodyparts v Objects',[figlabel,'-',graphlabel]},'FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
% plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:');
colorbar('SouthOutside'); caxis([0 1]); set(gca,'FontSize',7)

subplot(3,7,8); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.TDvTA_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('Threat-Dir v Threat-Avert','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])
subplot(3,7,9); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.FDvFA_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('Fear-Dir v Fear-Avert','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])
subplot(3,7,10); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.NDvTD_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('Neut-Dir v Threat-Dir','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])
subplot(3,7,11); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.NAvTA_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('Neut-Avert v Threat-Avert','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])
subplot(3,7,12); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.NDvFD_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('Neut-Dir v Fear-Dir','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])
subplot(3,7,13); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.NAvFA_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('Neut-Avert v Fear-Avert','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])
subplot(3,7,14); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),cm.ID_Fish)
shading flat; axis square; xlim([-100 400]); ylim([-100 400])
title('ID Contrasts','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 400],'w:'); plot([-100 400],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])

% plot diagonals
subplot(3,3,7); hold on
plx_shade_spden(time_range(1:end-1),diagonals.Fish(1,:),normdist,0.25,'k'); % all face vs non-face 
plx_shade_spden(time_range(1:end-1),diagonals.Fish(2,:),normdist,0.25,'m'); % face vs. non-face
plx_shade_spden(time_range(1:end-1),diagonals.Fish(3,:),normdist,0.25,'b'); % gaze direction
plx_shade_spden(time_range(1:end-1),diagonals.Fish(14,:),normdist,0.25,'r'); % Expressions
plx_shade_spden(time_range(1:end-1),diagonals.Fish(11,:),normdist,0.25,'g'); % Identity
plx_shade_spden(time_range(1:end-1),diagonals.Fish(12,:),normdist,0.25,'c'); % id min
plx_shade_spden(time_range(1:end-1),diagonals.Fish(13,:),normdist,0.25,'y'); % bodyparts vs objects
title({'Diagonals - Correlation Coefficients (r)',figlabel},'FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('AFvNF','','FvNF','','GD','','Expr','','ID','','IDmin','','BPvOb','');

subplot(3,3,8); hold on
plx_shade_spden(time_range(1:end-1),diagonals.Fish(3,:),normdist,0.25,'k'); % NDvsNA
plx_shade_spden(time_range(1:end-1),diagonals.Fish(4,:),normdist,0.25,'r'); % TDvsTA
plx_shade_spden(time_range(1:end-1),diagonals.Fish(5,:),normdist,0.25,'b'); % FDvsFA
title({'Expression Contrasts (r)',figlabel},'FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('NDvsNA','','TDvsTA','','FDvsFA','');

subplot(3,3,9); hold on
plx_shade_spden(time_range(1:end-1),diagonals.Fish(6,:),normdist,0.25,'k'); % NDvTD
plx_shade_spden(time_range(1:end-1),diagonals.Fish(7,:),normdist,0.25,'r'); % NAvTA
plx_shade_spden(time_range(1:end-1),diagonals.Fish(8,:),normdist,0.25,'b'); % NDvFD
plx_shade_spden(time_range(1:end-1),diagonals.Fish(9,:),normdist,0.25,'g'); % NAvFA
title({'Direction Contrasts (r)',figlabel},'FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',10)
ylabel('Pattern Classifier Index','FontSize',10)
xlim([-100 500]); ylim([0 2.5]);legend('NDvTD','','NAvTA','','NDvFD','','NAvFA','');

jpgfigname=[figurepath,filesep,figlabel,'-',graphlabel,'.jpg'];
epsfigname=[figurepath,filesep,figlabel,'-',graphlabel,'.eps'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig(sprintf(epsfigname), '-eps', '-rgb', '-transparent');

return
