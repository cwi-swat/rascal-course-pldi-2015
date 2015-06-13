module java::Examples

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;
import util::ValueUI;
import java::JavaTestCoverage;
import Prelude;

public loc project = |project://snakesAndLadders|;

public M3 createModel() {
	m = createM3FromEclipseProject(project);
	return m;
}

// NOTE: These are meant to be run from the command prompt, this just 
// provides a convenient way to copy and paste these examples.
public void sampleQueries(M3 m) {
	// From the Exercises Markdown file and PDF.
	m@methodInvocation;
	
	// From the Exercises Markdown file and PDF.
	iprintln(m@containment);
	
	// From the Exercises Markdown file and PDF.
	text(m@methodInvocation o m@methodOverrides<1,0>);
	
	// From the Exercises Markdown file and PDF.
	problems(m);
	
	// From the Exercises Markdown file and PDF.
	stats(m);

	// Visible on Slide 8	
	m@annotations;

	// From Slide 10
	size(m@annotations);
	
	// From Slide 10
	classes(m);
	
	// From Slide 10
	size(classes(m));
	
	// From Slide 11
	m@extends;
	
	// From Slide 11
	m@extends[|java+class:///snakes/Snake|];
}

public void methodsPerClass(M3 model){
	for(c <- classes(model)){
		println("<c>: <size(methods(model, c))>");
	}
}

public set[loc] classesWithMostMethods(M3 model){
	methodCount = ( c : size(methods(model, c)) | c <- classes(model));

	largest = max(range(methodCount));
	return { c | c <- classes(model), methodCount[c] == largest };
}

public Declaration getDeclaration(M3 model) {
	l = |java+constructor:///snakes/LastSquare/LastSquare(snakes.Game,int)|;
	return getMethodASTEclipse(l, model=model);
}

// NOTE: This isn't on the slides, but gives us something to run
// the next two functions on.
public set[Declaration] getMethodDeclarations(M3 model) {
	return { getMethodASTEclipse(l,model=model) | l <- methods(model) };
}

public int countCasts1(set[Declaration] decls){
	int cnt = 0;
 	visit(decls){
 		case \cast(_, _): cnt += 1;
 	}
 	return cnt;
}

int countCasts2(set[Declaration] decls) = size([c | /c:\cast(_,_) := decls]);
