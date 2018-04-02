function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_h' and 'act_a' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'

n = length(W);
grad_W = cell(1,n);
grad_b = cell(1,n);

% Output layer
out = act_h{end};
gh = -Y./out;
ga = gh'*(diag(out) - out*out');
grad_W{end} = ga'*act_h{end-1}';
grad_b{end} = ga';

gh = W{end}'*ga';

% Hidden layers
for i=1:n-2
    ga = gh.*act_h{end-i}.*(1-act_h{end-i});
    grad_W{end-i} = ga*act_h{end-1-i}';
    grad_b{end-i} = ga;
    gh = W{end-i}'*ga;
end

% First hidden layer
ga = gh.*act_h{1}.*(1-act_h{1});
grad_W{1} = ga*X;
grad_b{1} = ga;

end
