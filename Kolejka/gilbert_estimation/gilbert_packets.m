function [ r,h,p ] = gilbert_packets( lost_indexes, total )
%GILBERT_PACKETS Summary of this function goes here
%   Detailed explanation goes here
    A = zeros(1,total);
    for i = 1:length(lost_indexes)
        A(lost_indexes(i)) = 1;
    end
    [r,h,p] = estimate_gilbert(A);
end

