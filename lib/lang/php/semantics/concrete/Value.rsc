@license{
  Copyright (c) 2009-2011 CWI
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
}
@contributor{Mark Hills - Mark.Hills@cwi.nl (CWI)}
module lang::php::semantics::concrete::Value

import lang::php::semantics::shared::Value;

public data Value
	= IntValue(int iv)
	| RealValue(real rv)
	| BoolValue(bool bv)
	| StringValue(str sv)
	;
	