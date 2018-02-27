function logistic_graphical
  clf
  a = 3.9;
  xx = 0:.01:1;
  yy = a.*xx.*(1-xx);
  plot(xx,yy,'k'), hold on
  plot([0 1],[0 1],'k')
  t(1) = 0;
  x(1) = 0.25;
  for j = 1:100
      x(j+1) = a.*x(j).*(1-x(j));
      t(j+1) = t(j) + 1;
      plot([x(j) x(j+1)],[x(j+1) x(j+1)],'b')
    if (j == 1)
      plot([x(j) x(j)],[0 x(j+1)],'b')
    else
      plot([x(j) x(j)],[x(j) x(j+1)],'b')
    end
  end
  axis([0 1 0 1])
  hold off
  xlabel('x(t)')
  ylabel('x(t+1)')
  %filename = sprintf('logistic_graphical%d.png',i)
  %print(filename,'-dpng')
end
