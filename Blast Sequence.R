seq.list <- vector("list", length(ACCSN_NUMS))


#LOAD RDATA OBJECTS WITH SEQUENCE DATA

for(i in 1:length(ACCSN_NUMS)) {
  filename <- paste(ACCSN_NUMS[i], 'Rdata', sep = '.')
  load(file = file.path(SEQ_OBJS_DIR, filename))
  seq.list[[i]] <- vector("list", 2)
  print(paste('Importing: ', filename))
  #browser()
  seq.list[[i]][[1]] <- sread(accsn_seq.data$SEQ)
  seq.list[[i]][[2]] <- id(accsn_seq.data$SEQ)
  names(seq.list)[i] <- accsn_seq.data$ACCSN
  names(seq.list[[i]]) <- c('SEQ', 'IDS')
}