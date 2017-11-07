#seq.data <- vector("list", dim(isolates)[1])
#names(seq.data) <- isolates$ACCESSION_NUMBER

ref_gene.db <- REF_GENE_DB_SET[1]

#LOAD RDATA OBJECTS WITH SEQUENCE DATA

ref_gene.name <- 'ARG-ANNOT'
ref_gene.db <- blast(db = file.path(LOCAL_WGS_REPOS, 
                                    REF_GENE_DB_DIR, 
                                    ref_gene.name, 
                                    paste(ref_gene.name, 'fasta', sep = '.')
                                    )
                                )
split.symbol <- ':'
blast_result.list <- vector('list', length = length(REF_GENE_DB_SET) * dim(isolates)[1])
names(blast_result.list) <- isolates$ACCESSION_NUMBER



i <- 0 
for(accsn in names(blast_result.list)[1]) {
  i <- i + 1
  cat('\n\nBLAST #', match(accsn, names(blast_result.list)), 'of', dim(isolates)[1])
  blast_result.list[[accsn]] <- Blast_sequence(
                              accsn, 
                              ref_gene.db, 
                              split.symbol, 
                              loud = TRUE
                              )
}
blast_results <- rbindlist(blast_result.list)
