#This file makes ANN models using the whole dataset (no train/test split)
#its a smart idea to use smaller images
library(keras)

totalImages <- length(pixelMap)

#first lets get our images formatted correctly, as 2d arrays
totalImagesANN <- array(dim = c(totalImages, 128, 120))
for(j in 1:totalImages) totalImagesANN[j,,] <- totalImagesANN[[j]]


#one hot encode all labels
allEmotionsOneHot <- to_categorical(
  as.numeric(as.factor(emotionLabel)))

allFacesOneHot <- to_categorical(
  as.numeric(as.factor(nameLabel)))

allSunglassesOneHot <- to_categorical(
  as.numeric(as.factor(sunglassesLabel)))

allPositionsOneHot <- to_categorical(
  as.numeric(as.factor(positionLabel)))


#we will now randomize all of the data since its all in order and will
#otherwise mess with the model whilst being built
set.seed(1)
randomize <- sample(1:totalImages, totalImages)

totalImagesANN = totalImagesANN[randomize,,]
allEmotionsOneHot = allEmotionsOneHot[randomize,]
allFacesOneHot = allFacesOneHot[randomize,]
allSunglassesOneHot = allSunglassesOneHot[randomize,]
allPositionsOneHot = allPositionsOneHot[randomize,]


#get number of hidden layer nodes per model
inputNodes = 128*120

emotionHiddenLayerNodes = (inputNodes + ncol(allEmotionsOneHot))/2
facesHiddenLayerNodes = (inputNodes + ncol(allFacesOneHot))/2
sunglassesHiddenLayerNodes = (inputNodes + ncol(allSunglassesOneHot))/2
positionsHiddenLayerNodes = (inputNodes + ncol(allPositionsOneHot))/2


earlyStop <- callback_early_stopping(monitor = "val_lass",
                                      patience = 20)

#because this is very computationally expensive, we've decreased the
#hidden layer nodes substantially

#we will now build the models


#emotions model
use_session_with_seed(1)
fullEmotionsModel <- keras_model_sequential(layers = list(
  layer_flatten(input_shape = c(128, 120)),
  layer_dense(units = 1000, activation = 'relu'),
  layer_dense(units = ncol(allEmotionsOneHot), activation = 'softmax')
))


compile(fullEmotionsModel,
        optimizer = 'adam',
        loss = 'categorical_crossentropy',
        metrics = 'accuracy')

fullEmotionHistory <- fit(fullEmotionsModel,
                          totalImagesANN, allEmotionsOneHot,
                          validation_split = 0.2, batch_size = 32,
                          early_stop = list(earlyStop),
                          epochs = 200)




#faces model
use_session_with_seed(1)
fullFacesModel <- keras_model_sequential(layers = list(
  layer_flatten(input_shape = c(128, 120)),
  layer_dense(units = 1000, activation = 'relu'),
  layer_dense(units = ncol(allFacesOneHot), activation = 'softmax')
))


compile(fullFacesModel,
        optimizer = 'adam',
        loss = 'categorical_crossentropy',
        metrics = 'accuracy')

fullFacesHistory <- fit(fullFacesModel,
                          totalImagesANN, allFacesOneHot,
                          validation_split = 0.2, batch_size = 32,
                          early_stop = list(earlyStop),
                          epochs = 100)




#sunglasses model
fullSunglassesModel <- keras_model_sequential(layers = list(
  layer_flatten(input_shape = c(128, 120)),
  layer_dense(units = 1000, activation = 'relu'),
  layer_dense(units = ncol(allSunglassesOneHot), activation = 'softmax')
))


compile(fullSunglassesModel,
        optimizer = 'adam',
        loss = 'categorical_crossentropy',
        metrics = 'accuracy')

fullSunglassesHistory <- fit(fullSunglassesModel,
                          totalImagesANN, allSunglassesOneHot,
                          validation_split = 0.2, batch_size = 32,
                          early_stop = list(earlyStop),
                          epochs = 200)




#face position model
fullPositionsModel <- keras_model_sequential(layers = list(
  layer_flatten(input_shape = c(128, 120)),
  layer_dense(units = 1000, activation = 'relu'),
  layer_dense(units = ncol(allPositionsOneHot), activation = 'softmax')
))


compile(fullPositionsModel,
        optimizer = 'adam',
        loss = 'categorical_crossentropy',
        metrics = 'accuracy')

fullPositionHistory <- fit(fullPositionsModel,
                          totalImagesANN, allPositionsOneHot,
                          validation_split = 0.2, batch_size = 32,
                          early_stop = list(earlyStop),
                          epochs = 200)





