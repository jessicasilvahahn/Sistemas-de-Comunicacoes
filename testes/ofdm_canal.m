function ofdm_canal(x,h,snr)
    n = length(x);
    conv_circular = cconv(h,x,n)
    y = awgn(conv_circular,snr)

end