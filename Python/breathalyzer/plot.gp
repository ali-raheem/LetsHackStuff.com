set term png
set output 'results.png'
set xlabel 'time (minutes)'
set title 'Breathlyser results post 125ml 11% wine'
set key off
foo(x) = a*exp(b*x)
a = 200
b=-0.15
fit foo(x) 'results' using 1:2 via a, b
plot 'results' using 1:2, foo(x)

