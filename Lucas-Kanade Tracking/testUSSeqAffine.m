close all;
clear all;
clc;

load('../data/usseq.mat');
load('usseqrects.mat');
fs = [5 25 50 75 100];
idx = 1;
fig = figure();
for i=1:size(frames,3)-1
    image1 = frames(:,:,i);
    image2 = frames(:,:,i+1);
    mask = SubtractDominantMotion(image1, image2);
    if size(find(fs==i+1),2) ~= 0
        rect = rects(idx,:);
        m = zeros(size(mask));
        m(rect(2):rect(4),rect(1):rect(3)) = 1;
        img = imfuse(image2,mask.*m);
        subplot(1,5,idx);
        imshow(img);
        idx = idx + 1;
    end
    if i==100
        break;
    end
end

filename = sprintf('usSeqAffine.png');
saveas(fig, filename);

