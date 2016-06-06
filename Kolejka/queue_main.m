close all; clear all;
addpath(genpath('../Raw-data'));
%Zastąpiłem ispdsl.mat na zmixowany sygnał ispdsl z teledyskiem
%data = load('ispdsl.mat');
%A = data.ispdsl;
A = mixer('ispdsl.mat','teledysk4080p_filtered_odciete.pcapng.csv');

%A = A(A(:,3)==1, :);

B = 10;
C = 1*10^7; % [B/s]

tic
[ lost lostvec Xvec] = queue( A, B, C );
toc
stairs(Xvec(:,1),Xvec(:,2));
[packed unpacked mean_delay min_delay max_delay]  = dropped_analyze(lostvec)