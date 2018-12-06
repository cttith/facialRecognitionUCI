#ANN model for detecting whether the person is wearing sunglasses or not

use_session_with_seed(1)
early_stop <- callback_early_stopping(monitor = "val_loss", 
                                      patience = 20)


#(input nodes + output nodes)/2
sunglasses_hiddenLayerNodes = ((128*120)+2)/2


#rerandomize the training images & labels so as to ensure all the images fed
#to the model aren't in an ordered fashion
rand_test = sample(1:499, 499)

temp_train_images_ANN = train_images_ANN[rand_test,,]
temp_train_sunglasses_onehot = train_sunglasses_onehot[rand_test,]


#build the ANN sunglasses model
#setting up our layers
model <- keras_model_sequential(layers=list(
  layer_flatten(input_shape = c(128,120)),
  layer_dense(units=sunglasses_hiddenLayerNodes, activation = 'relu'),
  layer_dense(units = ncol(train_sunglasses_onehot),activation = 'softmax')))

model

compile(model,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')

#fitting the model
sunglassesHistory <- fit(model,
                   train_images_ANN, train_sunglasses_onehot,
                   validation_split = 0.2, batch_size=32,
                   early_stop=list(early_stop),
                   epochs = 200)

#uncomment below to plot the model history 
#plot(emotionHistory, smooth = F)

#get the model score/accuracy against our testing subset
score <- evaluate(model,
                  test_images_ANN, test_sunglasses_onehot)

cat('Test loss:', score$loss, "\n")
cat('Test accuracy:', score$acc, "\n")



