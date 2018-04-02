function [locs, desc] = computeBrief(im, locs, compareX, compareY)
% Compute the BRIEF descriptor for detected keypoints.
% im is 1 channel image, 
% locs are locations
% compareX and compareY are idx in patchWidth^2
% Return:
% locs: m x 2 vector which contains the coordinates of the keypoints
% desc: m x nbits vector which contains the BRIEF descriptor for each
%   keypoint.

nbits = length(compareX);
pad = 4;
[rows,cols] = size(im);
idx = find(locs(:,1)>pad & locs(:,1)<cols-pad &...
    locs(:,2)>pad & locs(:,2)<rows-pad);
m = length(idx);
newlocs = zeros(m,2);
desc = zeros(m,nbits);

for i=1:m
    I = idx(i);
    index = locs(I,:);
    p = im(index(2)-pad:index(2)+pad,index(1)-pad:index(1)+pad);
    newlocs(i,:) = index;
    for j=1:nbits
        x = compareX(j);
        y = compareY(j);
        I1 = p(x);
        I2 = p(y);
        if I1 < I2
            desc(i,j) = 1;
        end
    end
end
locs = newlocs;

%%%
end