% Seeing (at least in text) Beamformers in Complex Numbers

lambda = 2;
k = 2*pi/lambda;
d = lambda/2;
c = 1;
omega = pi;
theta = pi/4;

N = 5;

%% Data and Replica (Phase Relative to Element 0, the Reference Element)
x = exp(1i*(k*(0:(N-1)).'*d*sin(theta) + pi/2));
w = exp(1i*k*(0:(N-1)).'*d*sin(theta));

%% Phase Across Array
unwrap(angle(x))
%% Phase Across Replica Vector (weights)
unwrap(angle(w))
%% Relative Phase Between Elements of Data and Replica is the Same
assert(all(...
    abs(diff( diff(unwrap(angle(w)))-diff(unwrap(angle(x))) )) < 1e-5 ))
%% Phase Across Adjusted Array Data
unwrap(angle(conj(w).*x))
%% Adjusted Phase Across Array is Equal to Phase on Reference Element
assert(all(...
    abs( unwrap(angle(x(1)))-unwrap(angle(conj(w).*x)) ) < 1e-5 ))

%% Data Covariance Matrix
K = x*x';