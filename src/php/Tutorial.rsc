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

@doc{
	Parse the wp-load.php file with source locations disabled.
}
public Script parseWithoutLocations() {	
	return loadPHPFile(wpload, false, false);
}

@doc{
	Parse the wp-load.php file with source locations enabled.
}
public Script parseWithLocations() {	
	return loadPHPFile(wpload, true, false);
}

@doc{
	Parse the wp-load.php file with source locations disabled and view
	the result using text.
}
public void parseWithoutLocationsAndView() {	
	text(parseWithoutLocations());
}

@doc{
	Parse the wp-load.php file with source locations enabled and view
	the result using text.
}
public void parseWithLocationsAndView() {	
	text(parseWithLocations());
}

@doc{
	View a specific file from the pre-parsed version of WordPress. This
	just demonstrates how the text function works.
}
public void viewBasedOnPreParsed() {	
	text(loadWordPress()[wpload]);
}

@doc{
	Parse the entire source for WordPress 4.2.2
}
public System parseWordPress() {
	return loadPHPFiles(wp422);	
}

@doc{
	Build the serialized version of the WordPress ASTs from source and serialize it.
}
public void buildAndSerializeWordPress() {
	wp = loadPHPFiles(wp422);
	writeBinaryValueFile(|project://rascal-course-pldi-2015/data/serialized/wordpress-4.2.2.pt|, wp);
}

@doc{
	Load the pre-parsed version of WordPress 4.2.2.
}
public System loadWordPress() {
	return readBinaryValueFile(#System, |project://rascal-course-pldi-2015/data/serialized/wordpress-4.2.2.pt|);
}

@doc{
	Find all function calls in the given system
}
public rel[loc callLoc, Expr callExpr] findAllCalls(System s) {
	return { < c@at, c > | /c:call(_,_) := s };
}

@doc{
	Find all calls to functions with mysql as part of the name
}
public rel[loc callLoc, Expr callExpr] findAllMySQLCalls(System s) {
	return { < c@at, c > | /c:call(name(name(fn)),_) := s, /mysql/ := fn };
}

@doc{
	Find method calls with $this as the call target (e.g., $this->myMethod(...))
}
public rel[loc callLoc, Expr callExpr] findAllCallsOnThis(System s) {
	return { < c@at, c > | /c:methodCall(var(name(name("this"))),_,_) := s };
}

@doc{
	The type of dynamic invocation target. Note that methodTarget is more general than
	staticMethodTarget, we only know if we have a static method target when the first
	part of the callable is a string, but if the first part is an expression it could
	compute either a string or an object instance.
}
data TargetType = functionTarget() | methodTarget() | staticMethodTarget() | unknownTarget();

@doc{
	Compute the target type for an expression. If we have a string, we know it is a function.
	If we have an array with a string as the first element, we know it is a static method.
	If we have an array with something else as the first element, it could be either a regular
	or static method, in which case we classify it as just a methodTarget.
}
public TargetType computeTargetType(scalar(string(_))) = functionTarget();
public TargetType computeTargetType(array(list[ArrayElement] el)) = staticMethodTarget() when !isEmpty(el) && scalar(string(_)) := el[0].val;
public TargetType computeTargetType(array(list[ArrayElement] el)) = methodTarget() when !isEmpty(el) && scalar(string(_)) !:= el[0].val;
public default TargetType computeTargetType(Expr e) = unknownTarget();
