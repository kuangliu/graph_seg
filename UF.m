classdef UF
    % Weighted-UF algorithm
    % stupid implementation
    properties
        id
        sz
        count
    end
    
    methods
        function uf = UF(N)
            uf.id = 1:N;
            uf.sz = ones(1, N);
            uf.count = N;
        end
        
        function pid = find_id(uf, p)
            while p ~= uf.id(p)
                p = uf.id(uf.id(p));
            end
            pid = p;
        end
        
        function ret = connected(uf, p, q)
            ret = (find_id(uf, p) == find_id(uf, q));
        end
        
        function uf = union(uf, p, q)
            i = find_id(uf, p);
            j = find_id(uf, q);
            if i == j
                return
            end
                
            if uf.sz(i) < uf.sz(j)
                uf.id(i) = j;
                uf.sz(j) = uf.sz(j) + uf.sz(i);
            else
                uf.id(j) = i;
                uf.sz(i) = uf.sz(i) + uf.sz(j);
            end
            uf.count = uf.count - 1; 
        end
    end    
end

