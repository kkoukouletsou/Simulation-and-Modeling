function [calculation] = leastSquaresRegression(z, y)
phi = z;
calc1 = y.' * phi;
calc2 = phi.'* phi;
calculation = calc1/calc2;
end