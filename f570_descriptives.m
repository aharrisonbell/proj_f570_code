function f570_descriptives
global hmiconfig monkeyname xldata
disp('Figure 1 - Methods, Descriptive Stats, and Examples')
%   faces570_paper_example;
%   May choose to show this as table, not pie charts...
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.05 0.15 0.9 0.7]); set(gca,'FontName','Arial','FontSize',10);
subplot(3,4,1); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(3)=length(find(strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(4)=length(find(strcmp(xldata.confprefcat,'Non-responsive')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title([monkeyname,' - (A) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('F','Bp','O','Nr','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)
subplot(3,4,2); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface>=0.05));
piedata(3)=length(find(strcmp(xldata.confneur,'Non-responsive')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title([monkeyname,' - (B) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('FResp','nonFRresp','Nr','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)
subplot(3,4,3)
totalunits=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1));
clear bardata
bardata(1,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05))/totalunits*100;
bardata(2,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05))/totalunits*100;
bardata(3,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05))/totalunits*100;
bardata(4,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_min'<0.05))/totalunits*100;
bardata(5,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_id(:,3)<0.05))/totalunits*100;
bardata(6,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_gd(:,3)<0.05))/totalunits*100;
bardata(7,1)=length(find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe_gd(:,3)<0.05))/totalunits*100;
bar(bardata); ylim([0 60]);
for col=1:7,
    text(col,50,num2str(bardata(col),'%1.3g'),'FontSize',8)
end
ylabel('% Face Responsive Neurons','FontSize',hmiconfig.fontsize_med)
set(gca,'XTickLabel',{'FE','ID','GD','ID*','FExID','GDxID','FExGD'})
title([monkeyname,' - ANOVA Main Effects & Interactions'],'FontSize',hmiconfig.fontsize_lrg)

subplot(3,4,4)
clear bardata
p_value1=0.05; p_value2=0.05; p_value3=0.005;
totalunits=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<p_value2));
bardata(1,1)=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<p_value2 & xldata.anova_fe_id(:,3)<p_value3))/totalunits*100;
bardata(1,2)=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<p_value2 & xldata.anova_fe_id(:,3)<p_value3));
bardata(1,3)=totalunits;
totalunits=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=p_value2));
bardata(2,1)=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=p_value2 & xldata.anova_fe_id(:,3)<p_value3))/totalunits*100;
bardata(2,2)=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=p_value2 & xldata.anova_fe_id(:,3)<p_value3));
bardata(2,3)=totalunits;
totalunits=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<p_value2));
bardata(3,1)=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<p_value2 & xldata.anova_id_gd(:,3)<p_value3))/totalunits*100;
bardata(3,2)=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<p_value2 & xldata.anova_id_gd(:,3)<p_value3));
bardata(3,3)=totalunits;
totalunits=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=p_value2));
bardata(4,1)=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=p_value2 & xldata.anova_id_gd(:,3)<p_value3))/totalunits*100;
bardata(4,2)=length(find(xldata.validface<p_value1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=p_value2 & xldata.anova_id_gd(:,3)<p_value3));
bardata(4,3)=totalunits;
bar(bardata(:,1)); ylim([0 60]);
for col=1:4,
    text(col,50,num2str(bardata(col),'%1.3g'),'FontSize',8)
end
ylabel('% Face Responsive Neurons','FontSize',hmiconfig.fontsize_med)
set(gca,'XTickLabel',{'FE(FE&ID)','nonFE(FE&ID)','GD(GD&ID)','nonGD(GD&ID)'})
title([monkeyname,' - ANOVA Interactions'],'FontSize',hmiconfig.fontsize_lrg)

%%% Face-Preferring Neurons
subplot(3,4,5); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(D) Facial Expression ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('sigFE','nonsig','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)
subplot(3,4,6); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(E) Gaze Direction ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('sigGD','nonsig','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)
subplot(3,4,7); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(F) Identity ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('sigI','nonsig','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)
subplot(3,4,8); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_min'<0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id_min'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(F) Identity* ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('sigI','nonsig','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)

%%% Face-Responsive Neurons (all neurons that have a valid face response)
subplot(3,4,9); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'<0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05 & xldata.anova_fe'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(G) Facial Expression ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('sigFE','nonsig','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)
subplot(3,4,10); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_gd'<0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_gd'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(H) Gaze Direction ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('sigGD','nonsig','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)
subplot(3,4,11); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id'<0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(I) Identity ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('sigI','nonsig','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)
subplot(3,4,12); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id_min'<0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05  & xldata.anova_id_min'>=0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(I) Identity* ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',hmiconfig.fontsize_lrg,'FontWeight','Bold')
legend('sigI','nonsig','Location','Best'); set(gca,'FontSize',hmiconfig.fontsize_sml)

jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig2_DescriptiveStats.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig1_DescriptiveStats.eps -eps -transparent -rgb
return
