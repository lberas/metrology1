% Input point cloud is named 'x.txt', where x=[a b c d e]
points='e.txt';
a=readmatrix(points);

% This variation of the code is for YZ analysis
a(:,1)=[];

% Sorting and placing the surface at (0,0)
A=sortrows(a,2);
A(:,1)=A(:,1)-min(A(:,1));
A(:,2)=A(:,2)-min(A(:,2));

%Ploting the surface
plot(A(:,2),A(:,1),'r-');

mid=mean(A(:,1));

% Wv is the waviness 2D curve, not the scalar value
% A moving average of 10 points
Wv=movmean(A(:,1),10);

% Ra is the scalar surface roughness value
% Calculated using difference to waviness curve
Ra=sum(abs(A(:,1)-Wv))/max(size(A))

hold on
plot(A(:,2),Wv,'b-');

% Form curve uses a moving average of 100 points
Form=movmean(Wv,100);
plot(A(:,2),Form,'g-');

% Wa is the scalar waviness value
% Calculated using difference to form curve
Wa=sum(abs(Wv-Form))/max(size(A))

title(['YZ, ' points ': raw data (red), waviness (blue) and form (green)'])
xlabel('Z (mm)')
ylabel('Y (mm)')
plot(A(:,2),mid*ones(max(size(A))),'y--')

% Forma is the scalar form value
% Calculated using difference to form curve
Forma=sum(abs(Form-mid))/max(size(A))