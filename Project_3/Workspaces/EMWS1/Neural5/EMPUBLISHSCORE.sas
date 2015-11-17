***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label GRP_IMP_CLAGE2 = 'Dummy: GRP_IMP_CLAGE=2' ;

      label GRP_IMP_CLAGE3 = 'Dummy: GRP_IMP_CLAGE=3' ;

      label GRP_IMP_CLAGE4 = 'Dummy: GRP_IMP_CLAGE=4' ;

      label GRP_IMP_DEBTINC2 = 'Dummy: GRP_IMP_DEBTINC=2' ;

      label GRP_IMP_DEBTINC3 = 'Dummy: GRP_IMP_DEBTINC=3' ;

      label GRP_IMP_DEBTINC4 = 'Dummy: GRP_IMP_DEBTINC=4' ;

      label GRP_IMP_NINQ1 = 'Dummy: GRP_IMP_NINQ=1' ;

      label GRP_IMP_NINQ2 = 'Dummy: GRP_IMP_NINQ=2' ;

      label GRP_IMP_NINQ3 = 'Dummy: GRP_IMP_NINQ=3' ;

      label GRP_INDELINQ3 = 'Dummy: GRP_INDELINQ=3' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label H14 = 'Hidden: H1=4' ;

      label H15 = 'Hidden: H1=5' ;

      label I_BAD = 'Into: BAD' ;

      label U_BAD = 'Unnormalized Into: BAD' ;

      label P_BAD1 = 'Predicted: BAD=1' ;

      label P_BAD0 = 'Predicted: BAD=0' ;

      label  _WARN_ = "Warnings";

*** Generate dummy variables for GRP_IMP_CLAGE ;
drop GRP_IMP_CLAGE2 GRP_IMP_CLAGE3 GRP_IMP_CLAGE4 ;
if missing( GRP_IMP_CLAGE ) then do;
   GRP_IMP_CLAGE2 = .;
   GRP_IMP_CLAGE3 = .;
   GRP_IMP_CLAGE4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_IMP_CLAGE , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '3'  then do;
      GRP_IMP_CLAGE2 = 0.63245553203367;
      GRP_IMP_CLAGE3 = -0.63245553203367;
      GRP_IMP_CLAGE4 = -0.63245553203367;
   end;
   else if _dm12 = '5'  then do;
      GRP_IMP_CLAGE2 = 0.63245553203367;
      GRP_IMP_CLAGE3 = 0.63245553203367;
      GRP_IMP_CLAGE4 = 0.63245553203367;
   end;
   else if _dm12 = '2'  then do;
      GRP_IMP_CLAGE2 = -0.63245553203367;
      GRP_IMP_CLAGE3 = -0.63245553203367;
      GRP_IMP_CLAGE4 = -0.63245553203367;
   end;
   else if _dm12 = '4'  then do;
      GRP_IMP_CLAGE2 = 0.63245553203367;
      GRP_IMP_CLAGE3 = 0.63245553203367;
      GRP_IMP_CLAGE4 = -0.63245553203367;
   end;
   else do;
      GRP_IMP_CLAGE2 = .;
      GRP_IMP_CLAGE3 = .;
      GRP_IMP_CLAGE4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_IMP_DEBTINC ;
drop GRP_IMP_DEBTINC2 GRP_IMP_DEBTINC3 GRP_IMP_DEBTINC4 ;
if missing( GRP_IMP_DEBTINC ) then do;
   GRP_IMP_DEBTINC2 = .;
   GRP_IMP_DEBTINC3 = .;
   GRP_IMP_DEBTINC4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_IMP_DEBTINC , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '3'  then do;
      GRP_IMP_DEBTINC2 = 0.63245553203367;
      GRP_IMP_DEBTINC3 = -0.63245553203367;
      GRP_IMP_DEBTINC4 = -0.63245553203367;
   end;
   else if _dm12 = '2'  then do;
      GRP_IMP_DEBTINC2 = -0.63245553203367;
      GRP_IMP_DEBTINC3 = -0.63245553203367;
      GRP_IMP_DEBTINC4 = -0.63245553203367;
   end;
   else if _dm12 = '5'  then do;
      GRP_IMP_DEBTINC2 = 0.63245553203367;
      GRP_IMP_DEBTINC3 = 0.63245553203367;
      GRP_IMP_DEBTINC4 = 0.63245553203367;
   end;
   else if _dm12 = '4'  then do;
      GRP_IMP_DEBTINC2 = 0.63245553203367;
      GRP_IMP_DEBTINC3 = 0.63245553203367;
      GRP_IMP_DEBTINC4 = -0.63245553203367;
   end;
   else do;
      GRP_IMP_DEBTINC2 = .;
      GRP_IMP_DEBTINC3 = .;
      GRP_IMP_DEBTINC4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_IMP_NINQ ;
drop GRP_IMP_NINQ1 GRP_IMP_NINQ2 GRP_IMP_NINQ3 ;
if missing( GRP_IMP_NINQ ) then do;
   GRP_IMP_NINQ1 = .;
   GRP_IMP_NINQ2 = .;
   GRP_IMP_NINQ3 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_IMP_NINQ , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      GRP_IMP_NINQ1 = -0.63245553203367;
      GRP_IMP_NINQ2 = -0.63245553203367;
      GRP_IMP_NINQ3 = -0.63245553203367;
   end;
   else if _dm12 = '2'  then do;
      GRP_IMP_NINQ1 = 0.63245553203367;
      GRP_IMP_NINQ2 = -0.63245553203367;
      GRP_IMP_NINQ3 = -0.63245553203367;
   end;
   else if _dm12 = '4'  then do;
      GRP_IMP_NINQ1 = 0.63245553203367;
      GRP_IMP_NINQ2 = 0.63245553203367;
      GRP_IMP_NINQ3 = 0.63245553203367;
   end;
   else if _dm12 = '3'  then do;
      GRP_IMP_NINQ1 = 0.63245553203367;
      GRP_IMP_NINQ2 = 0.63245553203367;
      GRP_IMP_NINQ3 = -0.63245553203367;
   end;
   else do;
      GRP_IMP_NINQ1 = .;
      GRP_IMP_NINQ2 = .;
      GRP_IMP_NINQ3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_INDELINQ ;
drop GRP_INDELINQ3 ;
if missing( GRP_INDELINQ ) then do;
   GRP_INDELINQ3 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_INDELINQ , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '3'  then do;
      GRP_INDELINQ3 = -1;
   end;
   else if _dm12 = '4'  then do;
      GRP_INDELINQ3 = 1;
   end;
   else do;
      GRP_INDELINQ3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
*** *************************;
*** Writing the Node ord ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.84162425217187 * GRP_IMP_CLAGE2  +     0.91394613895235 *
        GRP_IMP_CLAGE3  +     0.91372436571234 * GRP_IMP_CLAGE4
          +     1.21199529798407 * GRP_IMP_DEBTINC2  +     0.10023735854587 *
        GRP_IMP_DEBTINC3  +  1.0000000827403E-10 * GRP_IMP_DEBTINC4
          +      0.4030166160329 * GRP_IMP_NINQ1  +     0.34466117671511 *
        GRP_IMP_NINQ2  +  9.9999994396249E-11 * GRP_IMP_NINQ3
          +  1.0000000827403E-10 * GRP_INDELINQ3 ;
   H12  =     0.44318412836719 * GRP_IMP_CLAGE2  +     2.04152352764679 *
        GRP_IMP_CLAGE3  +  1.0000000827403E-10 * GRP_IMP_CLAGE4
          +     1.86395164971817 * GRP_IMP_DEBTINC2  +  1.0000000827403E-10 *
        GRP_IMP_DEBTINC3  +  9.9999994396249E-11 * GRP_IMP_DEBTINC4
          +     0.32412764649444 * GRP_IMP_NINQ1  +     0.19578732841955 *
        GRP_IMP_NINQ2  +     0.92053217056657 * GRP_IMP_NINQ3
          +  1.0000000133514E-10 * GRP_INDELINQ3 ;
   H13  =     0.28161058010309 * GRP_IMP_CLAGE2  +     0.89606737229768 *
        GRP_IMP_CLAGE3  +  1.0000000827403E-10 * GRP_IMP_CLAGE4
          +     1.44402290031604 * GRP_IMP_DEBTINC2  +  1.0000000133514E-10 *
        GRP_IMP_DEBTINC3  +     0.40839697317136 * GRP_IMP_DEBTINC4
          +  1.0000000827403E-10 * GRP_IMP_NINQ1  +     0.65521944084878 *
        GRP_IMP_NINQ2  +  1.0000000133514E-10 * GRP_IMP_NINQ3
          +     1.52717150748592 * GRP_INDELINQ3 ;
   H14  =  1.0000000133514E-10 * GRP_IMP_CLAGE2  +     0.42156928311284 *
        GRP_IMP_CLAGE3  +     0.20105839863856 * GRP_IMP_CLAGE4
          +     0.31105435980584 * GRP_IMP_DEBTINC2  +     0.50830792932042 *
        GRP_IMP_DEBTINC3  +  1.0000000827403E-10 * GRP_IMP_DEBTINC4
          +     0.04419961855017 * GRP_IMP_NINQ1  +     0.02908901113418 *
        GRP_IMP_NINQ2  +     0.07418371374931 * GRP_IMP_NINQ3
          +      0.0380118013461 * GRP_INDELINQ3 ;
   H15  =  1.0000000133514E-10 * GRP_IMP_CLAGE2  +  9.9999994396249E-11 *
        GRP_IMP_CLAGE3  +     0.61981433688837 * GRP_IMP_CLAGE4
          +      1.3235985600726 * GRP_IMP_DEBTINC2  +  1.0000000827403E-10 *
        GRP_IMP_DEBTINC3  +     0.63969853377089 * GRP_IMP_DEBTINC4
          +  9.9999994396249E-11 * GRP_IMP_NINQ1  +     0.43670668517942 *
        GRP_IMP_NINQ2  +     0.12517306001487 * GRP_IMP_NINQ3
          +      0.4202953626148 * GRP_INDELINQ3 ;
   H11  =     1.27322598653348 + H11 ;
   H12  =     1.00173288370604 + H12 ;
   H13  =    -2.19477141796525 + H13 ;
   H14  =    -0.41073547330617 + H14 ;
   H15  =     1.52044566991639 + H15 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
END;
*** *************************;
*** Writing the Node BAD ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_BAD1  =    -2.64403957786331 * H11  +     2.41620588643142 * H12
          +     1.12237375231097 * H13  +    -3.79942630995982 * H14
          +     2.96546954408798 * H15 ;
   P_BAD1  =    -3.74774044260044 + P_BAD1 ;
   P_BAD0  = 0;
   _MAX_ = MAX (P_BAD1 , P_BAD0 );
   _SUM_ = 0.;
   P_BAD1  = EXP(P_BAD1  - _MAX_);
   _SUM_ = _SUM_ + P_BAD1 ;
   P_BAD0  = EXP(P_BAD0  - _MAX_);
   _SUM_ = _SUM_ + P_BAD0 ;
   P_BAD1  = P_BAD1  / _SUM_;
   P_BAD0  = P_BAD0  / _SUM_;
END;
ELSE DO;
   P_BAD1  = .;
   P_BAD0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_BAD1  =     0.19939577039274;
   P_BAD0  =     0.80060422960725;
END;
*** *************************;
*** Writing the I_BAD  AND U_BAD ;
*** *************************;
_MAXP_ = P_BAD1 ;
I_BAD  = "1           " ;
U_BAD  =                    1;
IF( _MAXP_ LT P_BAD0  ) THEN DO;
   _MAXP_ = P_BAD0 ;
   I_BAD  = "0           " ;
   U_BAD  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
H11
H12
H13
H14
H15
;
