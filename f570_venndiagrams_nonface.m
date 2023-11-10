function f570_venndiagrams_nonface
global xldata monkeyname hmiconfig anterior posterior
neuron_type = {'Bodyparts' 'Objects' 'Non-responsive'}
disp('Figure 3 - Intersecting vs. Independent Pathways')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_med);
clear vn
vn(1)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'>=0.05));
vn(2)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
vn(3)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
vn(4)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
vn(5)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
vn(6)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
vn(7)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
subplot(1,2,1)
[~,S]=venn(vn);
for i = 1:7, text(S.ZoneCentroid(i,1), S.ZoneCentroid(i,2), num2str(vn(i))); end
axis square; axis off
legend('fe','id','ge'); set(gca,'FontSize',hmiconfig.fontsize_sml)
title({[monkeyname,' - Neuron Distribution (n=',num2str(length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1))),')'],...
    ['(sig n=',num2str(sum(vn)),')']},'FontSize',hmiconfig.fontsize_lrg)
subplot(1,2,2); clear vn
vn(1)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'<0.05 & xldata.anova_gd'>=0.05));
vn(2)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'>=0.05 & xldata.anova_gd'<0.05));
vn(3)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'<0.05 & xldata.anova_gd'<0.05));
vn(4)=length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1 & xldata.anova_fe'>=0.05 & xldata.anova_gd'>=0.05));
[~,S]=venn(vn(1:2),vn(3));
for i = 1:3, text(S.ZoneCentroid(i,1), S.ZoneCentroid(i,2), num2str(vn(i))); end
axis square; axis off
title({[monkeyname,' - Neuron Distribution (n=',num2str(length(find(xldata.validface>=0.05 & ismember(xldata.confprefcat,neuron_type)==1))),')'],...
    ['(sig n=',num2str(sum(vn(1:3))),')']},'FontSize',hmiconfig.fontsize_lrg)
legend('fe','gd'); set(gca,'FontSize',hmiconfig.fontsize_sml)

jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig3_IntersectingPathways.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig3_IntersectingPathways.eps -eps -transparent -rgb

disp('Figure 3.5 - Intersecting vs. Independent Pathways')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_med);





% POSTERIOR
clear vnp vna vnm vn
vnp(1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'>=0.05));
vnp(2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
vnp(3)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
vnp(4)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
vnp(5)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
vnp(6)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
vnp(7)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
subplot(2,2,1)
[~,S]=venn(vnp);
for i = 1:7, text(S.ZoneCentroid(i,1), S.ZoneCentroid(i,2), num2str(vnp(i))); end
axis square; axis off
legend('fe','id','gd'); set(gca,'FontSize',hmiconfig.fontsize_sml)
title({[monkeyname,' - Neuron Distribution POSTERIOR (n=',num2str(length(find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1))),')'],...
    ['(sig n=',num2str(sum(vnp)),')']},'FontSize',hmiconfig.fontsize_lrg)
subplot(2,2,2);
vn(1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_gd'>=0.05));
vn(2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_gd'<0.05));
vn(3)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_gd'<0.05));
vn(4)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_gd'>=0.05));
[~,S]=venn(vn(1:2),vn(3));
for i = 1:3, text(S.ZoneCentroid(i,1), S.ZoneCentroid(i,2), num2str(vn(i))); end
axis square; axis off
title({[monkeyname,' - Neuron Distribution (n=',num2str(length(find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1))),')'],...
    ['(sig n=',num2str(sum(vn(1:3))),')']},'FontSize',hmiconfig.fontsize_lrg)
legend('fe','gd'); set(gca,'FontSize',hmiconfig.fontsize_sml)

% ANTERIOR
clear vn
vna(1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'>=0.05));
vna(2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
vna(3)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
vna(4)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
vna(5)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
vna(6)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
vna(7)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
subplot(2,2,3)
[~,S]=venn(vna);
for i = 1:7, text(S.ZoneCentroid(i,1), S.ZoneCentroid(i,2), num2str(vna(i))); end
axis square; axis off
legend('fe','id','gd'); set(gca,'FontSize',hmiconfig.fontsize_sml)
title({[monkeyname,' - Neuron Distribution ANTERIOR (n=',num2str(length(find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1))),')'],...
    ['(sig n=',num2str(sum(vna)),')']},'FontSize',hmiconfig.fontsize_lrg)
subplot(2,2,4); clear vn
vn(1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_gd'>=0.05));
vn(2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_gd'<0.05));
vn(3)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_gd'<0.05));
vn(4)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_gd'>=0.05));
[~,S]=venn(vn(1:2),vn(3));
for i = 1:3, text(S.ZoneCentroid(i,1), S.ZoneCentroid(i,2), num2str(vn(i))); end
axis square; axis off
title({[monkeyname,' - Neuron Distribution (n=',num2str(length(find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1))),')'],...
    ['(sig n=',num2str(sum(vn(1:3))),')']},'FontSize',hmiconfig.fontsize_lrg)
legend('fe','gd'); set(gca,'FontSize',hmiconfig.fontsize_sml)
jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig351_IntersectingPathways.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig351_IntersectingPathways.eps -eps -transparent -rgb



return