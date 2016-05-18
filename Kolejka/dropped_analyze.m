function [ packed, unpacked, mean_delay, min_delay, max_delay ] = dropped_analyze( lvec )
    shiftedlvec=circshift(lvec(:,1),[1,0]);
    shiftedlvec(1,1)=0;
    packed = 0;
    unpacked = 0;
    
    %calculate mean, min and max delays
    mean_delay=mean(lvec(:,1)-shiftedlvec)
    min_delay=min(lvec(:,1)-shiftedlvec)
    max_delay=max(lvec(:,1)-shiftedlvec)
    
    lost_packets_vec = lvec(:,3:4);
    lost_signal=lost_packets_vec((lost_packets_vec(:,1)==1),:);
    n = length(lost_signal);
    for i = 2:n,
       if(lost_signal(i)-lost_signal(i-1)==1)
           packed=packed+1;
       else
           unpacked=unpacked+1;
       end
    end
end
