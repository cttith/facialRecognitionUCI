# SETTING UP LAYERS
library(keras)

emotionModel <- keras_model_sequential(layers=list(
                layer_flatten(input_shape = c(32,30)),
                layer_dense(units=499/2, activation = 'relu'),    # not sure about hidden layer unit size yet
                layer_dense(units = length(train_emotion_onehot),activation = 'softmax')))
                
emotionModel

compile(emotionModel,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')

# Fitting model
emotionHistory <- fit(emotionModel,
                      train_images,
                      train_emotion_onehot,
                      validation_split = 0.2, batch_size=32,
                      epochs = 500)



