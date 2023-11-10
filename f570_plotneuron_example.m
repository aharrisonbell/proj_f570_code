function f570_plotneuron_example(hmiconfig,xscale,graphstruct,respstruct,fname)

figurepath='/Users/ab03/Documents/Manuscripts_Grants/Faces570/figure_source_images';

fontsize_sml=10; fontsize_med=12; fontsize_lrg=14;

warning off
%%% determining baseline %%%
avg_baseline=mean(respstruct.m_baseline); avg_baseline1=mean(respstruct.m_baseline);
figure
clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.1 0.1 0.5 0.8]); set(gca,'FontName','Arial')
xrange=(1000+xscale(1)):(1000+xscale(end));
subplot(3,2,[1 3 5]) % colour plot
plotorder=[hmiconfig.facesND570 hmiconfig.facesNA570 hmiconfig.facesTD570 hmiconfig.facesTA570 hmiconfig.facesFD570 hmiconfig.facesFA570 hmiconfig.bodyp570 hmiconfig.objct570];
pcolor(xscale,1:88,graphstruct.allconds_avg(plotorder,xrange))
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
text(xscale(1)-(abs(xscale(1))*.3),4,'Neutral (D)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.3),12,'Neutral (A)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.3),20,'Threat (D)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.3),28,'Threat (A)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.3),36,'Fear Grin (D)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.3),44,'Fear Grin (A)','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.3),58,'Bodyparts','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
text(xscale(1)-(abs(xscale(1))*.3),78,'Objects','FontSize',fontsize_med,'HorizontalAlignment','Center','Rotation',90)
set(gca,'FontSize',fontsize_sml); xlim([xscale(1) xscale(end)]); box off; axis off; axis ij; ylim([0 88]);
signame=char(graphstruct.label);

subplot(3,2,2) % CATEGORY effect, average spike density functions
hold on
plot(xscale,graphstruct.facesND_avg(xrange),'r-','LineWidth',2)
plot(xscale,graphstruct.bodyp_avg(xrange),'y-','LineWidth',2)
plot(xscale,graphstruct.objct_avg(xrange),'g-','LineWidth',2)
plot([xscale(1) xscale(end)],[avg_baseline avg_baseline],'k--','LineWidth',0.25)
h=axis;
plot([0 0],[0 h(4)],'k:','LineWidth',0.5)
plot([xscale(1) xscale(end)],[0 0],'k-');
%legend('Neutral','BodyP','Objects')
ylabel('sp/s','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); xlim([xscale(1) xscale(end)]);
try
    title([signame(1:end-4),': FACES570 Task ',...
        char(respstruct.gridlocation),' (',char(respstruct.APIndex),') - ',num2str(respstruct.depth),'um'],'FontSize',10,'FontWeight','Bold');
catch
    title([signame(1:end-4),': FACES570 Task'],'FontSize',10,'FontWeight','Bold'); % if unable to sync
end

subplot(3,2,4) % EXPRESSION effect, average spike density functions
hold on
temp=mean(graphstruct.allconds_avg([hmiconfig.facesND570],:));
plot(xscale,temp(xrange),'r-','LineWidth',2)
temp=mean(graphstruct.allconds_avg([hmiconfig.facesTD570],:));
plot(xscale,temp(xrange),'k-','LineWidth',2)
temp=mean(graphstruct.allconds_avg([hmiconfig.facesFD570],:));
plot(xscale,temp(xrange),'b-','LineWidth',2)
h=axis;
plot([0 0],[0 h(4)],'k:','LineWidth',0.5)
plot([xscale(1) xscale(end)],[0 0],'k-');
%legend('Neutral','Threat','FearGrin')
ylabel('sp/s','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); xlim([xscale(1) xscale(end)]);
title({'Facial Expression','(Directed Gaze Only)'},'FontSize',10,'FontWeight','Bold');

subplot(3,2,6) % GAZE EFFECT effect, average spike density functions
hold on
temp=mean(graphstruct.allconds_avg([hmiconfig.facesND570],:));
plot(xscale,temp(xrange),'r-','LineWidth',2)
temp=mean(graphstruct.allconds_avg([hmiconfig.facesNA570],:));
plot(xscale,temp(xrange),'k-','LineWidth',2)
h=axis;
plot([0 0],[0 h(4)],'k:','LineWidth',0.5)
plot([xscale(1) xscale(end)],[0 0],'k-');
%legend('Directed','Averted')
ylabel('sp/s','FontSize',fontsize_med); set(gca,'FontSize',fontsize_med); xlim([xscale(1) xscale(end)]);
title({'Gaze Direction Expression','(Neutral Expression Only)'},'FontSize',10,'FontWeight','Bold');

cd (figurepath)
jpgfigname=[figurepath,filesep,fname,'_f570_SpDenFunc.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
nfname=[fname,'_spdenfunc.eps'];
eval(['export_fig ',nfname,' -eps -transparent -rgb'])

matfigname=[figurepath,filesep,fname,'_f570_SpDenFunc.fig'];
illfigname=[figurepath,filesep,fname,'_f570_SpDenFunc.ai'];
jpgfigname=[figurepath,filesep,fname,'_f570_SpDenFunc.jpg'];
hgsave(matfigname);
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure
print(gcf,jpgfigname,'-djpeg') % generates an Adobe Illustrator file of the figure
return