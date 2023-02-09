% stima dell'energia del fascio su tutte le Run13-14-15

import Functions/.*;
addpath 'Functions';

energy = zeros(4, 1);

for j = 1:1:4

    file_sign1 = "../Run1" + (j + 2) + "/C2.mat";
    file_sign2 = "../Run1" + (j + 2) + "/C3.mat";

    c2 = open(file_sign1);
    c3 = open(file_sign2);

    [row, col] = size(c2.y2);
    delay = zeros(col - 1, 1);
    en = zeros(col - 1, 1);
    cross = zeros(col -1, 1);

    for i = 1:1:(col - 1)

        c2_x = c2.x2(:, i);
        c2_y = c2.y2(:, i);
        c2_y_filt = signal_filter(c2_x, c2_y, 499975);
        delta = c2_x(2) - c2_x(1);

        c3_x = c3.x3(:, i);
        c3_y = c3.y3(:, i);
        c3_y_filt = signal_filter(c3_x, c3_y, 499975);

        [c,lags] = xcorr(c2_y_filt, c3_y_filt, 'normalized');
        [r, k] = max(c);
        
        cross(i) = r;
        d = abs( delta * lags(k));
        delay(i) = d;

        e = 938.28 * ( 1 / sqrt( 1 - (0.022 / d)^2 / (3*10^8)^2 ) - 1 );
        if (imag(e) == 0 && real(e) > 0 && e > 50 && e < 150)
            en(i) = e;
        end

        i
    end

    energy(j) = mean(en(en > 0));

    j
end


