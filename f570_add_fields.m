function f570_add_fields(files);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f570_add_fields(files); %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% written by AHB, Oct 2012, behaves like FACES570
% files = optional argument, list files as strings.  Otherwise, program
% will load files listed in default XL sheet, as listed in
% generate_hmi_configplex.

%%% SETUP DEFAULTS
warning off;
hmiconfig=generate_hmi_configplex; % generates and loads config file
parnumlist=[570]; % list of paradigm numbers

%%%  LOAD FILE LIST
if nargin==0,
    error('You must specify an individual filename or monkey initial (''S''/''W'').')
elseif strcmp(files,'S')==1
    disp('Analyzing all F570 files for Stewie...')
    % Pulls files from HMI_PhysiologyNotes
    include=xlsread(hmiconfig.excelfile,'Faces570','A9:A1000'); % alphanumeric, Gridlocation
    [crap,filest]=xlsread(hmiconfig.excelfile,'Faces570','B9:B1000');
    filesx=filest(find(include==1)); clear include; clear files
    for ff=1:size(filesx,1),
        temp=char(filesx(ff)); files(ff)=cellstr(temp(1:12));
    end
elseif strcmp(files,'W')==1
    disp('Analyzing all F570 files for Wiggum...')
    % Pulls files from HMI_PhysiologyNotes
    include=xlsread(hmiconfig.excelfile,'Faces570','D9:D1000'); % alphanumeric, Gridlocation
    [crap,filest]=xlsread(hmiconfig.excelfile,'Faces570','E9:E1000');
    filesx=filest(find(include==1)); clear include; clear files
    for ff=1:size(filesx,1),
        temp=char(filesx(ff)); files(ff)=cellstr(temp(1:12));
    end
end


%%% ANALYZE INDIVIDUAL FILES
disp('*****************************************************************************')
disp('f570_add_fields.m - Analysis program for FACES570-series datafiles (Oct 2012)')
disp('   - For adding additional fields to RESPSTRUCTSINGLE'
disp('*****************************************************************************')
for f=1:length(files), % perform following operations on each nex file listed
    close all % close all figure windows
    filename=char(files(f));
    disp(['Loading current version of RESPSTRUCTSINGLE: ',filename])

   
      
    
          

            