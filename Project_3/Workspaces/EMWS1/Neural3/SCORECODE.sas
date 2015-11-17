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
      label S_IMP_CLAGE = 'Standard: IMP_CLAGE' ;

      label S_IMP_DEBTINC = 'Standard: IMP_DEBTINC' ;

      label S_IMP_DELINQ = 'Standard: IMP_DELINQ' ;

      label S_IMP_DEROG = 'Standard: IMP_DEROG' ;

      label S_IMP_NINQ = 'Standard: IMP_NINQ' ;

      label S_IMP_YOJ = 'Standard: IMP_YOJ' ;

      label G_IMP_JOB0 = 'Dummy: G_IMP_JOB=0' ;

      label G_IMP_JOB1 = 'Dummy: G_IMP_JOB=1' ;

      label G_IMP_JOB2 = 'Dummy: G_IMP_JOB=2' ;

      label G_IMP_JOB3 = 'Dummy: G_IMP_JOB=3' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label I_BAD = 'Into: BAD' ;

      label U_BAD = 'Unnormalized Into: BAD' ;

      label P_BAD1 = 'Predicted: BAD=1' ;

      label P_BAD0 = 'Predicted: BAD=0' ;

      label  _WARN_ = "Warnings"; 

*** Generate dummy variables for G_IMP_JOB ;
drop G_IMP_JOB0 G_IMP_JOB1 G_IMP_JOB2 G_IMP_JOB3 ;
*** encoding is sparse, initialize to zero;
G_IMP_JOB0 = 0;
G_IMP_JOB1 = 0;
G_IMP_JOB2 = 0;
G_IMP_JOB3 = 0;
if missing( G_IMP_JOB ) then do;
   G_IMP_JOB0 = .;
   G_IMP_JOB1 = .;
   G_IMP_JOB2 = .;
   G_IMP_JOB3 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( G_IMP_JOB , BEST12. );
   %DMNORMIP( _dm12 )
   _dm_find = 0; drop _dm_find;
   if _dm12 <= '2'  then do;
      if _dm12 <= '1'  then do;
         if _dm12 = '0'  then do;
            G_IMP_JOB0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '1'  then do;
               G_IMP_JOB1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm12 = '2'  then do;
            G_IMP_JOB2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm12 = '3'  then do;
         G_IMP_JOB3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm12 = '4'  then do;
            G_IMP_JOB0 = -1;
            G_IMP_JOB1 = -1;
            G_IMP_JOB2 = -1;
            G_IMP_JOB3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      G_IMP_JOB0 = .;
      G_IMP_JOB1 = .;
      G_IMP_JOB2 = .;
      G_IMP_JOB3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   IMP_CLAGE , 
   IMP_DEBTINC , 
   IMP_DELINQ , 
   IMP_DEROG , 
   IMP_NINQ , 
   IMP_YOJ   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_IMP_CLAGE  =     -2.1324986323703 +     0.01177180625915 * IMP_CLAGE ;
   S_IMP_DEBTINC  =    -4.21130359350115 +     0.12464292126092 * IMP_DEBTINC
         ;
   S_IMP_DELINQ  =    -0.40381023676556 +     0.87362166360406 * IMP_DELINQ ;
   S_IMP_DEROG  =    -0.31573464531037 +     1.31032371760165 * IMP_DEROG ;
   S_IMP_NINQ  =     -0.7098195299189 +     0.61350782376294 * IMP_NINQ ;
   S_IMP_YOJ  =    -1.21374892345752 +     0.13686286372334 * IMP_YOJ ;
END;
ELSE DO;
   IF MISSING( IMP_CLAGE ) THEN S_IMP_CLAGE  = . ;
   ELSE S_IMP_CLAGE  =     -2.1324986323703 +     0.01177180625915 * IMP_CLAGE
         ;
   IF MISSING( IMP_DEBTINC ) THEN S_IMP_DEBTINC  = . ;
   ELSE S_IMP_DEBTINC  =    -4.21130359350115 +     0.12464292126092 * 
        IMP_DEBTINC ;
   IF MISSING( IMP_DELINQ ) THEN S_IMP_DELINQ  = . ;
   ELSE S_IMP_DELINQ  =    -0.40381023676556 +     0.87362166360406 * 
        IMP_DELINQ ;
   IF MISSING( IMP_DEROG ) THEN S_IMP_DEROG  = . ;
   ELSE S_IMP_DEROG  =    -0.31573464531037 +     1.31032371760165 * IMP_DEROG
         ;
   IF MISSING( IMP_NINQ ) THEN S_IMP_NINQ  = . ;
   ELSE S_IMP_NINQ  =     -0.7098195299189 +     0.61350782376294 * IMP_NINQ ;
   IF MISSING( IMP_YOJ ) THEN S_IMP_YOJ  = . ;
   ELSE S_IMP_YOJ  =    -1.21374892345752 +     0.13686286372334 * IMP_YOJ ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.33653827868869 * S_IMP_CLAGE  +    -0.75289827647212 * 
        S_IMP_DEBTINC  +    -0.22919317194108 * S_IMP_DELINQ
          +    -0.07417183485472 * S_IMP_DEROG  +     0.04322962980493 * 
        S_IMP_NINQ  +     0.03618310076915 * S_IMP_YOJ ;
   H12  =    -0.26607888311404 * S_IMP_CLAGE  +     9.30326546746983 * 
        S_IMP_DEBTINC  +     0.16111470976117 * S_IMP_DELINQ
          +     0.06929894104172 * S_IMP_DEROG  +     0.06020512837372 * 
        S_IMP_NINQ  +    -0.15828595201535 * S_IMP_YOJ ;
   H13  =    -2.26408457785795 * S_IMP_CLAGE  +    -1.97906405407195 * 
        S_IMP_DEBTINC  +    -0.45846543885283 * S_IMP_DELINQ
          +    -0.29670156817859 * S_IMP_DEROG  +    -2.14640009307261 * 
        S_IMP_NINQ  +    -0.11749803911456 * S_IMP_YOJ ;
   H11  = H11  +    -0.17581447730619 * G_IMP_JOB0  +     0.03490438931354 * 
        G_IMP_JOB1  +     -0.0634954402918 * G_IMP_JOB2
          +     0.00825551842383 * G_IMP_JOB3 ;
   H12  = H12  +     0.50719377861698 * G_IMP_JOB0  +     0.15550585127268 * 
        G_IMP_JOB1  +     0.23902812349072 * G_IMP_JOB2
          +     0.39696990874501 * G_IMP_JOB3 ;
   H13  = H13  +    -1.37904541391227 * G_IMP_JOB0  +    -0.67438652615848 * 
        G_IMP_JOB1  +     0.70324186886517 * G_IMP_JOB2
          +     0.70838092892535 * G_IMP_JOB3 ;
   H11  =     0.52240125542592 + H11 ;
   H12  =    -2.07147600119511 + H12 ;
   H13  =    -0.79686311280305 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node BAD ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_BAD1  =    -4.95136598500677 * H11  +    -2.42862862595734 * H12
          +    -0.88134755054033 * H13 ;
   P_BAD1  =    -0.82314411789937 + P_BAD1 ;
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
