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

public rel[loc callLoc, Expr callExpr] findAllBinaryCalls(System s) {
	return { < c@at, c > | /c:call(_,params) := s, size(params) == 2 };
}

public rel[loc callLoc, Expr callExpr] findAllCallsWithOnlyStringParams(System s) {
	// NOTE: We could check here to see if the params are empty and say this
	// is false. Instead, we will interpret this as "all given parameters are
	// string literals", which means if we don't have any parameters this is
	// still true.
	
	bool allParamsAreStringLiterals(list[ActualParameter] params) {
		for (p <- params) {
			if (scalar(string(_)) !:= p.expr) {
				return false;
			}
		}
		return true;
	}
	
	return { < c@at, c > | /c:call(_,params) := s, !allParamsAreStringLiterals(params) };
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

public rel[loc funLoc, str funName] varargsCheckers(System s) {
	bool checksForArgs(list[Stmt] fbody) {
		return !isEmpty({ c | /c:call(name(name(fn)),_) := fbody,
							  fn in { "func_get_args", "func_num_args", "func_get_arg" } });
	}

	return { < f@at, fn > | /f:function(fn,_,_,fbody) := s, checksForArgs(fbody) };
}

public rel[loc callLoc, Expr callExpr] findDynamicInvocations(System s) {
	// We need to find all uses of the dynamic invocation functions:
	// 1. call_user_func
	// 2. call_user_func_array
	return { < c@at, c > | /c:call(name(name(fn)),_) := s,
						   fn in { "call_user_func", "call_user_func_array" } };
}

data TargetType = functionTarget() | methodTarget() | staticMethodTarget() | unknownTarget();

public map[loc callLoc, TargetType invocationType] findKnowableInvocations(System s) {
	// First, get back all the dynamic invocations
	calls = findDynamicInvocations(s);
	
	// Now, for each, go through and determine if we can figure out what kind
	// of function or method we are calling
	map[loc callLoc, TargetType invocationType] res = ( );
	
	for ( < cloc, c > <- calls ) {
		if (call(name(name("call_user_func")),params) := c) {
			;
		} else if (call(name(name("call_user_func_array")),params) := c) {
			;
		}
	}
	
	return res;
}
