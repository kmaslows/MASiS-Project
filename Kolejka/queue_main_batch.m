close all; clear all;
addpath(genpath('../Raw-data'));

% Set buffor sizes
B = 10:200;
% Set queue throughput
C = [1*10^7 1.5*10^7 2*10^7]; % [B/s]

% Load and prepare data
data = load('ispdsl.mat');
A = data.ispdsl;
A = A(A(:,3)==1, :);
%A = A(1:1000,:);

output = queue_batch_wrapper( A, B, C );
save('test.mat','output');
