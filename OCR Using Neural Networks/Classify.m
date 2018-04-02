function [outputs] = Classify(W, b, data)
% [predictions] = Classify(W, b, data) should accept the network parameters 'W'
% and 'b' as well as an DxN matrix of data sample, where D is the number of
% data samples, and N is the dimensionality of the input data. This function
% should return a vector of size DxC of network softmax output probabilities.

D = size(data,1);
outputs = cell(1,D);
for i=1:D
    X = data(i,:);
    [out, ~, ~] = Forward(W, b, X);
    outputs{i} = out;
end

end
