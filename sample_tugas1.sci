clc;
clear all;

/*********************************************************/
//VARIABLE DECLARATION
global xt deltat ht yt;
L = 2000;
dep = (1-0.33);             //signal after depletion (pelemahan)

/*********************************************************/
//SOURCE SIGNAL x(t)
//time-domain
[xt, fs] = wavread('Spesifikasi B.wav');    //read signal from audio file
figure(1);
subplot(2,1,1);
title('Source Signal x(t) in Time Domain');
xlabel('t (s)');
ylabel('amplitude');
plot2d(xt);                                 //plot signal in time domain

//frequency-domain
xt_fft = fft(xt);                           //Forward Fourier Transform (FFT) process
xt_fft_magnitude = abs(xt_fft);             //magnitude view and scaling
xt_fft_magnitude_single = xt_fft_magnitude(1:0.5*L+1);  //first half of freq domain
xt_fft_magnitude_single = mtlb_i(xt_fft_magnitude_single,2:0.5*L+1, 2*mtlb_double(mtlb_e(xt_fft_magnitude_single,2:0.5*L+1)));  //double the magnitude
axis_single = (0:L/2)*(fs/L);               //x axis for freq domain
subplot(2,1,2);
title('Source Signal x(t) in Frequency Domain');
xlabel('frequency (Hz)');
ylabel('magnitude (Watt)');
plot2d(axis_single, xt_fft_magnitude_single);   //plot signal in freq domain

/*********************************************************/
//CHANNEL h(t)
//h(t) = pelemahan * deltafunction
deltat = zeros(1,max(size(xt)));
deltat(1,1)= 1;
//time-domain
ht = dep*deltat;
figure(2);
subplot(2,1,1);
title('Channel h(t) in Time Domain');
xlabel('t (s)');
ylabel('amplitude');
plot2d(ht); 

//frequency-domain
ht_fft = fft(ht);                           //Forward Fourier Transform (FFT) process
ht_fft_magnitude = abs(ht_fft);             //magnitude view and scaling
ht_fft_magnitude_single = ht_fft_magnitude(1:0.5*L+1);  //first half of freq domain
ht_fft_magnitude_single = mtlb_i(ht_fft_magnitude_single,2:0.5*L+1, 2*mtlb_double(mtlb_e(ht_fft_magnitude_single,2:0.5*L+1)));  //double the magnitude
axis_single = (0:L/2)*(fs/L);               //x axis for freq domain
subplot(2,1,2);
title('Channel h(t) in Frequency Domain');
xlabel('frequency (Hz)');
ylabel('magnitude (Watt)');
plot2d(axis_single, ht_fft_magnitude_single);   //plot signal in freq domain

/*********************************************************/
//RECEIVED SIGNAL y(t)
//time-domain
yt = conv(xt, ht, "same");
figure(3);
subplot(2,1,1);
title('Received Signal y(t) in Time Domain');
xlabel('t (s)');
ylabel('amplitude');
plot2d(yt); 

//frequency-domain
yt_fft = fft(yt);
yt_fft_magnitude = abs(yt_fft);             //magnitude view and scaling
yt_fft_magnitude_single = yt_fft_magnitude(1:0.5*L+1);  //first half of freq domain
yt_fft_magnitude_single = mtlb_i(yt_fft_magnitude_single,2:0.5*L+1, 2*mtlb_double(mtlb_e(yt_fft_magnitude_single,2:0.5*L+1)));  //double the magnitude
axis_single = (0:L/2)*(fs/L);               //x axis for freq domain
subplot(2,1,2);
title('Received Signal y(t) in Frequency Domain');
xlabel('frequency (Hz)');
ylabel('magnitude (Watt)');
plot2d(axis_single, yt_fft_magnitude_single);   //plot signal in freq domain
