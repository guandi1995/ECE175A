%%problem 1
%part(c)
x=-5:1:5;
y1=abs(x)-abs(x-1)/2+log(1/2);
figure
plot(x,y1,'black')
hold on 
yline(0,'-.red');
grid on
xlabel('x')
ylabel('y')
title('P_Y(0)=P_Y(1)=0.5')
%part(d)
x=-5:1:5;
y2=2*abs(x)-abs(x-1)+2*log(1/6);
figure
plot(x,y2,'black')
hold on 
yline(0,'-.red');
grid on
xlabel('x')
ylabel('y')
title('P_Y(0)=0.75, P_Y(1)=0.25')