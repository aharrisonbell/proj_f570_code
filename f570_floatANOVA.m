function floatdata=f570_floatANOVA(hmiconfig,xldata,pointer,xrange,binsize)
floatbins=xrange(1):binsize:xrange(end);
floatdata=[];
for ff=1:length(pointer),
    newname=char(xldata.plxname(pointer(ff))); newunit=char(xldata.unitname(pointer(ff)));
    load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570graphdata.mat']);
    for fb=1:length(floatbins)-1,
        floatdata.facesND(ff,fb)=mean(graphstructsingle.facesND_avg(1000+floatbins(fb):1000+floatbins(fb+1)));
        floatdata.facesNA(ff,fb)=mean(graphstructsingle.facesNA_avg(1000+floatbins(fb):1000+floatbins(fb+1)));
        floatdata.facesTD(ff,fb)=mean(graphstructsingle.facesTD_avg(1000+floatbins(fb):1000+floatbins(fb+1)));
        floatdata.facesTA(ff,fb)=mean(graphstructsingle.facesTA_avg(1000+floatbins(fb):1000+floatbins(fb+1)));
        floatdata.facesFD(ff,fb)=mean(graphstructsingle.facesFD_avg(1000+floatbins(fb):1000+floatbins(fb+1)));
        floatdata.facesFA(ff,fb)=mean(graphstructsingle.facesFA_avg(1000+floatbins(fb):1000+floatbins(fb+1)));
    end
    clear graphstructsingle
end

for fb=1:length(floatbins)-1,
    % facial expression
    responsetype=[ones(length(pointer)*1,1)*1 ; ones(length(pointer)*1,1)*2 ; ones(length(pointer)*1,1)*3];
    floatdata.anova(fb,1)=anova1([floatdata.facesND(:,fb);floatdata.facesTD(:,fb);floatdata.facesFD(:,fb)],responsetype,'off');
        
    % gaze direction
    responsetype=[ones(length(pointer)*1,1)*1 ; ones(length(pointer)*1,1)*2];
    floatdata.anova(fb,2)=anova1([floatdata.facesND(:,fb);floatdata.facesNA(:,fb)],responsetype,'off');
end
return