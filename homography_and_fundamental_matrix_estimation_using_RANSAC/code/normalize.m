function [ n,T_left,T_right ] = normalize(m)
%Finds the normalization of provided matches.
%   
N=size(m,1);
 mx=max(m);
   %mx=mx.^2;
   st=mean(m);
   T_left=[1/mx(1) 0        -(st(1)/mx(1));
           0       1/mx(2)  -(st(2)/mx(2));
           0       0          1           ];
   T_right=[1/mx(3) 0        -(st(3)/mx(3));
           0       1/mx(4)  -(st(4)/mx(4));
           0       0          1           ];    
    for i=1:N
     x1=m(i,1);
     y1=m(i,2);
     x1d=m(i,3);
     y1d=m(i,4);
     xxx=T_left*[x1 y1 1]';
     m_norm(i,1)=xxx(1);
     m_norm(i,2)=xxx(2);   
     xxx=T_right*[x1d y1d 1]';
     m_norm(i,3)=xxx(1);
     m_norm(i,4)=xxx(2);
    end 
n=m_norm;
end

