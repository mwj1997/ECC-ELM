function [beta]=MDCCELM_build_output_layer(h,actual_output,numda,K,epsilon)

% build the MDCC-ELM based on mixture correntropy
% Input:
%       h                       - the hidden layer outputs
%       actual_output           - the expected outputs
%       numda                       - the regularization parameter
%       K                           - the maximum iteration number
%       epsilon                     - the termination tolerance
%  Output:
%       beta                        - the hidden layer output weights

%********* initialize the beta vector ******%
n_neurons=size(h,1);
n_output=size(actual_output,1);
beta=zeros(n_output,n_neurons);

%*** calculate the output layer with correntropy **%
flag=0;
iteration=1;
Jmmcc=zeros(1,iteration);
beta=actual_output*inv(h'*h+numda*eye(size(h,2)))*h';

while(iteration<K && flag==0)
    %%% compute the error
    e=actual_output-beta*h;
    %%% compute the diagonal matrix
    [alpha,sigma,dimension]=optimal_kernel(e,1);
    alpha=1;
    G_matrix=zeros(1,size(h,2));
    for j=1:dimension
        G_matrix=G_matrix+alpha(1,j)*(exp(-1*(e.*e)/(sigma(1,j)*sigma(1,j))))/(sigma(1,j)*sigma(1,j));
    end
    D_matrix=diag(G_matrix);
    %%% update the weight vector
    beta=(inv(h*D_matrix*h'+eye(n_neurons)*(2*size(actual_output,2)*numda))*h*D_matrix*actual_output')';
    Jmmcc(1,iteration)=1-sum(G_matrix)/size(G_matrix,1);%%%+numda*beta*beta';
    if iteration>1 &&Jmmcc(1,iteration-1)-Jmmcc(1,iteration)<epsilon
        flag=1;
    end
    iteration=iteration+1;
end

