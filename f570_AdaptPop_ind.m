function output=f570_AdaptPop_ind(data,pointer,fieldname,classfield,class_val)
% nested function to calculate average adaptation (repetition suppresion)
% to repeated stimulus exposures for a subset of neurons.  Note this
% requires the normalization of firing rates, unlike that analysis
% performed on each neuron.
% This is based on f570_AdaptPop but calculates Adaptation Index (as per Sawamura et al., 2006)
% instead of firing rate (normalised or otherwise).

if nargin==3,
    rawdata=zeros(length(pointer),50); % maxes out at 50 repetitions
    for un=1:length(pointer), % scroll through each neuron in the group
        trial_responses = data.trial_response(pointer(un),:);
        temp_id = getfield(data,fieldname);
        trial_id=temp_id(pointer(un),:);

        % remove zeros
        trial_responses=trial_responses(1:find(nonzeros(trial_id), 1, 'last' ));
        trial_id=trial_id(1:find(nonzeros(trial_id), 1, 'last' ));   

        [tempbd temprr]=f570_calcAdapt(trial_responses,trial_id);
        bd=tempbd(:,1);
        rawdata(un,1:temprr)=bd; % paste data into matrix for all 
        colcount(un)=temprr;
    end
    rawdata=rawdata(:,1:max(colcount));
    output=zeros(max(colcount),2);
    for cc=1:max(colcount),
        x=rawdata(:,cc);
        output(cc,1)=nanmean(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10));
        output(cc,2)=nanstd(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10))/sqrt(size(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10),1));
    end
elseif nargin==5, % for selecting only a subset of responses
    rawdata=zeros(length(pointer),200)*NaN; % maxes out at 200 repetitions
    temp_class=getfield(data,classfield); % get category ID for all neurons
    temp_stimrep=getfield(data,fieldname); % get stimulus repetition number for all neurons

    for un=1:length(pointer), % scroll through each neuron in the group
        % Solve for class pointer     
        class_id=temp_class(pointer(un),:); % select only data for current neuron
        temp_class_pointer=find(class_id==class_val);
        class_pointer=temp_class_pointer(1:find(nonzeros(temp_class_pointer), 1, 'last' )); clear temp_class_pointer % this represents all CATEGORY TRIALS
        
        % Solve for data
        trial_responses=data.trial_response(pointer(un),class_pointer); % extract each response for current neuron for only the select trials
        
        % Solve for repetition number
        trial_id=temp_stimrep(pointer(un),class_pointer); % ...for only the proper trials
        
        [tempbd temprr]=f570_calcAdapt(trial_responses,trial_id);
        bd=tempbd(:,3); % use index
        rawdata(un,1:temprr)=bd;
        colcount(un)=temprr;
    end
    if max(colcount)>50, ccount=50; else ccount=max(colcount); end
    rawdata=rawdata(:,1:ccount);
    output=zeros(ccount,3);
    for cc=1:ccount,
        x=rawdata(:,cc);
        output(cc,1)=mean(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10));
        output(cc,2)=std(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10))/sqrt(length(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10)));
        output(cc,3)=length(x(isinf(x)==0 & isnan(x)==0 & abs(x)<10)); % this is the number of neurons that still have a repeated stimulus at this point
    end
end
return
