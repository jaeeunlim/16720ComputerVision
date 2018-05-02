close all;
clear all;
clc;

load('../data/sylvseq.mat');
load('../data/sylvbases.mat');
rect = [102; 62; 156; 108];
rect1 = [102; 62; 156; 108];
fs = [1 200 300 350 400];
n = length(fs);
rects = zeros(n,4);
rects1 = zeros(n,4);
idx = 1;
fig = figure();
for i=1:size(frames,3)-1
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);
    [u,v] = LucasKanadeBasis(It, It1, rect, bases);
    [u1,v1] = LucasKanadeInverseCompositional(It, It1, rect1);
    rect = rect + [u;v;u;v];
    rect1 = rect1 + [u1;v1;u1;v1];
    if size(find(fs==i),2) ~= 0
        subplot(1,5,idx);
        imshow(frames(:,:,i));
        hold on;
        rectangle('Position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'Edgecolor','g');
        hold on;
        rectangle('Position',[rect1(1) rect1(2) rect1(3)-rect1(1) rect1(4)-rect1(2)],'Edgecolor','y');
        hold off;
        rects(idx,1:4) = rect;
        rects1(idx,1:4) = rect1;
        idx = idx + 1;
    end
    if i==400
        break;
    end
end

filename = sprintf('sylvSeq.png');
saveas(fig, filename);

save('sylvseqrects.mat','rects');

