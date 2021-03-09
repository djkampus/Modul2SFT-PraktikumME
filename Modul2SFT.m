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
y_fft_single = fftshift(fft(y));%sinyal yang ingin di fft-kan
y_fft_single = y_fft_single(L/2+1:end);
y_fft_single = abs(2*y_fft_single)./L;
axis_single = (0:L/2)*(Fs/L);               %%x axis for freq domain
figure(2)
plot(f, y_fft_single);   %plot signal in freq domain
title('Source Signal x(t) in Frequency Domain');
xlabel('frequency (Hz)');
ylabel('magnitude');

