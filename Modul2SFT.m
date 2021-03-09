%%%preparation
[xt,Fs]=audioread('Spesifikasi B.wav');
dep=(1-0.94);%prosentase nilai susutan

%%%plotting isyarat masukan x(t) dimana adalah sample audio
%%%dalam ranah waktu
figure()
subplot(2,1,1)
plot(xt)
title('Source Signal x(t) in Time Domain')
xlabel('t (s)')
ylabel('amplitude')
%%dalam ranah frekuensi
%%dalam ranah frekuensi
xt_fft = fft(xt);                          
xt_fft_magnitude = abs(xt_fft);             
xt_fft_magnitude_single = xt_fft_magnitude(1:0.5*L+1); 
axis_single = (0:L/2)*(fs/L);

subplot(2,1,2)
plot(axis_single, xt_fft_magnitude_single)
title('Source Signal x(t) in Frequency Domain');
xlabel('frequency (Hz)');
ylabel('magnitude (Watt)');

%%channel h(t)
deltat = zeros(1,max(size(xt)));
deltat(1,1)= 1;
%%time-domain
ht = dep*deltat;
figure()
subplot(2,1,1)
plot(ht)
title('Channel h(t) in Time Domain');
xlabel('t (s)');
ylabel('amplitude');
%%ploting time domain khusus h(t)

%frequency-domain
ht_fft = fft(ht);                           %%Forward Fourier Transform (FFT) process
ht_fft_magnitude = abs(ht_fft);             %%magnitude view and scaling
ht_fft_magnitude_single = ht_fft_magnitude(1:0.5*L+1);  %%first half of freq domain
subplot(2,1,2)
plot(axis_single, ht_fft_magnitude_single);   %plot signal in freq domain
title('Channel h(t) in Frequency Domain');
xlabel('frequency (Hz)');
ylabel('magnitude');


%RECEIVED SIGNAL y(t)
%time-domain
yt = conv(xt, ht, "same");
figure()
subplot(2,1,1)
plot(yt); 
title('Received Signal y(t) in Time Domain');
xlabel('t (s)');
ylabel('amplitude');


%%frequency-domain
yt_fft = fft(yt);
yt_fft_magnitude = abs(yt_fft);           
yt_fft_magnitude_single = yt_fft_magnitude(1:0.5*L+1);  
axis_single = (0:L/2)*(fs/L); 
subplot(2,1,2)
plot(axis_single, yt_fft_magnitude_single)
title('Received Signal y(t) in Frequency Domain')
xlabel('frequency (Hz)');
ylabel('magnitude (Watt)');
  