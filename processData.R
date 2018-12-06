library(keras)

n <- length(pixelMap) #number of images
set.seed(1)

#random 80/20 split for training & testing data
train <- sample(n, 0.8*n)

#get the subset of pictures we'll use for training, as well as their respective labels for
#every every response variable
train_images <- pixelMap[train]
train_emotions <- emotionLabel[train]
train_faces <- nameLabel[train]
train_positions <- positionLabel[train]
train_sunglasses <- sunglassesLabel[train]


#get the subset of pictures we'll use for testing, as well as their respective labels for
#every every response variable
test_images <- pixelMap[-train]
test_emotions <- emotionLabel[-train]
test_faces <- nameLabel[-train]
test_positions <- positionLabel[-train]
test_sunglasses <- sunglassesLabel[-train]


numTrainImages = length(train_images)
numTestImages = length(test_images)

#Training/Testing images used for CNN (as CNN requires 4 dimensions)
train_images_CNN <- array(dim = c(numTrainImages, 128, 120,1))
for( j in 1:numTrainImages) train_images_CNN[j,,,] <- train_images[[j]]

test_images_CNN <- array(dim = c(numTestImages, 128, 120,1))
for (j in 1:numTestImages) test_images_CNN[j,,,]  <- test_images[[j]]


#Training/Testing images used for ANN (as ANN requires 3 dimensions)
train_images_ANN <- array(dim = c(numTrainImages, 128, 120))
for (j in 1:numTrainImages) train_images_ANN[j,,]  <- train_images[[j]]

test_images_ANN <- array(dim = c(numTestImages, 128, 120))
for (j in 1:numTestImages) test_images_ANN[j,,]  <- test_images[[j]]



#One hot encoding our training/testing response labels (variables)
train_emotions_onehot <- to_categorical(as.numeric(as.factor(train_emotions))-1)
train_positions_onehot <- to_categorical(as.numeric(as.factor(train_positions))-1)
train_sunglasses_onehot <- to_categorical(as.numeric(as.factor(train_sunglasses))-1)
train_faces_onehot <- to_categorical(as.numeric(as.factor(train_faces))-1)

test_emotions_onehot <- to_categorical(as.numeric(as.factor(test_emotions))-1)
test_positions_onehot <- to_categorical(as.numeric(as.factor(test_positions))-1)
test_sunglasses_onehot <- to_categorical(as.numeric(as.factor(test_sunglasses))-1)
test_faces_onehot <- to_categorical(as.numeric(as.factor(test_faces))-1)

