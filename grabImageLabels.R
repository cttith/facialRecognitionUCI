library(qdapRegex)
library(pixmap)
library(magick)
library(imager)


################ [BEFORE RUNNING] GO TO SESSION > SET WORKING DIRECTORY > TO SOURCE FILE LOCATION 

wd <- getwd()

#change the 1 below to either 2 or 4 to change the picture size scales
fullDir = paste(wd,"/scale1Faces/",sep="")
all.files <- list.files(path = fullDir)

n.imageIndex = 1
emotionLabel <- NULL
positionLabel <- NULL
nameLabel <- NULL
pixelMap <- NULL
sunglassesLabel <- NULL


for (fileName in all.files){
  currVec = rm_between(fileName, "_", "_", extract = TRUE) #get the emotion & face position in currVec
  emotionLabel[n.imageIndex] <- currVec[[1]][2]
  positionLabel[n.imageIndex] <- currVec[[1]][1]
  
  nameLabel[n.imageIndex] <-gsub("_.*", "", fileName)
  
  sunglassesSplit <- strsplit(fileName, '_')
  sunglassesVal <- sunglassesSplit[[1]][4]
  sunglassesLabel[n.imageIndex] <- substring(sunglassesVal, 1, nchar(sunglassesVal)-4)
  
  magickObj <- image_read(paste(fullDir, fileName, sep = "")) #use magick to read pgm extension
  cimgObj <- magick2cimg(magickObj)   #convert magick to cimg, for functionality
  
  pixelMap[[n.imageIndex]] <- cimgObj
  n.imageIndex <- n.imageIndex + 1
}


#plot these 4 pictures next to each other
par(mfrow=c(2,2))
plot(pixelMap[[1]],
     main=paste("Size:", dim(pixelMap[[1]])[1],"x", dim(pixelMap[[1]])[2]))
plot(pixelMap[[2]],
     main=paste("Size:", dim(pixelMap[[2]])[1],"x", dim(pixelMap[[2]])[2]))
plot(pixelMap[[3]],
     main=paste("Size:", dim(pixelMap[[3]])[1],"x", dim(pixelMap[[3]])[2]))
plot(pixelMap[[4]],
     main=paste("Size:", dim(pixelMap[[4]])[1],"x", dim(pixelMap[[4]])[2]))
par(mfrow=c(1,1))



