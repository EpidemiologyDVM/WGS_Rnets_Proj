# File: 	Pipeline master.R
# Author: 	WJL
# Purpose: 	Initialize values and run associated script modules

#ATTACH PACKAGES
source("https://bioconductor.org/biocLite.R")
biocLite('SRAdb')
library(SRAdb)  #SRAdb library



#INITIALIZE PROJECT CONSTANTS

# Identify user home
USER_HOME <- gsub('\\Documents', '', Sys.getenv('R_USER'))
USER_HOME <- substring(USER_HOME, 1, nchar(USER_HOME)-1)

# Define Project Location
PROJ_PATH <- c('Desktop\\WGS_Rnet')
PROJ_DIR <- file.path(USER_HOME, PROJ_PATH)

# Define local sequence repository
LOCAL_WGS_REPOS <- 'D:\\WGS Repository'

#Find CSV data file with NARMS data
ISOLATE_DATA_FILE <- 'Salmonella_NARMS_WGS/Data/NARMSRetailMeats.csv'

#SRA db name
SRA_DB_NAME <- 'SRAmetadb.sqlite'



#INITIALIZE LOCAL SEQUENCE REPOSITORY

source('Initialize Repository.R')



#IDENTIFY CASES

#Select data of interest
SUBSET_CRITERIA <- "SEROTYPE == 'Typhimurium' & ACCESSION_NUMBER != ''"

#Pulls out ID numbers and Accession numbers from csv data file
source(file.path(PROJECT_DIR, 'Pipeline Code/Identify isolates.R'))
