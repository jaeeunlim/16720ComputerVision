close all;
clear all
clc;

load('../data/usseq.mat');
rect = [255; 105; 310; 170];
fs = [5 25 20 75 100];
n = length(fs);
rects = zeros(n,4);
idx = 1;
fig = figure();
for i=1:size(frames,3)-1
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);
    [u,v] = LucasKanadeInverseCompositional(It, It1, rect);
    rect = rect + [u;v;u;v];
    if size(find(fs==i+1),2) ~= 0
        subplot(1,5,idx);
        imshow(frames(:,:,i));
        hold on;
        rectangle('Position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'Edgecolor','y');
        rects(idx,1:4) = rect;
        idx = idx + 1;
    end
    if i==100
        break;
    end
end

filename = sprintf('ultrasoundSeq.png');
saveas(fig, filename);

save('usseqrects.mat','rects');