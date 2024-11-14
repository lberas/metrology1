clc
clear

% Stable point file is named 'sp.txt'
a=readmatrix('sp.txt');
a(:,1:4)=[];

% Finding centroid
cent=mean([a(1:4,1) a(1:4,2) a(1:4,3)]);

% Finding normal (cross-product) at first point
cross1=cross(a(4,1:3)-a(1,1:3),a(2,1:3)-a(1,1:3));
cross1=cross1/norm(cross1);
% Finding normal at second point etc.
cross2=cross(a(1,1:3)-a(2,1:3),a(3,1:3)-a(2,1:3));
cross2=cross2/norm(cross2);
cross3=cross(a(2,1:3)-a(3,1:3),a(4,1:3)-a(3,1:3));
cross3=cross3/norm(cross3);
cross4=cross(a(3,1:3)-a(4,1:3),a(1,1:3)-a(4,1:3));
cross4=cross4/norm(cross4);
% Defining the new z axis as average of previous normals
newz=mean([cross1;cross2;cross3;cross4]);
newz=newz/norm(newz);

hold on
grid on

% Plotting theoretical path
plot3(a([1:4 1],1),a([1:4 1],2),a([1:4 1],3),'g')

% Plotting origin
trplot(eye(4),'frame','s','length',50,'color','r')

% Plotting normals at stable points
arrow3(a(1,1:3),a(1,1:3)+cross1*50)
arrow3(a(2,1:3),a(2,1:3)+cross2*50)
arrow3(a(3,1:3),a(3,1:3)+cross3*50)
arrow3(a(4,1:3),a(4,1:3)+cross4*50)

% Projecting x axis to the new plane
newx=[1 0 0]-dot(newz,[1 0 0])*newz;
newx=newx/norm(newx);

% Rotating new x axis 90° around new z axis to create new y axis
newy=axang2rotm([newz pi/2])*newx';
% Transposing just to keep axes dimensions consistent
newy=newy';

% Creating an HTM for the new coordinate system
newHTM=[newx' newy' newz' cent'; 0 0 0 1];
trplot(newHTM,'length',50,'color','b')

axis equal
axis([-200 300 -100 100 -200 250])
xlabel('X')
ylabel('Y')
zlabel('Z')