module php::Exercises

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
	// TODO: Find just the calls to mysql_query and return these as a
	// relation from locations to call expressions.
	return { };
}

@doc{
	Find any function calls that are given 0 parameters.
}
public rel[loc callLoc, Expr callExpr] findAllNullaryCalls(System s) {
	// TODO: Find just the function calls that are given 0 actual parameters
	// and return these as a relation from locations to call expressions.
	return { };
}

@doc{
	Find any calls that are only given string literals as parameters.
}
public rel[loc callLoc, Expr callExpr] findAllCallsWithOnlyStringParams(System s) {
	// TODO: Find just the function calls that are given only string literals
	// as parameters. If the function is given no parameters, it should not
	// be included. Return these as a relation from locations to call expressions.
	return { };
}

@doc{
	Find any calls where the call may be given a different number of actual parameters than the declared
	number of formal parameters.
}
public rel[loc declarationLoc, loc callLoc, Expr callExpr] findAllDifferingCalls(System s) {
	// TODO: Find function calls where the number of parameters provided differs
	// from the number of formal parameters in any declaration we know about of
	// that function. We only need to be concerned with functions defined inside
	// WordPress itself, not libraries, plugins, etc.
	
	// Possible solution steps:
	// 1. Find all the functions defined in WordPress so we can get back
	//    the name of the function and the number of arguments it takes.
	//    We could have multiple declarations, brought in by different
	//    includes under different conditions. 
	//
	//    Function is defined as this in the abstract syntax:
	// 			function(str name, bool byRef, list[Param] params, list[Stmt] body)
	//
	// 2. For each call, check to see if the name of the called function
	//    is one we know about, and then check the parameter count to see
	//    if it differs from the ones we are aware of.

	return { }; 
}

@doc{
	Return the functions that use at least one of the library functions
	provided for working with variable numbers of arguments. This is a
	strong indication that they provide varargs functionality.
}
public rel[loc funLoc, str funName] varargsCheckers(System s) {
	// TODO: Find all functions that use the library functions func_get_args,
	// func_num_args, or func_get_arg inside the function body. These functions
	// are most likely varags functions, based on making these calls.
}

@doc{
	Find all calls to either call_user_func or call_user_func_array.
}
public rel[loc callLoc, Expr callExpr] findDynamicInvocations(System s) {
	// TODO: Find all calls to call_user_func or call_user_func_array.
	// Return these as a relation from locations to call expressions.
}

@doc{
	Find all dynamic invocation calls where we can tell what kind of call we
	are making: to a function, static method, or method (static or non-staic).
	Calls to unknown targets should not be returned.
} 
public map[loc callLoc, TargetType invocationType] findKnowableInvocations(System s) {
	// TODO: Looking at the dynamic invocation calls from findDynamicInvocations, see
	// in which cases we can determine if the target is unknown or not. For details
	// about how these functions for dynamic invocations work, see the slides, as well
	// as the following PHP manual pages:
	// * http://php.net/manual/en/language.types.callable.php for callables
	// * http://php.net/manual/en/function.call-user-func.php for call_user_func
	// * http://php.net/manual/en/function.call-user-func-array.php for call_user_func_array
	//
	// Also, see the function computeTargetType in module php::Tutorial. You should use this
	// to determine what type of target each call has, and then filter out any with unknown
	// targets.
	//
	// The result is a map from call locations to invocation types.
	return ( );
}
