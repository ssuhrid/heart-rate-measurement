These Matlab scripts compute your heart rate over time from a video of your fingertip captured with your smartphone. To get good results, you must press the camera lens gently. Make sure that your fingertip covers the lens completely. If your phone has a torch next to the lens, turn it on so it illuminates your fingertip and makes the image brighter.

**How to use the Matlab scripts**

1) Compute the brightness signal from a video:  

brightness = acquire('path to the video file');


2) Then, process the signal:  

process2(brightness);

A plot will open and you will see an animation of the estimated heart rate over time.