function [ r p ] = gilbert_signal_estimate( lost_signal, lost_signal_length )
%GILBERT_TMP Summary of this function goes here
    lost_signal_indexes = lost_signal(:,4);
    [r,h,p] = gilbert_packets(lost_signal_indexes, lost_signal_length);
    disp(['Number of lost packets: ', num2str(length(lost_signal_indexes))]);
    disp(['Signal Gilbert: ', 'r=' , num2str(r), ' h=', num2str(h), ' p=', num2str(p)]);
end