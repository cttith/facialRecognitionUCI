# Model for Emotion ANN

# SETTING UP LAYERS

early_stop <- callback_early_stopping(monitor = "val_loss", 
                                      patience = 20)
Emotion_hiddenLayerNodes = (499+4)/2


model <- keras_model_sequential(layers=list(
  layer_flatten(input_shape = c(128,120)),
  layer_dense(units=Emotion_hiddenLayerNodes, activation = 'relu'),    # not sure about hidden layer unit size yet
  layer_dense(units = ncol(train_emotions_onehot),activation = 'softmax')))

model

compile(model,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')

# Fitting model
emotionHistory <- fit(model,
                   train_images_ANN, train_emotions_onehot,
                   validation_split = 0.2, batch_size=32,
                   early_stop=list(early_stop),
                   epochs = 200)


score <- evaluate(model,
                  test_images_ANN, test_emotions_onehot)

cat('Test loss:', score$loss, "\n")
cat('Test accuracy:', score$acc, "\n")



