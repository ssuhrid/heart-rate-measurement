
gain = abs(fft(y));

    % FFT indices of frequencies where the human heartbeat is
    il = floor(fcl * (size(y, 2) / fps))+1; ih = ceil(fch * (size(y, 2) / fps))+1;
    index_range = il:ih;
    
    % Plot the amplitude of the frequencies of interest
%     figure(1);
%     subplot(2, 1, 1);
%     hold off;
    
%     fft_plot = plot((index_range-1) * (fps / size(y, 2)) * 60, gain(index_range), 'b', 'LineWidth', 2);
%     hold on;    
%     max_freq_plot_amplitude = max(max_freq_plot_amplitude, max(gain(index_range)));
%     axis([BPM_L BPM_H 0 max_freq_plot_amplitude]);
%     grid on;
%     xlabel('Heart rate (BPM)');
%     ylabel('Amplitude');
%     title('Frequency analysis and time evolution of heart rate signal');

    % Find peaks in the interest frequency range and locate the highest
    [pks, locs] = findpeaks(gain(index_range));
    [max_peak_v, max_peak_i] = max(pks);
    max_f_index = index_range(locs(max_peak_i));
    bpm(i) = (max_f_index-1) * (fps / size(y, 2)) * 60;
    
    % Smooth the highest peak frequency by finding the frequency that
    % best "correlates" in the resolution range around the peak
    freq_resolution = 1 / WINDOW_SECONDS;
    lowf = bpm(i) / 60 - 0.5 * freq_resolution;
    freq_inc = FINE_TUNING_FREQ_INCREMENT / 60;
    test_freqs = round(freq_resolution / freq_inc);
    power = zeros(1, test_freqs);
    freqs = (0:test_freqs-1) * freq_inc + lowf;
    for h = 1:test_freqs,
        re = 0; im = 0;
        for j = 0:(size(y, 2) - 1),
            phi = 2 * pi * freqs(h) * (j / fps);
            re = re + y(j+1) * cos(phi);
            im = im + y(j+1) * sin(phi);
        end
        power(h) = re * re + im * im;
    end
    [max_peak_v, max_peak_i] = max(power);
    bpm_smooth(i) = 60*freqs(max_peak_i);
    %bpm_smooth(i)=60*freqs(i);
    % Plot BPM over time
    hold on;
%     subplot(2, 1, 2);
    t = (0:i-1) * ((size(orig_y, 2) / fps) / (num_bpm_samples - 1));
    hold off;
    plot(t, bpm_smooth, 'r', 'LineWidth', 2);
    grid on;
    %xlabel('Time (s)');
    
    pause(BPM_SAMPLING_PERIOD / ANIMATION_SPEED_FACTOR);
    