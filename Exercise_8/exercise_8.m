close all;

% Samples column-wise
X = [1.0 1.7
     2.2 1.4
     2.1 2.3
     0.7 2.2
     2.6 1.9]';

W = k_means(X, X(:, [1 4]));

function W = k_means(X, W0)
    % Number of clusters
    k = size(W0, 2);
    % Codebook vectors
    W = W0;
    % History of codebook vectors
    W_hist = [];

    minimum_change = 1e-3;
    delta_w = ones(size(W));

    while true
        % Compute distances between xi and all codebook vectors
        dists = zeros(1, size(W0, 2));
        nn = zeros(1, size(X, 2));

        for it_x = 1:size(X, 2)
            for it_w = 1:size(W, 2)
                dists(it_w) = norm(X(:, it_x) - W(:, it_w));
            end
            % NN classification
            [~, nn(it_x)] = min(dists);
        end
        % Move codebook vectors into their centroids
        for it_w = 1:size(W, 2)
            new_w = mean(X(:, nn == it_w), 2);
            delta_w(:, it_w) = W(:, it_w) - new_w;
            W(:, it_w) = new_w;
        end

        plot(X(1, :), X(2, :), 'bo');
        hold on;
        plot(W(1, :), W(2, :), 'go')
        hold off;
        grid on;

        delta_w = abs(delta_w);
        if ~sum(delta_w(:) > minimum_change)
            break;
        end
    end

end
