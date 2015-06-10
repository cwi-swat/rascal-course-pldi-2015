@license{
  Copyright (c) 2009-2013 CWI
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
}
@contributor{Mark Hills - Mark.Hills@cwi.nl (CWI)}
module lang::php::m3::AST

extend analysis::m3::AST;
import lang::php::ast::AbstractSyntax;
import lang::php::ast::System;

public data AST(loc file = |file:///unknown|)
	= phpAST(Script script)
	;
