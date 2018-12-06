# Model for Faces CNN
use_session_with_seed(1)
Face_hiddenLayerNodes = (499+20)/2


faceModel<-keras_model_sequential()
#configuring the Model
faceModel %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3),padding="same",input_shape=c(128,120,1),activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3), activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  layer_conv_2d(filter=32,kernel_size=c(3,3), activation = "relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  
  
  layer_flatten() %>%
  layer_dense(units = Face_hiddenLayerNodes,activation = "relu")  %>%
  
  layer_dense(units = ncol(train_faces_onehot),activation = 'softmax')


compile(faceModel,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')

faceHistory <- fit(model,
                    train_images_CNN, train_faces_onehot,
                    validation_split = 0.2, batch_size=32,
                    epochs = 500,
                    callbacks = list(early_stop))


score <- evaluate(faceModel,
                  test_images_CNN, test_faces_onehot)
  
cat('Test loss:', score$loss, "\n")
cat('Test accuracy:', score$acc, "\n")