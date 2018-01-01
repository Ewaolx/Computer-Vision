function [ fundx ] = fit_fundamental(m)
% Finds findamental matrix.
% m=  matches
fundx=0;

N = size(m,1);

x1=m(1,1);
y1=m(1,2);
x1d=m(1,3);
y1d=m(1,4);
ax=[x1*x1d x1*y1d x1 y1*x1d y1*y1d y1 x1d y1d 1];



for i=2:N
 x1=m(i,1);
 y1=m(i,2);
 x1d=m(i,3);
 y1d=m(i,4);
 b=[x1*x1d x1*y1d x1 y1*x1d y1*y1d y1 x1d y1d 1];
 ax=[ax;b];
end

[U,S,V]=svd(ax);
Httemp=V(:,end);
H1t=Httemp(1:3,:);
H2t=Httemp(4:6,:);
H3t=Httemp(7:9,:);
fundx=[H1t';H2t';H3t'];

[fu,fs,fv]=svd(fundx);
fs(3,3)=0;
fundx=fu*fs*fv';
% 
fundx=fundx';
 
 
end

