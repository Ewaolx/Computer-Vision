[filterBank]= createFilterBank();
% Get list of all BMP files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.


% currentimage=0;
% imagefiles = dir('../data/ice_skating/sun_advbapyfkehgemjf.jpg');      
% nfiles = length(imagefiles);    % Number of files found
% images=zeros(200,1);
% for ii=1:1
%    %currentfilename = imagefiles(ii).name;
%    currentimage = imread('../data/ice_skating/sun_advbapyfkehgemjf.jpg');
%    
%    %disp(res);
%    %images(ii,1) = currentimage;
%    
% end

imagefiles = dir('../data/art_gallery/*.jpg');      
fn={imagefiles.name}; 
imagefiles = dir('../data/computer_room/*.jpg');
bn={imagefiles.name};
fn=[fn , bn];
imagefiles = dir('../data/garden/*.jpg');
bn={imagefiles.name};
fn=[fn , bn];
imagefiles = dir('../data/ice_skating/*.jpg');
 bn={imagefiles.name};
 fn=[fn , bn];
imagefiles = dir('../data/library/*.jpg');
bn={imagefiles.name};
fn=[fn , bn];
imagefiles = dir('../data/mountain/*.jpg');
bn={imagefiles.name};
fn=[fn , bn];
imagefiles = dir('../data/ocean/*.jpg');
bn={imagefiles.name};
fn=[fn, bn];
imagefiles = dir('../data/tennis_court/*.jpg');
bn={imagefiles.name};
fn=[fn , bn];
%disp(length(fn));
%[f dic]=getFilterBankAndDictionary(fn);
%computeDictionary();
[x]=size(dictionary);
dictionarySize=x(1,2);
%batchToVisualWords(2);
layernum=3;
% [h] = getImageFeaturesSPM(layernum,wordMap, dictionarySize);
% w1=imread(fn{1});
% w2=imread(fn{2});
% w3=imread(fn{3});
% [w1]=getVisualWords(w1,filterBank,dictionary);
% [w2]=getVisualWords(w2,filterBank,dictionary);
% [w3]=getVisualWords(w3,filterBank,dictionary);
% [w1] = getImageFeaturesSPM(layernum,w1, dictionarySize);
% [w2] = getImageFeaturesSPM(layernum,w2, dictionarySize);
% [w3] = getImageFeaturesSPM(layernum,w3, dictionarySize);
%w=cat(2,w1,w2,w3);

 %histInter = distanceToSet(h, w);
%  wordfiles = dir('../data/art_gallery/*.mat');       
%  wf={wordfiles.name};
%  wordfiles = dir('../data/computer_room/*.jpg');
% bn={wordfiles.name};
% wf=[wf , bn];
% wordfiles = dir('../data/garden/*.jpg');
% bn={wordfiles.name};
% wf=[wf , bn];
% wordfiles = dir('../data/ice_skating/*.jpg');
%  bn={wordfiles.name};
%  wf=[wf , bn];
% wordfiles = dir('../data/library/*.jpg');
% bn={wordfiles.name};
% wf=[wf , bn];
% wordfiles = dir('../data/mountain/*.jpg');
% bn={wordfiles.name};
% wf=[wf , bn];
% wordfiles = dir('../data/ocean/*.jpg');
% bn={wordfiles.name};
% wf=[wf, bn];
% wordfiles = dir('../data/tennis_court/*.jpg');
% bn={wordfiles.name};
% wf=[wf , bn];
% disp(size(wf));

% tt=train_labels;
%      train_labels=num2cell(train_labels);
%      if(train_labels(2)==2)
%          disp(as);
%      end
%      rr=(mapping(1));
%      train_labels(1)= (rr);
%
%gg(160,160)=0;
%  for i=1:160
%   t=test_imagenames(i);
%   t=char(t);
%   [x]=size(t);
%   tp(i,1:x(1,2))=t(1,:);
%   g=guessImage(t);
%   [x]=size(g);
%   gg(i,1:x(1,2))=g(1,:);
%  end
cellfind = @(string)(@(cell_contents)(strcmp(string,cell_contents)));
%    for i=1:160
%    t=test_imagenames(i);
%    t=char(t);
%    idy(i)=test_labels(i);
%    g=guessImage(t);
%    idx=cellfun(cellfind(g),mapping);
%    idx=find(idx==1);
%    idxx(i)=idx;
%    disp(idx);
%    end
%    [C,order] = confusionmat(idy,idxx);
%      acc=trace(C)/sum(C(:));
     %evaluateRecognitionSystem();

%guessImage(test_imagenames{85});
%[coo]=evaluateRecognitionSystem();
checkA1Submission('50247214');
imas = dir('../data/ice_skating/sun_advbapyfkehgemjf.jpg');      
fnxs={imas.name}; 
fnxs=imread(fnxs{1});
%imshow(fnxs);
%[fnse]=extractFilterResponses(fnxs,filterBank);
   %idx = find(ismember([mapping{:}],'mountain'));
%buildRecognitionSystem();
 %imagesc(xs.wordMap);
%  aa=wf{1};
%  t=load(aa);
%  w=t.wordMap;
%  [re] = getImageFeaturesSPM(layernum,w, dictionarySize);
%  hist(re);
%  
%  for i=2:3
%   aa=wf{i};
%   t=load(aa);
%   w=t.wordMap;
%   [ro] = getImageFeaturesSPM(layernum,w, dictionarySize);
%   re=cat(2,re,ro); 
%  end
%  disp(size(re));
