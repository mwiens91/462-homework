% constants
g = 9.81;
h0 = 0.25;

c0 = sqrt(g * h0);
alpha = c0 / 3;
u0 = c0 / 4;

% set up figure
figure
hold on

xlabel('x')
ylabel('t')
xlim([-0.5, 5])
ylim([0, 5])

% plot piston
ts = linspace(0, 5, 500);
pxs = -u0 * ts + alpha / 2 * ts.^2;
plot(pxs, ts, 'LineWidth', 2);

% plot separating line
sxs = (c0 - u0) * ts;
plot(sxs, ts, 'LineWidth', 2);

% plot UF characteristics
qts = linspace(0, 5, 20);
for i=1:20
qxs = qts * (-u0 + c0) + i/4;
plot(qxs, qts, 'Color', 'Black')
end

% plot DF characteristics
for i=1:20
tw = i / 4;
xw = -u0 * tw + alpha / 2 * tw.^2;
qts = linspace(tw, 5, 20);
uw = -u0 + alpha * tw;
slope = uw + 1/2 * (8 * c0^3 + 12 * uw * g^2 + 12 * u0 * g^2)^(1/3);
qxs = (qts - tw) * slope + xw;
plot(qxs, qts, 'Color', 'Black');
end

print -dpng as09fig1.png
