function decisions = ERM(pdfs, samples, lossMatrix)

MLClass1 = evalGaussian(samples, pdfs.meanVectors(:,1), pdfs.covMatrices(:,:,1));
MLClass2 = evalGaussian(samples, pdfs.meanVectors(:,2), pdfs.covMatrices(:,:,2));
MLClass3 = evalGaussian(samples, pdfs.meanVectors(:,3), pdfs.covMatrices(:,:,3))+ evalGaussian(samples, pdfs.meanVectors(:,4), pdfs.covMatrices(:,:,4));

PClass1 = MLClass1 * pdfs.priors(1);
PClass2 = MLClass2 * pdfs.priors(2);
PClass3 = MLClass3 * (pdfs.priors(3) + pdfs.priors(4));

PosteriorMatrix = [PClass1; PClass2; PClass3];

RiskMatrix = lossMatrix * PosteriorMatrix;

decisions = zeros(1, length(samples));
for i = 1:length(samples)
   [~, decisions(i)] = min(RiskMatrix(:,i));
end


end