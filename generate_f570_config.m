function hmiconfig = generate_f570_config
% generate_hmi_configplex.m
% Generates Config file for all paradigms configured to work with PLEXON
% pencodes (identified by CAPITAL letters)

% ROOT DIRECTORY%rootdir = '\\psf\Home\Documents\PlexonData\';
rootdir = '/Users/ab03/Documents/PlexonData/';
hmiconfig.rootdir=rootdir;

% PLEXON DIRECTORIES
hmiconfig.outdir    = [rootdir,'BEHAV_output',filesep]; % output dir for all behavioural structures
hmiconfig.spikedir  = [rootdir,'COMPILED_output',filesep]; % output dir for spike matrices
hmiconfig.neurondir = [rootdir,'UNIT_output',filesep]; % output dir for MUA
hmiconfig.LFPdir    = [rootdir,'LFPS',filesep]; % output dir for uncorrected LFP channels
hmiconfig.LFPdir_corr=[rootdir,'LFPscorr',filesep]; % output dir for LFP channels (after reverse filtering)
hmiconfig.startend  = [rootdir,'StartEnd',filesep]; % output dir for start & end text files
hmiconfig.locationdir=[rootdir,'LocationFiles',filesep]; % output dir for location text files
hmiconfig.wavetemp   =[rootdir,'WAVEFORM_templates',filesep]; % output dir for waveform templates
hmiconfig.wave_raw   =[rootdir,'WAVEFORM_raw',filesep]; % output dir for raw waveforms
%hmiconfig.unitdir   = [rootdir,'UnitFiles',filesep]; % output dir for spiketrains/trial files
hmiconfig.rsvp500spks=[rootdir,'rsvp500spks',filesep]; % output for spiketrains for dms400 neurons
hmiconfig.rsvp500lfps=[rootdir,'rsvp500lfps',filesep]; % output for lfps for rsvp500 files
hmiconfig.rsvp500lfps_lrg=['I:\LFPdata\rsvp500lfps',filesep]; % output for lfps for rsvp500 files
hmiconfig.faces570spks=[rootdir,'faces570spks',filesep]; % output for spiketrains for faces570 neurons
hmiconfig.faces570lfps=[rootdir,'faces570lfps',filesep]; % output for lfps for faces570 files

% DEFAULT FILE LISTS
hmiconfig.excelfile = [rootdir,'Faces570_Neurons.xlsx']; % excel spreadsheet

% ANALYSIS DEFAULTS
hmiconfig.gausskernel = 10; % gaussian spike density function kernel (10ms)
hmiconfig.printer     = 0;
hmiconfig.LFP_kernel  = [rootdir,'PRA2kernelEmpPRA2HST20Gelec_2kHz.mat'];
hmiconfig.LFP_kernel_HST1X = [rootdir,'PRA2kernel_2kHz.mat'];

% LFP ANALYSIS 
hmiconfig.chronux_params=struct('tapers',[3 5],'Fs',1000,'pad',-1,'err',0,'trialave',1,'fpass',[0 120]);

% PATTERN CLASSIFIER ANALYSIS
hmiconfig.pClass_time_skip = 10; % slides TIME_SKIP ms each step
hmiconfig.pClass_time_win = 20; % plus/minus TIME_WIN ms
hmiconfig.pClass_time_range = -100:hmiconfig.pClass_time_skip:500;

% EVENT CODES - Lists the definitions for the event codes
% faces570
hmiconfig.faces      = 1:48;
hmiconfig.non_faces  = 49:88;
hmiconfig.facesND570 = [1 7 13 19 25 31 37 43];
hmiconfig.facesNA570 = [2 8 14 20 26 32 38 44];
hmiconfig.facesTD570 = [3 9 15 21 27 33 39 45];
hmiconfig.facesTA570 = [4 10 16 22 28 34 40 46];
hmiconfig.facesFD570 = [5 11 17 23 29 35 41 47];
hmiconfig.facesFA570 = [6 12 18 24 30 36 42 48];
hmiconfig.bodyp570 = 49:68;
hmiconfig.objct570 = 69:88;

hmiconfig.f570_neutral = [1 7 13 19 25 31 37 43 2 8 14 20 26 32 38 44];
hmiconfig.f570_threat = [3 9 15 21 27 33 39 45 4 10 16 22 28 34 40 46];
hmiconfig.f570_feargrin = [5 11 17 23 29 35 41 47 6 12 18 24 30 36 42 48];
hmiconfig.f570_directed =[1 7 13 19 25 31 37 43 3 9 15 21 27 33 39 45 5 11 17 23 29 35 41 47];
hmiconfig.f570_averted = [2 8 14 20 26 32 38 44 4 10 16 22 28 34 40 46 6 12 18 24 30 36 42 48];

hmiconfig.f570_face1 = 1:6;
hmiconfig.f570_face1 = 7:12;
hmiconfig.f570_face1 = 13:18;
hmiconfig.f570_face1 = 19:24;
hmiconfig.f570_face1 = 25:30;
hmiconfig.f570_face1 = 31:36;
hmiconfig.f570_face1 = 37:42;
hmiconfig.f570_face1 = 43:48;





% SAVE CONFIG FILE
configname = [rootdir,'hmi_configplex.mat'];
save(configname,'hmiconfig');
