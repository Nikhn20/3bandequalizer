function [] = failedprojekt()
pwd
[song, Fs] = audioread('mj.wav');

fc = 50;
gain = 6;

song = low_freq_shelving_filter(song, gain, fc, Fs, 0.707);

cfm = 500;
gm = 10;
bm = 100;

song = midEqualizer(song, cfm, bm, gm, Fs);

fc = 5000;
G = 6;
Q = 0.707;

song = high_freq_shelving_filter(song, G, fc, Fs, Q);

audiowrite('mjfiltered.wav', song, Fs);
end

function filtered_signal = high_freq_shelving_filter(input_signal, G, fc, fs, Q)
    omega_c = 2 * pi * fc / fs;
    A = 10^(G/40);
    beta = sqrt(A + A^2 * (1 / Q^2 - 1));

    b0 = A * ((A + 1) + (A - 1) * cos(omega_c) + beta * sin(omega_c));
    b1 = -2 * A * ((A - 1) + (A + 1) * cos(omega_c));
    b2 = A * ((A + 1) + (A - 1) * cos(omega_c) - beta * sin(omega_c));
    a0 = (A + 1) - (A - 1) * cos(omega_c) + beta * sin(omega_c);
    a1 = 2 * ((A - 1) - (A + 1) * cos(omega_c));
    a2 = (A + 1) - (A - 1) * cos(omega_c) - beta * sin(omega_c);

    b = [b0, b1, b2] / a0;
    a = [a0, a1, a2] / a0;

    filtered_signal = filter(b, a, input_signal);

    figure;
    freqz(b, a, 2048, fs);
    title('Frequency Response of the High-Frequency Shelving Filter');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
end

function filtered_signal = low_freq_shelving_filter(input_signal, G, fc, fs, Q)
    omega_c = 2 * pi * fc / fs;
    A = 10^(G/40);
    beta = sqrt(A + A^2 * (1 / Q^2 - 1));

    b0 = A * ((A + 1) - (A - 1) * cos(omega_c) + beta * sin(omega_c));
    b1 = 2 * A * ((A - 1) - (A + 1) * cos(omega_c));
    b2 = A * ((A + 1) - (A - 1) * cos(omega_c) - beta * sin(omega_c));
    a0 = (A + 1) + (A - 1) * cos(omega_c) + beta * sin(omega_c);
    a1 = -2 * ((A - 1) + (A + 1) * cos(omega_c));
    a2 = (A + 1) + (A - 1) * cos(omega_c) - beta * sin(omega_c);

    b = [b0, b1, b2] / a0;
    a = [a0, a1, a2] / a0;

    filtered_signal = filter(b, a, input_signal);

    figure;
    freqz(b, a, 2048, fs);
    title('Frequency Response of the Low-Frequency Shelving Filter');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
end

function output_signal_mid = midEqualizer(input_signal, center_frequency_mid, bandwidth_mid, gain_mid, Fs)
    w0 = 2 * pi * center_frequency_mid / Fs;
    BW = 2 * pi * bandwidth_mid / Fs;

    Q = w0 / BW;

    A = 10^(gain_mid / 40);
    alpha = sin(w0) / (2 * Q);
    a0 = 1 + alpha / A;
    a1 = -2 * cos(w0);
    a2 = 1 - alpha / A;
    b0 = 1 + alpha * A;
    b1 = -2 * cos(w0);
    b2 = 1 - alpha * A;

    a = [a0, a1, a2] / a0;
    b = [b0, b1, b2] / a0;

    figure;
    freqz(b, a, 1024, Fs);
    title('Frequency Response of Mid-Range Equalizer');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    ylim([-18, 18]);

    output_signal_mid = filter(b, a, input_signal);
end

