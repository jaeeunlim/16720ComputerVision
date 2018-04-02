function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
%
% To prevent clipping at the edges, we instead need to warp both image 1 and image 2 into a common third reference frame 
% in which we can display both images without any clipping.

% scale and translation
sx = H2to1(1,1);
sy = H2to1(2,2);
tx = -H2to1(2,3);
ty = H2to1(1,3)/2;
M = [sx 0 tx; 0 sy ty; 0 0 1];

% warp
outsize = size(img1);
warp_im1 = warpH(img1, M, outsize);
warp_im2 = warpH(img2, M*H2to1, outsize);

% overlay
warp_im1(find(warp_im2>0)) = warp_im2(find(warp_im2>0));
panoImg = warp_im1;

%%%

end