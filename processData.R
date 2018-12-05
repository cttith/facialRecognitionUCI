library(keras)
# split data

#train_images <- array(dim=c(n.train.im, 28, 28))
#for (j in 1:n.train.im)  train_images[j,,]  <- train.images.28x28.gray[[rand.samp[j]]]

n <- length(pixelMap)     # num of imgs
set.seed(1)

train <- sample(n,0.8*n)



train_images <- pixelMap[train]
train_emotions <- emotionLabel[train]
train_faces <- nameLabel[train]
train_positions <- positionLabel[train]
train_sunglasses <- sunglassesLabel[train]

test_images <- pixelMap[-train]
test_emotions <- emotionLabel[-train]
test_faces <- nameLabel[-train]
test_positions <- positionLabel[-train]
test_sunglasses <- sunglassesLabel[-train]

# Train images for CNN (requires 4 dimensions)

numTrainImages = length(train_images)
train_images_CNN <- array(dim=c(numTrainImages, 128, 120,1))
for( j in 1:numTrainImages) train_images_CNN[j,,,] <- train_images[[j]]

numTestImages = length(test_images)
test_images_CNN <- array(dim=c(numTestImages, 128, 120,1))
for (j in 1:numTestImages)  test_images_CNN[j,,,]  <- test_images[[j]]


# Train images for ANN (requires 3 dimensions)

train_images_ANN <- array(dim=c(numTrainImages, 128, 120))
for (j in 1:numTrainImages)  train_images_ANN[j,,]  <- train_images[[j]]


test_images_ANN <- array(dim=c(numTestImages, 128, 120))
for (j in 1:numTestImages)  test_images_ANN[j,,]  <- test_images[[j]]


# one hot encoding 

train_emotions_onehot <- to_categorical(as.numeric(as.factor(train_emotions))-1)
train_positions_onehot <- to_categorical(as.numeric(as.factor(train_positions))-1)
train_sunglasses_onehot <- to_categorical(as.numeric(as.factor(train_sunglasses))-1)
train_faces_onehot <- to_categorical(as.numeric(as.factor(train_faces))-1)

test_emotions_onehot <- to_categorical(as.numeric(as.factor(test_emotions))-1)
test_positions_onehot <- to_categorical(as.numeric(as.factor(test_positions))-1)
test_sunglasses_onehot <- to_categorical(as.numeric(as.factor(test_sunglasses))-1)
test_faces_onehot <- to_categorical(as.numeric(as.factor(test_faces))-1)

