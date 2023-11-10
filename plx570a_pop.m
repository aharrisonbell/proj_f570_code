function plx570pop(monkinitial);
%%%%%%%%%%%%%
% plx570pop %
%%%%%%%%%%%%%
% written by AHB, Nov2009
% Program to compile all FACES570 neurons and generate summary figures.
% MONKINITIAL (required) = 'W' or 'S'

%%% SETUP DEFAULTS
warning off; close all;
hmiconfig=generate_hmi_configplex; % generates and loads config file
if nargin==0, error('You must specify a monkey (''S''/''W''/''B'')'); end
fontsize_sml=7; fontsize_med=8; fontsize_lrg=9;

disp('**********************************************************************')
disp('* plx570pop.m - Program to compile all FACES570 neurons and generate *')
disp('*               summary figures.                                     *')
disp('* NOTE:  This program works best if run AFTER plx570sync2excel.m     *')
disp('**********************************************************************')

if monkinitial=='S',
    monkeyname='Stewie'; sheetname='F570_Neural_S';
    %%%  LOAD FILE LIST
    disp(['...Loading file list from Excel: ',sheetname]);
    [crap,xldata.plxname]=xlsread(hmiconfig.excelfile,sheetname,'B4:B1000');
    [crap,xldata.unitname]=xlsread(hmiconfig.excelfile,sheetname,'C4:C1000');
    [crap,xldata.gridloc]=xlsread(hmiconfig.excelfile,sheetname,'D4:D1000');
    [crap,xldata.autoneur]=xlsread(hmiconfig.excelfile,sheetname,'E4:E1000');
    [crap,xldata.confneur]=xlsread(hmiconfig.excelfile,sheetname,'F4:F1000');
    [crap,xldata.autoprefcat]=xlsread(hmiconfig.excelfile,sheetname,'G4:G1000');
    [crap,xldata.confprefcat]=xlsread(hmiconfig.excelfile,sheetname,'H4:H1000');
    [crap,xldata.autoresptype]=xlsread(hmiconfig.excelfile,sheetname,'I4:I1000');
    [crap,xldata.confresptype]=xlsread(hmiconfig.excelfile,sheetname,'J4:J1000');
    [crap,xldata.autocatselect]=xlsread(hmiconfig.excelfile,sheetname,'K4:K1000');
    [crap,xldata.confcatselect]=xlsread(hmiconfig.excelfile,sheetname,'L4:L1000');
    xldata.quality=xlsread(hmiconfig.excelfile,sheetname,'M4:M1000');
    xldata.face_si=xlsread(hmiconfig.excelfile,sheetname,'N4:N1000');
    xldata.bodyp_si=xlsread(hmiconfig.excelfile,sheetname,'O4:O1000');
    xldata.objct_si=xlsread(hmiconfig.excelfile,sheetname,'P4:P1000');
    xldata.validface=xlsread(hmiconfig.excelfile,sheetname,'Q4:Q1000');
    xldata.validbodyp=xlsread(hmiconfig.excelfile,sheetname,'R4:R1000');
    xldata.validobject=xlsread(hmiconfig.excelfile,sheetname,'S4:S1000');
    xldata.anova_expr=xlsread(hmiconfig.excelfile,sheetname,'T4:T1000');
    xldata.anova_id=xlsread(hmiconfig.excelfile,sheetname,'U4:U1000');
    xldata.anova_gaze=xlsread(hmiconfig.excelfile,sheetname,'V4:V1000');
    xldata.anova_id_gz=xlsread(hmiconfig.excelfile,sheetname,'W4:W1000');
    xldata.expr_si(:,1)=xlsread(hmiconfig.excelfile,sheetname,'X4:X1000');
    xldata.expr_si(:,2)=xlsread(hmiconfig.excelfile,sheetname,'Y4:Y1000');
    xldata.expr_si(:,3)=xlsread(hmiconfig.excelfile,sheetname,'Z4:Z1000');
    xldata.expr_si(:,4)=xlsread(hmiconfig.excelfile,sheetname,'AA4:AA1000');
    xldata.id_si(:,1)=xlsread(hmiconfig.excelfile,sheetname,'AB4:AB1000');
    xldata.gaze_si(:,1)=xlsread(hmiconfig.excelfile,sheetname,'AC4:AC1000');
    %%% Load information from RESPSTRUCTSINGLE files
    for un=1:size(xldata.plxname,1),
        % Load individual file
        newname=char(xldata.plxname(un)); newunit=char(xldata.unitname(un));
        disp(['...',newname(1:12),'-',newunit,'...'])
        load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
        xldata.cat_rsp_avg(un,1:3)=respstructsingle.cat_rsp_avg;
        xldata.expr_rsp_avg(un,1:3)=respstructsingle.expr_rsp_avg;
        xldata.gaze_rsp_avg(un,1:2)=respstructsingle.gaze_rsp_avg;
    end
    facegrids={'A3R4','A3R5','A3R6','A4R4','A4R5','A4R6','A5R4','A5R5','A5R6','A6R5','A6R6','A7R5','A7R6'}; % confirmed May 3, 2010

elseif monkinitial=='W',
    monkeyname='Wiggum'; sheetname='F570_Neural_W';
    %%%  LOAD FILE LIST
    disp(['...Loading file list from Excel: ',sheetname]);
    [crap,xldata.plxname]=xlsread(hmiconfig.excelfile,sheetname,'B4:B1000');
    [crap,xldata.unitname]=xlsread(hmiconfig.excelfile,sheetname,'C4:C1000');
    [crap,xldata.gridloc]=xlsread(hmiconfig.excelfile,sheetname,'D4:D1000');
    [crap,xldata.autoneur]=xlsread(hmiconfig.excelfile,sheetname,'E4:E1000');
    [crap,xldata.confneur]=xlsread(hmiconfig.excelfile,sheetname,'F4:F1000');
    [crap,xldata.autoprefcat]=xlsread(hmiconfig.excelfile,sheetname,'G4:G1000');
    [crap,xldata.confprefcat]=xlsread(hmiconfig.excelfile,sheetname,'H4:H1000');
    [crap,xldata.autoresptype]=xlsread(hmiconfig.excelfile,sheetname,'I4:I1000');
    [crap,xldata.confresptype]=xlsread(hmiconfig.excelfile,sheetname,'J4:J1000');
    [crap,xldata.autocatselect]=xlsread(hmiconfig.excelfile,sheetname,'K4:K1000');
    [crap,xldata.confcatselect]=xlsread(hmiconfig.excelfile,sheetname,'L4:L1000');
    xldata.quality=xlsread(hmiconfig.excelfile,sheetname,'M4:M1000');
    xldata.face_si=xlsread(hmiconfig.excelfile,sheetname,'N4:N1000');
    xldata.bodyp_si=xlsread(hmiconfig.excelfile,sheetname,'O4:O1000');
    xldata.objct_si=xlsread(hmiconfig.excelfile,sheetname,'P4:P1000');
    xldata.validface=xlsread(hmiconfig.excelfile,sheetname,'Q4:Q1000');
    xldata.validbodyp=xlsread(hmiconfig.excelfile,sheetname,'R4:R1000');
    xldata.validobject=xlsread(hmiconfig.excelfile,sheetname,'S4:S1000');
    xldata.anova_expr=xlsread(hmiconfig.excelfile,sheetname,'T4:T1000');
    xldata.anova_id=xlsread(hmiconfig.excelfile,sheetname,'U4:U1000');
    xldata.anova_gaze=xlsread(hmiconfig.excelfile,sheetname,'V4:V1000');
    xldata.anova_id_gz=xlsread(hmiconfig.excelfile,sheetname,'W4:W1000');
    xldata.expr_si(:,1)=xlsread(hmiconfig.excelfile,sheetname,'X4:X1000');
    xldata.expr_si(:,2)=xlsread(hmiconfig.excelfile,sheetname,'Y4:Y1000');
    xldata.expr_si(:,3)=xlsread(hmiconfig.excelfile,sheetname,'Z4:Z1000');
    xldata.expr_si(:,4)=xlsread(hmiconfig.excelfile,sheetname,'AA4:AA1000');
    xldata.id_si(:,1)=xlsread(hmiconfig.excelfile,sheetname,'AB4:AB1000');
    xldata.gaze_si(:,1)=xlsread(hmiconfig.excelfile,sheetname,'AC4:AC1000');
    %%% Load information from RESPSTRUCTSINGLE files
    for un=1:size(xldata.plxname,1),
        % Load individual file
        newname=char(xldata.plxname(un)); newunit=char(xldata.unitname(un));
        disp(['...',newname(1:12),'-',newunit,'...'])
        load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
        xldata.cat_rsp_avg(un,1:3)=respstructsingle.cat_rsp_avg;
        xldata.expr_rsp_avg(un,1:3)=respstructsingle.expr_rsp_avg;
        xldata.gaze_rsp_avg(un,1:2)=respstructsingle.gaze_rsp_avg;
    end
    facegrids={'A0R0','A0R1','A1R0','A2R1','A3R0','P7R0','P7R2'}; %  updated July 29, 2010

elseif monkinitial=='B'
    monkeyname='Both Monkeys';
    sheetname='F570_Neural_S';
    %%%  LOAD FILE LIST
    disp(['...Loading file list from Excel: ',sheetname]);
    [crap,xldata.plxname]=xlsread(hmiconfig.excelfile,sheetname,'B4:B1000');
    [crap,xldata.unitname]=xlsread(hmiconfig.excelfile,sheetname,'C4:C1000');
    [crap,xldata.gridloc]=xlsread(hmiconfig.excelfile,sheetname,'D4:D1000');
    [crap,xldata.autoneur]=xlsread(hmiconfig.excelfile,sheetname,'E4:E1000');
    [crap,xldata.confneur]=xlsread(hmiconfig.excelfile,sheetname,'F4:F1000');
    [crap,xldata.autoprefcat]=xlsread(hmiconfig.excelfile,sheetname,'G4:G1000');
    [crap,xldata.confprefcat]=xlsread(hmiconfig.excelfile,sheetname,'H4:H1000');
    [crap,xldata.autoresptype]=xlsread(hmiconfig.excelfile,sheetname,'I4:I1000');
    [crap,xldata.confresptype]=xlsread(hmiconfig.excelfile,sheetname,'J4:J1000');
    [crap,xldata.autocatselect]=xlsread(hmiconfig.excelfile,sheetname,'K4:K1000');
    [crap,xldata.confcatselect]=xlsread(hmiconfig.excelfile,sheetname,'L4:L1000');
    xldata.quality=xlsread(hmiconfig.excelfile,sheetname,'M4:M1000');
    xldata.face_si=xlsread(hmiconfig.excelfile,sheetname,'N4:N1000');
    xldata.bodyp_si=xlsread(hmiconfig.excelfile,sheetname,'O4:O1000');
    xldata.objct_si=xlsread(hmiconfig.excelfile,sheetname,'P4:P1000');
    xldata.validface=xlsread(hmiconfig.excelfile,sheetname,'Q4:Q1000');
    xldata.validbodyp=xlsread(hmiconfig.excelfile,sheetname,'R4:R1000');
    xldata.validobject=xlsread(hmiconfig.excelfile,sheetname,'S4:S1000');
    xldata.anova_expr=xlsread(hmiconfig.excelfile,sheetname,'T4:T1000');
    xldata.anova_id=xlsread(hmiconfig.excelfile,sheetname,'U4:U1000');
    xldata.anova_gaze=xlsread(hmiconfig.excelfile,sheetname,'V4:V1000');
    xldata.anova_id_gz=xlsread(hmiconfig.excelfile,sheetname,'W4:W1000');
    xldata.expr_si(:,1)=xlsread(hmiconfig.excelfile,sheetname,'X4:X1000');
    xldata.expr_si(:,2)=xlsread(hmiconfig.excelfile,sheetname,'Y4:Y1000');
    xldata.expr_si(:,3)=xlsread(hmiconfig.excelfile,sheetname,'Z4:Z1000');
    xldata.expr_si(:,4)=xlsread(hmiconfig.excelfile,sheetname,'AA4:AA1000');
    xldata.id_si(:,1)=xlsread(hmiconfig.excelfile,sheetname,'AB4:AB1000');
    xldata.gaze_si(:,1)=xlsread(hmiconfig.excelfile,sheetname,'AC4:AC1000');

    %%%  LOAD FILE LIST
    sheetname='F570_Neural_W';
    startrow=size(xldata.plxname,1)+1;
    disp(['...Loading file list from Excel: ',sheetname]);
    [crap,crap1]=xlsread(hmiconfig.excelfile,sheetname,'B4:B1000');
    endrow=size(crap1,1)+startrow-1;
    [crap,xldata.plxname(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['B4:B',num2str(startrow+3)]);
    [crap,xldata.unitname(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['C4:C',num2str(startrow+3)]);
    [crap,xldata.gridloc(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['D4:D',num2str(startrow+3)]);
    [crap,xldata.autoneur(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['E4:E',num2str(startrow+3)]);
    [crap,xldata.confneur(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['F4:F',num2str(startrow+3)]);
    [crap,xldata.autoprefcat(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['G4:G',num2str(startrow+3)]);
    [crap,xldata.confprefcat(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['H4:H',num2str(startrow+3)]);
    [crap,xldata.autoresptype(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['I4:I',num2str(startrow+3)]);
    [crap,xldata.confresptype(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['J4:J',num2str(startrow+3)]);
    [crap,xldata.autocatselect(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['K4:K',num2str(startrow+3)]);
    [crap,xldata.confcatselect(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['L4:L',num2str(startrow+3)]);
    xldata.quality(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['M4:M',num2str(startrow+3)]);
    xldata.face_si(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['N4:N',num2str(startrow+3)]);
    xldata.bodyp_si(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['O4:O',num2str(startrow+3)]);
    xldata.objct_si(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['P4:P',num2str(startrow+3)]);
    xldata.validface(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['Q4:Q',num2str(startrow+3)]);
    xldata.validbodyp(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['R4:R',num2str(startrow+3)]);
    xldata.validobject(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['S4:S',num2str(startrow+3)]);
    xldata.anova_expr(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['T4:T',num2str(startrow+3)]);
    xldata.anova_id(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['U4:U',num2str(startrow+3)]);
    xldata.anova_gaze(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['V4:V',num2str(startrow+3)]);
    xldata.anova_id_gz(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['W4:W',num2str(startrow+3)]);
    xldata.expr_si((startrow:endrow),1)=xlsread(hmiconfig.excelfile,sheetname,['X4:X',num2str(startrow+3)]);
    xldata.expr_si((startrow:endrow),2)=xlsread(hmiconfig.excelfile,sheetname,['Y4:Y',num2str(startrow+3)]);
    xldata.expr_si((startrow:endrow),3)=xlsread(hmiconfig.excelfile,sheetname,['Z4:Z',num2str(startrow+3)]);
    xldata.expr_si((startrow:endrow),4)=xlsread(hmiconfig.excelfile,sheetname,['AA4:AA',num2str(startrow+3)]);
    xldata.id_si((startrow:endrow),1)=xlsread(hmiconfig.excelfile,sheetname,['AB4:AB',num2str(startrow+3)]);
    xldata.gaze_si((startrow:endrow),1)=xlsread(hmiconfig.excelfile,sheetname,['AC4:AC',num2str(startrow+3)]);

    %%% Load information from RESPSTRUCTSINGLE files
    for un=1:size(xldata.plxname,1),
        % Load individual file
        newname=char(xldata.plxname(un)); newunit=char(xldata.unitname(un));
        disp(['...',newname(1:12),'-',newunit,'...'])
        load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
        xldata.cat_rsp_avg(un,1:3)=respstructsingle.cat_rsp_avg;
        xldata.expr_rsp_avg(un,1:3)=respstructsingle.expr_rsp_avg;
        xldata.gaze_rsp_avg(un,1:2)=respstructsingle.gaze_rsp_avg;
    end
end
disp(' ')

%%%%%%%%%%%%%%%%%%%%%%%%
%%% GENERATE FIGURES %%%
%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 1 - Summary Figure')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.05 0.15 0.6 0.7]); set(gca,'FontName','Arial','FontSize',8);
subplot(3,2,1); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(3)=length(find(strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(4)=length(find(strcmp(xldata.confneur,'Non-responsive')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title([monkeyname,' - (A) Neuron Breakdown (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('F','Bp','O','Nr','Location','Best'); set(gca,'FontSize',7)

subplot(3,2,2); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confresptype,'Excite')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(2)=length(find(strcmp(xldata.confresptype,'Suppress')==1 & strcmp(xldata.confneur,'Sensory')==1));
piedata(3)=length(find(strcmp(xldata.confresptype,'Both')==1 & strcmp(xldata.confneur,'Sensory')==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(B) Excite/Suppress/Both (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('E','S','B','Location','Best'); set(gca,'FontSize',7)

%%% Face-Preferring Neurons
subplot(3,3,4); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_expr<=0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_expr>0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(C) Facial Expression ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigFE','nonsig','Location','Best'); set(gca,'FontSize',7)

subplot(3,3,5); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gaze<=0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gaze>0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(D) Gaze Direction ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigGD','nonsig','Location','Best'); set(gca,'FontSize',7)

subplot(3,3,6); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id<=0.05));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id>0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(E) Identity ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Preferring Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigI','nonsig','Location','Best'); set(gca,'FontSize',7)

%%% Face-Responsive Neurons (all neurons that have a valid face response)
subplot(3,3,7); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_expr>0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(F) Facial Expression ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigFE','nonsig','Location','Best'); set(gca,'FontSize',7)

subplot(3,3,8); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05  & xldata.anova_gaze<=0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05  & xldata.anova_gaze>0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(G) Gaze Direction ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigGD','nonsig','Location','Best'); set(gca,'FontSize',7)

subplot(3,3,9); piedata=[]; %
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05  & xldata.anova_id<=0.05));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05  & xldata.anova_id>0.05));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title({['(H) Identity ANOVA (n=',num2str(sum(piedata)),')'],'(Face-Responsive Neurons)'},'FontSize',fontsize_med,'FontWeight','Bold')
legend('sigI','nonsig','Location','Best'); set(gca,'FontSize',7)

jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig1pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig1pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 2 - Distribution of Neurons relative to Face Patches)')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.5]); set(gca,'FontName','Arial','FontSize',8);
subplot(1,2,1); % face neurons
surfdata=[];
numgrids=unique(xldata.gridloc);
for g=1:length(numgrids),
    gridloc=numgrids(g);
    surfdata(g,1:2)=plx_convertgrid2ap(gridloc);
    temp1=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.gridloc,gridloc)==1 & xldata.validface<=0.05));
    temp2=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.gridloc,gridloc)==1));
    surfdata(g,3)=temp1/temp2;
    clear temp1 temp2
    %if isinf(surfdata(g,3))==1, surfdata(g,3)=1; end
    if isnan(surfdata(g,3))==1, surfdata(g,3)=0; end
end
gridmap=plx500_surfdata2gridmap(surfdata);
pcolor(gridmap); shading flat; set(gca,'XDir','reverse');
axis square; set(gca,'CLim',[0 1])
mp=colormap; mp(1,:)=[0.7529 0.7529 0.7529]; colormap(mp)
set(gca,'YTick',1:15,'YTickLabel',5:19,'XTick',15:29,'XTickLabel',15:29)
ylabel('Distance from interaural axis (mm)','fontsize',6);
xlabel('Distance from midline (mm)','fontsize',6);
title({['Distribution of Face-Responsive Neurons'],[]},'FontSize',fontsize_med,'FontWeight','Bold')
colorbar('SouthOutside','FontSize',6)

subplot(1,2,2); % face patches
surfdata=[];
numgrids=unique(facegrids);
for g=1:length(numgrids),
    gridloc=numgrids(g);
    surfdata(g,1:2)=plx_convertgrid2ap(gridloc);
    surfdata(g,3)=1;
end
gridmap=plx500_surfdata2gridmap(surfdata);
pcolor(gridmap); shading flat; set(gca,'XDir','reverse');
axis square; set(gca,'CLim',[0 1])
mp=colormap; mp(1,:)=[0.7529 0.7529 0.7529]; colormap(mp)
set(gca,'YTick',1:15,'YTickLabel',5:19,'XTick',15:29,'XTickLabel',15:29)
ylabel('Distance from interaural axis (mm)','fontsize',6);
xlabel('Distance from midline (mm)','fontsize',6);
title({['Location of Face Patches'],[]},'FontSize',fontsize_med,'FontWeight','Bold')
colorbar('SouthOutside','FontSize',6)

jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig2pop_faces570_patches.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig2pop_faces570_patches.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 3 - Summary Statistics of In vs. Out Face Patch(es)')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);

subplot(2,3,1); piedata=[]; % number of neurons in vs. out
piedata(1)=length(find(ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(ismember(xldata.gridloc,facegrids)~=1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(A)Neurons Inside vs. Outside Face Patch'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('IN','OUT','Location','Best'); set(gca,'FontSize',7)

subplot(2,3,2); piedata=[]; % category selectivity for in vs. out patch
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1));
piedata(3)=length(find(strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(B) Inside Patch (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('F','Bp','O','Location','Best'); set(gca,'FontSize',7)

subplot(2,3,3); piedata=[]; % category selectivity for in vs. out patch
piedata(1)=length(find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1));
piedata(2)=length(find(strcmp(xldata.confprefcat,'Bodyparts')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1));
piedata(3)=length(find(strcmp(xldata.confprefcat,'Objects')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(C) Outside Patch (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('F','Bp','O','Location','Best'); set(gca,'FontSize',7)

subplot(2,3,4)
% Face Selectivity Index of all face preferring neurons
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
temp_indata=xldata.cat_rsp_avg(pointer,:); indata=[];
for nn=1:length(pointer),
    indata(nn)=(temp_indata(nn,1)-(0.5*sum(temp_indata(nn,2:3))))/(temp_indata(nn,1)+(0.5*sum(temp_indata(nn,2:3))));
end
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
temp_outdata=xldata.cat_rsp_avg(pointer,:); outdata=[];
for nn=1:length(pointer),
    outdata(nn)=(temp_outdata(nn,1)-(0.5*sum(temp_outdata(nn,2:3))))/(temp_outdata(nn,1)+(0.5*sum(temp_outdata(nn,2:3))));
end
hold on
bar(1:2,[mean(indata) mean(outdata)])
errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
title('Face Selectivity Index for Face-Preferring Neurons Inside vs. Outside Patches')
xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',7)
ylabel('Face Selectivity Index')
p=ranksum(outdata,indata);
text(1.5,0.5,['P=',num2str(p,'%1.2g')],'FontSize',7)

subplot(2,3,5) % valence effect
% Facial Expression Selectivity Index of all face preferring neurons
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
temp_indata=xldata.expr_rsp_avg(pointer,:); indata=[];
for nn=1:length(pointer),
    indata(nn)=abs((temp_indata(nn,1)-(max(temp_indata(nn,2:3))))/(temp_indata(nn,1)+(max(temp_indata(nn,2:3)))));
end

pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
temp_outdata=xldata.expr_rsp_avg(pointer,:); outdata=[];
for nn=1:length(pointer),
    outdata(nn)=abs((temp_outdata(nn,1)-(max(temp_outdata(nn,2:3))))/(temp_outdata(nn,1)+(max(temp_outdata(nn,2:3)))));
end
hold on
bar(1:2,[mean(indata) mean(outdata)])
errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
title('Valence Effect for Face-Preferring Neurons Inside vs. Outside Patches')
xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',7)
ylabel('abs(Valence Effect)')
p=ranksum(outdata,indata);
text(1.5,0.5,['P=',num2str(p,'%1.2g')],'FontSize',7)

subplot(2,3,6) % gaze direction effect
% Gaze Direction Sensitivity Selectivity Index of all face preferring neurons
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
temp_indata=xldata.gaze_rsp_avg(pointer,:); indata=[];
for nn=1:length(pointer),
    indata(nn)=abs((temp_indata(nn,1)-temp_indata(nn,2))/(temp_indata(nn,1)+temp_indata(nn,2)));
end

pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
temp_outdata=xldata.gaze_rsp_avg(pointer,:); outdata=[];
for nn=1:length(pointer),
    outdata(nn)=abs((temp_outdata(nn,1)-temp_outdata(nn,2))/(temp_outdata(nn,1)+temp_outdata(nn,2)));
end
hold on
bar(1:2,[mean(indata) mean(outdata)])
errorbar(1:2,[mean(indata) mean(outdata)],[sem(indata) sem(outdata)]);
title('Gaze Direction Index for Face-Preferring Neurons Inside vs. Outside Patches')
xlim([0.5 2.5]); set(gca,'XTick',[1 2],'XTickLabel',{'IN','OUT'}); set(gca,'FontSize',7)
ylabel('abs(Gaze Direction Sensitivity)')
p=ranksum(outdata,indata);
text(1.5,0.1,['P=',num2str(p,'%1.2g')],'FontSize',7)

jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig3pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig3pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 3 - Social Effects Statistics of In vs. Out Face Patch(es) -- ALL FACE RESPONSIVE NEURONS')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);
subplot(3,2,1); piedata=[]; % FE inside patch
[junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_expr>0.05 & ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==3));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(A) FE ANOVA IN PATCH(All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,2); piedata=[]; % FE inside patch
[junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_expr>0.05 & ismember(xldata.gridloc,facegrids)~=1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==3));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(A) FE ANOVA OUT PATCH (All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,3); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_gaze>0.05 & ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(B) GD ANOVA IN PATCH(All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,4); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_gaze>0.05 & ismember(xldata.gridloc,facegrids)~=1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(B) GD ANOVA OUT PATCH (All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,5); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_id>0.05 & ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_id<=0.05 & ismember(xldata.gridloc,facegrids)==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(C) ID ANOVA IN PATCH(All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,6); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_id>0.05 & ismember(xldata.gridloc,facegrids)~=1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & xldata.validface<=0.05 & xldata.anova_id<=0.05 & ismember(xldata.gridloc,facegrids)~=1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(C) ID ANOVA OUT PATCH (All Face-R Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig3pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig3pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 4 - Social Effects Statistics of In vs. Out Face Patch(es) _Face Pref Neurons Only')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);
subplot(3,2,1); piedata=[]; % FE inside patch
[junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr>0.05 & ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==3));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(A) FE ANOVA IN PATCH(Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,2); piedata=[]; % FE inside patch
[junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr>0.05 & ismember(xldata.gridloc,facegrids)~=1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==3));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(A) FE ANOVA OUT PATCH (Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,3); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze>0.05 & ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(B) GD ANOVA IN PATCH(Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,4); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze>0.05 & ismember(xldata.gridloc,facegrids)~=1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(B) GD ANOVA OUT PATCH (Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,5); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id>0.05 & ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id<=0.05 & ismember(xldata.gridloc,facegrids)==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(C) ID ANOVA IN PATCH(Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,6); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id>0.05 & ismember(xldata.gridloc,facegrids)~=1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')==1 & xldata.anova_id<=0.05 & ismember(xldata.gridloc,facegrids)~=1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(C) ID ANOVA OUT PATCH (Face-P Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig4pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig4pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 5 - Social Effects Statistics of In vs. Out Face Patch(es) _Only Face-Responsive, no face pref Neurons Only')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);
subplot(3,2,1); piedata=[]; % FE inside patch
[junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_expr>0.05 & ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==3));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(A) FE ANOVA IN PATCH(only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,2); piedata=[]; % FE inside patch
[junk,maxindex]=max(xldata.expr_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_expr>0.05 & ismember(xldata.gridloc,facegrids)~=1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
piedata(4)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_expr<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==3));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(4)),'(',num2str(piedata(4)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(A) FE ANOVA OUT PATCH (only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(N)','max(T)','max(FG)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,3); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_gaze>0.05 & ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)==1 & maxindex==2));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(B) GD ANOVA IN PATCH(only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,4); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_gaze>0.05 & ismember(xldata.gridloc,facegrids)~=1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==1));
piedata(3)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_gaze<=0.05 & ismember(xldata.gridloc,facegrids)~=1 & maxindex==2));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(B) GD ANOVA OUT PATCH (only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','max(D)','max(A)','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,5); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_id>0.05 & ismember(xldata.gridloc,facegrids)==1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_id<=0.05 & ismember(xldata.gridloc,facegrids)==1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(C) ID ANOVA IN PATCH(only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
subplot(3,2,6); piedata=[]; % GD inside patch
[junk,maxindex]=max(xldata.gaze_rsp_avg'); maxindex=maxindex';
piedata(1)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_id>0.05 & ismember(xldata.gridloc,facegrids)~=1));
piedata(2)=length(find(strcmp(xldata.confneur,'Sensory')==1 & strcmp(xldata.confprefcat,'Faces')~=1 & xldata.validface<=0.05 & xldata.anova_id<=0.05 & ismember(xldata.gridloc,facegrids)~=1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title(['(C) ID ANOVA OUT PATCH (only FaceR Neurons) (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('nonsig','sig','Location','Best'); set(gca,'FontSize',7)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig5pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig5pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 6 - Facial Expression Magnitude Effect')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);

subplot(3,4,1); % average magnitude for face-preferring neurons (IN)
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.expr_rsp_avg(pointer,:);
bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
hold on
bar(mean(bardata(:,1:3)))
errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Pref (IN) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,2); % average magnitude for face-preferring neurons (OUT)
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
bardata=xldata.expr_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:3)))
errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Pref (OUT) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,3); % average magnitude for face-preferring neurons (IN)
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.expr_rsp_avg(pointer,:);
bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
hold on
bar(mean(bardata(:,4:6)))
errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Pref (IN) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 1.7])
subplot(3,4,4); % average magnitude for face-preferring neurons (OUT)
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
bardata=xldata.expr_rsp_avg(pointer,:);
bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
hold on
bar(mean(bardata(:,4:6)))
errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Pref (OUT) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 1.7])

subplot(3,4,5); % average magnitude for face-responsive neurons (IN)
pointer=find(xldata.validface<=0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.expr_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:3)))
errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Resp (IN) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,6); % average magnitude for face-responsive neurons (OUT)
pointer=find(xldata.validface<=0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
bardata=xldata.expr_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:3)))
errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Resp (OUT) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,7); % average magnitude for face-responsive neurons (IN)
pointer=find(xldata.validface<=0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.expr_rsp_avg(pointer,:);
bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
hold on
bar(mean(bardata(:,4:6)))
errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Resp (IN) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 1.7])
subplot(3,4,8); % average magnitude for face-responsive neurons (OUT)
pointer=find(xldata.validface<=0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
bardata=xldata.expr_rsp_avg(pointer,:);
bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
hold on
bar(mean(bardata(:,4:6)))
errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Resp (OUT) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 1.7])

subplot(3,4,9); % average magnitude for non-face responsive (IN)
pointer=find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.expr_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:3)))
errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('NonFace (IN) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,10); % average magnitude for non-face responsive (IN)
pointer=find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.expr_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:3)))
errorbar(1:3,[mean(bardata(:,1)) mean(bardata(:,2)) mean(bardata(:,3))],[sem(bardata(:,1)) sem(bardata(:,2)) sem(bardata(:,3))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('NonFace (OUT) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,11); % average magnitude for non-face responsive (IN)
pointer=find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.expr_rsp_avg(pointer,:);
bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
hold on
bar(mean(bardata(:,4:6)))
errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('NonFace (IN) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 1.7])
subplot(3,4,12); % average magnitude for non-face responsive (IN)
pointer=find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.expr_rsp_avg(pointer,:);
bardata(:,4)=bardata(:,1)./bardata(:,1); bardata(:,5)=bardata(:,2)./bardata(:,1); bardata(:,6)=bardata(:,3)./bardata(:,1);
hold on
bar(mean(bardata(:,4:6)))
errorbar(1:3,[mean(bardata(:,4)) mean(bardata(:,5)) mean(bardata(:,6))],[sem(bardata(:,4)) sem(bardata(:,5)) sem(bardata(:,6))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('NonFace (OUT) - FE','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=signrank(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 1.7])

jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig6pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig6pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure



disp('Figure 7 - Gaze Direction Magnitude Effect')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);

subplot(3,4,1); % average magnitude for face-preferring neurons (IN)
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.gaze_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:2)))
errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Pref (IN) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,2); % average magnitude for face-preferring neurons (OUT)
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
bardata=xldata.gaze_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:2)))
errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Pref (OUT) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,3); % average magnitude for face-preferring neurons (IN)
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.gaze_rsp_avg(pointer,:);
bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
hold on
bar(mean(bardata(:,3:4)))
errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Pref (IN) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 1.7])
subplot(3,4,4); % average magnitude for face-preferring neurons (OUT)
pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
bardata=xldata.gaze_rsp_avg(pointer,:);
bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
hold on
bar(mean(bardata(:,3:4)))
errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Pref (OUT) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 1.7])

subplot(3,4,5); % average magnitude for face-responsive neurons (IN)
pointer=find(xldata.validface<=0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.gaze_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:2)))
errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Resp (IN) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,6); % average magnitude for face-responsive neurons (OUT)
pointer=find(xldata.validface<=0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
bardata=xldata.gaze_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:2)))
errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Resp (OUT) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,7); % average magnitude for face-responsive neurons (IN)
pointer=find(xldata.validface<=0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.gaze_rsp_avg(pointer,:);
bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
hold on
bar(mean(bardata(:,3:4)))
errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Resp (IN) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 1.7])
subplot(3,4,8); % average magnitude for face-responsive neurons (OUT)
pointer=find(xldata.validface<=0.05 & strcmp(xldata.confprefcat,'Faces')~=1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1);
bardata=xldata.gaze_rsp_avg(pointer,:);
bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
hold on
bar(mean(bardata(:,3:4)))
errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Resp (OUT) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 1.7])

subplot(3,4,9); % average magnitude for non-face responsive (IN)
pointer=find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.gaze_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:2)))
errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('NonFace (IN) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,10); % average magnitude for non-face responsive (IN)
pointer=find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.gaze_rsp_avg(pointer,:);
hold on
bar(mean(bardata(:,1:2)))
errorbar(1:2,[mean(bardata(:,1)) mean(bardata(:,2))],[sem(bardata(:,1)) sem(bardata(:,2))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('NonFace (OUT) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0 25])
subplot(3,4,11); % average magnitude for non-face responsive (IN)
pointer=find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.gaze_rsp_avg(pointer,:);
bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
hold on
bar(mean(bardata(:,3:4)))
errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('NonFace (IN) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 2.7])
subplot(3,4,12); % average magnitude for non-face responsive (IN)
pointer=find(xldata.validface>0.05 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1);
bardata=xldata.gaze_rsp_avg(pointer,:);
bardata(:,3)=bardata(:,1)./bardata(:,1); bardata(:,4)=bardata(:,2)./bardata(:,1);
hold on
bar(mean(bardata(:,3:4)))
errorbar(1:2,[mean(bardata(:,3)) mean(bardata(:,4))],[sem(bardata(:,3)) sem(bardata(:,4))]);
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('NonFace (OUT) - GD','FontSize',10)
[p,h]=signrank(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
ylim([0.7 2.7])

jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig7pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig7pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure













return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 4 - Expression Selectivity')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.25 0.8 0.6]); set(gca,'FontName','Arial','FontSize',8);
face_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1);
% histogram of SIdirection values
subplot(2,4,1)
tsidata=xldata.expr_si(face_pointer,1);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('All Face Neurons, Neutral vs. Threat'); axis square
text(0.3,10,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,1)),'%1.2g')],'FontSize',8)
subplot(2,4,2)
tsidata=xldata.expr_si(face_pointer,2);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('All Face Neurons, Neutral vs. Fear'); axis square
text(0.3,10,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,2)),'%1.2g')],'FontSize',8)
subplot(2,4,3)
tsidata=xldata.expr_si(face_pointer,3);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x) ;xlim([-1 1]);
title('All Face Neurons, Neutral vs. Both'); axis square
text(0.3,10,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,3)),'%1.2g')],'FontSize',8)
subplot(2,4,4)
tsidata=xldata.expr_si(face_pointer,4);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('All Face Neurons, Neutral vs. Max(Threat/Fear)'); axis square
text(0.3,10,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,4)),'%1.2g')],'FontSize',8)
face_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_expr<=0.05);














%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 3 - Summary Bargraphs/Piecharts showing patterns among Significant Neurons')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.2 0.25 0.5 0.8]); set(gca,'FontName','Arial','FontSize',8);
% Right now - selects Face preferring neurons
expr_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_expr<=0.05);
gaze_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gaze<=0.05);

subplot(4,3,1); hold on % expression - average raw responses
bardata=xldata.expr_rsp_avg(expr_pointer,:);
bar(1:3,mean(bardata,1));
errorbar(1:3,mean(bardata,1),sem(bardata));
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Pref - Facial Expression (Raw Firing Rates)','FontSize',10)
[p,h]=ranksum(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(4,3,2); hold on % expression - normalized (to neutral)
bardata(:,4)=bardata(:,1)./bardata(:,1);
bardata(:,5)=bardata(:,2)./bardata(:,1);
bardata(:,6)=bardata(:,3)./bardata(:,1);
bar(1:3,mean(bardata(:,4:6),1));
errorbar(1:3,mean(bardata(:,4:6),1),sem(bardata(:,4:6)));
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Pref - Facial Expression (Raw Firing Rates)','FontSize',10)
[p,h]=ranksum(bardata(:,4),bardata(:,5));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,5),bardata(:,6));
text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,4),bardata(:,6));
text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(4,3,3) % expression - pie chart showing distribution of max response
[val,ind]=max(bardata(:,1:3),[],2); clear piedata
piedata(1)=length(find(ind==1));
piedata(2)=length(find(ind==2));
piedata(3)=length(find(ind==3));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['Face Pref - Max Facial Expression (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('Neutral','Threat','FearGrin','Best'); set(gca,'FontSize',7)

subplot(4,3,4); hold on % gaze - average raw responses
bardata=xldata.gaze_rsp_avg(gaze_pointer,:);
bar(1:2,mean(bardata,1));
errorbar(1:2,mean(bardata,1),sem(bardata));
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Pref - Gaze Direction (Raw Firing Rates)','FontSize',10)
[p,h]=ranksum(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(4,3,5); hold on % gaze - normalized (to directed)
bardata(:,3)=bardata(:,1)./bardata(:,1);
bardata(:,4)=bardata(:,2)./bardata(:,1);
bar(1:2,mean(bardata(:,3:4),1))
errorbar(1:2,mean(bardata(:,3:4),1),sem(bardata(:,3:4)));
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Pref - Gaze Direction (Raw Firing Rates)','FontSize',10)
[p,h]=ranksum(bardata(:,3),bardata(:,4));
text(1.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(4,3,6) % gaze - pie chart showing distribution of max response
clear piedata
piedata(1)=length(find(bardata(:,4)>1));
piedata(2)=length(find(bardata(:,4)<1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title(['Face Pref - Gaze Direction (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('Directed','Averted','Location','Best'); set(gca,'FontSize',7)

% Right now - selects Face preferring neurons
expr_pointer=find(xldata.validface<=0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_expr<=0.05);
gaze_pointer=find(xldata.validface<=0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gaze<=0.05);

% NOTE - because experimenter can override automated classification, it is
% possible that the number of neurons found here may be LESS than above.
% Must devise a way to counteract this possibility

clear bardata piedata
subplot(4,3,7); hold on % expression - average raw responses
bardata=xldata.expr_rsp_avg(expr_pointer,:);
bar(1:3,mean(bardata,1));
errorbar(1:3,mean(bardata,1),sem(bardata));
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Resp - Facial Expression (Raw Firing Rates)','FontSize',10)
[p,h]=ranksum(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,2),bardata(:,3));
text(2.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,1),bardata(:,3));
text(2,mean(bardata(:,2))+sem(bardata(:,2)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(4,3,8); hold on % expression - normalized (to neutral)
bardata(:,4)=bardata(:,1)./bardata(:,1);
bardata(:,5)=bardata(:,2)./bardata(:,1);
bardata(:,6)=bardata(:,3)./bardata(:,1);
bar(1:3,mean(bardata(:,4:6),1));
errorbar(1:3,mean(bardata(:,4:6),1),sem(bardata(:,4:6)));
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Neutral','Threat','FearGrin'},'FontSize',7,'XTick',1:3)
title('Face Resp - Facial Expression (Raw Firing Rates)','FontSize',10)
[p,h]=ranksum(bardata(:,4),bardata(:,5));
text(1.5,mean(bardata(:,4))+sem(bardata(:,4)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,5),bardata(:,6));
text(2.5,mean(bardata(:,6))+sem(bardata(:,6)),['P=',num2str(p,'%1.2g')],'FontSize',8)
[p,h]=ranksum(bardata(:,4),bardata(:,6));
text(2,mean(bardata(:,5))+sem(bardata(:,5)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(4,3,9) % expression - pie chart showing distribution of max response
[val,ind]=max(bardata(:,1:3),[],2); clear piedata
piedata(1)=length(find(ind==1));
piedata(2)=length(find(ind==2));
piedata(3)=length(find(ind==3));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(3)),'(',num2str(piedata(3)/sum(piedata)*100,'%1.2g'),'%)']})
title(['Face Resp - Max Facial Expression (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('Neutral','Threat','FearGrin','Best'); set(gca,'FontSize',7)

subplot(4,3,10); hold on % gaze - average raw responses
bardata=xldata.gaze_rsp_avg(gaze_pointer,:);
bar(1:2,mean(bardata,1));
errorbar(1:2,mean(bardata,1),sem(bardata));
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Pref - Gaze Direction (Raw Firing Rates)','FontSize',10)
[p,h]=ranksum(bardata(:,1),bardata(:,2));
text(1.5,mean(bardata(:,1))+sem(bardata(:,1)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(4,3,11); hold on % gaze - normalized (to directed)
bardata(:,3)=bardata(:,1)./bardata(:,1);
bardata(:,4)=bardata(:,2)./bardata(:,1);
bar(1:2,mean(bardata(:,3:4),1))
errorbar(1:2,mean(bardata(:,3:4),1),sem(bardata(:,3:4)));
ylabel('Average Response (sp/s)','FontSize',8);
set(gca,'XTickLabel',{'Directed','Averted'},'FontSize',7,'XTick',1:2)
title('Face Resp - Gaze Direction (Raw Firing Rates)','FontSize',10)
[p,h]=ranksum(bardata(:,3),bardata(:,4));
text(1.5,mean(bardata(:,3))+sem(bardata(:,3)),['P=',num2str(p,'%1.2g')],'FontSize',8)
subplot(4,3,12) % gaze - pie chart showing distribution of max response
clear piedata
piedata(1)=length(find(bardata(:,4)>1));
piedata(2)=length(find(bardata(:,4)<1));
pie(piedata,...
    {['n=',num2str(piedata(1)),'(',num2str(piedata(1)/sum(piedata)*100,'%1.2g'),'%)'] ...
    ['n=',num2str(piedata(2)),'(',num2str(piedata(2)/sum(piedata)*100,'%1.2g'),'%)']})
title(['Face Resp - Gaze Direction (n=',num2str(sum(piedata)),')'],'FontSize',fontsize_med,'FontWeight','Bold')
legend('Directed','Averted','Location','Best'); set(gca,'FontSize',7)

jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig2pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig2pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 3 - Expression Selectivity')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.25 0.8 0.6]); set(gca,'FontName','Arial','FontSize',8);
face_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1);
% histogram of SIdirection values
subplot(2,4,1)
tsidata=xldata.expr_si(face_pointer,1);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('All Face Neurons, Neutral vs. Threat'); axis square
text(0.3,10,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,1)),'%1.2g')],'FontSize',8)
subplot(2,4,2)
tsidata=xldata.expr_si(face_pointer,2);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('All Face Neurons, Neutral vs. Fear'); axis square
text(0.3,10,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,2)),'%1.2g')],'FontSize',8)
subplot(2,4,3)
tsidata=xldata.expr_si(face_pointer,3);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x) ;xlim([-1 1]);
title('All Face Neurons, Neutral vs. Both'); axis square
text(0.3,10,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,3)),'%1.2g')],'FontSize',8)
subplot(2,4,4)
tsidata=xldata.expr_si(face_pointer,4);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('All Face Neurons, Neutral vs. Max(Threat/Fear)'); axis square
text(0.3,10,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,4)),'%1.2g')],'FontSize',8)
face_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_expr<=0.05);
% histogram of SIdirection values
subplot(2,4,5)
tsidata=xldata.expr_si(face_pointer,1);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons, Neutral vs. Threat'); axis square
text(0.3,5,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,1)),'%1.2g')],'FontSize',8)
subplot(2,4,6)
tsidata=xldata.expr_si(face_pointer,2);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons, Neutral vs. Fear'); axis square
text(0.3,5,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,2)),'%1.2g')],'FontSize',8)
subplot(2,4,7)
tsidata=xldata.expr_si(face_pointer,3);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x) ;xlim([-1 1]);
title('Sig Face Neurons, Neutral vs. Both'); axis square
text(0.3,5,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,3)),'%1.2g')],'FontSize',8)
subplot(2,4,8)
tsidata=xldata.expr_si(face_pointer,4);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons, Neutral vs. Max(Threat/Fear)'); axis square
text(0.3,5,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,4)),'%1.2g')],'FontSize',8)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig3pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig3pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 4 - Gaze Direction')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.25 0.8 0.6]); set(gca,'FontName','Arial','FontSize',8);
face_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1);
subplot(1,2,1)
tsidata=xldata.gaze_si(face_pointer);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('All Face Neurons, Directed vs. Averted'); axis square
text(0.3,10,['avg si: ',num2str(mean(xldata.gaze_si(face_pointer)),'%1.2g')],'FontSize',8)
subplot(1,2,2)
face_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_gaze<=0.05);
tsidata=xldata.gaze_si(face_pointer);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons, Directed vs. Averted'); axis square
text(0.3,3,['avg si: ',num2str(mean(xldata.gaze_si(face_pointer)),'%1.2g')],'FontSize',8)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig4pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig4pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 5 - ID')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.25 0.8 0.6]); set(gca,'FontName','Arial','FontSize',8);
face_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1);
subplot(1,2,1)
tsidata=xldata.id_si(face_pointer);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('All Face Neurons, ID'); axis square
text(0.3,10,['avg si: ',num2str(mean(xldata.id_si(face_pointer)),'%1.2g')],'FontSize',8)
subplot(1,2,2)
face_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_id<=0.05);
tsidata=xldata.id_si(face_pointer);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons, ID'); axis square
text(0.3,3,['avg si: ',num2str(mean(xldata.id_si(face_pointer)),'%1.2g')],'FontSize',8)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig5pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig5pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Figure 6 - Expression Selectivity per patch')
figure; clf; cla; %
set(gcf,'Units','Normalized','Position',[0.1 0.25 0.8 0.6]); set(gca,'FontName','Arial','FontSize',8);
face_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)==1 & xldata.anova_expr<=0.05);
% histogram of SIdirection values
subplot(2,4,1)
tsidata=xldata.expr_si(face_pointer,1);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons in patch, Neutral vs. Threat'); axis square
text(0.3,1,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,1)),'%1.2g')],'FontSize',8)
subplot(2,4,2)
tsidata=xldata.expr_si(face_pointer,2);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons in patch, Neutral vs. Fear'); axis square
text(0.3,1,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,2)),'%1.2g')],'FontSize',8)
subplot(2,4,3)
tsidata=xldata.expr_si(face_pointer,3);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x) ;xlim([-1 1]);
title('Sig Face Neurons in patch, Neutral vs. Both'); axis square
text(0.3,1,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,3)),'%1.2g')],'FontSize',8)
subplot(2,4,4)
tsidata=xldata.expr_si(face_pointer,4);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons in patch, Neutral vs. Max(Threat/Fear)'); axis square
text(0.3,1,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,4)),'%1.2g')],'FontSize',8)
face_pointer=find(strcmp(xldata.confprefcat,'Faces')==1 & strcmp(xldata.confneur,'Sensory')==1 & ismember(xldata.gridloc,facegrids)~=1 & xldata.anova_expr<=0.05);
% histogram of SIdirection values
subplot(2,4,5)
tsidata=xldata.expr_si(face_pointer,1);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons out patch, Neutral vs. Threat'); axis square
text(0.3,1,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,1)),'%1.2g')],'FontSize',8)
subplot(2,4,6)
tsidata=xldata.expr_si(face_pointer,2);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons out patch, Neutral vs. Fear'); axis square
text(0.3,1,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,2)),'%1.2g')],'FontSize',8)
subplot(2,4,7)
tsidata=xldata.expr_si(face_pointer,3);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x) ;xlim([-1 1]);
title('Sig Face Neurons out patch, Neutral vs. Both'); axis square
text(0.3,1,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,3)),'%1.2g')],'FontSize',8)
subplot(2,4,8)
tsidata=xldata.expr_si(face_pointer,4);
x=histc(tsidata,-1:0.2:1); bar(-1:0.2:1,x); xlim([-1 1]);
title('Sig Face Neurons out patch, Neutral vs. Max(Threat/Fear)'); axis square
text(0.3,1,['avg si: ',num2str(mean(xldata.expr_si(face_pointer,4)),'%1.2g')],'FontSize',8)
jpgfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig6pop_faces570.jpg'];
illfigname=[hmiconfig.rootdir,'faces570_project',filesep,'Fig6pop_faces570.ai'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
print(gcf,illfigname,'-dill') % generates an Adobe Illustrator file of the figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%
% Analyes to add:
% 1) population spike density functions - data will have to be normalized (to neutral expr, directed, average id)
% 2) average response/response histograms - what is the predominant pattern of responses according to expression *i.e., does it follow fMRI? (hadj-bouziane et al)
%
% how does it compare to previous results?
%
%
% 4)
%
%

return


%%% NESTED FUNCTIONS %%%
