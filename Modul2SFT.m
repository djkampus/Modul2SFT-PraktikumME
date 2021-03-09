%%%preparation
[y,Fs]=audioread('Spesifikasi B.wav');
dep=(1-0.94);%prosentase nilai susutan

%%%plotting isyarat masukan x(t) dimana adalah sample audio
%%%dalam ranah waktu
figure(1)
plot(y)
title('Source Signal x(t) in Time Domain')
xlabel('t (s)')
ylabel('amplitude')
%%dalam ranah frekuensi
%%dalam ranah frekuensi
L=length(y);
axis_single = (0:L/2)*(Fs/L);               %%x axis for freq domain
y_fft_single = fftshift(fft(y));%sinyal yang ingin di fft-kan
y_fft_single = y_fft_single(L/2+1:end);
y_fft_single = abs(2*y_fft_single)./L;
df = Fs/L;
f = -Fs/2:df:Fs/2-df;
f = f(L/2+1:end)';
figure(2)
plot(f, y_fft_single);   %plot signal in freq domain
title('Source Signal x(t) in Frequency Domain');
xlabel('frequency (Hz)');
ylabel('magnitude');

%%channel h(t)
deltat = zeros(1,max(size(y)));
deltat(1,1)= 1;
%%time-domain
ht = dep*deltat;
figure(2);
title('Channel h(t) in Time Domain');
xlabel('t (s)');
ylabel('amplitude');
%%ploting time domain khusus h(t)
plot(ht); 

%frequency-domain
ht_fft = fft(ht);                           %%Forward Fourier Transform (FFT) process
ht_fft_magnitude = abs(ht_fft);             %%magnitude view and scaling
ht_fft_magnitude_single = ht_fft_magnitude(1:0.5*L+1);  %%first half of freq domain
figure()
plot(axis_single, ht_fft_magnitude_single);   %plot signal in freq domain
title('Channel h(t) in Frequency Domain');
xlabel('frequency (Hz)');
ylabel('magnitude');
