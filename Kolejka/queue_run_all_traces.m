close all; clear all;
addpath(genpath('../Raw-data'));

% Set buffor sizes
B = 1:4:48;
% Set queue throughput
Cmin = 0.75*10^7;
Cmax = 1.25*10^7;
Cn = 12;
C = linspace(Cmin,Cmax,Cn);

results_dir = '..\Raw-data\Results2'
file_name = {
    '4kfiltered_odciete.pcapng.csv',
    'bond_odciete.pcapng.csv',
    'bond2_odciete.pcapng.csv',
    'dlugi_odciete.pcapng.csv',
    'dlugie_odciete.pcapng.csv',
    'foofigters1080p_odciete.pcapng.csv',
    'spotify_spike_odciete.pcapng.csv',
    'teledysk4080p_filtered_odciete.pcapng.csv',
    'topgear1080p_60sec_odciete.pcapng.csv',
    'topgear1080p_filtered_odciete.pcapng.csv',
    'topgear1080p1000buf_filtered_odciete.pcapng.csv',
    'topgearvpc1080p_filtered_odciete.pcapng.csv',
    'vncfiltered_odciete.pcapng.csv' 
    }

% Load and prepare data
for i = 1:numel(file_name),
    disp(['Running filename: ' file_name{i}])
    A = mixer('ispdsl-one-way.mat',file_name{i});
    output = queue_batch_wrapper( A, B, C );
    save([results_dir '\exp-ispdsl-' file_name{i} '.mat'],'output','-v7.3');
end