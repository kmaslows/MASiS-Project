function [ output ] = draw_heatmap( data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

X = cell2mat(data(:,1));
Y = cell2mat(data(:,2));
Z = cell2mat(data(:,3));
Xn = numel(unique(X));
Yn = numel(unique(Y));

XX = reshape(X,Xn,Yn);
YY = reshape(Y,Xn,Yn);
ZZ = reshape(Z,Xn,Yn);

surf(XX,YY,ZZ)
xlabel('Buffer size')
ylabel('Throughput')
zlabel('# packet lost')

end

