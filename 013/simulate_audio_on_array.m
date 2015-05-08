# Simulate sound on an array

kd\sin(\theta)
omega d\sin(\theta)/c

% ULA
c = 343;  % sound speed (m/s)
N = 8;    % Number of Elements
f0 = 3000;  % array design frequency - telephony 300-3400 Hz

% Audio data
fs = 44.1e3;
dt = 1/fs;

max_delay = (N-1)*d/c;
max_delay_samples = ceil(max_delay/dt);

% Range of time between fore and aft endfire delays
buffer_length_samples = (max_delay_samples * 2)-1

theta = linspace(-pi,pi,max_delay_samples);

% Given an angle, these are the delay times
delays = d/c * (0:(N-1)).' * sin(theta);
