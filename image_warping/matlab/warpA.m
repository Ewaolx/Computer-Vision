function [ warp_im ] = warpA( im, A, out_size )
warp_im=0;
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.
% INPUTS:
%   im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%   warp_im : result of warping im by A
p=0;
t1=0;
t2=0;
r=zeros(out_size(1,1),out_size(1,2));
t=0;
r=0;
%  for i=1:out_size(1,2)
%    for j=1:out_size(1,1)
%     t=[i j 1]';    
%     %disp(A*t);
%     x=(A*t);
%     a=round(x(1,1));
%     b=round(x(2,1));
%     disp(a);
%     disp(b);
%     if(a<=0)
%        %x(1,1)=1; 
%        continue;
%     end    
%     if((b<=0))
%        %x(2,1)=1; 
%        continue;
%     end
%     if(b>200)  
%       continue;
%     end
%     if(a>150)
%        continue;
%     end
%       r(b,a)=im(j,i);
%       if(b<=149 && a<=199)
%        r(b+1,a)=im(j,i);
%        r(b,a+1)=im(j,i);
%        r(b+1,a+1)=im(j,i);
%       end
%       if(a>=2 && b>=2)
%        r(b-1,a)=im(j,i);
%        r(b,a-1)=im(j,i);
%        r(b-1,a-1)=im(j,i);
%       end
%    end      
%  end
%---------------------------------------------------------------------
for i=1:out_size(1,2)
   for j=1:out_size(1,1)
    t=[i j 1]';    
    x=(inv(A)*t);
    a=round(x(1,1));
    b=round(x(2,1));
    %disp(a);
    %disp(b);
    if(a<=0)
       %x(1,1)=1; 
       continue;
    end    
    if((b<=0))
       %x(2,1)=1; 
       continue;
    end
    if(b>200)  
      continue;
    end
    if(a>150)
       continue;
    end
      r(j,i)=im(b,a);
   end      
 end

%disp(size(r));
%figure();
%imshow(r);
warp_im=r;
end
