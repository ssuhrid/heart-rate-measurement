function y=acquire()

clc
close all
clear all

video=VideoReader('S:\\Dropbox\\MATLAB\\Pulse Rate\\Video2HeartRate-master\\pv3.mpg')
numFrames = video.NumberOfFrames;
display(['Total frames: ' num2str(numFrames)]);
y = zeros(1, numFrames);
x=1:numFrames;
figure()
for i=1:numFrames,
    %display(['Processing ' num2str(i) '/' num2str(numFrames)]);
    frame = read(video, i);
    redPlane = frame(:, :, 1);    
%     subplot(2,1,1)
%     imshow(redPlane);
    y(i) = sum(sum(redPlane)) / (size(frame, 1) * size(frame, 2));   
%     subplot(2,1,1);
%     plot(x,y)
end

f=abs(fft(y))
subplot(2,1,2);
plot(x,f)

display('Signal acquired.');
end