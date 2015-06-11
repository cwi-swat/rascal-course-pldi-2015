module php::Tutorial

import lang::php::ast::AbstractSyntax;
import lang::php::util::Utils;
import lang::php::util::Corpus;
import lang::php::ast::System;
import lang::php::pp::PrettyPrinter;

import List;
import Set;
import String;
import ValueIO;
import util::ValueUI;

private loc wp422 = |project://rascal-course-pldi-2015/data/systems/WordPress/wordpress-4.2.2|;
private loc wpload = |project://rascal-course-pldi-2015/data/systems/WordPress/wordpress-4.2.2/wp-load.php|;

public Script parseWithoutLocations() {	
	return loadPHPFile(wpload, false, false);
}

public Script parseWithLocations() {	
	return loadPHPFile(wpload, true, false);
}

public void parseWithoutLocationsAndView() {	
	text(parseWithoutLocations());
}

public void parseWithLocationsAndView() {	
	text(parseWithLocations());
}

public void viewBasedOnPreParsed() {	
	text(loadWordPress()[wpload]);
}

public System parseWordPress() {
	return loadPHPFiles(wp422);	
}

public void buildAndSerializeWordPress() {
	wp = loadPHPFiles(wp422);
	writeBinaryValueFile(|project://rascal-course-pldi-2015/data/serialized/wordpress-4.2.2.pt|, wp);
}

public System loadWordPress() {
	return readBinaryValueFile(#System, |project://rascal-course-pldi-2015/data/serialized/wordpress-4.2.2.pt|);
}

public rel[loc callLoc, Expr callExpr] findAllCalls(System s) {
	return { < c@at, c > | /c:call(_,_) := s };
}

public rel[loc callLoc, Expr callExpr] findAllMySQLCalls(System s) {
	return { < c@at, c > | /c:call(name(name(fn)),_) := s, /mysql/ := fn };
}
