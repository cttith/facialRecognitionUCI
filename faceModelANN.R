# Model for Face ANN

# SETTING UP LAYERS
use_session_with_seed(1)
early_stop <- callback_early_stopping(monitor = "val_loss", 
                                      patience = 20)
Face_hiddenLayerNodes = ((128*120)+2)/2




rand_test = sample(1:499, 499)

temp_train_images_ANN = train_images_ANN[rand_test,,]
temp_train_faces_onehot = train_faces_onehot[rand_test,]


model <- keras_model_sequential(layers=list(
  layer_flatten(input_shape = c(128,120)),
  layer_dense(units=Face_hiddenLayerNodes, activation = 'relu'),    # not sure about hidden layer unit size yet
  layer_dense(units = ncol(train_faces_onehot),activation = 'softmax')))

model

compile(model,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')

# Fitting model
faceHistory <- fit(model,
                   train_images_ANN, train_faces_onehot,
                   validation_split = 0.2, batch_size=32,
                   early_stop=list(early_stop),
                   epochs = 20)


score <- evaluate(model,
                  test_images_ANN, test_faces_onehot)

cat('Test loss:', score$loss, "\n")
cat('Test accuracy:', score$acc, "\n")



