library(fastmatch)
library(keras)
# split data

#train_images <- array(dim=c(n.train.im, 28, 28))
#for (j in 1:n.train.im)  train_images[j,,]  <- train.images.28x28.gray[[rand.samp[j]]]

n <- length(pixelMap)     # num of imgs
set.seed(1)
train <- sample(n,0.8*n)

train_images <- NULL

train_images <- pixelMap[train]
train_emotion <- emotionLabel[train]

test_images <- NULL

test_images <- pixelMap[-train]
test_emotion <- emotionLabel[-train]


#####UP TO HERE, IT'S CORRECT, A1

numTrainImages = length(train_images)
train_final_images <- array(dim=c(numTrainImages, 32, 30))
for (j in 1:numTrainImages)  train_final_images[j,,]  <- train_images[[j]]


numTestImages = length(test_images)
test_final_images <- array(dim=c(numTestImages, 32, 30))
for (j in 1:numTestImages)  test_final_images[j,,]  <- train_images[[j]]


# one hot encoding

train_emotion_onehot <- fmatch(train_emotion, c("angry","happy","neutral","sad"))
test_emotion_onehot <- fmatch(test_emotion, c("angry","happy","neutral","sad"))


train_oneHot <- to_categorical(train_emotion_onehot-1)
test_oneHot <- to_categorical(test_emotion_onehot-1)

