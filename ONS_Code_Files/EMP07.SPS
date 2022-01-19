/keep PWT18 jbtp101 ftpt inecac05 jobtyp sex.

weight by PWT18.

recode  jbtp101 (3=1) (4=2) (1=3) (2=4) (5=5) (-8,-9=6)Into JobTmp.
value labels JobTmp
1 'Seasonal work'
2 'Done under contract for a fixed period'
3 'Agency Temping'
4 'Casual type of work'
5 'Some other reason'
6 'Missing -8 & -9'.


USE ALL.
COMPUTE filter_$=(PWT18>0).
VARIABLE LABEL filter_$ 'PWT18>0 (FILTER)'.
VALUE LABELS filter_$  0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE .
recode ftpt (2,4=1) Into PartTime.
value labels PartTime
1 'Part Time'.

select if (jobtyp=2) and (inecac05=1).
execute.


* Custom Tables.
CTABLES
  /VLABELS VARIABLES=JobTmp PartTime sex DISPLAY=DEFAULT
  /TABLE sex BY JobTmp [C][COUNT F40.0] + JobTmp [C] > PartTime [C][COUNT F40.0]
  /CATEGORIES VARIABLES=JobTmp [6, 1, 2, 3, 4, 5, OTHERNM] EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=PartTime ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=sex ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER MISSING=INCLUDE.

Weight Off.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=JobTmp PartTime sex DISPLAY=DEFAULT
  /TABLE sex BY JobTmp [C][COUNT F40.0] + JobTmp [C] > PartTime [C][COUNT F40.0]
  /CATEGORIES VARIABLES=JobTmp [6, 1, 2, 3, 4, 5, OTHERNM] EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=PartTime ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=sex ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER MISSING=INCLUDE.

New file.

DATASET CLOSE ALL.