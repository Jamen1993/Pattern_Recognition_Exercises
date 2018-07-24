% exercise 2
% In this exercise we want to find how well a binary classifier works in
% detecting above normal values from two interleaved normal distributions.
% 1. Plot the ROC curve for the decision rule
% 2. Plot the Precision-Recall curve of the same data
% 3. Plot the cost curve for the provided costs of different types of mistakes
% 4. Find the optimal point of operation

close all;

% Read observations from file
data = readtable('observations.csv');
normal = data.normal;
above_normal = data.aboveNormal;

% Calculate sensible thresholds
min_threshold = floor(min([normal; above_normal]));
max_threshold = ceil(max([normal; above_normal]));
thresholds = linspace(min_threshold, max_threshold);

% Classifier performance
TP = zeros(100, 1);
FP = zeros(100, 1);
TN = zeros(100, 1);
FN = zeros(100, 1);

for it = 1:100
    threshold = thresholds(it);

    classified_normal = normal > threshold;
    classified_above_normal = above_normal > threshold;

    TP(it) = sum(classified_above_normal);
    FP(it) = sum(classified_normal);
    TN(it) = sum(~classified_normal);
    FN(it) = sum(~classified_above_normal);
end

% Calculate and plot the ROC curve
sensitivities = TP / length(above_normal);
specificities = TN / length(normal);

subplot(2, 2, 1);
plot(1 - specificities, sensitivities);
title('ROC');
xlabel('1 - specificity / FPR');
ylabel('sensitivity / TPR');
grid on;

% Calculate precision, recall and plot curve
P = TP + FP;

precisions = TP ./ P;
recalls = sensitivities;

subplot(2, 2, 2);
plot(recalls, precisions);
title('PRC');
xlabel('recall / PPV');
ylabel('precision / TPR');
grid on;

% Given the following costs, plot the cost function below
cfn = 1; % cost false negative
cfp = 1; % cost false positive

costs = cfn * FN + cfp * FP;

subplot(2, 2, 3);
plot(thresholds, costs);
title('Cost function');
xlabel('Threshold');
ylabel('Cost');
grid on;

% Given the previous cost fuction, find the optimal threshold
[~, index_min] = min(costs);
optimal_threshold = thresholds(index_min);

subplot(2, 2, 4);
text(0.5, 0.5, sprintf('Optimal threshold = %.2f', optimal_threshold), 'horizontalalignment', 'center', 'fontweight', 'bold');
set(gca, 'visible', 'off');

