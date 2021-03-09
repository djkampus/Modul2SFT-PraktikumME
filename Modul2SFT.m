%%%preparation
clear;
[xt,Fs]=audioread('Spesifikasi B.wav');
dep=(1-0.94);%prosentase nilai susutan
L=length(xt);
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
axis_single = (0:L/2)*(Fs/L);

subplot(2,1,2)
plot(axis_single, xt_fft_magnitude_single)
title('Source Signal x(t) in Frequency Domain');
xlabel('frequency (Hz)');
ylabel('magnitude');

%%channel h(t)
Am = 10;
tht = -L/2:1:L/2;
df = dirac(tht);
ht = df == Inf;
ht(ht) = 1;
figure();
plot(tht,ht*(1-dep));
xlim([-10, 10]);
title('Impulse Response');
xlabel('t');
ylabel('Magnitude')
%%time-domain
ht = dep*ht;
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
axis_single = (0:L/2)*(Fs/L); 
subplot(2,1,2)
plot(axis_single, yt_fft_magnitude_single)
title('Received Signal y(t) in Frequency Domain')
xlabel('frequency (Hz)');
ylabel('magnitude');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%function for wireless channel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [H,channel_axis,H_freq]=wireless_channel(L,Fs)
channel_length=1:L;
channel_axis=(0:L/2)*(Fs/L);
total_path_loss=0.5;
loss_coeff=total_path_loss./(sum(exp(-channel_length/8)));
path_loss=loss_coeff*exp(-channel_length/8); %path loss in power, exponential decay model
H=zeros(1,length(channel_length)); %channel impulse response
        for j=1:length(channel_length)
              H(j)=path_loss(j).*(randn(1,1));
        end
H=abs(H);
H_freq=abs(fft(H))/L;
H_freq=H_freq(1:(0.5*L)+1);
H_freq(2:(0.5*L)+1)=2*H_freq(2:(0.5*L)+1);
end

%%%%%tugas 2