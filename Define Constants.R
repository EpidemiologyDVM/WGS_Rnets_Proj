# IDENTIFY USER HOME
USER_HOME <- gsub('\\Documents', '', Sys.getenv('R_USER'))
USER_HOME <- substring(USER_HOME, 1, nchar(USER_HOME)-1)


# DEFINE PROJECT LOCATION
PROJ_PATH <- c('Desktop\\WGS_Rnet')
PROJ_DIR <- file.path(USER_HOME, PROJ_PATH)


# DEFINE LOCAL SEQUENCE REPOSITORY
LOCAL_WGS_REPOS <- 'D:\WGS Repository'


