clc
clear

% Stable point file is named 'sp.txt'
a=readmatrix('sp.txt');
a(:,1:4)=[];

% Path file is called 'named.txt'
b=readmatrix('path.txt');
b(:,1:2)=[];

hold on

% Calculating the HTM of each stable point and plotting it
for i=1:4
    HTM=eye(4);
    HTM(1:3,1:3)=rotz(a(i,6),'deg')*roty(a(i,5),'deg')*rotx(a(i,4),'deg');
    HTM(1:4,4)=[a(i,1) a(i,2) a(i,3) 1]';
    trplot(HTM,'length',50);
    % Plotting each stable point uncertaintly, exaggerated 400x
    plotcube([a(i,7) a(i,8) a(i,9)]*400, [a(i,1) a(i,2) a(i,3)]-[a(i,7) a(i,8) a(i,9)]*200)
end

% Plotting lines between stable points
plot3(a([1:4 1],1),a([1:4 1],2),a([1:4 1],3),'g')

% Plotting origin
trplot(eye(4),'frame','s','length',50,'color','r')

% Plotting path points
plot3(b(:,1),b(:,2),b(:,3),'k*')

axis equal
axis([-200 300 -100 100 -200 250])
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on