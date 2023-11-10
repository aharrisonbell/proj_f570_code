function [data1,data2]=id_contrast(unit_id,unit_data,p1,p2,nTrials);

if nargin>4,
    % Create contrasts for f570 pattern classifier analysis
    pointer1=find(ismember(unit_id,p1)==1);
    pointer2=find(ismember(unit_id,p2)==1);
    [condAe,condAo,condBe,condBo]=create_vectors(pointer1,pointer2,nTrials);
    temp_even=mean(unit_data(:,condAe),2)-mean(unit_data(:,condBe),2); temp_odd=mean(unit_data(:,condAo),2)-mean(unit_data(:,condBo),2);
    data1=temp_even(1:end-1);
    data2=temp_odd(1:end-1);
else % nTrials not specified
    pointer1=find(ismember(unit_id,p1)==1);
    pointer2=find(ismember(unit_id,p2)==1);
    [condAe,condAo,condBe,condBo]=create_vectors(pointer1,pointer2);
    temp_even=mean(unit_data(:,condAe),2)-mean(unit_data(:,condBe),2); temp_odd=mean(unit_data(:,condAo),2)-mean(unit_data(:,condBo),2);
    data1=temp_even(1:end-1);
    data2=temp_odd(1:end-1);
end
return



