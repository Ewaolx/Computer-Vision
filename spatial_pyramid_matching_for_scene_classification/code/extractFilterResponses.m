function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses

% TODO Implement your code here
filterResponses=0;
s=size(img);
[a b cc]=size(img);
        if (cc==1)
           img=cat(3,img,img,img); 
        end   
%disp(s);
img=im2double(img);
% [im a b]=RGB2Lab(img(:,:,1),img(:,:,2),img(:,:,3));
% im=cat(3,im,a,b);
im=RGB2Lab(img);
%imshow(im);
[s]=size(im);
for i=1:20
    te(:,:,(3*i-2):3*i)=imfilter(im,filterBank{i,1});
    re{i}=imfilter(im,filterBank{i,1});
end

 %y=cat(4,t);
 y=cat(4,re{1},re{2},re{3},re{4},re{5},re{6},re{7},re{8},re{9},re{10},re{11},re{12},re{13},re{14},re{15},re{16},re{17},re{18},re{19},re{20});
 %montage(y,'Size',[4 5]);
 %saveas(gcf,'monnta.png');
 %disp(size(re));
 %figure();
 %imshow(re{20});
 filterResponses=te;
%montage(cat(20,re{:}));
end
