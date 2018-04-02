% buildRecognitionSystem.m
% This script loads the visual word dictionary (in dictionaryRandom.mat or dictionaryHarris.mat) and processes
% the training images so as to build the recognition system. The result is
% stored in visionRandom.mat and visionHarris.mat.

load('../data/traintest.mat');
filterBank = createFilterBank();
T = length(train_imagenames);

% Random
dictionary = load('dictionaryRandom.mat');
K = size(dictionary.dictionary1,1);
trainFeatures = zeros(T,K);
for i = 1:T
    wordMapName = strcat('../data/',train_imagenames{i}(1:end-3),'mat');
    wordMap = load(wordMapName);
    trainFeatures(i,:) = getImageFeatures(wordMap.wordMap, K);
end
train_labels = train_labels';
save('visionRandom.mat','dictionary','filterBank','trainFeatures','train_labels');

% Harris
dictionary = load('dictionaryHarris.mat');
K = size(dictionary.dictionary1,1);
trainFeatures = zeros(T,K);
for i = 1:T
    wordMapName = strcat('../data/',train_imagenames{i}(1:end-3),'mat');
    wordMap = load(wordMapName);
    trainFeatures(i,:) = getImageFeatures(wordMap.wordMap, K);
end
train_labels = train_labels';
save('visionHarris.mat','dictionary','filterBank','trainFeatures','train_labels');

