close all

y=br;
fps=30;



% Parameters
WINDOW_SECONDS = 6;             % [s] Sliding window length
BPM_SAMPLING_PERIOD = 0.5;      % [s] Time between heart rate estimations
BPM_L = 40; BPM_H = 230;        % [bpm] Valid heart rate range
FILTER_STABILIZATION_TIME = 1;  % [s] Filter startup transient
CUT_START_SECONDS = 0;          % [s] Initial signal period to cut off
FINE_TUNING_FREQ_INCREMENT = 1; % [bpm] Separation between test tones for smoothing
ANIMATION_SPEED_FACTOR = 2;     % [] This makes the animation run faster or slower than real time

% Build and apply input filter
[b, a] = butter(2, [(((BPM_L)/60)/fps*2) (((BPM_H)/60)/fps*2)]);
yf = filter(b, a, y);
y = yf((fps * max(FILTER_STABILIZATION_TIME, CUT_START_SECONDS))+1:size(yf, 2));

% Some initializations and precalculations
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

figure
subplot(6,1,1);
for i=1:num_bpm_samples,
    window_start = (i-1)*bpm_sampling_period_samples+1;
    ynw = orig_y(window_start:window_start+num_window_samples);
    y = ynw .* rectwin(size(ynw, 2))';
    analyse
end
ylabel('Rect');
disp(['Rectangular: ' num2str(mean(bpm_smooth)) ' bpm']);

bpm = [];
bpm_smooth = [];
subplot(6,1,2);
for i=1:num_bpm_samples,
    window_start = (i-1)*bpm_sampling_period_samples+1;
    ynw = orig_y(window_start:window_start+num_window_samples);
    y = ynw .* triang(size(ynw, 2))';
    analyse
end
disp(['Triangular: ' num2str(mean(bpm_smooth)) ' bpm']);
ylabel('Tri');

bpm = [];
bpm_smooth = [];
subplot(6,1,3);
for i=1:num_bpm_samples,
    window_start = (i-1)*bpm_sampling_period_samples+1;
    ynw = orig_y(window_start:window_start+num_window_samples);
    y = ynw .* hann(size(ynw, 2))';
    analyse
end
ylabel('Hann');
disp(['Hanning: ' num2str(mean(bpm_smooth)) ' bpm']);

bpm = [];
bpm_smooth = [];
subplot(6,1,4);
for i=1:num_bpm_samples,
    window_start = (i-1)*bpm_sampling_period_samples+1;
    ynw = orig_y(window_start:window_start+num_window_samples);
    y = ynw .* hamming(size(ynw, 2))';
    analyse
end
ylabel('Hamm');
disp(['Hamming: ' num2str(mean(bpm_smooth)) ' bpm']);

bpm = [];
bpm_smooth = [];
subplot(6,1,5);
for i=1:num_bpm_samples,
    window_start = (i-1)*bpm_sampling_period_samples+1;
    ynw = orig_y(window_start:window_start+num_window_samples);
    y = ynw .* blackman(size(ynw, 2))';
    analyse
end
ylabel('Black');
disp(['Blackmann: ' num2str(mean(bpm_smooth)) ' bpm']);

bpm = [];
bpm_smooth = [];
subplot(6,1,6);
for i=1:num_bpm_samples,
    window_start = (i-1)*bpm_sampling_period_samples+1;
    ynw = orig_y(window_start:window_start+num_window_samples);
    y = ynw .* kaiser(size(ynw, 2))';
    analyse
end
ylabel('Kaiser');
disp(['Kaiser: ' num2str(mean(bpm_smooth)) ' bpm']);


