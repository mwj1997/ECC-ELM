% multi dimension correntropy extreme learning machine
% Input: Samples
% Output:   weight vectors
% Parameter Setting: 
%       numberofhiddennodes         - the number of hidden nodes
%       numda                       - the regularization parameter
%       K                           - the maximum iteration number
%       epsilon                     - the termination tolerance

%*********  parameter setting ****************%
numda=0.00001;
K=2;
epsilon=0.0001;
numberofhiddennodes=100;

%********  input vector construction *********%
[input_vector,dimension_input,dimension_sample]=load_input(X_train);
[actual_output,dimension_output]=load_actual_output(T_train);

%******** hidden layer construction *******%
numberofhiddennodes=90;
[h,w,b]=ELM_build_hidden_layer(input_vector,dimension_input,numberofhiddennodes);

%******** output layer construction *******%
[beta]=MDCCELM_build_output_layer(h,actual_output,numda,K,epsilon);

%******** get the train result *******%
y=beta*h;
mse_train=mse(actual_output-y);

%******** get the test result ******%
[input_vector,dimension_input,dimension_sample]=load_input(X_test);
[actual_output,dimension_output]=load_actual_output(T_test);
lh1=w*input_vector;
lh2=lh1+b(:,ones(1,size(input_vector,2)));
h=1./(1+exp(-1*lh2));
y=beta*h;
mse_test=mse(actual_output-y);

hold on;
plot(y,'b');
plot(actual_output,'r');

%hold on;
%input_vector=-8:0.01:8;
%dimension_input=1;
%dimension_sample=size(input_vector,2);
%lh1=w*input_vector;
%lh2=lh1+b(:,ones(1,size(input_vector,2)));
%h=1./(1+exp(-1*lh2));
%y=beta*h;
%plot(x_actual,y_actual);
%plot(input_vector,y,'b');
%scatter(X_test,actual_output,'r');