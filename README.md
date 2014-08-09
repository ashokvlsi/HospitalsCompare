Hospitals Compare
==================

###Summary
> Based on the data (last update: 04/17/2014) from the [Hospital Compare web site](http://hospitalcompare.hhs.gov)
run by the U.S. Department of Health and Human Services, the script does the following:

> 1. Find the best hospital in a state for a given disease (heart attack, heart failure, or pneumonia).
> 2. Find the hospital in a state having a given rank by the 30-day mortality rate of a given disease. 
> 3. Find the hospitals in all states across the U.S. having a given rank by the 30-day mortality rate of a given disease. 
> 4. Ranks the hospitals in a state by the 30-day mortality rate of a given disease.


> The result of each of the above tasks is output in the console. In addition, the result is output to a .csv file for Task 3 and Task 4. The script was produced using R x64 3.1.1 on Windows 7. The script and a pair of sample outputs for Task 3 and Task 4 are available in the main repo. 

###To run the script:
> 1. Click [here](https://github.com/SamanthaLui/HospitalsCompare/archive/master.zip) to download the zip file containing this repo.

> 2. Extract the files and put them in a directory of your choice. Use it as your local directory for this program.

> 3. Run the file "HospitalComparison.R".

> 4. Enter `main()` at the console to start the program.

> 5. For the first time one of _Option 1, 2, 3_, or _4_ is selected, the program downloads the data from [Hospital Compare web site](http://hospitalcompare.hhs.gov), extracts the file "hvbp_outcome_02_25_2014.csv" and stores both the zip and .csv files in the local directory.

> 
