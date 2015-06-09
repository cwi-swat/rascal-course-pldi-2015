# Overview Exercises Rascal Course PLDI 2015

## Resources
### General Rascal Resources

* Rascal home page: [http://www.rascal-mpl.org](http://www.rascal-mpl.org)
* Rascal at GitHub: [https://github.com/cwi-swat/rascal](https://github.com/cwi-swat/rascal)
* The Rascal Tutor: [http://tutor.rascal-mpl.org](http://tutor.rascal-mpl.org)

### Course Repository

* [https://github.com/cwi-swat/rascal-course-pldi-2015.git](https://github.com/cwi-swat/rascal-course-pldi-2015.git) 

In this repository:

   - `doc/Exercises.[md|pdf]` (this text)
   - `doc/RascalCheatSheet.pdf` (overview of Rascal features)
   - `presentations/*` (all course presentations)
   - `src/*` (template code for the exercises)
   - `lib/*` (library code used by the exercises)
	
### Places to Find Rascal Examples

* The three exercise tracks described below.
* Rascal Recipes: [http://tutor.rascal-mpl.org/Recipes/Recipes.html](http://tutor.rascal-mpl.org/Recipes/Recipes.html) gives dozens of small examples.
* Rascal at Rosetta Code: [http:rosettacode.org/wiki/Category:Rascal](http:rosettacode.org/wiki/Category:Rascal) contains circa 50 Rosetta tasks with a solution in Rascal.

### Three Exercise Tracks

You can select one of three exercise tracks (more details below):

* Hack Your Javascript
* Java Static Test Coverage
* PHP Analysis

## Track 1: Hack Your Javascript

The _Hack Your Javascript_ track shows how Rascal can be used to add various extensions to Javascript.

### The _Hack Your Javascript_ Track Illustrates

- Concrete pattern matching
- Desugaring and simple code generation
- Handling of variable bindings
- How a Rascal Eclipse plugin is organized

The Javascript exercises and all related sources and documentation can be found in a separate Github repo:

- [https://github.com/cwi-swat/hack-your-javascript.git](https://github.com/cwi-swat/hack-your-javascript.git)

### Getting started with the _Hack Your Javascript_ Track

1. Clone the above Github project
2. Setup is described in `doc/setup.pdf`
3. Exercises are described in `doc/HackYourLanguage_Exercises.pdf`
2. Import in Eclipse (File -> Import...)
3. In `src/Series1.rsc` and `src/Series2.rsc` you find skeleton answers to be filled in by you as well as tests to check your answer.

## Track 2: Java Static Test Coverage

### The Java Static Test Coverage Track Illustrates

* M3: reusable (_not_ language independent) intermediate model for PL
* URI `loc` data-type for referencing and hyperlinking source code artifacts
* M3 query and reporting using relational calculus
* AST (abstract) pattern matching
 
### Getting started with the _Java Metrics_ Track

* `File->Import`, Existing Eclipse Project, snakesAndLadders from the `rascal-course-pldi-2015` clone
* start a console for the `rascal-course-pldi-2015` project
* `:edit analysis::m3::Core` language independent part of M3
* `:edit lang::java::m3::Core` Java extensions to M3
* `:edit lang::java::jdt::m3::Core` Eclipse API to generate 
* `import lang::java::jdt::m3::Core;`
* `import lang::java::m3::Core;`



## Track 3: PHP Analysis
### The _PHP Analysis_ Track Illustrates
### Getting started with the _PHP Analysis_ Track