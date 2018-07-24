% exercise 2
% In this exercise we want to find how well a binary classifier works in 
% detecting above normal values from two interleaved normal distributions.
% 1. Plot the ROC curve for the decision rule
% 2. Plot the Precision-Recall curve of the same data
% 3. Plot the cost curve for the provided costs of different types of mistakes
% 4. Find the optimal point of operation

% normal distribution classes
rng(0);
numOfObservations = 1000;
mean1 = 3;
std1 = 2;
mean2 = 7;
std2= 2;
normal = sort(normrnd(mean1, std1, [1 numOfObservations]), 'descend');
aboveNormal = sort(normrnd(mean2, std2, [1 numOfObservations]), 'descend');

% Calculate and plot the ROC curve below
% 
% (code)
%


% Calculate precision, recall and plot curve below
%
% (code)
%


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

