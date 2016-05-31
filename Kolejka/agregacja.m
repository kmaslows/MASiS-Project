function [out ] = agregacja( data,delta )
%http://www.mathworks.com/matlabcentral/answers/116416-cumulative-sum-for-every-15min-from-1-min-timeseries-data

ix = 1+floor((data(:,1)-data(1,1))/delta);
out=accumarray(ix,data(:,2),[],@sum);
end

