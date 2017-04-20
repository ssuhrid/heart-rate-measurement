clc
close all
clear all
vid=VideoReader('S:\\Dropbox\\MATLAB\\Pulse Rate\\v1.mpg')
k=[];
set(gcf,'keypress','k=get(gcf,''currentchar'');');

for i=1:vid.NumberofFrames;
    i
    rgb=read(vid,i);
    r=rgb(:,:,1);
    g=rgb(:,:,2);
    b=rgb(:,:,3);
    subplot(3,4,1);
    imshow(rgb)
    title('RGB')
    subplot(3,4,2);
    imshow(r)
    title('R')
    subplot(3,4,3);
    imshow(g)
    title('G')
    subplot(3,4,4);
    imshow(b)
    title('B')
    hsv=rgb2hsv(rgb);
    h=hsv(:,:,1);
    s=hsv(:,:,2);
    v=hsv(:,:,3);
    subplot(3,4,5);
    imshow(hsv)
    title('HSV')
    subplot(3,4,6);
    imshow(h)
    title('H')
    subplot(3,4,7);
    imshow(s)
    title('S')
    subplot(3,4,8);
    imshow(b)
    title('V')
    y=0.299 * r + 0.587 * g + 0.114 * b;
    u = -0.14713 * r - 0.28886 * g + 0.436 * b;
    v = 0.615 * r - 0.51499 * g - 0.10001 * b;
    yuv = cat(3,y,u,v);
    subplot(3,4,9);
    imshow(yuv)
    title('YUV')
    subplot(3,4,10);
    imshow(y)
    title('Y')
    subplot(3,4,11);
    imshow(u)
    title('U')
    subplot(3,4,12);
    imshow(v)
    title('V')
    
    if ~isempty(k)
            if strcmp(k,'q'); 
                delete(vid);
                break; 
            end;
    end
end