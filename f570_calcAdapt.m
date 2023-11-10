function [bardata rep_range]=f570_calcAdapt(data,baseline,trial_id)
rep_range=max(trial_id);
% Calculate with and without baseline
bardata=zeros(rep_range,3);
data_nobase=data-baseline;

for rr=1:rep_range,
    pointer=find(trial_id==rr);
    bardata(rr,1)=mean(data(pointer)); % including baseline
    bardata(rr,2)=sem(data(pointer)); % including baseline
    bardata(rr,3)=mean(data_nobase(pointer)); % after subtracting baseline
    bardata(rr,4)=sem(data_nobase(pointer)); % after subtracting baseline
end
for rr=2:rep_range,
    bardata(rr,5)=(bardata(1,1)-bardata(rr,1))/bardata(1,1); % Formula based on Sawamura et al., 2006
    bardata(rr,6)=(bardata(1,3)-bardata(rr,3))/bardata(1,3); % Formula based on Sawamura et al., 2006
end
return