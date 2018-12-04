library(qdapRegex)
library(pixmap)
library(magick)

wd <- getwd()
fullDir = paste(wd,"/scale4Faces/",sep="")
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
  
  magickObj <- image_read(paste(fullDir,fileName,sep=""))
  cimgObj <- magick2cimg(magickObj)
  
  pixelMap[[n.imageIndex]] <- cimgObj
  n.imageIndex <- n.imageIndex + 1
}


# # create magick object (needed to read pgm extension)
# testImagepath = paste(fullDir,"an2i_left_angry_open_4.pgm",sep="")
# parrots <- image_read(testImagepath)
# bitmap <- parrots[[1]]
# parrots
# 
# # convert magick to cimg to work with professor's code/ more functionality https://cran.r-project.org/web/packages/imager/vignettes/gettingstarted.html
# cimg <- magick2cimg(parrots)
# # plot image
# plot(cimg)
# bdf <- as.data.frame(cimg)  #960 Obs = 32*30
# 





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



