* Encoding: UTF-8.

*LFS WORKSHOP PRACTICAL SESSION
*Exercise 2: The distribution of weekly earnings of full-time employees

*This exercise recreates ONS labour market analysis reported in the table EARN04: Gross weekly earnings of full-time employees
*https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/earningsandworkinghours/datasets/grossweeklyearningsoffulltimeemployeesearn04 [last accessed 24/04/2021]
This table is updated four times a year in February, May, August and November using the Quarterly Labour Force Survey. 
*Data: Quarterly Labour Force Survey, October - December, 2020, which is accessible from the UK Data Servic (http://doi.org/10.5255/UKDA-SN-8777-3)

*Open data, keeping only the necessary variables (to use the set data command you may need to set the directory e.g. cd "XXXX\LFS workshop\UKDA-8777-spss\spss\spss25".

GET FILE ="UKDA-8777-spss\spss\spss25\lfsp_od20_eul_pwt18.sav". 
SAVE 
  OUTFILE="lfs_od20_practical2_temp"
    /keep PWT18 PIWT18 grsswk inecac05 ftpt hourpay sex.

GET FILE ="lfs_od20_practical2_temp".

*Apply the weight. 
weight by PIWT18.
***********************************************************************************************
*REVIEW QUESTIONS 1
*Why do we use a different weight from exercise 1?
***********************************************************************************************

*Create and apply a filter to select those with a weight greater than 0. 
USE ALL.
COMPUTE filter_$=(PIWT18>0).
VARIABLE LABEL filter_$ 'PIWT18>0 (FILTER)'.
VALUE LABELS filter_$  0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE .

*Select only those in fulltime employment ****with valid income values*****
*Replace the three asterixs (*) with relevant values to complete the syntax below. 
select if (PIWT18>0) and (hourpay>=0 and hourpay<=100) and (inecac05=*) and (ftpt=* or ftpt=*).
execute.


***********************************************************************************************
*REVIEW QUESTIONS 2
*what were the correct values to complete the code?
Note - you can use the code below to check values and value labels for variables.
CODEBOOK inecac05 ftpt.
***********************************************************************************************
* Custom Tables.
FREQUENCIES sex.
CTABLES
  /VLABELS VARIABLES=grsswk sex DISPLAY=DEFAULT
  /TABLE sex BY grsswk [MEAN, MEDIAN, PTILE 10, PTILE 25, PTILE 75, PTILE 90]
  /CATEGORIES VARIABLES=sex ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER MISSING=EXCLUDE.

***********************************************************************************************
*REVIEW QUESTIONS 3
*what are median weekly earnings?
*what are earnings at the lowest decile for males and females? 
***********************************************************************************************
* Get a frequency table of sex to examine the gender breakdown of fulltime employees. 
FREQUENCIES SEX.

***********************************************************************************************
*REVIEW QUESTIONS 4
The ONS table associated with this report gives the estimated number of fulltime employees as 21,401,000. 
*Using the frequency above, we get 213, 15181. Why is there a difference? What steps above need to be different to get the 
correct estimate of the number of fulltime employees?
***********************************************************************************************

New file.
DATASET CLOSE ALL.

*WHAT NEXT?
*Move to the final exercise, which uses one of the longitundial datasets
* Or see if you can examine earnings for temporary workers or another sub-group of interest
*Reopen the full datafile and using GET FILE ="lfsp_od20_eul_pwt18.sav". and explore as you choose 




