function confusionMatrix = calcConfuse(decisions, labels, priors)

confusionMatrix = zeros(3);
for decision = 1:3
   for label = 1:3
       confusionMatrix(decision, label) = length(find(decisions==decision & labels==label))*priors(label)/length(find(labels==label));
   end
end

end