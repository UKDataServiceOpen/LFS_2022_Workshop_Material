/keep PWT18 sex ilodefr  ethukeul inecac05 age.

weight by PWT18.

USE ALL.
COMPUTE filter_$=(PWT18>0).
VARIABLE LABEL filter_$ 'PWT18>0 (FILTER)'.
VALUE LABELS filter_$  0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE .

DO IF (sex = 1) .
RECODE
  age
  (16 thru 64=1) INTO  WRKAGE.
END IF .
EXECUTE .

DO IF (sex = 2) .
RECODE
  age
  (16 thru 64=2) INTO  WRKAGE.
END IF .
EXECUTE .

Value labels  WRKAGE
1 'Male 16-64'
2 'Female 16-64'.


recode ethukeul (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7=7) (8=8) (-8,-9=10) (9=9) Into Ethen.
value labels Ethen
1 'White	'
2 'Mixed'	
3 'Indian'	
4 'Pakistani'	
5 'Bangladeshi'	
6 'Chinese'	
7 'Other Asian'	
8 'Black/African/Caribbean'	
9 'Other'
10 'NA'.	


recode inecac05 (1=1) Into inecac05EMPE.
value labels inecac05EMPE
1 'Employee'.

recode inecac05 (2=1) Into inecac05SEMP.
value labels inecac05SEMP
1 'Self Employed'.

recode ilodefr (1=1) Into ilodefrEMP.
value labels ilodefrEMP
1 'Employment'.

recode ilodefr (2=1) Into ilodefrUNEMP.
value labels ilodefrUNEMP
1 'Unemployment'.

recode ilodefr (1, 2=1) Into ilodefrACT.
value labels ilodefrACT
1 'Economically Active'.

recode ilodefr (3=1) Into ilodefrINACT.
value labels ilodefrINACT
1 'Inactive'.

recode ilodefr (1, 2, 3=1) Into ilodefr16.
value labels ilodefr16
1 'All Persons aged 16+'.

recode WRKAGE (1, 2=1) Into MF5964WA.
value labels MF5964WA
1 'Working Age'.


* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Ethen WRKAGE ilodefrACT ilodefrINACT ilodefrEMP ilodefrUNEMP inecac05EMPE inecac05SEMP sex ilodefr16
    DISPLAY=DEFAULT
  /TABLE WRKAGE [C] > (ilodefrACT [C] + ilodefrINACT [C] + ilodefrEMP [C] + ilodefrUNEMP [C] + inecac05EMPE [C] +
  inecac05SEMP [C]) + sex > ilodefr16 [C] > (ilodefrACT [C] + ilodefrINACT [C] + ilodefrEMP [C] + ilodefrUNEMP [C] +
  inecac05EMPE [C] + inecac05SEMP [C]) + sex BY Ethen [C][COUNT F40.0]
  /CATEGORIES VARIABLES=Ethen WRKAGE ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=ilodefrACT ilodefrINACT ilodefrEMP ilodefrUNEMP inecac05EMPE inecac05SEMP ilodefr16 ORDER=A KEY=VALUE
  EMPTY=INCLUDE
  /CATEGORIES VARIABLES=sex ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER MISSING=INCLUDE.

weight Off.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Ethen WRKAGE ilodefrACT ilodefrINACT ilodefrEMP ilodefrUNEMP inecac05EMPE inecac05SEMP sex ilodefr16
    DISPLAY=DEFAULT
  /TABLE WRKAGE [C] > (ilodefrACT [C] + ilodefrINACT [C] + ilodefrEMP [C] + ilodefrUNEMP [C] + inecac05EMPE [C] +
  inecac05SEMP [C]) + sex > ilodefr16 [C] > (ilodefrACT [C] + ilodefrINACT [C] + ilodefrEMP [C] + ilodefrUNEMP [C] +
  inecac05EMPE [C] + inecac05SEMP [C]) + sex BY Ethen [C][COUNT F40.0]
  /CATEGORIES VARIABLES=Ethen WRKAGE ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=ilodefrACT ilodefrINACT ilodefrEMP ilodefrUNEMP inecac05EMPE inecac05SEMP ilodefr16 ORDER=A KEY=VALUE
  EMPTY=INCLUDE
  /CATEGORIES VARIABLES=sex ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER MISSING=INCLUDE.



New file.

DATASET CLOSE All.
