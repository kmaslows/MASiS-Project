close all; clear all;
addpath(genpath('../Raw-data'));

% Set buffor sizes
B = 1:4:40;
% Set queue throughput
Cmin = 1*10^7;
Cmax = 1.5*10^7;
Cn = 10;
C = linspace(Cmin,Cmax,Cn);

% Load and prepare data
A = mixer('ispdsl.mat','teledysk4080p_filtered_odciete.pcapng.csv');

output = queue_batch_wrapper( A, B, C );
save('exp-ispdsl-teledysk4080p_filtered_odciete.mat','output','-v7.3');
x = cell2mat(output(:,1));
y = cell2mat(output(:,3));

n = size(output,1);
avg_delay = zeros(1,n);
avg_delay_signal = zeros(1,n);
yy = [];
for i = 1:n,
   lost_packets_vec = output{i,4};
   lost_signal_indexes = lost_packets_vec(:,3) == 1;
   gilbert_signal_estimate(lost_packets_vec(find(lost_packets_vec(:,3) == 1),:));
   yy(i) = sum(lost_signal_indexes);
   avg_delay(i) = mean(get_delays(lost_packets_vec));
   avg_delay_signal(i) = mean(get_delays(lost_packets_vec(lost_signal_indexes,:)));
end

subplot(121)
plot(x,y,'b',x,yy,'r'); grid on;
title('Number of lost packets vs buffer size')
legend('Entire traffic','Signal')
subplot(122)
plot(x,avg_delay,'b',x,avg_delay_signal,'r'); grid on;
title('Avg delay between packet loss vs buffer size')
legend('Entire traffic','Signal')

