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
VcNoise = Vc;
VrNoise = Vr;

for var = 1: 1: 3
    k = randi(length(VcNoise));
    l = randi(length(VrNoise));
    VcNoise(k) = VcNoise(k) + randi([100, 1000]);
    VrNoise(l) = VrNoise(l) + randi([100, 1000]);
end



z3(:, 1) = lsim(tf([-1 0],[1 (p1+p2) p1*p2]), VcNoise, t);
z3(:, 2) = lsim(tf(-1,[1 (p1+p2) p1*p2]), VcNoise, t);         
z3(:, 3) = lsim(tf([1 0],[1 (p1+p2) p1*p2]),u1_,t);     
z3(:, 4) = lsim(tf(1,[1 (p1+p2) p1*p2]),u1_,t);
z3(:, 5) = lsim(tf([1 0],[1 (p1+p2) p1*p2]),u2_,t);
z3(:, 6) = lsim(tf(1,[1 (p1+p2) p1*p2]),u2_,t);
    
theta3 = leastSquaresRegression(z3, VcNoise);
RCHat3 = (theta3(1) + p1 + p2)^(-1);
LCHat3 = (theta3(2) + p1*p2)^(-1);
disp(z3);
VcHatNoise = theta3 * z3';
VcHatNoise = VcHatNoise';
    
    
figure
subplot(2, 1, 1);
plot(t, VcNoise, 'LineWidth', 1);
title("$$V_C\ with\ noise$$", 'interpreter', 'latex');
ylabel("$$V_C(V)$$", 'interpreter', 'latex');
xlabel("$$Time(s)$$", 'interpreter', 'latex');
    
subplot(2, 1, 2)
plot(t, VcHatNoise, 'r', 'LineWidth', 1);
title("$$\hat{V_C}\ with\ noise$$",'interpreter', 'latex');
ylabel("$$\hat{V_C}(V)$$",'interpreter', 'latex');
xlabel("$$Time(s)$$", 'interpreter', 'latex');
    
figure
plot(t, VcNoise - VcHatNoise, 'LineWidth', 1);
title("$$Error$$",'interpreter', 'latex');
ylabel("$$e = V_C - \hat{V_C}(V)$$",'interpreter', 'latex');
xlabel("$$Time(s)$$", 'interpreter', 'latex');
    
    
    
z4(:, 1) = lsim(tf([-1 0], [1 p1+p2 p1*p2]), VrNoise, t(:));
z4(:, 2) = lsim(tf(-1, [1 p1+p2 p1*p2]), VrNoise, t(:));
z4(:, 3) = lsim(tf([1 0 0], [1 p1+p2 p1*p2]), u1_, t(:));
z4(:, 4) = lsim(tf([1 0], [1 p1+p2 p1*p2]), u1_, t(:));
z4(:, 5) = lsim(tf(1, [1 p1+p2 p1*p2]), u1_, t(:));
z4(:, 6) = lsim(tf([1 0 0], [1 p1+p2 p1*p2]), u2_, t(:));
z4(:, 7) = lsim(tf([1 0], [1 p1+p2 p1*p2]), u2_, t(:));
z4(:, 8) = lsim(tf(1, [1 p1+p2 p1*p2]), u2_, t(:));
    
theta4 = leastSquaresRegression(z4, VrNoise);
RCHat4 = (theta4(1) + p1 + p2)^(-1);
LCHat4 = (theta4(2) + p1*p2)^(-1);
disp(z4);
    
VrHatNoise = theta4 * z4';
VrHatNoise = VrHatNoise';
    
    
figure
subplot(2, 1, 1);
plot(t, VrNoise, 'LineWidth', 1);
title('$$V_R\ with\ noise$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$V_R(Volt)$$', 'interpreter', 'latex');
    
subplot(2, 1, 2);
plot(t, VrHatNoise, 'r', 'LineWidth', 1);
title('$$\hat{V_R}\ with\ noise$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$\hat{V_R}(Volt)$$', 'interpreter', 'latex');
    
figure
plot(t, VrNoise - VrHatNoise, 'LineWidth', 1);
title('$$Error = \hat{V_R}-V_R$$', 'interpreter', 'latex');
xlabel('$$Time(s)$$', 'interpreter', 'latex');
ylabel('$$error$$', 'interpreter', 'latex');
