function NaiveERM(N, pdfs, data_samples, data_labels)

pdfs.comMatrices(:,:,1) = [2, 0, 0, 0;
      0, 1, 0, 0;
      0, 0, 1, 0;
      0, 0, 0, 2];

pdfs.covMatrices(:,:,2) = [1, 0, 0, 0;
      0, 2, 0, 0;
      0, 0, 1, 0;
      0, 0, 0, 3];

%Decide sample classes for many threshold values
gammas = [[0:0.01:10], logspace(0,10,500)];
ml_label0 = evalGaussian(data_samples, pdfs.meanVectors(:,1), pdfs.covMatrices(:,:,1));
ml_label1 = evalGaussian(data_samples, pdfs.meanVectors(:,2), pdfs.covMatrices(:,:,2));
likelihood_ratios = ml_label1 ./ ml_label0;

% The decisions matrix decides all samples for many gamma. Each row of
% the matrix is a decision based on a different threshold value
decisions = zeros(size(gammas, 2), N);
for i = 1 : size(gammas, 2)
    decisions(i,:) = likelihood_ratios >= gammas(i);
end

% find the true positive and false positive rate for each gamma using an
% ROC curve function
labelData.labels = data_labels;
labelData.priors = pdfs.priors;
[Pfalsepos, Ptruepos, Perror] = ROCcurve(decisions, labelData);

plot(Pfalsepos, Ptruepos, 'oy'), hold on;
xlabel('P(False+)'),ylabel('P(True+)'), title('ROC Curve for ML Ratio Classifier')

[~, minGammaIndex] = min(Perror);
minimizingGamma = gammas(minGammaIndex);
minimizingGammaROC = [Pfalsepos(minGammaIndex), Ptruepos(minGammaIndex)];
plot(minimizingGammaROC(1), minimizingGammaROC(2), 'xr');
disp("Naive" + minimizingGamma);

hold off;


end



