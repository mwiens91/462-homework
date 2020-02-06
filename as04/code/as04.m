clear; close all;

% Setup grid
r_max = 2;
z_max = 2;

rs = linspace(-r_max, r_max, 500);
zs = linspace(-z_max, z_max, 500);

rqs = linspace(-r_max, r_max, 50);
zqs = linspace(-z_max, z_max, 50);

[rr, zz] = meshgrid(rs, zs);
[rrq, zzq] = meshgrid(rqs, zqs);

mags = sqrt(rrq.^2 + zzq.^2);
magsnq = sqrt(rr.^2 + zz.^2);

% Constants
A = 20;
m = 100;

% Get Psi values
psi = A/2 * rr.^2 + m/(4*pi) * (1 - zz./sqrt(rr.^2 + zz.^2));

% Get flow velocity values
uu = m*rrq/(4*pi) * 1./(rrq.^2 + zzq.^2).^(3/2);
ww = A + m*zzq/(4*pi) * 1./(rrq.^2 + zzq.^2).^(3/2);

% Get pressure
uunq = m*rr/(4*pi) * 1./(rr.^2 + zz.^2).^(3/2);
wwnq = A + m*zz/(4*pi) * 1./(rr.^2 + zz.^2).^(3/2);

pp = A^2/2 - 1/2 * (uunq.^2 + wwnq.^2);

% Set up figure
clf;
hold on;

% Plot level curves of Psi
contour(rr, zz, psi, 20);
colorbar;
contour(rr, zz, psi, [0, m/(2*pi)], 'k');

% Plot arrows
quiver(rrq, zzq, uu .* (mags >= 0.25), ww .* (mags >= 0.25), 1);

% Plot points of 0 flow
special_rs = 0;
special_zs = - 1/2 * sign(A) * sqrt(m / (abs(A) * pi));
plot(special_rs, special_zs, "r*");

title("Level curves of \Psi (A = " + A + ", m = " + m + ")")
xlabel("r")
ylabel("z")

print -dpng aso4fig1.png

% Set up next figure
figure;
hold on;

% Plot level curves of Psi

surf(rr, zz, pp .* (magsnq >= abs(special_zs)));
shading interp;
colorbar;


title("Level curves of pressure difference (A = " + A + ", m = " + m + ",\rho = " + 1 + ")")
xlabel("r")
ylabel("z")

print -dpng aso4fig2.png