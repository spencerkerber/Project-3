*------------------------------------------------------------*;
* Neural4: Create decision matrix;
*------------------------------------------------------------*;
data WORK.BAD(label="BAD");
  length   BAD                              $  32
           COUNT                                8
           DATAPRIOR                            8
           TRAINPRIOR                           8
           DECPRIOR                             8
           DECISION1                            8
           DECISION2                            8
           ;

  label    COUNT="Level Counts"
           DATAPRIOR="Data Proportions"
           TRAINPRIOR="Training Proportions"
           DECPRIOR="Decision Priors"
           DECISION1="1"
           DECISION2="0"
           ;
BAD="1"; COUNT=594; DATAPRIOR=0.19939577039274; TRAINPRIOR=0.19939577039274; DECPRIOR=.; DECISION1=1; DECISION2=0;
output;
BAD="0"; COUNT=2385; DATAPRIOR=0.80060422960725; TRAINPRIOR=0.80060422960725; DECPRIOR=.; DECISION1=0; DECISION2=1;
output;
;
run;
proc datasets lib=work nolist;
modify BAD(type=PROFIT label=BAD);
label DECISION1= '1';
label DECISION2= '0';
run;
quit;
data EM_Neural4;
set EMWS1.BINNING_TRAIN(keep=
BAD GRP_IMP_CLAGE GRP_IMP_DEBTINC GRP_IMP_NINQ GRP_INDELINQ );
run;
*------------------------------------------------------------* ;
* Neural4: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    BAD(DESC) GRP_IMP_CLAGE(ASC) GRP_IMP_DEBTINC(ASC) GRP_IMP_NINQ(ASC)
   GRP_INDELINQ(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural4: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;

%mend DMDBVar;
*------------------------------------------------------------*;
* Neural4: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural4
dmdbcat=WORK.Neural4_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
BAD
;
run;
quit;
*------------------------------------------------------------* ;
* Neural4: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;

%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural4: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural4: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;

%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural4: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;
    GRP_IMP_CLAGE GRP_IMP_DEBTINC GRP_IMP_NINQ GRP_INDELINQ
%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural4 dmdbcat=WORK.Neural4_DMDB
validdata = EMWS1.BINNING_VALIDATE
random=12345
;
nloptions
;
performance alldetails noutilfile;
netopts
decay=0;
input %ORDINPUTS / level=ordinal id=ord
;
target BAD / level=NOMINAL id=BAD
bias
;
arch MLP
Hidden=3
;
Prelim 5 preiter=10
pretime=3600
Outest=EMWS1.Neural4_PRELIM_OUTEST
;
save network=EMWS1.Neural4_NETWORK.dm_neural;
train Maxiter=50
maxtime=14400
Outest=EMWS1.Neural4_outest estiter=1
Outfit=EMWS1.Neural4_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural4_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural4;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural4(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural4_INITIAL;
set EMWS1.Neural4_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural4 dmdbcat=WORK.Neural4_DMDB
validdata = EMWS1.BINNING_VALIDATE
network = EMWS1.Neural4_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural4_INITIAL;
train tech=NONE;
code file="C:\Users\sakerb01\Desktop\SAS EM 12.3 Tutorials _ Projects\Project_3\Workspaces\EMWS1\Neural4\SCORECODE.sas"
group=Neural4
;
;
code file="C:\Users\sakerb01\Desktop\SAS EM 12.3 Tutorials _ Projects\Project_3\Workspaces\EMWS1\Neural4\RESIDUALSCORECODE.sas"
group=Neural4
residual
;
;
score data=EMWS1.BINNING_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural4_OUTKEY;
score data=EMWS1.BINNING_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural4_OUTKEY;
run;
quit;
data EMWS1.Neural4_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural4_EMESTIMATE;
set EMWS1.Neural4_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural4;
run;
quit;
