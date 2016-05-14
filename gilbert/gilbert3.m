function [ packet_loss ] = gilbert3( p, r )
%GILBERT3 Summary of this function goes here
%   Detailed explanation goes here
    packet_loss = p / (p+r);

end

