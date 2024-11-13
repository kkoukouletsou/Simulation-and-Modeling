close all
clear
clc
u1 = @(t)10;
u2 = @(t) 10 * sin(3*t);
a = 3;
b = 0.5;

startTime = 0;
timeStep = 0.1;
timeSpan = 15;

initialValues = [0 0 0 0 0];

g = 100;
am = 3;

[t1, x1] = ode45(@(t1, x1)GradientDescent(t1, x1, a, b, am, g, 1), [startTime timeSpan], initialValues);

x_ = x1(:, 1);
phi1 = x1(:, 2);
phi2 = x1(:, 3);
theta1hat = x1(:, 4);
theta2hat = x1(:, 5);

ahat = am - theta1hat;
bhat = theta2hat;

xhat = theta1hat .* phi1 + theta2hat .* phi2;

subplot(2, 1 ,1);
plot(t1, x1(:, 1), 'LineWidth', 1);
mytitleText = ['$$Plot\ of\ x\, for\ g = $$',num2str(g), '$$, a_m = $$', num2str(am)];
title(mytitleText, 'Interpreter', 'latex');

subplot(2, 1, 2);
plot(t1, xhat(:, 1), 'r', 'LineWidth', 1);
mytitleText = ['$$Plot\ of\ \hat{x}\, for\ g = $$',num2str(g), '$$, a_m = $$', num2str(am)];
title(mytitleText, 'Interpreter', 'latex');

figure
e = x1 - xhat;
plot(t1, e(:, 1), 'LineWidth', 1);
mytitleText = ['$$Error = x - \hat{x}\, for\ g = $$',num2str(g), '$$, a_m = $$', num2str(am)];
title(mytitleText, 'Interpreter', 'latex');


figure
plot(t1, ahat, 'LineWidth', 1);
mytitleText = ['$$Plot\ of\ \hat{a}\ for\ g = $$',num2str(g), '$$, a_m = $$', num2str(am)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t1, bhat, 'LineWidth', 1);
mytitleText = ['$$Plot\ of\ \hat{b}\ for\ g = $$',num2str(g), '$$, a_m = $$', num2str(am)];
title(mytitleText, 'Interpreter', 'latex');



g = 1000;
am = 5;


[t2, x2] = ode45(@(t2, x2)GradientDescent(t2, x2, a, b, am, g, 2), [startTime timeSpan], initialValues);
x_ = x2(:, 1);
phi1 = x2(:, 2);
phi2 = x2(:, 3);
theta1hat = x2(:, 4);
theta2hat = x2(:, 5);

ahat = am - theta1hat;
bhat = theta2hat;

xhat = theta1hat .* phi1 + theta2hat .* phi2;

figure
subplot(2, 1 ,1);
plot(t2, x2(:, 1), 'LineWidth', 1);
title('$$Plot\ of\ x$$', 'interpreter', 'latex');
mytitleText = ['$$Plot\ of\ x\ for\ g = $$', num2str(g), '$$, a_m = $$', num2str(am)];
title(mytitleText, 'Interpreter', 'latex');

subplot(2, 1, 2);
plot(t2, xhat(:, 1), 'r', 'LineWidth', 1);
mytitleText = ['$$Plot\ of\ \hat{x}\,for\ g = $$',num2str(g), '$$, a_m = $$', num2str(am)];
title(mytitleText, 'Interpreter', 'latex');

figure
e = x2 - xhat;
plot(t2, e(:, 1), 'LineWidth', 1);
mytitleText = ['$$Error = x - \hat{x},\ for\ g = $$',num2str(g), '$$, a_m = $$', num2str(am)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t2, ahat, 'LineWidth', 1);
mytitleText = ['$$Plot\ of\ \hat{a}\, for\ g = $$',num2str(g), '$$, a_m = $$', num2str(am)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t2, bhat, 'LineWidth', 1);
mytitleText = ['$$Plot\ of\ \hat{b}\, for\ g = $$',num2str(g), '$$, a_m = $$', num2str(am)];
title(mytitleText, 'Interpreter', 'latex');
