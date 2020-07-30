function [vote,strength] = Phase_Comp(M,hz,h,epsilon)
N = length(h);
total = zeros(4,N);
states = [exp(complex(0,pi/4)),exp(complex(0,3*pi/4)),exp(complex(0,5*pi/4)),exp(complex(0,7*pi/4))];
cnt = zeros(4,N);
vote = zeros(1,N);
L = 1:N;
for t=1:M
    b = randsample(states, length(L), true);
    cnt(1,L) = cnt(1,L)+(b==exp(complex(0,pi/4)));
    cnt(2,L) = cnt(2,L)+(b==exp(complex(0,3*pi/4)));
    cnt(3,L) = cnt(3,L)+(b==exp(complex(0,5*pi/4)));
    cnt(4,L) = cnt(4,L)+(b==exp(complex(0,7*pi/4)));
    hn = complex(normrnd(0,sqrt(2)*epsilon/2),normrnd(0,sqrt(2)*epsilon/2));
    mag = abs(hz + dot(b,h(L)) + dot(vote,h) + hn);
    total(1,L) = total(1,L)+(b==exp(complex(0,pi/4)))*mag;
    total(2,L) = total(2,L)+(b==exp(complex(0,3*pi/4)))*mag;
    total(3,L) = total(3,L)+(b==exp(complex(0,5*pi/4)))*mag;
    total(4,L) = total(4,L)+(b==exp(complex(0,7*pi/4)))*mag;
end
meas = total ./ (cnt + 0.000001);
vote(L) = vote(L) + ((meas(1,L)- meas(4,L) > 0) & (meas(4,L)- meas(3,L) > 0)) * exp(complex(0,pi/4));
vote(L) = vote(L) + ((meas(1,L)- meas(4,L) > 0) & (meas(4,L)- meas(3,L) < 0)) * exp(complex(0,3*pi/4));
vote(L) = vote(L) + ((meas(1,L)- meas(4,L) < 0) & (meas(4,L)- meas(3,L) < 0)) * exp(complex(0,5*pi/4));
vote(L) = vote(L) + ((meas(1,L)- meas(4,L) < 0) & (meas(4,L)- meas(3,L) > 0)) * exp(complex(0,7*pi/4));
strength = abs(hz + dot(vote,h));
%disp(vote)
end