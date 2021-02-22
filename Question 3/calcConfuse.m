function confusionMatrix = calcConfuse(decisions, labels, numLabels, priors)

confusionMatrix = zeros(numLabels);
for decision = 1:numLabels
   for label = 1:numLabels
       confusionMatrix(decision, label) = length(find(decisions==decision & labels==label))*priors(label)/length(find(labels==label));
   end
end

confusionMatrix(isnan(confusionMatrix))=0;

end