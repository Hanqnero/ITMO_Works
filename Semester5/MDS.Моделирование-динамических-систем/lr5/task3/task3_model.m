%% Task 3: DDE model simulation (variant 7)
% x'(t) = A x(t) + A1 x(t-h)

clear; clc; close all;

A  = [-2  1;
       0 -3];
A1 = [ 1  2;
       1 -2];

h = 3; % delay

% History function x(t) for t in [-h, 0]
phi = @(t) [1; -0.5];

ddefun = @(t, x, Z) A * x + A1 * Z(:,1);

delays = h;
tspan  = [0 20];

sol = dde23(ddefun, delays, phi, tspan);

% Dense output for smooth plot
T = linspace(tspan(1), tspan(2), 2000);
X = deval(sol, T);

figure('Color','w');
plot(T, X(1,:), 'LineWidth', 1.5);
hold on;
plot(T, X(2,:), '--', 'LineWidth', 1.5);
grid on;
xlabel('t');
ylabel('x(t)');
legend('x_1', 'x_2', 'Location', 'northeast');
title(sprintf('DDE simulation with delay h = %g', h));

% Save for Typst report
outDir = fullfile(fileparts(mfilename('fullpath')), '..', 'img');
if ~exist(outDir), mkdir(outDir); end
outPath = fullfile(outDir, 'task3_sim.png');
exportgraphics(gcf, outPath, 'Resolution', 200);

fprintf('Saved plot to: %s\n', outPath);

