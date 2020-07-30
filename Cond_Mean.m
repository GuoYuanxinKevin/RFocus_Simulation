function [vote,strength] = Cond_Mean(M,hz,h,epsilon)
N = length(h);
meas = zeros(4,N);
states = [exp(complex(0,pi/4)),exp(complex(0,3*pi/4)),exp(complex(0,5*pi/4)),exp(complex(0,7*pi/4))];
cnt = zeros(4,N);
for j=1:M
    b = randsample(states, N, true);
    cnt(1,:) = cnt(1,:)+(b==exp(complex(0,pi/4)));
    cnt(2,:) = cnt(2,:)+(b==exp(complex(0,3*pi/4)));
    cnt(3,:) = cnt(3,:)+(b==exp(complex(0,5*pi/4)));
    cnt(4,:) = cnt(4,:)+(b==exp(complex(0,7*pi/4)));
    %cnt(5,:) = cnt(5,:)+(b==0);
    hn = complex(normrnd(0,sqrt(2)*epsilon/2),normrnd(0,sqrt(2)*epsilon/2));
    mag = abs(hz + dot(b,h) + hn);
    meas(1,:) = meas(1,:)+(b==exp(complex(0,pi/4)))*mag;
    meas(2,:) = meas(2,:)+(b==exp(complex(0,3*pi/4)))*mag;
    meas(3,:) = meas(3,:)+(b==exp(complex(0,5*pi/4)))*mag;
    meas(4,:) = meas(4,:)+(b==exp(complex(0,7*pi/4)))*mag;
    %meas(5,:) = meas(5,:)+(b==0)*mag;
end
meas = meas ./ (cnt + 0.000001);
[~,max_ind] = max(meas(:,:));
vote = states(max_ind);
strength = abs(hz + dot(vote,h));
end