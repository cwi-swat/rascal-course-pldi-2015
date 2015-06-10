module lang::php::language::Classes

// Predefined classes
// http://php.net/manual/en/reserved.classes.php

import lang::php::ast::AbstractSyntax;
import ValueIO;
	
Stmt Directory = readTextValueString(#Stmt, "classDef(class(\"Directory\",{},noName(),[],[property({\\public()},[property(\"path\",noExpr())[@at=|file://Directory.php|(56,5,\<4,0\>,\<4,0\>),@decl=|php+field:///directory/path|]])[@at=|file://Directory.php|(49,14,\<4,0\>,\<4,0\>)],property({\\public()},[property(\"handle\",noExpr())[@at=|file://Directory.php|(75,7,\<5,0\>,\<5,0\>),@decl=|php+field:///directory/handle|]])[@at=|file://Directory.php|(68,16,\<5,0\>,\<5,0\>)],method(\"close\",{\\public()},false,[param(\"dir_handle\",someExpr(fetchConst(name(\"null\")[@at=|file://Directory.php|(149,4,\<7,0\>,\<7,0\>)])[@at=|file://Directory.php|(149,4,\<7,0\>,\<7,0\>)])[@at=|file://Directory.php|(149,4,\<7,0\>,\<7,0\>)],someName(name(\"resource\")[@at=|file://Directory.php|(126,8,\<7,0\>,\<7,0\>)]),false)[@at=|file://Directory.php|(126,27,\<7,0\>,\<7,0\>),@decl=|php+methodParam:///directory/close/dir_handle|]],[])[@at=|file://Directory.php|(103,54,\<7,0\>,\<7,0\>),@decl=|php+method:///directory/close|],method(\"read\",{\\public()},false,[param(\"dir_handle\",someExpr(fetchConst(name(\"null\")[@at=|file://Directory.php|(203,4,\<8,0\>,\<8,0\>)])[@at=|file://Directory.php|(203,4,\<8,0\>,\<8,0\>)])[@at=|file://Directory.php|(203,4,\<8,0\>,\<8,0\>)],someName(name(\"resource\")[@at=|file://Directory.php|(180,8,\<8,0\>,\<8,0\>)]),false)[@at=|file://Directory.php|(180,27,\<8,0\>,\<8,0\>),@decl=|php+methodParam:///directory/read/dir_handle|]],[])[@at=|file://Directory.php|(158,54,\<8,0\>,\<8,0\>),@decl=|php+method:///directory/read|],method(\"rewind\",{\\public()},false,[param(\"dir_handle\",someExpr(fetchConst(name(\"null\")[@at=|file://Directory.php|(260,4,\<9,0\>,\<9,0\>)])[@at=|file://Directory.php|(260,4,\<9,0\>,\<9,0\>)])[@at=|file://Directory.php|(260,4,\<9,0\>,\<9,0\>)],someName(name(\"resource\")[@at=|file://Directory.php|(237,8,\<9,0\>,\<9,0\>)]),false)[@at=|file://Directory.php|(237,27,\<9,0\>,\<9,0\>),@decl=|php+methodParam:///directory/rewind/dir_handle|]],[])[@at=|file://Directory.php|(213,56,\<9,0\>,\<9,0\>),@decl=|php+method:///directory/rewind|]])[@at=|file://Directory.php|(6,265,\<2,0\>,\<2,0\>),@decl=|php+class:///directory|])[@at=|file://Directory.php|(6,265,\<2,0\>,\<2,0\>)]");
Stmt stdClass = readTextValueString(#Stmt, "classDef(class(\"stdClass\",{},noName(),[],[])[@at=|file://stdClass.php|(6,18,\<2,0\>,\<2,0\>),@decl=|php+class:///stdclass|])[@at=|file://stdClass.php|(6,18,\<2,0\>,\<2,0\>)]");
Stmt __PHP_Incomplete_Class = readTextValueString(#Stmt, "classDef(class(\"__PHP_Incomple_Class\",{},noName(),[],[])[@at=|file://__PHP_Incomple_Class.php|(6,29,\<2,0\>,\<2,0\>),@decl=|php+class:///__php_incomple_class|])[@at=|file://__PHP_Incomple_Class.php|(6,29,\<2,0\>,\<2,0\>)]");
Stmt Exception = readTextValueString(#Stmt, "classDef(class(\"Exception\",{},noName(),[],[property({protected()},[property(\"message\",noExpr())[@at=|file://Exception.php|(51,8,\<4,0\>,\<4,0\>),@decl=|php+field:///exception/message|]])[@at=|file://Exception.php|(41,20,\<4,0\>,\<4,0\>)],property({protected()},[property(\"code\",noExpr())[@at=|file://Exception.php|(72,5,\<5,0\>,\<5,0\>),@decl=|php+field:///exception/code|]])[@at=|file://Exception.php|(62,17,\<5,0\>,\<5,0\>)],property({protected()},[property(\"file\",noExpr())[@at=|file://Exception.php|(90,5,\<6,0\>,\<6,0\>),@decl=|php+field:///exception/file|]])[@at=|file://Exception.php|(80,17,\<6,0\>,\<6,0\>)],property({protected()},[property(\"line\",noExpr())[@at=|file://Exception.php|(108,5,\<7,0\>,\<7,0\>),@decl=|php+field:///exception/line|]])[@at=|file://Exception.php|(98,17,\<7,0\>,\<7,0\>)],method(\"__construct\",{\\public()},false,[param(\"message\",someExpr(scalar(string(\"\"))[@at=|file://Exception.php|(178,2,\<9,0\>,\<9,0\>)])[@at=|file://Exception.php|(178,2,\<9,0\>,\<9,0\>)],someName(name(\"string\")[@at=|file://Exception.php|(160,6,\<9,0\>,\<9,0\>)]),false)[@at=|file://Exception.php|(160,20,\<9,0\>,\<9,0\>),@decl=|php+methodParam:///exception/__construct/message|],param(\"code\",someExpr(scalar(integer(0))[@at=|file://Exception.php|(191,1,\<9,0\>,\<9,0\>)])[@at=|file://Exception.php|(191,1,\<9,0\>,\<9,0\>)],noName(),false)[@at=|file://Exception.php|(183,9,\<9,0\>,\<9,0\>),@decl=|php+methodParam:///exception/__construct/code|],param(\"previous\",someExpr(fetchConst(name(\"NULL\")[@at=|file://Exception.php|(217,4,\<9,0\>,\<9,0\>)])[@at=|file://Exception.php|(217,4,\<9,0\>,\<9,0\>)])[@at=|file://Exception.php|(217,4,\<9,0\>,\<9,0\>)],someName(name(\"Exception\")[@at=|file://Exception.php|(195,9,\<9,0\>,\<9,0\>)]),false)[@at=|file://Exception.php|(195,26,\<9,0\>,\<9,0\>),@decl=|php+methodParam:///exception/__construct/previous|]],[])[@at=|file://Exception.php|(130,96,\<9,0\>,\<9,0\>),@decl=|php+method:///exception/__construct|],method(\"getMessage\",{\\public(),final()},false,[],[])[@at=|file://Exception.php|(227,39,\<10,0\>,\<10,0\>),@decl=|php+method:///exception/getmessage|],method(\"getPrevious\",{\\public(),final()},false,[],[])[@at=|file://Exception.php|(267,40,\<11,0\>,\<11,0\>),@decl=|php+method:///exception/getprevious|],method(\"getCode\",{\\public(),final()},false,[],[])[@at=|file://Exception.php|(308,36,\<12,0\>,\<12,0\>),@decl=|php+method:///exception/getcode|],method(\"getFile\",{\\public(),final()},false,[],[])[@at=|file://Exception.php|(345,36,\<13,0\>,\<13,0\>),@decl=|php+method:///exception/getfile|],method(\"getLine\",{\\public(),final()},false,[],[])[@at=|file://Exception.php|(382,36,\<14,0\>,\<14,0\>),@decl=|php+method:///exception/getline|],method(\"getTrace\",{\\public(),final()},false,[],[])[@at=|file://Exception.php|(419,37,\<15,0\>,\<15,0\>),@decl=|php+method:///exception/gettrace|],method(\"getTraceAsString\",{\\public(),final()},false,[],[])[@at=|file://Exception.php|(457,45,\<16,0\>,\<16,0\>),@decl=|php+method:///exception/gettraceasstring|],method(\"__toString\",{\\public()},false,[],[])[@at=|file://Exception.php|(503,33,\<17,0\>,\<17,0\>),@decl=|php+method:///exception/__tostring|],method(\"__clone\",{\\private(),final()},false,[],[])[@at=|file://Exception.php|(537,37,\<18,0\>,\<18,0\>),@decl=|php+method:///exception/__clone|]])[@at=|file://Exception.php|(6,570,\<2,0\>,\<2,0\>),@decl=|php+class:///exception|])[@at=|file://Exception.php|(6,570,\<2,0\>,\<2,0\>)]");
Stmt ErrorException = readTextValueString(#Stmt, "classDef(class(\"ErrorException\",{},someName(name(\"Exception\")[@at=|file://ErrorException.php|(35,9,\<2,0\>,\<2,0\>)]),[],[property({protected()},[property(\"severity\",noExpr())[@at=|file://ErrorException.php|(74,9,\<4,0\>,\<4,0\>),@decl=|php+field:///errorexception/severity|]])[@at=|file://ErrorException.php|(64,21,\<4,0\>,\<4,0\>)],property({protected()},[property(\"message\",noExpr())[@at=|file://ErrorException.php|(123,8,\<6,0\>,\<6,0\>),@decl=|php+field:///errorexception/message|]])[@at=|file://ErrorException.php|(113,20,\<6,0\>,\<6,0\>)],property({protected()},[property(\"code\",noExpr())[@at=|file://ErrorException.php|(144,5,\<7,0\>,\<7,0\>),@decl=|php+field:///errorexception/code|]])[@at=|file://ErrorException.php|(134,17,\<7,0\>,\<7,0\>)],property({protected()},[property(\"file\",noExpr())[@at=|file://ErrorException.php|(162,5,\<8,0\>,\<8,0\>),@decl=|php+field:///errorexception/file|]])[@at=|file://ErrorException.php|(152,17,\<8,0\>,\<8,0\>)],property({protected()},[property(\"line\",noExpr())[@at=|file://ErrorException.php|(180,5,\<9,0\>,\<9,0\>),@decl=|php+field:///errorexception/line|]])[@at=|file://ErrorException.php|(170,17,\<9,0\>,\<9,0\>)],method(\"__construct\",{\\public()},false,[],[])[@at=|file://ErrorException.php|(202,33,\<11,0\>,\<11,0\>),@decl=|php+method:///errorexception/__construct|],method(\"getSeverity\",{\\public(),final()},false,[],[])[@at=|file://ErrorException.php|(236,39,\<12,0\>,\<12,0\>),@decl=|php+method:///errorexception/getseverity|]])[@at=|file://ErrorException.php|(6,272,\<2,0\>,\<2,0\>),@decl=|php+class:///errorexception|])[@at=|file://ErrorException.php|(6,272,\<2,0\>,\<2,0\>)]");
Stmt php_user_filter = readTextValueString(#Stmt, "classDef(class(\"php_user_filter\",{},noName(),[],[property({\\public()},[property(\"filtername\",noExpr())[@at=|file://php_user_filter.php|(54,11,\<4,0\>,\<4,0\>),@decl=|php+field:///php_user_filter/filtername|]])[@at=|file://php_user_filter.php|(47,20,\<4,0\>,\<4,0\>)],property({\\public()},[property(\"params\",noExpr())[@at=|file://php_user_filter.php|(75,7,\<5,0\>,\<5,0\>),@decl=|php+field:///php_user_filter/params|]])[@at=|file://php_user_filter.php|(68,16,\<5,0\>,\<5,0\>)],method(\"filter\",{\\public()},false,[param(\"in\",noExpr(),noName(),false)[@at=|file://php_user_filter.php|(124,3,\<7,0\>,\<7,0\>),@decl=|php+methodParam:///php_user_filter/filter/in|],param(\"out\",noExpr(),noName(),false)[@at=|file://php_user_filter.php|(130,4,\<7,0\>,\<7,0\>),@decl=|php+methodParam:///php_user_filter/filter/out|],param(\"consumed\",noExpr(),noName(),true)[@at=|file://php_user_filter.php|(137,10,\<7,0\>,\<7,0\>),@decl=|php+methodParam:///php_user_filter/filter/consumed|],param(\"closing\",noExpr(),noName(),false)[@at=|file://php_user_filter.php|(150,8,\<7,0\>,\<7,0\>),@decl=|php+methodParam:///php_user_filter/filter/closing|]],[])[@at=|file://php_user_filter.php|(99,64,\<7,0\>,\<7,0\>),@decl=|php+method:///php_user_filter/filter|],method(\"onClose\",{\\public()},false,[],[])[@at=|file://php_user_filter.php|(164,30,\<8,0\>,\<8,0\>),@decl=|php+method:///php_user_filter/onclose|],method(\"onCreate\",{\\public()},false,[],[])[@at=|file://php_user_filter.php|(195,31,\<9,0\>,\<9,0\>),@decl=|php+method:///php_user_filter/oncreate|]])[@at=|file://php_user_filter.php|(6,222,\<2,0\>,\<2,0\>),@decl=|php+class:///php_user_filter|])[@at=|file://php_user_filter.php|(6,222,\<2,0\>,\<2,0\>)]");
Stmt Closure = readTextValueString(#Stmt, "classDef(class(\"Closure\",{},noName(),[],[method(\"__construct\",{\\private()},false,[],[])[@at=|file://Closure.php|(36,34,\<4,0\>,\<4,0\>),@decl=|php+method:///closure/__construct|],method(\"bind\",{\\public(),static()},false,[param(\"closure\",noExpr(),someName(name(\"Closure\")[@at=|file://Closure.php|(101,7,\<5,0\>,\<5,0\>)]),false)[@at=|file://Closure.php|(101,16,\<5,0\>,\<5,0\>),@decl=|php+methodParam:///closure/bind/closure|],param(\"newthis\",noExpr(),someName(name(\"object\")[@at=|file://Closure.php|(120,6,\<5,0\>,\<5,0\>)]),false)[@at=|file://Closure.php|(120,15,\<5,0\>,\<5,0\>),@decl=|php+methodParam:///closure/bind/newthis|],param(\"newscope\",someExpr(scalar(string(\"static\"))[@at=|file://Closure.php|(156,8,\<5,0\>,\<5,0\>)])[@at=|file://Closure.php|(156,8,\<5,0\>,\<5,0\>)],someName(name(\"mixed\")[@at=|file://Closure.php|(138,5,\<5,0\>,\<5,0\>)]),false)[@at=|file://Closure.php|(138,26,\<5,0\>,\<5,0\>),@decl=|php+methodParam:///closure/bind/newscope|]],[])[@at=|file://Closure.php|(71,99,\<5,0\>,\<5,0\>),@decl=|php+method:///closure/bind|],method(\"bindTo\",{\\public()},false,[param(\"newthis\",noExpr(),someName(name(\"object\")[@at=|file://Closure.php|(196,6,\<6,0\>,\<6,0\>)]),false)[@at=|file://Closure.php|(196,15,\<6,0\>,\<6,0\>),@decl=|php+methodParam:///closure/bindto/newthis|],param(\"newscope\",someExpr(scalar(string(\"static\"))[@at=|file://Closure.php|(232,8,\<6,0\>,\<6,0\>)])[@at=|file://Closure.php|(232,8,\<6,0\>,\<6,0\>)],someName(name(\"mixed\")[@at=|file://Closure.php|(214,5,\<6,0\>,\<6,0\>)]),false)[@at=|file://Closure.php|(214,26,\<6,0\>,\<6,0\>),@decl=|php+methodParam:///closure/bindto/newscope|]],[])[@at=|file://Closure.php|(171,74,\<6,0\>,\<6,0\>),@decl=|php+method:///closure/bindto|]])[@at=|file://Closure.php|(6,241,\<2,0\>,\<2,0\>),@decl=|php+class:///closure|])[@at=|file://Closure.php|(6,241,\<2,0\>,\<2,0\>)]");

private list[Stmt] classes = [Directory, stdClass, __PHP_Incomplete_Class, Exception, ErrorException, php_user_filter, Closure];

public Script predefinedClasses = script( classes )[@decl=|php+namespace:///|];