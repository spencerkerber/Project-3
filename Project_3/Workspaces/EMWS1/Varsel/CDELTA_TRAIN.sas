if upcase(name) = 'IMP_CLNO' then role = 'REJECTED';
else
if upcase(name) = 'IMP_JOB' then role = 'REJECTED';
else
if upcase(name) = 'IMP_MORTDUE' then role = 'REJECTED';
else
if upcase(name) = 'IMP_REASON' then role = 'REJECTED';
else
if upcase(name) = 'IMP_VALUE' then role = 'REJECTED';
else
if upcase(name) = 'LOAN' then role = 'REJECTED';
if upcase(strip(name)) = "G_IMP_JOB" then level = "NOMINAL";
