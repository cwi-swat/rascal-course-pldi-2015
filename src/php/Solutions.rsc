module php::Solutions

import php::Tutorial;

import lang::php::ast::AbstractSyntax;
import lang::php::util::Utils;
import lang::php::util::Corpus;
import lang::php::ast::System;
import lang::php::pp::PrettyPrinter;

import List;
import Set;
import IO;

public rel[loc callLoc, Expr callExpr] findAllCallsToMySQLQuery(System s) {
	return { < c@at, c > | /c:call(name(name("mysql_query")),_) := s };
}

public rel[loc callLoc, Expr callExpr] findAllNullaryCalls(System s) {
	return { < c@at, c > | /c:call(_,params) := s, isEmpty(params) };
}

public rel[loc declarationLoc, loc callLoc, Expr callExpr] findAllDifferingCalls(System s) {
	// First, find all the functions defined in WordPress. We just need
	// the name and the number of arguments. At runtime this would be a
	// map, but functions of the same name could be defined in different
	// include files, so we will use a relation.
	//
	// NOTE: Function is defined as this:
	// 			function(str name, bool byRef, list[Param] params, list[Stmt] body)
	// inside the AbstractSyntax.
	println("Computing the number of formals for each local function");
	functionAndArgs = { < fn, size(params) > | /function(fn,_,params,_) := s };
	println("Found <size(functionAndArgs)> name/parameter count combinations");
	
	// compute just the function names we have in functionAndArgs, this is quicker
	// then repeatedly computing this...
	justTheNames = functionAndArgs<0>;
	
	// Now, look through all the calls, see if we have any where
	// a) the name is in functionAndArgs, but
	// b) the parameter count differs from that in functionAndArgs
	differing = { < c@at, c > | /c:call(name(name(fn)), params) := s, 
								fn in justTheNames,
								< fn, size(params) > notin functionAndArgs };
								
	return differing; 
}