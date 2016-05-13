close all; clear all;
addpath(genpath('../Raw-data'));
data = load('ispdsl_small.mat');
A = data.ispdsl_small;
%A = A(A(:,3)==1, :);

B = 10;
C = 1*10^7; % [B/s]

tic
[ lost lostvec Xvec Dropped] = queue( A, B, C );
toc
stairs(Xvec(:,1),Xvec(:,2));
[packed unpacked]  = dropped_analyze(Dropped)