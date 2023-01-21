
import Functions/.*;
addpath 'Functions';

file_sign1 = "../Run16/C2.mat";
file_sign2 = "../Run16/C3.mat";

th1 = 0.6;
th2 = 0.4;

i = 1;

c2 = open(file_sign1);
c2_x = c2.x2(:, i);
delta1 = c2_x(2) - c2_x(1);
c2_y = c2.y2(:, i);

% figure
% plot(c2_x, c2_y)

% [c2_y_ft, f] = fourier_transform(c2_x, c2_y);
% figure
% plot(f, c2_y_ft)

figure
c2_y_filt = signal_filter(c2_x, c2_y, 499975);
plot(c2_x, c2_y_filt)


c3 = open(file_sign2);
c3_x = c3.x3(:, i);
delta2 = c3_x(2) - c3_x(1);
c3_y = c3.y3(:, i);

delta_run = c2_x(1) - c3_x(1);

% figure
% plot(c3_x, c3_y)

% [c3_y_ft, f] = fourier_transform(c3_x, c3_y);
% figure
% plot(f, c3_y_ft)

figure
c3_y_filt = signal_filter(c3_x, c3_y, 499975);
plot(c3_x, c3_y_filt)

figure
[c,lags] = xcorr(c2_y_filt, c3_y_filt, 'normalized');
stem(lags,c)

[r, i] = max(c);
delay = abs(delta1 * lags(i));

v = 0.022/delay;
c = 3*10^8;

En = 938.28 * (1 / sqrt(1 - (v/c)^2) - 1);

fd = finddelay(c2_y_filt, c3_y_filt);
