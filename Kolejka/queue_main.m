close all; clear all;
data = load('ispdsl.mat');
A = data.ispdsl;
%A = A(A(:,3)==1, :);

B = 10;
C = 1*10^7; % [B/s]

tic
[ lost lostvec Xvec ] = queue( A, B, C );
toc
stairs(Xvec(:,1),Xvec(:,2));