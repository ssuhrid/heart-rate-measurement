function y=acquire()

clc
close all
clear all

v=VideoReader('Samples\\jainsir.mpg');
%v=VideoReader('jainsir.mpg');
numFrames = v.NumberOfFrames;
display(['Total frames: ' num2str(numFrames)]);
y = zeros(1, numFrames);
x=1:numFrames;
figure()
for i=1:numFrames,
    display(['Processing ' num2str(i) '/' num2str(numFrames)]);
    frame = read(v, i);
    redPlane = frame(:, :, 1);    
   % subplot(2,1,1)
   % imshow(redPlane);
    y(i) = sum(sum(redPlane)) / (size(frame, 1) * size(frame, 2));   
    subplot(2,1,1);
    plot(x,y)
end

display('Signal acquired.');
end