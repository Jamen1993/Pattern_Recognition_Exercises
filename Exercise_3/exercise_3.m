% pr_exercise_3.m

% Read again the sescirption and answer the following:
%
% 1. Based on your observations are all the selected featured needed for correct classifications?
%
% 2. Based on the assumptiom that the selected features are conditionally independent classify the observations
%
% 3. Visualize the risk of a wrong decision for observetion 5 by varying the coordinates under the assumption of a Zero-One loss model

close all;

% load data
observations_1 = readtable('observations.csv');

fh = @(x) reshape(x, [], 4);

latitude = fh(observations_1.latitude);
longitude = fh(observations_1.longitude);
body_temperature = fh(observations_1.bodyTemperature);
tiredness = fh(observations_1.tiredness);
headache = fh(observations_1.headache);

%% Task 1

plot_histogram(latitude, 'Latitude');
plot_histogram(longitude, 'Longitude');
plot_histogram(body_temperature, 'Body Temperature');
plot_histogram(tiredness, 'Tiredness');
plot_histogram(headache, 'Headache');

%% Task 2
observations_2 = [42.12 10.43 37.7 5.0 2.1;
49.82 22.89 38.6 3.4 3.9;
58.90 18.71 40.1 2.2 7.7;
32.85 06.35 38.2 8.6 1.0;
54.56 22.43 38.3 9.3 9.0;
42.85 -0.35 36.2 1.6 4.2];

% Compute class distributions

% Latitude
% Gaussian with good separation of classes with respect to mean and std
latitude_means = mean(latitude, 1);
latitude_stds = std(latitude, 1);

% Longitude
% Gaussian with good separation of classes with respect to mean and std
longitude_means = mean(longitude, 1);
longitude_stds = std(longitude, 1);

% Body Temperature
% Gaussian with good separation of classes with respect to mean and std
body_temperature_means = mean(body_temperature, 1);
body_temperature_stds = std(body_temperature, 1);

% Tiredness
% Non standard shaped distribution with good seperation of classes
bin_edges = 0:0.5:10;
tiredness_distributions = zeros(length(bin_edges) - 1, 4);
% for each class
for it = 1:4
    tiredness_distributions(:, it) = histcounts(tiredness(:, it), bin_edges);
end
% Normalise to get pdf
tiredness_distributions = tiredness_distributions ./ sum(tiredness_distributions, 1);


% Compute sample likelihood for each class and feature
% Sample index is row index and class index is column index

% Gaussian distributed features
Latitude_probabilities = gaussian_probability(observations_2(:, 1), latitude_means, latitude_stds);
Longitude_probabilities = gaussian_probability(observations_2(:, 2), longitude_means, longitude_stds);
Body_temperature_probabilities = gaussian_probability(observations_2(:, 3), body_temperature_means, body_temperature_stds);

% Tiredness
% Determine bin index
bin_indices = floor(observations_2(:, 4) / 0.5) + 1;

Tiredness_probabilities = tiredness_distributions(bin_indices, :);

% Likelihood
Likelihoods = Latitude_probabilities .* Longitude_probabilities .* Body_temperature_probabilities .* Tiredness_probabilities;

% Apply Bayes to get posterior likelihood
priors = [4 1 3 2] / 10;

Posteriors = Likelihoods .* priors;

% Select class with maximum likelihood

[~, labels] = max(Posteriors, [], 2);

disp('Classification Result:');
disp(labels);

%% Task 3
%
% (code)
%

function plot_histogram(data, name)
    figure('name', name);
    limits = [floor(min(data(:))) ceil(max(data(:)))];

    % for each class
    for it = 1:size(data, 2)
        subplot(4, 1, it);
        histogram(data(:, it));
        grid on;
        xlim(limits);
        title(sprintf('Disease %d %s = %.2f std = %.2f', it, '\mu', mean(data(:, it)), std(data(:, it))));
    end
end

function probability = gaussian_probability(x, m, s)
    scaling_factor = sqrt(2 * pi) .* s;
    numerator = (x - m) .^ 2;
    denominator = 2 * s .^ 2;

    probability = exp(-numerator ./ denominator) ./ scaling_factor;
end
