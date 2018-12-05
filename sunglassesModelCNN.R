# Model for Sunglasses CNN
use_session_with_seed(1)
sunglasses_hiddenLayersNodes = (499+2)/2

sunglassesModel<-keras_model_sequential()
#configuring the Model
sunglassesModel %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3),padding="same",input_shape=c(128,120,1),activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3), activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3), activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  
  layer_flatten() %>%
  layer_dense(units = sunglasses_hiddenLayersNodes,activation = "relu")  %>%
  
  layer_dense(units = ncol(train_sunglasses_onehot),activation = 'softmax')

compile(sunglassesModel,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')

sunglassesHistory <- fit(sunglassesModel,
                      train_images_CNN, train_sunglasses_onehot,
                      validation_split = 0.2, batch_size=32,
                      epochs = 500,
                      callbacks = list(early_stop))


score <- evaluate(sunglassesModel,
                  test_images_CNN, test_sunglasses_onehot)

cat('Test loss:', score$loss, "\n")
cat('Test accuracy:', score$acc, "\n")