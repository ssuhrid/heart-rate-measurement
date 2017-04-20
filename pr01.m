clc
clear all
close all
%obj=mmreader('v1.mpg');
obj=VideoReader('v1.mpg');
nFrames=obj.NumberOfFrames;
set(gcf,'keypress','k=get(gcf,''currentchar'');');
for k=1:nFrames
    img=read(obj,k);
    hsv=rgb2hsv(img);
    r=img(:,:,1);
    %figure(1),imshow(img,[]);
    figure(1);
    subplot(2,2,1);
    imshow(img);
    %r(:)=255-r(:);
    subplot(2,2,2);
    imshow(r);
    subplot(2,2,3);
    x=hsv(:,:,3);
    imshow(x);
    if ~isempty(k)
            if strcmp(k,'q'); 
                stop(vid);
                break; 
            end;
    end
end