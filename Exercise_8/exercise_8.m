close all;

% Samples column-wise
X = [1.0 1.7
     2.2 1.4
     2.1 2.3
     0.7 2.2
     2.6 1.9]';

W = k_means(X, X(:, [1 4]));

function W = k_means(X, W0)
    % Codebook vectors
    W = W0;
    % History of codebook vectors
    W_hist = W(:);

    minimum_change = 1e-3;
    delta_w = ones(size(W));

    while true
        % Compute distances between xi and all codebook vectors
        nn = zeros(1, size(X, 2));

        for it_x = 1:size(X, 2)
            dists = X(:, it_x) - W;
            dists = dists .^ 2;
            dists = sum(dists, 1);
            % Determine NN codebook vector
            [~, nn(it_x)] = min(dists);
        end
        % Move codebook vectors into their centroids
        for it_w = 1:size(W, 2)
            new_w = mean(X(:, nn == it_w), 2);
            delta_w(:, it_w) = W(:, it_w) - new_w;
            W(:, it_w) = new_w;
        end

        W_hist = [W_hist, W(:)];

        % Termination criterion
        delta_w = abs(delta_w);
        if sum(delta_w(:) < minimum_change)
            break;
        end
    end

    % Plot result
    plot(X(1, :), X(2, :), 'bo');
    hold on;
    for it = 1:size(W_hist, 2)
        colour = 1 - ones(1, 3) * it / size(W_hist, 2);
        tmp = reshape(W_hist(:, it), [], size(W, 2));
        plot(tmp(1, :), tmp(2, :), 'o', 'markeredgecolor', colour);
    end
    hold off;
    grid on;

end
