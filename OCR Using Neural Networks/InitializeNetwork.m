function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.

W = cell(1,length(layers)-1);
b = cell(1,length(layers)-1);

for i=1:length(layers)-1
    n1 = layers(i);
    n2 = layers(i+1);
    
    W{i} = -1 + 2*rand(n2,n1);
    b{i} = -1 + 2*rand(n2,1);
end

end
