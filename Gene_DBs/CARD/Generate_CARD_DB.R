CARD_DB.path <- file.path(
  LOCAL_WGS_REPOS,
  REF_GENE_DB_DIR,
  'CARD'
  )

CARD_DB.filename <- 'CARD_aggregate.fasta'

CARD.files <- list.files(CARD_DB.path)

CARD_DB.files <- CARD.files[grep('_fasta', CARD.files)]

CARD_DB.strings <- readDNAStringSet(
  file.path(CARD_DB.path, CARD_DB.files), 
  format = "fasta", 
  nrec = -1L, 
  skip = 0L, 
  seek.first.rec = FALSE, 
  use.names = TRUE
  )

makeblastdb(
  file.path(CARD_DB.path, CARD_DB.filename), 
  dbtype = "nucl", 
  args = paste(" -input_type fasta -out",  CARD_DB.path) 
  )
