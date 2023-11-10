function f570_multivariate(hmiconfig,xldata,figlabel,figurepath,neuron_filter)

reload=1; % flag to indicate whether it's necessary to reload all the spike density data
time_skip=5; % slides TIME_SKIP ms each step
time_range=-100:time_skip:700;
time_win=10; % plus/minus TIME_WIN ms
cd(figurepath)

if nargin==4, neuron_filter=1:length(xldata.plxname); end % if no filter is specified, include all neurons
num_neurons=length(neuron_filter); % number of units to include in analysis

cm=struct('F_NDe',[],'F_NAe',[],'F_FDe',[],'F_FAe',[],'F_TDe',[],'F_TAe',[],'NONFe',[],...
    'F_NDo',[],'F_NAo',[],'F_FDo',[],'F_FAo',[],'F_TDo',[],'F_TAo',[],'NONFo',[],...
    'FACESe',[],'FACESo',[],'DIRe',[],'AVERTe',[],'AVERTo',[],'NEUTe',[],'NEUTo',[],'THREATe',[],'THREATo',[],'FEARe',[],'FEARo',[]);

% Step 1 - load data and store epoch response
for un=1:num_neurons,
    % Load graphstructsingle file
    newname=char(xldata.plxname(un)); newunit=char(xldata.unitname(un));
    load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570graphdata.mat']);
    load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
    tempspk=graphstructsingle.spden_trial(:,800:3000);
    temp_id=respstructsingle.trial_id;
    clear graphstructsingle respstructsingle
    for tt=1:length(time_range)-1,
        % Conditions
        % All Faces
        pointer=find(temp_id(:,3)~=0);
        cm.FACESe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.FACESo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % All Directed
        pointer=find(temp_id(:,4)==1);
        cm.DIRe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.DIRo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % All Averted
        pointer=find(temp_id(:,4)==2);
        cm.AVERTe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.AVERTo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % All Neutral
        pointer=find(temp_id(:,2)==1);
        cm.NEUTe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.NEUTo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % All Threat
        pointer=find(temp_id(:,2)==2);
        cm.THREATe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.THREATo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % All Fear Grin
        pointer=find(temp_id(:,2)==3);
        cm.FEARe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.FEARo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % FacesND
        pointer=find(temp_id(:,2)==1 & temp_id(:,4)==1);
        cm.F_NDe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.F_NDo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % FacesNA
        pointer=find(temp_id(:,2)==1 & temp_id(:,4)==2);
        cm.F_NAe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.F_NAo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % FacesFD
        pointer=find(temp_id(:,2)==3 & temp_id(:,4)==1);
        cm.F_FDe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.F_FDo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % FacesFA
        pointer=find(temp_id(:,2)==3 & temp_id(:,4)==2);
        cm.F_FAe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.F_FAo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % FacesTD
        pointer=find(temp_id(:,2)==2 & temp_id(:,4)==1);
        cm.F_TDe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.F_TDo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % FacesTA
        pointer=find(temp_id(:,2)==2 & temp_id(:,4)==2);
        cm.F_TAe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.F_TAo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        % NonFaces
        pointer=find(temp_id(:,3)==0);
        cm.NONFe(un,tt)=mean(mean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.NONFo(un,tt)=mean(mean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        
        
        % ID1 - neutral directed
        pointer=find(temp_id(:,2)==1 & temp_id(:,3)==1 & temp_id(:,4)==1);
        %if isempty(pointer)==0,
        cm.ID1_NDe(un,tt)=nanmean(nanmean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.ID1_NDo(un,tt)=nanmean(nanmean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        %else
        %    cm.ID1_NDe(un,tt)=0; cm.ID1_NDo(un,tt)=0;
        %end
        
        % ID2 - neutral directed
        pointer=find(temp_id(:,2)==1 & temp_id(:,3)==1 & temp_id(:,4)==2);
        %if isempty(pointer)==0,
        cm.ID2_NDe(un,tt)=nanmean(nanmean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.ID2_NDo(un,tt)=nanmean(nanmean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        %else
        %    cm.ID2_NDe(un,tt)=0; cm.ID2_NDo(un,tt)=0;
        %end
        
        % ID3 - neutral directed
        pointer=find(temp_id(:,2)==1 & temp_id(:,3)==1 & temp_id(:,4)==3);
        %if isempty(pointer)==0,
        cm.ID3_NDe(un,tt)=nanmean(nanmean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.ID3_NDo(un,tt)=nanmean(nanmean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        %else
        %    cm.ID3_NDe(un,tt)=0; cm.ID3_NDo(un,tt)=0;
        %end
        
        % ID4 - neutral directed
        pointer=find(temp_id(:,2)==1 & temp_id(:,3)==1 & temp_id(:,4)==4);
        %if isempty(pointer)==0,
        cm.ID4_NDe(un,tt)=nanmean(nanmean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.ID4_NDo(un,tt)=nanmean(nanmean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        %else
        %    cm.ID4_NDe(un,tt)=0; cm.ID4_NDo(un,tt)=0;
        %end
        
        % ID5 - neutral directed
        pointer=find(temp_id(:,2)==1 & temp_id(:,3)==1 & temp_id(:,4)==5);
        %if isempty(pointer)==0,
        cm.ID5_NDe(un,tt)=nanmean(nanmean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.ID5_NDo(un,tt)=nanmean(nanmean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        %else
        %    cm.ID5_NDe(un,tt)=0; cm.ID5_NDo(un,tt)=0;
        %end
        
        % ID6 - neutral directed
        pointer=find(temp_id(:,2)==1 & temp_id(:,3)==1 & temp_id(:,4)==6);
        %if isempty(pointer)==0,
        cm.ID6_NDe(un,tt)=nanmean(nanmean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.ID6_NDo(un,tt)=nanmean(nanmean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        %else
        %    cm.ID6_NDe(un,tt)=0; cm.ID6_NDo(un,tt)=0;
        %end
        
        % ID7 - neutral directed
        pointer=find(temp_id(:,2)==1 & temp_id(:,3)==1 & temp_id(:,4)==7);
        if isempty(pointer)==0,cm.ID7_NDe(un,tt)=nanmean(nanmean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.ID7_NDo(un,tt)=nanmean(nanmean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        else
            cm.ID7_NDe(un,tt)=0; cm.ID7_NDo(un,tt)=0;
        end
        
        % ID8 - neutral directed
        pointer=find(temp_id(:,2)==1 & temp_id(:,3)==1 & temp_id(:,4)==8);
        %if isempty(pointer)==0,
        cm.ID8_NDe(un,tt)=nanmean(nanmean(tempspk(pointer(2:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win))); cm.ID8_NDo(un,tt)=nanmean(nanmean(tempspk(pointer(1:2:end),200+time_range(tt)-time_win:200+time_range(tt)+time_win)));
        %else
        %    cm.ID8_NDe(un,tt)=0; cm.ID8_NDo(un,tt)=0;
        %end
    end
end
outputfname=[hmiconfig.faces570spks,filesep,figlabel,'-570cm.mat'];
save(outputfname,'cm')


%%% Step 2 - Evaluate Correlation
if reload==1,
    outputfname=[hmiconfig.faces570spks,filesep,figlabel,'-570corrm.mat'];
    load(outputfname);
else
    corrmatrix=struct('FvNF',zeros(length(time_range)-1),'FvNF_pval',zeros(length(time_range)-1),'FvNF_Fish',zeros(length(time_range)-1),...
        'DvA',zeros(length(time_range)-1),'DvA_pval',zeros(length(time_range)-1),'DvA_Fish',zeros(length(time_range)-1),...
        'NvT',zeros(length(time_range)-1), 'NvT_pval',zeros(length(time_range)-1),'NvT_Fish',zeros(length(time_range)-1),...
        'NvFG',zeros(length(time_range)-1),'NvFG_pval',zeros(length(time_range)-1),'NvFG_Fish',zeros(length(time_range)-1),...
        'TvFG',zeros(length(time_range)-1),'TvFG_pval',zeros(length(time_range)-1),'TvFG_Fish',zeros(length(time_range)-1),...
        'NDvTD',zeros(length(time_range)-1),'NDvTD_pval',zeros(length(time_range)-1),'NDvTD_Fish',zeros(length(time_range)-1),...
        'ID',zeros(length(time_range)-1,length(time_range)-1,28));
    
    % 2.1 - FACES vs. NON-FACES
    [corrmatrix.FvNF,corrmatrix.FvNF_pval,corrmatrix.FvNF_Fish]=f570_multicorr(time_range,cm.FACESe,cm.FACESo,cm.NONFe,cm.NONFo);
    
    % 2.2 - DIRECTED vs. AVERTED (grouped)
    [corrmatrix.DvA,corrmatrix.DvA_pval,corrmatrix.DvA_Fish]=f570_multicorr(time_range,cm.DIRe,cm.DIRo,cm.AVERTe,cm.AVERTo);
    
    % 2.3 - Expressions (grouped)
    [corrmatrix.EXPR(:,:,1),corrmatrix.EXPR_pval(:,:,1),corrmatrix.EXPR_Fish(:,:,1)]=f570_multicorr(time_range,cm.NEUTe,cm.NEUTo,cm.THREATe,cm.THREATo);
    [corrmatrix.EXPR(:,:,2),corrmatrix.EXPR_pval(:,:,2),corrmatrix.EXPR_Fish(:,:,2)]=f570_multicorr(time_range,cm.NEUTe,cm.NEUTo,cm.FEARe,cm.FEARo);
    [corrmatrix.EXPR(:,:,3),corrmatrix.EXPR_pval(:,:,3),corrmatrix.EXPR_Fish(:,:,3)]=f570_multicorr(time_range,cm.THREATe,cm.THREATo,cm.FEARe,cm.FEARo);
    
    % 2.4 ID Comparisons (grouped)
    [corrmatrix.ID(:,:,1),corrmatrix.ID_pval(:,:,1),corrmatrix.ID_Fish(:,:,1)]=f570_multicorr(time_range,cm.ID1_NDe,cm.ID1_NDo,cm.ID2_NDe,cm.ID2_NDo);
    [corrmatrix.ID(:,:,2),corrmatrix.ID_pval(:,:,2),corrmatrix.ID_Fish(:,:,2)]=f570_multicorr(time_range,cm.ID1_NDe,cm.ID1_NDo,cm.ID3_NDe,cm.ID3_NDo);
    [corrmatrix.ID(:,:,3),corrmatrix.ID_pval(:,:,3),corrmatrix.ID_Fish(:,:,3)]=f570_multicorr(time_range,cm.ID1_NDe,cm.ID1_NDo,cm.ID4_NDe,cm.ID4_NDo);
    [corrmatrix.ID(:,:,4),corrmatrix.ID_pval(:,:,4),corrmatrix.ID_Fish(:,:,4)]=f570_multicorr(time_range,cm.ID1_NDe,cm.ID1_NDo,cm.ID5_NDe,cm.ID5_NDo);
    [corrmatrix.ID(:,:,5),corrmatrix.ID_pval(:,:,5),corrmatrix.ID_Fish(:,:,5)]=f570_multicorr(time_range,cm.ID1_NDe,cm.ID1_NDo,cm.ID6_NDe,cm.ID6_NDo);
    [corrmatrix.ID(:,:,6),corrmatrix.ID_pval(:,:,6),corrmatrix.ID_Fish(:,:,6)]=f570_multicorr(time_range,cm.ID1_NDe,cm.ID1_NDo,cm.ID7_NDe,cm.ID7_NDo);
    [corrmatrix.ID(:,:,7),corrmatrix.ID_pval(:,:,7),corrmatrix.ID_Fish(:,:,7)]=f570_multicorr(time_range,cm.ID1_NDe,cm.ID1_NDo,cm.ID8_NDe,cm.ID8_NDo);
    [corrmatrix.ID(:,:,8),corrmatrix.ID_pval(:,:,8),corrmatrix.ID_Fish(:,:,8)]=f570_multicorr(time_range,cm.ID2_NDe,cm.ID2_NDo,cm.ID3_NDe,cm.ID3_NDo);
    [corrmatrix.ID(:,:,9),corrmatrix.ID_pval(:,:,9),corrmatrix.ID_Fish(:,:,9)]=f570_multicorr(time_range,cm.ID2_NDe,cm.ID2_NDo,cm.ID4_NDe,cm.ID4_NDo);
    [corrmatrix.ID(:,:,10),corrmatrix.ID_pval(:,:,10),corrmatrix.ID_Fish(:,:,10)]=f570_multicorr(time_range,cm.ID2_NDe,cm.ID2_NDo,cm.ID5_NDe,cm.ID5_NDo);
    [corrmatrix.ID(:,:,11),corrmatrix.ID_pval(:,:,11),corrmatrix.ID_Fish(:,:,11)]=f570_multicorr(time_range,cm.ID2_NDe,cm.ID2_NDo,cm.ID6_NDe,cm.ID6_NDo);
    [corrmatrix.ID(:,:,12),corrmatrix.ID_pval(:,:,12),corrmatrix.ID_Fish(:,:,12)]=f570_multicorr(time_range,cm.ID2_NDe,cm.ID2_NDo,cm.ID7_NDe,cm.ID7_NDo);
    [corrmatrix.ID(:,:,13),corrmatrix.ID_pval(:,:,13),corrmatrix.ID_Fish(:,:,13)]=f570_multicorr(time_range,cm.ID2_NDe,cm.ID2_NDo,cm.ID8_NDe,cm.ID8_NDo);
    [corrmatrix.ID(:,:,14),corrmatrix.ID_pval(:,:,14),corrmatrix.ID_Fish(:,:,14)]=f570_multicorr(time_range,cm.ID3_NDe,cm.ID3_NDo,cm.ID4_NDe,cm.ID4_NDo);
    [corrmatrix.ID(:,:,15),corrmatrix.ID_pval(:,:,15),corrmatrix.ID_Fish(:,:,15)]=f570_multicorr(time_range,cm.ID3_NDe,cm.ID3_NDo,cm.ID5_NDe,cm.ID5_NDo);
    [corrmatrix.ID(:,:,16),corrmatrix.ID_pval(:,:,16),corrmatrix.ID_Fish(:,:,16)]=f570_multicorr(time_range,cm.ID3_NDe,cm.ID3_NDo,cm.ID6_NDe,cm.ID6_NDo);
    [corrmatrix.ID(:,:,17),corrmatrix.ID_pval(:,:,17),corrmatrix.ID_Fish(:,:,17)]=f570_multicorr(time_range,cm.ID3_NDe,cm.ID3_NDo,cm.ID7_NDe,cm.ID7_NDo);
    [corrmatrix.ID(:,:,18),corrmatrix.ID_pval(:,:,18),corrmatrix.ID_Fish(:,:,18)]=f570_multicorr(time_range,cm.ID3_NDe,cm.ID3_NDo,cm.ID8_NDe,cm.ID8_NDo);
    [corrmatrix.ID(:,:,19),corrmatrix.ID_pval(:,:,19),corrmatrix.ID_Fish(:,:,19)]=f570_multicorr(time_range,cm.ID4_NDe,cm.ID4_NDo,cm.ID5_NDe,cm.ID5_NDo);
    [corrmatrix.ID(:,:,20),corrmatrix.ID_pval(:,:,20),corrmatrix.ID_Fish(:,:,20)]=f570_multicorr(time_range,cm.ID4_NDe,cm.ID4_NDo,cm.ID6_NDe,cm.ID6_NDo);
    [corrmatrix.ID(:,:,21),corrmatrix.ID_pval(:,:,21),corrmatrix.ID_Fish(:,:,21)]=f570_multicorr(time_range,cm.ID4_NDe,cm.ID4_NDo,cm.ID7_NDe,cm.ID7_NDo);
    [corrmatrix.ID(:,:,22),corrmatrix.ID_pval(:,:,22),corrmatrix.ID_Fish(:,:,22)]=f570_multicorr(time_range,cm.ID4_NDe,cm.ID4_NDo,cm.ID8_NDe,cm.ID8_NDo);
    [corrmatrix.ID(:,:,23),corrmatrix.ID_pval(:,:,23),corrmatrix.ID_Fish(:,:,23)]=f570_multicorr(time_range,cm.ID5_NDe,cm.ID5_NDo,cm.ID6_NDe,cm.ID6_NDo);
    [corrmatrix.ID(:,:,24),corrmatrix.ID_pval(:,:,24),corrmatrix.ID_Fish(:,:,24)]=f570_multicorr(time_range,cm.ID5_NDe,cm.ID5_NDo,cm.ID7_NDe,cm.ID7_NDo);
    [corrmatrix.ID(:,:,25),corrmatrix.ID_pval(:,:,25),corrmatrix.ID_Fish(:,:,25)]=f570_multicorr(time_range,cm.ID5_NDe,cm.ID5_NDo,cm.ID8_NDe,cm.ID8_NDo);
    [corrmatrix.ID(:,:,26),corrmatrix.ID_pval(:,:,26),corrmatrix.ID_Fish(:,:,26)]=f570_multicorr(time_range,cm.ID6_NDe,cm.ID6_NDo,cm.ID7_NDe,cm.ID7_NDo);
    [corrmatrix.ID(:,:,27),corrmatrix.ID_pval(:,:,27),corrmatrix.ID_Fish(:,:,27)]=f570_multicorr(time_range,cm.ID6_NDe,cm.ID6_NDo,cm.ID8_NDe,cm.ID8_NDo);
    [corrmatrix.ID(:,:,28),corrmatrix.ID_pval(:,:,28),corrmatrix.ID_Fish(:,:,28)]=f570_multicorr(time_range,cm.ID7_NDe,cm.ID7_NDo,cm.ID8_NDe,cm.ID8_NDo);
    
    % Ungrouped
    
    % 2.5 - FACES vs. NON-FACES
    [corrmatrix.FdvNF,corrmatrix.FdvNF_pval,corrmatrix.FdvNF_Fish]=f570_multicorr(time_range,cm.F_NDe,cm.F_NDo,cm.NONFe,cm.NONFo);
    
    % 2.6 - DIRECTED vs. AVERTED (neutral expression only)
    [corrmatrix.DnvAn,corrmatrix.DnvAn_pval,corrmatrix.DnvAn_Fish]=f570_multicorr(time_range,cm.F_NDe,cm.F_NDo,cm.F_NAe,cm.F_NAo);
    
    % 2.3 - Expressions (directed gaze only)
    [corrmatrix.EXPRd(:,:,1),corrmatrix.EXPRd_pval(:,:,1),corrmatrix.EXPRd_Fish(:,:,1)]=f570_multicorr(time_range,cm.F_NDe,cm.F_NDo,cm.F_TDe,cm.F_TDo);
    [corrmatrix.EXPRd(:,:,2),corrmatrix.EXPRd_pval(:,:,2),corrmatrix.EXPRd_Fish(:,:,2)]=f570_multicorr(time_range,cm.F_NDe,cm.F_NDo,cm.F_FDe,cm.F_FDo);
    [corrmatrix.EXPRd(:,:,3),corrmatrix.EXPRd_pval(:,:,3),corrmatrix.EXPRd_Fish(:,:,3)]=f570_multicorr(time_range,cm.F_TDe,cm.F_TDo,cm.F_FDe,cm.F_FDo);
    
    outputfname=[hmiconfig.faces570spks,filesep,figlabel,'-570corrm.mat'];
    save(outputfname,'corrmatrix')
end

%%% Step 3 - Solve for Diagonals
for x=1:size(corrmatrix.FvNF,1),
    diagonals.rho(1,x)=corrmatrix.FvNF(x,x); diagonals.pval(1,x)=corrmatrix.FvNF_pval(x,x); diagonals.Fish(1,x)=corrmatrix.FvNF_Fish(x,x);
    diagonals.rho(2,x)=corrmatrix.DvA(x,x);  diagonals.pval(2,x)=corrmatrix.DvA_pval(x,x);  diagonals.Fish(2,x)=corrmatrix.DvA_Fish(x,x);
    
    diagonals.rho(3,x)=corrmatrix.EXPR(x,x,1); diagonals.pval(3,x)=corrmatrix.EXPR_pval(x,x,1); diagonals.Fish(3,x)=corrmatrix.EXPR_Fish(x,x,1);
    diagonals.rho(4,x)=corrmatrix.EXPR(x,x,2); diagonals.pval(4,x)=corrmatrix.EXPR_pval(x,x,2); diagonals.Fish(4,x)=corrmatrix.EXPR_Fish(x,x,2);
    diagonals.rho(5,x)=corrmatrix.EXPR(x,x,3); diagonals.pval(5,x)=corrmatrix.EXPR_pval(x,x,3); diagonals.Fish(5,x)=corrmatrix.EXPR_Fish(x,x,3);
    
    diagonals.rho(6,x)=corrmatrix.ID(x,x,1); diagonals.pval(6,x)=corrmatrix.ID_pval(x,x,1); diagonals.Fish(6,x)=corrmatrix.ID_Fish(x,x,1);
    diagonals.rho(7,x)=corrmatrix.ID(x,x,2); diagonals.pval(7,x)=corrmatrix.ID_pval(x,x,2); diagonals.Fish(7,x)=corrmatrix.ID_Fish(x,x,2);
    diagonals.rho(8,x)=corrmatrix.ID(x,x,3); diagonals.pval(8,x)=corrmatrix.ID_pval(x,x,3); diagonals.Fish(8,x)=corrmatrix.ID_Fish(x,x,3);
    diagonals.rho(9,x)=corrmatrix.ID(x,x,4); diagonals.pval(9,x)=corrmatrix.ID_pval(x,x,4); diagonals.Fish(9,x)=corrmatrix.ID_Fish(x,x,4);
    diagonals.rho(10,x)=corrmatrix.ID(x,x,5); diagonals.pval(10,x)=corrmatrix.ID_pval(x,x,5); diagonals.Fish(10,x)=corrmatrix.ID_Fish(x,x,5);
    diagonals.rho(11,x)=corrmatrix.ID(x,x,6); diagonals.pval(11,x)=corrmatrix.ID_pval(x,x,6); diagonals.Fish(11,x)=corrmatrix.ID_Fish(x,x,6);
    diagonals.rho(12,x)=corrmatrix.ID(x,x,7); diagonals.pval(12,x)=corrmatrix.ID_pval(x,x,7); diagonals.Fish(12,x)=corrmatrix.ID_Fish(x,x,7);
    diagonals.rho(13,x)=corrmatrix.ID(x,x,8); diagonals.pval(13,x)=corrmatrix.ID_pval(x,x,8); diagonals.Fish(13,x)=corrmatrix.ID_Fish(x,x,8);
    diagonals.rho(14,x)=corrmatrix.ID(x,x,9); diagonals.pval(14,x)=corrmatrix.ID_pval(x,x,9); diagonals.Fish(14,x)=corrmatrix.ID_Fish(x,x,9);
    diagonals.rho(15,x)=corrmatrix.ID(x,x,10); diagonals.pval(15,x)=corrmatrix.ID_pval(x,x,10); diagonals.Fish(15,x)=corrmatrix.ID_Fish(x,x,10);
    diagonals.rho(16,x)=corrmatrix.ID(x,x,11); diagonals.pval(16,x)=corrmatrix.ID_pval(x,x,11); diagonals.Fish(16,x)=corrmatrix.ID_Fish(x,x,11);
    diagonals.rho(17,x)=corrmatrix.ID(x,x,12); diagonals.pval(17,x)=corrmatrix.ID_pval(x,x,12); diagonals.Fish(17,x)=corrmatrix.ID_Fish(x,x,12);
    diagonals.rho(18,x)=corrmatrix.ID(x,x,13); diagonals.pval(18,x)=corrmatrix.ID_pval(x,x,13); diagonals.Fish(18,x)=corrmatrix.ID_Fish(x,x,13);
    diagonals.rho(19,x)=corrmatrix.ID(x,x,14); diagonals.pval(19,x)=corrmatrix.ID_pval(x,x,14); diagonals.Fish(19,x)=corrmatrix.ID_Fish(x,x,14);
    diagonals.rho(20,x)=corrmatrix.ID(x,x,15); diagonals.pval(20,x)=corrmatrix.ID_pval(x,x,15); diagonals.Fish(20,x)=corrmatrix.ID_Fish(x,x,15);
    diagonals.rho(21,x)=corrmatrix.ID(x,x,16); diagonals.pval(21,x)=corrmatrix.ID_pval(x,x,16); diagonals.Fish(21,x)=corrmatrix.ID_Fish(x,x,16);
    diagonals.rho(22,x)=corrmatrix.ID(x,x,17); diagonals.pval(22,x)=corrmatrix.ID_pval(x,x,17); diagonals.Fish(22,x)=corrmatrix.ID_Fish(x,x,17);
    diagonals.rho(23,x)=corrmatrix.ID(x,x,18); diagonals.pval(23,x)=corrmatrix.ID_pval(x,x,18); diagonals.Fish(23,x)=corrmatrix.ID_Fish(x,x,18);
    diagonals.rho(24,x)=corrmatrix.ID(x,x,19); diagonals.pval(24,x)=corrmatrix.ID_pval(x,x,19); diagonals.Fish(24,x)=corrmatrix.ID_Fish(x,x,19);
    diagonals.rho(25,x)=corrmatrix.ID(x,x,20); diagonals.pval(25,x)=corrmatrix.ID_pval(x,x,20); diagonals.Fish(25,x)=corrmatrix.ID_Fish(x,x,20);
    diagonals.rho(26,x)=corrmatrix.ID(x,x,21); diagonals.pval(26,x)=corrmatrix.ID_pval(x,x,21); diagonals.Fish(26,x)=corrmatrix.ID_Fish(x,x,21);
    diagonals.rho(27,x)=corrmatrix.ID(x,x,22); diagonals.pval(27,x)=corrmatrix.ID_pval(x,x,22); diagonals.Fish(27,x)=corrmatrix.ID_Fish(x,x,22);
    diagonals.rho(28,x)=corrmatrix.ID(x,x,23); diagonals.pval(28,x)=corrmatrix.ID_pval(x,x,23); diagonals.Fish(28,x)=corrmatrix.ID_Fish(x,x,23);
    diagonals.rho(29,x)=corrmatrix.ID(x,x,24); diagonals.pval(29,x)=corrmatrix.ID_pval(x,x,24); diagonals.Fish(29,x)=corrmatrix.ID_Fish(x,x,24);
    diagonals.rho(30,x)=corrmatrix.ID(x,x,25); diagonals.pval(30,x)=corrmatrix.ID_pval(x,x,25); diagonals.Fish(30,x)=corrmatrix.ID_Fish(x,x,25);
    diagonals.rho(31,x)=corrmatrix.ID(x,x,26); diagonals.pval(31,x)=corrmatrix.ID_pval(x,x,26); diagonals.Fish(31,x)=corrmatrix.ID_Fish(x,x,26);
    diagonals.rho(32,x)=corrmatrix.ID(x,x,27); diagonals.pval(32,x)=corrmatrix.ID_pval(x,x,27); diagonals.Fish(32,x)=corrmatrix.ID_Fish(x,x,27);
    diagonals.rho(33,x)=corrmatrix.ID(x,x,28); diagonals.pval(33,x)=corrmatrix.ID_pval(x,x,28); diagonals.Fish(33,x)=corrmatrix.ID_Fish(x,x,28);
    
    
    diagonals.rho(34,x)=corrmatrix.FdvNF(x,x); diagonals.pval(34,x)=corrmatrix.FdvNF_pval(x,x); diagonals.Fish(34,x)=corrmatrix.FdvNF_Fish(x,x);
    diagonals.rho(35,x)=corrmatrix.DnvAn(x,x);  diagonals.pval(35,x)=corrmatrix.DnvAn_pval(x,x);  diagonals.Fish(35,x)=corrmatrix.DnvAn_Fish(x,x);
    
    diagonals.rho(36,x)=corrmatrix.EXPRd(x,x,1); diagonals.pval(36,x)=corrmatrix.EXPRd_pval(x,x,1); diagonals.Fish(36,x)=corrmatrix.EXPRd_Fish(x,x,1);
    diagonals.rho(37,x)=corrmatrix.EXPRd(x,x,2); diagonals.pval(37,x)=corrmatrix.EXPRd_pval(x,x,2); diagonals.Fish(37,x)=corrmatrix.EXPRd_Fish(x,x,2);
    diagonals.rho(38,x)=corrmatrix.EXPRd(x,x,3); diagonals.pval(38,x)=corrmatrix.EXPRd_pval(x,x,3); diagonals.Fish(38,x)=corrmatrix.EXPRd_Fish(x,x,3);
    
    
end

%%%  Step 4 - Generate Averages
matrix_expr.rho=nanmean(corrmatrix.EXPR,3);
matrix_expr.pval=nanmean(corrmatrix.EXPR_pval,3);
matrix_expr.fish=nanmean(corrmatrix.EXPR_Fish,3);

matrix_id.rho=nanmean(corrmatrix.ID,3);
matrix_id.pval=nanmean(corrmatrix.ID_pval,3);
matrix_id.fish=nanmean(corrmatrix.ID_Fish,3);

matrix_exprd.rho=nanmean(corrmatrix.EXPRd,3);
matrix_exprd.pval=nanmean(corrmatrix.EXPRd_pval,3);
matrix_exprd.fish=nanmean(corrmatrix.EXPRd_Fish,3);

diagonals.expr_rho=nanmean(diagonals.rho(3:5,:),1);
diagonals.expr_pval=nanmean(diagonals.pval(3:5,:),1);
diagonals.expr_fish=nanmean(diagonals.Fish(3:5,:),1);

diagonals.exprd_rho=nanmean(diagonals.rho(36:38,:),1);
diagonals.exprd_pval=nanmean(diagonals.pval(36:38,:),1);
diagonals.exprd_fish=nanmean(diagonals.Fish(36:38,:),1);

diagonals.id_rho=nanmean(diagonals.rho(6:33,:),1);
diagonals.id_pval=nanmean(diagonals.pval(6:33,:),1);
diagonals.id_fish=nanmean(diagonals.Fish(6:33,:),1);

%%% Step 5 - Generate Figures
figure; clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.1 0.1 0.8 0.8]); set(gca,'FontName','Arial')
subplot(2,4,1); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),corrmatrix.FvNF)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title({'Faces vs. NonFaces',figlabel},'FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1]);

subplot(2,4,2); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),corrmatrix.DvA)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('Directed vs. Averted','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])

subplot(2,4,3); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),matrix_expr.rho)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('mean(Expression Contrasts)','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])

subplot(2,4,4); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),matrix_id.rho)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('mean(ID Contrasts)','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])

subplot(2,4,5); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),corrmatrix.FvNF_Fish)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('Faces vs. NonFaces - Fisher''s Transformation','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1.25])

subplot(2,4,6); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),corrmatrix.DvA_Fish)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('Directed vs. Averted - Fisher''s Transformation','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1.25])

subplot(2,4,7); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),matrix_expr.fish)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('mean(Expression Contrasts - Fisher''s Transformation','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1.25])

subplot(2,4,8); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),matrix_id.fish)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('mean(ID Contrasts - Fisher''s Transformation','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1.25])

jpgfigname=[figurepath,filesep,'Faces570_Fig7a_LDA_part1.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig7a_LDA_part1 -eps -rgb -transparent







figure; clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.1 0.1 0.8 0.8]); set(gca,'FontName','Arial')
subplot(2,3,1); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),corrmatrix.FdvNF)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title({'Faces (directonly) vs. NonFaces',figlabel},'FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1]);

subplot(2,3,2); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),corrmatrix.DnvAn)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('Directed vs. Averted (neutral only)','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])

subplot(2,3,3); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),matrix_exprd.rho)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('mean(Expression Contrasts) (direct only)','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1])

subplot(2,3,4); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),corrmatrix.FdvNF_Fish)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('Faces vs. NonFaces - Fisher''s Transformation','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1.25])

subplot(2,3,5); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),corrmatrix.DnvAn_Fish)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('Directed vs. Averted - Fisher''s Transformation','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1.25])

subplot(2,3,6); hold on
pcolor(time_range(1:end-1),time_range(1:end-1),matrix_exprd.fish)
shading flat; axis square; xlim([-100 700]); ylim([-100 700])
title('mean(Expression Contrasts - Fisher''s Transformation','FontWeight','Bold','FontSize',10)
xlabel('Time (ms)','FontSize',8); ylabel('Time (ms)','FontSize',8);
plot([0 0],[-100 800],'w:'); plot([-100 800],[0 0],'w:'); set(gca,'FontSize',7)
colorbar('SouthOutside'); caxis([0 1.25])

jpgfigname=[figurepath,filesep,'Faces570_Fig7b_LDA_part1.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig7b_LDA_part1 -eps -rgb -transparent




figure; clf; cla; set(gcf,'Units','Normalized'); set(gcf,'Position',[0.2 0.1 0.3 0.8]); set(gca,'FontName','Arial')
% plot diagonals
subplot(3,2,1); hold on
plot(time_range(1):time_skip:time_range(end-1),diagonals.rho(1,:),'k-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.rho(2,:),'r-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.expr_rho,'b-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.id_rho,'g-','LineWidth',2)
title({'Diagonals - Correlation Coefficients (r)',figlabel},'FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',8)
ylabel('Correlation Coefficient (r)','FontSize',8)
xlim([-100 700]); ylim([0 1]); legend('Face vs. NonFace','Gaze Direction','Expression','ID');

subplot(3,2,2); hold on
plot(time_range(1):time_skip:time_range(end-1),diagonals.rho(34,:),'k-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.rho(35,:),'r-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.exprd_rho,'b-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.id_rho,'g-','LineWidth',2)
title({'Diagonals - Correlation Coefficients (r)',figlabel},'FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',8)
ylabel('Correlation Coefficient (r)','FontSize',8)
xlim([-100 700]); ylim([0 1]); legend('Face vs. NonFace (corrected)','Gaze Direction','Expression','ID');

subplot(3,2,3); hold on
plot(time_range(1):time_skip:time_range(end-1),diagonals.Fish(1,:),'k-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.Fish(2,:),'r-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.expr_fish,'b-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.id_fish,'g-','LineWidth',2)
title('Diagonals - Fisher''s Transformation','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',8)
ylabel('arctanh(r)','FontSize',8)
xlim([-100 700]); ylim([0 2.0]); legend('Face vs. NonFace','Gaze Direction','Expression','ID');

subplot(3,2,4); hold on
plot(time_range(1):time_skip:time_range(end-1),diagonals.Fish(34,:),'k-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.Fish(35,:),'r-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.exprd_fish,'b-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.id_fish,'g-','LineWidth',2)
title('Diagonals - Fisher''s Transformation (corrected)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',8)
ylabel('arctanh(r)','FontSize',8)
xlim([-100 700]); ylim([0 2.0]); legend('Face vs. NonFace','Gaze Direction','Expression','ID');

subplot(3,2,5); hold on
plot(time_range(1):time_skip:time_range(end-1),diagonals.pval(1,:),'k-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.pval(2,:),'r-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.expr_pval,'b-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.id_pval,'g-','LineWidth',2)
title('Diagonals - p-values','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',8)
ylabel('Significance (p)','FontSize',8)
xlim([-100 700]); ylim([0 0.5]); legend('Face vs. NonFace','Gaze Direction','Expression','ID');

subplot(3,2,6); hold on
plot(time_range(1):time_skip:time_range(end-1),diagonals.pval(34,:),'k-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.pval(35,:),'r-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.exprd_pval,'b-','LineWidth',2)
plot(time_range(1):time_skip:time_range(end-1),diagonals.id_pval,'g-','LineWidth',2)
title('Diagonals - p-values (corrected)','FontSize',11,'FontWeight','Bold'); set(gca,'FontSize',7)
xlabel('Time from Stimulus Presentation (ms)','FontSize',8)
ylabel('Significance (p)','FontSize',8)
xlim([-100 700]); ylim([0 0.5]); legend('Face vs. NonFace','Gaze Direction','Expression','ID');

jpgfigname=[figurepath,filesep,'Faces570_Fig7c_LDA_part1.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig7c_LDA_part1 -eps -rgb -transparent

return



