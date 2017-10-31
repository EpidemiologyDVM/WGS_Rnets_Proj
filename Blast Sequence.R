seq.data <- vector("list", dim(isolates)[1])
names(seq.data) <- isolates$ACCESSION_NUMBER


#LOAD RDATA OBJECTS WITH SEQUENCE DATA

for(accsn in names(seq.data)) {
  filename <- paste(accsn, 'Rdata', sep = '.')
  load(file = file.path(LOCAL_WGS_REPOS, 'R data', filename))
  seq.data[[accsn]] <- vector("list", 2)
  names(seq.data[[accsn]]) <- c('SEQ', 'IDS')
  
  print(paste('Importing:', filename))
#  browser()
  seq.data[[accsn]]$SEQ <- sread(accsn.read)
  seq.data[[accsn]]$IDS <- id(accsn.read)
}
