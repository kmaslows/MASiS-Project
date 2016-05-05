function [ Lcounter Lvec Xvec ] = queue( A, B, C )

%% Initialize 
% Set initial data iterator
n = 1; 
% Set initial number of buffered packets
X = 0;
% Pre allocate buffer status variable
Xvec = zeros(length(A),2);
% Buffer counter
Xcounter = 0;
% Set initial time
t = 0;
% Set initial lost values
Lcounter = 0;
% Pre allocate lost buffer
Lvec = zeros(length(A),length(A(1,:)));
% Allocate buffer
Bvec = zeros(B,3);
Bhead = 1;
Btail = 1;

%% Main loop
while 1
    if X == 0 % if buffer empty
        if n == length(A)
            %End simulation. No more data.
            break
        end
        p = A(n,:);
    else % grab packet from the buffer
        p = Bvec(Bhead,:);
        
        % update packet time
        p(1) = t;
        X = X - 1;
        if Bhead == B
            Bhead = 1;
        else
            Bhead = Bhead + 1;
        end
        
        % Output buffer status
        Xcounter = Xcounter + 1;
        Xvec(Xcounter,:) = [t X] ;
    end
    
    % Calculate time at which the packet will be fully sent
    tsent = t + (p(2)/C);
    while n ~= length(A)
        % Get next packet
        n = n + 1;
        pnext = A(n,:);
        % Check if next packet arrived before last one was fully sent
        if pnext(1) < tsent
            % Check if there is space in the buffer
            if X < B 
                % Add packet to the buffer
                Bvec(Btail,:) = pnext;
                X = X + 1;
                if Btail == B
                    Btail = 1;
                else
                    Btail = Btail + 1;
                end
                % Output buffer status
                Xcounter = Xcounter + 1;
                Xvec(Xcounter,:) = [t X] ;
            else
                % Drop the packet
                Lcounter = Lcounter + 1;
                Lvec(Lcounter,:) = pnext;
            end
        else
            break
        end
    end
    % Finish packet sending
    t = tsent;
end

% Trim output variabless
Lvec = Lvec(1:Lcounter,:);
Xvec = Xvec(1:Xcounter,:);

