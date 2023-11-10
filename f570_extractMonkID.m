function [output,output_mean]=f570_extractMonkID(xldata,pointer,hmiconfig)
% function to isolate individual identity responses for a series of files

numunits=length(pointer);
output=zeros(numunits,3,2,8); % one row per unit, one col per ID
for un=1:numunits,
    newname=char(xldata.plxname(pointer(un))); newunit=char(xldata.unitname(pointer(un)));
    load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
    
    for fe=1:3,
        for gd=1:2,
            for id=1:8,
                point= respstructsingle.trial_id(:,2)==fe & respstructsingle.trial_id(:,3)==id & respstructsingle.trial_id(:,4)==gd;
                output(un,fe,gd,id)=mean(respstructsingle.trial_m_epoch1(point));
            end
        end
    end
end


output_mean=zeros(numunits,6,8);
for un=1:numunits,
    output_mean(un,1,1:8)=squeeze(output(un,1,1,1:8))';
    output_mean(un,2,1:8)=squeeze(output(un,1,2,1:8))';
    output_mean(un,3,1:8)=squeeze(output(un,2,1,1:8))';
    output_mean(un,4,1:8)=squeeze(output(un,2,2,1:8))';
    output_mean(un,5,1:8)=squeeze(output(un,3,1,1:8))';
    output_mean(un,6,1:8)=squeeze(output(un,3,2,1:8))';
end

return