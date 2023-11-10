function f570_graphLFP(hmiconfig,filename,chan,lfpstruct,xscale)
fontsize_sml=7;
fontsize_med=8;
xscale=lfpstruct.xscale;
figure; clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial')

subplot(4,4,[1 5 9 13])
plotorder=[hmiconfig.facesND570 hmiconfig.facesNA570 hmiconfig.facesTD570 hmiconfig.facesTA570 hmiconfig.facesFD570 hmiconfig.facesFA570 hmiconfig.bodyp570 hmiconfig.objct570];
pcolor(xscale(1):xscale(2),1:88,lfpstruct.lfp_average(plotorder,:))
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
title([filename,'-',char(lfpstruct.label),' - All Categories'],'FontSize',11,'FontWeight','Bold')

subplot(4,4,2); hold on
plot(xscale(1):xscale(2),lfpstruct.faces_avg(1,:),'k-','LineWidth',1)
plot(xscale(1):xscale(2),lfpstruct.faces_avg(2,:),'k:','LineWidth',1)
set(gca,'YDir','reverse'); xlim(xscale); h=axis; plot([0 0],[h(3) h(4)],'k:');
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
title('Neutral Faces','FontSize',fontsize_med);

subplot(4,4,6); hold on
plot(xscale(1):xscale(2),lfpstruct.faces_avg(3,:),'r-','LineWidth',1)
plot(xscale(1):xscale(2),lfpstruct.faces_avg(4,:),'r:','LineWidth',1)
set(gca,'YDir','reverse'); xlim(xscale); h=axis; plot([0 0],[h(3) h(4)],'k:');
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
title('Threat Faces','FontSize',fontsize_med);

subplot(4,4,10); hold on
plot(xscale(1):xscale(2),lfpstruct.faces_avg(5,:),'b-','LineWidth',1)
plot(xscale(1):xscale(2),lfpstruct.faces_avg(6,:),'b:','LineWidth',1)
set(gca,'YDir','reverse'); xlim(xscale); h=axis; plot([0 0],[h(3) h(4)],'k:');
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
title('Fear Grin Faces','FontSize',fontsize_med);

subplot(4,4,14); hold on
plot(xscale(1):xscale(2),lfpstruct.faces_avg(7,:),'y-','LineWidth',1)
plot(xscale(1):xscale(2),lfpstruct.faces_avg(8,:),'g:','LineWidth',1)
set(gca,'YDir','reverse'); xlim(xscale); h=axis; plot([0 0],[h(3) h(4)],'k:');
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
title('Bodyparts/Objects','FontSize',fontsize_med);

% spectrograms - multitaper
subplot(4,4,3)
tmp=log(abs(squeeze(lfpstruct.cat_specgramMT_S_noB(1,:,:))));
pcolor((lfpstruct.cat_specgramMT_T(1,:)-0.4)*1000,lfpstruct.cat_specgramMT_F(1,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-200 500]); ylim([0 125]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('Neutral - Directed (multitaper)','FontSize',fontsize_med); colormap(jet);
subplot(4,4,4)
tmp=log(abs(squeeze(lfpstruct.cat_specgramMT_S_noB(2,:,:))));
pcolor((lfpstruct.cat_specgramMT_T(1,:)-0.4)*1000,lfpstruct.cat_specgramMT_F(1,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-200 500]); ylim([0 125]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('Neutral - Averted (multitaper)','FontSize',fontsize_med);
subplot(4,4,7)
tmp=log(abs(squeeze(lfpstruct.cat_specgramMT_S_noB(3,:,:))));
pcolor((lfpstruct.cat_specgramMT_T(1,:)-0.4)*1000,lfpstruct.cat_specgramMT_F(1,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-200 500]); ylim([0 125]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('Threat - Directed (multitaper)','FontSize',fontsize_med);
subplot(4,4,8)
tmp=log(abs(squeeze(lfpstruct.cat_specgramMT_S_noB(4,:,:))));
pcolor((lfpstruct.cat_specgramMT_T(1,:)-0.4)*1000,lfpstruct.cat_specgramMT_F(1,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-200 500]); ylim([0 125]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('Threat - Averted (multitaper)','FontSize',fontsize_med);
subplot(4,4,11)
tmp=log(abs(squeeze(lfpstruct.cat_specgramMT_S_noB(5,:,:))));
pcolor((lfpstruct.cat_specgramMT_T(1,:)-0.4)*1000,lfpstruct.cat_specgramMT_F(1,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-200 500]); ylim([0 125]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('Fear Grin - Directed (multitaper)','FontSize',fontsize_med); colormap(jet);
subplot(4,4,12)
tmp=log(abs(squeeze(lfpstruct.cat_specgramMT_S_noB(6,:,:))));
pcolor((lfpstruct.cat_specgramMT_T(1,:)-0.4)*1000,lfpstruct.cat_specgramMT_F(1,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-200 500]); ylim([0 125]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('Fear Grin - Averted (multitaper)','FontSize',fontsize_med);
subplot(4,4,15)
tmp=log(abs(squeeze(lfpstruct.cat_specgramMT_S_noB(7,:,:))));
pcolor((lfpstruct.cat_specgramMT_T(1,:)-0.4)*1000,lfpstruct.cat_specgramMT_F(1,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-200 500]); ylim([0 125]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('Bodyparts (multitaper)','FontSize',fontsize_med);
subplot(4,4,16)
tmp=log(abs(squeeze(lfpstruct.cat_specgramMT_S_noB(8,:,:))));
pcolor((lfpstruct.cat_specgramMT_T(1,:)-0.4)*1000,lfpstruct.cat_specgramMT_F(1,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-200 500]); ylim([0 125]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('Objects (multitaper)','FontSize',fontsize_med);


%matfigname=[hmiconfig.figure_dir,'faces570lfps',filesep,filename,'_570_',char(lfpstruct.label),'.fig'];
jpgfigname=[hmiconfig.figure_dir,'faces570lfps',filesep,filename,'_570_',char(lfpstruct.label),'.jpg'];
%illfigname=[hmiconfig.figure_dir,'faces570lfps',filesep,filename,'_570_',char(lfpstruct.label),'.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
%print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure
%hgsave(matfigname);
if hmiconfig.printer==1, % prints the figure to the default printer (if printer==1)
    print
end
return






























% Evoked Potentials (by block)
subplot(4,5,1); hold on % 
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(1,:),'r-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(6,:),'r-','LineWidth',2)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(11,:),'b-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(16,:),'b-','LineWidth',2)
xlabel('Time from cue onset (ms)','FontSize',fontsize_med); xlim([-100 1200]);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
set(gca,'YDir','reverse'); h=axis; plot([0 0],[h(3) h(4)],'k:'); title({[filename,'-',char(lfpstruct.label)],'100% Fruit'},'FontSize',fontsize_med)

subplot(4,5,2); hold on % 
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(2,:),'r-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(7,:),'r-','LineWidth',2)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(12,:),'b-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(17,:),'b-','LineWidth',2)
xlabel('Time from cue onset (ms)','FontSize',fontsize_med); title('75% Fruit'); xlim([-100 1200]);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
set(gca,'YDir','reverse'); h=axis; plot([0 0],[h(3) h(4)],'k:');

subplot(4,5,3); hold on % 
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(3,:),'r-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(8,:),'r-','LineWidth',2)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(13,:),'b-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(18,:),'b-','LineWidth',2)
xlabel('Time from cue onset (ms)','FontSize',fontsize_med); title('50% Fruit'); xlim([-100 1200]);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
set(gca,'YDir','reverse'); h=axis; plot([0 0],[h(3) h(4)],'k:');

subplot(4,5,4); hold on % 
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(4,:),'r-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(9,:),'r-','LineWidth',2)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(14,:),'b-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(19,:),'b-','LineWidth',2)
xlabel('Time from cue onset (ms)','FontSize',fontsize_med); title('75% Face'); xlim([-100 1200]);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
set(gca,'YDir','reverse'); h=axis; plot([0 0],[h(3) h(4)],'k:');

subplot(4,5,5); hold on % 
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(5,:),'r--','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(10,:),'r-','LineWidth',2)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(15,:),'b-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(20,:),'b-','LineWidth',2)
xlabel('Time from cue onset (ms)','FontSize',fontsize_med); title('100% Face'); xlim([-100 1200]);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
set(gca,'YDir','reverse'); h=axis; plot([0 0],[h(3) h(4)],'k:');

% Evoked Potentials (by stimulus)
subplot(4,4,5); hold on
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(6,:),'r-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(7,:),'b-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(8,:),'g-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(9,:),'k-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(10,:),'m-','LineWidth',1)
xlabel('Time from cue onset (ms)','FontSize',fontsize_med); title('Face Trials (Correct)'); xlim([-100 1200]);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
set(gca,'YDir','reverse'); h=axis; plot([0 0],[h(3) h(4)],'k:');

subplot(4,4,6); hold on
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(1,:),'r-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(2,:),'b-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(3,:),'g-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(4,:),'k-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(5,:),'m-','LineWidth',1)
xlabel('Time from cue onset (ms)','FontSize',fontsize_med); title('Face Trials (Incorrect)'); xlim([-100 1200]);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
set(gca,'YDir','reverse'); h=axis; plot([0 0],[h(3) h(4)],'k:');

subplot(4,4,7); hold on
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(16,:),'r-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(17,:),'b-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(18,:),'g-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(19,:),'k-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(20,:),'m-','LineWidth',1)
xlabel('Time from cue onset (ms)','FontSize',fontsize_med); title('Fruit Trials (Correct)'); xlim([-100 1200]);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
set(gca,'YDir','reverse'); h=axis; plot([0 0],[h(3) h(4)],'k:');

subplot(4,4,8); hold on
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(11,:),'r-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(12,:),'b-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(13,:),'g-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(14,:),'k-','LineWidth',1)
plot(epochs.LFP_range(1):epochs.LFP_range(2),lfpstruct.type_average(15,:),'m-','LineWidth',1)
xlabel('Time from cue onset (ms)','FontSize',fontsize_med); title('Fruit Trials (Incorrect)'); xlim([-100 1200]);
ylabel('Voltage (mV)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); box off;
set(gca,'YDir','reverse'); h=axis; plot([0 0],[h(3) h(4)],'k:');



% Spectrograms (Correct vs. Incorrect)
subplot(4,5,11)
tmp=log(abs(squeeze(lfpstruct.type_specgramMT_S_noB(6,:,:))));
pcolor((lfpstruct.type_specgramMT_T(6,:)-0.4)*1000,lfpstruct.type_specgramMT_F(6,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-300 1000]); ylim([0 120]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('%100 Fruit (Correct)','FontSize',fontsize_med); colormap(jet);
subplot(4,5,12)
tmp=log(abs(squeeze(lfpstruct.type_specgramMT_S_noB(7,:,:))));
pcolor((lfpstruct.type_specgramMT_T(7,:)-0.4)*1000,lfpstruct.type_specgramMT_F(7,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-300 1000]); ylim([0 120]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('%75 Fruit (Correct)','FontSize',fontsize_med);
subplot(4,5,13)
tmp=log(abs(squeeze(lfpstruct.type_specgramMT_S_noB(8,:,:))));
pcolor((lfpstruct.type_specgramMT_T(8,:)-0.4)*1000,lfpstruct.type_specgramMT_F(8,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-300 1000]); ylim([0 120]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('%50 Fruit (Correct)','FontSize',fontsize_med);
subplot(4,5,14)
tmp=log(abs(squeeze(lfpstruct.type_specgramMT_S_noB(9,:,:))));
pcolor((lfpstruct.type_specgramMT_T(9,:)-0.4)*1000,lfpstruct.type_specgramMT_F(9,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-300 1000]); ylim([0 120]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('%75 Face (Correct)','FontSize',fontsize_med);
subplot(4,5,15)
tmp=log(abs(squeeze(lfpstruct.type_specgramMT_S_noB(10,:,:))));
pcolor((lfpstruct.type_specgramMT_T(10,:)-0.4)*1000,lfpstruct.type_specgramMT_F(10,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-300 1000]); ylim([0 120]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('%100 Face (Correct)','FontSize',fontsize_med);

subplot(4,5,16)
tmp=log(abs(squeeze(lfpstruct.type_specgramMT_S_noB(1,:,:))));
pcolor((lfpstruct.type_specgramMT_T(1,:)-0.4)*1000,lfpstruct.type_specgramMT_F(1,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-300 1000]); ylim([0 120]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('%100 Fruit (Incorrect)','FontSize',fontsize_med); colormap(jet);
subplot(4,5,17)
tmp=log(abs(squeeze(lfpstruct.type_specgramMT_S_noB(2,:,:))));
pcolor((lfpstruct.type_specgramMT_T(2,:)-0.4)*1000,lfpstruct.type_specgramMT_F(2,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-300 1000]); ylim([0 120]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('%75 Fruit (Incorrect)','FontSize',fontsize_med);
subplot(4,5,18)
tmp=log(abs(squeeze(lfpstruct.type_specgramMT_S_noB(3,:,:))));
pcolor((lfpstruct.type_specgramMT_T(3,:)-0.4)*1000,lfpstruct.type_specgramMT_F(3,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-300 1000]); ylim([0 120]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('%50 Fruit (Incorrect)','FontSize',fontsize_med);
subplot(4,5,19)
tmp=log(abs(squeeze(lfpstruct.type_specgramMT_S_noB(4,:,:))));
pcolor((lfpstruct.type_specgramMT_T(4,:)-0.4)*1000,lfpstruct.type_specgramMT_F(4,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-300 1000]); ylim([0 120]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('%75 Face (Incorrect)','FontSize',fontsize_med);
subplot(4,5,20)
tmp=log(abs(squeeze(lfpstruct.type_specgramMT_S_noB(5,:,:))));
pcolor((lfpstruct.type_specgramMT_T(5,:)-0.4)*1000,lfpstruct.type_specgramMT_F(5,:),tmp'); shading flat;
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-300 1000]); ylim([0 120]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('%100 Face (Incorrect)','FontSize',fontsize_med);







% anova spect
subplot(4,4,10)
hold on
pcolor((lfpstruct.type_specgramMT_T(1,:)-0.4)*1000,lfpstruct.type_specgramMT_F(1,:),lfpstruct.mtspect_anova'); shading flat;
plot([0 0],[0 120],'k:')
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-200 400]); ylim([0 125]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('Anova on Category (no Fruit)','FontSize',fontsize_med); cmap_anova; caxis([0 0.05]); colorbar('SouthOutside')

% ttest spect sample
subplot(4,4,14)
hold on
pcolor((lfpstruct.type_specgramMT_T(1,:)-0.4)*1000,lfpstruct.type_specgramMT_F(1,:),squeeze(lfpstruct.mtspect_ttest(3,:,:))'); shading flat;
plot([0 0],[0 120],'k:')
xlabel('Time from stimulus onset (ms)','FontSize',fontsize_med); xlim([-200 400]); ylim([0 125]);
ylabel('Frequency (Hz)','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med);
title('Sample TTest (Faces vs. Places))','FontSize',fontsize_med); cmap_anova; caxis([0 0.05]); colorbar('SouthOutside')


%matfigname=[hmiconfig.figure_dir,'rsvp500lfps',filesep,fname,'_rsvp500_',char(lfpstruct.label),'.fig'];
jpgfigname=[hmiconfig.figure_dir,'rsvp500lfps',filesep,fname,'_rsvp500_',char(lfpstruct.label),'.jpg'];
%illfigname=[hmiconfig.figure_dir,'rsvp500lfps',filesep,fname,'_rsvp500_',char(lfpstruct.label),'.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
%print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure
%hgsave(matfigname);
if hmiconfig.printer==1, % prints the figure to the default printer (if printer==1)
    print
end

return