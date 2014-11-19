# Understandning xtabs with sum and mean.
# Because I can't download package Hmisc in this distribution of Ubuntu.
# I wanted to use programmable variable names.

# THIS IS EQUAL FOR SUM:
# tmp_sum = xtabs(V1~ Activity+ID,aggregate(V1~Activity + ID,dataset,sum))
# var_name <- sprintf(colnames(dataset)[i])
# data_out_sum   <- xtabs(dataset[[var_name]] ~ Activity + ID, data = dataset)
# data_out_sum == tmp_sum

# THIS IS EQUAL FOR MEAN:
# tmp_mean = xtabs(V1~ID + Activity,aggregate(V1~ID + Activity,dataset,mean))
# data_tmp <- aggregate(V1~ID + Activity,dataset,mean);
# data_out_mean <- xtabs(V1~ID + Activity,data_tmp)
# data_out_mean == tmp_mean