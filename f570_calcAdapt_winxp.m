function [bardata rep_range]=f570_calcAdapt_winxp(data,trial_id)
rep_range=max(trial_id);
bardata=zeros(rep_range,2);
for rr=1:rep_range,
    pointer=find(trial_id==rr);
    bardata(rr,1)=mean(data(pointer));
    bardata(rr,2)=sem(data(pointer));
end
for rr=2:rep_range,
    bardata(rr,3)=(bardata(1,1)-bardata(rr,1))/bardata(1,1); % Formula based on Sawamura et al., 2006
end
return