%offline method
clear all
clc
step = 0.01;
maxTime = 100;
N = maxTime/step + 1;
t = 0: step: maxTime; 
u = @(t) cos(0.25 * t) + 2 * sin(2 * t);
[y, ts] = sys(t, u);
i = 0;
for time = 0: step: maxTime
    i = i + 1;
    u_(i) = u(time);
end

for n = 1: 1: 5
    den = filterPick(n);
    for m = 0: 1: n - 1
        count = 0;
        z = zeros((n + m + 1), N);
        for i = n: -1: 1
            count = count + 1;
            num = zeros(1, i);
            num(1, 1) = -1;
            z = lsim(num, den, y, t(:)); 
            zVector(count, :) = z.';
        end
        for j = m: -1: 0
            count = count + 1;
            num = zeros(1, j + 1);
            num(1, 1) = 1;
            z = lsim(num, den, u_, t(:)); 
            zVector(count, :) = z.';
        end
        theta = leastSquaresRegression(zVector, y); 
        yhat = theta.' * zVector;
        error = y - yhat.';
        plot(t, error, 'LineWidth', 1);
        mytitleText = [' n = ', num2str(n),', m = ', num2str(m)];
        title(mytitleText, 'Interpreter', 'tex');
        if n == 5 && m == 4  
            break
        end
        figure;
    end
end

% After best combo of (n, m) is found to be (3, 2)
nWinner = 3;
mWinner = 2;
den = filterPick(nWinner);
zWinner = zeros((nWinner + mWinner + 1), N);
count = 0;
for i = nWinner: -1: 1
    count = count + 1;
    num = zeros(1, i);
    num(1, 1) = -1;
    zWinner = lsim(num, den, y, t(:)); 
    zVectorW(count, :) = zWinner.';
end
for j = mWinner: -1: 0
    count = count + 1;
    num = zeros(1, j + 1);
    num(1, 1) = 1;
    zWinner = lsim(num, den, u_, t(:)); 
    zVectorW(count, :) = zWinner.';
end

thetaW = leastSquaresRegression(zVectorW, y);

a = zeros(1, nWinner);
for i = 1: 1: nWinner
    a(1, i) = thetaW(i, 1) + den(1, i + 1);
end
b = zeros(1, mWinner + 1);
c = 0;
for j = (nWinner + 1): 1: (nWinner + mWinner + 1) 
    c = c + 1;
    b(1, c) = thetaW(j, 1);
end

yHatNew = lsim(b, [1, a], u_, t);

%Akaike's Information Criterion - AIC 
total = 0;
for j = 1: 1: N
    total = total + (y(j) - yHatNew(j))^2;
end
I = (1/N) * total;
r = 2;
k = 3 + 2 + 1;
AIC = N * log(I) + r * k;
disp("AIC is equal to " + AIC);
disp("a is equal to");
disp(a);
disp("b is equal to");
disp(b);

