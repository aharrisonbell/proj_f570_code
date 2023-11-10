function [avgfunc semfunc]=f570_avg_spden(xldata,pointer,hmiconfig,xrange,normaliser)
%configname = [hmiconfig.rootdir,'faces570_project',filesep,monkeyname,'_spden.mat'];
% v.Oct,2012 - now includes ordered ID
% Epoch information
% spden's aligned to cue onset (=timepoint 1000)
epoch=[50 400]; % early cue response window
epoch2=epoch; %[-50 50]; % normalizer window

% Initialize matrices
graphdata=struct(...
    'facesND_avg',[],'facesNA_avg',[],'facesTD_avg',[],'facesTA_avg',[],'facesFD_avg',[],'facesFA_avg',[],'bodyp_avg',[],'objct_avg',[],...
    'NORM_facesND_avg',[],'NORM_facesNA_avg',[],'NORM_facesTD_avg',[],'NORM_facesTA_avg',[],'NORM_facesFD_avg',[],'NORM_facesFA_avg',[],'NORM_bodyp_avg',[],'NORM_objct_avg',[],...
    'neutral',[],'threat',[],'feargrin',[],'directed',[],'averted',[],...
    'NORM_neutral',[],'NORM_threat',[],'NORM_feargrin',[],'NORM_directed',[],'NORM_averted',[]);
avgfunc=[];

% Load graphdata
for ff=1:length(pointer),
    newname=char(xldata.plxname(pointer(ff))); newunit=char(xldata.unitname(pointer(ff)));
    load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570graphdata.mat']);

    graphdata.facesND_avg=[graphdata.facesND_avg;graphstructsingle.facesND_avg];
    graphdata.facesNA_avg=[graphdata.facesNA_avg;graphstructsingle.facesNA_avg];
    graphdata.facesTD_avg=[graphdata.facesTD_avg;graphstructsingle.facesTD_avg];
    graphdata.facesTA_avg=[graphdata.facesTA_avg;graphstructsingle.facesTA_avg];
    graphdata.facesFD_avg=[graphdata.facesFD_avg;graphstructsingle.facesFD_avg];
    graphdata.facesFA_avg=[graphdata.facesFA_avg;graphstructsingle.facesFA_avg];
    graphdata.bodyp_avg=[graphdata.bodyp_avg;graphstructsingle.bodyp_avg];
    graphdata.objct_avg=[graphdata.objct_avg;graphstructsingle.objct_avg];
    
    normalizer=max(graphstructsingle.facesND_avg(1000+epoch2(1):1000+epoch2(2)));
    %normalizer2=max(graphstructsingle.bodyp_avg(1000+epoch2(1):1000+epoch2(2)));
    %normalizer3=max(graphstructsingle.objct_avg(1000+epoch2(1):1000+epoch2(2)));
    %normalizer=max([normalizer1 normalizer2 normalizer3]);
    
    
    
    graphdata.NORM_facesND_avg=[graphdata.NORM_facesND_avg;(graphstructsingle.facesND_avg/normalizer)];
    graphdata.NORM_facesNA_avg=[graphdata.NORM_facesNA_avg;(graphstructsingle.facesNA_avg/normalizer)];
    graphdata.NORM_facesTD_avg=[graphdata.NORM_facesTD_avg;(graphstructsingle.facesTD_avg/normalizer)];
    graphdata.NORM_facesTA_avg=[graphdata.NORM_facesTA_avg;(graphstructsingle.facesTA_avg/normalizer)];
    graphdata.NORM_facesFD_avg=[graphdata.NORM_facesFD_avg;(graphstructsingle.facesFD_avg/normalizer)];
    graphdata.NORM_facesFA_avg=[graphdata.NORM_facesFA_avg;(graphstructsingle.facesFA_avg/normalizer)];
    graphdata.NORM_bodyp_avg=[graphdata.NORM_bodyp_avg;(graphstructsingle.bodyp_avg/normalizer)];
    graphdata.NORM_objct_avg=[graphdata.NORM_objct_avg;(graphstructsingle.objct_avg/normalizer)];

    graphdata.neutral  = [graphdata.neutral;mean(graphstructsingle.allconds_avg(hmiconfig.f570_neutral,:))];
    graphdata.threat   = [graphdata.threat;mean(graphstructsingle.allconds_avg(hmiconfig.f570_threat,:))];
    graphdata.feargrin = [graphdata.feargrin;mean(graphstructsingle.allconds_avg(hmiconfig.f570_feargrin,:))];
    graphdata.directed = [graphdata.directed;mean(graphstructsingle.allconds_avg(hmiconfig.f570_directed,:))];
    graphdata.averted  = [graphdata.averted;mean(graphstructsingle.allconds_avg(hmiconfig.f570_averted,:))];

    graphdata.NORM_neutral  = [graphdata.NORM_neutral;mean(graphstructsingle.allconds_avg(hmiconfig.f570_neutral,:))/normalizer];
    graphdata.NORM_threat   = [graphdata.NORM_threat;mean(graphstructsingle.allconds_avg(hmiconfig.f570_threat,:))/normalizer];
    graphdata.NORM_feargrin = [graphdata.NORM_feargrin;mean(graphstructsingle.allconds_avg(hmiconfig.f570_feargrin,:))/normalizer];
    graphdata.NORM_directed = [graphdata.NORM_directed;mean(graphstructsingle.allconds_avg(hmiconfig.f570_directed,:))/normalizer];
    graphdata.NORM_averted  = [graphdata.NORM_averted;mean(graphstructsingle.allconds_avg(hmiconfig.f570_averted,:))/normalizer];

    clear graphstructsingle
end

avgfunc(1,:)=mean(graphdata.facesND_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(2,:)=mean(graphdata.facesNA_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(3,:)=mean(graphdata.facesTD_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(4,:)=mean(graphdata.facesTA_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(5,:)=mean(graphdata.facesFD_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(6,:)=mean(graphdata.facesFA_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(7,:)=mean(graphdata.bodyp_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(8,:)=mean(graphdata.objct_avg(:,1000+xrange(1):1000+xrange(2)),1);

avgfunc(9,:)=mean(graphdata.NORM_facesND_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(10,:)=mean(graphdata.NORM_facesNA_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(11,:)=mean(graphdata.NORM_facesTD_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(12,:)=mean(graphdata.NORM_facesTA_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(13,:)=mean(graphdata.NORM_facesFD_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(14,:)=mean(graphdata.NORM_facesFA_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(15,:)=mean(graphdata.NORM_bodyp_avg(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(16,:)=mean(graphdata.NORM_objct_avg(:,1000+xrange(1):1000+xrange(2)),1);

avgfunc(17,:)=mean(graphdata.neutral(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(18,:)=mean(graphdata.threat(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(19,:)=mean(graphdata.feargrin(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(20,:)=mean(graphdata.directed(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(21,:)=mean(graphdata.averted(:,1000+xrange(1):1000+xrange(2)),1);

avgfunc(22,:)=mean(graphdata.NORM_neutral(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(23,:)=mean(graphdata.NORM_threat(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(24,:)=mean(graphdata.NORM_feargrin(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(25,:)=mean(graphdata.NORM_directed(:,1000+xrange(1):1000+xrange(2)),1);
avgfunc(26,:)=mean(graphdata.NORM_averted(:,1000+xrange(1):1000+xrange(2)),1);

semfunc(1,:)=sem(graphdata.facesND_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(2,:)=sem(graphdata.facesNA_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(3,:)=sem(graphdata.facesTD_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(4,:)=sem(graphdata.facesTA_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(5,:)=sem(graphdata.facesFD_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(6,:)=sem(graphdata.facesFA_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(7,:)=sem(graphdata.bodyp_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(8,:)=sem(graphdata.objct_avg(:,1000+xrange(1):1000+xrange(2)));

semfunc(9,:)=sem(graphdata.NORM_facesND_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(10,:)=sem(graphdata.NORM_facesNA_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(11,:)=sem(graphdata.NORM_facesTD_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(12,:)=sem(graphdata.NORM_facesTA_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(13,:)=sem(graphdata.NORM_facesFD_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(14,:)=sem(graphdata.NORM_facesFA_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(15,:)=sem(graphdata.NORM_bodyp_avg(:,1000+xrange(1):1000+xrange(2)));
semfunc(16,:)=sem(graphdata.NORM_objct_avg(:,1000+xrange(1):1000+xrange(2)));

semfunc(17,:)=sem(graphdata.neutral(:,1000+xrange(1):1000+xrange(2)));
semfunc(18,:)=sem(graphdata.threat(:,1000+xrange(1):1000+xrange(2)));
semfunc(19,:)=sem(graphdata.feargrin(:,1000+xrange(1):1000+xrange(2)));
semfunc(20,:)=sem(graphdata.directed(:,1000+xrange(1):1000+xrange(2)));
semfunc(21,:)=sem(graphdata.averted(:,1000+xrange(1):1000+xrange(2)));

semfunc(22,:)=sem(graphdata.NORM_neutral(:,1000+xrange(1):1000+xrange(2)));
semfunc(23,:)=sem(graphdata.NORM_threat(:,1000+xrange(1):1000+xrange(2)));
semfunc(24,:)=sem(graphdata.NORM_feargrin(:,1000+xrange(1):1000+xrange(2)));
semfunc(25,:)=sem(graphdata.NORM_directed(:,1000+xrange(1):1000+xrange(2)));
semfunc(26,:)=sem(graphdata.NORM_averted(:,1000+xrange(1):1000+xrange(2)));


return

