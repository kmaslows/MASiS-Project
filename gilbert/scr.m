addpath(genpath('../Kolejka'));

A = mixer('ispdsl.mat','teledysk4080p_filtered_odciete.pcapng.csv');
number_of_packets = length(A);
number_of_packets = 10000;
for r = 0.8:0.02:0.99
    [~, packets] = gilbert2(0.0001,r,number_of_packets); %todo: replace with number of packets
%packets - 0 lost , 1 - forwarded

    indexes_of_lost_packets = find(packets==0);

    A_lost = A(indexes_of_lost_packets,:);
    delays = get_delays(A_lost);
    disp(r)
    disp(mean(delays))
    disp('---')
end