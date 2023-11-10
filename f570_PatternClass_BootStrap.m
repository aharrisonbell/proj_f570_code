function [cm_rho,cm_pval,cm_fish]=f570_PatternClass_BootStrap(hmiconfig,cm_all,cm_trials,figlabel)
% function to conduct Pattern Classifier Analysis 
% This function performs NUM_RANDOM different repetitions, solving for correlation between
% even/odd runs
% as per M.Stokes, script by AHB, June 2012
% Analysis Principles:
% 1) equal number of trials per condition
% 2) bootstrap to determine distribution (normal)

% establish variables
time_range=hmiconfig.pClass_time_range;
num_random=1000;
num_trials=20;
num_neurons=size(cm_all,1);

cm_rho=zeros(num_random,length(time_range)-1);
cm_pval=zeros(num_random,length(time_range)-1);
cm_fish=zeros(num_random,length(time_range)-1);

h = waitbar(0,'Randomising Correlations...');
for rn=1:num_random
    for un=1:num_neurons,
        unit_data=squeeze(cm_all(un,:,:)); % isolate data for current unit
        unit_trials=find(isnan(unit_data(1,:))==1, 1 )-1; % determine number of trials for current unit
        temp_trials=randperm(unit_trials,4*num_trials);
        C1odd_vector =sort(temp_trials(1:4:end));
        C1even_vector=sort(temp_trials(2:4:end));
        C2odd_vector =sort(temp_trials(3:4:end));
        C2even_vector=sort(temp_trials(4:4:end));
        clear temp_trials       
        cond1_even(un,:)=nanmean(squeeze(cm_all(un,:,C1even_vector)),2);
        cond1_odd(un,:) =nanmean(squeeze(cm_all(un,:,C1odd_vector)),2);
        cond2_even(un,:)=nanmean(squeeze(cm_all(un,:,C2even_vector)),2);
        cond2_odd(un,:) =nanmean(squeeze(cm_all(un,:,C2odd_vector)),2);
    end  
    tempdata=f570_multicorr_diag(time_range,cond1_even,cond1_odd,cond2_even,cond2_odd);
    cm_rho(rn,:)=tempdata(:,1)';
    cm_pval(rn,:)=tempdata(:,2)';
    cm_fish(rn,:)=tempdata(:,3)';
    clear tempdata
    waitbar(rn/num_random,h)
end
save([hmiconfig.faces570spks,filesep,figlabel,'-570_BootStrap.mat'],'cm_rho','cm_pval','cm_fish')
return



