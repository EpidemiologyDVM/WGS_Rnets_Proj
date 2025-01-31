# File: 	Pipeline master.R
# Author: 	WJL
# Purpose: 	Initialize values and run associated script modules

#ATTACH PACKAGES

source("https://bioconductor.org/biocLite.R")
biocLite('SRAdb')
biocLite('ShortRead')

library(devtools)
install_github("mhahsler/rBLAST")

library(SRAdb)  #SRAdb library
library(ShortRead)
library(RSQLite)
library(rBLAST)
library(Biostrings)

#INITIALIZE PROJECT CONSTANTS

USER_HOME <- gsub('/Documents', '', Sys.getenv('R_USER'))
                                                  #
#USER_HOME <- substring(USER_HOME, 1, nchar(USER_HOME)-1)

# Define Project Location
PROJ_PATH <- c('Desktop/WGS_Rnet_Proj')
PROJ_DIR <- file.path(USER_HOME, PROJ_PATH)

# Define local sequence repository
LOCAL_WGS_REPOS <- 'D:/WGS_Repository'


# Define location for reference gene DBs in LOCAL_WGS_REPOS
REF_GENE_DB_DIR <- 'Gene_DBs'

# Define reference gene DBs to blast sequences against
REF_GENE_DB_SET <- c('ARG-ANNOT')

#Find CSV data file with NARMS data
ISOLATE_DATA_FILE <- 'Data/NARMSRetailMeats.csv'

#SRA db name
SRA_DB_NAME <- 'SRAmetadb.sqlite'

#Subset Criteria from NARMS data file
SUBSET_CRITERIA <- "SEROTYPE == 'Typhimurium' & ACCESSION_NUMBER != ''"


#INITIALIZE LOCAL SEQUENCE REPOSITORY
source(file = file.path(PROJ_DIR,'Initialize Repository.R'))
                                                  #Downloads and installs '


#IDENTIFY CASES

source(file.path(PROJ_DIR,'Identify isolates.R')) #Pulls out ID numbers and Accession numbers from csv data file

isolates <- isolates[1:9,]

#GET SRA/FASTQ FILES

source(file.path(PROJ_DIR, 'Download and process fastqs.R'))
