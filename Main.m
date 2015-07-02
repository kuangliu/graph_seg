clc; clear; close all;

sigma = 0.8;
K = 300;    % 300 components
min_size = 30;

im = imread('/home/kuang/beauty.jpg');  % RGB image
[H, W, ~] = size(im);
imshow(im)
figure

im2 = filter_image(im, sigma);
imshow(im2)

graph = build_graph(im2);


