module php::Tutorial

import lang::php::ast::AbstractSyntax;
import lang::php::util::Utils;
import lang::php::util::Corpus;
import lang::php::ast::System;
import lang::php::pp::PrettyPrinter;

import List;
import Set;
import String;

import util::ValueUI;

public loc wp422 = |home:///Projects/rascal-course-pldi-2015/data/systems/WordPress/wordpress-4.2.2|;
public loc wpload = |home:///Projects/rascal-course-pldi-2015/data/systems/WordPress/wordpress-4.2.2/wp-load.php|;

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

public System parseWordPress() {
	return loadPHPFiles(wp422);	
}

public rel[loc callLoc, Expr callExpr] findAllCalls(System s) {
	return { < c@at, c > | /c:call(_,_) := s };
}

public rel[loc callLoc, Expr callExpr] findAllMySQLCalls(System s) {
	return { < c@at, c > | /c:call(name(name(fn)),_) := s, /mysql/ := fn };
}

public rel[loc callLoc, Expr callExpr] findAllCallsToMySQLQuery(System s) {
	return { < c@at, c > | /c:call(name(name("mysql_query")),_) := s };
}
