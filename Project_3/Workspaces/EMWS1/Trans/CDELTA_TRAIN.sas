*------------------------------------------------------------*;
* Formula Code;
*------------------------------------------------------------*;

if NAME="INDELINQ" then do;
ROLE ="INPUT";
REPORT ="N";
LEVEL ="INTERVAL";
end;
if NAME="IMP_DELINQ" then delete;

if NAME="INDEROG" then do;
ROLE ="INPUT";
REPORT ="N";
LEVEL ="INTERVAL";
end;
if NAME="IMP_DEROG" then delete;

if NAME="LOG_yoj" then do;
ROLE ="INPUT";
REPORT ="N";
LEVEL ="INTERVAL";
end;
if NAME="IMP_YOJ" then delete;
