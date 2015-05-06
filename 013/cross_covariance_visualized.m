function cross_covariance_visualized()
% Seeing (at least in text) Beamformers in Complex Numbers
% John Boyle, 2015
% MATLAB 2014a 
%% Data and Replica (Phase Relative to Element 0, the Reference Element)
theta = pi/3;
[x,w] = data_and_replica(theta);

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

figure
hplot = imagesc(angle(K));
caxis([-pi pi])
colorbar

uicontrol('Style', 'slider',...
    'Min',-pi,'Max',pi,'Value',pi/3,...
    'Position', [400 10 120 20],...
    'Callback', {@compute_K,hplot});
uicontrol('Style','text',...
        'Position',[400 35 120 20],...
        'String','Vertical Exaggeration')
end

function compute_K(hObj,event,hplot)

val = get(hObj,'Value');
[x,~] = data_and_replica(val);
K = x*x';
set(hplot,'CData',angle(K))
title(sprintf('Signal Angle Relative to Broadside: %1.2',val))
end

function val = jrand()
val = -1 + 2*rand;
end

function [x,w] = data_and_replica(theta)
c = 1;
omega = pi;
k = omega/c;
lambda = 2*pi/k;

d = lambda/2;

N = 5;
x = exp(1i*(k*(0:(N-1)).'*d*sin(theta) + pi*jrand()));
w = exp(1i*k*(0:(N-1)).'*d*sin(theta));
end
