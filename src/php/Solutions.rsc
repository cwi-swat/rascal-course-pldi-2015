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

@doc{
	Find calls just the mysql_query function.
}
public rel[loc callLoc, Expr callExpr] findAllCallsToMySQLQuery(System s) {
	return { < c@at, c > | /c:call(name(name("mysql_query")),_) := s };
}

@doc{
	Find any function calls that are given 0 parameters.
}
public rel[loc callLoc, Expr callExpr] findAllNullaryCalls(System s) {
	return { < c@at, c > | /c:call(_,params) := s, isEmpty(params) };
}

@doc{
	Find any function calls that are given 2 parameters.
}
public rel[loc callLoc, Expr callExpr] findAllBinaryCalls(System s) {
	return { < c@at, c > | /c:call(_,params) := s, size(params) == 2 };
}

@doc{
	Find any calls that are only given string literals as parameters.
}
public rel[loc callLoc, Expr callExpr] findAllCallsWithOnlyStringParams(System s) {
	bool allParamsAreStringLiterals(list[ActualParameter] params) {
		if (size(params) == 0) return false;
		
		for (p <- params) {
			if (scalar(string(_)) !:= p.expr) {
				return false;
			}
		}
		return true;
	}
	
	return { < c@at, c > | /c:call(_,params) := s, !allParamsAreStringLiterals(params) };
}

@doc{
	Find any calls where the call may be given a different number of actual parameters than the declared
	number of formal parameters.
}
public rel[loc declarationLoc, loc callLoc, Expr callExpr] findAllDifferingCalls(System s) {
	// First, find all the functions defined in WordPress. We just need
	// the name and the number of arguments. At runtime this would be a
	// map, but functions of the same name could be defined in different
	// include files, so we will use a relation.
	//
	// NOTE: Function is defined as this in the abstract syntax:
	// 			function(str name, bool byRef, list[Param] params, list[Stmt] body)
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

@doc{
	Return the functions that use at least one of the library functions
	provided for working with variable numbers of arguments. This is a
	strong indication that they provide varargs functionality.
}
public rel[loc funLoc, str funName] varargsCheckers(System s) {
	bool checksForArgs(list[Stmt] fbody) {
		// This gets back a set containing each call to one of the functions we are
		// interested in. If it isn't empty, we know we found one.
		return !isEmpty({ c | /c:call(name(name(fn)),_) := fbody,
							  fn in { "func_get_args", "func_num_args", "func_get_arg" } });
	}

	// The call to checksForArgs will be true if the body uses one of the functions that
	// is used for checking the arguments passed in to the function. We could also do
	// something similar for method declarations.
	return { < f@at, fn > | /f:function(fn,_,_,fbody) := s, checksForArgs(fbody) };
}

@doc{
	Find all calls to either call_user_func or call_user_func_array.
}
public rel[loc callLoc, Expr callExpr] findDynamicInvocations(System s) {
	// This is similar to the examples above, but checks against two different function names.
	return { < c@at, c > | /c:call(name(name(fn)),_) := s,
						   fn in { "call_user_func", "call_user_func_array" } };
}

@doc{
	Find all dynamic invocation calls where we can tell what kind of call we
	are making: to a function, static method, or method (static or non-staic).
	Calls to unknown targets should not be returned.
} 
public map[loc callLoc, TargetType invocationType] findKnowableInvocations(System s) {
	// First, get back all the dynamic invocations
	calls = findDynamicInvocations(s);
	
	// Now, for each, go through and determine if we can figure out what kind
	// of function or method we are calling
	map[loc callLoc, TargetType invocationType] res = ( );
	
	for ( < cloc, c > <- calls ) {
		// NOTE: The code for these cases is the same. You may want to leave them
		// split like this if you want to do additional processing, since the callables
		// are given in the same way but the parameters are not -- in the first case,
		// they are passed individually, in the second they are given as an array.
		// For more information on callables see 
		// http://php.net/manual/en/language.types.callable.php.
		if (call(name(name("call_user_func")),params) := c && !isEmpty(params)) {
			// See http://php.net/manual/en/function.call-user-func.php for details
			tt = computeTargetType(params[0].expr);
			if (! (tt is unknownTarget) ) {
				res[cloc] = computeTargetType(params[0].expr);
			}
		} else if (call(name(name("call_user_func_array")),params) := c && !isEmpty(params)) {
			// See http://php.net/manual/en/function.call-user-func-array.php for details
			tt = computeTargetType(params[0].expr);
			if (! (tt is unknownTarget) ) {
				res[cloc] = computeTargetType(params[0].expr);
			}
		}
	}
	
	return res;
}
