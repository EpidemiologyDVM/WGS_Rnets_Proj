Needed_Accsns <- function(req.accsn, accsn.prefix = 'SRA_', accsn.suffix = '.fastq'){
  fastq.dir <- file.path(LOCAL_WGS_REPOS, 'fastq')
  local.accsn <- list.files(fastq.dir)[grepl(accsn.suffix, list.files(fastq.dir))]
  local.accsn <- substr(local.accsn, -nchar(accs.suffix))
  
  return(setdiff(req.accsn, local.accsn))
}