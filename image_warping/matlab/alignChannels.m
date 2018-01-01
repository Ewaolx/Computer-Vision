function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
rr=0;
rt=0;
bb=0;
bt=0;
r=red;
b=blue;
g=green;
d1=100000000;
x1i=0;x1j=0;x2i=0;x2j=0;
d2=100000000;
d3=100000000;
di=100000000;
rgbResult=0;
t=0;
for i=-30:30
  red=r;   
  red=circshift(red,i,1);
  for j=-30:30
  rt=red;    
  rt=circshift(rt,j,2);   
  t=sum((rt(:)-green(:)).^2);
    if(d1>t)
      rr=rt;  
      d1=t;
      x1i=i;
      x1j=j;
    end
  end 
end 

t=0;
for i=-30:30
  blue=b;   
  blue=circshift(blue,i,1);
  for j=-30:30
  bt=blue;    
  bt=circshift(bt,j,2);   
  t=sum((bt(:)-green(:)).^2);
    if(d2>t)
      bb=bt;  
      d2=t;
      x2i=i;
      x2j=j;
    end
  end 
end 
 
r=circshift(r,x1i,1);
r=circshift(r,x1j,2);
b=circshift(b,x2i,1);
b=circshift(b,x2j,2);

t=sum((r(:)-b(:)).^2);
X=cat(3,rr,green,bb);
rgbResult=X;
end
