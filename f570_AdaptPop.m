function [output,neuron_output]=f570_AdaptPop(data,pointer,fieldname,classfield,class_val)
% nested function to calculate average adaptation (repetition suppresion)
% to repeated stimulus exposures for a subset of neurons.  Note this
% requires the normalization of firing rates, unlike that analysis
% performed on each neuron.

% if nargin==3,
%     rawdata=zeros(length(pointer),50); % maxes out at 50 repetitions
%     for un=1:length(pointer), % scroll through each neuron in the group
%         trial_responses = data.trial_response(pointer(un),:);
%         trial_baselines = data.trial_baseline(pointer(un),:);
%         
%         temp_id = getfield(data,fieldname);
%         trial_id=temp_id(pointer(un),:);
% 
%         % remove zeros
%         trial_responses=trial_responses(1:find(nonzeros(trial_id), 1, 'last' ));
%         trial_baselines=trial_baselines(1:find(nonzeros(trial_id), 1, 'last' ));
%         trial_id=trial_id(1:find(nonzeros(trial_id), 1, 'last' ));   
% 
%         [tempbd temprr]=f570_calcAdapt(trial_responses,trial_baselines,trial_id);
%         bd=tempbd(:,1)/tempbd(1,1); % normalise to response from first presentation
%         bd=tempbd(:,1);
%         rawdata(un,1:temprr)=bd; % paste data into matrix for all 
%         colcount(un)=temprr;
%     end
%     rawdata=rawdata(:,1:max(colcount));
%     output=zeros(max(colcount),2);
%     for cc=1:max(colcount),
%         x=rawdata(:,cc);
%         output(cc,1)=nanmean(x(isinf(x)==0 & isnan(x)==0));
%         output(cc,2)=nanstd(x(isinf(x)==0 & isnan(x)==0))/sqrt(size(x(isinf(x)==0 & isnan(x)==0),1));
%     end
% elseif nargin==5, % for selecting only a subset of responses
rawdata=zeros(length(pointer),200)*NaN; % maxes out at 200 repetitions
rawdata_norm=zeros(length(pointer),200)*NaN; % maxes out at 200 repetitions
rawdataNB=zeros(length(pointer),200)*NaN; % maxes out at 200 repetitions
rawdata_normNB=zeros(length(pointer),200)*NaN; % maxes out at 200 repetitions
neuron_output=zeros(length(pointer),15)*NaN;

temp_class=getfield(data,classfield); % get category ID for all neurons
temp_stimrep=getfield(data,fieldname); % get stimulus repetition number for all neurons

for un=1:length(pointer), % scroll through each neuron in the group
    % Solve for class pointer
    class_id=temp_class(pointer(un),:); % select only data for current neuron
    temp_class_pointer=find(class_id==class_val);
    class_pointer=temp_class_pointer(1:find(nonzeros(temp_class_pointer), 1, 'last' )); clear temp_class_pointer % this represents all CATEGORY TRIALS
    
    % Solve for data
    trial_responses=data.trial_response(pointer(un),class_pointer); % extract each response for current neuron for only the select trials
    trial_baselines=data.trial_baseline(pointer(un),class_pointer);
    
    % Solve for repetition number
    trial_id=temp_stimrep(pointer(un),class_pointer); % ...for only the proper trials
    
    [tempbd temprr]=f570_calcAdapt(trial_responses,trial_baselines,trial_id);
    
    rawdata_norm(un,1:temprr)=tempbd(:,1)/tempbd(1,1); % normalise to response on first trial
    rawdata_normNB(un,1:temprr)=tempbd(:,3)/tempbd(1,3); % normalise to response on first trial
    rawdata_ind(un,1:temprr)=tempbd(:,5);
    rawdata(un,1:temprr)=tempbd(:,1); % no normalisation
    rawdataNB(un,1:temprr)=tempbd(:,3); % no normalisation
    rawdata_indNB(un,1:temprr)=tempbd(:,6);
    colcount(un)=temprr;
    
    neuron_output.baseline(un,1:temprr)=tempbd(:,5);
    neuron_output.no_baseline(un,1:temprr)=tempbd(:,6);

end
if max(colcount)>50, ccount=50; else ccount=max(colcount); end
rawdata=rawdata(:,1:ccount);
rawdata_norm=rawdata_norm(:,1:ccount);
rawdataNB=rawdataNB(:,1:ccount);
rawdata_normNB=rawdata_normNB(:,1:ccount);

output=zeros(ccount,3);
for cc=1:ccount,
    x=rawdata(:,cc);
    output(cc,1)=mean(x(isinf(x)==0 & isnan(x)==0));
    output(cc,2)=std(x(isinf(x)==0 & isnan(x)==0))/sqrt(length(x(isinf(x)==0 & isnan(x)==0)));
    output(cc,3)=length(x(isinf(x)==0 & isnan(x)==0)); % this is the number of neurons that still have a repeated stimulus at this point
    x=rawdata_norm(:,cc);
    output(cc,4)=mean(x(isinf(x)==0 & isnan(x)==0));
    output(cc,5)=std(x(isinf(x)==0 & isnan(x)==0))/sqrt(length(x(isinf(x)==0 & isnan(x)==0)));
    x=rawdata_ind(:,cc);
    output(cc,6)=mean(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10));
    output(cc,7)=std(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10))/sqrt(length(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10)));
    output(cc,8)=length(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10)); % this is the number of neurons that still have a repeated stimulus at this point
    
    x=rawdataNB(:,cc);
    output(cc,9)=mean(x(isinf(x)==0 & isnan(x)==0));
    output(cc,10)=std(x(isinf(x)==0 & isnan(x)==0))/sqrt(length(x(isinf(x)==0 & isnan(x)==0)));
    output(cc,11)=length(x(isinf(x)==0 & isnan(x)==0)); % this is the number of neurons that still have a repeated stimulus at this point
    x=rawdata_normNB(:,cc);
    output(cc,12)=mean(x(isinf(x)==0 & isnan(x)==0));
    output(cc,13)=std(x(isinf(x)==0 & isnan(x)==0))/sqrt(length(x(isinf(x)==0 & isnan(x)==0)));
    x=rawdata_indNB(:,cc);
    output(cc,14)=mean(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10));
    output(cc,15)=std(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10))/sqrt(length(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10)));
    output(cc,16)=length(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10)); % this is the number of neurons that still have a repeated stimulus at this point
end





%end

return
