% close all; clear all;
% addpath(genpath('../Raw-data'));
% 
% % Set buffor sizes
% %B = 1:4:40;
% B = [10,20,40];
% %B = 10;
% % Set queue throughput
% Cmin = 1*10^7;
% Cmax = 1.5*10^7;
% Cn = 10;%real_packets
% C = linspace(Cmin,Cmax,Cn);
% %C = 1.2*10^7;
% 
% 
% % Load and prepare data
% A = mixer('ispdsl.mat','4kfiltered_odciete.pcapng.csv');
% 
% output = queue_batch_wrapper( A, B, C );
% save('exp-ispdsl-4kfiltered_odciete.pcapng.mat','output','-v7.3');
% x = cell2mat(output(:,1));
% y = cell2mat(output(:,3));

n = size(output,1);
% avg_delay = zeros(1,n);
% avg_delay_signal = zeros(1,n);
% yy = [];
% r = zeros(size(C));
% p = zeros(size(C));
% gilbert_packets=zeros(size(p));
avg=zeros(size(p));
signal_size = length(find(A(:,3)==1));
for i = 1:n
   lost_packets_vec = output{i,4};
   lost_signal_column = lost_packets_vec(:,3) == 1;
   lost_signal_indexes = find(lost_packets_vec(:,3) == 1);
   [r(i), p(i)] = gilbert_signal_estimate(lost_packets_vec(find(lost_packets_vec(:,3) == 1),:), signal_size); %(find(lost_packets_vec(:,3) == 1),:)
%    processor_output = gilbert_processor(p(i),r(i),length(A));
%    all_packets_gilbert = A;
%    all_packets_gilbert(:,4) = all_packets_gilbert(:,4).*processor_output';
%    lost_packets_vec_gilbert = all_packets_gilbert(all_packets_gilbert(:,4)~=0,:);
%    lost_signal_indexes_gilbert = lost_packets_vec_gilbert(:,3) == 1;
    processor_output = gilbert_processor(p(i),r(i),signal_size);
    all_packets_gilbert = [1:signal_size]';
    all_packets_gilbert = all_packets_gilbert.*processor_output';
    lost_signal_indexes_gilbert = all_packets_gilbert(all_packets_gilbert(:,1)~=0,:);
   sprintf('%d / %d',i,n)
   [avg(i) dev seq_vec] = burst_loss_calc(lost_signal_indexes_gilbert');
   [avg2(i) dev seq_vec] = burst_loss_calc(lost_signal_indexes');
   yy(i) = sum(lost_signal_column);
   avg_delay(i) = mean(get_delays(lost_packets_vec));
   avg_delay_signal(i) = mean(get_delays(lost_packets_vec(lost_signal_column,:)));
end
figure(1); 
plot(C,avg(1:Cn),'r',C,avg(Cn+1:2*Cn),'g',C,avg(2*Cn+1:end),'b'); grid on;
title('Average loss')
legend('B=10','B=20','B=40')
figure(2); 
plot(C,avg2(1:Cn),'r',C,avg2(Cn+1:2*Cn),'g',C,avg2(2*Cn+1:end),'b'); grid on;
title('Average loss normal')
legend('B=10','B=20','B=40')

% subplot(121)
% plot(x,y,'b',x,yy,'r'); grid on;
% title('Number of lost packets vs buffer size')
% legend('Entire traffic','Signal')
% subplot(122)
% plot(x,avg_delay,'b',x,avg_delay_signal,'r'); grid on;
% title('Avg delay between packet loss vs buffer size')
% legend('Entire traffic','Signal')

