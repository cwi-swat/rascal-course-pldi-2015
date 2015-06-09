module java::JavaTestCoverage

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

// Construct the call relation (partially correct)
rel[loc,loc] calls(M3 m) 
  = m@methodInvocation                          // from call sites to (virtual) methods
  + m@methodInvocation o m@methodOverrides<1,0> // link virtual to concrete methods
  ; 
  
set[loc] publicMethods(M3 m)
  = { f | f <- methods(m), \public() in m@modifiers[f]} // filter public methods 
  ;
    
set[loc] notTouchedByUnitTests(M3 m)
  = methods(m) 
  - testMethods(m) 
  - ignoredMethods(m) 
  - constructors(m) 
  - (calls(m)+)[testMethods(m)]; // note the transitive closure
  
set[loc] notDirectlyUnitTested(M3 m)
  = methods(m) 
  - testMethods(m) 
  - ignoredMethods(m)
  - constructors(m) 
  - calls(m)[testMethods(m)] // same as notTouchedByUnitTests without the closure
  ;

set[loc] getters(M3 m) = { /* 1: TODO TODO TODO: write a comprehension to retrieve all getter methods */};
  
set[loc] deadMethods(M3 m) = { /* TODO TODO TODO: write a relational expression to produce all the methods which are never called */ };
  
bool isGetter(loc method, M3 m) = method(_, _, [], [], \block([\return(simpleName(_))])) := getMethodASTEclipse(method,model=m);
  
void markMethods(set[loc] methods, str msg)
  = addMessageMarkers({warning(msg, m) | m <- methods});
  
void unMarkMethods(loc project) = removeMessageMarkers(project);  
  
// main function generating markers in the editors and the problems view of Eclipse  
void problems(M3 m) {
  unMarkMethods(m.id + "src");
  markMethods(deadMethods(m), "methods is never called"); // 2: TODO TODO TODO filter the getters
  markMethods(notDirectlyUnitTested(m), "method is not directly unit tested");
  markMethods(notTouchedByUnitTests(m), "method is not reachable from unit tests");
}

// main function for visualizing and debugging the call graph
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
