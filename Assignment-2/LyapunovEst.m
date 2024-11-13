function [var] = LyapunovEst(t, x, A, B, g1, g2, thetam)
u = 3.5 * sin(7.2 * t) + 2 * sin(11.7 * t);

x1 = x(1);
x2 = x(2);
x1hat = x(3);
x2hat = x(4);
a11hat = x(5);
a12hat = x(6);
a21hat = x(7);
a22hat = x(8);
Ahat = [a11hat a12hat; a21hat a22hat];
b1hat = x(9);
b2hat = x(10);
Bhat = [b1hat; b2hat];

e1 = x1 - x1hat;
e2 = x2 - x2hat;


var(1) = A(1, 1) * x1 + A(1, 2) * x2 + B(1) * u;
var(2) = A(2, 1) * x1 + A(2, 2) * x2 + B(2) * u;
var(3) = Ahat(1, 1) * x1 + Ahat(1, 2) * x2 + Bhat(1) * u + thetam * (x1 - x1hat);
var(4) = Ahat(2, 1) * x1 + Ahat(2, 2) * x2 + Bhat(2) * u + thetam * (x2 - x2hat);
var(5) = g1 * e1 * x1hat;
var(6) = g1 * e1 * x2hat;
var(7) = g1 * e2 * x1hat;
var(8) = g1 * e2 * x2hat;
var(9) = g2 * e1 * u;
var(10) = g2 * e2 * u;

var = var';
end



