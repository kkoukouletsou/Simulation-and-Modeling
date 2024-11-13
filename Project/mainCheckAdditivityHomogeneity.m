%check system's additivity
step = 0.001;
maxTime = 20;
t = 0: step: maxTime; 
u = @(t) cos(t) + 2 * sin(2 * t);
[y, ts] = sys(t, u);
plot(ts, y, 'LineWidth', 1);
title('Check Additivity', 'interpreter', 'latex');
u1 = @(t) cos(t);
u2 = @(t) 2 * sin(2 * t);
[y1, t] = sys(t, u1);
[y2, t] = sys(t, u2);
figure
plot(t, y1 + y2,'LineWidth', 1);
title('Check Additivity', 'interpreter', 'latex');
figure
error = y - (y1 + y2);
plot(t, error, 'color', 'r', 'LineWidth', 1);
title('Error', 'interpreter', 'latex');
figure

%check system's homogeneity
u3 = @(t) 5 * cos(0.5 * t);
u4 = @(t) cos(0.5 * t);
[y3, t3] = sys(t, u3);
[y4, t4] = sys(t, u4);
plot(t, y3, 'LineWidth', 1);
title('Check Homogeneity', 'interpreter', 'latex');
figure;
plot(t, 5 * y4, 'LineWidth', 1);
title('Check Homogeneity', 'interpreter', 'latex');
figure
error2 = y3 - 5 * y4;
plot(t, error2, 'color', 'r', 'LineWidth', 1);
title('Error', 'interpreter', 'latex');
