%The main function of question 1

hold off;
N = 10000;

mu1 = [-1, 1, -1, 1];
mu2 = [1, 1, 1, 1];

C0 = [2, -0.5, 0.3, 0;
    -0.5, 1, -0.5, 0;
    0.3, -0.5, 1, 0;
    0, 0, 0, 2];

C1 = [1, 0.3, -0.2, 0;
    0.3, 2, 0.3, 0;
    -0.2, 0.3, 1, 0;
    0, 0, 0, 3];


pdfs.meanVectors = [mu1', mu2'];
pdfs.covMatrices(:,:,1) = C0;
pdfs.covMatrices(:,:,2) = C1;

pdfs.priors = [0.7, 0.3];

[samples, labels] = generateDataFromGMM(N, pdfs);

figure(1);
TrueERM(N, pdfs, samples, labels);
figure(2);
NaiveERM(N, pdfs, samples, labels);


