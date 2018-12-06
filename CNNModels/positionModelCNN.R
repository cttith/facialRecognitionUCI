# Model for Position CNN
use_session_with_seed(1)
position_hiddenLayersNodes = (499+4)/2

positionModel<-keras_model_sequential()
#configuring the Model
positionModel %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3),padding="same",input_shape=c(128,120,1),activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3), activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3), activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  
  layer_flatten() %>%
  layer_dense(units = position_hiddenLayersNodes,activation = "relu")  %>%
  
  layer_dense(units = ncol(train_positions_onehot),activation = 'softmax')

compile(positionModel,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')

positionHistory <- fit(positionModel,
                      train_images_CNN, train_positions_onehot,
                      validation_split = 0.2, batch_size=32,
                      epochs = 500,
                      callbacks = list(early_stop))


score <- evaluate(emotionModel,
                  test_images_CNN, test_positions_onehot)

cat('Test loss:', score$loss, "\n")
cat('Test accuracy:', score$acc, "\n")