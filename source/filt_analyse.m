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

%figure
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


