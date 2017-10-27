
#Filename:Create Blast Database.R
#Date modified: 2017-10-13
#Author: Hanna Berman
#project: NARMS WGS Salmonella 
#File desciption: Creating Salmonella Typhimurium and resistance database

#Create a database in BLAST
#Public databases used:
#REMOVED: Salmonella enerica serotype Typhimurium reference genome NC_003197.2 https://www.ncbi.nlm.nih.gov/assembly/organism/28901/latest/
#NOT INCLUDED: BacMet verson 1.1 released 01/16/2014: http://bacmet.biomedicine.gu.se/download_temporary.html --NOT YET IN DATABASE ONLY HAS PEPTIDE FILES
#CARD version 1.2.0 released 09/07/2017: https://card.mcmaster.ca/download
#ResFinder  :https://bitbucket.org/genomicepidemiology/resfinder_db/downloads/
#Arg-ANNOT version 3 released March 2017 : http://en.mediterranee-infection.com/arkotheque/client/ihumed/_depot_arko/articles/1424/arg-annot-nt-v3-march2017_doc.fasta

#NOTE: SRAdb and biostrings packages CAN handle file paths with spaces
#NOTE: rBLAST and SHORTREAD packages CANNOT handle file paths with spaces

#all raw downloaded DB files are stored in C:\Users\hlberman\Google Drive\Lanzas_Lab_Hanna\DB MASTER FILES
#"raw downloaded" files to be used were put into C:\Users\hlberman\Google Drive\Lanzas_Lab_Hanna\Salmonella_NARMS_WGS\Resistance_DB_RAWFILES for easy access and manipulation before conversion to fasta files. 

library(rBLAST)
library(Biostrings)

#Choose file to create string obect
ARG_ANNOT <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ARG-ANNOT/ARG-ANNOT_text.txt"
CARD_1 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/CARD/protein_fasta_protein_variant_model.fasta"
CARD_2 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/CARD/nucleotide_fasta_protein_homolog_model.fasta"
CARD_3 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/CARD/nucleotide_fasta_protein_knockout_model.fasta" 
CARD_4 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/CARD/nucleotide_fasta_protein_overexpression_model.fasta"
CARD_5 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/CARD/nucleotide_fasta_protein_variant_model.fasta"
CARD_6 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/CARD/nucleotide_fasta_rRNA_gene_variant_model.fasta"
CARD_7 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/CARD/protein_fasta_protein_homolog_model.fasta"
CARD_8 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/CARD/protein_fasta_protein_knockout_model.fasta"
CARD_9 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/CARD/protein_fasta_protein_overexpression_model.fasta"
RF_1 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/trimethoprim.fsa"
RF_2 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/aminoglycoside.fsa"
RF_3 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/beta-lactam.fsa"
RF_4 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/colistin.fsa"
RF_5 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/fosfomycin.fsa"
RF_6 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/fusidicacid.fsa"
RF_7 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/glycopeptide.fsa"
RF_8 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/macrolide.fsa"
RF_9 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/nitroimidazole.fsa"
RF_10 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/oxazolidinone.fsa"
RF_11 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/phenicol.fsa"
RF_12 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/quinolone.fsa"
RF_13 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/rifampicin.fsa"
RF_14 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/sulphonamide.fsa"
RF_15 <- "C:/Users/hlberman/Google Drive/Lanzas_Lab_Hanna/Salmonella_NARMS_WGS/Resistance_DB_RAWFILES/ResFinder/tetracycline.fsa"


#TO CREATE INDIVIDUAL FASTA FILES FOR EACH FILE --NOT SURE IF NECESSARY
#create DNA string from file. readDNAStringset() command is from biostrings package. Can retreive from Google Drive folder
  #>DNAstringobject <- readDNAStringSet(ARG_ANNOT, format = "fasta", nrec = -1L, skip = 0L, seek.first.rec = FALSE, use.names = TRUE)

#Create new FASTA file and specify new file name and location with "fastaFILE"
  #>fastaFILE <- "<C:/Users/hlberman/Resistance_DB/....fasta>"
  #>writeFasta(DNAstringobject, fastaFILE, mode = "w")

#Make Database: first, create list of FASTA files to be included in the DB to combine all files into one single string object



DB_files <- list.files(TEMP_RDB_RAWFILES_DIR )
CARD_DB_files <- DB_files[grep('_fasta', DB_files)]
ARG_ANNOT_DB_files <- 'ARG-ANNOT.fasta'
RF_DB_files <- DB_files[grep('RF_', DB_files)]

#DB_fileLIST <-  c("C:/Users/hlberman/Resistance_DB/RF_trimethoprim.fasta",
#                 "C:/Users/hlberman/Resistance_DB/ARG-ANNOT.fasta",
#                  "C:/Users/hlberman/Resistance_DB/nucleotide_fasta_protein_homolog_model.fasta",
#                 "C:/Users/hlberman/Resistance_DB/nucleotide_fasta_protein_knockout_model.fasta",
#                 "C:/Users/hlberman/Resistance_DB/nucleotide_fasta_protein_overexpression_model.fasta",
#                 "C:/Users/hlberman/Resistance_DB/nucleotide_fasta_protein_variant_model.fasta",
#                 "C:/Users/hlberman/Resistance_DB/nucleotide_fasta_rRNA_gene_variant_model.fasta",
#                 "C:/Users/hlberman/Resistance_DB/protein_fasta_protein_homolog_model.fasta",
#             "C:/Users/hlberman/Resistance_DB/protein_fasta_protein_knockout_model.fasta",
#                 "C:/Users/hlberman/Resistance_DB/protein_fasta_protein_overexpression_model.fasta",
#                 "C:/Users/hlberman/Resistance_DB/protein_fasta_protein_variant_model.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_aminoglycoside.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_beta-lactam.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_colistin.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_fosfomycin.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_fusidicacid.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_glycopeptide.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_macrolide.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_nitroimidazole.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_oxazolidinone.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_phenicol.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_quinolone.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_rifampicin.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_sulphonamide.fasta",
#                 "C:/Users/hlberman/Resistance_DB/RF_tetracycline.fasta"
#)


#CREATE ARG-ANNOT BLAST DB
#Does not need to be created here - already exists in single file: "C:/Users/hlberman/Resistance_DB/ARG-ANNOT.fasta"
file.copy(
  from ="C:\\Users\\hlberman\\Google Drive\\Lanzas_Lab_Hanna\\Salmonella_NARMS_WGS\\Resistance_DB\\Fasta files\\ARG-ANNOT.fasta", 
  to = "C:\\Users\\hlberman\\Resistance_DB\\ARG-ANNOT.fasta"
  )

makeblastdb(
  "C:\\Users\\hlberman\\Resistance_DB\\ARG-ANNOT.fasta",
  dbtype = "nucl", 
  args = " -input_type fasta -out C:/Users/hlberman/Resistance_DB/ARG-ANNOT"
)
                      

#CREATE ResFinder BLAST DB
RF_db_strings <- readDNAStringSet(file.path(TEMP_RDB_RAWFILES_DIR, RF_DB_files) , format = "fasta", nrec = -1L, skip = 0L, 
                                         seek.first.rec = FALSE, use.names = TRUE)
RF_fasta_DB <- "C:/Users/hlberman/Resistance_DB/RF_fast_DB.fasta"
#NOTE: PATH CANNOT HAVE SPACES!!!!
writeFasta(RF_db_strings, RF_fasta_DB, mode = "w")
makeblastdb(RF_fasta_DB, 
            dbtype = "nucl", 
            args = " -input_type fasta -out C:/Users/hlberman/Resistance_DB/RF"
            )


#CREATE CARD BLAST DB
card_db_strings <- readDNAStringSet(file.path(TEMP_RDB_RAWFILES_DIR, CARD_DB_files) , format = "fasta", nrec = -1L, skip = 0L, 
                                  seek.first.rec = FALSE, use.names = TRUE)
CARD_fasta_DB <- "C:/Users/hlberman/Resistance_DB/RF_fast_DB.fasta"
#NOTE: PATH CANNOT HAVE SPACES!!!!
writeFasta(card_db_strings, CARD_fasta_DB, mode = "w")
makeblastdb(CARD_fasta_DB, 
            dbtype = "nucl", 
            args = " -input_type fasta -out C:/Users/hlberman/Resistance_DB/CARD"
            )

#WARNING: THROWING INVALID SEQUENCE ERRORS!!!!




#create one single DNA string object from FASTA files (can also simply do this from raw downloaded files)
ResistanceDB_strings <- readDNAStringSet(DB_fileLIST, format = "fasta", nrec = -1L, skip = 0L, 
                                         seek.first.rec = FALSE, use.names = TRUE)
ResistanceDB_strings

#Write all strings of  as single FASTA file for Database creation. fastaDBFile used to specify location of new DB fasta file
fastaDBFILE <- "C:/Users/hlberman/Resistance_DB/Resistance_DB_fasta.fasta"
writeFasta(ResistanceDB_strings, fastaDBFILE, mode = "w")

#Use the newly created fasta file to made a blast database with rBLAST package. fasta file used cannot be retrieved from Google Drive folder (or any folder with a space in the name). This command will return 3 new files that BLAST reads as your database
makeblastdb("C:/Users/hlberman/Resistance_DB/Resistance_DB_fasta.fasta", dbtype = "nucl", args = " -input_type fasta -out C:/Users/hlberman/Resistance_DB")

#Store this database in a location without spaces in the file name, so that rBLAST can retrieve the file during further analyses


