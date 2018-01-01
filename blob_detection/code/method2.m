im=dir('../data/butterfly.jpg');
f={im.name};
t=imread(f{1});
imagee=t;
t=rgb2gray(t);
t=im2double(t);
n=5;
si=2*ceil(3*2)+1;
h=fspecial('log',[si si],3);
h=h.*((3)^2);
rr(:,:,1)=imfilter(t,h);
k=3;
six(1)=3;

%% Applying filter and downsampling image.
for i=2:n
J = imresize(rr(:,:,i-1), 1/(k^(i-1)), 'bicubic');
six(i)=(k^(i));
J=imfilter(J,h);
b=J.^2;
b = imresize(b,size(t),'bicubic');
rr(:,:,i)=b;
end

tempcell=cell(n,1);
 i2=rr;
 
 %% Performing non max  suppression among individual scales
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
 



%% Performing non max  suppression between different scales

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
 cc=0.05; %%-----------------------> threshold
for i=1:n
 ree{i}=tempcell{i}>cc;
end


%% Finding radius for each circle

    [axx bxx]=find(ree{1});
    for i=1:size(axx)
        sigarray(i,1)=six(1)*sqrt(2);
    end    
    

for j=2:n
    
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

