#library(sm)
# change to your own directory structure
data1 <- read.csv("negatives_craft.txt")
data2 <- read.csv("negatives_mimic2disch.txt")
n_data1 <- data1$neg
n_data2 <- data2$neg
t.test(n_data1,n_data2)
#sm.density.compare(data1, data2)
#hist(data1)
#d <- density(n_data1)
#plot(d)
#data1

d1 <- density(n_data1, n=128)
d2 <- density(n_data2, n=128)

pdf(file="medinfo-pdf.pdf", width=5, height=4)
par(mar=c(2,2,0.5,0.5)+0.1)
plot(d2$x, d2$y, xlim=c(0, max(n_data2)), ylim=c(0, 0.06), lty=2, pch=".", col="red", main=NULL)
lines(d1$x, d1$y, pch=".", col="blue")
title(main = NULL, sub = NULL, xlab = NULL, ylab = NULL)
legend("topright", c("Journal articles", "MIMIC II discharge summaries"), lty=1:2, col=c("blue", "red"))
dev.off()

shapiro.test(n_data1)
shapiro.test(n_data2)
