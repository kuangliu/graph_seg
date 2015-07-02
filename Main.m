clc; clear; close all;

sigma = 0.8;
K = 300;
min_size = 30;

im = imread('/home/kuang/beauty.jpg');  % RGB image
im = imresize(im, 0.25);
im = double(im);

[H, W, ~] = size(im);
num_nodes = H*W;

imshow(uint8(im))
figure

im2 = filter_image(im, sigma);
imshow(uint8(im2))

graph = build_graph(im2);
[uf, sorted_graph] = segment_graph(graph, num_nodes, K);
[uf, sorted_graph] = remove_small_components(uf, sorted_graph, min_size);
ret_img = build_seg_image(uf, H, W);

figure
imshow(ret_img)



