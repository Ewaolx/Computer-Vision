
left_im = imread('house1.jpg');
right_im = imread('house2.jpg');
m = load('house_matches.txt');
N = size(m,1);
[fund]=fit_fundamental(m);
figure();

L = (fund * [m(:,1:2) ones(N,1)]')'; % transform points from 
% the first image to get epipolar lines in the second image

% find points on epipolar lines L closest to matches(:,3:4)
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
pt_line_dist = sum(L .* [m(:,3:4) ones(N,1)],2);
closest_pt = m(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);

% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

% display points and segments of corresponding epipolar lines
clf;
imshow(right_im); hold on;
plot(m(:,3), m(:,4), '+r');
line([m(:,3) closest_pt(:,1)]', [m(:,4) closest_pt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');

%% Unnormalized Mean Squared Geometric Distance between point and epipolar lines

distancee=residue(m,fund);


%% Normalized Mean Squared Geometric Distance between point and epipolar lines
   [m_norm Tr Tl]=normalize(m);
   [fundx]=fit_fundamental(m_norm);
   fundx=fundx'
   fundx=Tr'*fundx*Tl;
   dist_norm=residue(m_norm,fundx);

figure();   
L = (fundx * [m(:,1:2) ones(N,1)]')'; % transform points from 
% the first image to get epipolar lines in the second image

% find points on epipolar lines L closest to matches(:,3:4)
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
pt_line_dist = sum(L .* [m(:,3:4) ones(N,1)],2);
closest_pt = m(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);

% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

% display points and segments of corresponding epipolar lines
clf;
imshow(right_im); hold on;
plot(m(:,3), m(:,4), '+r');
line([m(:,3) closest_pt(:,1)]', [m(:,4) closest_pt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');
%% Ransack from PART 1
right=right_im;
ssi=size(right);
left=left_im;
left_im=rgb2gray(left_im);
right_im=rgb2gray(right_im);
left_im=im2double(left_im);
right_im=im2double(right_im);
thres_harris=0.02;
sigma=2;
window=11;
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
 rts=(diss<5);
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

%  figure();
%  imshow([left,right]);
%  for i=1:length(fc)
%  hold on   
%   plot([fr(i),frr(i)+ssi(2)],[fc(i),fcc(i)],'r','linewidth',1);
%  end
 
%% Homogeneous Matrix- Ransack 
n=10000;
tii=0;
be=1;
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
thr=0.0033;
ff=1;


for i=1:length(pairs)
    aptl=pairs{1,i}{1,1};
    aptr=pairs{1,i}{1,2};
    rr=h*[aptl(1) aptl(2) 1]';
    
      rrx=int16(rr(1)/rr(3));
      rry=int16(rr(2)/rr(3));
      rrt=((rrx-aptr(1)).^2) + ((rry-aptr(2)).^2);
      if(rrt<=250)
            count=count+1;
            fpairs{ff}=[aptl,aptr];
            ff=ff+1;
      end
end

  if(tii<count)
    tii=count;
    finh=h;
    kpairs=fpairs;
    bey{be}=fpairs;
    be=be+1;
  end    
end    


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

%% Fitting Fundamental Matrix
%mm=kpairs{1};
for  i=1:length(kpairs)
    mm=kpairs{i};
    mss(i,1)=mm(1);
    mss(i,2)=mm(2);
    mss(i,3)=mm(3);
    mss(i,4)=mm(4);
end

 [m_norm_without_gt Tr Tl]=normalize(mss);
    
   [fundd]=fit_fundamental(m_norm_without_gt);
   fundd=fundd';
   fundd=Tr'*fundd*Tl;
 %% Residual for Normalized estimation without ground truth matches[Using Ransac]   
   dist_norm_without_gt=residue(m_norm_without_gt,fundd);
   
 %% Displaying Result
 
   N=size(m_norm_without_gt,1);
   m_norm_without_gt=mss;

figure();
L = (fundd * [m_norm_without_gt(:,1:2) ones(N,1)]')'; % transform points from 
% the first image to get epipolar lines in the second image

% find points on epipolar lines L closest to matches(:,3:4)
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
pt_line_dist = sum(L .* [m_norm_without_gt(:,3:4) ones(N,1)],2);
closest_pt = m_norm_without_gt(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);

% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

% display points and segments of corresponding epipolar lines
clf;
imshow(right_im); hold on;
plot(m_norm_without_gt(:,3), m_norm_without_gt(:,4), '+r');
line([m_norm_without_gt(:,3) closest_pt(:,1)]', [m_norm_without_gt(:,4) closest_pt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');



