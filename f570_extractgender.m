function output=f570_extractMonkID(xldata,pointer,hmiconfig);
% function to isolate individual identity responses for a series of files


num_units=length(pointer);
output=zeros(numunits,8); % one row per unit, one col per ID

for un=1:num_units,

    
    
        newname=char(xldata.plxname(pointer(un))); newunit=char(xldata.unitname(pointer(un)));
        
        
        disp(['...',newname(1:12),'-',newunit,'...'])
        load([hmiconfig.faces570spks,filesep,newname(1:12),'-',newunit,'-570responsedata.mat']);
        xldata.cat_rsp_avg(un,1:3)=respstructsingle.cat_rsp_avg;
        xldata.expr_rsp_avg(un,1:3)=respstructsingle.expr_rsp_avg;
        xldata.gaze_rsp_avg(un,1:2)=respstructsingle.gaze_rsp_avg;
        xldata.anova_fe(un)=respstructsingle.anova_fe;
        xldata.anova_id(un)=respstructsingle.anova_id;
        xldata.anova_gd(un)=respstructsingle.anova_gd;
        xldata.anovam_fe_id(un,:)=respstructsingle.anovam_fe_id';
        xldata.anovam_fe_gd(un,:)=respstructsingle.anovam_fe_gd';
        xldata.anovam_id_gd(un,:)=respstructsingle.anovam_id_gd';
        xldata.anovam_fe_id_gd(un,:)=respstructsingle.anovam_fe_id_gd';
        xldata.anova_fe_id(un,:)=respstructsingle.anova_fe_id';
        xldata.anova_fe_gd(un,:)=respstructsingle.anova_fe_gd';
        xldata.anova_id_gd(un,:)=respstructsingle.anova_id_gd';
        xldata.anova_fe_id_gd(un,:)=respstructsingle.anova_fe_id_gd';
        xldata.unit_number(un)=un;
        xldata.avg_rsp(un,1)=mean(respstructsingle.m_epoch1(hmiconfig.facesND570));
        xldata.avg_rsp(un,2)=mean(respstructsingle.m_epoch1(hmiconfig.facesNA570));
        xldata.avg_rsp(un,3)=mean(respstructsingle.m_epoch1(hmiconfig.facesTD570));
        xldata.avg_rsp(un,4)=mean(respstructsingle.m_epoch1(hmiconfig.facesTA570));
        xldata.avg_rsp(un,5)=mean(respstructsingle.m_epoch1(hmiconfig.facesFD570));
        xldata.avg_rsp(un,6)=mean(respstructsingle.m_epoch1(hmiconfig.facesFA570));
        xldata.avg_rsp(un,7)=mean(respstructsingle.m_epoch1(hmiconfig.bodyp570));
        xldata.avg_rsp(un,8)=mean(respstructsingle.m_epoch1(hmiconfig.objct570));
        
        xldata.norm_avg_rsp(un,1)=mean(respstructsingle.m_epoch1(hmiconfig.facesND570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,2)=mean(respstructsingle.m_epoch1(hmiconfig.facesNA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,3)=mean(respstructsingle.m_epoch1(hmiconfig.facesTD570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,4)=mean(respstructsingle.m_epoch1(hmiconfig.facesTA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,5)=mean(respstructsingle.m_epoch1(hmiconfig.facesFD570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,6)=mean(respstructsingle.m_epoch1(hmiconfig.facesFA570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,7)=mean(respstructsingle.m_epoch1(hmiconfig.bodyp570))/xldata.avg_rsp(un,1);
        xldata.norm_avg_rsp(un,8)=mean(respstructsingle.m_epoch1(hmiconfig.objct570))/xldata.avg_rsp(un,1);
end
return