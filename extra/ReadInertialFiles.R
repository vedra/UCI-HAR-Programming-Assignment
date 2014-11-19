# This reads the data from the Inertial folders and merges them into a dataset.
# I didn't use it because later I realized it wasn't necessary for the assignment.

fold <- "UCI HAR Dataset/train/Inertial Signals/"
f <- list.files(fold)
for (i in 1:length(f)){
  tmp = read.table(file = paste(fold,f[i], sep=""))
  if(i==1){
    out <- tmp
  }else{
    out = cbind(out,tmp)
  }
  colnames(out)[i] <- f[i]
}

train <- cbind(train,out)
rm("out")

fold <- "UCI HAR Dataset/test/Inertial Signals/"
f <- list.files(fold)
for (i in 1:length(f)){
  tmp = read.table(file = paste(fold,f[i], sep=""))
  if(i==1){
    out <- tmp
  }else{
    out = cbind(out,tmp)
  }
  colnames(out)[i] <- f[i]
}

test <- cbind(test,out)
rm("out")
