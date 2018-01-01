left_im = imread('house1.jpg');
right_im = imread('house2.jpg');
c1=load('library1_camera.txt');
c2=load('library2_camera.txt');
matches = load('library_matches.txt');
%% Finding camera centers

[cu cs cv]=svd(c1);
cam1=cv(:,4);
x1cen=cam1(1)/cam1(4);
y1cen=cam1(2)/cam1(4);
z1cen=cam1(3)/cam1(4);

[cu cs cv]=svd(c2);
cam2=cv(:,4);
x2cen=cam2(1)/cam2(4);
y2cen=cam2(2)/cam2(4);
z2cen=cam2(3)/cam2(4);


%% Finding triangulation Matrix
finnal=zeros(168,3);
fr=zeros(168,4);

x1=matches(1,1);
y1=matches(1,2);
x1d=matches(1,3);
y1d=matches(1,4);

aa=[0   -1  y1;
    1    0  -x1;
    -y1  x1  0];
ac1=aa*c1;
bb=[0   -1  y1d;
    1    0  -x1d;
    -y1d  x1d  0]; 
ac2=bb*c2;

zz=[ac1;ac2];
[U,S,V]=svd(zz);
fi=V(:,end);
fr(1,:)=fi';
fin=[fi(1)/fi(4) fi(2)/fi(4) fi(3)/fi(4)];
finnal(1,:)=fin;

for i=2:length(matches)
x1=matches(i,1);
y1=matches(i,2);
x1d=matches(i,3);
y1d=matches(i,4);

aa=[0   -1  y1;
    1    0  -x1;
    -y1  x1  0];
ac1=aa*c1;
bb=[0   -1  y1d;
    1    0  -x1d;
    -y1d  x1d  0]; 
ac2=bb*c2;

zz=[ac1;ac2];
[U,S,V]=svd(zz);
fi=V(:,end);
fr(i,:)=fi';
fin=[fi(1)/fi(4) fi(2)/fi(4) fi(3)/fi(4)];
finnal(i,:)=fin;
end

%% Plotting camera centers for both images and triangulation
figure();
plot3(-x1cen,y1cen,z1cen,'*g');
figure();
plot3(-x2cen,y2cen,z2cen,'*g');
figure();
plot3(-finnal(:,1),finnal(:,2),finnal(:,3),'.r');

%%  Residue between 3d and  2d points
%Image1
t=c1*fr';
t=t';
for i=1:length(t)
    temp=t(i);
    resp1(i,:)=[t(i,1)/t(i,3)  t(i,2)/t(i,3)];
end

respw1=matches(:,1:2);
di1=dist2(resp1,respw1);
distance1=trace(di1);

%Image2
t=c2*fr';
t=t';
for i=1:length(t)
    temp=t(i);
    resp2(i,:)=[t(i,1)/t(i,3)  t(i,2)/t(i,3)];
end

respw2=matches(:,3:4);
di2=dist2(resp2,respw2);
distance2=trace(di2);