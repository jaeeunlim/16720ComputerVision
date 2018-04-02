num_epoch = 5;
classes = 36;
layers = [32*32, 400, classes];
learning_rate = 0.01;

load('../data/nist36_train.mat', 'train_data', 'train_labels')
load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')

[W, b] = InitializeNetwork(layers);

%%%%%%% Weight Visualization
dir = 'before36';
mkdir(dir);
w = W{1};
imgs = {};
for i=1:size(w,1)
    name = sprintf('imagebefore36_%d.jpg',i);
    imwrite(mat2gray(reshape(w(i,:),32,32)),fullfile(dir,name));  
    imgs{end+1} = fullfile(dir,name);
end
N = round(sqrt(size(w,1)));
figure(); 
montage(imgs,'Size',[N, size(w,1)-N*N+N]);
%%%%%%%

train_accs = zeros(1,num_epoch);
valid_accs = zeros(1,num_epoch);
test_accs = zeros(1,num_epoch);
test_losses = zeros(1,num_epoch);
train_losses = zeros(1,num_epoch);
valid_losses = zeros(1,num_epoch);
for j = 1:num_epoch
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);

    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);
    [test_acc, test_loss] = ComputeAccuracyAndLoss(W, b, test_data, test_labels);

    train_accs(j) = train_acc*100;
    valid_accs(j) = valid_acc*100;
    test_accs(j) = test_acc*100;
    test_losses(j) = test_loss;
    train_losses(j) = train_loss;
    valid_losses(j) = valid_loss;
    
    fprintf('Epoch %d - accuracy: %.5f, %.5f, %.5f, \t loss: %.5f, %.5f, %.5f \n', j,...
        train_acc, valid_acc, test_acc, train_loss, valid_loss, test_loss);
end

num_epoch = 1:num_epoch;
figure();
plot(num_epoch, train_accs, num_epoch, valid_accs, num_epoch, test_accs);
xlabel('Epoch');
ylabel('Accuracy (%)');
legend('Training','Validation','Test');
figure();
plot(num_epoch, train_losses, num_epoch, valid_losses, num_epoch, test_losses);
xlabel('Epoch');
ylabel('Loss');
legend('Training','Validation','Test');

save('nist36_model.mat', 'W', 'b')

%%%%%% Weight Visualization
dir = 'after36';
mkdir(dir);
w = W{1};
imgs = {};
for i=1:size(w,1)
    name = sprintf('imageafter36_%d.jpg',i);
    imwrite(mat2gray(reshape(w(i,:),32,32)),fullfile(dir,name));  
    imgs{end+1} = fullfile(dir,name); 
end
N = round(sqrt(size(w,1)));
figure(); 
montage(imgs,'Size',[N, size(w,1)-N*N+N]);
%%%%%%

%%%%%% Confusion Matrix Visualization
[outputs] = Classify(W, b, test_data);
output = zeros(size(test_labels));
for i=1:length(outputs)
    [~,I] = max(outputs{i});
    output(i,I) = 1;
end
figure();
plotconfusion(test_labels', output');
%%%%%%%