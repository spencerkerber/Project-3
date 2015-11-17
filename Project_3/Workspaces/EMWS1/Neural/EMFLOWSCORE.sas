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
      F_BAD  $ 12
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

      label H14 = 'Hidden: H1=4' ;

      label H15 = 'Hidden: H1=5' ;

      label I_BAD = 'Into: BAD' ;

      label F_BAD = 'From: BAD' ;

      label U_BAD = 'Unnormalized Into: BAD' ;

      label P_BAD1 = 'Predicted: BAD=1' ;

      label R_BAD1 = 'Residual: BAD=1' ;

      label P_BAD0 = 'Predicted: BAD=0' ;

      label R_BAD0 = 'Residual: BAD=0' ;

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
   H11  =     0.58729800213932 * S_IMP_CLAGE  +    -2.34686795798741 *
        S_IMP_DEBTINC  +    -0.06699115283235 * S_IMP_DELINQ
          +    -0.51770331267765 * S_IMP_DEROG  +     0.09607133016041 *
        S_IMP_NINQ  +    -0.38253146953445 * S_IMP_YOJ ;
   H12  =     0.03707251252663 * S_IMP_CLAGE  +     32.7627346836811 *
        S_IMP_DEBTINC  +     0.00508911864681 * S_IMP_DELINQ
          +     0.04895724984593 * S_IMP_DEROG  +    -0.17027829293006 *
        S_IMP_NINQ  +     0.00124180413719 * S_IMP_YOJ ;
   H13  =     0.14916936157583 * S_IMP_CLAGE  +     25.2686268707396 *
        S_IMP_DEBTINC  +     0.02014122564755 * S_IMP_DELINQ
          +      -0.171619531484 * S_IMP_DEROG  +    -0.16035663388263 *
        S_IMP_NINQ  +      -0.092036922923 * S_IMP_YOJ ;
   H14  =     2.25889157201296 * S_IMP_CLAGE  +     0.28492080847695 *
        S_IMP_DEBTINC  +      0.5249733361329 * S_IMP_DELINQ
          +    -1.19857425393824 * S_IMP_DEROG  +     1.13892105600959 *
        S_IMP_NINQ  +     2.26778246599839 * S_IMP_YOJ ;
   H15  =    -0.17345558122763 * S_IMP_CLAGE  +     0.22445075997402 *
        S_IMP_DEBTINC  +    -0.49046368048744 * S_IMP_DELINQ
          +     0.34310775696216 * S_IMP_DEROG  +    -0.30707858970334 *
        S_IMP_NINQ  +    -0.13645064986779 * S_IMP_YOJ ;
   H11  = H11  +     0.54222378087002 * G_IMP_JOB0  +    -0.48965402720997 *
        G_IMP_JOB1  +     0.06975017608734 * G_IMP_JOB2
          +    -0.34586970375181 * G_IMP_JOB3 ;
   H12  = H12  +    -0.11831470850165 * G_IMP_JOB0  +     0.17766733141037 *
        G_IMP_JOB1  +    -0.18309466705273 * G_IMP_JOB2
          +     0.05699093421242 * G_IMP_JOB3 ;
   H13  = H13  +    -0.04970367901613 * G_IMP_JOB0  +     -0.1390306943278 *
        G_IMP_JOB1  +     -0.0679951554559 * G_IMP_JOB2
          +     0.05695730175464 * G_IMP_JOB3 ;
   H14  = H14  +     1.57845513003555 * G_IMP_JOB0  +      2.5363704113924 *
        G_IMP_JOB1  +    -1.38461798652148 * G_IMP_JOB2
          +     1.70232354078576 * G_IMP_JOB3 ;
   H15  = H15  +    -0.75998512952973 * G_IMP_JOB0  +    -0.06049976159353 *
        G_IMP_JOB1  +      0.1048278032579 * G_IMP_JOB2
          +     0.04061065892327 * G_IMP_JOB3 ;
   H11  =     3.62607963134042 + H11 ;
   H12  =     0.81465395661678 + H12 ;
   H13  =    -0.25900833088053 + H13 ;
   H14  =    -1.52846199129323 + H14 ;
   H15  =      0.7343610624492 + H15 ;
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

*** Generate dummy variables for BAD ;
drop BAD1 BAD0 ;
label F_BAD = 'From: BAD' ;
length F_BAD $ 12;
F_BAD = put( BAD , BEST12. );
%DMNORMIP( F_BAD )
if missing( BAD ) then do;
   BAD1 = .;
   BAD0 = .;
end;
else do;
   if F_BAD = '0'  then do;
      BAD1 = 0;
      BAD0 = 1;
   end;
   else if F_BAD = '1'  then do;
      BAD1 = 1;
      BAD0 = 0;
   end;
   else do;
      BAD1 = .;
      BAD0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_BAD1  =    -4.53042429297557 * H11  +     3.90768655087799 * H12
          +    -3.38300098884084 * H13  +    -1.51169140671043 * H14
          +    -3.44226582148895 * H15 ;
   P_BAD1  =     2.70820978933811 + P_BAD1 ;
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
*** *****************************;
*** Writing the Residuals  of the Node BAD ;
*** ******************************;
IF MISSING( BAD1 ) THEN R_BAD1  = . ;
ELSE R_BAD1  = BAD1  - P_BAD1 ;
IF MISSING( BAD0 ) THEN R_BAD0  = . ;
ELSE R_BAD0  = BAD0  - P_BAD0 ;
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
drop S_:;
