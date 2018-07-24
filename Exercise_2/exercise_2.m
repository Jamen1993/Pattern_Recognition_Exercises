% exercise 2
% In this exercise we want to find how well a binary classifier works in
% detecting above normal values from two interleaved normal distributions.
% 1. Plot the ROC curve for the decision rule
% 2. Plot the Precision-Recall curve of the same data
% 3. Plot the cost curve for the provided costs of different types of mistakes
% 4. Find the optimal point of operation

% Read observations from file
data = readtable('observations.csv');
normal = data.normal;
above_normal = data.aboveNormal;

min_threshold = floor(min([normal; above_normal]));
max_threshold = ceil(max([normal; above_normal]));
thresholds = linspace(min_threshold, max_threshold);

% Calculate and plot the ROC curve
sensitivity = zeros(100, 1);
specificity = zeros(100, 1);

for it = 1:100
    threshold = thresholds(it);

    classified_normal = normal > threshold;
    classified_above_normal = above_normal > threshold;

    TP = sum(classified_above_normal);
    % FP = sum(classified_normal);
    TN = sum(~classified_normal);
    % FN = sum(~classified_above_normal);

    sensitivity(it) = TP / length(above_normal);
    specificity(it) = TN / length(normal);
end

subplot(1, 2, 1);
plot(1 - specificity, sensitivity);
title('ROC');
xlabel('1 - specificity / FPR');
ylabel('sensitivity / TPR');
grid on;

% Calculate precision, recall and plot curve
precision = zeros(100, 1);
recall = sensitivity;

for it = 1:100
    threshold = thresholds(it);

    classified_normal = normal > threshold;
    classified_above_normal = above_normal > threshold;

    TP = sum(classified_above_normal);
    FP = sum(classified_normal);
    % TN = sum(~classified_normal);
    % FN = sum(~classified_above_normal);

    P = TP + FP;

    precision(it) = TP / P;
end

subplot(1, 2, 2);
plot(recall, precision);
title('PRC');
xlabel('recall / PPV');
ylabel('precision / TPR');
grid on;

% Given the following costs, plot the cost function below
cfn = 1; % cost false negative
cfp = 1; % cost false positive

%
% (code)
%



% Given the previous cost fuction, find the optimal threshold
%
% (code)
%

