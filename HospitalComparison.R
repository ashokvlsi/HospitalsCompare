#
# Initiates the opening prompt to let user select a service, 
# and enables the user to choose another service as they select
# to continue.
#
main <- function(){
      continue <- TRUE
      while(continue){
            hospitalCompare()
            c <- tolower(readline("Continue? y/n: "))
            if(c=='y') 
                  continue <- TRUE
            else
                  continue <- FALSE
      }
}





#
# Inquires the user for what kind of service they desire
# and for the further info for the opted service. Then
# handles the info accordingly for the input of the computations,
# and finally prints the result.
#
hospitalCompare <- function(){     
      # Prompts user to select a service.
      input <- prompt(1)
      
      # Service selected. Prompts user to enter the necessary info.
      if(input %in% 0:4){
            # User selected to quit the engine.
            if(input==0)
                  return
            
            # Obtains the hospital data for the computation in the form of a data frame.
            else{
                  outcomes <- getFiles()
                  
                  # Used to check if the user's later input is valid.
                  states = unique(outcomes$State)
                  possibleOutcomes = c("heart attack","heart failure", "pneumonia")
            }
     
            
            # User selected Option 1 or 2.
            if(input==1 | input==2){
                  state_outcome_rank <- c()
                  state <- c()
                  outcome <- c()
                  rank <- c()
                  if(input==1){
                        # Obtains input from user.
                        state_outcome_rank <- strsplit(as.character(prompt(2)),",")
                        # Sorts the user's input into usable inputs for the computation.
                        state <- state_outcome_rank[[1]][1]
                        outcome <- state_outcome_rank[[1]][2]
                        rank <- "best"
                  }
                  else {
                        state_outcome_rank <- strsplit(as.character(prompt(3)),",")
                        state <- state_outcome_rank[[1]][1]
                        outcome <- state_outcome_rank[[1]][2]
                        rank <- state_outcome_rank[[1]][3]
                  }
                  
                  if (!state %in% states)
                        stop("invalid state")
                  if  (!outcome %in% possibleOutcomes)
                        stop("invalid outcome")
                  
                  # Computes for the result with the handled inputs above.
                  result <- rankhospital(outcomes,state, outcome, rank)
                  
                  
                  re <- paste("The hospital in ",state," which ranks ",rank," in ",outcome," is : ",result, sep="")
                  print(re)                  
            }
            
            # User selected Option 3.
            if(input==3){
                  
                  outcome_rank <- strsplit(as.character(prompt(4)),",")
                  outcome <- outcome_rank[[1]][1]
                  rank <- outcome_rank[[1]][2]
                  if  (!outcome %in% possibleOutcomes)
                        stop("invalid outcome")
                  

                  states = unique(outcomes$State)
                  hospitals  = sapply(states, function(x) rankhospital(outcomes, as.character(x),outcome,rank))
                  
                  numRecords <- length(hospitals)                  
                  details <- strsplit(hospitals,",")
                  name <- sapply(1:numRecords, function(x) details[[x]][1])
                  address <- sapply(1:numRecords, function(x) details[[x]][2])
                  city <- sapply(1:numRecords, function(x) details[[x]][3])                  
                  
                  allTable = data.frame(states,name,address,city)
                  names(allTable) <- c("State","Name of Hospital","Address","City")
                  
                  
                  cat("Table of hospital in each state ranking ",rank," in ",outcome,":\n", sep="")
                  print(allTable[order(allTable$State),])
                  print("The result is also stored as `HospitalsAcrossUS.csv` in the local directory.")
                  write.csv(allTable[order(allTable$State),],"HospitalsAcrossUS.csv",row.names = FALSE)
            }

            # User selected Option 4.
            if(input==4){
                  state_outcome <- strsplit(as.character(prompt(5)),",")
                  state <- state_outcome[[1]][1]
                  outcome <- state_outcome[[1]][2]
                  if (!state %in% states)
                        stop("invalid state")
                  if  (!outcome %in% possibleOutcomes)
                        stop("invalid outcome")
                  
                  numRecords <- sum(outcomes$State==state)
                  rankedHospitals <- sapply(1:numRecords, function(r) rankhospital(outcomes, state, outcome, as.numeric(r)))
                  details <- strsplit(rankedHospitals,",")
                  name <- sapply(1:numRecords, function(x) details[[x]][1])
                  address <- sapply(1:numRecords, function(x) details[[x]][2])
                  city <- sapply(1:numRecords, function(x) details[[x]][3])
                  allTable = data.frame(1:numRecords,name,address,city)
                  names(allTable) <- c("Rank","Name of Hospital","Address","City")
                  cat("Table of all hospitals in ",state, " for ",outcome,":\n", sep="")
                  print(allTable)
                  print("The result is also stored as `HospitalsAtState.csv` in the local directory.")
                  write.csv(allTable,"HospitalsAtState.csv",row.names = FALSE)
            }
      }
      else # An invalid input option is entered.
            stop("Invalid input option")      
}      





#
# Retrieves the name and location of a hospital in a specified state having a specified rank
# in the mortality rate of a specified disease from the given database.
# @input:
#     outcomes is the database from where the data are extracted.
#     state is the two-letter abbreviation of a state in the U.S..
#     outcome is the name of the disease whose mortality rate is in question.
#     rank is the position from the top of the list of the mortality rate in ascending order.
#
rankhospital <- function(outcomes, state, outcome, rank){
      rate = c()
      if(outcome == "heart attack")
            rate = outcomes$MORT.30.AMI.Performance.Rate[outcomes$State == state]
      if(outcome == "heart failure")
            rate = outcomes$MORT.30.HF.Performance.Rate[outcomes$State == state]
      if(outcome == "pneumonia")
            rate = outcomes$MORT.30.PN.Performance.Rate[outcomes$State == state]
      
      name = outcomes$Hospital.Name[outcomes$State==state]
      address <- outcomes$Address[outcomes$State==state]
      city <-  outcomes$City[outcomes$State==state]
      
      table = data.frame(rate, name, address, city)
      table = table[!is.na(table$rate),]
      table = table[order(table$rate,table$name),]
      
      result = c()
      
      if(rank == "best")
            result = paste(table$name[1],",",table$address[1],",",table$city[1],sep="")
      else if(rank == "worst")
            result = paste(table$name[nrow(table)],",",table$address[nrow(table)],",",table$city[nrow(table)],sep="")             
      else if(as.numeric(rank) <= nrow(table))
            result = paste(table$name[as.integer(rank)],",",table$address[as.integer(rank)],",",table$city[as.integer(rank)],sep="")
      else
            result = NA
      
      as.character(result)
}





# Prompts the user for inputs.
# @input:
#     session is the prompting session to be launded.
# @return:
#     output is a character vector representation of the user's input from the console.
#
prompt <- function(session=1){
      outut <- c()

      # Initial prompt.
      if(session==1){
            cat("This engine ranks the hospitals around the U.S. according to the  the 30-day mortality and readmission rates 
                for heart attacks, heart failure, and pneumonia for over 4,000 hospitals (as of 04/17/2014).",
                "Please enter the number for one of the following options:\n",
                "0: Exit the engine\n",
                "1: Find the best hospital in a specified state for a specified outcome.\n",
                "2: Find the hospital having a specified rank in a specified state for a specified outcome.\n",
                "3. Find the hospital having a specified rank in each state for a specified outcome.\n",
                "4. Find the ranks of all hospitals in a specified state for a specified outcome.\n",
                sep="")   
            output <- as.integer(readline(prompt="Option: "))
      }

      # Prompt for Option 1 related input.
      if(session==2){
            cat("You have selected Option 1: Find the best hospital in a specified state for a specified outcome.\n",
                "Please enter the two-letter abbreviation of the state (e.g.,CA for California) and the outcome (heart attack,
                heart failure,or pneumonia) separated by a comma.\n", 
                "For example, CA,heart attack\n",
                sep="")
            output <- readline(prompt="Enter here: ")
      }

      # Prompt for Option 2 related input.
      if(session==3){
            cat("You have selected Option 2: Find the hospital having a specified rank in a specified state for a specified outcome.\n",
                "Please enter the two-letter abbreviation of the state (e.g.,CA for California), the outcome (heart attack,
                      heart failure, or pneumonia) and the rank (best, worst, or any number) separated by a comma.\n", 
                "For example, CA,heart attack,5\n",
                sep ="")
            output <- readline(prompt="Enter here: ")
      }

      # Prompt for Option 3 related input.
      if(session==4){
            cat("You have selected Option 3: Find the hospital having a specified rank in each state for a specified outcome.\n",
                "Please enter the outcome (heart attack,heart failure,or pneumonia) and the rank (best, worst, or any number) separated by a comma.\n", 
                "For example, heart attack,5\n",
                sep ="")
            output <- readline(prompt="Enter here: ")
      }
      
      # Prompt for Option 4 related input.
      if(session==5){
            cat("You have selected Option 4: Find the ranks of all hospitals in a specified state for a specified outcome.\n",
                "Please enter the two-letter abbreviation of the state (e.g.,CA for California) and the outcome (heart attack,heart failure,or pneumonia) separated by a comma.\n", 
                "For example, NY,heart attack\n",
                sep ="")
            output <- readline(prompt="Enter here: ")
      }
      
      output
}





# 
# Downloads and extracts the files required for the analysis.
# @return:
#     outcomes is a data frame representation of the data.
#          
getFiles <- function(){
      # Sets the destination for the download to be the local directory
      localDir <- getwd()
      # Sets the download file name to be "hospitalCompare.zip".
      zfname = paste(localDir,"/hospitalCompare.zip", sep="")
      furl <- "http://medicare.gov/download/HospitalCompare/2014/April/HOSArchive_Revised_FlatFiles_20140417.zip"
      if(!file.exists(zfname))
            download.file(furl, destfile=zfname)
      # Exacts locally the file, "hvbp_outcome_02_25_2014.csv", for the computations.
      unzip(zfname, "hvbp_outcome_02_25_2014.csv")
      outcomes <- read.csv("hvbp_outcome_02_25_2014.csv")
      
      # Casts the records from factors to numerics.
      outcomes$MORT.30.AMI.Performance.Rate = 
            as.numeric(as.character(outcomes$MORT.30.AMI.Performance.Rate))      
      outcomes$MORT.30.HF.Performance.Rate = 
            as.numeric(as.character(outcomes$MORT.30.HF.Performance.Rate))      
      outcomes$MORT.30.PN.Performance.Rate = 
            as.numeric(as.character(outcomes$MORT.30.PN.Performance.Rate))
      outcomes
}      
