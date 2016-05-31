function [ ] = plot_loss_delay_and_lost_count( queue_output )

x = cell2mat(queue_output(:,1));
y = cell2mat(queue_output(:,2));

n = size(queue_output,1);
avg_delay = zeros(1,n);
avg_delay_signal = zeros(1,n);
z = zeros(n,1);

for i = 1:n,
   lost_packets_vec = queue_output{i,4};
   lost_signal_indexes = lost_packets_vec(:,3) == 1;
   z(i) = sum(lost_signal_indexes);
   avg_delay(i) = mean(get_delays(lost_packets_vec));
   avg_delay_signal(i) = mean(get_delays(lost_packets_vec(lost_signal_indexes,:)));
end


subplot(131)
plot_data = [x y z];
draw_heatmap(plot_data);
xlabel('Buffer size')
ylabel('Throughput')
zlabel('# signal packet lost')
set(gca, 'ZScale', 'log')

subplot(132)
plot_data = [x y avg_delay_signal'];
draw_heatmap(plot_data);
xlabel('Buffer size')
ylabel('Throughput')
zlabel('Average Delay between lost packets[s]')


