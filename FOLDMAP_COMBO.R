setwd("~/icSHAPE_Project")

plFolder <- " "
vitroShapeFolder <- " "
vivoShapeFolder <- " "
pname <- " "


loadplfold <- function(shapePath) {
  shape <- read.table(shapePath, 
                      skip = 2,
                      header = FALSE)
  return(shape)
}

loadShapeFile <- function(shapePath) {
  shape <- read.table(shapePath, 
                      sep = "\t",
                      header = FALSE)
  return(shape)
}

plfiles <- list.files(path = plFolder, 
                      all.files = FALSE, 
                      full.names = TRUE,
                      recursive = FALSE)
vitroFiles <- list.files(path = vitroShapeFolder, 
                         all.files = FALSE, 
                         full.names = TRUE,
                         recursive = FALSE)
vivoFiles <- list.files(path = vivoShapeFolder, 
                        all.files = FALSE, 
                        full.names = TRUE,
                        recursive = FALSE)

plTabs <- lapply(plfiles, loadplfold)
vitroShapeTabs <- lapply(vitroFiles, loadShapeFile)
vivoShapeTabs <- lapply(vivoFiles, loadShapeFile)

combineCols <- function(shapeDfs) {
  shape <- data.frame()
  for (item in shapeDfs) {
    shape <- rbind(shape, item$"V2")
  }
  nums <- 1:length(shapeDfs)
  rownames(shape) <- 
    return(shape)
}

plCombine <- combineCols(plTabs)
vitroShape <- combineCols(vitroShapeTabs)
vivoShape <- combineCols(vivoShapeTabs)
#rownames(shape) <- vitroSiteNames
#colnames(shape) <- 1:41

plMatrix <- data.matrix(plCombine)
vitroShapeMatrix <- data.matrix(vitroShape)
vivoShapeMatrix <- data.matrix(vivoShape)
#heatmap(shapeMatrix, Rowv = NA, Colv = NA)
#pheatmap::pheatmap(vitroShapeMatrix, cluster_cols = FALSE, cluster_rows = TRUE, clustering_method = "complete")

plcrosslink <- plMatrix[,26]
write.table(plcrosslink, sep = "\t", file = paste(pname,"_plcrosslink.txt", sep=""), quote = FALSE)

#MEDIAN
plColAvg <- apply(plMatrix, 2, median)
vitroColAvg <- apply(vitroShapeMatrix, 2, median)
vivoColAvg <- apply(vivoShapeMatrix, 2, median)
set.seed(1)
background <- sample(vitroColAvg)

jpeg(file=paste(pname, "plot_median.jpeg", sep = ""), width = 463, height = 463 )
plot(c(0, length(plColAvg)), c(0, 1), type="n", xlab="Position",
     ylab="Unpaired Probability" )

lines(1:length(plColAvg), plColAvg, col = "gray")
lines(1:length(vitroColAvg), vitroColAvg, col = "blue")
lines(1:length(vivoColAvg), vivoColAvg, col = "orange")
title(paste(pname,"Structure Profile - Median"))
legend("topleft", c("RNAplFold", "vitro", "vivo"), col = c("gray", "blue", "orange"), lty=1:2, cex=0.5)
dev.off()

#MEAN
plColAvg <- apply(plMatrix, 2, mean)
vitroColAvg <- apply(vitroShapeMatrix, 2, mean)
vivoColAvg <- apply(vivoShapeMatrix, 2, mean)
set.seed(1)
background <- sample(vitroColAvg)

jpeg(file=paste(pname, "plot_median.jpeg", sep = ""), width = 463, height = 463 )
plot(c(0, length(plColAvg)), c(0, 1), type="n", xlab="Position",
     ylab="Unpaired Probability" )

lines(1:length(plColAvg), plColAvg, col = "gray")
lines(1:length(vitroColAvg), vitroColAvg, col = "blue")
lines(1:length(vivoColAvg), vivoColAvg, col = "orange")
title(paste(pname,"Structure Profile - Mean"))
legend("topleft", c("RNAplFold", "vitro", "vivo"), col = c("gray", "blue", "orange"), lty=1:2, cex=0.5)
dev.off()

