# Dataset 
sample=paste(rep("sample_",24) , seq(1,24) , sep="")
specie=c(rep("dicoccoides" , 8) , rep("dicoccum" , 8) , rep("durum" , 8))
treatment=rep(c(rep("High",4 ) , rep("Low",4)),3)
data=data.frame(sample,specie,treatment)
for (i in seq(1:5)){
        gene=sample(c(1:40) , 24 )
        data=cbind(data , gene)
        colnames(data)[ncol(data)]=paste("gene_",i,sep="")
}
data[data$treatment=="High" , c(4:8)]=data[data$treatment=="High" , c(4:8)]+100
data[data$specie=="durum" , c(4:8)]=data[data$specie=="durum" , c(4:8)]-30
data

# Euclidean distance
rownames(data)=data[,1]    
dist=dist(data[ , c(4:8)] , diag=TRUE)
dist

# hierarchical clustering
hc=hclust(dist)

plot(hc)


