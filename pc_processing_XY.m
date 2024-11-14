% Input point cloud is named 'x.txt', where x=[i ii iii iv v]
points='v.txt';
a=readmatrix(points);

% This variation of the code is for XY analysis
a(:,3)=[];

% Sorting and placing the surface at (0,0)
A=sortrows(a,1);
A(:,1)=A(:,1)-min(A(:,1));
A(:,2)=A(:,2)-min(A(:,2));

%Ploting the surface
plot(A(:,1),A(:,2),'r-');

mid=mean(A(:,2));

% Wv is the waviness 2D curve, not the scalar value
% A moving average of 7 points
Wv=movmean(A(:,2),7);

% RaA is the scalar surface roughness value
% Calculated using difference to waviness curve
Ra=sum(abs(A(:,2)-Wv))/max(size(A))

hold on
plot(A(:,1),Wv,'b-');

% Form curve uses a moving average of 100 points
Form=movmean(Wv,100);
plot(A(:,1),Form,'g-');

% WaA is the scalar waviness value
% Calculated using difference to form curve
WaA=sum(abs(Wv-Form))/max(size(A))

title(['XY, ' points ': raw data (red), waviness (blue) and form (green)'])
xlabel('Z (mm)')
ylabel('Y (mm)')
plot(A(:,1),mid*ones(max(size(A))),'y--')

Forma=sum(abs(Form-mid))/max(size(A))