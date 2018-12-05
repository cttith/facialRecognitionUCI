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



########### SETTING UP NEW MODEL
model<-keras_model_sequential()
#configuring the Model
model %>%  
  #defining a 2-D convolution layer
  
  layer_conv_2d(filter=32,kernel_size=c(3,3),padding="same",input_shape=c(32,30,1) ) %>%  
  layer_activation("relu") %>%  
  #another 2-D convolution layer
  
  layer_conv_2d(filter=32 ,kernel_size=c(3,3))  %>%  layer_activation("relu") %>%
  #Defining a Pooling layer which reduces the dimentions of the #features map and reduces the computational complexity of the model
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  #dropout layer to avoid overfitting
  layer_dropout(0.25) %>%
  layer_conv_2d(filter=32 , kernel_size=c(3,3),padding="same") %>% layer_activation("relu") %>%  layer_conv_2d(filter=32,kernel_size=c(3,3) ) %>%  layer_activation("relu") %>%  
  layer_max_pooling_2d(pool_size=c(2,2)) %>%  
  layer_dropout(0.25) %>%
  #flatten the input  
  layer_flatten() %>%  
  layer_dense(512) %>%  
  layer_activation("relu") %>%  
  layer_dropout(0.5) %>%  
  #output layer-10 classes-10 units  
  layer_dense(4) %>%  
  #applying softmax nonlinear activation function to the output layer #to calculate cross-entropy  
  layer_activation("softmax") 
#for computing Probabilities of classes-"logit(log probabilities)


compile(model,
        optimizer ='adam',
        loss='categorical_crossentropy',
        metrics = 'accuracy')
model2 <- fit(model,
                      train_images_new_model, train_oneHot,
                      validation_split = 0.2, batch_size=32,
                      epochs = 500)
