gamrho = 74/1e6;
g = 9.8;
h = 2;
L = 10;

f = 0.8;
omega = 2*pi*f;
k = omega^2/g;
lambda = k/(2*pi);

a = 9e-2;
x0 = linspace(0,L,100);
z0 = linspace(-h, 0, round(h/a)*2);
[x0,z0] = meshgrid(x0,z0);



figure
pause
for jj = 1:100
    t = 0.1 * jj;
    x = x0 - g*k*a./omega^2*(1+gamrho*k^2/g).*cosh(z0+h)./cosh(k*h).*sin(k.*x0-omega*t);
    z = z0 + g*k*a./omega^2*(1+gamrho*k^2/g).*sinh(k*(z0+h))./cosh(k*h).*cos(k.*x0-omega*t);
    
    plot(x,z,'ro')
    axis equal
    xlim([-a max(max(x0))+a])
    ylim([-h-a a])
    pause(0.1)
end