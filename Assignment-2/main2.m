close all
clear
clc

a = 3;
b = 0.5;
g1 = 50;
g2 = 10;


u = @(t) 10 * sint(3*t);

startTime = 0;
timeStep = 0.1;
timeSpan = 35;

initialValues = [0 0 0 0];

[t, x] = ode45(@(t, x)LyapunovParallel(t, x, a, b, g1, g2, 1, 0.5, 40), [startTime timeSpan], initialValues);
x1 = x(:, 1);
theta1hat = x(:, 2);
theta2hat = x(:, 3);
xhat = x(:, 4);

ahat = theta1hat;
bhat = theta2hat;

subplot(2, 1, 1);
plot(t, x1, 'LineWidth', 1);
mytitleText = ['$$Lyapunov Parallel - Plot\ of\ x\ for\ g_1 = $$',num2str(g1), '$$, g_2 = $$', num2str(g2)];
title(mytitleText, 'Interpreter', 'latex');

subplot(2, 1, 2);
plot(t, xhat, 'r', 'LineWidth', 1);
e = x1 - xhat;
mytitleText = ['$$Lyapunov Parallel - Plot\ of\ \hat{x}\ for\ g_1 = $$',num2str(g1), '$$, g_2 = $$', num2str(g2)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t, e, 'LineWidth', 1);
mytitleText = ['$$Lyapunov Parallel - Error = x - \hat{x}, \ for\ g_1 = $$',num2str(g1), '$$, g_2 = $$', num2str(g2)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t, ahat, 'LineWidth', 1);
mytitleText = ['$$Lyapunov Parallel - Plot\ of\ \hat{a}\ for\ g_1 = $$',num2str(g1), '$$, g_2 = $$', num2str(g2)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t, bhat, 'LineWidth', 1);
mytitleText = ['$$Lyapunov Parallel - Plot\ of\ \hat{b}\ for\ g_1 = $$',num2str(g1), '$$, g_2 = $$', num2str(g2)];
title(mytitleText, 'Interpreter', 'latex');

g1 = 70;
g2 = 10;
thetam = 10;

[t, x] = ode45(@(t, x)LyapunovMixed(t, x, a, b, g1, g2, thetam, 1, 0.5, 40), [startTime timeSpan], initialValues);
x1 = x(:, 1);
theta1hat = x(:, 2);
theta2hat = x(:, 3);
xhat = x(:, 4);

ahat = theta1hat;
bhat = theta2hat;

figure
subplot(2, 1, 1);
plot(t, x1, 'LineWidth', 1);
mytitleText = ['$$Lyapunov Mixed - Plot\ of\ x\ for\ g_1 = $$',num2str(g1), '$$, g_2 = $$', num2str(g2), '$$, theta_m = $$', num2str(thetam)];
title(mytitleText, 'Interpreter', 'latex');

subplot(2, 1, 2);
plot(t, xhat, 'r', 'LineWidth', 1);
mytitleText = ['$$Lyapunov Mixed - Plot\ of\ \hat{x}\ for\ g1 = $$',num2str(g1), '$$, g_2 = $$', num2str(g2), '$$, theta_m = $$', num2str(thetam)];
title(mytitleText, 'Interpreter', 'latex');

e = x1 - xhat;
figure
plot(t, e, 'LineWidth', 1);
mytitleText = ['$$Lyapunov Mixed - Error= x - \hat{x} for\ g_1 = $$',num2str(g1), '$$, g_2 = $$', num2str(g2), '$$, theta_m = $$', num2str(thetam)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t, ahat, 'LineWidth', 1);
mytitleText = ['$$Lyapunov Mixed - Plot\ of\ \hat{a}\ for\ g_1 = $$',num2str(g1), '$$, g_2 = $$', num2str(g2), '$$, theta_m = $$', num2str(thetam)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t, bhat, 'LineWidth', 1);
mytitleText = ['$$Lyapunov Mixed - Plot\ of\ \hat{b}\ for\ g_1 = $$',num2str(g1), '$$, g_2 = $$', num2str(g2), '$$, theta_m = $$', num2str(thetam)];
title(mytitleText, 'Interpreter', 'latex');

