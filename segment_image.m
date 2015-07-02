function ret_img = segment_graph(graph, num_nodes, K)
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

for i = 1:num_edges
    if mod(i, 5000) == 0
        fprintf('%d\n', i)
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

%% remove all small components
for i = 1:num_edges
    if mod(i, 5000) == 0
        fprintf('%d\n', i)
    end
    edge = sorted_graph(i, :);
    a = uf.find_id(edge(1));
    b = uf.find_id(edge(2));
    
    if a~=b && (uf.sz(a) < min_size || uf.sz(b) < min_size)
        uf.union(a, b);
    end
end

%% save result image
color_map = uint8(randi([0, 255], num_nodes, 3));

ret_img = zeros(H, W, 3, 'uint8');
for w = 1:W
    for h = 1:H
        id = uf.find_id((w-1)*H+h);
        ret_img(h, w, :) = reshape(color_map(id, :), [1,1,3]);
    end
end





























