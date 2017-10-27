#Filename: 	Process SRA files.R
#Date modified: 2017-10-17
#Author: 	WJL and Hanna Berman
#Purpose: Initialize values and run associated script modules
#

#NOTE: SRAdb and biostrings packages CAN handle file paths with spaces
#NOTE: rBLAST and SHORTREAD packages CANNOT handle file paths with spaces

#Install SRAdb Package
## try http:// if https:// URLs are not supported
#IF SHORTREAD PACKAGE IS NOT DOWNLOWDED - Download ShortRead package for FastQ manipulation 
source("https://bioconductor.org/biocLite.R")
biocLite("ShortRead")
biocLite("SRAdb") #need to check if abouve source line 

# Load packages
library(SRAdb)
library(GEOquery)
library(ShortRead)
library(rBLAST)


#DECLARE FILE PATHS
SRA_DB_DIR <- 'C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Data' 
                                                      #Directory to house sra metadata rdb
FASTQ_REPOS_DIR <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Data/fastq_files"
                                                      #Directory target to download .sra files
                                                      #CAN'T CONTAIN SPACES?
TEMP_FASTQ_FILE_DIR <- "C:/Users/hlberman/Desktop/component_fastqs"      #Directory 
AGGR_FASTQ_OUTPUT_DIR <- file.path(TEMP_FASTQ_FILE_DIR, '..', 'Aggregate_Fastqs')
SEQ_OBJS_DIR <- "C:\\Users\\hlberman\\Desktop\\Sequence_Rdata_objs"
TEMP_RDB_RAWFILES_DIR <- 'C:/Users/hlberman/google drive/Lanzas_lab_hanna/Salmonella_NARMS_WGS/Resistance_DB/Fasta files'


#DOWNLOAD & INSTALL SRA METADATA RDB

SRA_SQLITE_PATH <- file.path(SRA_DB_DIR, 'SRAmetadb.sqlite')
                                                      #Define location of SRAmetadb.sqlite
SRA_RDB_IS_LOCAL <- file.exists(SRA_SQLITE_PATH)          #Check if metadata rdb exists locally
if(!SRA_RDB_IS_LOCAL) getSRAdbFile(destdir = file.path(SRA_SQLITE_PATH, 'SRAmetadb.sqlite')) 
                                                      #IF SRA db file does not exist locally download and connect to the most recent SRAdb metadatabase
sra_con <- dbConnect(dbDriver("SQLite"), SRA_SQLITE_PATH) 
                                                      #Est connection to SRAmetadb.sqlite


#DOWNLOAD SRA FILES IN FASTQ FORMAT

ACCSN_NUMS = isolates$ACCESSION_NUMBER                #Grab ACCSNs of interest; see pipeline master
#NOTE: THIS IS NOT BEING USED IN CURRENT DEVELOPMENT TESTING; WILL BE USED IN FINAL VERSION

#getFASTQinfo( ACCSN_NUMS, sra_con, srcType = 'ftp' ) #If you want to get info and address(es) for fastq files (not necessary - shows metadb information and address of fastq file)

getSRAfile(ACCSN_NUMS, sra_con, destDir = FASTQ_REPOS_DIR, fileType = "fastq") 
                                                      #Grabs .gz archives containing requested fastq files from ftp site BASED ON sqlite metadata rdb

#download gzs
for (gz_file_name in list.files(FASTQ_REPOS_DIR )){  #loop for every file in local gz repository
  if(grepl('.gz', gz_file_name)) {
      gunzip(file.path(FASTQ_REPOS_DIR , gz_file_name))  #unzip current file, and delete .gz
      print(paste('Unzipped:', gz_file_name, sep = ' ')) #Returns name of decompressed file as check
  }
  fastq_file_name <- gsub('.gz', '', gz_file_name)  #create fastq_file_name
  
}

ACCSN_NUMS <- unique(sapply(strsplit(list.files(TEMP_FASTQ_FILE_DIR  ), "_"), function(x) return(x[1])))
                                                    #loads temp isolate numbers
fastq.list <- list(length = length(ACCSN_NUMS))

for(accsn in ACCSN_NUMS) {
  file.out = file.path(AGGR_FASTQ_OUTPUT_DIR, paste(accsn, "fastq", sep = '.'))
                                                    #Defines output file for current iteration
  fastq_accsn = readFastq(dirPath = TEMP_FASTQ_FILE_DIR , pattern=accsn, compress=FALSE)
  fastq.list[[accsn]] <- fastq_accsn                                               
  writeFastq(fastq_accsn, file.out, mode="w", compress=FALSE)
  
}
#ADD TITLE CONTENTS: Project name ('NARMS NTS WGS Data'|<serotype>|<ACCSN #> )
#NOT CURRENTLY WORKING, MAY ADD IN FUTURE



#Create string objects for each fastQ file using ShortRead R package

#NOTE: ShortRead cannot retreive files from Google Drive folder due to space between "Google" and "Drive".  
  

#creating a DNA string object from a FastQ file

for(accsn in ACCSN_NUMS){
  fastq.reads <- readFastq(dirPath = file.path(AGGR_FASTQ_OUTPUT_DIR, paste(accsn, 'fastq', sep = '.')))

  accsn_seq.data <- list(
                    ACCSN = accsn,
                    SEQ = fastq.reads
                    )

  save(accsn_seq.data, file = file.path(SEQ_OBJS_DIR, paste(accsn_seq.data$ACCSN, 'Rdata', sep = '.')))

  test.seq <- readFastq(dirPath = file.path(AGGR_FASTQ_OUTPUT_DIR, paste(accsn, 'fastq', sep = '.')))
  test.str <- sread(test.seq)
}

#paste each of these objects into one r data file each file with other data:
  # metadata, MIC, wGS - which is the DNA string objects we just created
  #these will then be used to blast the sequences against the database we have created.
 
    
    
    