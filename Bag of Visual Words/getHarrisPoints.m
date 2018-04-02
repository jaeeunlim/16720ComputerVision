function [points] = getHarrisPoints(I, alpha, k)
% Finds the corner points in an image using the Harris Corner detection algorithm
% Input:
%   I:                      grayscale image
%   alpha:                  number of points
%   k:                      Harris parameter
% Output:
%   points:                    point locations
%
    % -----fill in your implementation here --------
    if size(I,3) ~= 1
        I = rgb2gray(I);
    end
    
    [h,w] = size(I);
    [Ix,Iy] = imgradientxy(I);
    Ix = Ix - mean(mean(Ix)); % subtract mean from image gradient
    Iy = Iy - mean(mean(Iy));
    
    window = ones(3);
    sum_xx = conv2(Ix.*Ix,window,'same');
    sum_xy = conv2(Ix.*Iy,window,'same');
    sum_yx = conv2(Iy.*Ix,window,'same');
    sum_yy = conv2(Iy.*Iy,window,'same');

    Hs = zeros(2,2,numel(I));
    Hs(1,1,:) = sum_xx(:);
    Hs(1,2,:) = sum_xy(:);
    Hs(2,1,:) = sum_yx(:);
    Hs(2,2,:) = sum_yy(:);
    
    Rs = zeros(1,numel(I));
    for i = 1:numel(I)
        H = Hs(:,:,i);
        Rs(1,i) = det(H) - k*trace(H)^2;
    end

    [~,idx] = sort(Rs,'descend');
    idxs = ind2sub(size(idx),idx(1:alpha));
    
    points = zeros(alpha,2);
    points(:,1) = ceil(idxs/h);
    points(:,2) = mod(idxs,h);
    points = points + h*xor(points,1);

    % ------------------------------------------

end
