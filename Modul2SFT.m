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
<<<<<<< HEAD


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


%%%fungsi dari wireless channel
function [H,channel_axis,H_freq, q]=wadidaw(L,Fs)
channel_length=1:L;
channel_axis=(0:L/2)*(Fs/L);
total_path_loss=0.5;
loss_coeff=total_path_loss./(sum(exp(-channel_length/8)));
path_loss=loss_coeff*exp(-channel_length/8); %path loss in power, exponential decay model
H=zeros(1,length(channel_length)); %channel impulse response
        for j=1:length(channel_length)
              q(j) = randn(1,1);
              H(j)=path_loss(j).*(q(j));
        end
H=abs(H);
H_freq=abs(fft(H))/L;
H_freq=H_freq(1:(0.5*L)+1);
H_freq(2:(0.5*L)+1)=2*H_freq(2:(0.5*L)+1);
end
  
=======
>>>>>>> parent of ab118c0 (sekarang udah bener untuk pengerjaan 1)
