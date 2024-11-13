close all
clear
clc

a = 3;
b = 0.5;
f = 40;
n = 0.5;
g1 = 50;
g2 = 10;


u = @(t) 10 * sint(3*t);

startTime = 0;
timeStep = 0.1;
timeSpan = 35;

initialValues = [0 0 0 0];


[t, x] = ode45(@(t, x)LyapunovParallel(t, x, a, b, g1, g2, 2, n, f), [startTime timeSpan], initialValues);
x1 = x(:, 1);
theta1hat = x(:, 2);
theta2hat = x(:, 3);
xhat = x(:, 4);

ahat = theta1hat;
bhat = theta2hat;

figure
subplot(2, 1, 1);
plot(t, x1, 'LineWidth', 1);
mytitleText = ['$$Lyapunov\ Parallel\ with\ noise - Plot\ of\ x\ for\ f = $$',num2str(f), '$$, n = $$', num2str(n)];
title(mytitleText, 'Interpreter', 'latex');

subplot(2, 1, 2);
plot(t, xhat, 'r', 'LineWidth', 1);
mytitleText = ['$$Lyapunov\ Parallel\ with\ noise - Plot\ of\ \hat{x}\ for\ f = $$',num2str(f), '$$, n = $$', num2str(n)];
title(mytitleText, 'Interpreter', 'latex');

figure
e = x1 - xhat;
plot(t, e, 'LineWidth', 1);
mytitleText = ['$$Lyapunov\ Parallel\ with\ noise - Error = x - \hat{x}\ for\ f = $$',num2str(f), '$$, n = $$', num2str(n)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t, ahat, 'LineWidth', 1);
mytitleText = ['$$Lyapunov\ Parallel\ with\ noise - Plot\ of\ \hat{a}\ for\ f = $$',num2str(f), '$$, n = $$', num2str(n)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t, bhat, 'LineWidth', 1);
mytitleText = ['$$Lyapunov\ Parallel\ with\ noise - Plot\ of\ \hat{b}\ for\ f = $$',num2str(f), '$$, n = $$', num2str(n)];
title(mytitleText, 'Interpreter', 'latex');


thetam = 10;

[t, x] = ode45(@(t, x)LyapunovMixed(t, x, a, b, g1, g2, thetam, 2, n, f), [startTime timeSpan], initialValues);
x1 = x(:, 1);
theta1hat = x(:, 2);
theta2hat = x(:, 3);
xhat = x(:, 4);

ahat = theta1hat;
bhat = theta2hat;

figure
subplot(2, 1, 1);
plot(t, x1, 'LineWidth', 1);
mytitleText = ['$$Lyapunov\ Mixed\ with\ noise - Plot\ of\ x\ for\ f = $$',num2str(f), '$$, n = $$', num2str(n)];
title(mytitleText, 'Interpreter', 'latex');

subplot(2, 1, 2);
plot(t, xhat, 'r', 'LineWidth', 1);
mytitleText = ['$$Lyapunov\ Mixed\ with\ noise - Plot\ of\ \hat{x}\ for\ f = $$',num2str(f), '$$, n = $$', num2str(n)];
title(mytitleText, 'Interpreter', 'latex');

e = x1 - xhat;
figure
plot(t, e, 'LineWidth', 1);
mytitleText = ['$$Lyapunov\ Mixed\ with\ noise - Error = x - x\hat{x}\ for\ f = $$',num2str(f), '$$, n = $$', num2str(n)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t, ahat, 'LineWidth', 1);
mytitleText = ['$$Lyapunov\ Mixed\ with\ noise - Plot\ of\ \hat{a}\ for\ f = $$',num2str(f), '$$, n = $$', num2str(n)];
title(mytitleText, 'Interpreter', 'latex');

figure
plot(t, bhat, 'LineWidth', 1);
mytitleText = ['$$Lyapunov\ Mixed\ with\ noise - Plot\ of\ \hat{b}\ for\ f = $$',num2str(f), '$$, n = $$', num2str(n)];
title(mytitleText, 'Interpreter', 'latex');


%Lyapunov Parallel, different values for f
figure
for i = 1:1:4
    n = 0.5;
    f = [0.5 10 25 50];
    [t, x] = ode45(@(t, x)LyapunovParallel(t, x, a, b, g1, g2, 2, n, f(i)), [startTime timeSpan], initialValues);
    x1 = x(:, 1);
    theta1hat = x(:, 2);
    theta2hat = x(:, 3);
    xhat = x(:, 4);

    ahat = theta1hat;
    bhat = theta2hat;
    error = x1 - xhat;
    
    
    subplot(2, 2, i);
    plot(t, error, 'LineWidth', 1);
    mytitleText = ['Lyapunov Parallel, error for f = ',num2str(f(i)), ', n = ', num2str(n)];
    title(mytitleText, 'Interpreter', 'latex');
    
end

g1 = 70;
g2 = 10;
thetam = 10;

%Lyapunov Mixed different values for f
figure
for i = 1:1:4
    n = 0.5;
    f = [0.5 10 25 50];
    [t, x] = ode45(@(t, x)LyapunovMixed(t, x, a, b, g1, g2, thetam, 2, n, f(i)), [startTime timeSpan], initialValues);
    x1 = x(:, 1);
    theta1hat = x(:, 2);
    theta2hat = x(:, 3);
    xhat = x(:, 4);

    ahat = theta1hat;
    bhat = theta2hat;

    error = x1 - xhat;
    
    subplot(2, 2, i);
    plot(t, error, 'LineWidth', 1);
    mytitleText = ['Lyapunov Mixed, error for f = ',num2str(f(i)), ', n = ', num2str(n)];
    title(mytitleText, 'Interpreter', 'latex');
end


%Lyapunov Parallel, different values for n
figure
for i = 1:1:4
    f = 40;
    n = [0.5 1 10 50];
    [t, x] = ode45(@(t, x)LyapunovParallel(t, x, a, b, g1, g2, 2, n(i), f), [startTime timeSpan], initialValues);
    x1 = x(:, 1);
    theta1hat = x(:, 2);
    theta2hat = x(:, 3);
    xhat = x(:, 4);

    ahat = theta1hat;
    bhat = theta2hat;
    error = x1 - xhat;
    
    
    subplot(2, 2, i);
    plot(t, error, 'LineWidth', 1);
    mytitleText = ['Lyapunov Parallel, error for f = ',num2str(f), ', n = ', num2str(n(i))];
    title(mytitleText, 'Interpreter', 'latex');
end

%Lyapunov Mixed different values for f
figure
for i = 1:1:4
    f = 40;
    n = [0.5 1 10 50];
    [t, x] = ode45(@(t, x)LyapunovMixed(t, x, a, b, g1, g2, thetam, 2, n(i), f), [startTime timeSpan], initialValues);
    x1 = x(:, 1);
    theta1hat = x(:, 2);
    theta2hat = x(:, 3);
    xhat = x(:, 4);

    ahat = theta1hat;
    bhat = theta2hat;

    error = x1 - xhat;
    
    subplot(2, 2, i);
    plot(t, error, 'LineWidth', 1);
    mytitleText = ['Lyapunov Mixed, error for f = ',num2str(f), ', n = ', num2str(n(i))];
    title(mytitleText, 'Interpreter', 'latex');
end