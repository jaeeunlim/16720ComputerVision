function [lines, bw] = findLetters(im)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.

% Process the image
img = im+10; % increase brightness
img = imgaussfilt(img,2);
bw = im2bw(img);
bw = 1-bw;
se = strel('line',15,5);
bw = imdilate(bw,se);
bw = 1-bw;

figure();
imshow(im);
hold on;

% Find connected groups of character pixels. Place bounding box around each
% connected component
BW = 1-bw;
cc = bwconncomp(BW); % takes black background
N = length(cc.PixelIdxList);
lines = {};
count = 0; % # of lines found
cys = [];
delta = 50;
for i=1:N
    pixels = cc.PixelIdxList{i};
    [Y,X] = ind2sub(cc.ImageSize,pixels);
    y1 = min(Y); x1 = min(X);
    y2 = max(Y); x2 = max(X);
    dx = x2-x1; dy = y2-y1;
    threshold = 20;
    if dx > threshold && dy > threshold % only consider when box is large enough
        % Group the letters based on which line of the text they are a part of
        if length(cys) > 0
            y1vec = y1*ones(1,length(cys));
            y2vec = y2*ones(1,length(cys));
            idx1 = find(y1vec-cys < delta);
            idx2 = find(cys-y2vec < delta);
            if (length(idx1)>0 &&  (length(idx2)>0) && length(intersect(idx1,idx2))>0)% on same line
                idx = intersect(idx1,idx2);
                idx = idx(1);
                lines{idx} = vertcat(lines{idx}, [x1,y1,x1+dx,y1+dy]);
            else % new line
                count = count + 1;
                cys(end+1) = y1+dy/2;
                lines{end+1} = [x1,y1,x1+dx,y1+dy];
            end
        else % first line
            count = count + 1;
            cys(end+1) = y1+dy/2; 
            lines{end+1} = [x1,y1,x1+dx,y1+dy];
        end
        % display on image
        rectangle('Position', [x1,y1,dx,dy], 'EdgeColor','r', 'LineWidth', 1);
        hold on; 
    end    
end
hold off;

% Sort the group so that the letters are in the order they appear on the page. 
for i=1:length(lines)
    line = lines{i};
    lines{i} = sortrows(line); % sort letters
end
idx = cellfun(@(x)x(1,2), lines);
[~,order] = sort(idx); % sort lines
lines = lines(order);

end
