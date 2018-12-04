# SETTING UP LAYERS
library(keras)

# training_images <- list()
# for(i in (1:length(train_images))) {
#   training_images[[i]] <- train_images[[i]]
# }
# 
# training_images[[1]]



hiddenLayerNodes = (499+4)/2


emotionModel <- keras_model_sequential(layers=list(
                layer_flatten(input_shape = c(32,30)),
                layer_dense(units=hiddenLayerNodes, activation = 'relu'),    # not sure about hidden layer unit size yet
                layer_dense(units = ncol(train_oneHot),activation = 'softmax')))
                
emotionModel

compile(emotionModel,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')





# Fitting model
emotionHistory <- fit(emotionModel,
                      train_final_images, train_oneHot,
                      validation_split = 0.2, batch_size=32,
                      epochs = 500)


score <- evaluate(emotionModel,
                  test_final_images, test_oneHot)
