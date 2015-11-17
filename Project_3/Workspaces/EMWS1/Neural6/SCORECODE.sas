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
   H11  =  1.0000000827403E-10 * GRP_IMP_CLAGE2  +  1.0000000827403E-10 * 
        GRP_IMP_CLAGE3  +  9.9999994396249E-11 * GRP_IMP_CLAGE4
          +     0.39611532196021 * GRP_IMP_DEBTINC2  +  9.9999994396249E-11 * 
        GRP_IMP_DEBTINC3  +  1.0000000827403E-10 * GRP_IMP_DEBTINC4
          +  1.0000000827403E-10 * GRP_IMP_NINQ1  +     0.11502747149719 * 
        GRP_IMP_NINQ2  +     0.10024614185186 * GRP_IMP_NINQ3
          +     0.19716792178802 * GRP_INDELINQ3 ;
   H11  =     0.39348243075107 + H11 ;
   H11  = TANH(H11 );
END;
ELSE DO;
   H11  = .;
END;
*** *************************;
*** Writing the Node BAD ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_BAD1  =      4.2492734342721 * H11 ;
   P_BAD1  =    -3.07454550795861 + P_BAD1 ;
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
