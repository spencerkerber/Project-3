*------------------------------------------------------------* ;
* EM: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    BAD(DESC) IMP_JOB(ASC) IMP_REASON(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* EM: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    IMP_CLAGE IMP_CLNO IMP_DEBTINC IMP_DELINQ IMP_DEROG IMP_MORTDUE IMP_NINQ
   IMP_VALUE IMP_YOJ LOAN
%mend DMDBVar;
*------------------------------------------------------------*;
* EM: Create DMDB;
*------------------------------------------------------------*;
libname _spdslib SPDE "C:\Users\sakerb01\AppData\Local\Temp\SAS Temporary Files\_TD4856_COB-IT-M11_\Prc2";
proc dmdb batch data=EMWS1.Impt_TRAIN
dmdbcat=WORK.EM_DMDB
maxlevel = 101
out=_spdslib.EM_DMDB
;
class %DMDBClass;
var %DMDBVar;
target
BAD
;
run;
quit;
*------------------------------------------------------------* ;
* Varsel: Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INPUTS;
               IMP_CLAGE IMP_CLNO IMP_DEBTINC IMP_DELINQ IMP_DEROG IMP_JOB IMP_MORTDUE
   IMP_NINQ IMP_REASON IMP_VALUE IMP_YOJ LOAN
%mend INPUTS;
proc dmine data=_spdslib.EM_DMDB dmdbcat=WORK.EM_DMDB
minr2=0.005 maxrows=3000 stopr2=0.0005 NOAOV16 NOINTER USEGROUPS OUTGROUP=EMWS1.Varsel_OUTGROUP outest=EMWS1.Varsel_OUTESTDMINE outeffect=EMWS1.Varsel_OUTEFFECT outrsquare =EMWS1.Varsel_OUTRSQUARE
NOMONITOR
PSHORT
;
var %INPUTS;
target BAD;
code file="C:\Users\sakerb01\Desktop\SAS EM 12.3 Tutorials _ Projects\Project_3\Workspaces\EMWS1\Varsel\EMFLOWSCORE.sas";
code file="C:\Users\sakerb01\Desktop\SAS EM 12.3 Tutorials _ Projects\Project_3\Workspaces\EMWS1\Varsel\EMPUBLISHSCORE.sas";
run;
quit;
/*      proc print data =EMWS1.Varsel_OUTEFFECT;      proc print data =EMWS1.Varsel_OUTRSQUARE;      */
run;
