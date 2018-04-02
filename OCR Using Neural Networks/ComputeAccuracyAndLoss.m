function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.

% accuracy
outputs = Classify(W, b, data);
D = size(data,1);
correct = 0;
loss = 0;
for i=1:D
    y_hat = outputs{i};
    y = labels(i,:);
    [~,y_hat_i] = max(y_hat);
    [~,y_i] = max(y);
    correct = correct + (y_hat_i==y_i);
    loss = loss - y*log(y_hat);
end
accuracy = correct/D;
loss = loss/D; % average cross-entropy

end
