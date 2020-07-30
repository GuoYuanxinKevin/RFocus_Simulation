function [vote,strength] = Ada_Cond_Mean(iter,M,hz,h,epsilon)
N = length(h);
total = zeros(4,N);
states = [exp(complex(0,pi/4)),exp(complex(0,3*pi/4)),exp(complex(0,5*pi/4)),exp(complex(0,7*pi/4))];
cnt = zeros(4,N);
vote = zeros(1,N);
h0 = hz;
L = 1:N;
for t = 1:iter
    for j=1:(M/iter)
        b = randsample(states, N, true);
        cnt(1,:) = cnt(1,:)+(b==exp(complex(0,pi/4)));
        cnt(2,:) = cnt(2,:)+(b==exp(complex(0,3*pi/4)));
        cnt(3,:) = cnt(3,:)+(b==exp(complex(0,5*pi/4)));
        cnt(4,:) = cnt(4,:)+(b==exp(complex(0,7*pi/4)));
        %cnt(5,:) = cnt(5,:)+(b==0);
        %hn = complex(normrnd(0,sqrt(2)*epsilon/2),normrnd(0,sqrt(2)*epsilon/2));
        hn = exp(complex(log(epsilon),unifrnd(-pi,pi,1,1)));
        mag = abs(hz + dot(b,h) + hn);
        total(1,:) = total(1,:)+(b==exp(complex(0,pi/4)))*mag;
        total(2,:) = total(2,:)+(b==exp(complex(0,3*pi/4)))*mag;
        total(3,:) = total(3,:)+(b==exp(complex(0,5*pi/4)))*mag;
        total(4,:) = total(4,:)+(b==exp(complex(0,7*pi/4)))*mag;
        %meas(5,:) = meas(5,:)+(b==0)*mag;
    end
    meas = total ./ (cnt + 0.000001);
    %disp(size(L));
    temp = meas(meas(:,L)<max(meas(:,L)));
    %disp(temp);
    disp(size(temp));
    temp = reshape(temp,3,[]);
    %disp(meas);
    delta = max(meas(:,L))-max(temp(:,:));
    subset = L(delta > 13*log(M)/(sqrt(t*M/iter)) );
    [~,max_ind] = max(meas(:,subset));
    vote(subset) = states(max_ind);
    L = setdiff(L,subset);
    hz = hz + dot(vote(subset),h(subset));
end

[~,max_ind] = max(meas(:,L));
vote(L) = states(max_ind);
%disp(abs(vote));
strength = abs(h0 + dot(vote,h));
end