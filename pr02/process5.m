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

figure('name','Butter');
disp('Butter');
[b, a] = butter(2, [(((BPM_L)/60)/fps*2) (((BPM_H)/60)/fps*2)]);
yf = filter(b, a, y);
y = yf((fps * max(FILTER_STABILIZATION_TIME, CUT_START_SECONDS))+1:size(yf, 2));
filt_analyse

figure('name','Bessel');
disp('Bessel')
y=br;
[b, a] = besself(2, [(((BPM_L)/60)/fps*2) (((BPM_H)/60)/fps*2)]);
yf = filter(b, a, y);
y = yf((fps * max(FILTER_STABILIZATION_TIME, CUT_START_SECONDS))+1:size(yf, 2));
filt_analyse


