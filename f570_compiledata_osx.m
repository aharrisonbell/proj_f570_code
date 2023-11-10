function [xldata,monkeyname,facegrids]=f570_compiledata_osx(monkinitial);
% This program compiles all the output from FACES570.M for all neurons listed in the
% EXCEL spreadsheet.
% This version is SPECIFIC for running under Matlab v2012a, under Mac OSX

hmiconfig=generate_f570_config;
facegrids={};
if monkinitial=='S',
    monkeyname='Stewie'; sheetname='F570_Neural_S';
    %%%  LOAD FILE LIST
    disp(['...Loading file list from Excel: ',sheetname]);
    [~,xldata.plxname]=xlsread(hmiconfig.excelfile,sheetname,'B4:B1000');
    [~,xldata.unitname]=xlsread(hmiconfig.excelfile,sheetname,'C4:C1000');
    [~,xldata.gridloc]=xlsread(hmiconfig.excelfile,sheetname,'D4:D1000');
    [~,xldata.autoneur]=xlsread(hmiconfig.excelfile,sheetname,'E4:E1000');
    [~,xldata.confneur]=xlsread(hmiconfig.excelfile,sheetname,'F4:F1000');
    [~,xldata.autoprefcat]=xlsread(hmiconfig.excelfile,sheetname,'G4:G1000');
    [~,xldata.confprefcat]=xlsread(hmiconfig.excelfile,sheetname,'H4:H1000');
    [~,xldata.autoresptype]=xlsread(hmiconfig.excelfile,sheetname,'I4:I1000');
    [~,xldata.confresptype]=xlsread(hmiconfig.excelfile,sheetname,'J4:J1000');
    [~,xldata.autocatselect]=xlsread(hmiconfig.excelfile,sheetname,'K4:K1000');
    [~,xldata.confcatselect]=xlsread(hmiconfig.excelfile,sheetname,'L4:L1000');
    xldata.quality=xlsread(hmiconfig.excelfile,sheetname,'M4:M1000');
    xldata.face_si=xlsread(hmiconfig.excelfile,sheetname,'N4:N1000');
    xldata.bodyp_si=xlsread(hmiconfig.excelfile,sheetname,'O4:O1000');
    xldata.objct_si=xlsread(hmiconfig.excelfile,sheetname,'P4:P1000');
    xldata.validface=xlsread(hmiconfig.excelfile,sheetname,'Q4:Q1000');
    xldata.validbodyp=xlsread(hmiconfig.excelfile,sheetname,'R4:R1000');
    xldata.validobject=xlsread(hmiconfig.excelfile,sheetname,'S4:S1000');
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
        xldata.anova_fe(un)=respstructsingle.anova_fe;
        xldata.anova_id(un)=respstructsingle.anova_id;
        xldata.anova_gd(un)=respstructsingle.anova_gd;
        xldata.anovam_fe_id(un,:)=respstructsingle.anovam_fe_id';
        xldata.anovam_fe_gd(un,:)=respstructsingle.anovam_fe_gd';
        xldata.anovam_id_gd(un,:)=respstructsingle.anovam_id_gd';
        xldata.anovam_fe_id_gd(un,:)=respstructsingle.anovam_fe_id_gd';
        xldata.anova_fe_id(un,:)=respstructsingle.anova_fe_id';
        xldata.anova_fe_gd(un,:)=respstructsingle.anova_fe_gd';
        xldata.anova_id_gd(un,:)=respstructsingle.anova_id_gd';
        xldata.anova_fe_id_gd(un,:)=respstructsingle.anova_fe_id_gd';
        xldata.unit_number(un)=un;
        xldata.avg_rsp(un,1)=mean(respstructsingle.m_epoch1(hmiconfig.facesND570));
        xldata.avg_rsp(un,2)=mean(respstructsingle.m_epoch1(hmiconfig.facesNA570));
        xldata.avg_rsp(un,3)=mean(respstructsingle.m_epoch1(hmiconfig.facesTD570));
        xldata.avg_rsp(un,4)=mean(respstructsingle.m_epoch1(hmiconfig.facesTA570));
        xldata.avg_rsp(un,5)=mean(respstructsingle.m_epoch1(hmiconfig.facesFD570));
        xldata.avg_rsp(un,6)=mean(respstructsingle.m_epoch1(hmiconfig.facesFA570));
        xldata.avg_rsp(un,7)=mean(respstructsingle.m_epoch1(hmiconfig.bodyp570));
        xldata.avg_rsp(un,8)=mean(respstructsingle.m_epoch1(hmiconfig.objct570));
        
        xldata.norm_avg_rsp(un,1)=mean(respstructsingle.m_epoch1(hmiconfig.facesND570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,2)=mean(respstructsingle.m_epoch1(hmiconfig.facesNA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,3)=mean(respstructsingle.m_epoch1(hmiconfig.facesTD570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,4)=mean(respstructsingle.m_epoch1(hmiconfig.facesTA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,5)=mean(respstructsingle.m_epoch1(hmiconfig.facesFD570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,6)=mean(respstructsingle.m_epoch1(hmiconfig.facesFA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,7)=mean(respstructsingle.m_epoch1(hmiconfig.bodyp570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,8)=mean(respstructsingle.m_epoch1(hmiconfig.objct570))/xldata.avg_rsp(un,1);
        
        
        %%% Individual Trial Data for Adaptation Analysis
        xldata.trial_response(un,:)=zeros(1,2000); % create blank
        xldata.trial_response(un,1:length(respstructsingle.trial_m_epoch1))=respstructsingle.trial_m_epoch1;
        xldata.trial_baseline(un,1:length(respstructsingle.trial_m_epoch1))=respstructsingle.trial_m_baseline;
        xldata.trial_response_nobase(un,1:length(respstructsingle.trial_resp_nobaseline))=respstructsingle.trial_resp_nobaseline;
        
        xldata.numtrials(un,1)=length(respstructsingle.trial_m_epoch1);
        xldata.trial_id1(un,:)=zeros(1,2000); % create blank
        xldata.trial_id1(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,1)';
        xldata.trial_id2(un,:)=zeros(1,2000); % create blank
        xldata.trial_id2(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,2)';
        xldata.trial_id3(un,:)=zeros(1,2000); % create blank
        xldata.trial_id3(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,3)';
        xldata.trial_id4(un,:)=zeros(1,2000); % create blank
        xldata.trial_id4(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,4)';
        xldata.trial_id5(un,:)=zeros(1,2000); % create blank
        xldata.trial_id5(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,5)';
        xldata.trial_id6(un,:)=zeros(1,2000); % create blank
        xldata.trial_id6(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,6)';
        xldata.trial_id7(un,:)=zeros(1,2000); % create blank
        xldata.trial_id7(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,7)';
        xldata.trial_id8(un,:)=zeros(1,2000); % create blank
        xldata.trial_id8(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,8)';        
        xldata.trial_id9(un,:)=zeros(1,2000); % create blank
        xldata.trial_id9(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,9)';
        xldata.trial_id10(un,:)=zeros(1,2000); % create blank
        xldata.trial_id10(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,10)';
        xldata.trial_id11(un,:)=zeros(1,2000); % create blank
        xldata.trial_id11(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,11)';
        xldata.trial_id12(un,:)=zeros(1,2000); % create blank
        xldata.trial_id12(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,12)';
        xldata.trial_id13(un,:)=zeros(1,2000); % create blank
        xldata.trial_id13(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,13)';
        xldata.trial_id14(un,:)=zeros(1,2000); % create blank
        xldata.trial_id14(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,14)';        
        xldata.trial_id15(un,:)=zeros(1,2000); % create blank
        xldata.trial_id15(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,15)';
         
        xldata.wf_params(un,:)=respstructsingle.wf_params;
    end
    facegrids={'A3R4','A3R5','A3R6','A4R4','A4R5','A4R6','A5R4','A5R5','A5R6','A6R5','A6R6','A7R5','A7R6'}; % confirmed May 3, 2010

elseif monkinitial=='W',
    monkeyname='Wiggum'; sheetname='F570_Neural_W';
    %%%  LOAD FILE LIST
    disp(['...Loading file list from Excel: ',sheetname]);
    [~,xldata.plxname]=xlsread(hmiconfig.excelfile,sheetname,'B4:B1000');
    [~,xldata.unitname]=xlsread(hmiconfig.excelfile,sheetname,'C4:C1000');
    [~,xldata.gridloc]=xlsread(hmiconfig.excelfile,sheetname,'D4:D1000');
    [~,xldata.autoneur]=xlsread(hmiconfig.excelfile,sheetname,'E4:E1000');
    [~,xldata.confneur]=xlsread(hmiconfig.excelfile,sheetname,'F4:F1000');
    [~,xldata.autoprefcat]=xlsread(hmiconfig.excelfile,sheetname,'G4:G1000');
    [~,xldata.confprefcat]=xlsread(hmiconfig.excelfile,sheetname,'H4:H1000');
    [~,xldata.autoresptype]=xlsread(hmiconfig.excelfile,sheetname,'I4:I1000');
    [~,xldata.confresptype]=xlsread(hmiconfig.excelfile,sheetname,'J4:J1000');
    [~,xldata.autocatselect]=xlsread(hmiconfig.excelfile,sheetname,'K4:K1000');
    [~,xldata.confcatselect]=xlsread(hmiconfig.excelfile,sheetname,'L4:L1000');
    xldata.quality=xlsread(hmiconfig.excelfile,sheetname,'M4:M1000');
    xldata.face_si=xlsread(hmiconfig.excelfile,sheetname,'N4:N1000');
    xldata.bodyp_si=xlsread(hmiconfig.excelfile,sheetname,'O4:O1000');
    xldata.objct_si=xlsread(hmiconfig.excelfile,sheetname,'P4:P1000');
    xldata.validface=xlsread(hmiconfig.excelfile,sheetname,'Q4:Q1000');
    xldata.validbodyp=xlsread(hmiconfig.excelfile,sheetname,'R4:R1000');
    xldata.validobject=xlsread(hmiconfig.excelfile,sheetname,'S4:S1000');
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
        xldata.anova_fe(un)=respstructsingle.anova_fe;
        xldata.anova_id(un)=respstructsingle.anova_id;
        xldata.anova_gd(un)=respstructsingle.anova_gd;
        xldata.anovam_fe_id(un,:)=respstructsingle.anovam_fe_id';
        xldata.anovam_fe_gd(un,:)=respstructsingle.anovam_fe_gd';
        xldata.anovam_id_gd(un,:)=respstructsingle.anovam_id_gd';
        xldata.anovam_fe_id_gd(un,:)=respstructsingle.anovam_fe_id_gd';
        xldata.anova_fe_id(un,:)=respstructsingle.anova_fe_id';
        xldata.anova_fe_gd(un,:)=respstructsingle.anova_fe_gd';
        xldata.anova_id_gd(un,:)=respstructsingle.anova_id_gd';
        xldata.anova_fe_id_gd(un,:)=respstructsingle.anova_fe_id_gd';
        xldata.unit_number(un)=un;
        xldata.avg_rsp(un,1)=mean(respstructsingle.m_epoch1(hmiconfig.facesND570));
        xldata.avg_rsp(un,2)=mean(respstructsingle.m_epoch1(hmiconfig.facesNA570));
        xldata.avg_rsp(un,3)=mean(respstructsingle.m_epoch1(hmiconfig.facesTD570));
        xldata.avg_rsp(un,4)=mean(respstructsingle.m_epoch1(hmiconfig.facesTA570));
        xldata.avg_rsp(un,5)=mean(respstructsingle.m_epoch1(hmiconfig.facesFD570));
        xldata.avg_rsp(un,6)=mean(respstructsingle.m_epoch1(hmiconfig.facesFA570));
        xldata.avg_rsp(un,7)=mean(respstructsingle.m_epoch1(hmiconfig.bodyp570));
        xldata.avg_rsp(un,8)=mean(respstructsingle.m_epoch1(hmiconfig.objct570));
            
        xldata.norm_avg_rsp(un,1)=mean(respstructsingle.m_epoch1(hmiconfig.facesND570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,2)=mean(respstructsingle.m_epoch1(hmiconfig.facesNA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,3)=mean(respstructsingle.m_epoch1(hmiconfig.facesTD570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,4)=mean(respstructsingle.m_epoch1(hmiconfig.facesTA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,5)=mean(respstructsingle.m_epoch1(hmiconfig.facesFD570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,6)=mean(respstructsingle.m_epoch1(hmiconfig.facesFA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,7)=mean(respstructsingle.m_epoch1(hmiconfig.bodyp570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,8)=mean(respstructsingle.m_epoch1(hmiconfig.objct570))/xldata.avg_rsp(un,1);
        
                
        %%% Individual Trial Data for Adaptation Analysis
        xldata.trial_response(un,:)=zeros(1,2000); % create blank
        xldata.trial_response(un,1:length(respstructsingle.trial_m_epoch1))=respstructsingle.trial_m_epoch1;
        xldata.trial_baseline(un,1:length(respstructsingle.trial_m_epoch1))=respstructsingle.trial_m_baseline;
        xldata.trial_response_nobase(un,1:length(respstructsingle.trial_resp_nobaseline))=respstructsingle.trial_resp_nobaseline;
        xldata.numtrials(un,1)=length(respstructsingle.trial_m_epoch1);
        xldata.trial_id1(un,:)=zeros(1,2000); % create blank
        xldata.trial_id1(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,1)';
        xldata.trial_id2(un,:)=zeros(1,2000); % create blank
        xldata.trial_id2(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,2)';
        xldata.trial_id3(un,:)=zeros(1,2000); % create blank
        xldata.trial_id3(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,3)';
        xldata.trial_id4(un,:)=zeros(1,2000); % create blank
        xldata.trial_id4(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,4)';
        xldata.trial_id5(un,:)=zeros(1,2000); % create blank
        xldata.trial_id5(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,5)';
        xldata.trial_id6(un,:)=zeros(1,2000); % create blank
        xldata.trial_id6(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,6)';
        xldata.trial_id7(un,:)=zeros(1,2000); % create blank
        xldata.trial_id7(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,7)';
        xldata.trial_id8(un,:)=zeros(1,2000); % create blank
        xldata.trial_id8(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,8)';        
        xldata.trial_id9(un,:)=zeros(1,2000); % create blank
        xldata.trial_id9(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,9)';
        xldata.trial_id10(un,:)=zeros(1,2000); % create blank
        xldata.trial_id10(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,10)';
        xldata.trial_id11(un,:)=zeros(1,2000); % create blank
        xldata.trial_id11(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,11)';
        xldata.trial_id12(un,:)=zeros(1,2000); % create blank
        xldata.trial_id12(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,12)';
        xldata.trial_id13(un,:)=zeros(1,2000); % create blank
        xldata.trial_id13(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,13)';
        xldata.trial_id14(un,:)=zeros(1,2000); % create blank
        xldata.trial_id14(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,14)';        
        xldata.trial_id15(un,:)=zeros(1,2000); % create blank
        xldata.trial_id15(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,15)';
        
        xldata.wf_params(un,:)=respstructsingle.wf_params;
    end
    facegrids={'A0R0','A0R1','A1R0','A2R1','A3R0','P7R0','P7R2'}; %  updated July 29, 2010

elseif monkinitial=='B'
    monkeyname='BothMonkeys';
    sheetname='F570_Neural_S';
    %%%  LOAD FILE LIST
    disp(['...Loading file list from Excel: ',sheetname]);
    [~,xldata.plxname]=xlsread(hmiconfig.excelfile,sheetname,'B4:B1000');
    [~,xldata.unitname]=xlsread(hmiconfig.excelfile,sheetname,'C4:C1000');
    [~,xldata.gridloc]=xlsread(hmiconfig.excelfile,sheetname,'D4:D1000');
    [~,xldata.autoneur]=xlsread(hmiconfig.excelfile,sheetname,'E4:E1000');
    [~,xldata.confneur]=xlsread(hmiconfig.excelfile,sheetname,'F4:F1000');
    [~,xldata.autoprefcat]=xlsread(hmiconfig.excelfile,sheetname,'G4:G1000');
    [~,xldata.confprefcat]=xlsread(hmiconfig.excelfile,sheetname,'H4:H1000');
    [~,xldata.autoresptype]=xlsread(hmiconfig.excelfile,sheetname,'I4:I1000');
    [~,xldata.confresptype]=xlsread(hmiconfig.excelfile,sheetname,'J4:J1000');
    [~,xldata.autocatselect]=xlsread(hmiconfig.excelfile,sheetname,'K4:K1000');
    [~,xldata.confcatselect]=xlsread(hmiconfig.excelfile,sheetname,'L4:L1000');
    xldata.quality=xlsread(hmiconfig.excelfile,sheetname,'M4:M1000');
    xldata.face_si=xlsread(hmiconfig.excelfile,sheetname,'N4:N1000');
    xldata.bodyp_si=xlsread(hmiconfig.excelfile,sheetname,'O4:O1000');
    xldata.objct_si=xlsread(hmiconfig.excelfile,sheetname,'P4:P1000');
    xldata.validface=xlsread(hmiconfig.excelfile,sheetname,'Q4:Q1000');
    xldata.validbodyp=xlsread(hmiconfig.excelfile,sheetname,'R4:R1000');
    xldata.validobject=xlsread(hmiconfig.excelfile,sheetname,'S4:S1000');
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
        xldata.anova_fe(un)=respstructsingle.anova_fe';
        xldata.anova_id(un)=respstructsingle.anova_id';
        xldata.anova_gd(un)=respstructsingle.anova_gd';
        xldata.anovam_fe_id(un,:)=respstructsingle.anovam_fe_id';
        xldata.anovam_fe_gd(un,:)=respstructsingle.anovam_fe_gd';
        xldata.anovam_id_gd(un,:)=respstructsingle.anovam_id_gd';
        xldata.anovam_fe_id_gd(un,:)=respstructsingle.anovam_fe_id_gd';
        xldata.anova_fe_id(un,:)=respstructsingle.anova_fe_id';
        xldata.anova_fe_gd(un,:)=respstructsingle.anova_fe_gd';
        xldata.anova_id_gd(un,:)=respstructsingle.anova_id_gd';
        xldata.anova_fe_id_gd(un,:)=respstructsingle.anova_fe_id_gd';
        xldata.unit_number(un)=un;
        xldata.avg_rsp(un,1)=mean(respstructsingle.m_epoch1(hmiconfig.facesND570));
        xldata.avg_rsp(un,2)=mean(respstructsingle.m_epoch1(hmiconfig.facesNA570));
        xldata.avg_rsp(un,3)=mean(respstructsingle.m_epoch1(hmiconfig.facesTD570));
        xldata.avg_rsp(un,4)=mean(respstructsingle.m_epoch1(hmiconfig.facesTA570));
        xldata.avg_rsp(un,5)=mean(respstructsingle.m_epoch1(hmiconfig.facesFD570));
        xldata.avg_rsp(un,6)=mean(respstructsingle.m_epoch1(hmiconfig.facesFA570));
        xldata.avg_rsp(un,7)=mean(respstructsingle.m_epoch1(hmiconfig.bodyp570));
        xldata.avg_rsp(un,8)=mean(respstructsingle.m_epoch1(hmiconfig.objct570));
            
        xldata.norm_avg_rsp(un,1)=mean(respstructsingle.m_epoch1(hmiconfig.facesND570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,2)=mean(respstructsingle.m_epoch1(hmiconfig.facesNA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,3)=mean(respstructsingle.m_epoch1(hmiconfig.facesTD570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,4)=mean(respstructsingle.m_epoch1(hmiconfig.facesTA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,5)=mean(respstructsingle.m_epoch1(hmiconfig.facesFD570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,6)=mean(respstructsingle.m_epoch1(hmiconfig.facesFA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,7)=mean(respstructsingle.m_epoch1(hmiconfig.bodyp570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,8)=mean(respstructsingle.m_epoch1(hmiconfig.objct570))/xldata.avg_rsp(un,1);
    
            
        %%% Individual Trial Data for Adaptation Analysis
        xldata.trial_response(un,:)=zeros(1,2000); % create blank
        xldata.trial_response(un,1:length(respstructsingle.trial_m_epoch1))=respstructsingle.trial_m_epoch1;
        xldata.trial_baseline(un,1:length(respstructsingle.trial_m_epoch1))=respstructsingle.trial_m_baseline;
        xldata.trial_response_nobase(un,1:length(respstructsingle.trial_resp_nobaseline))=respstructsingle.trial_resp_nobaseline;
        xldata.numtrials(un,1)=length(respstructsingle.trial_m_epoch1);
        xldata.trial_id1(un,:)=zeros(1,2000); % create blank
        xldata.trial_id1(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,1)';
        xldata.trial_id2(un,:)=zeros(1,2000); % create blank
        xldata.trial_id2(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,2)';
        xldata.trial_id3(un,:)=zeros(1,2000); % create blank
        xldata.trial_id3(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,3)';
        xldata.trial_id4(un,:)=zeros(1,2000); % create blank
        xldata.trial_id4(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,4)';
        xldata.trial_id5(un,:)=zeros(1,2000); % create blank
        xldata.trial_id5(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,5)';
        xldata.trial_id6(un,:)=zeros(1,2000); % create blank
        xldata.trial_id6(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,6)';
        xldata.trial_id7(un,:)=zeros(1,2000); % create blank
        xldata.trial_id7(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,7)';
        xldata.trial_id8(un,:)=zeros(1,2000); % create blank
        xldata.trial_id8(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,8)';        
        xldata.trial_id9(un,:)=zeros(1,2000); % create blank
        xldata.trial_id9(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,9)';
        xldata.trial_id10(un,:)=zeros(1,2000); % create blank
        xldata.trial_id10(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,10)';
        xldata.trial_id11(un,:)=zeros(1,2000); % create blank
        xldata.trial_id11(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,11)';
        xldata.trial_id12(un,:)=zeros(1,2000); % create blank
        xldata.trial_id12(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,12)';
        xldata.trial_id13(un,:)=zeros(1,2000); % create blank
        xldata.trial_id13(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,13)';
        xldata.trial_id14(un,:)=zeros(1,2000); % create blank
        xldata.trial_id14(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,14)';        
        xldata.trial_id15(un,:)=zeros(1,2000); % create blank
        xldata.trial_id15(un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,15)';
         
        xldata.wf_params(un,:)=respstructsingle.wf_params;
    end
    
    %%%  LOAD FILE LIST
    sheetname='F570_Neural_W';
    startrow=size(xldata.plxname,1)+1;
    disp(['...Loading file list from Excel: ',sheetname]);
    [~,start1]=xlsread(hmiconfig.excelfile,sheetname,'B4:B1000');
    endrow=size(start1,1)+startrow-1;
    [~,xldata.plxname(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['B4:B',num2str(startrow+3)]);
    [~,xldata.unitname(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['C4:C',num2str(startrow+3)]);
    [~,xldata.gridloc(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['D4:D',num2str(startrow+3)]);
    [~,xldata.autoneur(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['E4:E',num2str(startrow+3)]);
    [~,xldata.confneur(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['F4:F',num2str(startrow+3)]);
    [~,xldata.autoprefcat(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['G4:G',num2str(startrow+3)]);
    [~,xldata.confprefcat(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['H4:H',num2str(startrow+3)]);
    [~,xldata.autoresptype(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['I4:I',num2str(startrow+3)]);
    [~,xldata.confresptype(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['J4:J',num2str(startrow+3)]);
    [~,xldata.autocatselect(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['K4:K',num2str(startrow+3)]);
    [~,xldata.confcatselect(startrow:endrow)]=xlsread(hmiconfig.excelfile,sheetname,['L4:L',num2str(startrow+3)]);
    xldata.quality(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['M4:M',num2str(startrow+3)]);
    xldata.face_si(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['N4:N',num2str(startrow+3)]);
    xldata.bodyp_si(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['O4:O',num2str(startrow+3)]);
    xldata.objct_si(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['P4:P',num2str(startrow+3)]);
    xldata.validface(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['Q4:Q',num2str(startrow+3)]);
    xldata.validbodyp(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['R4:R',num2str(startrow+3)]);
    xldata.validobject(startrow:endrow)=xlsread(hmiconfig.excelfile,sheetname,['S4:S',num2str(startrow+3)]);
    xldata.expr_si((startrow:endrow),1)=xlsread(hmiconfig.excelfile,sheetname,['X4:X',num2str(startrow+3)]);
    xldata.expr_si((startrow:endrow),2)=xlsread(hmiconfig.excelfile,sheetname,['Y4:Y',num2str(startrow+3)]);
    xldata.expr_si((startrow:endrow),3)=xlsread(hmiconfig.excelfile,sheetname,['Z4:Z',num2str(startrow+3)]);
    xldata.expr_si((startrow:endrow),4)=xlsread(hmiconfig.excelfile,sheetname,['AA4:AA',num2str(startrow+3)]);
    xldata.id_si((startrow:endrow),1)=xlsread(hmiconfig.excelfile,sheetname,['AB4:AB',num2str(startrow+3)]);
    xldata.gaze_si((startrow:endrow),1)=xlsread(hmiconfig.excelfile,sheetname,['AC4:AC',num2str(startrow+3)]);

    %%% Load information from RESPSTRUCTSINGLE files
    startrow=startrow-1;
    for un=1:size(start1),
        % Load individual file
        newname=char(xldata.plxname(startrow+un)); newunit=char(xldata.unitname(startrow+un));
        disp(['...',newname(1:12),'-',newunit,'...'])
        load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
        xldata.cat_rsp_avg(startrow+un,1:3)=respstructsingle.cat_rsp_avg;
        xldata.expr_rsp_avg(startrow+un,1:3)=respstructsingle.expr_rsp_avg;
        xldata.gaze_rsp_avg(startrow+un,1:2)=respstructsingle.gaze_rsp_avg;
        xldata.anova_fe(startrow+un)=respstructsingle.anova_fe';
        xldata.anova_id(startrow+un)=respstructsingle.anova_id';
        xldata.anova_gd(startrow+un)=respstructsingle.anova_gd';
        xldata.anovam_fe_id(startrow+un,:)=respstructsingle.anovam_fe_id';
        xldata.anovam_fe_gd(startrow+un,:)=respstructsingle.anovam_fe_gd';
        xldata.anovam_id_gd(startrow+un,:)=respstructsingle.anovam_id_gd';
        xldata.anovam_fe_id_gd(startrow+un,:)=respstructsingle.anovam_fe_id_gd';
        xldata.anova_fe_id(startrow+un,:)=respstructsingle.anova_fe_id';
        xldata.anova_fe_gd(startrow+un,:)=respstructsingle.anova_fe_gd';
        xldata.anova_id_gd(startrow+un,:)=respstructsingle.anova_id_gd';
        xldata.anova_fe_id_gd(startrow+un,:)=respstructsingle.anova_fe_id_gd';
        xldata.unit_number(startrow+un)=startrow+un;
        xldata.avg_rsp(startrow+un,1)=mean(respstructsingle.m_epoch1(hmiconfig.facesND570));
        xldata.avg_rsp(startrow+un,2)=mean(respstructsingle.m_epoch1(hmiconfig.facesNA570));
        xldata.avg_rsp(startrow+un,3)=mean(respstructsingle.m_epoch1(hmiconfig.facesTD570));
        xldata.avg_rsp(startrow+un,4)=mean(respstructsingle.m_epoch1(hmiconfig.facesTA570));
        xldata.avg_rsp(startrow+un,5)=mean(respstructsingle.m_epoch1(hmiconfig.facesFD570));
        xldata.avg_rsp(startrow+un,6)=mean(respstructsingle.m_epoch1(hmiconfig.facesFA570));
        xldata.avg_rsp(startrow+un,7)=mean(respstructsingle.m_epoch1(hmiconfig.bodyp570));
        xldata.avg_rsp(startrow+un,8)=mean(respstructsingle.m_epoch1(hmiconfig.objct570));
            
        xldata.norm_avg_rsp(startrow+un,1)=mean(respstructsingle.m_epoch1(hmiconfig.facesND570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(startrow+un,2)=mean(respstructsingle.m_epoch1(hmiconfig.facesNA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(startrow+un,3)=mean(respstructsingle.m_epoch1(hmiconfig.facesTD570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(startrow+un,4)=mean(respstructsingle.m_epoch1(hmiconfig.facesTA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(startrow+un,5)=mean(respstructsingle.m_epoch1(hmiconfig.facesFD570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(startrow+un,6)=mean(respstructsingle.m_epoch1(hmiconfig.facesFA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(startrow+un,7)=mean(respstructsingle.m_epoch1(hmiconfig.bodyp570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(startrow+un,8)=mean(respstructsingle.m_epoch1(hmiconfig.objct570))/xldata.avg_rsp(un,1);
        
        %%% Individual Trial Data for Adaptation Analysis
        xldata.trial_response(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_response(startrow+un,1:length(respstructsingle.trial_m_epoch1))=respstructsingle.trial_m_epoch1;
        xldata.trial_baseline(startrow+un,1:length(respstructsingle.trial_m_epoch1))=respstructsingle.trial_m_baseline;
        xldata.trial_response_nobase(startrow+un,1:length(respstructsingle.trial_resp_nobaseline))=respstructsingle.trial_resp_nobaseline;
        xldata.numtrials(startrow+un,1)=length(respstructsingle.trial_m_epoch1);
        xldata.trial_id1(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id1(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,1)';
        xldata.trial_id2(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id2(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,2)';
        xldata.trial_id3(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id3(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,3)';
        xldata.trial_id4(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id4(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,4)';
        xldata.trial_id5(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id5(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,5)';
        xldata.trial_id6(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id6(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,6)';
        xldata.trial_id7(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id7(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,7)';
        xldata.trial_id8(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id8(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,8)';        
        xldata.trial_id9(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id9(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,9)';
        xldata.trial_id10(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id10(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,10)';
        xldata.trial_id11(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id11(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,11)';
        xldata.trial_id12(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id12(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,12)';
        xldata.trial_id13(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id13(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,13)';
        xldata.trial_id14(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id14(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,14)';
        xldata.trial_id15(startrow+un,:)=zeros(1,2000); % create blank
        xldata.trial_id15(startrow+un,1:length(respstructsingle.trial_id))=respstructsingle.trial_id(:,15)';
        
        xldata.wf_params(startrow+un,:)=respstructsingle.wf_params;
        
    end
end
disp(' ')
save([hmiconfig.faces570spks,filesep,'Faces570data_',monkeyname,'.mat'],'xldata','monkeyname','facegrids');
return