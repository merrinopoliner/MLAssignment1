function [decisions, priors] = minPerror(data, labels, numLabels, regParam)

numParameters = size(data, 1);

decisions = zeros(1, size(data, 2));
classPosteriors = zeros(numLabels, size(data,2));
priors = zeros(1, numLabels);
for i = 1:numLabels
   classi = data(:, labels==i);
   priors(i) = size(classi,2)/length(labels);
   
   if(priors(i) ~= 0)
       meanVector = mean(classi,2);
       covMatrix = cov(classi');
       %Add small regularization parameter
       covMatrix = covMatrix + regParam*eye(numParameters);
       classPosteriors(i,:) = mvnpdf(data',meanVector',covMatrix).*priors(i);
   else
       classPosteriors(i,:) = zeros(1, size(data,2));
   end
end

%Choose class of data based on maximum posterior probability
for i = 1:size(data,2)
   [~, decisions(i)] = max(classPosteriors(:,i)); 
end

end