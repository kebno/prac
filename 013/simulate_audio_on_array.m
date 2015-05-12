% Simulate sound on an array
%
% kd\sin(\theta)
% omega d\sin(\theta)/c
clear all

% ULA
c = 343;  % sound speed (m/s)
N = 8;    % Number of Elements
for f0 = [100 200 400 800 1600 3200 ];  % array design frequency - telephony 300-3400 Hz
d = c/(2*f0);
L = (N-1)*d;

% Audio data
fs = 44.1e3;
dt = 1/fs;

max_delay = (N-1)*d/c;
max_delay_samples = ceil(max_delay/dt);

% Range of time between fore and aft endfire delays
frame_len = 4096;
buffer_length_samples = (2*max_delay_samples) - 1 + frame_len;

theta = linspace(-pi/2,pi/2,max_delay_samples);
dtheta = mean(diff(theta));
ddeg = dtheta * 180/pi;

% Given an angle, these are the delay times
delays_sec = d/c * (0:(N-1)).' * sin(theta);
delays_samp = ceil(delays_sec / dt);

src.theta = max(theta);
src.theta_ind = find(abs(src.theta - theta) <= dtheta, 1);

%% Apply data on array
samples = [1,fs*6];
[y,Fs] = audioread('paragraph_acoustics.wav',samples);
y = mean(y,2);

assert(Fs==fs,'Design Fs doesnt match audio file fs.')

zero_delay_start_samp = 1 + max_delay_samples;
Nsample = length(y) - 2*max_delay_samples;
end_samp = length(y) - max_delay_samples;

ula.data = [];
for jj = 1:N
    data_inds = delays_samp(jj,src.theta_ind)...
        + [zero_delay_start_samp : end_samp];
   ula.data(jj,:) = y(data_inds);
end

% figure
% hold on
% for jj = 1:N
%     plot(1:Nsample,ula.data(jj,:) + jj*0.1)
% end
% hold off
% title('Wave Data')
figure(1)
% Create textbox
clf
annotation(figure(1),'textbox',...
    [0.1385 0.471428571428571 0.752571428571429 0.383333333333341],...
    'String',{[num2str(N) ' Element Array'];...
    ['Source in endfire direction'];...
    ['Beamformer steered to broadside'];...
    [' '];...
    [num2str(f0) ' Hz Design Frequency'];},...
    'FontSize',20,'FitBoxToText','On');

%% Play beamformer output steered to broadside
sound(mean(ula.data,1),Fs)
pause(Nsample*dt)
end
%% Play original sound
clf
annotation(figure(1),'textbox',...
    [0.1385 0.471428571428571 0.752571428571429 0.383333333333341],...
    'String',{'Original Audio'},...
    'FontSize',20,'FitBoxToText','On');
sound(y(data_inds),Fs)
