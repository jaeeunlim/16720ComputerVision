function [dictionary] = getDictionary(imgPaths, alpha, K, method)
% Generate the filter bank and the dictionary of visual words
% Inputs:
%   imgPaths:        array of strings that repesent paths to the images
%   alpha:          num of points
%   K:              K means parameters
%   method:         string 'random' or 'harris'
% Outputs:
%   dictionary:         a length(imgPaths) * K matrix where each column
%                       represents a single visual word
    % -----fill in your implementation here --------
    
    k = 0.05;
    filterBank = createFilterBank();
    
    T = length(imgPaths);
    n = length(filterBank);
    pixelResponses = zeros(alpha*T, 3*n);
    
    if method == 'random'
        for i = 1:T
            path = imgPaths{i};
            I = imread(strcat('../data/',path));
            filterResponses = extractFilterResponses(I,filterBank);
            
            points = getRandomPoints(I, alpha);
            [x,y,z] = size(filterResponses);
            for j = 1:z
                img = filterResponses(:,:,j);
                linIdx = sub2ind(size(img),points(:,1),points(:,2));
                pixelResponses((i-1)*alpha + 1:i*alpha,j) = img(linIdx);
            end
        end
    else
        for i = 1:T
            path = imgPaths{i};
            I = imread(strcat('../data/',path));
            filterResponses = extractFilterResponses(I,filterBank);
            
            points = getHarrisPoints(I, alpha, k);
            [x,y,z] = size(filterResponses);
            for j = 1:z
                img = filterResponses(:,:,j);
                linIdx = sub2ind(size(img),points(:,2),points(:,1));
                pixelResponses((i-1)*alpha + 1:i*alpha,j) = img(linIdx);
            end
        end
    end
    
    [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');

    % ------------------------------------------
    
end
