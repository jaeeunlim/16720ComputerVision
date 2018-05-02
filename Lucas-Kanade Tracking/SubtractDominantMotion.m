function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size

mask = ones(size(image1));
M = LucasKanadeAffine(image1, image2);

img1 = im2double(image1);
img2 = im2double(image2);

% threshold = 0.18;
m = affine2d(M);
Iwarp = imwarp(img1,m);
diff = abs(img2-Iwarp);
threshold = graythresh(double(diff));
mask(diff<threshold) = 0;
mask = imbinarize(medfilt2(mask), graythresh(mask));
mask = imdilate(mask, strel('disk',5));
mask = imerode(mask, strel('disk',5));

end