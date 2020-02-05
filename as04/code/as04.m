clear; close all;

% Setup grid
r_max = 3;
z_max = 3;

rs = linspace(-r_max, r_max, 500);
zs = linspace(-z_max, z_max, 500);

rqs = linspace(-r_max, r_max, 50);
zqs = linspace(-z_max, z_max, 50);

[rr, zz] = meshgrid(rs, zs);
[rrq, zzq] = meshgrid(rqs, zqs);

% Constants
A = 200;
m = 500;

% Get Psi values
psi = A/2 * rr.^2 + m/(4*pi) * (1 - zz./sqrt(rr.^2 + zz.^2));

% Get flow velocity values
uu = m*rrq/(4*pi) * 1./(rrq.^2 + zzq.^2).^(3/2);
ww = A + m*zzq/(4*pi) * 1./(rrq.^2 + zzq.^2).^(3/2);

% Set up figure
clf;
hold on;

% Plot level curves of Psi
contour(rr, zz, psi, 5);
colorbar;

% Plot arrows
quiver(rrq, zzq, uu, ww, 5);

%print -dpng aso4fig.png