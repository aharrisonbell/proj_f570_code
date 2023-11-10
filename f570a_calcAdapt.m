function [bardata rep_range]=f570_calcAdapt(data,trial_id)
rep_range=max(trial_id);
bardata=zeros(rep_range,2);
for rr=1:rep_range,
    pointer=find(trial_id==rr & data>0);
    bardata(rr,1)=mean(data(pointer));
    bardata(rr,2)=sem(data(pointer));
end