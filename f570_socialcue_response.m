function f570_socialcue_responses;
global xldata monkeyname hmiconfig
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);

%%% FACIAL EXPRESSION %%%
disp('Figure 2A,B - Effect of Facial Expression on Face Responses')
fepointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05);
fepointerNS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05);
[avgfunc, semfunc]=f570_avg_spden(xldata,fepointerS,hmiconfig,hmiconfig.xrange,monkeyname);
subplot(3,2,1); hold on % sig, norm, fe
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(9,:),semfunc(9,:),0.25,'k') % neutral directed
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(11,:),semfunc(11,:),0.25,'r') % threat directed
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(13,:),semfunc(13,:),0.25,'b') % fear grin directed
set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 1]); xlim([-100 400]);
%plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(1,:),semfunc(1,:),0.25,'k') % neutral directed
%plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(3,:),semfunc(3,:),0.25,'r') % threat directed
%plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(5,:),semfunc(5,:),0.25,'b') % fear grin directed
%set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 50]); xlim([-100 400]);

xlabel('Time from stimulus onset (ms)','FontSize',hmiconfig.fontsize_med); ylabel('Normalized Firing Rate*','FontSize',hmiconfig.fontsize_med)
title({'(A) Facial Expression (F-Resp Neurons, Directed Only)',['Sig Neurons (n=',num2str(length(fepointerS)),')']},'FontSize',hmiconfig.fontsize_lrg)
%legend('N','','T','','Fg','')

bardataS=xldata.expr_rsp_avg(fepointerS,:);
bardataNS=xldata.expr_rsp_avg(fepointerNS,:);
subplot(3,2,2); hold on
bar(1:6,[mean(bardataS,1) mean(bardataNS,1)]);
errorbar(1:6,[mean(bardataS,1) mean(bardataNS,1)],[sem(bardataS) sem(bardataNS)]);
ylabel('Average Response (sp/s)','FontSize',hmiconfig.fontsize_med); ylim([0 20])
set(gca,'XTickLabel',{'N-s','T-s','FG-s','N-ns','T-ns','FG-ns'},'FontSize',hmiconfig.fontsize_sml,'XTick',1:6);
title('(B) Face Resp (sig effect of FE)','FontSize',10)
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

subplot(3,2,3); hold on % expression - normalized (to neutral)
bardataS(:,4)=bardataS(:,1)./bardataS(:,1);
bardataS(:,5)=bardataS(:,2)./bardataS(:,1);
bardataS(:,6)=bardataS(:,3)./bardataS(:,1);
bardataNS(:,4)=bardataNS(:,1)./bardataNS(:,1);
bardataNS(:,5)=bardataNS(:,2)./bardataNS(:,1);
bardataNS(:,6)=bardataNS(:,3)./bardataNS(:,1);
bar(1:6,[mean(bardataS(:,4:6),1) mean(bardataNS(:,4:6),1)]);
errorbar(1:6,[mean(bardataS(:,4:6),1) mean(bardataNS(:,4:6),1)],[sem(bardataS(:,4:6)) sem(bardataNS(:,4:6))]);
ylabel('Average Response (sp/s)','FontSize',hmiconfig.fontsize_med); ylim([0.6 1.4])
set(gca,'XTickLabel',{'N-s','T-s','FG-s','N-ns','T-ns','FG-ns'},'FontSize',hmiconfig.fontsize_sml,'XTick',1:6);
title('(B) Face Resp (Normalized)(direct gaze only)','FontSize',10)
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

subplot(3,2,4); hold on
scatter(bardataNS(:,5),bardataNS(:,6),40,[0.5 0.5 0.5],'s')
pointer_FoverT=find(bardataS(:,5)<bardataS(:,6));
pointer_ToverF=find(bardataS(:,5)>bardataS(:,6));
scatter(bardataS(pointer_ToverF,5),bardataS(pointer_ToverF,6),40,'r','s','filled')
scatter(bardataS(pointer_FoverT,5),bardataS(pointer_FoverT,6),40,'b','s','filled')
xlabel('Response to Threat (normalized to Neutral)','FontSize',hmiconfig.fontsize_sml)
ylabel('Response to Fear Grin (normalized to Neutral)','FontSize',hmiconfig.fontsize_sml);
axis square;
xlim([0 4]); ylim([0 4]); plot([0 4],[0 4],'k:')
plot([0 1],[1 1],'k:'); plot([1 1],[0 1],'k:')
title('(D) Compare Threat vs. Fear Grin','FontSize',10)

subplot(3,2,5); clear piedata
bardataS=xldata.expr_rsp_avg(fepointerS,:);
[~,ind]=max(bardataS(:,1:3),[],2); clear piedata
piedata(1)=length(find(ind==1));
piedata(2)=length(find(ind==2));
piedata(3)=length(find(ind==3));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Maximum Response (averaged across direction)',['(n=',num2str(sum(piedata)),')']},'FontSize',hmiconfig.fontsize_med,'FontWeight','Bold')
legend('Neutral','Threat','FearGrin'); set(gca,'FontSize',hmiconfig.fontsize_sml)

subplot(3,2,6); clear si % histogram
si(:,1)=histc(abs(xldata.expr_si(fepointerS,4)),0:0.05:0.5); % currently using MAX response
si(:,2)=histc(abs(xldata.expr_si(fepointerNS,4)),0:0.05:0.5); % currently using MAX response
bar(0:0.05:0.5,si,'stacked'); axis square
xlim([0 0.5]); xlabel('|SI|','FontSize',hmiconfig.fontsize_med)
ylabel('# Neurons')
title('Selectivity Index - Facial Expression','FontSize',hmiconfig.fontsize_lrg)
text(0.3,30,['mean: ',num2str(mean(abs(xldata.expr_si([fepointerS;fepointerNS])))),' +/-',num2str(sem(abs(xldata.expr_si([fepointerS;fepointerNS]))))],'FontSize',hmiconfig.fontsize_med)
text(0.3,50,['mean: ',num2str(mean(abs(xldata.expr_si(fepointerS)))),' +/-',num2str(sem(abs(xldata.expr_si(fepointerS))))],'FontSize',hmiconfig.fontsize_med)
clear fepointerS fepointerNS si

jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig2pt1_FacialExpression.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig2pt1_FacialExpression.eps -eps -transparent -rgb

figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);

%%% GAZE DIRECTION %%%
disp('Figure 2C,D - Effect of Facial Expression on Face Responses')
gdpointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'<0.05);
gdpointerNS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gd'>=0.05);
[avgfunc, semfunc]=f570_avg_spden(xldata,gdpointerS,hmiconfig,hmiconfig.xrange,monkeyname);
subplot(3,2,1); hold on %
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(9,:),semfunc(9,:),0.25,'k') % directed
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(10,:),semfunc(10,:),0.25,'b') % averted
set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 1.25]); xlim([-100 400]);
%plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(1,:),semfunc(1,:),0.25,'k') % directed
%plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(2,:),semfunc(2,:),0.25,'b') % averted
%set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 25]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',hmiconfig.fontsize_med); ylabel('Normalized Firing Rate*','FontSize',hmiconfig.fontsize_med)
title({'(C) Gaze Direction (F-Resp Neurons, Neutral Only)',['Sig Neurons (n=',num2str(length(gdpointerS)),')']},'FontSize',hmiconfig.fontsize_lrg)
%legend('D','','A','')

bardataS=xldata.gaze_rsp_avg(gdpointerS,:);
bardataNS=xldata.gaze_rsp_avg(gdpointerNS,:);
subplot(3,2,2); hold on % average responses collapsed across gaze direction
bar(1:4,[mean(bardataS,1) mean(bardataNS,1)]);
errorbar(1:4,[mean(bardataS,1) mean(bardataNS,1)],[sem(bardataS) sem(bardataNS)]);
ylabel('Average Response (sp/s)','FontSize',hmiconfig.fontsize_med); ylim([0 20])
set(gca,'XTickLabel',{'D-s','A-s','D-ns','A-ns'},'FontSize',hmiconfig.fontsize_sml,'XTick',1:4);
title('Face Resp (sig effect of GD, Neutral Only)','FontSize',10)
[p,~]=ranksum(bardataS(:,1),bardataS(:,2));
text(1,mean(bardataS(:,1))+sem(bardataS(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)
[p,~]=ranksum(bardataNS(:,1),bardataNS(:,2));
text(3,mean(bardataNS(:,1))+sem(bardataNS(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',10)

subplot(3,2,3); hold on % expression - normalized (to neutral)
bardataS(:,3)=bardataS(:,1)./bardataS(:,1);
bardataS(:,4)=bardataS(:,2)./bardataS(:,1);
bardataNS(:,3)=bardataNS(:,1)./bardataNS(:,1);
bardataNS(:,4)=bardataNS(:,2)./bardataNS(:,1);
bar(1:4,[mean(bardataS(:,3:4),1) mean(bardataNS(:,3:4),1)]);
errorbar(1:4,[mean(bardataS(:,3:4),1) mean(bardataNS(:,3:4),1)],[sem(bardataS(:,3:4)) sem(bardataNS(:,3:4))]);
ylabel('Average Response (sp/s)','FontSize',hmiconfig.fontsize_med); ylim([0.6 1.4])
set(gca,'XTickLabel',{'D-s','A-s','D-ns','A-ns'},'FontSize',hmiconfig.fontsize_sml,'XTick',1:4);
title('Face Resp (Normalized, Neutral Only)','FontSize',10)
[p,~]=ttest2(bardataS(:,3),bardataS(:,4));
text(1,mean(bardataS(:,3))+sem(bardataS(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)
[p,~]=ranksum(bardataNS(:,3),bardataNS(:,4));
text(3,mean(bardataNS(:,3))+sem(bardataNS(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',10)

subplot(3,2,4); hold on
scatter(bardataNS(:,1),bardataNS(:,2),40,[0.5 0.5 0.5],'s')
pointer_AoverD=find(bardataS(:,1)<bardataS(:,2));
pointer_DoverA=find(bardataS(:,1)>bardataS(:,2));
scatter(bardataS(pointer_DoverA,1),bardataS(pointer_DoverA,2),40,'k','s','filled')
scatter(bardataS(pointer_AoverD,1),bardataS(pointer_AoverD,2),40,'b','s','filled')
xlabel('Response to Direct (sp/s)','FontSize',hmiconfig.fontsize_sml)
ylabel('Response to Averted (sp/s)','FontSize',hmiconfig.fontsize_sml);
axis square;
xlim([0 80]); ylim([0 80]); plot([0 80],[0 80],'k:')
% plot([0 1],[1 1],'k:'); plot([1 1],[0 1],'k:')
title('(D) Compare Directed vs. Averted','FontSize',10)

subplot(3,2,5); clear piedata
bardataS=xldata.gaze_rsp_avg(gdpointerS,:);
[~,ind]=max(bardataS(:,1:2),[],2); clear piedata
piedata(1)=length(find(ind==1));
piedata(2)=length(find(ind==2));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Maximum Response (averaged across expression)',['(n=',num2str(sum(piedata)),')']},'FontSize',hmiconfig.fontsize_med,'FontWeight','Bold')
legend('Directed','Averted'); set(gca,'FontSize',hmiconfig.fontsize_sml)

subplot(3,2,6); clear si % histogram
si(:,1)=histc(abs(xldata.gaze_si(gdpointerS)),0:0.05:0.5); % currently using MAX response
si(:,2)=histc(abs(xldata.gaze_si(gdpointerNS)),0:0.05:0.5); % currently using MAX response
bar(0:0.05:0.5,si,'stacked'); axis square
xlim([0 0.5]); xlabel('|SI|','FontSize',hmiconfig.fontsize_med)
ylabel('# Neurons')
title('Selectivity Index - Gaze Direction','FontSize',hmiconfig.fontsize_lrg)
text(0.3,30,['mean: ',num2str(mean(abs(xldata.gaze_si([gdpointerS;gdpointerNS])))),' +/-',num2str(sem(abs(xldata.gaze_si([gdpointerS;gdpointerNS]))))],'FontSize',hmiconfig.fontsize_med)
text(0.3,50,['mean: ',num2str(mean(abs(xldata.gaze_si(gdpointerS)))),' +/-',num2str(sem(abs(xldata.gaze_si(gdpointerS))))],'FontSize',hmiconfig.fontsize_med)
clear gdpointerS gdpointerNS si

jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig3pt2_GazeDirection.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig2pt2_GazeDirection.eps -eps -transparent -rgb

figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);

%%% IDENTITY %%%
disp('Figure 2E,F - Effect of Identity on Face Responses')
idpointerS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'<0.05);
idpointerNS=find(xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id'>=0.05);
[avgfunc, semfunc]=f570_avg_spden_ID(xldata,idpointerS,hmiconfig,hmiconfig.xrange,monkeyname);
subplot(3,2,1); hold on %
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(9,:),semfunc(9,:),0.25,'k') % maximum
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(11,:),semfunc(11,:),0.25,'r') % 3rd
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(13,:),semfunc(13,:),0.25,'g') % 5th
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(16,:),semfunc(16,:),0.25,'b') % minimum
set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 1]); xlim([-100 400]);

%plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(1,:),semfunc(1,:),0.25,'k') % maximum
%plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(3,:),semfunc(3,:),0.25,'r') % 3rd
%plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(6,:),semfunc(6,:),0.25,'g') % 5th
%plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc(8,:),semfunc(8,:),0.25,'b') % minimum
%set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 50]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',hmiconfig.fontsize_med); ylabel('Normalized Firing Rate*','FontSize',hmiconfig.fontsize_med)
title({'(E)Identity (F-Resp Neurons, Neutral,Directed Only)',['Sig Neurons (n=',num2str(length(idpointerS)),')']},'FontSize',hmiconfig.fontsize_lrg)

bardataS=xldata.id_rsp_avg(idpointerS,:);
bardataNS=xldata.id_rsp_avg(idpointerNS,:);
subplot(3,4,5);
boxplot(bardataS)
ylabel('Average Response (sp/s)','FontSize',hmiconfig.fontsize_med); ylim([0 100])
title('(B) unsorted ID Sig','FontSize',10)
subplot(3,4,6);
boxplot(sort(bardataS,2))
ylabel('Average Response (sp/s)','FontSize',hmiconfig.fontsize_med); ylim([0 100])
title('(C) sorted ID Sig','FontSize',10)
subplot(3,4,7);
boxplot(bardataNS)
ylabel('Average Response (sp/s)','FontSize',hmiconfig.fontsize_med); ylim([0 100])
title('(D) unsorted ID non-sig','FontSize',10)
subplot(3,4,8);
boxplot(sort(bardataNS,2))
ylabel('Average Response (sp/s)','FontSize',hmiconfig.fontsize_med); ylim([0 100])
title('(E) unsorted ID non-sig','FontSize',10)

subplot(3,2,5); clear piedata % single/average example
piedata(1)=length(idpointerS);
piedata(2)=length(idpointerNS);
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({'Face Resp - Identity',['(n=',num2str(sum(piedata)),')']},'FontSize',hmiconfig.fontsize_med,'FontWeight','Bold')
legend('Sig','Non-Sig'); set(gca,'FontSize',hmiconfig.fontsize_sml)

subplot(3,2,6); clear si % histogram
si(:,1)=histc(abs(xldata.id_si(idpointerS)),0:0.05:0.5); % currently using MAX response
si(:,2)=histc(abs(xldata.id_si(idpointerNS)),0:0.05:0.5); % currently using MAX response
bar(0:0.05:0.5,si,'stacked'); axis square
xlim([0 0.5]); xlabel('|SI|','FontSize',hmiconfig.fontsize_med)
ylabel('# Neurons')
title('Selectivity Index - Identity','FontSize',hmiconfig.fontsize_lrg)
text(0.3,30,['mean: ',num2str(mean(abs(xldata.id_si([idpointerS;idpointerNS])))),' +/-',num2str(sem(abs(xldata.id_si([idpointerS;idpointerNS]))))],'FontSize',hmiconfig.fontsize_med)
text(0.3,50,['mean: ',num2str(mean(abs(xldata.id_si(idpointerS)))),' +/-',num2str(sem(abs(xldata.id_si(idpointerS))))],'FontSize',hmiconfig.fontsize_med)
clear si

% new identity tuning width histogram
subplot(3,2,2); clear si
si(:,1)=histc(xldata.identity_tuning(idpointerS),0:1:9); % currently using MAX response
si(:,2)=histc(xldata.identity_tuning(idpointerNS),0:1:9); % currently using MAX response
bar(0:1:9,si,'stacked'); axis square
xlim([0 9]); xlabel('Tuning Width','FontSize',hmiconfig.fontsize_med)
ylabel('# Neurons')
title('Selectivity Index - Facial Expression','FontSize',hmiconfig.fontsize_lrg)
text(5,100,['mean(all): ',num2str(mean(xldata.identity_tuning([idpointerS;idpointerNS]))),' +/-',num2str(sem(abs(xldata.identity_tuning([idpointerS;idpointerNS]))))],'FontSize',hmiconfig.fontsize_med)
text(5,80,['mean(S): ',num2str(mean(xldata.identity_tuning(idpointerS))),' +/-',num2str(sem(xldata.identity_tuning(idpointerS)))],'FontSize',hmiconfig.fontsize_med)
text(5,60,['mean(NS): ',num2str(mean(xldata.identity_tuning(idpointerNS))),' +/-',num2str(sem(xldata.identity_tuning(idpointerNS)))],'FontSize',hmiconfig.fontsize_med)
clear idpointerS idpointerNS si

jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig2pt3_Identity.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig2pt3_Identity.eps -eps -transparent -rgb

clear idpointerS idpointerNS bardataS bardataNS

return
