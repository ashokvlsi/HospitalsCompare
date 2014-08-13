Hospital Compare
==================

###Summary
> Based on the data (last update: 04/17/2014) from the [Hospital Compare web site](http://hospitalcompare.hhs.gov)
run by the U.S. Department of Health and Human Services, the program

> 1. Finds the best hospital in a state for a given disease (heart attack, heart failure, or pneumonia).
> 2. Finds the hospital in a state having a given rank by the hospital's 30-day mortality rate of a given disease. 
> 3. Finds the hospitals in all states across the U.S. having a given rank by the hospital's 30-day mortality rate of a given disease. 
> 4. Ranks the hospitals in a state by the hospital's 30-day mortality rate of a given disease.


> The result of each of the above activities is output in the console. In addition, it is output to a .csv file for Activity 3 and Activity 4. The script was produced using R x64 3.1.1 on Windows 7. The script and a pair of sample outputs for Task 3 and Task 4 are available in the main repo. 

###To run the script:
> 1. Click [here](https://github.com/SamanthaLui/HospitalsCompare/archive/master.zip) to download the zip file containing this repo.

> 2. Extract the files and put them in a directory of your choice. Use it as your local directory for this program.

> 3. Run the script "HospitalComparison.R".

> 4. Enter `main()` at the console to start the program.

> 5. For the first time one of _Option 1, 2, 3_, or _4_ is selected, the program downloads the data from [Hospital Compare web site](http://hospitalcompare.hhs.gov), extracts the file "hvbp_outcome_02_25_2014.csv" and stores both the zip and .csv files in the local directory.

> 6. If _Option 3_, or _4_ is selected, in addition to printing the result in the console, the script outputs it to the .csv files, "nameOfTheDisease_rank_HospitalsAcrossUS.csv" and "nameOfTheDisease_state_HospitalsAtState.csv", respectively, in the local directory. 
