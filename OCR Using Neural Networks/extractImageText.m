function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the text contained in the image as a string.

im = imread(fname);
[lines, bw] = findLetters(im);
model = load('nist36_model.mat');
W = model.W;
b = model.b;

text = "";
letters = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',...
    'P','Q','R','S','T','U','V','W','X','Y','Z',...
    '1','2','3','4','5','6','7','8','9','0'];
for i=1:length(lines)
    coords = lines{i};
    data = zeros(length(coords),32*32);
    for j=1:size(coords,1)
        % change coords representation to pixels
        coord = coords(j,:);
        pixels = bw(coord(2):coord(4),coord(1):coord(3));
        pad1 = 1;
        pad2 = 2;
        resizedim = imresize(pixels, [32-2*pad1 32-2*pad2]);
        resizedim = padarray(resizedim,[pad1 pad2],1);
        data(j,:) = resizedim(:);
    end
    [outputs] = Classify(W, b, data);
    for k=1:length(outputs)
        out = outputs{k};
        [~,I] = max(out);
        text = strcat(text,letters(I));
    end
    text = strcat(text,'\n');
end

end
