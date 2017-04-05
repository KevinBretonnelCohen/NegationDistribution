#library(sm)
# change to your own directory structure
data1 <- read.csv("/Users/kev/Dropbox/A-M/Corpora/scripts/negatives_craft.txt")
data2 <- read.csv("/Users/kev/Dropbox/A-M/Corpora/scripts/negatives_mimic2disch.txt")
n_data1 <- data1$neg
n_data2 <- data2$neg
t.test(n_data1,n_data2)
#sm.density.compare(data1, data2)
#hist(data1)
#d <- density(n_data1)
#plot(d)
#data1
plot(density(n_data2), xlim=c(0, max(n_data2)), ylim=c(0, 0.06), lty=2,
     main="Distribution of frequency of explicit negation per 10K words")
lines(density(n_data1), lty=3)
#legend("topright", legend=c("MIMIC II discharge summaries", "Journal articles"), 
       #names(legendnames), cex=0.8,  
#       lty=2:3, lwd=3, bty="n")
legend("topright", c("MIMIC II discharge summaries", "Journal articles"), lty=2:3)
shapiro.test(n_data1)
shapiro.test(n_data2)
