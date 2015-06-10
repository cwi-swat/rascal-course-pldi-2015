module lang::php::experiments::issta2014::ISSTA2014

import lang::php::ast::AbstractSyntax;
import lang::php::util::Config;
import lang::php::util::Utils;
import lang::php::util::Corpus;
import lang::php::ast::System;
import lang::php::stats::Stats;
import lang::php::analysis::includes::IncludeGraph;
import lang::php::analysis::includes::ResolveIncludes;
import IO;
import Set;
import ValueIO;
import DateTime;

@doc{The base corpus used in the paper, matching that used for ISSTA}
private Corpus issta14BaseCorpus = (
	"osCommerce":"2.3.3.4",
	"ZendFramework":"1.12.3",
	"CodeIgniter":"2.1.4",
	"Symfony":"2.4.0",
	"SilverStripe":"3.1.2",
	"WordPress":"3.8",
	"Joomla":"3.2.1",
	"phpBB":"3.0.12",
	"Drupal":"7.24",
	"MediaWiki":"1.22.0",
	"Gallery":"3.0.9",
	"SquirrelMail":"1.4.22",
	"Moodle":"2.6",
	"Smarty":"3.1.16",
	"Kohana":"3.3.1",
	"phpMyAdmin":"4.1.3-english",
	"PEAR":"1.9.4",
	"CakePHP":"2.4.4",
	"DoctrineORM":"2.3.3",
	"Magento":"1.8.1.0");

private map[str,list[str]] defaultIncludePaths = (
	"osCommerce" : ["."],
	"ZendFramework" : [".","/library","/extras/library"],
	"CodeIgniter" : ["."],
	"Symfony" : ["."],
	"SilverStripe" : ["."],
	"WordPress" : ["."],
	"Joomla" : ["."],
	"phpBB" : ["."],
	"Drupal" : ["."],
	"MediaWiki" : ["."],
	"Gallery" : ["."],
	"SquirrelMail" : ["."],
	"Moodle" : ["."],
	"Smarty" : ["."],
	"Kohana" : ["."],
	"phpMyAdmin" : ["."],
	"PEAR" : ["."],
	"CakePHP" : ["."],
	"DoctrineORM" : ["."],
	"Magento" :  ["."]);

@doc{The location of the corpus extension, change to your location!}
private loc includesSystemsLoc = |home:///PHPAnalysis/includesSystems|;

@doc{Retrieve the base corpus}
public Corpus getBaseCorpus() = issta14BaseCorpus;

@doc{Retrieve information on the extension; in this case we do not have
     version information, so we just go from name to location}
alias SysMap = map[str sysname, loc sysloc];
public SysMap getIncludesSystems() = getIncludesSystems(includesSystemsLoc);
public SysMap getIncludesSystems(loc base) = (l.file : l | l <- base.ls, isDirectory(l));

@doc{Get the extension as a name/version corpus, with version always "HEAD"
     since this was the head version of whatever was in the github repo}
public Corpus getIncludesSystemsCorpus() = getIncludesSystemsCorpus(getIncludesSystems());
public Corpus getIncludesSystemsCorpus(SysMap smap) = ( s : "HEAD" | s <- smap );

@doc{Build binaries of parsed systems for the extension}
public void buildExtensionBinaries(SysMap smap) {
	for (p <- smap) {
		buildBinaries(p,"HEAD",smap[p]);
	}
}

@doc{Load a binary for an extension system}
public System loadESECBinary(str sys) {
	return loadBinary(sys, "HEAD");
}

@doc{Build binaries, with resolved includes, for the extension}
public void buildESECBinariesWithIncludes(SysMap smap) {
	for (s <- smap) {
		pt = loadESECBinary(s);
		pt2 = resolveIncludes(pt,smap[s]);
		parsedItem = parsedDir + "<s>-HEAD-icp.pt";
		println("Writing binary: <parsedItem>");
		writeBinaryValueFile(parsedItem, pt2);
	}	
}

@doc{Load a binary, with resolved includes, for the extension system}
public map[loc,Script] loadESECBinaryWithIncludes(str product) {
	parsedItem = parsedDir + "<product>-HEAD-icp.pt";
	println("Loading binary: <parsedItem>");
	return readBinaryValueFile(#map[loc,Script],parsedItem);
}

@doc{Get back all the dynamic includes in the extension, organized by system}
public map[str sysname, lrel[loc fileloc, Expr call] dincs] fetchAllDynamicIncludes(SysMap smap) {
	map[str sysname, lrel[loc fileloc, Expr call] dincs] res = ( );
	for (sys <- smap) {
		pt = loadESECBinary(sys);
		incs = gatherIncludesWithVarPaths(pt);
		res[sys] = incs;
	}
	return res;
}

//public void buildExperimentalESECBinariesWithIncludes(SysMap smap) {
//	for (s <- smap) {
//		pt = loadESECBinary(s);
//		pt2 = resolveIncludesWithVars(pt,smap[s]);
//		parsedItem = parsedDir + "<s>-HEAD-icpe.pt";
//		println("Writing binary: <parsedItem>");
//		writeBinaryValueFile(parsedItem, pt2);
//	}	
//}

@doc{Get back all dynamic includes in the extension that remain after the
     includes resolution algorithm completes}
public map[str sysname, lrel[loc fileloc, Expr call] dincs] fetchAllUnresolvedDynamicIncludes(SysMap smap) {
	map[str sysname, lrel[loc fileloc, Expr call] dincs] res = ( );
	for (sys <- smap) {
		pt = loadESECBinaryWithIncludes(sys);
		incs = gatherIncludesWithVarPaths(pt);
		res[sys] = incs;
	}
	return res;
}

public void resolveBaseIncludes(str p, str v, list[str] ipath) {
	< sys, igraph, timings > = resolve(loadBinary(p,v),getCorpusItem(p,v),ipath);
	writeBinaryValueFile(|home:///PHPAnalysis/serialized/includes/<p>-<v>-inlined.pt|, sys);		
	writeBinaryValueFile(|home:///PHPAnalysis/serialized/includes/<p>-<v>-igraph.pt|, igraph);		
	writeBinaryValueFile(|home:///PHPAnalysis/serialized/includes/<p>-<v>-timings.pt|, timings);		
}

public void resolveBaseIncludes(str p) {
	c = getBaseCorpus();
	resolveBaseIncludes(p, c[p], defaultIncludePaths[p]);
}

public void resolveBaseIncludes() {
	c = getBaseCorpus();
	for (s <- c) resolveBaseIncludes(s, c[s], defaultIncludePaths[s]);
}


public tuple[System,IncludeGraph,lrel[str,datetime]] loadSerializedInfo(str p, str v) {
	sys = readBinaryValueFile(#System, |home:///PHPAnalysis/serialized/includes/<p>-<v>-inlined.pt|);		
	igraph = readBinaryValueFile(#IncludeGraph, |home:///PHPAnalysis/serialized/includes/<p>-<v>-igraph.pt|);
	timings = readBinaryValueFile(#lrel[str,datetime], |home:///PHPAnalysis/serialized/includes/<p>-<v>-timings.pt|);
	return < sys, igraph, timings >;
}

public rel[str p, str v, loc fileloc, Expr call] allIncludes() {
	c = getBaseCorpus();
	rel[str p, str v, loc fileloc, Expr call] res = { };
	for (s <- c) {
		sys = loadBinary(s, c[s]);
		res += { < s, c[s], i@at, i > | /i:include(_,_) := sys };
	}
	return res;
}

public rel[str p, str v, loc fileloc, Expr call] dynamicIncludes(rel[str p, str v, loc fileloc, Expr call] allincs) {
	return { < s, v, l, i > | < s, v, l, i > <- allincs, include(scalar(string(_)),_) !:= i };
}

public rel[str p, str v, loc fileloc, Expr call] unresolvedIncludes() {
	c = getBaseCorpus();
	rel[str p, str v, loc fileloc, Expr call] res = { };
	for (s <- c) {
		println("Loading include graph for <s>-<c[s]>");
		igraph = readBinaryValueFile(#IncludeGraph, |home:///PHPAnalysis/serialized/includes/<s>-<c[s]>-igraph.pt|);
		for (e <- igraph.edges, !(e.target is igNode))
			res = res + < s, c[s], e.includeExpr@at, e.includeExpr >;
	}
	return res;
}

public rel[str p, str v, loc fileloc, Expr call] nonuniqueIncludes() {
	c = getBaseCorpus();
	rel[str p, str v, loc fileloc, Expr call] res = { };
	for (s <- c) {
		println("Loading include graph for <s>-<c[s]>");
		igraph = readBinaryValueFile(#IncludeGraph, |home:///PHPAnalysis/serialized/includes/<s>-<c[s]>-igraph.pt|);
		for (e <- igraph.edges, !(e.target is igNode))
			res = res + < s, c[s], e.includeExpr@at, e.includeExpr >;
	}
	return res;
}

public rel[str p, str v, loc fileloc, Expr call] unknownIncludes() {
	c = getBaseCorpus();
	rel[str p, str v, loc fileloc, Expr call] res = { };
	for (s <- c) {
		println("Loading include graph for <s>-<c[s]>");
		igraph = readBinaryValueFile(#IncludeGraph, |home:///PHPAnalysis/serialized/includes/<s>-<c[s]>-igraph.pt|);
		for (e <- igraph.edges, e.target is unknownNode)
			res = res + < s, c[s], e.includeExpr@at, e.includeExpr >;
	}
	return res;
}

public rel[str p, str v, loc fileloc, Expr call] libraryIncludes() {
	c = getBaseCorpus();
	rel[str p, str v, loc fileloc, Expr call] res = { };
	for (s <- c) {
		println("Loading include graph for <s>-<c[s]>");
		igraph = readBinaryValueFile(#IncludeGraph, |home:///PHPAnalysis/serialized/includes/<s>-<c[s]>-igraph.pt|);
		for (e <- igraph.edges, e.target is libNode)
			res = res + < s, c[s], e.includeExpr@at, e.includeExpr >;
	}
	return res;
}

public rel[str p, str v, loc fileloc, Expr call] libraryIncludes() {
	c = getBaseCorpus();
	rel[str p, str v, loc fileloc, Expr call] res = { };
	for (s <- c) {
		println("Loading include graph for <s>-<c[s]>");
		igraph = readBinaryValueFile(#IncludeGraph, |home:///PHPAnalysis/serialized/includes/<s>-<c[s]>-igraph.pt|);
		for (e <- igraph.edges, e.target is libNode)
			res = res + < s, c[s], e.includeExpr@at, e.includeExpr >;
	}
	return res;
}

public rel[str p, str v, loc fileloc, Expr call, int alts] multiIncludes() {
	c = getBaseCorpus();
	rel[str p, str v, loc fileloc, Expr call, int alts] res = { };
	for (s <- c) {
		println("Loading include graph for <s>-<c[s]>");
		igraph = readBinaryValueFile(#IncludeGraph, |home:///PHPAnalysis/serialized/includes/<s>-<c[s]>-igraph.pt|);
		for (e <- igraph.edges, e.target is multiNode)
			res = res + < s, c[s], e.includeExpr@at, e.includeExpr, size(e.target.alts) >;
	}
	return res;
}

public rel[str p, str v, IncludeGraphEdge igedge] unresWithLiteralPath() {
	c = getBaseCorpus();
	rel[str p, str v, IncludeGraphEdge igedge] res = { };
	for (s <- c) {
		println("Loading include graph for <s>-<c[s]>");
		igraph = readBinaryValueFile(#IncludeGraph, |home:///PHPAnalysis/serialized/includes/<s>-<c[s]>-igraph.pt|);
		for (e <- igraph.edges, !((e.target is igNode) || include(scalar(string(_)),_) := e.includeExpr))
			res = res + < s, c[s], e >;
	}
	return res;
}

public map[str p, int c] unresBySystem(rel[str p, str v, IncludeGraphEdge igedge] un) {
	map[str p, int c] res = ( p : 0 | p <- getBaseCorpus());
	for (<p,v,e> <- un) res[p] += 1;
	return res;
}

public map[str p, int c] unresBySystem() {
	un = unresWithLiteralPath();
	return unresBySystem(un);
}

public rel[loc l, Expr call] setIncludePathCalls() {
	c = getBaseCorpus();
	rel[loc l, Expr call] res = { };
	for (s <- c) {
		println("Loading system for <s>-<c[s]>");
		sys = readBinaryValueFile(#System, |home:///PHPAnalysis/serialized/includes/<s>-<c[s]>-inlined.pt|);
		res = res + { < cl@at, cl > | /cl:call(name(name("set_include_path")),_) := sys }; 
	}
	return res;
}

public str generateIncludeCountsTable() {
	rel[str p, str v, loc fileloc, Expr call] allincs = allIncludes();
	rel[str p, str v, loc fileloc, Expr call] dynincs = dynamicIncludes(allincs);
	rel[str p, str v, loc fileloc, Expr call] unincs = unresolvedIncludes();
	
	lv = getBaseCorpus();
	ci = loadCountsCSV();
		
	str productLine(str p) {
		v = lv[p];
		< lineCount, fileCount > = getOneFrom(ci[p,v]);
		giniC = counts[<p,v>].unresolved.gc;
		giniToPrint = (giniC == 0.0) ? 0.0 : round(giniC*1000.0)/1000.0;

		return "<p> & \\numprint{<totalIncludes[<p,v>]>} & \\numprint{<counts[<p,v>].initial.hc>}  & \\numprint{<counts[<p,v>].initial.hc-counts[<p,v>].unresolved.hc>} & \\numprint{<fileCount>}(\\numprint{<counts[<p,v>].unresolved.fc>}) & \\nprounddigits{2} \\numprint{<giniToPrint>} \\npnoround \\\\";
	}
		
	res = "\\npaddmissingzero
		  '\\npfourdigitsep
		  '\\begin{table}
		  '  \\centering
		  '  \\ra{1.2}
		  '  \\scriptsize
		  '  \\begin{tabular}{@{}lrrrrr@{}} \\toprule
		  '  Product & \\multicolumn{3}{c}{Includes} & Files & Gini \\\\
		  ' \\cmidrule{2-4} 
		  '   &  Total & Dynamic & Resolved & &  \\\\ \\midrule<for (p <- sort(toList(lv<0>),bool(str s1,str s2) { return toUpperCase(s1)<toUpperCase(s2); })) {>
		  '    <productLine(p)> <}>
		  '  \\bottomrule
		  '  \\end{tabular}
		  '  \\normalsize
		  '  \\caption{PHP Dynamic Includes.\\label{table-includes}}
		  '\\end{table}
		  '\\npfourdigitnosep
		  '\\npnoaddmissingzero
		  '";
	return res;	
}