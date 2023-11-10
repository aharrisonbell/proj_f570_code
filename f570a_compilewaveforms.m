function f570a_compilewaveforms(monkinitial);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f570a_compilewaveforms(filez); %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% by AHB, Nov2008, edited May2012
% Collects raw waveforms for listed units and compiles the individual
% parameters into histograms.  Used for determining the identity of neurons
% based on the waveform shape (Mitchell et al., 2006 Neuron)
% TAG_ID = optional argument
%
% This program analyzes four different parameters:
% 1) Depolarization Magnitude
% 2) Depolarization Latency
% 3) Repolarization Magnitude
% 4) Repolarization Latency
%
% This program eliminates any waveforms where the latency of the
% repolarization is LESS than the depolarization (indicates a neuron that
% was thresholded from above)

warning off;
%%% SETUP DEFAULTS
hmiconfig=generate_f570_config; % generates and loads config file
samprate=40000; 
xticktime=(1/samprate)*1000000; % us per tick

%%% LOAD FILE LIST
if monkinitial=='S',
    monkeyname='Stewie'; sheetname='F570_Neural_S';
    [~,xldata.plxname]=xlsread(hmiconfig.excelfile,sheetname,'B4:B1000');
    [~,xldata.unitname]=xlsread(hmiconfig.excelfile,sheetname,'C4:C1000');
    include=xlsread(hmiconfig.excelfile,sheetname,'AN4:AN1000');
    pointer=find(include==1);
end
if monkinitial=='W',    
    monkeyname='Wiggum'; sheetname='F570_Neural_W';
    [~,xldata.plxname]=xlsread(hmiconfig.excelfile,sheetname,'B4:B1000');
    [~,xldata.unitname]=xlsread(hmiconfig.excelfile,sheetname,'C4:C1000');
    include=xlsread(hmiconfig.excelfile,sheetname,'AN4:AN1000');
    pointer=find(include==1);
end
xldata.plxname=xldata.plxname(pointer,:);
xldata.unitname=xldata.unitname(pointer,:);

%%% CREATE EMPTY MATRICES
wf_data_all=struct('raw_avg_wf',[],'align_avg_wf',[],'parameters',[]);
disp('*** plx_compilewaveforms ***')
disp(' ')
for un=1:length(xldata.plxname), % perform following operations on each nex file listed
    try%%% LOAD INDIVIDUAL FILE %%%
        newname=char(xldata.plxname(un)); newunit=char(xldata.unitname(un));
        disp(['..loading waveforms for ',newname(1:12),'-',newunit,'...'])
        raw_wf=load([hmiconfig.wave_raw,filesep,newname(1:12),'-',newunit,'_raw.mat']);
        raw_wf=raw_wf.waverawdata;
        wf_data_all.raw_avg_wf(un,:)=mean(raw_wf');
        [wf_data_all.parameters(un,1) wf_data_all.parameters(un,2)]=min(wf_data_all.raw_avg_wf(un,:));
        [wf_data_all.parameters(un,3) wf_data_all.parameters(un,4)]=max(wf_data_all.raw_avg_wf(un,:));
        wf_data_all.parameters(un,5)=wf_data_all.parameters(un,4)-wf_data_all.parameters(un,2);
        % Aligned waveforms
        wf_data_all.align_avg_wf(un,:)=wf_data_all.raw_avg_wf(un,wf_data_all.parameters(un,2)-4:wf_data_all.parameters(un,2)+15);
        wf_data_all.parameters(un,6)=wf_data_all.parameters(un,5)*xticktime;
    catch
        
    end
end

%%% FILTER UNITS
wf_data=wf_data_all;
pointer=find(wf_data_all.parameters(:,2)>wf_data_all.parameters(:,4));
wf_data.align_avg_wf(pointer,:)=[]; wf_data.parameters(pointer,:)=[]; wf_data.raw_avg_wf(pointer,:)=[];
wf_data.reject_wf=wf_data_all.align_avg_wf(pointer,:);
wf_data.reject_parameters=wf_data_all.parameters(pointer,:);

%%% NORMALIZE AND ALIGN
for un=1:size(wf_data.align_avg_wf,1),
    wf_data.norm_avg(un,:)=wf_data.align_avg_wf(un,:)/wf_data.parameters(un,3);
end
 
figure
subplot(2,2,1); hold on;
plot(-200:25:575,wf_data.raw_avg_wf')
xlim([-200 600]); ylim([-.3 .3]); xlabel('Time (us)'); ylabel('Amplitude')
title('Raw Waveforms')

subplot(2,2,2)
plot(-100:25:375,wf_data.norm_avg')
xlim([-100 400]); ylim([-4 2]); xlabel('Time (us)'); ylabel('Amplitude')
title('Normalized and Aligned Waveforms')

subplot(2,2,3)
x=histc(wf_data.parameters(:,6),100:20:400)
bar(100:20:400,x); xlim([100 400]);
xlabel('Wave Duration (us)'); ylabel('Number of Units');
text(110,40,['HDT=',num2str(HartigansDipTest(wf_data.parameters(:,6)),'%1.3g')],'FontSize',7)

subplot(2,2,4)
hold on
pointer=find(wf_data.parameters(:,6)>275);
plot(-100:25:375,wf_data.norm_avg(pointer,:)','r-')
pointer=find(wf_data.parameters(:,6)<275);
plot(-100:25:375,wf_data.norm_avg(pointer,:)','b-')
xlim([-100 400]); ylim([-4 2]); xlabel('Time (us)'); ylabel('Amplitude')




return