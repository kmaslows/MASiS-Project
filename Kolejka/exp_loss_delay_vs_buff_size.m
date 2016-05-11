close all; clear all;
addpath(genpath('../Raw-data'));

% Set buffor sizes
B = 5:50;
% Set queue throughput
C = [1*10^7]; % [B/s]

% Load and prepare data
data = load('ispdsl.mat');
A = data.ispdsl;
A = A(A(:,3)==1, :);
%A = A(1:1000,:);

output = queue_batch_wrapper( A, B, C );
x = cell2mat(output(:,1));
y = cell2mat(output(:,3));

n = size(output,1);
avg_delay = zeros(1,n);
for i = 1:n,
   avg_delay(i) = mean(get_delays(output{i,4}));
end

plot(x,y);
figure
plot(x,avg_delay);

