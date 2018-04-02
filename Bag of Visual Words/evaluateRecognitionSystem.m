% evaluateRecognitionSystem.m
% This script evaluates nearest neighbour recognition system on test images
% load traintest.mat and classify each of the test_imagenames files.
% Report both accuracy and confusion matrix

method = 'euclidean';
% method = 'chi2';

load('visionHarris.mat');
% load('visionRandom.mat');

load('../data/traintest.mat');
total = length(test_imagenames);
correct = 0;
C = zeros(8);
filterBank = createFilterBank();

for i = 1:total
    I = imread(strcat('../data/',test_imagenames{i}));
    label = test_labels(i);
    wordMap = getVisualWords(I,dictionary.dictionary1,filterBank);
    
    h = getImageFeatures(wordMap,size(dictionary.dictionary1,1));
    dist = getImageDistance(h, trainFeatures, method);
    [~,idx] = min(dist); 
    predict = train_labels(idx);
    
    if label == predict
        correct = correct + 1;
    end
    C(label,predict) = C(label,predict) + 1;
end

accuracy = correct/total;

disp(C);
disp(accuracy);
