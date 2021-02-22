

%First get 4 Gaussian distribtutions using the generate data function.

hold off;
N = 10000;

mu1 = [-1.5, 1.5, -1.5];
mu2 = [1.5, 1.5, 1.5];
mu3 = [1, -1.5, -1.5];
mu4 = [1.5, -1.5, 1.5];

C1 = [3, -0.5, 0.3;
      -0.5, 5, -0.9;
      0.3, -0.9, 4];

C2 = [6, -2, 1;
     -2, 2, 0.8;
     1, 0.8, 4];
 
C3 = [10, 3, 2;
      3, 5, 1;
      2, 1, 1];
  
C4 = [3, 3, 3;
     3, 4, 4
     3, 4, 5];


pdfs.meanVectors = [mu1', mu2', mu3', mu4'];
pdfs.covMatrices(:,:,1) = C1;
pdfs.covMatrices(:,:,2) = C2;
pdfs.covMatrices(:,:,3) = C3;
pdfs.covMatrices(:,:,4) = C4;

pdfs.priors = [0.3, 0.3, 0.2, 0.2];

[samples, labels] = generateDataFromGMM(N, pdfs);

%Now combine the last two distributions into the same class
class3SecondPDF = find(labels == 4);
labels(class3SecondPDF) = 3 * ones(1, length(class3SecondPDF));

%P(error) minimization
lossMatrix = ones(3) - eye(3);
decisions = ERM(pdfs, samples, lossMatrix);
confusionMatrix = calcConfuse(decisions, labels, [0.3, 0.3, 0.4])
%classification visual representation
figure(1)
plotConfusion(samples, decisions, labels);

%Loss matrix (10) minimization
lossMatrix = [0, 1, 10;
              1, 0, 10;
              1, 1, 0];
decisions = ERM(pdfs, samples, lossMatrix);
confusionMatrix = calcConfuse(decisions, labels, [0.3, 0.3, 0.4])
%classification visual representation
figure(2)
plotConfusion(samples, decisions, labels);

%Loss matrix (100) minimization
lossMatrix = [0, 1, 100;
              1, 0, 100;
              1, 1, 0];
decisions = ERM(pdfs, samples, lossMatrix);
confusionMatrix = calcConfuse(decisions, labels, [0.3, 0.3, 0.4])
%classification visual representation
figure(3)
plotConfusion(samples, decisions, labels);


hold off;

