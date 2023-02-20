%% Create a mixed signal
Fs = 100;       % samples per second
dt = 1/Fs;       % seconds per sample
T = 1;           % seconds
N = Fs * T;      % data points
t = (0:dt:T-dt); % seconds

freq1 = 3; % Hz
freq2 = 8; % Hz

sin1 = sin(2*pi*freq1*t);
sin2 = sin(2*pi*freq2*t);
data = sin1 + sin2;

%% Plot sine waves
subplot(2,3,1)
plot(sin1);
hold on;
plot(sin2);
xlabel("time")
title("3 and 8 Hz oscillations")
legend("3 Hz signal", "8 Hz signal")

subplot(2,3,4)
plot(data)
xlabel("time")
title('Mixed signal')

%% Run manual DTFT
y_dtft = zeros(1, Fs); % initialize Fourier coefficients
for fi=1:Fs
    % create sine wave
    sine_wave = exp(-1i*2*pi*(fi-1).*t); % . creates element-wise operations
    % compute dot product between sine wave and data
    y_dtft(fi) = sum(sine_wave.*data);
end
y_dtfn = y_dtft/N;
%% Run FFT
y_fft = fft(data);
% f = (0:length(y_fft)-1)*Fs/length(y_fft);
%% Plot frequency components
subplot(2,3,2)
plot(abs(y_fft).^2)
title("Power spectrum (FFT)")
xlabel("Frequency [Hz]")
ylabel("Power")

subplot(2,3,5)
plot(abs(y_dtft).^2)
title("Power spectrum (DTFT)")
xlabel('Frequency [Hz]')
ylabel('Power')

%% Keep only positivive frequencies
y_fft_ny = y_fft(1:nyquist);
y_dtft_ny = y_dtft(1:nyquist);
nyquist = N/2+1;

subplot(2,3,3)
plot(abs(y_fft_ny).^2)
title("PSD without negative frequencies (FFT)")
xlabel("Frequency [Hz]")
ylabel("Power")

subplot(2,3,6)
plot(abs(y_dtft_ny).^2)
title("PSD without negative frequencies (DTFT)")
xlabel('Frequency [Hz]')
ylabel('Power')