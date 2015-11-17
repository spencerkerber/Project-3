/*----G_IMP_JOB begin----*/
length _NORM7 $ 7;
%DMNORMCP( IMP_JOB , _NORM7 )
drop _NORM7;
select(_NORM7);
when("MGR    " ) G_IMP_JOB = 1;
when("OFFICE " ) G_IMP_JOB = 4;
when("OTHER  " ) G_IMP_JOB = 2;
when("PROFEXE" ) G_IMP_JOB = 3;
when("SALES  " ) G_IMP_JOB = 0;
when("SELF   " ) G_IMP_JOB = 1;
otherwise substr(_WARN_, 2, 1) = 'U';
end;
label G_IMP_JOB="Grouped Levels for IMP_JOB";
/*----G_IMP_JOB end----*/
