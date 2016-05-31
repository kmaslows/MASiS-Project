function [ output ] = draw_heatmap( data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if iscell(data)
    X = cell2mat(data(:,1));
    Y = cell2mat(data(:,2));
    Z = cell2mat(data(:,3));
else
    X = data(:,1);
    Y = data(:,2);
    Z = data(:,3);
end
Xn = numel(unique(X));
Yn = numel(unique(Y));

XX = reshape(X,Xn,Yn);
YY = reshape(Y,Xn,Yn);
ZZ = reshape(Z,Xn,Yn);

surf(XX,YY,ZZ)
az = 0;
el = 90;
view(az, el);
end

