function faces570_paper_example;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% faces570_paper_example(files); %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% written by AHB, June 2012, program based on faces570, purpose to generate example
% figures for paper.

%%% SETUP DEFAULTS
close all;
hmiconfig=generate_f570_config; % generates and loads config file
xscale=-100:500; % default time window

%%%  LOAD FILE LIST
disp('Loading example files listed in Excel spreadsheet...')
% Pulls files from Faces570_Neurons.xlsx
include=xlsread(hmiconfig.excelfile,'PaperExamples','A9:A1000'); % alphanumeric, Gridlocation
[crap,filest]=xlsread(hmiconfig.excelfile,'PaperExamples','B9:B1000');
filesx=filest(find(include==1)); clear include; clear files
for ff=1:size(filesx,1),
    temp=char(filesx(ff)); files(ff)=cellstr(temp(1:20));
end
clear temp filesx filest ff

%%% ANALYZE INDIVIDUAL FILES
disp('*****************************************************************')
disp('faces570_paper_example.m - Generate print quality example figures')
disp('*****************************************************************')
for f=1:length(files), % perform following operations on each nex file listed
    close all % close all figure windows
    disp(['Analyzing spike activity from ',char(files(f))])
    filename=char(files(f));
	load([hmiconfig.faces570spks,char(files(f)),'-570responsedata.mat']);
    load([hmiconfig.faces570spks,char(files(f)),'-570graphdata.mat']);
    f570_plotneuron_example(hmiconfig,xscale,graphstructsingle,respstructsingle,char(files(f)))
end
return
