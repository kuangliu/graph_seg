function img = filter_image(img, sigma)
%% Smooth image use Guassian filter
% blur image before build the graph is very important!
% cause it will prevent lots of 0 weights

alpha = 4;
sigma = max(sigma, 0.01);
k_size = ceil(sigma * alpha) + 1;  % use variant kernel size

guassian_filter = fspecial('gaussian', [k_size, k_size], sigma);
img = imfilter(img, guassian_filter);
