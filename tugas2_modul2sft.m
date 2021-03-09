%%prep
[xt, Fs] = audioread('Spesifikasi B.wav');
xt = reshape(xt, [],1);
L = length(xt);
dt = 1/Fs;            % seconds
t =(0:L-1)*dt;
%Tugas 2
[H,channel_axis,H_freq, q] = wadidaw(L, Fs);
figure();
plot(t,xt);
xlim([0, 6]);
title('Transmitted Signal - Time');
xlabel('t');
ylabel('Amplitude')
xt_freq=abs(fft(xt))./L;
xt_freq=xt_freq(1:(0.5*L)+1);
xt_freq(2:(0.5*L)+1)=2*xt_freq(2:(0.5*L)+1);
figure();
plot(channel_axis, xt_freq);
xlim([0, 2*10^4]);
title('Transmitted Signal - Frequency');
xlabel('Freq');
ylabel('Magnitude')
figure();
plot(t, H);
xlim([0, 0.002]);
title('Channel Impulse Response - Time');
xlabel('t');
ylabel('Amplitude')
figure();
plot(channel_axis, H_freq);
xlim([0, 2*10^4]);
title('Channel Impulse Response - Freq');
xlabel('Freq');
ylabel('Magnitude')
yt = conv(xt,H,'same');
yt_freq=abs(fft(yt))./L;
yt_freq=yt_freq(1:(0.5*L)+1);
yt_freq(2:(0.5*L)+1)=2*yt_freq(2:(0.5*L)+1);
figure();
plot(t, yt);
xlim([0, 6]);
title('Received Signal - Time');
xlabel('Time');
ylabel('Amplitude')
figure();
plot(channel_axis,yt_freq);
xlim([0, (2*10^4)]);
title('Received Signal - Frequency');
xlabel('Freq');
ylabel('Magnitude')

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