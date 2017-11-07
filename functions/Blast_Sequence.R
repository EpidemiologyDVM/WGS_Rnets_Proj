Blast_sequence <- function(
                    accsn,
                    ref_gene.db,
                    split.symbol,
                    loud = true
                    ) 
{
  filename <- paste(accsn, 'Rdata', sep = '.')

  if(loud) cat('\nImporting:', filename)
  load(file = file.path(LOCAL_WGS_REPOS, 'R data', filename))
  
  if(loud) cat('\nBlasting', accsn, 'against', ref_gene.name, '\n')
  blast.results.raw <- predict(ref_gene.db, sread(accsn.read))
  blast.results <- data.frame(
                      ACCSN = accsn,
                      Ref.DB = ref_gene.name,
                      Query.num = gsub('Query_', '', blast.results.raw$QueryID),
                      #Query.name = '',
                      Gene = sapply(strsplit(as.character(blast.results.raw[[2]]),split.symbol), function(x) return(x[1])),
                      Identity = blast.results.raw$Perc.Ident,
                      stringsAsFactors = FALSE
                      )
  #browser()
  #blast.results$Query.name <- id(accsn.read)$seq[blast.results$Query.num]
  return(blast.results)
}




Blast_sequence(isolates$ACCESSION_NUMBER[1], ref_gene.db, ':', loud = FALSE)
