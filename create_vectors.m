function [condAe,condAo,condBe,condBo]=create_vectors(pointer1,pointer2,nTrials)
% Create selection vectors for f570 Pattern Classifier Analysis
if nargin>2, % nTrials is specified
    if length(pointer1)<nTrials||length(pointer2)<nTrials,
        nTrials=min([length(pointer1) length(pointer2)]);
    end
    condA=sort(randperm(length(pointer1),nTrials));
    condB=sort(randperm(length(pointer2),nTrials));
    condAe=pointer1(condA(2:2:end));
    condAo=pointer1(condA(1:2:end));
    condBe=pointer2(condB(2:2:end));
    condBo=pointer2(condB(1:2:end));
else
    condAe=pointer1(2:2:end);
    condAo=pointer1(1:2:end);
    condBe=pointer2(2:2:end);
    condBo=pointer2(1:2:end);
end

return