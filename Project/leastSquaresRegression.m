function [calculation] = leastSquaresRegression(z, y)
format LongG
phi = z;
calc1 = phi * y;
calc2 = phi * phi.';
calculation = (calc2)^(-1)*calc1;
end
       