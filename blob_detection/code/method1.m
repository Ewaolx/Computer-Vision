im=dir('../data/butterfly.jpg');
f={im.name};
t=imread(f{1});
imagee=t;
t=rgb2gray(t);
t=im2double(t);
sigma=1.5;
n=10;
ce=cell(n,1);
k=1.44;

%% Applying filter among different scales.
for i=1:n
    sigma=sigma*k;
    si=2*ceil(3*sigma)+1;
    six(i)=sigma; 
    ss=zeros(si,si,1);
    h = fspecial('log',si,sigma);
    ss(:,:,1)=h;
    ss(:,:,1)=ss(:,:,1).*(sigma.^2);
    ce{i}=ss;
end 

 for i=1:n
     rr(:,:,i)=imfilter(t,ce{i});
     rr(:,:,i)=rr(:,:,i).*rr(:,:,i); 
 end

 
 tempcell=cell(n,1);
 i2=rr;
 %%  Performing non max  suppression among individual scales 
 for j=1:n
  i1=i2(:,:,j); 
  zz=colfilt(rr(:,:,j),[3 3],'sliding',@max);
  [t1 t2]=find(zz==i1);
  temp=zeros(size(i1));
  for i=1:size(t1)
     temp(t1(i),t2(i))=i1(t1(i),t2(i));
  end
  tempcell{j}=temp;
 end
 
 [sa sb c]=size(imagee);
 ty=zeros(sa,sb,n);
 for i=1:n
 ty(:,:,i)=tempcell{i};
 end
 



%%  Performing non max  suppression between different scales

for j=1:n
    [ax bx]=find(ty(:,:,j));
    
    if(j==1)
     for i=1:size(ax)
       if(ty(ax(i),bx(i),j)<=ty(ax(i),bx(i),j+1))
           ty(ax(i),bx(i),j)=0;
       end    
     end
     continue;
    end
    if(j==n)
     for i=1:size(ax)
       if(ty(ax(i),bx(i),j)<=ty(ax(i),bx(i),j-1))
           ty(ax(i),bx(i),j)=0;
       end    
     end
     continue;
    end
    for i=1:size(ax)
       if(ty(ax(i),bx(i),j)<=ty(ax(i),bx(i),j-1))
           ty(ax(i),bx(i),j)=0;
       end    
    end
    for i=1:size(ax)
       if(ty(ax(i),bx(i),j)<=ty(ax(i),bx(i),j+1))
           ty(ax(i),bx(i),j)=0;
       end    
    end
end    
 
%% Applying threshold
for i=1:n
 tempcell{i}=ty(:,:,i);
end

 tempcell2=cell(n,1);
 cc=0.046; %%-------------------------------->  Threshold
for i=1:n
 ree{i}=tempcell{i}>cc;
end

%%  Finding radius for each circle

    [axx bxx]=find(ree{1});
    for i=1:size(axx)
        sigarray(i,1)=six(1)*sqrt(2);
    end    
    

for j=2:n-1
    
    [cxx dxx]=find(ree{j});
     axx=[axx;cxx];
     bxx=[bxx;dxx];
    
    sigarra=zeros(length(cxx),1);
    for i=1:size(cxx)
        sigarra(i,1)=six(j)*sqrt(2);
    end   
    sigarray=[sigarray;sigarra];
end

show_all_circles(t,bxx,axx(:,1),sigarray);
  