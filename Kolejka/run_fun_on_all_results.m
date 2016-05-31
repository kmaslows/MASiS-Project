close all; clear all;
addpath(genpath('../Raw-data'));

results_dir = '..\Raw-data\Results2\'
traces_dir = '..\Raw-data\Tracey\'
file_list = dir(results_dir)
 
 for i = 3:numel(file_list),
     load([results_dir file_list(i).name])
     figure('Name',file_list(i).name)
     plot_loss_delay_and_lost_count(output);
     subplot(133)
     bw = mixer(file_list(i).name(12:end-4));
     bw = [ bw(:,1) bw(:,2)];
     agr = agregacja(bw,1);
     plot(agr), grid on;
     title(file_list(i).name);
 end

