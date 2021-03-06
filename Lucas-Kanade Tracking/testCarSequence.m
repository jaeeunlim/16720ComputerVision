close all;
clear all;
clc;

load('../data/carseq.mat');
rect = [60; 117; 146; 152];
fs = [1 50 100 200 300 400];
n = length(fs);
rects = zeros(n,4);
idx = 1;
fig = figure();
for i=1:size(frames,3)-1
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);
    [u,v] = LucasKanadeInverseCompositional(It, It1, rect);
    rect = rect + [u;v;u;v];
    if size(find(fs==i),2) ~= 0
        subplot(2,3,idx);
        imshow(frames(:,:,i));
        hold on;
        rectangle('Position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'Edgecolor','y');
        hold off;
        rects(idx,1:4) = rect;
        idx = idx + 1;
    end
    if i==400
        break;
    end
end

filename = sprintf('testCarSequence.png',i);
saveas(fig, filename);

save('carseqrects.mat','rects');

