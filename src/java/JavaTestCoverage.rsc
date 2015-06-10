module java::JavaTestCoverage

/* This file contains a number of pre-written functions to analyze JUnit test code and the 
 * code it tests. Then two main functions (stats, problems) which report the results of the analysis and then
 * some exercises to extend and improve the quality of the analysis.
 * 
 * We are over-approximating test coverage analysis by interpreting the static call graph.
 */
import lang::java::m3::Core;      // Java OO model
import lang::java::jdt::m3::Core; // Model acquisition from Eclipse context
import lang::java::m3::AST;       // AST model
import java::JUnit;               // JUnit annotation model
import util::ResourceMarkers;     // For IDE interaction
import Message;                   // Warnings and errors model
import Set;                       // Standard library 
import vis::Figure;               // For constructing graphics
import vis::Render;               // For rendering graphics
import analysis::graphs::Graph;
import IO;
import util::Math;

// Construct the call relation (partially correct)
rel[loc,loc] calls(M3 m) 
  = m@methodInvocation                          // from call sites to (virtual) methods
  + m@methodInvocation o m@methodOverrides<1,0> // link virtual to concrete methods
  ; 

// Project all public methods from the model  
set[loc] publicMethods(M3 m)
  = { f | f <- methods(m), \public() in m@modifiers[f]} // filter public methods 
  ;
 
// using set difference `-` and relation projection `r[e]` to
// find out which public methods are not unit-tested   
set[loc] notDirectlyUnitTested(M3 m)
  = methods(m) 
  - testMethods(m) 
  - ignoredMethods(m)
  - constructors(m) 
  - calls(m)[testMethods(m)] // same as notTouchedByUnitTests without the closure
  ;    
    
// using transitive closure `r+`, set difference `-` and relation projection `r[e]`
// to find out which methods are unreachable from the unit test roots  
set[loc] notTouchedByUnitTests(M3 m)
  = methods(m) 
  - testMethods(m) 
  - ignoredMethods(m) 
  - constructors(m) 
  - (calls(m)+)[testMethods(m)]; // note the transitive closure `+`

// Call this function and switch to the "Problems" view to see the effect:
void problems(M3 m) {
  void markMethods(set[loc] methods, str msg) = addMessageMarkers({warning(msg, x) | x <- methods});
    
  removeMessageMarkers(m.id + "src");
  markMethods(deadMethods(m), "methods is never called"); // 2: TODO TODO TODO filter the getters
  markMethods(notDirectlyUnitTested(m), "method is not directly unit tested");
  markMethods(notTouchedByUnitTests(m), "method is not reachable from unit tests");
}

// Call this specialized visualization to see what the data looks like:
void callGraph(M3 m) {
  c = calls(m);
  t = testMethods(m);
  a = (c<0> + c<1>) & methods(m);
  FProperty color(loc x) = fillColor(x in t ? "red" : "blue");
  FProperty popup(str s) = mouseOver(box(text(s), grow(1.2), resizable(false),fillColor("yellow")));
  
  nodes = [ellipse(color(method), width(10),height(10), id("I<method>"), popup(readFile(method))) | loc method <- [*top(c), *(a - top(c))]]; 
  edges = [edge("I<to>", "I<from>") | <to,from> <- c, from notin ignoredMethods(m), from notin deadMethods(m), to in a, from in a];  
  
  render(graph(nodes, edges, hint("layered"), std(gap(5)), std(font("Bitstream Vera Sans")), std(fontSize(14))));
}  

real perc(int part, int whole) = round(((part * 1.0) / (whole * 1.0)) * 100, 1.0);

// Call this to get the stats on test coverage
void stats(M3 m) = println( 
  "Reporting Test Coverage Analysis for <m.id.authority>:
  '
  '* <perc(size(notDirectlyUnitTested(m)), size(methods(m)))>% of the public methods are not unit tested at all:
  '  <for (x <- notDirectlyUnitTested(m)) {><x>
  '  <}>
  '* <perc(size(notTouchedByUnitTests(m)), size(methods(m)))>% of all methods are not reachable from the unit tests:
  '  <for (x <- notTouchedByUnitTests(m)) {><x>
  '  <}>
  '* <perc(size(deadMethods(m)), size(methods(m)))>% of the methods are not reachable at all:
  '  <for (x <- deadMethods(m)) {><x>
  '  <}>
  ");
   
// EXERCISES BELOW:

// Use this function in the first exercise, it uses abstract pattern matching to detect if a method
// looks like this: `ReturnType Name() { return var; }`
bool isGetter(loc method, M3 m) 
  = method(_, _, [], [], \block([\return(simpleName(_))])) := getMethodASTEclipse(method, model=m);

// Take a hint from the implementation of `publicMethods`
set[loc] getters(M3 m) = { /* 1: TODO TODO TODO: write a comprehension to retrieve all getter methods */};
  
// Use set difference `-` to implement this function and improve the false positive rate:  
set[loc] deadMethods(M3 m) = { /* TODO TODO TODO: write a relational expression to produce all the methods which are never called */ };
 
// BONUS. If you want to go all out, consider that the M3 model only contains information on what is actually
// written in code. Implicit constructors and super calls are thus not in `methodInvocations`, `containment`
// `methodOverrides`, etc, unless we put them there. This kind of semantics is typically language specific
// and we model it by model-to-model transformations in Rascal:  
M3 addImplicits(M3 m) {
  // Find classes without constructors (by querying the M3 model `m@containment`)
  noConstructor = { cl | cl <- classes(m), !any(x <- m@containment[cl], isConstructor(x))};
  
  // TODO: add stub constructor declarations in `m@containment` and `m@declarations`
  // create new locations like this `|java+constructor://<old.authority>/<old.path>()|`
  m@containment += {};
  m@declarations += {}; // invent source locations like the location of the entire class 

  // TODO: find constructors without explicit super call (match on the AST)
  noSuper = {c | c <- constructors(m) , /constructorCall(true, _) !:= getMethodASTEclipse(c, model=m)};
  
  // TODO: add invocations using a comprehesion and the `m@extends` relation
  m@methodInvocation += {}; 
  
  return m;
}
