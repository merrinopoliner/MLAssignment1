load('WINEdata.mat');
load('WINElabels.mat');

%add 1 to wine labels so that index starts with 1
WINElabelsAdjusted = WINElabels + 1;

%Use MAP classification to minimize P(error)
[WINEdecisionsAdjusted, WINEpriors] = minPerror(WINEdata, WINElabelsAdjusted, 11, 0.1);

%calculate confusion matrix
WINEconfusion = calcConfuse(WINEdecisionsAdjusted, WINElabelsAdjusted, 11, WINEpriors);

WINEperror = 1 - trace(WINEconfusion)

%remove 1 from decisions to match initial wine labels
WINEdecisions = WINEdecisionsAdjusted - 1;

%Find the first 3 principle components of the WINE data to plot
[EigVec, EigVal] = eig(cov(WINEdata'));
[~, eigIndex] = sort(diag(EigVal), 'descend');
SortedEigVec = EigVec(:,eigIndex);
PrincComp = SortedEigVec(:, [1:3])
% The first three principle components are close to the unit vectors in the
% direction of the total sulfur dioxide (7), free sulfur dioxide(6), and
% residual sugar(4)
figure(1)
plot3(WINEdata(7,:), WINEdata(6,:), WINEdata(4,:), '.b');
xlabel('Total Sulfur Dioxide'),ylabel('Free Sulfur Dioxide'), zlabel('Residual Sugar'), title('Principle components for wine data')

load('HARdata.mat');
load('HARlabels.mat');
[HARdecisions, HARpriors] = minPerror(HARdata, HARlabels, 6, 0.1);
HARconfusion = calcConfuse(HARdecisions, HARlabels, 6, HARpriors);

HARperror = 1 - trace(HARconfusion)

%Find the first 3 principle components of the HAR data to plot
[EigVec, EigVal] = eig(cov(HARdata'));
[~, eigIndex] = sort(diag(EigVal), 'descend');
SortedEigVec = EigVec(:,eigIndex);
PrincComp = SortedEigVec(:, [1:3])
% The first three principle components are not close to any parameter, so
% the plot will just be in terms of those components
figure(2)

%plot3(WINEdata(7,:), WINEdata(6,:), WINEdata(4,:), '.b');
%xlabel('Total Sulfur Dioxide'),ylabel('Free Sulfur Dioxide'), zlabel('Residual Sugar'), title('Principle components for wine data')


