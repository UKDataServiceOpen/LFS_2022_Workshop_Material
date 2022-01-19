
// LFS WORKSHOP PRACTICAL SESSION
// Exercise 1: estimates of temporary employment

// This exercise recreates ONS labour market analysis reported in the table EMP07 Temporary Employees
//https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/datasets/temporaryemployeesemp07. [last accessed 24/04/2021]
// This table is updated four times a year in February, May, August and November using the Quarterly Labour Force Survey. 
// The data used relates to an estimate for Oct-December 2020.
// Data: Quarterly Labour Force Survey, October - December, 2020, accessible from the UK Data Service (http://doi.org/10.5255/UKDA-SN-8777-3)

// Get set up. 
// You will need to access the data (see above)/ 

// clear memory
clear all
// Set directory. - you need to add the correct file path for your computer, where is the data saved?.

cd "C:\Users\niged\OneDrive\Documents\jobs\Manchester\UKDA-8777-stata\stata\stata13"
use "lfsp_od20_eul_pwt18.dta"
keep PWT18 JBTP101 FTPT INECAC05 JOBTYP SEX
save "lfs_od20_practical1_temp", replace

// Examine variables.
tab1 JBTP101 FTPT INECAC05 JOBTYP SEX

***********************************************************************************************
//REVIEW QUESTIONS 
// How many cases are there?
// What does the variable inecac05 relate to?
// Why are there many missing cases on the variables: jbtp101, ftpt and jobtyp. 
***********************************************************************************************
// Apply the weight and examine the variable frequencies again. 
tab1 JBTP101 FTPT INECAC05 JOBTYP SEX [fw=PWT18]

***********************************************************************************************
// REVIEW QUESTIONS 
// Do the frequencies change noticeably when the weight is applied? 
*********************************************************************************************** 
// run this code to adjust the category order and labels. 

recode  JBTP101 (3=1 "Seasonal work") ///
				(4=2 "Done under contract for a fixed period") /// 
				(1=3 "Agency Temping") ///
				(2=4 "Casual type of work") ///
				(5=5 "Some other reason") ///
				(-8 -9=6 "Missing"), gen(JOBTMP)

// Create and apply a filter to select those with a weight greater than 0. 				
keep if PWT18>0

// Create a variable to indicate those working part time.
recode FTPT (1 3=0 "Full time") (2 4=1 "Part time") ///
			(-8 -9=3 "Not stated"), gen(PARTTIME)

// Select relevant cases
keep if JOBTYP==2 & INECAC05==1

***********************************************************************************************
// REVIEW QUESTIONS 
// Which cases are selected using the above code?
***********************************************************************************************

table (JOBTMP SEX) (PARTTIME)

table (JOBTMP) (SEX PARTTIME) [fw=PWT18]