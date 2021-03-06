function [newpts, Translation] = normalize(pts)

% Input: pts, format is [(x1, y1, 1), (x2, y2, 1) ...]

% Normalization Transformation

% The transformation is as follows :
% 1.The points are translated so that their centroid is
% at the origin.
% 
% 2.The points are then scaled isotropically so that
% the average distance from the origin is equal to
% ?2.

% Hartley, R. I. (1997) In defense of the eight-point algorithm. 
% IEEE Transactions on Pattern Analysis & Machine Intelligence 19 
% (6): 580?593. 364, 380

% Step 1: Find the mean value of the x and y coordinates of the entire 
% group of points.

x_coords_mean = mean(pts(:, 1:1));
y_coords_mean = mean(pts(:, 2:2));

centroid = [x_coords_mean y_coords_mean];

% Step 2: Find the scaling factor by dividing the sqrt(2) by the
% hypotenuse of the x and y means

% take difference from mean of every coordinate
diff = pts(:, 1:2) - repmat(centroid, size(pts, 1), 1);

% compute the sum of the squared distance to get the average distance
avgdist = sum(sqrt(diff(:, 1).^2 + diff( :, 2).^2)) / size(pts, 1);

% sqrt(2) by the hypotenuse of the x and y means.
scale = sqrt(2) / avgdist;

Translation = diag([scale scale 1]) * [eye(3,2) [-centroid 1]'];
newpts = pts * Translation';