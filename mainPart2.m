clear 
close all
clc
timestep = 1e-4;
maxtime = 50;

format longG

t = 0:timestep:maxtime;
u1 = @(t)2 * sin(4*t);
u2 = @(t)4;


[Vr, Vc] = v(t);
Vc = Vc.';
Vr = Vr.';

p1 = 40;
p2 = 100;

i = 0;
for time = 0:timestep:maxtime
    i = i + 1;
    u1_(i) = u1(time);
    u2_(i) = u2(time);
end

N = maxtime/timestep + 1;


z(:, 1) = lsim(tf([-1 0], [1 (p1+p2) p1*p2]), Vc, t(:));
z(:, 2) = lsim(tf(-1, [1 (p1+p2) p1*p2]), Vc, t(:));
z(:, 3) = lsim(tf([1 0], [1 (p1+p2) p1*p2]), u1_, t(:));
z(:, 4) = lsim(tf(1, [1 (p1+p2) p1*p2]), u1_, t(:));
z(:, 5) = lsim(tf([1 0], [1 (p1+p2) p1*p2]), u2_, t(:));
z(:, 6) = lsim(tf(1, [1 (p1+p2) p1*p2]), u2_, t(:));

theta = leastSquaresRegression(z, Vc);
RCHat = (theta(1) + p1 + p2)^(-1);
LCHat = (theta(2) + p1*p2)^(-1);

%Vc and Vc-hat plot
subplot(2, 1, 1);
plot(t, Vc);
title('$$Graphic\ plot\ of\ V_C$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$V_C(Volt)$$', 'interpreter', 'latex');

VcHat = theta * z';
VcHat = VcHat';

subplot(2, 1, 2);
plot(t, VcHat, 'r');
title('$$Graphic\ plot\ of\ \hat{V_C}$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$\hat{V_C}(Volt)$$', 'interpreter', 'latex');
 
figure
plot(t, Vc - VcHat);
title('$$Error = V_C-\hat{V_C}$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$error$$', 'interpreter', 'latex');

z2(:, 1) = lsim(tf([-1 0], [1 p1+p2 p1*p2]), Vr, t(:));
z2(:, 2) = lsim(tf(-1, [1 p1+p2 p1*p2]), Vr, t(:));
z2(:, 3) = lsim(tf([1 0 0], [1 p1+p2 p1*p2]), u1_, t(:));
z2(:, 4) = lsim(tf([1 0], [1 p1+p2 p1*p2]), u1_, t(:));
z2(:, 5) = lsim(tf(1, [1 p1+p2 p1*p2]), u1_, t(:));
z2(:, 6) = lsim(tf([1 0 0], [1 p1+p2 p1*p2]), u2_, t(:));
z2(:, 7) = lsim(tf([1 0], [1 p1+p2 p1*p2]), u2_, t(:));
z2(:, 8) = lsim(tf(1, [1 p1+p2 p1*p2]), u2_, t(:));

theta2 = leastSquaresRegression(z2, Vr);
RCHat2 = (theta2(1) + p1 + p2)^(-1);
LCHat2 = (theta2(2) + p1*p2)^(-1);
disp(z2);
VrHat = theta2 * z2';
VrHat = VrHat';

figure
subplot(2, 1, 1);
plot(t, Vr);
title('$$V_R$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$V_R(Volt)$$', 'interpreter', 'latex');

subplot(2, 1, 2);
plot(t, VrHat, 'r');
title('$$\hat{V_R}$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$\hat{V_R}(Volt)$$', 'interpreter', 'latex');

figure
plot(t, Vr - VrHat);
title('$$Error = V_R-\hat{V_R}$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$error$$', 'interpreter', 'latex');

 

