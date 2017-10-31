# File: 	Identify cases.R
# Author: 	WJL
# Purpose: 	Code to identify case accessions to import

isolate_data <- read.csv(ISOLATE_DATA_FILE,
                         stringsAsFactors = F
                         )

isolates <- subset(isolate_data, 
			select = c('SAMPLE_ID', 'ACCESSION_NUMBER'), 
			subset = eval(
				parse(text = SUBSET_CRITERIA), 
				envir = isolate_data
				)
			)
