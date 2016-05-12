function [ output ] = mixer( varargin  )
% This function will parse and mix data from .csv and .mat files.
% output is an array with following columns:
% time[s] - size[B] - file number (0,1,2,3..) - packet number from given file  
marker = 0;
output = [];

for i = 1:nargin,

    signal_filename = varargin{i};
    [~,~,ext] = fileparts(signal_filename);
    
    if strcmp(ext,'.mat')
        signal = load(signal_filename);
        SNames = fieldnames(signal);
        signal = signal.(SNames{1});
    elseif strcmp(ext,'.csv')
        signal = csvread(signal_filename);
    else
        error(['Wrong filename: ', signal_filename])
    end

    % mark packets
    signal(:,3) = marker;
    marker = marker + 1;

    % numerate packets
    n = size(signal,1);
    n_vec = (1:n)';
    signal = [signal n_vec];
    output = [ output ; signal ];
end

output = sortrows(output);

end

