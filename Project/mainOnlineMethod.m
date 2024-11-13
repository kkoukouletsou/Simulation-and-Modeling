clear all
clc
format long
step = 0.01;
maxTime = 100;
t = 0: step: maxTime;
u = @(t) cos(6 * t) + sin(13 * t) + sin(0.3 * t);
[y, ts] = sys(t, u);
N = maxTime/step + 1;
i = 0;
for time = 0: step: maxTime
    i = i + 1;
    u_(i) = u(time);
end

for n = 1: 1: 4
    den = filterPick2(n);
    for m = 0: 1: n - 1
        phi = zeros(n * (n + m + 1), 1);
        theta = zeros(n + m + 1, 1);
        Qo = reshape((eye(n + m + 1))^(-1), [], 1);
        xV = [phi; Qo; theta]; 
        options1 = odeset('RelTol', 1e-3, 'AbsTol', 1e-5);
        [~, var] = ode45(@(t, var) odefun(t, var, y, n, m, den, maxTime, step), t, xV, options1);
        aHat = den - var(end, end - n - m: end - m - 1); 
        bHat = var(end,end-m:end);
        
        t = 0: step: maxTime;     
        uTest = @(t)sin(0.1 * t) + sin(25 * t);
        [yTest, tTest] = sys(t, uTest);
        i = 0;
        for time = 0: step: maxTime
            i = i + 1;
            uTest_(i) = uTest(time);
        end
        yHatTest = lsim(bHat, [1, aHat], u_, t(:));
        error = yTest - yHatTest;
        figure;
        plot(t, error);
        title(['error for n = ', num2str(n), ' and m = ', num2str(m)]);
        if n == 3 && m == 2
            aHatHold = den - var(end, end - n - m: end - m - 1); 
            bHatHold = var(end,end-m:end);
        end
    end
end

% Akaike's Information Criterion - AIC 
total = 0;
for j = 1: 1: N
    total = total + (y(j) - yHatTest(j))^2; 
end
I = (1/N) * total;
r = 2;
k = 3 + 2 + 1;
AIC = N * log(I) + r * k;
disp("AIC is equal to " + AIC);
disp("a is equal to");
disp(aHatHold);
disp("b is equal to");
disp(bHatHold);