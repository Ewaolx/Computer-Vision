im=dir('../data/part1/uttower/right.jpg');
fn={im.name};
right_im=imread(fn{1});
right=right_im;
ssi=size(right);
im=dir('../data/part1/uttower/left.jpg');
fn={im.name};
left_im=imread(fn{1});
left=left_im;
left_im=rgb2gray(left_im);
right_im=rgb2gray(right_im);
left_im=im2double(left_im);
right_im=im2double(right_im);
thres_harris=0.06;
sigma=2;
window=20;
%% Left Image
[ciml, rl, cl] = harris(left_im,sigma,thres_harris,3,1);
cc=[rl cl];
tt=1;
ssl=size(rl);
f=0;
re=1;
for  k=1:ssl(1)
    a=rl(k);
    b=cl(k);
    x=[a b];
    tt=1;
    t=0;
 for i=a-window:a+window
    for j=b-window:b+window
        if(a>window && b>window && a<ssi(1)-window && b<ssi(2)-window)
         t(tt)=left_im(i,j);
         tt=tt+1;
         f=1;
        end
    end    
 end
   if(f==1)
    res_left{re}=t;
    indl{re}=[x(2) x(1)];  
    re=re+1;
    f=0; 
   end 
end 
%% Right Image
[cimr, rr, cr] = harris(right_im,sigma,thres_harris,3,1);
cc=[rr cr];
tt=1;
ssr=size(rr);
f=0;
re=1;
for  k=1:ssr(1)
    a=rr(k);
    b=cr(k);
    x=[a b];
    tt=1;
    t=0;
 for i=a-window:a+window
    for j=b-window:b+window
        if(a>window && b>window && a<(ssi(1)-window) && b<(ssi(2)-window))
         t(tt)=right_im(i,j);
         tt=tt+1;
         f=1;
        end
    end    
 end
   if(f==1)
    res_right{re}=t;
    indr{re}=[x(2) x(1)];
    re=re+1;
    f=0;
   end 
end

%% Computing Distance between descriptors
 res_right_mat=cell2mat(res_right');
 res_left_mat=cell2mat(res_left');
 diss=dist2(res_left_mat,res_right_mat);

%% Applying threshold
 rts=(diss<35);
 [rts_r rts_c]=find(rts);
 for i=1:size(rts_r)
 ftt=indl{rts_r(i)};    
 fr(i)=ftt(1);
 fc(i)=ftt(2);
 ftt1=indr{rts_c(i)};
 frr(i)=ftt1(1);
 fcc(i)=ftt1(2);
 pairs{i}=[indl(rts_r(i)),indr(rts_c(i))];
 end

 figure();
 imshow([left,right]);
 for i=1:length(fc)
 hold on   
  plot([fr(i),frr(i)+ssi(2)],[fc(i),fcc(i)],'r','linewidth',1);
 end
 
%% Homogeneous Matrix- Ransack 
n=10000;
tii=0;
for  k=1:n
 rand=randperm(length(pairs),4);

 apl=pairs{1,rand(1)}{1,1};
 apr=pairs{1,rand(1)}{1,2};
 bpl=pairs{1,rand(2)}{1,1};
 bpr=pairs{1,rand(2)}{1,2};
 cpl=pairs{1,rand(3)}{1,1};
 cpr=pairs{1,rand(3)}{1,2};
 dpl=pairs{1,rand(4)}{1,1};
 dpr=pairs{1,rand(4)}{1,2};
 
 x1=apl(1);
 y1=apl(2);
 x1d=apr(1);
 y1d=apr(2);
 x2=bpl(1);
 y2=bpl(2);
 x2d=bpr(1);
 y2d=bpr(2);
 x3=cpl(1);
 y3=cpl(2);
 x3d=cpr(1);
 y3d=cpr(2);
 x4=dpl(1);
 y4=dpl(2);
 x4d=dpr(1);
 y4d=dpr(2);
 aa1=[x1 y1 1 0 0 0 -x1*x1d -y1*x1d -x1d;
      0  0  0 x1 y1 1 -x1*y1d -y1*y1d -y1d;
      x2 y2 1 0 0 0 -x2*x2d -y2*x2d -x2d;
      0  0  0 x2 y2 1 -x2*y2d -y2*y2d -y2d;
      x3 y3 1 0 0 0 -x3*x3d -y3*x3d -x3d;
      0  0  0 x3 y3 1 -x3*y3d -y3*y3d -y3d;
      x4 y4 1 0 0 0 -x4*x4d -y4*x4d -x4d;
      0  0  0 x4 y4 1 -x4*y4d -y4*y4d -y4d;];
 
[U,S,V]=svd(aa1);
Htemp=V(:,end);
H1=Htemp(1:3,:);
H2=Htemp(4:6,:);
H3=Htemp(7:9,:);
h=[H1';H2';H3'];   %% h=HOMOGENEOUS MATRIX
   
count=0; 
ff=1;
threshold=150;
ill=1;

for i=1:length(pairs)
    aptl=pairs{1,i}{1,1};
    aptr=pairs{1,i}{1,2};
    rr=h*[aptl(1) aptl(2) 1]';  
      rrx=(rr(1)/rr(3));
      rry=(rr(2)/rr(3));
      rrt=((rrx-aptr(1)).^2) + ((rry-aptr(2)).^2);
      il(ill)=rrt;
      ill=ill+1;
      if(rrt<=threshold)
            count=count+1;
            fpairs{ff}=[aptl,aptr];
            ff=ff+1;
      end
end

  if(tii<count)
    tii=count;
    finh=h;
    kpairs=fpairs;
  end    
end    

%  Number of Inliers= length(kpairs)
%% Final Homogeneous Matrix
kk=kpairs{1};
x1=kk(1);
y1=kk(2);
x1d=kk(3);
y1d=kk(4);
at=[x1 y1 1 0 0 0 -x1*x1d -y1*x1d -x1d;
    0  0  0 x1 y1 1 -x1*y1d -y1*y1d -y1d];
final_a=at;

for i=2:length(kpairs)
kk=kpairs{i};    
x1=kk(1);
y1=kk(2);
x1d=kk(3);
y1d=kk(4);
frx(i)=x1;
fcx(i)=y1;
frrx(i)=x1d;
fccx(i)=y1d;
at=[x1 y1 1 0 0 0 -x1*x1d -y1*x1d -x1d;
    0  0  0 x1 y1 1 -x1*y1d -y1*y1d -y1d];
final_a=[final_a;at];
end

[U,S,V]=svd(final_a);
Htemp=V(:,end);
H1=Htemp(1:3,:);
H2=Htemp(4:6,:);
H3=Htemp(7:9,:);
h_fin=[H1';H2';H3']; 
%% Average residual for the inliers
distance=0;
for  i=1:length(kpairs)
kk=kpairs{i};    
x1=kk(1);
y1=kk(2);
x1d=kk(3);
y1d=kk(4);
rrt=h_fin*[x1 y1 1]';
aax=rrt(1)/rrt(3);
aay=rrt(2)/rrt(3);
d=((aax-x1d).^2)+((aay-y1d).^2)
d=d.^(0.5);
distance=distance+d;
end
%% Displaying inliers
  figure();
  imshow([left,right]);
  for i=2:length(fcx)
  hold on   
  plot([frx(i),frrx(i)+ssi(2)],[fcx(i),fccx(i)],'r','linewidth',1);

  end
%%  Transformation and Stitching of two Images
  h_fin=h_fin./h_fin(3,3);
  tform = maketform('projective',finh');
  [tra,xdata,ydata]=imtransform(left_im,tform);  



xdim  = ssi(2) + abs(int16(xdata(1)));    
ydim  = ssi(1) + abs(int16(ydata(1)));
matrr=zeros(ydim,xdim);
for i=1:ssi(2)
    for j=1:ssi(1)
        matrr(j,i)=right_im(j,i);
    end
end

matrrx=zeros(ydim,xdim);
for i=1:ssi(1)
    for j=1:ssi(2)
        matrrx(i+abs(int16(ydata(1))),j+abs(int16(xdata(1))))=right_im(i,j);
    end
end

[str1 str2]=size(tra);
for i=1:str2
    for j=1:str1
        if(tra(j,i)==0)
           continue;
        end
        if(i<=size(matrrx,1) && j<=size(matrrx,1))
        if(matrrx(j,i)~=0)
          matrrx(j,i)=(matrrx(j,i)+tra(j,i))/2  ;
          continue;
        end    
        end
        matrrx(j,i)=tra(j,i);
    end
end

figure();
imshow(matrrx);
