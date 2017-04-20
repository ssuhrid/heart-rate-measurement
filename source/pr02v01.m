close all
fps=30;

y=br;

% BPM_L = 40;    % Heart rate lower limit [bpm]
% BPM_H = 230;   % Heart rate higher limit [bpm]
% FILTER_STABILIZATION_TIME = 1;    % [seconds]
% % Butterworth frequencies must be in [0, 1], where 1 corresponds to half the sampling rate
% [b, a] = butter(2, [((BPM_L / 60) / v.FrameRate * 2), ((BPM_H / 60) / v.FrameRate * 2)]);
% filtBrightness = filter(b, a, brightness);
% subplot(2,1,1)
% plot(1:length(x),y)
% subplot(2,1,2)
% % Cut the initial stabilization time
% filtBrightness = filtBrightness((v.FrameRate * FILTER_STABILIZATION_TIME + 1):size(filtBrightness, 2));
% plot(1:length(filtBrightness),filtBrightness)

% Parameters to play with
WINDOW_SECONDS = 6;             % Sliding window length
BPM_SAMPLING_PERIOD = 0.5;      % Time between heart rate estimations
BPM_L = 40; BPM_H = 230;        % Valid heart rate range
FILTER_STABILIZATION_TIME = 1;  % Filter startup transient
CUT_START_SECONDS = 0;          % Initial signal period to cut off
FINE_TUNING_FREQ_INCREMENT = 1; % Separation between test tones for smoothing
ANIMATION_SPEED_FACTOR = 2;     % This makes the animation run faster or slower than real time

subplot(4,1,1)
plot(1:length(br),br)
title('br=samples')

subplot(4,1,2)
plot(1:length(fft(br)),fft(br))
title('fft(br)')

[b, a] = butter(2, [(((BPM_L)/60)/fps*2) (((BPM_H)/60)/fps*2)]);
% this is band stop buttersworth filter

% freqz(b,a)

yf = filter(b, a, y);

% y = yf((fps * max(FILTER_STABILIZATION_TIME, CUT_START_SECONDS))+1:size(yf, 2));
y = yf(((fps * max(FILTER_STABILIZATION_TIME, CUT_START_SECONDS))+1):size(yf, 2));

subplot(4,1,3)
plot(1:length(yf),yf)
title('after butters filter= yf')

subplot(4,1,4)
plot(1:length(y),y)
title('remove start filter stabilization seconds')

figure()
subplot(5,1,1)
plot(1:length(br),br)
title('brightness')

subplot(5,1,2)
plot(1:length(y),(y))
title('after band pass filtering')

num_window_samples = round(WINDOW_SECONDS * fps);
bpm_sampling_period_samples = round(BPM_SAMPLING_PERIOD * fps);
num_bpm_samples = floor((size(y, 2) - num_window_samples) / bpm_sampling_period_samples);
fcl = BPM_L / 60; fch = BPM_H / 60;
orig_y = y;
bpm = [];
bpm_smooth = [];

max_freq_plot_amplitude = 0;
max_time_plot_bpm = 100;
min_time_plot_bpm = 50;

window_start = (1)*bpm_sampling_period_samples+1;
ynw = orig_y(window_start:window_start+num_window_samples);
% Use Hanning window to bring edges to zero. In this way, no artificial
% high frequencies appear when the signal is treated as periodic by the
% FFT
y = ynw .* hann(size(ynw, 2))';
gain = abs(fft(y));

subplot(5,1,3)
plot(1:length(y),(y))
title('after hanning window')

subplot(5,1,4)
plot(1:length(gain),(gain))
title('gain=abs fft of windowed output')


% FFT indices of frequencies where the human heartbeat is
il = floor(fcl * (size(y, 2) / fps))+1; ih = ceil(fch * (size(y, 2) / fps))+1;
index_range = il:ih;

subplot(5,1,5)
plot((index_range-1) * (fps / size(y, 2)) , gain(index_range), 'b', 'LineWidth', 2)
title('expanded roi of freq is picked from gain')




