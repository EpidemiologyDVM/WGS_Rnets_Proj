ARG_ANNOT.fasta <- file.path(
  LOCAL_WGS_REPOS,
  REF_GENE_DB_DIR,
  'ARG-ANNOT',
  "ARG-ANNOT.fasta"
)

if(!file.exists(ARG_ANNOT.fasta)) download.file(url = "http://en.mediterranee-infection.com/arkotheque/client/ihumed/_depot_arko/articles/1424/arg-annot-nt-v3-march2017_doc.fasta", destfile = ARG_ANNOT.fasta)

makeblastdb(
  ARG_ANNOT.fasta,
  dbtype = "nucl", 
  args = paste(
    " -input_type fasta -out",
    ARG_ANNOT.fasta
  )
)
