library(qdapRegex)
library(magick)
## Instead of "/home/usdandres/Downloads/" specify your directory,
##  where you downloaded the data.
wd <- getwd()
fullDir = paste(wd,"/scale4Faces/",sep="")
print(fullDir)
all.files <- list.files(path=fullDir)

n.imageIndex = 1
emotionVector <- NULL
positionVector <- NULL
pixelMap <- NULL

for (fileName in all.files){
  currVec = rm_between(fileName, "_", "_", extract=TRUE)
  emotionVector[n.imageIndex] <- currVec[[1]][2]
  positionVector[n.imageIndex] <- currVec[[1]][1]
  
  # pixelMapVal@grey is showing swapped dimensions
  pixelMapVal <- read.pnm(paste(fullDir,fileName,sep=""))
  pixelMap[[n.imageIndex]] <- pixelMapVal@grey
  n.imageIndex <- n.imageIndex + 1
}

