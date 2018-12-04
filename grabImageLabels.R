library(qdapRegex)
library(pixmap)
library(magick)

wd <- getwd()
fullDir = paste(wd,"/scale2Faces/",sep="")
print(fullDir)
all.files <- list.files(path=fullDir)

n.imageIndex = 1
emotionLabel <- NULL
positionLabel <- NULL
pixelMap <- NULL
images <- NULL

for (fileName in all.files){
  currVec = rm_between(fileName, "_", "_", extract=TRUE)
  emotionLabel[n.imageIndex] <- currVec[[1]][2]
  positionLabel[n.imageIndex] <- currVec[[1]][1]
  
  magickObj <- image_read(paste(fullDir,fileName,sep=""))         # use magick to read pgm extension
  cimgObj <- magick2cimg(magickObj)                       # convert magick to cimg, for functionality
  
  pixelMap[[n.imageIndex]] <- cimgObj
  n.imageIndex <- n.imageIndex + 1
}

# bdf flattens to data.frame (list) ; pixelMap[[1]] is a multi-dimensional list
#bdf <- as.data.frame(pixelMap[[1]])
#typeof(bdf)
typeof(pixelMap)






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



