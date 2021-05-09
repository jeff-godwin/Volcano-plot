## Rscript for enhanced volcano

library(EnhancedVolcano)
res<-read.table("tab_separated_file",sep="\t", header = TRUE)
head(res)

keyvals <- rep('grey30', nrow(res))
names(keyvals) <- rep('BASELINE', nrow(res))
names(keyvals)[which(res$pval > 0.05)] <- 'BASELINE'
keyvals[which(res$log2FoldChange > 2.0 & (res$pval < 0.05))] <- 'red2'
names(keyvals)[which(res$log2FoldChange > 2.0 & res$pval < 0.05)] <- 'UPREGULATED'
keyvals[which(res$log2FoldChange < -2.0 & res$pval < 0.05)] <- 'royalblue'
names(keyvals)[which(res$log2FoldChange < -2.0 & res$pval < 0.05)] <- 'DOWNREGULATED'

unique(names(keyvals))
unique(keyvals)
keyvals[1:20]

png("volcano.png", width = 1500,  height = 1500, res = 300, pointsize = 8)
EnhancedVolcano(res,lab = as.character(res$ID),x='log2FoldChange',y='pval',title='Volcano',pCutoff=0.05,FCcutoff=2.0, selectLab = c('abcd'),cutoffLineType = 'blank',hline=0.05,vline=c(2,-2),pointSize=1.5,labSize=3.5,colCustom = keyvals,gridlines.major = FALSE,gridlines.minor = FALSE)
dev.off()
