function [cm_all,cm_trials]=f570_PatternClass_PrepMatrix(hmiconfig,xldata,figlabel,figurepath)
% function to conduct Pattern Classifier Analysis
% as per M.Stokes, script by AHB, June 2012
% This particular function creates a 3D matrix that contains the spike density function 
% for every correct trial for all neurons (covering time_range).
% Analysis Principles:
% 1) equal number of trials per condition
% 2) bootstrap to determine confidence intervals

time_range=hmiconfig.pClass_time_range;
time_win=hmiconfig.pClass_time_win;
max_numtrials=550;

cd(figurepath)
num_neurons=length(xldata.plxname); % number of units to include in analysis

% Step 1 - load data and store epoch response
cm_all=NaN(num_neurons,length(time_range),max_numtrials);
cm_trials=NaN(num_neurons,max_numtrials);
h = waitbar(0,'Preparing matrix...');
for un=1:num_neurons,
    newname=char(xldata.plxname(un)); newunit=char(xldata.unitname(un));
    load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570graphdata.mat']);
    load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
    tempspk=graphstructsingle.spden_trial(:,800:3000);
    %tempcnd=graphstructsingle.allconds_avg(:,800:3000);
    temp_id=respstructsingle.trial_id;
    correct_trials=find(temp_id(:,17)==6);
    clear graphstructsingle respstructsingle
    cm_trials(un,1:length(correct_trials))=temp_id(correct_trials,1);
    for ti=1:length(time_range)-1,
        for tt=1:length(correct_trials),
            cm_all(un,ti,tt)=mean(mean(tempspk(correct_trials(tt),200+time_range(ti)-time_win:200+time_range(ti)+time_win)));
        end
    end
    clear newname newunit tempspk temp_id correct_trials
    waitbar(un/num_neurons,h)
end
save([hmiconfig.faces570spks,filesep,figlabel,'-570cmAll.mat'],'cm_all','cm_trials')
return

