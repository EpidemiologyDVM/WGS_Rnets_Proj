#Filename: 	Blast sequences.R
#Date modified: 2017-10-20
#Author: 	WJL and Hanna Berman
#Purpose: Blast accession sequences and organize outputs

#NOTE: SRAdb and biostrings packages CAN handle file paths with spaces
#NOTE: rBLAST and SHORTREAD packages CANNOT handle file paths with spaces

#INITIALIZE SEQUENCE DATA LIST
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
#note: database must be set up. See "Create BLAST database.R"

#BLAST sofware must be downloaded for local use. Can find on: https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download
#get rBLAST package (requires devtools package)
#>install_github("mhahsler/rBLAST")

#NOTE: rBLAST cannot retrieve input files from Google Drive folder because of the space between "Google" and "Drive". 

# load a BLAST database (replace db with the location + name of the BLAST DB)
blA <- blast(db = "C:/Users/hlberman/Resistance_DB/Resistance_DB")
RF_DB <- blast(db = "C:/Users/hlberman/Resistance_DB/RF")
CARD_DB <- blast(db = "C:/Users/hlberman/Resistance_DB/CARD")
ARG_ANNOT_DB <- blast(db = "C:/Users/hlberman/Resistance_DB/ARG-ANNOT")

# query a sequence using BLAST

RF.output <- vector("list", length(ACCSN_NUMS))
for(i in 1:length(ACCSN_NUMS)) {
  RF.output[[i]] <-predict(RF_DB, seq.list[[i]]$SEQ)
}
                       
clA <- predict(blA, seq.list[[i]]$SEQ)
clA[clA$Perc.Ident > 98,]

strsplit(as.character(clA[57,2]), '\|')

print(clA)
summary(clA)

