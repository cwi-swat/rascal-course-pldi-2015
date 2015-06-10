module java::JUnit

// this file contains utility functions to detect methods and classes annotated for JUnit
import lang::java::m3::Core;

set[loc] getTestClasses(M3 m) 
  = ((m@extends+)<1,0>)[|java+class:///junit/framework/TestCase|]
  + (m@annotations<1,0>)[|java+interface:///org/junit/runner/RunWith|]
  ;

set[loc] ignoredMethods(M3 m)
  = (m@annotations<1,0>)[|java+interface:///org/junit/Ignore|] & methods(m);
  
set[loc] testMethods(M3 m)
  = (m@annotations<1,0>)[|java+interface:///org/junit/Test|] & methods(m)
  - ignoredMethods(m)
  ;