function [y_filt] = signal_filter(x, y, fcoff)

Ts = x(2) -x(1);
Fs = 1 / Ts;
d = designfilt('lowpassfir', 'FilterOrder', 250, 'CutoffFrequency', fcoff, 'SampleRate', Fs);
y_filt = filter(d, y);

end