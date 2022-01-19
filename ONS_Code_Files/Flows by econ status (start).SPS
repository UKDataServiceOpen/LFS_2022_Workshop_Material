/Keep ages2 age2 lgwt18 emplen1 emplen2 flow sex ilodefr1 ilodefr2 INCAC051 INCAC052 SC10MMJ1 SC10MMJ2 in792sm2 in792sm1.

USE ALL.
COMPUTE filter_$=(RANGE(AGE2,16,64)).
VARIABLE LABEL filter_$ 'RANGE(AGE2,16,64) (FILTER)'.
VALUE LABELS filter_$  0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE .

WEIGHT  BY lgwt18.


FREQUENCIES
  VARIABLES=flow
  /ORDER=  ANALYSIS .
USE ALL.
EXECUTE .


USE ALL.
COMPUTE filter_$=(ilodefr1= 1  & EMPLEN2 = 1).
VARIABLE LABEL filter_$ 'ilodefr1  & EMPLEN2 = 1 (FILTER)'.
VALUE LABELS filter_$  0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE .

VARIABLE LEVEL FLOW (NOMINAL).

WEIGHT  BY lgwt18.

FREQUENCIES
  VARIABLES=flow
  /ORDER=  ANALYSIS .
USE ALL.
EXECUTE .


USE ALL.
COMPUTE filter_$=(RANGE(AGE2,16,64)).
VARIABLE LABEL filter_$ 'RANGE(AGE2,16,64) (FILTER)'.
VALUE LABELS filter_$  0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE .

WEIGHT  BY lgwt18.


RECODE
  INCAC051
  (1=1)  (2=2)  (3=1)  (4=1) (5=3) (6 thru 33 = 4) (-9 thru -8=99)   INTO  eco1 .
VARIABLE LABELS eco1 'eco1'.
VARIABLE LEVEL eco1 (NOMINAL).

VALUE LABELS eco1 
1 'Employee +' 
2 'Self-Employed'
3 'Unemployed'
4 'Inactive'
99 'NA/DNA'.
EXECUTE .

RECODE
  INCAC052
  (1=1)  (2=2)  (3=1)  (4=1) (5=3) (6 thru 33 = 4) (-9 thru -8=99)   INTO  eco2 .
VARIABLE LABELS eco2 'eco2'.
VARIABLE LEVEL eco2 (NOMINAL).

VALUE LABELS eco2 
1 'Employee +' 
2 'Self-Employed'
3 'Unemployed'
4 'Inactive'
99 'NA/DNA'.
EXECUTE .

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=eco2 eco1 DISPLAY=DEFAULT
  /TABLE eco1 [COUNT F40.0] BY eco2
  /CATEGORIES VARIABLES=eco2 eco1 ORDER=A KEY=VALUE EMPTY=INCLUDE MISSING=EXCLUDE.


USE ALL.
COMPUTE filter_$=(RANGE(AGE2,16,69)).
VARIABLE LABEL filter_$ 'RANGE(AGE2,16,64) (FILTER)'.
VALUE LABELS filter_$  0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE .

WEIGHT  BY lgwt18.
SELECT IF range(age2, 16,69).

FREQUENCIES
  VARIABLES=flow
  /ORDER=  ANALYSIS .
USE ALL.
EXECUTE .

New file.

DATASET CLOSE ALL.