function [vote,strength] = Mod_RFocus(M,hz,h,epsilon)
N = length(h);
vote = zeros(4,N);
states = [exp(complex(0,pi/4)),exp(complex(0,3*pi/4)),exp(complex(0,5*pi/4)),exp(complex(0,7*pi/4))];
config = zeros(M,N);
mag = zeros(1,N);
for j=1:M
    config(j,:) = randsample(states, N, true);
    hn = complex(normrnd(0,sqrt(2)*epsilon/2),normrnd(0,sqrt(2)*epsilon/2));
    mag(j) = abs(hz + dot(config(j,:),h) + hn);
end
avg_mag = mean(mag);
L = 1:M;
ind = L(mag > avg_mag);
for i = 1:length(ind)
    temp = config(ind(i),:);
    vote(1,:) = vote(1,:) + (temp == exp(complex(0,pi/4)));
    vote(2,:) = vote(2,:) + (temp == exp(complex(0,3*pi/4)));
    vote(3,:) = vote(3,:) + (temp == exp(complex(0,5*pi/4)));
    vote(4,:) = vote(4,:) + (temp == exp(complex(0,7*pi/4)));
end
[~,max_ind] = max(vote(:,:));
vote = states(max_ind);
strength = abs(hz + dot(vote,h));
end