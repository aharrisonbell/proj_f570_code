function [avgfunc semfunc]=f570_avg_spden_ID(xldata,pointer,hmiconfig,xrange,~)
%configname = [hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_spden.mat'];
% Epoch information
% spden's aligned to cue onset (=timepoint 1000)
% This version includes ordered ID
epoch=[50 400]; % early cue response window
epoch2 = epoch; % [-50 50]; % normalizer window
% Initialize matrices
graphdata=struct(...
    'id1_avg',[],'id2_avg',[],'id3_avg',[],'id4_avg',[],'id5_avg',[],'id6_avg',[],'id7_avg',[],'id8_avg',[],...
    'NORM_id1_avg',[],'NORM_id2_avg',[],'NORM_id3_avg',[],'NORM_id4_avg',[],'NORM_id5_avg',[],'NORM_id6_avg',[],'NORM_id7_avg',[],'NORM_id8_avg',[]);
    
avgfunc=[];

% Load graphdata
for ff=1:length(pointer),
    newname=char(xldata.plxname(pointer(ff))); newunit=char(xldata.unitname(pointer(ff)));
    load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570graphdata.mat']);
    load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
    
    % Order ID responses (based on Average magnitude for neutral directed)
    sort_id_responses=sort(respstructsingle.id_rsp_avg,2,'descend');
      
    index = find(respstructsingle.id_rsp_avg==sort_id_responses(1));
    graphdata.id1_avg=[graphdata.id1_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)]; % (maximum)
    
    normalizer=max(graphstructsingle.allconds_avg(hmiconfig.facesND570(index),1000+epoch2(1):1000+epoch2(2)));
    
    
    graphdata.NORM_id1_avg=[graphdata.NORM_id1_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)/normalizer]; % (maximum)
    
    index = find(respstructsingle.id_rsp_avg==sort_id_responses(2));
    graphdata.id2_avg=[graphdata.id2_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)]; % (2nd)
    
    graphdata.NORM_id2_avg=[graphdata.NORM_id2_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)/normalizer]; % (maximum)
       
    index = find(respstructsingle.id_rsp_avg==sort_id_responses(3));
    graphdata.id3_avg=[graphdata.id3_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)]; % (3rd)
    graphdata.NORM_id3_avg=[graphdata.NORM_id3_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)/normalizer]; % (maximum)
    
    index = find(respstructsingle.id_rsp_avg==sort_id_responses(4));
    graphdata.id4_avg=[graphdata.id4_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)]; % (4th)
    graphdata.NORM_id4_avg=[graphdata.NORM_id4_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)/normalizer]; % (maximum)
    
    index = find(respstructsingle.id_rsp_avg==sort_id_responses(5));
    graphdata.id5_avg=[graphdata.id5_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)]; % (5th)
    graphdata.NORM_id5_avg=[graphdata.NORM_id5_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)/normalizer]; % (maximum)
    
    index = find(respstructsingle.id_rsp_avg==sort_id_responses(6));
    graphdata.id6_avg=[graphdata.id6_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)]; % (6th)
    graphdata.NORM_id6_avg=[graphdata.NORM_id6_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)/normalizer]; % (maximum)
    
    index = find(respstructsingle.id_rsp_avg==sort_id_responses(7));
    graphdata.id7_avg=[graphdata.id7_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)]; % (7th)
    graphdata.NORM_id7_avg=[graphdata.NORM_id7_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)/normalizer]; % (maximum)
    
    index = find(respstructsingle.id_rsp_avg==sort_id_responses(8));
    graphdata.id8_avg=[graphdata.id8_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)]; % (minimum)
    graphdata.NORM_id8_avg=[graphdata.NORM_id8_avg;graphstructsingle.allconds_avg(hmiconfig.facesND570(index),:)/normalizer]; % (maximum)
 
    clear graphstructsingle respstructsingle
end

% Filter Normalised Data (to remove abnormally high responses)
for neuron_count = 1:length(pointer),
    if max(graphdata.NORM_id1_avg(neuron_count,:))>5,
        graphdata.NORM_id1_avg(neuron_count,:)=graphdata.NORM_id1_avg(neuron_count,:)*nan;
    end
    if max(graphdata.NORM_id2_avg(neuron_count,:))>5,
        graphdata.NORM_id2_avg(neuron_count,:)=graphdata.NORM_id2_avg(neuron_count,:)*nan;
    end
    if max(graphdata.NORM_id3_avg(neuron_count,:))>5,
        graphdata.NORM_id3_avg(neuron_count,:)=graphdata.NORM_id3_avg(neuron_count,:)*nan;
    end
    if max(graphdata.NORM_id4_avg(neuron_count,:))>5,
        graphdata.NORM_id4_avg(neuron_count,:)=graphdata.NORM_id4_avg(neuron_count,:)*nan;
    end
    if max(graphdata.NORM_id5_avg(neuron_count,:))>5,
        graphdata.NORM_id5_avg(neuron_count,:)=graphdata.NORM_id5_avg(neuron_count,:)*nan;
    end
    if max(graphdata.NORM_id6_avg(neuron_count,:))>5,
        graphdata.NORM_id6_avg(neuron_count,:)=graphdata.NORM_id6_avg(neuron_count,:)*nan;
    end
    if max(graphdata.NORM_id7_avg(neuron_count,:))>5,
        graphdata.NORM_id7_avg(neuron_count,:)=graphdata.NORM_id7_avg(neuron_count,:)*nan;
    end
    if max(graphdata.NORM_id8_avg(neuron_count,:))>5,
        graphdata.NORM_id8_avg(neuron_count,:)=graphdata.NORM_id8_avg(neuron_count,:)*nan;
    end
end
    

avgfunc(1,:)=nanmean(graphdata.id1_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(2,:)=nanmean(graphdata.id2_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(3,:)=nanmean(graphdata.id3_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(4,:)=nanmean(graphdata.id4_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(5,:)=nanmean(graphdata.id5_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(6,:)=nanmean(graphdata.id6_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(7,:)=nanmean(graphdata.id7_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(8,:)=nanmean(graphdata.id8_avg(:,1000+xrange(1):1000+xrange(2)),1);

avgfunc(9,:)= nanmean(graphdata.NORM_id1_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(10,:)=nanmean(graphdata.NORM_id2_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(11,:)=nanmean(graphdata.NORM_id3_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(12,:)=nanmean(graphdata.NORM_id4_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(13,:)=nanmean(graphdata.NORM_id5_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(14,:)=nanmean(graphdata.NORM_id6_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(15,:)=nanmean(graphdata.NORM_id7_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(16,:)=nanmean(graphdata.NORM_id8_avg(:,1000+xrange(1):1000+xrange(2)),1);

semfunc(1,:)=nanstd(graphdata.id1_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(2,:)=nanstd(graphdata.id2_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(3,:)=nanstd(graphdata.id3_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(4,:)=nanstd(graphdata.id4_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(5,:)=nanstd(graphdata.id5_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(6,:)=nanstd(graphdata.id6_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(7,:)=nanstd(graphdata.id7_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(8,:)=nanstd(graphdata.id8_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));

semfunc(9,:)= nanstd(graphdata.NORM_id1_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(10,:)=nanstd(graphdata.NORM_id2_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(11,:)=nanstd(graphdata.NORM_id3_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(12,:)=nanstd(graphdata.NORM_id4_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(13,:)=nanstd(graphdata.NORM_id5_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(14,:)=nanstd(graphdata.NORM_id6_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(15,:)=nanstd(graphdata.NORM_id7_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));
semfunc(16,:)=nanstd(graphdata.NORM_id8_avg(:,1000+xrange(1):1000+xrange(2)))/sqrt(length(pointer));


return

