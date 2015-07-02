function graph = build_graph(im)
%% Build graph on image
% Input:
%   im: RGB image
% Output:
%   graph: [4*H*W, 3] each row is [pointA_idx, pointB_idx, AB_diff]


% Get image size
[H, W, ~] = size(im);

if isa(im, 'uint8') % cast uint8 to double
    im = double(im);
end

% graph = zeros(4*H*W-2*H-2*W+2, 3);  
% note that after the iteration, there will be same edges not be assigned
% TODO: eliminate these edges
graph = zeros(2*(H-1)*(W-1)+(H-1)*W+(W-1)*H, 3);
cnt = 1;

for w = 1:W
    for h = 1:H
        idx = (w-1)*H + h;   % current point index
        point = im(h, w, :); % corrent point color
        point = point(:);    % reshape to 1 column
        
        if h < H
            idx_d = idx + 1;    % down point
            point_d = im(h+1, w, :);
            graph(cnt, 1) = idx;
            graph(cnt, 2) = idx_d;
            graph(cnt, 3) = norm(point-point_d(:));    % Euclidean distance
            cnt = cnt + 1;
        end
        
        if w < W
            idx_r = idx + H;    % right point
            point_r = im(h, w+1, :);
            graph(cnt, 1) = idx;
            graph(cnt, 2) = idx_r;
            graph(cnt, 3) = norm(point-point_r(:));
            cnt = cnt + 1;
        end
        
        if h < H && w < W
            idx_rd = idx + H + 1;    % right-down point
            point_rd = im(h+1, w+1, :);
            graph(cnt, 1) = idx;
            graph(cnt, 2) = idx_rd;
            graph(cnt, 3) = norm(point-point_rd(:));
            cnt = cnt + 1;
        end
        
        if h > 1 && w < W
            idx_ru = idx + H - 1;    % right-up point
            point_ru = im(h-1, w+1, :);
            graph(cnt, 1) = idx;
            graph(cnt, 2) = idx_ru;
            graph(cnt, 3) = norm(point-point_ru(:));
            cnt = cnt + 1;
        end
    end
end

% fprintf('%d\n%d', cnt, 4*H*W)



