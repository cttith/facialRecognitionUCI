library(keras)
library(fastmatch)
# split data

n <- length(pixelMap)     # num of imgs
set.seed(1)
train <- sample(n,0.8*n)

train_images <- pixelMap[train]
train_emotion <- emotionLabel[train]

test_images <- pixelMap[-train]
test_emotion <- emotionLabel[-train]


# one hot encoding

train_emotion_onehot <- fmatch(train_emotion, c("angry","happy","neutral","sad"))
test_emotion_onehot <- fmatch(test_emotion, c("angry","happy","neutral","sad"))


