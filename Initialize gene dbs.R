for(ref_gene.db in REF_GENE_DB_SET) {
  cat('Initializing reference gene database:', ref_gene.db)
  source(file.path(
    LOCAL_WGS_REPOS,
    REF_GENE_DB_DIR,
    ref_gene.db,
    paste('Generate_', ref_gene.db, '_DB.R', sep = '')
    ))
}
