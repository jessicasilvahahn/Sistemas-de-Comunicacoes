x = [1 -1]
h = [1 3]
y = cconv(h,x,2)


X = fft(x) 
H = fft(h) 
Y = fft(y) 
t = H.*X




conv_circ_entre_xh= [-2 2]
f = fft(conv_circ_entre_xh)





