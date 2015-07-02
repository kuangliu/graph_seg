function [uf, sorted_graph] = segment_graph(graph, num_nodes, K)
%% Segment an image
% Returns a color image representing the segmentation.
% Inputs:
%      graph: [4*H*W, 3] matrix, each row = [idxA, idxB, weight]
%
% Outputs:
%      num_ccs: number of connected components in the segmentation.


num_edges = size(graph, 1);

uf = UF(num_nodes);
threshold = ones(num_nodes, 1) * K;

[~, order] = sort(graph(:, 3));
sorted_graph = graph(order, :);

fprintf('segmenting...\n')
for i = 1:num_edges
    if mod(i, 5000) == 0
        fprintf('%d/%d\n', i, num_edges)
    end
    
    edge = sorted_graph(i, :);
    % idx_a = edge(1)
    % idx_b = edge(2)
    % weight = edge(3)
    parent_a = uf.find_id(edge(1));
    parent_b = uf.find_id(edge(2));
    condition_a = edge(3) <= threshold(parent_a);
    condition_b = edge(3) <= threshold(parent_b);
    
    if parent_a ~= parent_b && condition_a && condition_b % different components & disjoint diff < internel diff
        new_root = parent_a;
        if uf.sz(parent_a) < uf.sz(parent_b)
            new_root = parent_b;
        end
        
        uf = uf.union(parent_a, parent_b);
        % new_root = uf.find_id(parent_a); % new_root = id of the smaller size one
        
        threshold(parent_b) = edge(3) + K / uf.sz(new_root);
    end
end
fprintf('done!\n')






























