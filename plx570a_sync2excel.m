function plx570sync2excel(monkinitial,option);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plx570sync2excel(files,sheetinitial,option) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% written by AHB, November 2009, Based on plx500_syncexcel
% ROWNUMS: Can be range of numbers referring to the EXCEL row numbers
% SHEETINITIAL: First letter of the monkey whose data you wish to sync
% OPTION: Specifics direction of sync ('TOXL' Excel/'FROMXL' Excel Only)

% Syncs data between the RESPSTRUCTSINGLE structure created by plx570
% and the Excel spreadsheet storing all the data.  Currently, the program
% performs the following operations:
% TO EXCEL
% - automated neuron type (sensory, inhibited, non-responsive)
% - automated preferred category (faces, fruit, places, objects, body-parts)
% TO RESPSTRUCTSINGLE (output to *-responsedata.mat)
% - Grid location (respstruct.gridlocation)
% - CONFIRMED COLUMNS: (based on visual confirmation of automated process)
%   E4:J1000 - Confirmed Sensory (Sensory vs. Non-Responsive)
%   G4:J1000 - Confirmed Preferred Category (based on visual inspection)
%   I4:Q1000 - Quality
% sheetname = name of the sheet within the default excel file that contains
% the list of neurons to be analyzed.  note that it MUST have
% the same structure (i.e., column headers) as the default sheet

%%% SETUP DEFAULTS
warning off;
hmiconfig=generate_hmi_configplex; % generates and loads config file
if nargin==0, error('You must specify MONKEY_INITIAL and TOXL, FROMXL, GRIDLOC'); end
if nargin==1, error('You must specify either ''TOXL'' or ''FROMXL'' or ''GRIDLOC'''); end
if monkinitial=='S', sheetname='F570_Neural_S'; monkeyname='Stewie'; elseif monkinitial=='W', sheetname='F570_Neural_W'; monkeyname='Wiggum'; end
rownums=4:500;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% to EXCEL from MATLAB - First Time/Refresh %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(option,'TOXL')==1, % If this is the first time or wish to refresh all columns
    disp('Transferring data:  Matlab --> Excel')
    %%% LOAD UNIT NAMES AND PASTE ALL UNITS
    disp('...Scanning FACES570 directory...')
    dd=dir(hmiconfig.faces570spks);
    numfiles=size(dd,1); fnames=[];
    for nf=3:numfiles,
        if length(dd(nf).name)>26, % if filename is not proper length, skip it
            if strcmp(dd(nf).name(1),monkinitial)==1 && strcmp(dd(nf).name(25),'r')==1, fnames=[fnames;dd(nf).name]; end
        end
    end
    numfiles=size(fnames,1); % Number of MONKEY specific files
    %%% PASTE UNIT NAMES TO EXCEL
    disp('...Loading data from individual files...')
    for nf=1:numfiles,
        xldata.plx_fname(nf)={fnames(nf,1:12)};
        xldata.unit_id(nf)={fnames(nf,14:20)};
        % Load Data File
        load([hmiconfig.faces570spks,fnames(nf,:)]);
        xldata.neurontype(nf)={respstructsingle.response_type};
        xldata.prefcat(nf)={respstructsingle.pref_cat};
        xldata.autoresptype(nf)={respstructsingle.excitetype};
        xldata.autocatselect(nf)={respstructsingle.catselect};
        xldata.catsi(nf,:)=respstructsingle.catsi;
        xldata.validface(nf)=respstructsingle.valid_faces;
        xldata.validobject(nf)=respstructsingle.valid_objct;
        xldata.validbodyp(nf)=respstructsingle.valid_bodyp;
        xldata.anova_expr(nf)=respstructsingle.anova_expression;
        xldata.anova_id(nf)=respstructsingle.anova_identity;
        xldata.anova_gaze(nf)=respstructsingle.anova_gaze_dir;
        xldata.anova_id_gze(nf)=respstructsingle.anova_identity_expr(3);
        xldata.expr_si(nf,:)=respstructsingle.expr_si;
        xldata.id_si(nf)=respstructsingle.id_si;
        xldata.gaze_si(nf)=respstructsingle.gaze_si;
        clear respstructsingle
    end
    disp('...Pasting data into EXCEL spreadsheet...');
    xlswrite(hmiconfig.excelfile,xldata.plx_fname',sheetname,['B4:B',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.unit_id',sheetname,['C4:C',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.neurontype',sheetname,['E4:E',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.prefcat',sheetname,['G4:G',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.autoresptype',sheetname,['I4:I',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.autocatselect',sheetname,['K4:K',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.catsi(:,1),sheetname,['N4:N',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.catsi(:,2),sheetname,['O4:O',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.catsi(:,3),sheetname,['P4:P',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.validface',sheetname,['Q4:Q',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.validbodyp',sheetname,['R4:R',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.validobject',sheetname,['S4:S',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.anova_expr',sheetname,['T4:T',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.anova_id',sheetname,['U4:U',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.anova_gaze',sheetname,['V4:V',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.anova_id_gze',sheetname,['W4:W',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.expr_si(:,1),sheetname,['X4:X',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.expr_si(:,2),sheetname,['Y4:Y',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.expr_si(:,3),sheetname,['Z4:Z',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.expr_si(:,4),sheetname,['AA4:AA',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.id_si',sheetname,['AB4:AB',num2str(4+numfiles)])
    xlswrite(hmiconfig.excelfile,xldata.gaze_si',sheetname,['AC4:AC',num2str(4+numfiles)])
    disp('...Saving EXCEL data...');
    outputfname = [hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_faces570excelsummary.mat'];
    save(outputfname,'xldata')
    disp('Task complete.');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% from EXCEL to MATLAB %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(option,'FROMXL')==1,
    disp('Transferring data:  Excel --> Matlab')
    disp('...Loading data from Excel spreadsheet...')
    tic
    [crap,xldata.PlxFile]=xlsread(hmiconfig.excelfile,sheetname,['B',num2str(rownums(1)),':B',num2str(rownums(end))]); % alpha, PlexonFilename
    [crap,xldata.UnitName]=xlsread(hmiconfig.excelfile,sheetname,['C',num2str(rownums(1)),':C',num2str(rownums(end))]); % alpha, Unitname
    [crap,xldata.GridLoc]=xlsread(hmiconfig.excelfile,sheetname,['D',num2str(rownums(1)),':D',num2str(rownums(end))]); % alphanumeric, Gridlocation
    [crap,xldata.confNeurType]=xlsread(hmiconfig.excelfile,sheetname,['F',num2str(rownums(1)),':F',num2str(rownums(end))]); % alphanumeric, conf neuron type
    [crap,xldata.confPref]=xlsread(hmiconfig.excelfile,sheetname,['H',num2str(rownums(1)),':H',num2str(rownums(end))]); % alphanumeric, conf pref category
    [crap,xldata.confResp]=xlsread(hmiconfig.excelfile,sheetname,['J',num2str(rownums(1)),':J',num2str(rownums(end))]); % alphanumeric, conf response type
    [crap,xldata.confSelect]=xlsread(hmiconfig.excelfile,sheetname,['L',num2str(rownums(1)),':L',num2str(rownums(end))]); % alphanumeric, conf category selectivity
    xldata.confQuality=xlsread(hmiconfig.excelfile,sheetname,['M',num2str(rownums(1)),':M',num2str(rownums(end))]); % numeric, quality
    toc
    disp('...Pasting data into individual files...');
    for un=1:size(xldata.PlxFile,1),
        % Load individual file
        newname=char(xldata.PlxFile(un)); newunit=char(xldata.UnitName(un));
        disp(['...',newname(1:12),'-',newunit,'...'])
        load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
        % Paste Excel data into Matlab File
        respstructsingle.gridlocation=xldata.GridLoc(un);
        respstructsingle.conf_neurtype=xldata.confNeurType(un);
        respstructsingle.conf_prefcat=xldata.confPref(un);
        respstructsingle.conf_resptype=xldata.confResp(un);
        respstructsingle.conf_catselect=xldata.confSelect(un);
        respstructsingle.quality=xldata.confQuality(un);
        respstructsingle.datemodified=date;
        save([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat'],'respstructsingle');
    end
    disp('Task complete.');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PASTE GRIDLOC/DEPTH to RESPONSESTRUCT and EXCEL %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(option,'GRIDLOC')==1,
    disp('Loading filenames from Excel:')
    plx_importrecordingnotes(monkinitial);
    [crap,files.PlxFile]=xlsread(hmiconfig.excelfile,sheetname,['B4:B',num2str(rownums(end))]); % alpha, PlexonFilename
    [crap,files.UnitName]=xlsread(hmiconfig.excelfile,sheetname,['C4:C',num2str(rownums(end))]); % alpha, Unitname
    [crap,files.GridLoc]=xlsread(hmiconfig.excelfile,sheetname,['D4:D',num2str(rownums(end))]); % alphanumeric, Gridlocation
    try
        load([hmiconfig.rootdir,filesep,monkeyname,'_RecordingNotes.mat'])
    catch
        error('Recording notes not found.  Run plx_importantrecordingnotes.m prior to running this program.')
    end

    disp('...Pasting GRIDLOC into individual RESPSTRUCTSINGLE files...');
    gridloc_list={};
    for un=1:size(files.PlxFile,1),
        % Load individual file
        newname=char(files.PlxFile(un)); newunit=char(files.UnitName(un));
        disp(['...',newname(1:12),'-',newunit,'...'])
        load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
        % Find matching entry
        file_num=find(strcmp(xldata.PlxFile,[newname,'.plx']));
        unit_id=char(newunit(6));
        % Find Gridloc
        gridloc=eval(['xldata.Grid',num2str(unit_id),'(',num2str(file_num(1)),')']);
        gridloc_list(un)=gridloc;
        % Paste GridLoc
        respstructsingle.gridloc=gridloc;
        respstructsingle.datemodified=date;
        save([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat'],'respstructsingle');
    end
    xlswrite(hmiconfig.excelfile,gridloc_list',sheetname,['D4:D',num2str(3+size(files.PlxFile,1))])
    disp('Task complete.');
end
return