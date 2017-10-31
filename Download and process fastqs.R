fastq.reqd <- isolates$ACCESSION_NUMBER

all.present.fastq.files <- list.files(file.path(LOCAL_WGS_REPOS, 'fastq'))[grepl('.fastq', list.files(file.path(LOCAL_WGS_REPOS, 'fastq')))]
compiled.present.fastq.files <- all.present.fastq.files[!grepl('_', all.present.fastq.files)]

read.list <- vector('list', length = length(fastq.reqd))
names(read.list) <- fastq.reqd
compiled.fastq.present <- vector('logical', length = length(fastq.reqd))
names(compiled.fastq.present) <- fastq.reqd

for(accsn in fastq.reqd){
  if(paste(accsn, 'fastq', sep = '.')%in%compiled.present.fastq.files){
    cat(accsn, 'is present and compiled and has been added to read.list\n')
    compiled.fastq.present[accsn] <- T
    accsn.read <- readFastq( dirPath = file.path(LOCAL_WGS_REPOS, 'fastq', paste(accsn, 'fastq', sep = '.')), compress=FALSE)
    read.list[[accsn]] <- accsn.read
    save(accsn.read, file = file.path(LOCAL_WGS_REPOS, 'R data', paste(accsn, 'Rdata', sep = '.')))
    cat('Sequence read saved to ', accsn,'.Rdata\n\n', sep = '')
  } else {
    compiled.fastq.present[accsn] <- F
    cat(accsn, 'is not compiled locally\n\n')
  }
}

for(accsn in fastq.reqd) {
  if(!compiled.fastq.present[accsn]) {
    cat('Downloading ', accsn,'_X.fastq components from remote database\n', sep = '')
    getSRAfile(accsn, 
               sra_con, 
               destDir=file.path(LOCAL_WGS_REPOS, 'fastq'),
               fileType = "fastq",
               method = 'libcurl' #'libcurl' works, but default('curl') and 'auto' threw errors 10/30/17 from WJL's W10 system.
              )
    cat('Compiling ', accsn, '.fastq\n', sep = '')
    read.accsn <- readFastq(dirPath = file.path(LOCAL_WGS_REPOS, 'fastq'), pattern=accsn, compress=FALSE)
    file.out = file.path(file.path(LOCAL_WGS_REPOS, 'fastq'), paste(accsn, "fastq", sep = '.'))
    writeFastq(read.accsn , file.out, mode="w", compress=FALSE)
    cat('Adding', accsn, 'to read.list\n')
    read.list[[accsn]] <- read.accsn
    compiled.fastq.present[accsn] <- T
  }
  
}
