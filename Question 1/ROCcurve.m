%Adapted from code on Google Drive

function [Pfp,Ptp, Perror] = ROCcurve(decisions,labelData)

labels = labelData.labels;
labelPriors = labelData.priors;


Pfp = zeros(1, size(decisions, 1));
Ptp = zeros(1, size(decisions, 1));
Perror = zeros(1, size(decisions, 1));
Pfn = zeros(1, size(decisions, 1));

%for each gamma
for i = 1:size(decisions, 1)
    
    decisionForGamma = decisions(i,:);
    
    Pfp(i) = length(find(decisionForGamma==1 & labels==0))/length(find(labels==0));
    Ptp(i) = length(find(decisionForGamma==1 & labels==1))/length(find(labels==1));
    Pfn(i) = length(find(decisionForGamma==0 & labels==1))/length(find(labels==1));
    Perror(i) = Pfp(i)*labelPriors(1) + Pfn(i)*labelPriors(2);
end
