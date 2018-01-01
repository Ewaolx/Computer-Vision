function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    
    wordMap=0;
    %imshow(img);
    xx=100000;
    [fr] = extractFilterResponses(img, filterBank);
    [x]=size(fr);
    fr=reshape(fr,x(1,1)*x(1,2),60);
    a=fr(:,:);
    di=dictionary(:,:);
    di=di';
    di=di(:,:);
    r=pdist2(a,di,'euclidean');
    ar=ones(x(1,1)*x(1,2),1);
    n=x(1,1)*x(1,2);
    for i=1:n
        for j=1:200
             t=r(i,j);
             if(t<xx)
              xx=t;
              ar(i)=j; 
             end
        end
            xx=100000;
    end   
    
     ar=reshape(ar,x(1,1),x(1,2));
     %imagesc(ar);
     wordMap=ar;
     imagesc(wordMap);
     
end
