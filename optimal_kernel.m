function [alpha,sigma,dimension]=optimal_kernel(x,N_dimension)

% Usage: [alpha,sigma,dimension]=optimal_kernel(x,N_dimension)
% Function: access to the optimal kernel

global_cost=1000;

for i=1:N_dimension
    [a,sigma,cost]=exp_multi_kernel(x,i);
    if cost<global_cost
        global_cost=cost;
        alpha(1,1:i)=a;
        sigma(1,1:i)=sigma;
        dimension=i;
    end
end