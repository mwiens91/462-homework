clear; close all;

% Setup grid
a = 1;
rho = 1;
p_infty = 1;
x_max = 2 * a;
y_max = 2 * a;

xs = linspace(-x_max, x_max, 1000);
ys = linspace(-y_max, y_max, 1000);

xcs = linspace(-x_max, x_max, 20);
ycs = linspace(-y_max, y_max, 20);

[xx, yy] = meshgrid(xs, ys);
[xxc, yyc] = meshgrid(xcs, ycs);

rr = sqrt(xx.^2 + yy.^2);
rrc = sqrt(xxc.^2 + yyc.^2);

% Streamfunction
psi = ...
    - rr / (4 * pi * a^2) - log(a) / (2 * pi) + 1 / (4 * pi) .* (rr < a) ...
    - 1 / (2 * pi) * log(rr) .* (rr >= a);

% Get flow velocity values
uuc = - yyc ./ (2 * pi * a^2) .* (rrc < a) - yyc ./ (2 * pi * rrc.^2) .* (rrc >= a);
vvc =   xxc ./ (2 * pi * a^2) .* (rrc < a) + xxc ./ (2 * pi * rrc.^2) .* (rrc >= a);

% Pressure
pres = ...
    (rho * rr.^2 / (8 * pi^2 * a^4) - rho / (4 * pi^2 * a^2) + p_infty) .* (rr < a) ...
    + (- rho ./ (8 * pi^2 * rr.^2) + p_infty) .* (rr >= a);

% Set up figure
figure;
hold on;

% Plot arrows
quiver(xxc, yyc, uuc, vvc);
xlabel("x");
ylabel("y");
xlim([-x_max, x_max]);
ylim([-y_max, y_max]);

print -dpng as05fig1.png

% Set up figure
figure;
subplot(2, 1, 1)

% Plot level curves of Psi
surf(xx, yy, pres);
shading interp;
view(2);
colorbar('northoutside');

xlabel("x");
ylabel("y");
xlim([-x_max, x_max]);
ylim([-y_max, y_max]);
title("Heat map of pressure (a = \rho_0 = p^\infty = 1)");

subplot(2, 1, 2)

% Plot arrows
quiver(xxc, yyc, uuc, vvc);
xlabel("x");
ylabel("y");
xlim([-x_max, x_max]);
ylim([-y_max, y_max]);
title("Flow vector field (a = \rho_0 = p^\infty = 1)");