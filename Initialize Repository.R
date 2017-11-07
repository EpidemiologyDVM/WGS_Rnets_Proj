#CHECK FOR MASTER LOCAL REPOS DIR
if(!dir.exists(LOCAL_WGS_REPOS)) dir.create(LOCAL_WGS_REPOS)


#CHECK FOR LOCAL REPOS DIR
if(!dir.exists(file.path(LOCAL_WGS_REPOS, 'fastq'))) dir.create(file.path(LOCAL_WGS_REPOS, 'fastq'))
if(!dir.exists(file.path(LOCAL_WGS_REPOS, 'R data'))) dir.create(file.path(LOCAL_WGS_REPOS, 'R data'))
if(!dir.exists(file.path(LOCAL_WGS_REPOS, 'Gene DBs'))) dir.create(file.path(LOCAL_WGS_REPOS, 'Gene DBs'))


#HANDLE SRADB
SRA_DB_PATH <- file.path(LOCAL_WGS_REPOS, SRA_DB_NAME)
if(!file.exists(SRA_DB_PATH)) getSRAdbFile(LOCAL_WGS_REPOS)
sra_con <- dbConnect(dbDriver("SQLite"), SRA_DB_PATH)
