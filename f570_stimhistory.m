function [output,outputN,p]=f570_stimhistory(xldata,hmiconfig,pointer,data)
Pastruct=zeros(length(pointer),25)*NaN; PastructN=zeros(length(pointer),25)*NaN;
for un=1:length(pointer), % scroll through each unit
    temp_Pstruct=struct('nN',[],'tN',[],'fN',[],'bN',[],'oN',[],...
        'nT',[],'tT',[],'fT',[],'bT',[],'oT',[],...
        'nF',[],'tF',[],'fF',[],'bF',[],'oF',[],...
        'nB',[],'tB',[],'fB',[],'bB',[],'oB',[],...
        'nO',[],'tO',[],'fO',[],'bO',[],'oO',[]);

    Ntrials=xldata.numtrials(pointer(un));
    for nt=2:Ntrials;
        if ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_neutral)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_neutral)==1,
            temp_Pstruct.nN=[temp_Pstruct.nN;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_neutral)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_threat)==1,
            temp_Pstruct.tN=[temp_Pstruct.tN;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_neutral)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_feargrin)==1,
            temp_Pstruct.fN=[temp_Pstruct.fN;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_neutral)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.bodyp570)==1,
            temp_Pstruct.bN=[temp_Pstruct.bN;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_neutral)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.objct570)==1,
            temp_Pstruct.oN=[temp_Pstruct.oN;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_threat)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_neutral)==1,
            temp_Pstruct.nT=[temp_Pstruct.nT;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_threat)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_threat)==1,
            temp_Pstruct.tT=[temp_Pstruct.tT;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_threat)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_feargrin)==1,
            temp_Pstruct.fT=[temp_Pstruct.fT;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_threat)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.bodyp570)==1,
            temp_Pstruct.bT=[temp_Pstruct.bT;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_threat)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.objct570)==1,
            temp_Pstruct.oT=[temp_Pstruct.oT;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_feargrin)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_neutral)==1,
            temp_Pstruct.nF=[temp_Pstruct.nF;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_feargrin)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_threat)==1,
            temp_Pstruct.tF=[temp_Pstruct.tF;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_feargrin)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_feargrin)==1,
            temp_Pstruct.fF=[temp_Pstruct.fF;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_feargrin)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.bodyp570)==1,
            temp_Pstruct.bF=[temp_Pstruct.bF;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.f570_feargrin)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.objct570)==1,
            temp_Pstruct.oF=[temp_Pstruct.oF;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.bodyp570)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_neutral)==1,
            temp_Pstruct.nB=[temp_Pstruct.nB;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.bodyp570)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_threat)==1,
            temp_Pstruct.tB=[temp_Pstruct.tB;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.bodyp570)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_feargrin)==1,
            temp_Pstruct.fB=[temp_Pstruct.fB;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.bodyp570)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.bodyp570)==1,
            temp_Pstruct.bB=[temp_Pstruct.bB;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.bodyp570)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.objct570)==1,
            temp_Pstruct.oB=[temp_Pstruct.oB;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.objct570)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_neutral)==1,
            temp_Pstruct.nO=[temp_Pstruct.nO;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.objct570)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_threat)==1,
            temp_Pstruct.tO=[temp_Pstruct.tO;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.objct570)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.f570_feargrin)==1,
            temp_Pstruct.fO=[temp_Pstruct.fO;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.objct570)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.bodyp570)==1,
            temp_Pstruct.bO=[temp_Pstruct.bO;data(un,nt)];
        elseif ismember(xldata.trial_id1(pointer(un),nt),hmiconfig.objct570)==1 && ismember(xldata.trial_id1(pointer(un),nt-1),hmiconfig.objct570)==1,
            temp_Pstruct.oO=[temp_Pstruct.oO;data(un,nt)];
        end
    end
    
    normalizer=mean(xldata.avg_rsp(pointer(un),1:2));
    PastructN(un,1)=mean(temp_Pstruct.nN)/normalizer;
    PastructN(un,2)=mean(temp_Pstruct.tN)/normalizer;
    PastructN(un,3)=mean(temp_Pstruct.fN)/normalizer;
    PastructN(un,4)=mean(temp_Pstruct.bN)/normalizer;
    PastructN(un,5)=mean(temp_Pstruct.oN)/normalizer;
    PastructN(un,6)=mean(temp_Pstruct.nT)/normalizer;
    PastructN(un,7)=mean(temp_Pstruct.tT)/normalizer;
    PastructN(un,8)=mean(temp_Pstruct.fT)/normalizer;
    PastructN(un,9)=mean(temp_Pstruct.bT)/normalizer;
    PastructN(un,10)=mean(temp_Pstruct.oT)/normalizer;
    PastructN(un,11)=mean(temp_Pstruct.nF)/normalizer;
    PastructN(un,12)=mean(temp_Pstruct.tF)/normalizer;
    PastructN(un,13)=mean(temp_Pstruct.fF)/normalizer;
    PastructN(un,14)=mean(temp_Pstruct.bF)/normalizer;
    PastructN(un,15)=mean(temp_Pstruct.oF)/normalizer;
    PastructN(un,16)=mean(temp_Pstruct.nB)/normalizer;
    PastructN(un,17)=mean(temp_Pstruct.tB)/normalizer;
    PastructN(un,18)=mean(temp_Pstruct.fB)/normalizer;
    PastructN(un,19)=mean(temp_Pstruct.bB)/normalizer;
    PastructN(un,20)=mean(temp_Pstruct.oB)/normalizer;
    PastructN(un,21)=mean(temp_Pstruct.nO)/normalizer;
    PastructN(un,22)=mean(temp_Pstruct.tO)/normalizer;
    PastructN(un,23)=mean(temp_Pstruct.fO)/normalizer;
    PastructN(un,24)=mean(temp_Pstruct.bO)/normalizer;
    PastructN(un,25)=mean(temp_Pstruct.oO)/normalizer;
   
    Pastruct(un,1)=mean(temp_Pstruct.nN);
    Pastruct(un,2)=mean(temp_Pstruct.tN);
    Pastruct(un,3)=mean(temp_Pstruct.fN);
    Pastruct(un,4)=mean(temp_Pstruct.bN);
    Pastruct(un,5)=mean(temp_Pstruct.oN);
    Pastruct(un,6)=mean(temp_Pstruct.nT);
    Pastruct(un,7)=mean(temp_Pstruct.tT);
    Pastruct(un,8)=mean(temp_Pstruct.fT);
    Pastruct(un,9)=mean(temp_Pstruct.bT);
    Pastruct(un,10)=mean(temp_Pstruct.oT);
    Pastruct(un,11)=mean(temp_Pstruct.nF);
    Pastruct(un,12)=mean(temp_Pstruct.tF);
    Pastruct(un,13)=mean(temp_Pstruct.fF);
    Pastruct(un,14)=mean(temp_Pstruct.bF);
    Pastruct(un,15)=mean(temp_Pstruct.oF);
    Pastruct(un,16)=mean(temp_Pstruct.nB);
    Pastruct(un,17)=mean(temp_Pstruct.tB);
    Pastruct(un,18)=mean(temp_Pstruct.fB);
    Pastruct(un,19)=mean(temp_Pstruct.bB);
    Pastruct(un,20)=mean(temp_Pstruct.oB);
    Pastruct(un,21)=mean(temp_Pstruct.nO);
    Pastruct(un,22)=mean(temp_Pstruct.tO);
    Pastruct(un,23)=mean(temp_Pstruct.fO);
    Pastruct(un,24)=mean(temp_Pstruct.bO);
    Pastruct(un,25)=mean(temp_Pstruct.oO);
    
end
p=anova1(Pastruct);

output=zeros(25,2); outputN=zeros(25,2);
for cc=1:25,
    output(cc,1)=mean(nonzeros(Pastruct(:,cc)));
    output(cc,2)=sem(nonzeros(Pastruct(:,cc)));
    
    outputN(cc,1)=mean(nonzeros(PastructN(:,cc)));
    outputN(cc,2)=sem(nonzeros(PastructN(:,cc)));
end
return



























