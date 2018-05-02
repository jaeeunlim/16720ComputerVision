close all;
clear all;
clc;

load('../data/aerialseq.mat');
fs = [30 60 90 120];
idx = 1;
fig = figure();
for i=1:size(frames,3)-1
    image1 = frames(:,:,i);
    image2 = frames(:,:,i+1);
    mask = SubtractDominantMotion(image1, image2);
    if size(find(fs==i),2) ~= 0
        img = imfuse(image2,mask);
        subplot(1,4,idx);
        imshow(img);
        idx = idx + 1;
    end
    if i==120
        break;
    end
end
filename = sprintf('aeralSeq.png');
saveas(fig, filename);


