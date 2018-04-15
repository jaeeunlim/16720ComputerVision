function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup

% Get epipolar line
l = F*[x1;y1;1];

% Create window patch
pad = 10;
patch1 = double(im1(y1-pad:y1+pad, x1-pad:x1+pad));
weight = fspecial('gaussian', [2*pad+1, 2*pad+1], pad/2);

% Search for min Manhattan distance
height = size(im2,1);
errors = zeros(1,height-2*pad);
for y=1+pad:height-pad
    x = round(-(l(2)*y+l(3))/l(1));
    patch2 = double(im2(y-pad:y+pad, x-pad:x+pad));
    errors(y-pad) = sum(sum(abs((patch1-patch2).*weight)));
end

[~,I] = min(errors);
y2 = I;
x2 = -(l(2)*y+l(3))/l(1);

end

