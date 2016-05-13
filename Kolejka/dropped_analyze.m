function [ packed, unpacked ] = dropped_analyze( A )

% analyze lognest pack
packed = 0;
unpacked = 0;
for i = 2:length(A)
  if(A(i)-A(i-1)==1)
  packed++;
  end
  unpacked++;
  end
  