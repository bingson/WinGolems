


; Variables and percent signs.ahk
; See https://autohotkey.com/docs/Language.htm#expressions-vs-legacy-syntax

; See bottom of script for usage in commands e.g. IfWinExist

; my favorite "gotcha":  if (z3 = "") (see below)

#NoEnv
#SingleInstance Force ; prevents multiple instances of script from running


; AHK supports "unquoted text"
w = y ; value of w is the literal/text string "y"
v := w ; value of v is the literal/text string "y"

w2 =  2  ; Note whitespace around the "2"
w3 := 2
if (w2 = w3) 
	MsgBox Yes ; seems whitespace is ignored
	
MsgBox % """" . w2 . """" ; just confirming: there are 2 spaces before and after "2" (i.e. "w2 =  2  ") but it looks like such whitespace is ignored
	
MsgBox, Yes ; treats "Yes" as unquoted text
MsgBox, % Yes ; treats "Yes" as variable name "Yes" (which is unassigned/empty)
MsgBox, % "Yes" 

if x = y ; legacy/"traditional" if statement and unquoted text "y"
{
	sleep , 1
}
else
{
	sleep , 1 ; this line executes because x is treated as a variable and y as a literal. x is uninitialized.  AHK HAS NO VALUE FOR NULL.  UNINITIALIZED VARIABLES ARE EMPTY/BLANK STRINGS i.e. length of 0
}

if (x = y) 	; if (expression) DOES NOT SUPPORT UNQUOTED TEXT: x and y are treated as variables
{
	sleep , 1 ; this line executes because x and y are uninitialized/empty and thus equal
}
else
{
	sleep , 1
}

; Don't need braces if only 1 statement/command per if or else statement
if (x = y) ; if (expression)
	sleep , 1 ; this line executes because x and y variables are both uninitialized/blank and thus equal
else
	sleep , 1 


if z = 
{
	sleep , 1 ; this line executes because variable z has not been initialized and I guess therefore matches blank/empty
}
else
{
	sleep , 1
}


; z1 has not been initialized
if z1 = ""
{
	sleep , 1 
}
else
{
	sleep , 1 ; gotcha? this line executes because variable z1 has not been initialized and doesn't equal the literal consisting of two doublequotes
}

if (z2 = "")
{
	sleep , 1 ; this line executes because variable z2 has not been initialized and is blank/empty; since the expression is within parentheses, the pair of doublequotes is interpreted as a blank/empty literal
}
else
{
	sleep , 1
}

z3 = ""
if (z3 = "")
{
	sleep , 1
}
else
{
	sleep , 1 ; gotcha? this line executes because the value of z3 is a literal string (i.e. a pair of doublequotes) whereas the expression (z3 = "") is testing whether z3 is empty (i.e. has a string length of 0); an expression interprets a pair of doublequotes as a blank/empty literal
}




a1 = 1 + 2 ; assigns the literal "1 + 2"

a2 := 1 + 2 ; assigns 3 because of assignment operator ":=" and the valid math expression

a3 = ( 1 + 2 ) ; assigns the literal "( 1 + 2 )"

a4 := ( 1 + 2 ) ; assigns 3 because of operator ":=" and the valid math expression

a5 := a1 ; assigns the literal "1 + 2"

a6 := a1 + a3 ; assigns empty because of assignment operator ":=" and invalid math expression (adding together two literal text strings)

a7:= a1 + a2 ; assigns empty because of assignment operator ":=" and invalid math expression (adding together a literal text string (value of a1 is "1 + 2") and a number (value of a2 is 3))



b1 = a1 ; assigns literal "a1"

b2 = %a1% ; assigns literal "1 + 2"

b3 := a1 ; assigns literal "1 + 2"

b5 := %b1% ; assigns the literal "1 + 2"

; b4 := %a1% ; results in a terminal error "the following variable name contains an illegal character: '1 + 2'"; the percent signs identify the contents (i.e. value) of variable a1 as the name of a variable, that variable name being "1 + 2", which is an illegal variable name


MsgBox The value in the variable named b3 is %b3%. ; unquoted text
MsgBox % "The value in the variable named b3 is " . b3 . "." ; displays same as line above

MsgBox The value in the variable named b3 is """"%b3%"""". ; unquoted text, displays 4 doublequotes
MsgBox % "The value in the variable named b3 is " . """" . b3 . """" . "." ; need 4 doublequotes to display 1 when using quoted text



; EACH PARAMETER that has variables needs to be preceded with % space prefix:
FileRead, GetLastVersePageFile, % QIEpath Title ".txt" ; QIEpath and Title are variables


; EXAMPLE with multiple parameters:

WinTitle := "SciTE.exe" ; J:\StandaloneApps\AutoHotkey\SciTE\SciTE.exe
WinText := "Source"
ExcludeTitle := "xxyyzz"

; IfWinExist [, WinTitle, WinText, ExcludeTitle, ExcludeText] (deprecated, but using it as example of a command that uses traditional (i.e. non-expression) syntax which requires understanding of how/when to use "% space prefix" vs. just the variable name vs. surrounding the variables in %):
IfWinExist, ahk_exe %WinTitle%, % WinText, % ExcludeTitle ; each parameter syntax is separate, so I can use unquoted/legacy syntax for one parameter (i.e. ahk_exe %WinTitle%) and expression syntax with the other parameters
	MsgBox, Yes!

IfWinExist, % "ahk_exe " . WinTitle, % WinText, % ExcludeTitle ; Using expression syntax for all parameters
	MsgBox, Yes!