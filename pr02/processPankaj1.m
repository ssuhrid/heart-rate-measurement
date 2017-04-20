%[b,a]=butter(1,[.0388726919339164,0.1943634596695821]);
%h=fvtool(b,a)
% int i;
% int x;
z=0;
figure;
fps=30;
subplot(6,1,1);
plot(br);
[b, a] = butter(2, [(((40)/60)/fps*2) (((230)/60)/fps*2)]);
% [b,a]=butter(2,[0.70/30*2 4.166/30*2]);%designing butterwoth filter
ss1=filter(b,a,br);
subplot(6,1,2);
plot(ss1);
ss2=ss1(31:size(br,2));
subplot(6,1,3);
plot(ss2);
ss2=ss2(16:196);
hn=(hann(length(ss2)))';
ss3=ss2.*hn;
subplot(6,1,4);
plot(1:length(ss3),ss3);
ss4=fft(ss3);
% figure;
% plot(1:length(ss4),ss4);
ss5=abs(ss4);
% xlab=(1:length(ss4)).*(
subplot(6,1,5);
plot(1:length(ss5),ss5);
subplot(6,1,6);

il = floor((40/60) * (size(ss5, 2) / fps))+1; ih = ceil((230/60) * (size(ss5, 2) / fps))+1;
index_range = il:ih;

plot((index_range-1) * (fps / size(ss5, 2)) , ss5(index_range), 'b', 'LineWidth', 2)


% ss6=ss5(1:5);
% plot(1:length(ss6),ss6);

max(ss5(il:ih))

%matlabtoarduinodemo();
