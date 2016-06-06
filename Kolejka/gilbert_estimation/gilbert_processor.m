function [ packets ] = gilbert_processor(p, r, length)
%GILBERT2 Summary of this function goes here
%   Detailed explanation goes here

%todo: check?
%check = 100;

check = 100;
while check >= 10

good = 1;
total_packs = length;
packets = [];

size = 1;

while size <= total_packs
if good == 1
    packets = [packets good];
    good = rand(1) > p;
elseif good == 0
    packets = [packets good];
    good = rand(1) > (1-r);
else
    fprintf('error\n');
    break;
end
size = size + 1;
end

%fid = fopen('Loss_Pattern.txt','w');
%fprintf(fid, '%d ', packets);
%fclose(fid);
received_packs = nnz(packets);
theo_pack_loss_rate = 1 - r / (p+r);
act_pack_loss_rate = 1 - received_packs/total_packs;


check = abs(theo_pack_loss_rate - act_pack_loss_rate) / theo_pack_loss_rate * 100;

end


%theo_pack_loss_rate = p / (p+r)
%act_pack_loss_rate = 1 - received_packs/total_packs

packets = ~packets %reverting 0 and 1 to stick to convention

end

