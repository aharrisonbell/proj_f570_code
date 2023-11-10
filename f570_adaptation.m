function output=f570_adaptation(xldata,trial_id)
% Repetition Suppression Analysis for Population
% Several types of RS analysis are possible:
% 1) RS amongst face stimuli for face-responsive neurons (examine different populations) (i.e., same stimulus)
% 2) RS: same ID, different expression
% 3) RS: same ID, different gaze direction
% 4) RS: same expression, different ID
% 5) RS: same gaze, different ID
% 6) etc. 
 
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.05 0.8 0.8]); set(gca,'FontName','Arial','FontSize',10);
% Analysis No.1A - Adaptation to all different categories of stimuli for different neuronal populations
% This will examine RS to individual stimuli, grouped according to category

subplot(4,3,1); hold on; rep_range=1:5;
pointerFS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1); % face-selective
pointerBS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Bodyparts')==1); % bodypart-selective
pointerOS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Objects')==1); % objet-selective
bardata1=f570_AdaptPop(xldata,pointerFS,'trial_id11','trial_id5',1); % select only face responses
bardata2=f570_AdaptPop(xldata,pointerBS,'trial_id11','trial_id5',2); % select only bp responses
bardata3=f570_AdaptPop(xldata,pointerOS,'trial_id11','trial_id5',3); % select on object responses
plot(rep_range,bardata1(rep_range,1),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,1),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,1),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,1),bardata1(rep_range,2),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,1),bardata2(rep_range,2),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,1),bardata3(rep_range,2),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons - Absolute Firing Rate'},'FontSize',12,'FontWeight','Bold'); % 

subplot(4,3,2); hold on;
plot(rep_range,bardata1(rep_range,4),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,4),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,4),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,4),bardata1(rep_range,5),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,4),bardata2(rep_range,5),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,4),bardata3(rep_range,5),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons - Normalised Firing Rate'},'FontSize',12,'FontWeight','Bold'); %

subplot(4,3,3); hold on;
plot(rep_range,bardata1(rep_range,6),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,6),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,6),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,6),bardata1(rep_range,7),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,6),bardata2(rep_range,7),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,6),bardata3(rep_range,7),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('RS Index','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons - RS Index'},'FontSize',12,'FontWeight','Bold'); %

subplot(4,3,4); hold on;
plot(rep_range,bardata1(rep_range,9),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,9),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,9),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,9),bardata1(rep_range,10),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,9),bardata2(rep_range,10),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,9),bardata3(rep_range,10),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons (noB) - Absolute Firing Rate'},'FontSize',12,'FontWeight','Bold'); % 

subplot(4,3,5); hold on;
plot(rep_range,bardata1(rep_range,12),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,12),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,12),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,12),bardata1(rep_range,13),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,12),bardata2(rep_range,13),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,12),bardata3(rep_range,13),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons (noB) - Normalised Firing Rate'},'FontSize',12,'FontWeight','Bold'); %

subplot(4,3,6); hold on;
plot(rep_range,bardata1(rep_range,14),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,14),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,14),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,14),bardata1(rep_range,15),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,14),bardata2(rep_range,15),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,14),bardata3(rep_range,15),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('RS Index','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatSelct Neurons (noB) - RS Index'},'FontSize',12,'FontWeight','Bold'); %

% Analysis No.1B - Adaptation to all different categories of stimuli for different neuronal populations (ALL-RESPONSIVE NEURONS)
% This will examine RS to individual stimuli, grouped according to category

subplot(4,3,7); hold on; rep_range=1:5;
pointerFS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05); % face-selective
pointerBS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validbodyp<0.05); % bodypart-selective
pointerOS=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validobject<0.05); % objet-selective
bardata1=f570_AdaptPop(xldata,pointerFS,'trial_id11','trial_id5',1); % select only face responses
bardata2=f570_AdaptPop(xldata,pointerBS,'trial_id11','trial_id5',2); % select only bp responses
bardata3=f570_AdaptPop(xldata,pointerOS,'trial_id11','trial_id5',3); % select on object responses
plot(rep_range,bardata1(rep_range,1),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,1),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,1),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,1),bardata1(rep_range,2),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,1),bardata2(rep_range,2),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,1),bardata3(rep_range,2),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons - Absolute Firing Rate'},'FontSize',12,'FontWeight','Bold'); % 

subplot(4,3,8); hold on;
plot(rep_range,bardata1(rep_range,4),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,4),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,4),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,4),bardata1(rep_range,5),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,4),bardata2(rep_range,5),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,4),bardata3(rep_range,5),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons - Normalised Firing Rate'},'FontSize',12,'FontWeight','Bold'); %

subplot(4,3,9); hold on;
plot(rep_range,bardata1(rep_range,6),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,6),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,6),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,6),bardata1(rep_range,7),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,6),bardata2(rep_range,7),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,6),bardata3(rep_range,7),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('RS Index','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons - RS Index'},'FontSize',12,'FontWeight','Bold'); %

subplot(4,3,10); hold on;
plot(rep_range,bardata1(rep_range,9),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,9),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,9),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,9),bardata1(rep_range,10),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,9),bardata2(rep_range,10),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,9),bardata3(rep_range,10),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons (noB) - Absolute Firing Rate'},'FontSize',12,'FontWeight','Bold'); % 

subplot(4,3,11); hold on;
plot(rep_range,bardata1(rep_range,12),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,12),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,12),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,12),bardata1(rep_range,13),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,12),bardata2(rep_range,13),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,12),bardata3(rep_range,13),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons (noB) - Normalised Firing Rate'},'FontSize',12,'FontWeight','Bold'); %

subplot(4,3,12); hold on;
plot(rep_range,bardata1(rep_range,14),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,14),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,14),'g-','LineWidth',2)
errorbar(rep_range,bardata1(rep_range,14),bardata1(rep_range,15),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,14),bardata2(rep_range,15),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,14),bardata3(rep_range,15),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('RS Index','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title({'Category/Neuron Responses','CatResp Neurons (noB) - RS Index'},'FontSize',12,'FontWeight','Bold'); %


jpgfigname=[figure_path,filesep,monkeyname,'_Fig5.1_IndependentPaths_Faces570.jpg'];
illfigname=[figure_path,filesep,monkeyname,'_Fig5.1_IndependentPaths_Faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-deps') % generates an Adobe Illustrator file of the figure





% Analysis No.2 - Compare Face-Responsive vs. Face-selective vs. Face-non-selective
subplot(4,1,2); hold on; rep_range=1:10; 
pointer1=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.validface<0.05); % face-selective
pointer2=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==0 & xldata.validface<0.05); % face-non-selective
pointer3=find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<0.05); % face-responsive
bardata1=f570_AdaptPop_noBaseline_ind(xldata,pointer1,'trial_id11','trial_id5',1); % select only face responses
bardata2=f570_AdaptPop_noBaseline_ind(xldata,pointer2,'trial_id11','trial_id5',1); % select only bp responses
bardata3=f570_AdaptPop_noBaseline_ind(xldata,pointer3,'trial_id11','trial_id5',1); % select on object responses
errorbar(rep_range,bardata1(rep_range,1),bardata1(rep_range,2),'r-','LineWidth',2)
errorbar(rep_range,bardata2(rep_range,1),bardata2(rep_range,2),'k-','LineWidth',2)
errorbar(rep_range,bardata3(rep_range,1),bardata3(rep_range,2),'g-','LineWidth',2)
legend('FS','FnS','FR');
xlabel('# Exposures','FontSize',9); ylabel('Normalized Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title('Face Neuron Populations','FontSize',10,'FontWeight','Bold'); % 

subplot(4,1,3); hold on; rep_range=1:10;
pointerFS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1); % face-selective
pointerBS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Bodyparts')==1); % bodypart-selective
pointerOS=find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Objects')==1); % bodypart-selective
bardata1=f570_AdaptPop_noBaseline_ind(xldata,pointerFS,'trial_id7','trial_id5',1); % select only face CATEGORY
bardata2=f570_AdaptPop_noBaseline_ind(xldata,pointerBS,'trial_id7','trial_id5',2); % select only bp CATEGORY
bardata3=f570_AdaptPop_noBaseline_ind(xldata,pointerOS,'trial_id7','trial_id5',3); % select on object CATEGORY
plot(rep_range,bardata1(rep_range,1),'r-','LineWidth',2)
plot(rep_range,bardata2(rep_range,1),'k-','LineWidth',2)
plot(rep_range,bardata3(rep_range,1),'g-','LineWidth',2)
%errorbar(rep_range,bardata1(rep_range,1),bardata1(rep_range,2),'r-','LineWidth',2)
%errorbar(rep_range,bardata2(rep_range,1),bardata2(rep_range,2),'k-','LineWidth',2)
%errorbar(rep_range,bardata3(rep_range,1),bardata3(rep_range,2),'g-','LineWidth',2)
legend('F','Bp','O');
xlabel('# Exposures','FontSize',9); ylabel('Normalized Firing Rate (sp/s)','FontSize',9); xlim([rep_range(1) rep_range(end)]); % ylim([0 2.5])
set(gca,'FontSize',9); title('Category/Neuron Responses','FontSize',10,'FontWeight','Bold'); % 


return