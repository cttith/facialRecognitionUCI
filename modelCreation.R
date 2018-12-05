# SETTING UP LAYERS

early_stop <- callback_early_stopping(monitor = "val_loss", 
                                      patience = 20)
face_hiddenLayerNodes = (499+20)/2


model <- keras_model_sequential(layers=list(
  layer_flatten(input_shape = c(128,120)),
  layer_dense(units=face_hiddenLayerNodes, activation = 'relu'),    # not sure about hidden layer unit size yet
  layer_dense(units = ncol(train_face_onehot),activation = 'softmax')))

model

compile(model,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')

# Fitting model
faceHistory <- fit(model,
                   train_final_images, train_face_onehot,
                   validation_split = 0.2, batch_size=32,
                   early_stop=list(early_stop),
                   epochs = 20)


score <- evaluate(model,
                  test_final_images, test_face_onehot)

cat('Test loss:', score$loss, "\n")
cat('Test accuracy:', score$acc, "\n")




############## [ IGNORE BELOW FOR NOW] ##################

########### SETTING UP NEW MODEL   
model<-keras_model_sequential()
#configuring the Model
model %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3),padding="same",input_shape=c(128,120,1),activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3), activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3), activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3), activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3), activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_flatten() %>%
  layer_dense(units = 4,activation = "softmax") 






compile(model,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')

modelHistory <- fit(model,
                    train_images_new_model, train_oneHot,
                    validation_split = 0.2, batch_size=32,
                    epochs = 500,
                    callbacks = list(early_stop))


score <- evaluate(model,
                  test_final_images_new_model, test_oneHot)
