im1 = imread('../data/cv_cover.jpg');
im2 = rgb2gray(imread('../data/cv_desk.png'));
im3 = rgb2gray(imread('../data/hp_cover.jpg'));

% compute homography
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
ratio = 1;
matches = briefMatch(desc1, desc2, ratio);
locs1 = locs1(matches(:,1),:);
locs2 = locs2(matches(:,2),:);
[H2to1, inliers] = computeH_ransac(locs1, locs2);

% harry potterize
im3 = imresize(im3, size(im1));
composite_img = compositeH(H2to1, im3, im2);
figure();
imshow(composite_img);
