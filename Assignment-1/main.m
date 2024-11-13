clear 
close all
clc

%παράμετροι
mass = 10;
b = 0.5;
k = 2.5;

%πόλοι του συστήματος
p1 = 0.6;
p2 = 0.1;
disp("p1 is " + p1);
disp("p2 is " + p2);

t = 0:0.1:10;
 
[y, u] = odefun(mass, k, b);
 
%πίνακας ζ = [Δ(n-1)(s)/Λ(s) y     Δ(m - 1)(s)/Λ(s) u]
z(:, 1) = lsim(tf([-1 0], [1 (p1+p2) p1*p2]), y, t(:));
z(:, 2) = lsim(tf(-1, [1 (p1+p2) p1*p2]), y, t(:));
z(:, 3) = lsim(tf(1, [1 (p1+p2) p1*p2]), u, t(:));

theta = leastSquaresRegression(z, y);
yHat = theta * z';
yHat = yHat';

massHat = 1/theta(3);
kHat = massHat * (p2 * p1 + theta(2));
bHat = massHat * (p1 + p2 + theta(1));

disp("mass is " + massHat);
disp("k is " + kHat);
disp("b is " + bHat);
disp("real value of mass is " + mass);
disp("real value of k is " + k);
disp("real value of b is " + b);

%plots
subplot(2, 1, 1);
plot(t, y, 'LineWidth', 1);
title('$$Graphic\ plots\ of\ y$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$Output(m)$$', 'interpreter', 'latex');

subplot(2, 1, 2);
plot(t, yHat, 'r', 'LineWidth', 1);
title('$$Graphic\ plots\ of\ \hat{y}$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$Output(m)$$', 'interpreter', 'latex');

figure
error = y - yHat;
plot(t, error, 'LineWidth', 1);   
title('$$Graphic\ plot\ of\ error\ = y - \hat{y}$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$Error(m)$$', 'interpreter', 'latex');
