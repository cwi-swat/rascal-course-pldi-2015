module java::JavaTestCoverage

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import java::JUnit;

rel[loc,loc] getCalls(M3 m) 
  = m@methodInvocation
  + m@methodInvocation o m@methodOverrides<1,0>
  ; 
  
set[loc] publicMethods(M3 m)
  = { f | f <- methods(m), \public() in m@modifiers[f]}
  ;
    
set[loc] notTouchedByUnitTests(M3 m)
  = methods(m) 
  - testMethods(m) 
  - ignoredMethods(m) 
  - constructors(m) 
  - (getCalls(m)+)[testMethods(m)];
  
set[loc] notDirectlyUnitTested(M3 m)
  = methods(m) 
  - testMethods(m) 
  - ignoredMethods(m)
  - constructors(m) 
  - getCalls(m)[testMethods(m)]
  ;
  
set[loc] deadMethods(M3 m) = methods(m) - getCalls(m)<1> - testMethods(m);
  