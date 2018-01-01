function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.
    
	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    layernum=3;
    [x]=size(dictionary);
    dictionarySize=x(1,2);
    for i=1:1349
     t=train_imagenames(i);
     t=string(t);
     t=strrep(t,'.jpg','.mat');
     xs(i)=load(t);
    end

    [ro] = getImageFeaturesSPM(layernum,xs(1).wordMap, dictionarySize);
  
  for i=2:1349
     [re] = getImageFeaturesSPM(layernum,xs(i).wordMap, dictionarySize);
     ro=cat(2,ro,re);
  end 
  disp(size(ro));
  train_features=ro;
  load('../data/traintest.mat','train_labels');
  

	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end