# draw a professional dendrogram
install.packages("TraMineR")
install.packages("cluster")

library(TraMineR)
library(cluster)
data(biofam)
lab <- c("P","L","M","LM","C","LC","LMC","D")
biofam.seq <- seqdef(biofam[1:500,10:25], states=lab)

ccost <- seqsubm(biofam.seq, method = "CONSTANT", cval = 2, with.missing=TRUE)
sequences.OM <- seqdist(biofam.seq, method = "OM", norm= TRUE, sm = ccost,     
                        with.missing=TRUE)

clusterward <- agnes(sequences.OM, diss = TRUE, method = "ward")
plot(clusterward, which.plots = 2)



# draw a round dendrogram
install.packages("ape")
library(ape)
CL1 <- as.hclust(clusterward)
CL2 <- as.phylo(CL1)
plot(CL2, type="fan", cex=0.5)

plot(CL2, type="fan", show.tip.label=FALSE, no.margin=TRUE)

