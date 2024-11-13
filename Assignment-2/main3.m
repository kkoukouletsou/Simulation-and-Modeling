close all
clear
clc
a11 = - 0.25;
a12 = 3;
a21 = - 5;
a22 = 0;
A = [a11 a12; a21 a22];
b1 = 0.5;
b2 = 1.5;
B = [b1; b2];

u =@(t) 3.5 * sin(7.2 * t) + 2 * sin(11.7 * t);

g1 = 100;
g2 = 100;
thetam = 5;

startTime = 0;
timeStep = 0.1;
timeSpan = 15;

initialValues = [0 0 0 0 0 0 0 0 0 0];

[t, x] = ode45(@(t, x)LyapunovEst(t, x, A, B, g1, g2, thetam), [startTime timeSpan], initialValues);

x1 = x(:, 1);
x2 = x(:, 2);
x1hat = x(:, 3);
x2hat = x(:, 4);
a11hat = x(:, 5);
a12hat = x(:, 6);
a21hat = x(:, 7);
a22hat = x(:, 8);
Ahat = [a11hat a12hat; a21hat a22hat];
b1hat = x(:, 9);
b2hat = x(:, 10);
Bhat = [b1hat; b2hat];

subplot(2, 1, 1);
plot(t, x1, 'LineWidth', 1);
title('$$Plot\ of\ x$$', 'interpreter', 'latex');
subplot(2, 1, 2);
plot(t, x1hat, 'r', 'LineWidth', 1);
title('$$Plot\ of\ \hat{x}$$', 'interpreter', 'latex');

e1 = x1 - x1hat;
figure
plot(t, e1, 'LineWidth', 1);
title('$$Error = x - \hat{x}$$', 'interpreter', 'latex');

figure
subplot(4, 1, 1);
plot(t, a11hat, 'LineWidth', 1);
title('$$Plot\ of\ \hat{a_{11}}$$', 'interpreter', 'latex');
subplot(4, 1, 2);
plot(t, a12hat, 'r', 'LineWidth', 1);
title('$$Plot\ of\ \hat{a_{12}}$$', 'interpreter', 'latex');
subplot(4, 1, 3);
plot(t, a21hat, 'g', 'LineWidth', 1);
title('$$Plot\ of\ \hat{a_{21}}$$', 'interpreter', 'latex');
subplot(4, 1, 4);
plot(t, a22hat, 'k', 'LineWidth', 1);
title('$$Plot\ of\ \hat{a_{22}}$$', 'interpreter', 'latex');

figure
subplot(2, 1, 1);
plot(t, b1hat, 'LineWidth', 1);
title('$$Plot\ of\ \hat{b_1}$$', 'interpreter', 'latex');
subplot(2, 1, 2);
plot(t, b2hat, 'r', 'LineWidth', 1);
title('$$Plot\ of\ \hat{b_2}$$', 'interpreter', 'latex');


