function f570_descriptives_ant_post
global xldata monkeyname hmiconfig anterior posterior
disp('Figure 1.5 - Methods, Descriptive Stats, and Examples ( broken down into anterior vs. posterior')
ant_post_data=zeros(4,2);
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.05 0.15 0.9 0.7]); set(gca,'FontName','Arial','FontSize',10);

subplot(2,6,1); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(3)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(4)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confprefcat,'Non-responsive')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title([monkeyname,' - (A) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('F','Bp','O','Nr','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)

subplot(2,6,2); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05));
piedata(2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface>=0.05));
piedata(3)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Non-responsive')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title([monkeyname,' - (B) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('FResp','nonFRresp','Nr','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)

subplot(2,6,3); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05));
piedata(2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(G) Facial Expression ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
set(gca,'FontSize',hmiconfig.fontsize_sml)
ant_post_data(1,1)=piedata(1)/sum(piedata);

subplot(2,6,4); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_gd'<0.05));
piedata(2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_gd'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(H) Gaze Direction ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
set(gca,'FontSize',hmiconfig.fontsize_sml)
ant_post_data(2,1)=piedata(1)/sum(piedata);

subplot(2,6,5); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id'<0.05));
piedata(2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(I) Identity ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
set(gca,'FontSize',hmiconfig.fontsize_sml)
ant_post_data(3,1)=piedata(1)/sum(piedata);

subplot(2,6,6); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id_min'<0.05));
piedata(2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id_min'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(I) Identity* ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
set(gca,'FontSize',hmiconfig.fontsize_sml)
ant_post_data(4,1)=piedata(1)/sum(piedata);

% ANTERIOR
subplot(2,6,7); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(3)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(4)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confprefcat,'Non-responsive')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title([monkeyname,' - (A) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('F','Bp','O','Nr','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)

subplot(2,6,8); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05));
piedata(2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface>=0.05));
piedata(3)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Non-responsive')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title([monkeyname,' - (B) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
set(gca,'FontSize',hmiconfig.fontsize_sml)

subplot(2,6,9); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05));
piedata(2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(G) Facial Expression ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
set(gca,'FontSize',hmiconfig.fontsize_sml)
ant_post_data(1,2)=piedata(1)/sum(piedata);

subplot(2,6,10); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_gd'<0.05));
piedata(2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_gd'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(H) Gaze Direction ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
set(gca,'FontSize',hmiconfig.fontsize_sml)
ant_post_data(2,2)=piedata(1)/sum(piedata);

subplot(2,6,11); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id'<0.05));
piedata(2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(I) Identity ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
set(gca,'FontSize',hmiconfig.fontsize_sml)
ant_post_data(3,2)=piedata(1)/sum(piedata);

subplot(2,6,12); piedata=[]; %
piedata(1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id_min'<0.05));
piedata(2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id_min'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(I) Identity* ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
set(gca,'FontSize',hmiconfig.fontsize_sml)
ant_post_data(4,2)=piedata(1)/sum(piedata);

jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig151_DescriptiveStats.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig151_DescriptiveStats.eps -eps -transparent -rgb

figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.05 0.15 0.9 0.7]); set(gca,'FontName','Arial','FontSize',10);
subplot(2,1,1)
bar(ant_post_data,'grouped');
ylabel('Percentage of Neurons'); legend('Post','Ant')
title('Breakdown of selectivity for anterior vs. posterior')
set(gca,'XTickLabels',{'FE','GD','ID','ID*'});

subplot(2,2,3)

totalunits=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1));
clear bardata
bardata(1,1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05))/totalunits*100;
bardata(2,1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05))/totalunits*100;
bardata(3,1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05))/totalunits*100;
bardata(4,1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_min'<0.05))/totalunits*100;
bardata(5,1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_id(:,3)<0.05))/totalunits*100;
bardata(6,1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_gd(:,3)<0.05))/totalunits*100;
bardata(7,1)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05))/totalunits*100;

bardata(1,2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05));
bardata(2,2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
bardata(3,2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05));
bardata(4,2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_min'<0.05));
bardata(5,2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_id(:,3)<0.05));
bardata(6,2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_gd(:,3)<0.05));
bardata(7,2)=length(find(ismember(xldata.apindex(:,1),posterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05));


bar(bardata(:,1)); ylim([0 60]);
for col=1:7,
    text(col,50,num2str(bardata(col,1),'%1.3g'),'FontSize',8)
    text(col,55,['n=',num2str(bardata(col,2),'%1.3g')],'FontSize',8)
end
ylabel('% Face Responsive Neurons','FontSize',hmiconfig.fontsize_med)
set(gca,'XTickLabel',{'FE','ID','GD','ID*','FExID','GDxID','FExGD'})

subplot(2,2,4)
totalunits=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1));
clear bardata
bardata(1,1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05))/totalunits*100;
bardata(2,1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05))/totalunits*100;
bardata(3,1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05))/totalunits*100;
bardata(4,1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_min'<0.05))/totalunits*100;
bardata(5,1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_id(:,3)<0.05))/totalunits*100;
bardata(6,1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_gd(:,3)<0.05))/totalunits*100;
bardata(7,1)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05))/totalunits*100;

bardata(1,2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05));
bardata(2,2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
bardata(3,2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05));
bardata(4,2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_min'<0.05));
bardata(5,2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_id(:,3)<0.05));
bardata(6,2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_gd(:,3)<0.05));
bardata(7,2)=length(find(ismember(xldata.apindex(:,1),anterior)==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05));


bar(bardata(:,1)); ylim([0 60]);
for col=1:7,
    text(col,50,num2str(bardata(col,1),'%1.3g'),'FontSize',8)
    text(col,55,['n=',num2str(bardata(col,2),'%1.3g')],'FontSize',8)
end
ylabel('% Face Responsive Neurons','FontSize',hmiconfig.fontsize_med)
set(gca,'XTickLabel',{'FE','ID','GD','ID*','FExID','GDxID','FExGD'})


jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig152_DescriptiveStats.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig152_DescriptiveStats.eps -eps -transparent -rgb
return