function [mode,c1,c2,delay1,delay2]=select_strategy(Ef,iteration)

% Usage: assign the parameters for SDPSO
% input:
%       Ef          - the estimation function
%       iteration   - the update interation
% output:
%       mode        - the strategy state
%       c1          - the acceleration coefficient 1
%       c2          - the acceleration coefficient 2
%       delay1      - the delay time 1
%       delay2      - the delay time 2

fprintf("the %d iteration:",iteration);

if Ef>=0 && Ef<0.25
    fprintf("convergence\n");
    mode=1;
    c1=2;
    c2=2;
    delay1=0;
    delay2=0;
end

if Ef>=0.25 && Ef<0.5
    fprintf("exploitation\n");
    mode=2;
    c1=2.1;
    c2=1.9;
    delay1=floor(rand(1,1)*iteration);
    delay2=0;
end

if Ef>=0.5 && Ef<0.75
    fprintf("exploration\n");
    mode=3;
    c1=2.2;
    c2=1.8;
    delay1=0;
    delay2=floor(rand(1,1)*iteration);
end

if Ef>=0.75
    fprintf("jumping out\n");
    mode=4;
    c1=1.8;
    c2=2.2;
    delay1=floor(rand(1,1)*iteration);
    delay2=floor(rand(1,1)*iteration);
end