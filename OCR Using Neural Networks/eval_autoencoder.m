%% Train
% TODO: load training dataset
model = load('../data/nist26_train.mat');

% TODO: reshape and adjust the dimensions to be in the order of [height,width,1,sample_index]
layers = [
    imageInputLayer([32,32,1])
    % intermediate layers go between here ...
    conv2D(4,1,8,1,2)
    conv2D(4,8,16,1,2)
    conv2D(8,16,64,0,1)
    transpConv2D(8,64,16,0,1)
    transpConv2D(4,16,8,1,2)
    transpConv2D(4,8,1,1,2)
    % ... and here
    regressionLayer
];

options = trainingOptions('sgdm',...
                          'InitialLearnRate',0.00001,...
                          'MaxEpochs',3,...
                          'MiniBatchSize',3,...
                          'Shuffle','every-epoch',...
                          'Plot','training-progress',...
                          'VerboseFrequency',10);
data = model.train_data;
X = reshape(data,[32,32,1,size(data,1)]);

% TODO: run trainNetwork()
net = trainNetwork(X, X, layers, options);

%% Predict
% TODO: load test dataset
model = load('../data/nist26_test.mat');

% TODO: reshape and adjust the dimensions to be in the order of [height,width,1,sample_index]
data = model.test_data;
X = reshape(data,[32,32,1,size(data,1)]);

% TODO: run predict()
test_recon = predict(net,X);

% Plot
currentLabel = 0;
count = 0;
Y = model.test_labels;
for i=1:length(data) 
    [~,I] = max(Y(i,:));
    if I > currentLabel && currentLabel < 5
        count = count + 1;
        fig = figure();
        subplot(2,1,1);
        imshow(double(reshape(data(i,:),32,32)));
        subplot(2,1,2);
        imshow(double(test_recon(:,:,:,i)));
        name = sprintf('img_%d.jpg',i);
        saveas(fig, name);
        if count == 2
            currentLabel = currentLabel + 1;
            count = 0;
        end
    end
    if currentLabel == 5
        break
    end
end

psnr_total = 0;
for i=1:length(data)
    img1 = double(test_recon(:,:,:,i));
    img2 = double(reshape(data(i,:),32,32));
    [peaksnr, snr] = psnr(img1,img2);
    psnr_total = psnr_total + peaksnr;
end
avg_psnr = psnr_total/length(data);