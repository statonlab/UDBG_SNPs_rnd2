library(ggplot2)

# new UDBG (unpooled)
setwd("/lustre/projects/staton/projects/Brosnan/UDBG_SNPs_rnd2/analysis/11_MDSplot")

# plink.mds with the first line removed
mdsData <- as.matrix(read.table("plink_alter.mds"))

# store important data into variables
x<-as.numeric(mdsData[,4])
y<-as.numeric(mdsData[,5])
z<-as.numeric(mdsData[,6])
h<-as.numeric(mdsData[,7])
raw<-strsplit(mdsData[,1], ":")
label <-lapply(raw, '[[', 1)
label$name <-lapply(raw, '[[', 1)

# set up colors
label$color[grep("TW",label$name)] = "red"
label$color[grep("CH",label$name)] = "darkorchid"
label$color[grep("TG",label$name)] = "blue"
label$color[grep("TE",label$name)] = "aquamarine2"
label$color[grep("TD",label$name)] = "darkorange"
label$color[grep("TB",label$name)] = "cyan"
label$color[grep("TA",label$name)] = "purple"
label$color[grep("S",label$name)] = "black"
label$color[grep("DA",label$name)] = "black"
label$color[grep("DT",label$name)] = "black"
label$color[grep("MV",label$name)] = "darkolivegreen4"

# generate plot
tiff("MDS_Cmp12_01.tiff", width = 4, height = 4, units = 'in', res = 300)
# draw plot
par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
plot(x,y,col= "white", pch = 19, cex = 0.4, lty = "solid", lwd = 2, xlim = c(-0.1,0.4), ylim = c(-0.2,0.12),
     xlab="MDS Component 1", ylab="MDS Component 2",cex.lab=0.75,cex.axis=0.4)
# create legend
text(x,y,label$name,cex=0.4,col=label$color)
legend("topright",inset=c(-0.2,0), legend=c("TW","CH","TG","TE","TD","TB","TA","MV","S","DA","DT"), 
       text.col=c("red","darkorchid","blue","aquamarine2","darkorange","cyan","purple","darkolivegreen4","black","black","black"), 
       title="Cultivar", title.col="black", cex=0.4, pch = c(1,1))
# draw and label rectangle to indicate zoomed-in cluster
rect(xleft=-0.09,ybottom=0.009,xright=-0.02,ytop=0.029)
text(x=0,y=0.03,"*",col="black")
dev.off()

# generate plot
tiff("MDS_Cmp34_02.tiff", width = 4, height = 4, units = 'in', res = 300)
# draw plot
par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
plot(z,h,col= "white", pch = 19, cex = 0.4, lty = "solid", lwd = 2, xlim = c(-0.15,0.15), ylim = c(-0.12,0.16),
     xlab="MDS Component 3", ylab="MDS Component 4",cex.lab=0.75,cex.axis=0.4)
# create legend
text(z,h,label$name,cex=0.4,col=label$color)
legend("topright",inset=c(-0.2,0), legend=c("TW","CH","TG","TE","TD","TB","TA","MV","S","DA","DT"), 
       text.col=c("red","darkorchid","blue","aquamarine2","darkorange","cyan","purple","darkolivegreen4","black","black","black"), 
       title="Cultivar", title.col="black", cex=0.4, pch = c(1,1))
# draw and label rectangle to indicate zoomed-in cluster
rect(xleft=-0.032,ybottom=-0.009,xright=0.02,ytop=0.01)
text(x=0.025,y=0.015,"*",col="black")
dev.off()


# zoom in on cluster
tiff("MDS_zoom_01.tiff", width = 4, height = 4, units = 'in', res = 300)
par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
plot(x,y,col= "white", pch = 19, cex = 0.4, lty = "solid", lwd = 2, xlim = c(-0.071,-0.0439), ylim = c(0.015,0.023),
     xlab="MDS Component 1", ylab="MDS Component 2",cex.lab=0.75,cex.axis=0.4)
text(x,y,label$name,cex=0.4,col=label$color)
legend("topright",inset=c(-0.2,0), legend=c("TW","CH","TG","TE","TD","TB","TA","MV","S","DA","DT"), 
       text.col=c("red","darkorchid","blue","aquamarine2","darkorange","cyan","purple","darkolivegreen4","black","black","black"), 
       title="Cultivar", title.col="black", cex=0.4, pch = c(1,1))
dev.off()

# zoom in on cluster
tiff("MDS_zoom_02.tiff", width = 4, height = 4, units = 'in', res = 300)
par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
plot(z,h,col= "white", pch = 19, cex = 0.4, lty = "solid", lwd = 2, xlim = c(-0.018,0.011), ylim = c(-0.0034,0.0082),
     xlab="MDS Component 3", ylab="MDS Component 4",cex.lab=0.75,cex.axis=0.4)
text(z,h,label$name,cex=0.4,col=label$color)
legend("topright",inset=c(-0.2,0), legend=c("TW","CH","TG","TE","TD","TB","TA","MV","S","DA","DT"), 
       text.col=c("red","darkorchid","blue","aquamarine2","darkorange","cyan","purple","darkolivegreen4","black","black","black"), 
       title="Cultivar", title.col="black", cex=0.4, pch = c(1,1))
dev.off()
