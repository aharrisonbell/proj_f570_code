function f570_sample_spden
global xldata monkeyname hmiconfig S_xldata W_xldata anterior posterior
%%% EXAMPLES BODYPARTS AND OBJECT NEURONS  %%%
disp('Figure 1C,D - Average BodyPart + Object Neurons')
bppointer=find(strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1);
obpointer=find(strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1);
fapointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1);
[avgfunc1, semfunc1]=f570_avg_spden(xldata,fapointer,hmiconfig,hmiconfig.xrange,monkeyname);
[avgfunc2, semfunc2]=f570_avg_spden(xldata,bppointer,hmiconfig,hmiconfig.xrange,monkeyname);
[avgfunc3, semfunc3]=f570_avg_spden(xldata,obpointer,hmiconfig,hmiconfig.xrange,monkeyname);

figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.05 0.15 0.8 0.7]); set(gca,'FontName','Arial','FontSize',10);
subplot(3,2,1); hold on
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc1(1,:),semfunc1(1,:),0.25,'r') % faces response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc1(7,:),semfunc1(7,:),0.25,'y') % bodypart response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc1(8,:),semfunc1(8,:),0.25,'g') % object response
set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 30]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',hmiconfig.fontsize_med); ylabel('Firing Rate*','FontSize',hmiconfig.fontsize_med)
title({'Face neurons',[]},'FontSize',hmiconfig.fontsize_lrg)

subplot(3,2,2); hold on
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc1(9,:),semfunc1(9,:),0.25,'r') % faces response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc1(15,:),semfunc1(15,:),0.25,'y') % bodypart response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc1(16,:),semfunc1(16,:),0.25,'g') % object response
set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 1.25]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',hmiconfig.fontsize_med); ylabel('Normalized Firing Rate*','FontSize',hmiconfig.fontsize_med)
title({'Face neurons',[]},'FontSize',hmiconfig.fontsize_lrg)

subplot(3,2,3); hold on
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc2(1,:),semfunc2(1,:),0.25,'r') % faces response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc2(7,:),semfunc2(7,:),0.25,'y') % bodypart response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc2(8,:),semfunc2(8,:),0.25,'g') % object response
set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 30]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',hmiconfig.fontsize_med); ylabel('Firing Rate*','FontSize',hmiconfig.fontsize_med)
title({'Bodypart neurons',[]},'FontSize',hmiconfig.fontsize_lrg)

subplot(3,2,4); hold on
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc2(9,:),semfunc2(9,:),0.25,'r') % faces response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc2(15,:),semfunc2(15,:),0.25,'y') % bodypart response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc2(16,:),semfunc2(16,:),0.25,'g') % object response
set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 1.25]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',hmiconfig.fontsize_med); ylabel('Normalized Firing Rate*','FontSize',hmiconfig.fontsize_med)
title({'Bodypart neurons',[]},'FontSize',hmiconfig.fontsize_lrg)

subplot(3,2,5); hold on
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc3(1,:),semfunc3(1,:),0.25,'r') % faces response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc3(7,:),semfunc3(7,:),0.25,'y') % bodypart response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc3(8,:),semfunc3(8,:),0.25,'g') % object response
set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 30]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',hmiconfig.fontsize_med); ylabel('Firing Rate*','FontSize',hmiconfig.fontsize_med)
title({'Object neurons',[]},'FontSize',hmiconfig.fontsize_lrg)

subplot(3,2,6); hold on
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc3(9,:),semfunc3(9,:),0.25,'r') % faces response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc3(15,:),semfunc3(15,:),0.25,'y') % bodypart response
plx_shade_spden(hmiconfig.xrange(1):hmiconfig.xrange(2),avgfunc3(16,:),semfunc3(16,:),0.25,'g') % object response
set(gca,'FontName','Arial','FontSize',hmiconfig.fontsize_sml); ylim([0 1.25]); xlim([-100 400]);
xlabel('Time from stimulus onset (ms)','FontSize',hmiconfig.fontsize_med); ylabel('Normalized Firing Rate*','FontSize',hmiconfig.fontsize_med)
title({'Object neurons',[]},'FontSize',hmiconfig.fontsize_lrg)

jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig1_BPOBj.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig1_BPOBj.eps -eps -transparent -rgb
return