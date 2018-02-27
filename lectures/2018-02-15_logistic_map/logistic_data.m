function logistic_data
clf
a = 3.0;
t(1) = 0;
x(1) = 0.25;
for j = 1:100
x(j+1) = a.*x(j).*(1-x(j));
t(j+1) = t(j) + 1;
end
plot(t,x,'k*-'),axis([0 100 0 1])
xlabel('t')
ylabel('x')
%filename = sprintf('logistic_data%d.png',i)
%print(filename,'-dpng')
end
