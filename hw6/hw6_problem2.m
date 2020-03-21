%%problem 2
figure
c=[1,5,10];
%when c=1;
for i=1:3
    syms x1 x2
    subplot(1,3,i)

    cova=[c(i) 0;0 5];
    I=eye(2);
    y1=[x1;x2]'*inv(cova+I)*[x1;x2];
    y2=[x1;x2]'*inv(I)*[x1;x2];
    [x1,x2]=meshgrid(-3:0.1:3);
    y1=eval(y1);
    y2=eval(y2);

    contour(x1,x2,y1,[1,1],'linecolor','r')
    hold on
    contour(x1,x2,y2,[1,1],'linecolor','b')
    legend('\Sigma_x^{-1}','S_x^{-1}');
    title(['when c=',num2str(c(i))])
    xlabel('x1')
    ylabel('x2') 
end

