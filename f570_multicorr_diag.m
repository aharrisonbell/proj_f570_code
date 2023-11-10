function output=f570_multicorr_diag(time_range,condAe,condAo,condBe,condBo);
temp_even=condAe-condBe;
temp_odd=condAo-condBo;
for x=1:length(time_range)-1,
    [output(x,1),output(x,2)]=corr(temp_even(:,x),temp_odd(:,x));
    output(x,3)=atanh(output(x,1));
end
return

    
        
  