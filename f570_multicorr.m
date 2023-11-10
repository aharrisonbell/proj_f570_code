function [out_r,out_p,out_F]=f570_multicorr(time_range,condAe,condAo,condBe,condBo);

% remove NANs
condAe2=condAe;
condAo2=condAo;
condBe2=condBe;
condBo2=condBo;

% pointer=find(isnan(condAe2));
% condAe2(pointer)=0;
% pointer=find(isnan(condAo2));
% condAo2(pointer)=0;
% pointer=find(isnan(condBe2));
% condBe2(pointer)=0;
% pointer=find(isnan(condAo2));
% condBo2(pointer)=0;

temp_even=condAe-condBe;
temp_odd=condAo-condBo;


for x=1:length(time_range)-1,
    for y=1:length(time_range)-1,
        [out_r(x,y),out_p(x,y)]=corr(temp_even(:,x),temp_odd(:,y));
        out_F(x,y)=atanh(out_r(x,y));
    end
end
return