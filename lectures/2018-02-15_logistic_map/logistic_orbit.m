function logistic_orbit
clf
a = linspace(3,4,10000);
N = length(a);
x(1,1:N) = 0.25;
for j = 1:1000
x(j+1,:) = a.*x(j,:).*(1-x(j,:));
end
plot(a,x(900:1001,:),'k.','MarkerSize',1)
axis([0 4 0 1])
xlabel('a')
ylabel('x(t)')
%filename = sprintf('logistic_orbit.png')
%print(filename,'-dpng')
end
