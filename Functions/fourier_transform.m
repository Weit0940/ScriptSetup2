function [ft_y, f] = fourier_transform(x, y)

L = length(x);
M = L/2 + 1;

Ts = x(2) - x(1);
Fs = 1 / Ts;
f = Fs * (1:M) ./ L;

ft_y = fft(y);
ft_y = abs(ft_y(1:M));

end