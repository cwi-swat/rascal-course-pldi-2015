module java::Solutions

// Required imports omitted for brevity

// Exercise 1: Retrieve all getter methods
set[loc] getters(M3 m) = { 
   return { method | method <- methods(m), isGetter(mtd, m) };
};

// Exercise 2: Compute all "dead" methods

// We give two alternative solution here, but be aware they depend on different definitions
// when a method is "dead" and give different results!

bool isMainMethod(loc method) = findFirst(method.path, "main(") > 0;

set[loc] mainMethods(M3 m) = { method | method <- methods(m), isMainMethod(method) };

set[loc] deadMethods1(M3 m) ={ 
   return methods(m) - (calls(m)*)[mainMethods(m)] - ignoredMethods(m);
};

set[loc] deadMethods2(M3 m) { 
    top(calls(m)) - testMethods(m) - ignoredMethods(m);
} 

// BONUS EXERCISE. 
// Here is one possilble solution for the bonus exercise.
// Be aware: in the snakesAndLadders project nothing will be added.

void addImplicits(M3 m) {
  // Find classes without constructors (by querying the M3 model `m@containment`)
  noConstructor = { cl | cl <- classes(m), !any(x <- m@containment[cl], isConstructor(x))};
  
  // TODO: add stub constructor declarations in `m@containment` and `m@declarations`
  // create new locations like this `|java+constructor://<old.authority>/<old.path>()|`
  m@containment += { <cl, cl[scheme="java+constructor"] + "()"> | cl <- noConstructor};
  m@declarations += { <cl[scheme="java+constructor"] + "()", src> | cl <- noConstructor, src <- m@declarations[cl]}; // invent source locations like the location of the entire class 
  node ast(loc l, M3 m) { try { return getMethodASTEclipse(l, model=m); } catch value x: return ""(); }
  
  // TODO: find constructors without explicit super call (match on the AST)
  noSuper = {c | c <- constructors(m) , /constructorCall(true, _) !:= ast(c, m)};
  
  // TODO: add invocations using a comprehesion and the `m@extends` relation
  m@methodInvocation += { <c, cons> | c <- noSuper, <cl,c> <- m@containment, sup <- m@extends[cl], <sup,d> <- containment, isConstructor(cons), /()$/ := cons.path}; 
  
  iprintln(m@methodInvocation - old);
  return m;
}