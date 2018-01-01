function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
%[h] = getImageFeatures(wordMap, dictionarySize);
h=0;


[w]=size(wordMap);
a=w(1,1)/2;  
b=w(1,2)/2;
w1=wordMap(1:a,1:b);
w2=wordMap(1:a,b+1:w(1,2));
w3=wordMap(a+1:w(1,1),1:b);
w4=wordMap(a+1:w(1,1),b+1:w(1,2));

[w]=size(w1);
a=w(1,1)/2;  
b=w(1,2)/2;
w11=w1(1:a,1:b);
w12=w1(1:a,b+1:w(1,2));
w13=w1(a+1:w(1,1),1:b);
w14=w1(a+1:w(1,1),b+1:w(1,2));

[w]=size(w2);
a=w(1,1)/2;  
b=w(1,2)/2;
w21=w2(1:a,1:b);
w22=w2(1:a,b+1:w(1,2));
w23=w2(a+1:w(1,1),1:b);
w24=w2(a+1:w(1,1),b+1:w(1,2));

[w]=size(w3);
a=w(1,1)/2;  
b=w(1,2)/2;
w31=w3(1:a,1:b);
w32=w3(1:a,b+1:w(1,2));
w33=w3(a+1:w(1,1),1:b);
w34=w3(a+1:w(1,1),b+1:w(1,2));

[w]=size(w4);
a=w(1,1)/2;  
b=w(1,2)/2;
%disp(a);
%disp(b);
w41=w4(1:a,1:b);
w42=w4(1:a,b+1:w(1,2));
w43=w4(a+1:w(1,1),1:b);
w44=w4(a+1:w(1,1),b+1:w(1,2));
[w]=size(w41);

[h1] = getImageFeatures(w11,dictionarySize);
[h2] = getImageFeatures(w12,dictionarySize);
so=size(h1);
h1((so(1,1)+1):so(1,1)+so(1,1),1)=h2;
  %disp(size(h1));
[h2] = getImageFeatures(w13,dictionarySize);
s=size(h1);
%disp(s);
%disp(size(h2));
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w14,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w21,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w22,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w23,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w24,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w31,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w32,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w33,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w34,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w41,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w42,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w43,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
[h2] = getImageFeatures(w44,dictionarySize);
s=size(h1);
h1((s(1,1)+1):s(1,1)+(so(1,1)),1)=h2;
l2=h1;
%disp(sum(h1));
% hist(l2);

[p1] = getImageFeatures(w1,dictionarySize);
[p2] = getImageFeatures(w2,dictionarySize);
s=size(p1);
p1((s(1,1)+1):s(1,1)+(so(1,1)),1)=p2;
[p2] = getImageFeatures(w3,dictionarySize);
s=size(p1);
p1((s(1,1)+1):s(1,1)+(so(1,1)),1)=p2;
[p2] = getImageFeatures(w4,dictionarySize);
s=size(p1);
p1((s(1,1)+1):s(1,1)+(so(1,1)),1)=p2;
l1=p1;
 

[o] = getImageFeatures(wordMap,dictionarySize);

 l0=o;
 
 l0=l0*(1/4);
 l1=l1*(1/4);
 l2=l2*(1/2);

 l=cat(1,l0,l1,l2);
 l=l./sum(l);

 h=l;


end