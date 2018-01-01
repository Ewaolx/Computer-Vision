function [ d ] = residue( matches,f);
distance=0;
for i=1:size(matches,1)
x1=matches(i,1);
y1=matches(i,2);
x1d=matches(i,3);
y1d=matches(i,4);    
lin=f*[x1 y1 1]';
lind=(f')*[x1d y1d 1]';
dstr1=abs((lin(1)*x1d)+(lin(2)*y1d)+lin(3))/(((lin(1).^2)+(lin(2).^2)).^0.5);
dstr2=abs((lind(1)*x1)+(lind(2)*y1)+lind(3))/(((lind(1).^2)+(lind(2).^2)).^0.5);
dstr=(dstr1.^2)+(dstr2.^2);
distance=distance+dstr;

end

d=distance/size(matches,1);
end

