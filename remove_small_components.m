function [uf, sorted_graph] = remove_small_components(uf, sorted_graph, min_size)
%% remove small components: sz < min_size
num_edges = size(sorted_graph, 1);
fprintf('removing small components...\n')
for i = 1:num_edges
    if mod(i, 5000) == 0
        fprintf('%d/%d\n', i, num_edges)
    end
    edge = sorted_graph(i, :);
    a = uf.find_id(edge(1));
    b = uf.find_id(edge(2));
    
    if a~=b && (uf.sz(a) < min_size || uf.sz(b) < min_size)
        uf.union(a, b);
    end
end
fprintf('done!\n')