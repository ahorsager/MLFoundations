## PtMetadata.R
## For parsing and summarizing patient metadata (i.e., clinical descriptive data)
## Alan Horsager, NOV 2014

PtMetadata <- read.table("/Users/horsager/Dropbox/documents/programs/data/POCMetadata.csv", sep = ",", header = TRUE)

## Parsing data
PtAge <- na.omit(PtMetadata[1:127, "CollectionAge"])
DonorAge <- na.omit(PtMetadata[128:163, "CollectionAge"])
PtVolume <- na.omit(PtMetadata[1:127, "SAVolume"])
PtConc <- na.omit(PtMetadata[1:127, "SpermConc"])
PtMotile <- na.omit(100*PtMetadata[1:127, "PercentMotile"])
PtMorphHead <- na.omit(PtMetadata[1:127, "HeadNormal"])
PtMorphTail <- na.omit(PtMetadata[1:127, "TailNormal"])

## Plotting Data
par(mfrow = c(2,2))
## boxplot(PtAge, DonorAge, na.rm=TRUE, ylab = "Age (Years)") ## plot age of subjects when sample collected
## title("Subject Age")

boxplot(PtVolume, na.rm=TRUE, ylab = "Volume (mL)") ## plot age of subjects when sample collected
title("Semen Volume")
abline(h=1.5, col="red")

boxplot(PtConc, na.rm=TRUE, ylab = "Sperm / mL x 10^6") ## plot age of subjects when sample collected
title("Concentration")
abline(h=15, col="red")

boxplot(PtMotile, na.rm=TRUE, ylab = "Motile Sperm (%)") ## plot age of subjects when sample collected
title("Motility")
abline(h=32, col="red")

boxplot(PtMorphHead, na.rm=TRUE, ylab = "Normal Morphology (%)") ## plot age of subjects when sample collected
title("Morphology")
abline(h=4, col="red")