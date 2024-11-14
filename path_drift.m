clc
clear

% Stable point file is named 'sp.txt'
a=readmatrix('sp.txt');
a(:,1:4)=[];

% Path drift file is named 'pad.txt'
b=readmatrix('pad.txt');
b(:,1:3)=[];

hold on
grid on

for i=1:size(b,1)
    meanx=mean([b(i,1) b(i,7)]);
    meany=mean([b(i,2) b(i,8)]);
    meanz=mean([b(i,3) b(i,9)]);
    diffx=abs(b(i,1)-b(i,7))*25;
    diffy=abs(b(i,2)-b(i,8))*25;
    diffz=abs(b(i,3)-b(i,9))*25;
    plot3([meanx-diffx meanx+diffx],[meany-diffy meany+diffy], ...
        [meanz-diffz meanz+diffz])
end

% Plotting theoretical path
plot3(a([1:4 1],1),a([1:4 1],2),a([1:4 1],3),'g--')

axis equal
axis([-200 300 -100 100 -200 250])
xlabel('X')
ylabel('Y')
zlabel('Z')