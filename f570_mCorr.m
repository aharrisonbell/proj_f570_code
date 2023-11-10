function [out_r,out_p,out_F]=f570_mCorr(time_range,even_data,odd_data);
% Function to perform time point by time point correlation for f570 pattern classifier analysis
for x=1:length(time_range)-1,
    for y=1:length(time_range)-1,
        [out_r(x,y),out_p(x,y)]=corr(even_data(:,x),odd_data(:,y));
        out_F(x,y)=atanh(out_r(x,y));
    end
end
return