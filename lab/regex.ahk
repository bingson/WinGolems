;[updated: 2018-02-25]
;==================================================

;CONTENTS

;QUICK REFERENCE: ESCAPED CHARACTERS
;LINKS
;NOTES: REGEX EQUIVALENTS FOR ? AMD * WILDCARDS IN WINDOWS
;NOTES: + VERSUS *
;NOTES: ?
;NOTES: <.+> VERSUS <.+?>
;NOTES: ^
;NOTES: NEWLINES (LINE BREAKS)
;NOTES: CHARACTER CLASSES
;NOTES: CHARACTERS
;NOTES: CHARACTER TYPES
;NOTES: CHARACTER TYPES (SCRIPT NAMES)
;NOTES: POSIX NAMED SETS
;NOTES: ESCAPED CHARACTERS
;COLUMNS/CROP: REMOVE COLUMNS (CROP BEFORE/AFTER FIRST/LAST OCCURRENCE IN EACH LINE)
;COLUMNS: INCREASE WHITESPACE BETWEEN COLUMNS
;FIND/REMOVE CHARACTERS
;REMOVE TAGS (REMOVE HTML TAGS)
;STRING COMPARE (WILDCARDS): ? AND *
;KEEP/REMOVE LINES THAT CONTAIN STRING
;CROP CHARACTERS
;GET NTH ITEM
;LOOK UP ITEMS IN A TABLE
;IF VAR IN LIST
;IF VAR CONTAINS(/STARTS/ENDS) LIST
;TRIM LEADING/MULTIPLE/TRAILING CHARACTERS
;TRIM: RECREATING AUTOHOTKEY'S TRIM/LTRIM/RTRIM FUNCTIONS
;SEPARATE LEADING WHITESPACE / CODE / COMMENTS
;PUT STRINGS BEFORE/AFTER OCCURRENCES OF NEEDLE
;SLICE STRING / PAD STRING
;WHOLE WORD MATCH/REPLACE
;UPPERCASE / LOWERCASE / TITLE CASE
;REMOVE URLS FROM STRING
;SPLIT PATH
;DATES
;BACKREFERENCES
;BINARY SEARCH
;REGULAR EXPRESSION CALLOUTS (GET ALL MATCHES/OCCURRENCES)
;GET ALL MATCHES
;SYNTAX SPECIFIC TO AUTOHOTKEY
;QUERIES

;==================================================

;QUICK REFERENCE: ESCAPED CHARACTERS

;12 characters that need escaping in RegEx generally: \.*?+[{|()^$

;not brackets (8): \ .*?+ | ^$
;open brackets (3): [ { (
;close brackets (1): )

;4 characters that need escaping in a RegEx character class: ^-]\

;==================================================

;LINKS

;Regular Expressions (RegEx) - Quick Reference
;https://www.autohotkey.com/docs/misc/RegEx-QuickRef.htm

;RegExMatch
;https://www.autohotkey.com/docs/commands/RegExMatch.htm

;RegExReplace
;https://www.autohotkey.com/docs/commands/RegExReplace.htm

;Regular Expression Callouts
;https://autohotkey.com/docs/misc/RegExCallout.htm

;SetTitleMatchMode
;https://www.autohotkey.com/docs/commands/SetTitleMatchMode.htm#RegEx

;pcre.txt
;http://www.pcre.org/pcre.txt

;==================================================

;NOTES: REGEX EQUIVALENTS FOR ? AMD * WILDCARDS IN WINDOWS

;In Windows:
;? usually means 1 character [RegEx equivalent: .]
;* usually means 0 or more characters [RegEx equivalent: .*]

;In RegEx:
;? usually relates to 'greedy'/'ungreedy', discussed below, or have a special meaning inside round brackets
;* usually means 0 or more of the preceding character

;note:
;a* (0 or more a's)
;a+ (1 or more a's)
;a{2,} (2 or more a's)
;a{3} (3 a's)
;a{4,6} (between 4 and 6 a's)
;a{0,7} (between 0 and 7 a's)
;a{,7} (warning: appears not to work)

;==================================================

;NOTES: + VERSUS *

;a+ 1 or more a's
;a* 0 or more a's
;.+ 1 or more characters
;.* 0 or more characters

;==================================================

;NOTES: ?

;zero or one of the preceding character, class, or subpattern:
;?

;Greed:
;see 'NOTES: <.+> VERSUS <.+?>' below

;To use the parentheses without the side-effect of capturing a subpattern
;e.g. (?:.*)

;Look-ahead and look-behind assertions:
;(?=...) pattern exists to Right
;(?!...) pattern does not exist to Right
;(?<=...) pattern exists to Left (\K is similar and more versatile)
;(?<!...) pattern does not exist to Left

;Callouts provide a means of temporarily passing control to the script in the middle of regular expression pattern matching.
;(Perform RegExMatch multiple times, a function retrieves the results one by one.)
;e.g. (?CCallout)

;Change options on-the-fly.
;e.g. (?im) turns on the case-insensitive and multiline options
;e.g. (?-im) would turn them both off

;==================================================

;NOTES: <.+> VERSUS <.+?>
;also: <.*> versus <.*?>

;https://autohotkey.com/docs/misc/RegEx-QuickRef.htm#UCP
;Greed: By default, *, ?, +, and {min,max} are greedy because they consume all characters up through the last possible one that still satisfies the entire pattern.
;To instead have them stop at the first possible character, follow them with a question mark.
;For example, the pattern <.+> (which lacks a question mark) means: "search for a <, followed by one or more of any character, followed by a >".
;To stop this pattern from matching the entire string <em>text</em>, append a question mark to the plus sign: <.+?>.
;This causes the match to stop at the first '>' and thus it matches only the first tag <em>.

;==================================================

;NOTES: ^

;check if string starts with 'a'
vPos := RegExMatch(vText, "^a")
;check if string contains a character that is not 'a'
;(returns 0 if string is blank or only contains a's)
vPos := RegExMatch(vText, "[^a]")

;==================================================

;NOTES: NEWLINES (LINE BREAKS)
;e.g. crop 3 characters from the start of each line
;the examples in this document assume CRLF-delimited text,
;but can be adjusted as shown in the examples below

;CRLF (`r`n)
vText := RegExReplace(vText, "m)^...")
;LF (`n)
vText := RegExReplace(vText, "`nm)^...")
;CR (`r)
vText := RegExReplace(vText, "`rm)^...")
;CR, LF, and CRLF
vText := RegExReplace(vText, "m)(*ANYCRLF)^...")
;any type of newline, namely `r, `n, `r`n, `v/VT/vertical tab/chr(0xB), `f/FF/formfeed/chr(0xC), and NEL/next-line/chr(0x85)
vText := RegExReplace(vText, "`am)^...")

;==================================================

;NOTES: CHARACTER CLASSES

;special characters: ^-]\
;e.g. [\^], [\-], [\]], and [\\]

;[abc] ;3 characters
;[a-z] ;lowercase letters
;[A-Za-z0-9] ;letters or digits
;[A-Za-z0-9\-_] ;valid characters in a YouTube video ID
;[aeiou] ;vowels
;[bcdfghjklmnpqrstvwxyz] ;consonants
;[b-df-hj-np-tv-z] ;consonants
;[^abc] ;not one of 3 characters
;[^a-z] ;not a lowercase letter
;[^A-Za-z0-9] ;not a letter or a digit

;note: [A-z] would include:
;ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz
;i.e. every character from 'A' (Chr(65)) to 'z' (Chr(122))

;==================================================

;NOTES: CHARACTERS

;e.g. double quotes: \x22
vText := "abc" Chr(34) "def"
MsgBox, % RegExReplace(vText, "\x22")

;remove characters 1 to 31
vText := ""
Loop, 255
	vText .= Chr(A_Index)
MsgBox, % ">>>" vText
MsgBox, % ">>>" RegExReplace(vText, "[\ca-\c_]")
MsgBox, % ">>>" RegExReplace(vText, "[\x01-\x1F]")

;==================================================

;NOTES: CHARACTER TYPES

;e.g.
;\p{xx} 'a character with the xx property'
;\P{xx} 'a character without the xx property'
;e.g. \p{Ll} a lowercase letter a-z
;e.g. \P{Ll} not a lowercase letter a-z

;for more details see:
;pcresyntax specification
;http://www.pcre.org/original/doc/html/pcresyntax.html#SEC5

;examples:

;[A-Z]
;\p{Lu}

;[a-z]
;\p{Ll}

;[A-Za-z]
;\p{L}
;[^\W0-9_] ;i.e. a '\w' (see below) but not an _ or digit

;[A-Za-z0-9]
;(\p{L}|\d)
;\p{Xan}
;[^\W_] ;i.e. a '\w' (see below) but not an _

;[A-Za-z0-9_]
;\p{Xwd}
;\w

;==================================================

;NOTES: CHARACTER TYPES (SCRIPT NAMES)

;example code to list every Unicode character (1 to 65535) for a certain script/'alphabet'/language:

;list of scripts (i.e. loosely speaking 'alphabets' and related characters) from:
;pcresyntax specification
;http://www.pcre.org/original/doc/html/pcresyntax.html
vList := "Arabic, Armenian, Avestan, Balinese, Bamum, Bassa_Vah, Batak, Bengali, Bopomofo, Brahmi, Braille, Buginese, Buhid, Canadian_Aboriginal, Carian, Caucasian_Albanian, Chakma, Cham, Cherokee, Common, Coptic, Cuneiform, Cypriot, Cyrillic, Deseret, Devanagari, Duployan, Egyptian_Hieroglyphs, Elbasan, Ethiopic, Georgian, Glagolitic, Gothic, Grantha, Greek, Gujarati, Gurmukhi, Han, Hangul, Hanunoo, Hebrew, Hiragana, Imperial_Aramaic, Inherited, Inscriptional_Pahlavi, Inscriptional_Parthian, Javanese, Kaithi, Kannada, Katakana, Kayah_Li, Kharoshthi, Khmer, Khojki, Khudawadi, Lao, Latin, Lepcha, Limbu, Linear_A, Linear_B, Lisu, Lycian, Lydian, Mahajani, Malayalam, Mandaic, Manichaean, Meetei_Mayek, Mende_Kikakui, Meroitic_Cursive, Meroitic_Hieroglyphs, Miao, Modi, Mongolian, Mro, Myanmar, Nabataean, New_Tai_Lue, Nko, Ogham, Ol_Chiki, Old_Italic, Old_North_Arabian, Old_Permic, Old_Persian, Old_South_Arabian, Old_Turkic, Oriya, Osmanya, Pahawh_Hmong, Palmyrene, Pau_Cin_Hau, Phags_Pa, Phoenician, Psalter_Pahlavi, Rejang, Runic, Samaritan, Saurashtra, Sharada, Shavian, Siddham, Sinhala, Sora_Sompeng, Sundanese, Syloti_Nagri, Syriac, Tagalog, Tagbanwa, Tai_Le, Tai_Tham, Tai_Viet, Takri, Tamil, Telugu, Thaana, Thai, Tibetan, Tifinagh, Tirhuta, Ugaritic, Vai, Warang_Citi, Yi"
vList := StrReplace(vList, ", ", ",")

vOutput := ""
VarSetCapacity(vOutput, 100000*2)
Loop, Parse, vList, % ","
{
	vNeedle := "\p{" A_LoopField "}"
	vTemp := ""
	VarSetCapacity(vTemp, 65535*2)
	Loop, 65535
		if RegExMatch(Chr(A_Index), vNeedle)
			vTemp .= Chr(A_Index)
	vOutput .= StrLen(vTemp) "`t" A_LoopField "`t" vTemp "`r`n"
}
Clipboard := vOutput
MsgBox, % "done"

;==================================================

;NOTES: POSIX NAMED SETS

;https://autohotkey.com/docs/misc/RegEx-QuickRef.htm#class
;The following POSIX named sets are also supported via the form [[:xxx:]],
;where xxx is one of the following words:
;alnum, alpha, ascii (0-127), blank (space or tab), cntrl (control character),
;digit (0-9), xdigit (hex digit), print, graph (print excluding space),
;punct, lower, upper, space (whitespace), word (same as \w).

vText := "|123abc$£¥€√|"
MsgBox, % RegExReplace(vText,"[^[:ascii:]]")
MsgBox, % RegExReplace(vText,"[[:ascii:]]")
MsgBox, % RegExMatch(vText,"[[:ascii:]]")
MsgBox, % RegExMatch(vText,"[^[:ascii:]]")
return

;==================================================

;NOTES: ESCAPED CHARACTERS
;escaped characters: \.*?+[{|()^$

;https://autohotkey.com/docs/misc/RegEx-QuickRef.htm#Options
;the characters \.*?+[{|()^$ must be preceded by a backslash to be seen as literal

;prepare a literal needle:
;12 characters that need escaping in RegEx generally: \.*?+[{|()^$
vNeedle := RegExReplace(vNeedle, "[\Q\.*?+[{|()^$\E]", "\$0")

;also:
vNeedle := "\Q" RegExReplace(vNeedle, "\\E", "\E\\E\Q") "\E"

;use literal characters in a character class:
;4 characters that need escaping in a RegEx character class: ^-]\
MsgBox, % RegExReplace("abc^-]\", "[abc]")
MsgBox, % RegExReplace("abc^-]\", "[a-z]")
MsgBox, % RegExReplace("abc^-]\", "[\^\-\]\\]")
MsgBox, % RegExReplace("abc^-]\", "[\Q^-]\\E]")

;this function will prepare a string to be searched literally
;in a needle for RegExMatch/RegExReplace:
JEE_StrRegExLiteral(vText)
{
	vOutput := ""
	VarSetCapacity(vOutput, StrLen(vText)*2*2)

	Loop, Parse, vText
		if InStr("\.*?+[{|()^$", A_LoopField)
			vOutput .= "\" A_LoopField
		else
			vOutput .= A_LoopField
	return vOutput
}

;==================================================

;COLUMNS/CROP: REMOVE COLUMNS (CROP BEFORE/AFTER FIRST/LAST OCCURRENCE IN EACH LINE)
;note: see 'NOTES: newlines' above [use (*ANYCRLF) or `a to handle more types of line break]

;(where n is the number of columns in the line)
;keep column 1 (remove columns 2 to n)
vText := RegExReplace(vText, "`t.*")
;keep columns 2 to n (remove column 1)
vText := RegExReplace(vText, "m)^.*?`t")
;vText := RegExReplace(vText, "mU)^.*`t") ;equivalent to line above
;keep columns 1 to n-1 (remove column n)
vText := RegExReplace(vText, "m)`t(?!.*`t).*")
;keep column n (remove columns 1 to n-1)
vText := RegExReplace(vText, ".*`t")

;ini get keys (keep column 1) (remove columns 2 to n)
vText := RegExReplace(vText, "=.*")
;ini get values (keep columns 2 to n) (remove column 1)
vText := RegExReplace(vText, "m)^.*?=")
;vText := RegExReplace(vText, "mU)^.*=") ;equivalent to line above

;AutoHotkey script remove comments (keep column 1) (remove columns 2 to n)
vText := RegExReplace(vText, " `;.*")

;==================================================

;COLUMNS: INCREASE WHITESPACE BETWEEN COLUMNS

;RegExReplace: expand nth gap
vText := " ;continuation section
(
a	b	c	d	e
f	g	h	i	j
k	l	m	n	o
p	q	r	s	t
u	v	w	x	y
z
)"
MsgBox, % vText
Loop, 4
{
	vNum := A_Index
	MsgBox, % RegExReplace(vText, "(^|\n)(\t*[^\t]*){" vNum "}\K\t", "`t`t")
}
MsgBox, % vText
Loop, 4
{
	vNum := A_Index
	MsgBox, % vText := RegExReplace(vText, "(^|\n)(\t*[^\t]*){" vNum "}\K\t", "`t`t")
}

;==================================================

;FIND/REMOVE CHARACTERS
;note: some of these are similar to 'if var is type'

;check if contains/doesn't contain certain characters
vPos := RegExMatch(vText, "[A-Za-z0-9_]") ;alphanumeric characters or underscore
vPos := RegExMatch(vText, "\w") ;alphanumeric characters or underscore
vPos := RegExMatch(vText, "[A-Za-z0-9_\-]") ;valid characters in a YouTube video ID
vPos := RegExMatch(vText, "[\w\-]") ;valid characters in a YouTube video ID
vPos := RegExMatch(vText, "[A-Za-z0-9]") ;alphanumeric characters
vPos := RegExMatch(vText, "i)[a-z0-9]") ;alphanumeric characters
vPos := RegExMatch(vText, "[A-Za-z]") ;letters
vPos := RegExMatch(vText, "[A-Z]") ;uppercase letters
vPos := RegExMatch(vText, "[a-z]") ;lowercase letters
vPos := RegExMatch(vText, "\d") ;digits
vPos := RegExMatch(vText, "[0-9]") ;digits
vPos := RegExMatch(vText, "[aeiou]") ;individual characters (e.g. vowels)

vPos := RegExMatch(vText, "[^A-Za-z0-9_]") ;not alphanumeric characters or underscore
vPos := RegExMatch(vText, "\W") ;not alphanumeric characters or underscore
vPos := RegExMatch(vText, "[^A-Za-z0-9_\-]") ;invalid characters in a YouTube video ID
vPos := RegExMatch(vText, "[^\w\-]") ;invalid characters in a YouTube video ID
vPos := RegExMatch(vText, "[^A-Za-z0-9]") ;non-alphanumeric characters
vPos := RegExMatch(vText, "i)[^a-z0-9]") ;non-alphanumeric characters
vPos := RegExMatch(vText, "[^A-Za-z]") ;non-letters
vPos := RegExMatch(vText, "[^A-Z]") ;not uppercase letters
vPos := RegExMatch(vText, "[^a-z]") ;not lowercase letters
vPos := RegExMatch(vText, "\D") ;non-digits
vPos := RegExMatch(vText, "[^0-9]") ;digits
vPos := RegExMatch(vText, "[^aeiou]") ;not individual characters (e.g. vowels)

;replace/remove characters (see just above for more RegEx needles)
vText := RegExReplace(vText, "[aeiou]")  ;individual characters (e.g. vowels)

;remove multiple strings
vText := RegExReplace(vText, "aa|bb|cc")
vText := RegExReplace(vText, "(aa|bb|cc)")

;further examples:

;if letters or digits only
if !RegExMatch(vText, "[^A-Za-z0-9]")
	MsgBox, % "letters/digits only"

;if letters/uppercase letters/lowercase letters only
if !RegExMatch(vText, "[^A-Za-z]")
	MsgBox, % "letters only"
if !RegExMatch(vText, "[^A-Z]")
	MsgBox, % "uppercase letters only"
if !RegExMatch(vText, "[^a-z]")
	MsgBox, % "lowercase letters only"

;check for invalid filename characters [Chr(1) to Chr(31) and \/:*?"<>|]
if RegExMatch(vName, "[" Chr(1) "-" Chr(31) "\\/:*?""<>|]") ;invalid file name characters (40)
if RegExMatch(vPath, "[" Chr(1) "-" Chr(31) "/*?""<>|]") ;invalid file path characters (38) (allow : and \)

;if digits only (with optional leading hyphen)
;if !RegExMatch(vNum, "[^0-9\-]") && !InStr(SubStr(vNum, 2), "-")
if RegExMatch(vNum, "^(-\d|)\d*$") ;improved version

;check for datestamp e.g. '03:02 04/05/2006' ('dd:dd dd/dd/dddd')
vPos := RegExMatch(vText, "\d\d:\d\d \d\d/\d\d/\d\d\d\d")

;word/phrase to initials
;e.g. 'light-emitting diode' to 'led' (LED)
vText := "light-emitting diode"
MsgBox, % RegExReplace(vText, "[A-Za-z]\K[A-Za-z]+|[^A-Za-z]") ;with +
MsgBox, % RegExReplace(vText, "[A-Za-z]\K[A-Za-z]|[^A-Za-z]")  ;without + (doesn't work)
MsgBox, % RegExReplace(vText, "(?<=[A-Za-z])[A-Za-z]+|[^A-Za-z]") ;with +
MsgBox, % RegExReplace(vText, "(?<=[A-Za-z])[A-Za-z]|[^A-Za-z]") ;without +

;==================================================

;REMOVE TAGS (REMOVE HTML TAGS)

;html: remove tags
vText := RegExReplace(vText, "<.+?>")

;html: remove 'a' tags
vText := RegExReplace(vText, "<a .+?>")

;old AutoHotkey forum: remove 'color' tags ('colour' tags)
vText := StrReplace(vText, "[/color]")
vText := RegExReplace(vText, "\[color=.+?]")

;==================================================

;STRING COMPARE (WILDCARDS): ? AND *
;compare strings using ? and * as wildcards

;prepare a literal string but with ? and * as wildcards:
;deal with special characters: \.*?+[{|()^$
vText := RegExReplace(vText, "[\Q\.+[{|()^$\E]", "\$0")
vText := StrReplace(vText, "?", ".")
vText := StrReplace(vText, "*", ".*")

;e.g.
q::
vText := "qwertyuiopasdfghjklzxcvbnm"
vNeedle := "qw?rty*m"
MsgBox, % JEE_StrMatchWildcards(vText, vNeedle)
return

JEE_StrMatchWildcards(vText, vNeedle, vCaseSen=0)
{
	vOpt := "s"
	(vCaseSen) ? "" : (vOpt .= "i")

	;escaped characters: \.*?+[{|()^$
	vNeedle2 := ""
	VarSetCapacity(vNeedle2, StrLen(vNeedle)*2*2)
	Loop, Parse, vNeedle
	{
		vTemp := A_LoopField
		(InStr("\.+[{|()^$", vTemp)) ? (vTemp := "\" vTemp) : ""
		(vTemp = "?") ? (vTemp := ".") : ""
		(vTemp = "*") ? (vTemp := ".*") : ""
		vNeedle2 .= vTemp
	}
	return (RegExMatch(vText, vOpt ")^" vNeedle2 "$") = 1)
}

;==================================================

;KEEP/REMOVE LINES THAT CONTAIN STRING

;note: if a line contains tbe needle, the line and the line break after it are removed,
;this will affect whether there are any trailing line breaks

;remove lines that contain string
vText := RegExReplace(vText, "m)^.*\Q" vNeedle "\E.*(\R|$)")
;remove lines that start with string
vText := RegExReplace(vText, "m)^\Q" vNeedle "\E.*(\R|$)")
;remove lines that end with string
vText := RegExReplace(vText, "m)^.*\Q" vNeedle "\E(\R|$)")

;make lines blank that contains string
vText := RegExReplace(vText, "m)^.*\Q" vNeedle "\E.*")
;make lines blank that start with string
vText := RegExReplace(vText, "m)^\Q" vNeedle "\E.*")
;make lines blank that end with string
vText := RegExReplace(vText, "m)^.*\Q" vNeedle "\E$")

;remove lines that contain YouTube webpage titles (e.g. prior to spellcheck)
;(i.e. remove lines that end with ' - YouTube')
vText := RegExReplace(vText, "m)^.* - YouTube(\R|$)")

vText := "abc.abc`r`nabc.txt`r`nabc.abc`r`nabc.txt`r`nabc.abc`r`nabc.txt`r`n"
;remove lines that end in .txt
MsgBox, % RegExReplace(vText, "m)^.*\.txt(\R|$)")
;only keep lines that end in .txt (remove lines that don't end in .txt) (note: uses look behind)
MsgBox, % RegExReplace(vText, "m)^.*(?<!\.txt)(\R|$)")

vText := "abc`r`ndef`r`nabc`r`ndef"
;remove lines that contain b
MsgBox, % RegExReplace(vText, "m)^.*b.*(\R|$)")
;only keep lines that contain b (remove lines that don't contain b) (note: uses look behind)
MsgBox, % RegExReplace(vText, "m)^((?!b).)*(\R|$)")

;==================================================

;CROP CHARACTERS
;crop first/last n characters from each line

;crop first 5 characters from each line
vText := RegExReplace(vText, "m)^.....")

;crop last 5 characters from each line
vText := RegExReplace(vText, "m).....$")

;crop first 5 and last 5 characters from each line
vText := RegExReplace(vText, "m)^.....|.....$")

;==============================

;delete text relative to needle

;delete everything after the first m
vText := "abcdefghijklmnopqrstuvwxyz"
MsgBox, % RegExReplace(vText, "^.*?m\K.*")

;delete from the first n onwards
vText := "abcdefghijklmnopqrstuvwxyz"
MsgBox, % RegExReplace(vText, "^.*?\Kn.*")

;delete everything up to the first m
vText := "abcdefghijklmnopqrstuvwxyz"
MsgBox, % RegExReplace(vText, "^.*?m")

;delete everything after the first n
vText := "abcdefghijklmnopqrstuvwxyz"
MsgBox, % RegExReplace(vText, "^.*(?=n)")

;==============================

;get text before first i
vText := "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
RegExMatch(vText, ".*?(?=i)", v)
MsgBox, % v

;get text before last i
vText := "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
RegExMatch(vText, ".*(?=i)", v)
MsgBox, % v

;==================================================

;GET NTH ITEM

;get first line
vText := SubStr(vText, 1, RegExMatch(vText "`r", "`r|`n") - 1)

;get nth item (useful link)
;NCHITTEST Full Throttled - basic Window manipulations - Scripts and Functions - AutoHotkey Community
;https://autohotkey.com/board/topic/31032-nchittest-full-throttled-basic-window-manipulations/#entry197623

vNum := 3
RegExMatch("ERROR TRANSPARENT NOWHERE CLIENT CAPTION SYSMENU SIZE MENU HSCROLL VSCROLL MINBUTTON MAXBUTTON Left Right TOP TOPLeft TOPRight BOTTOM BOTTOMLeft BOTTOMRight BORDER OBJECT CLOSE HELP", "(?:\w+\s+){" . ErrorLevel+2&0xFFFFFFFF . "}(?<AREA>\w+\b)", HT)
MsgBox, % HTAREA

;get nth item
vNum := 3
RegExMatch("red yellow green blue", "(?:\w+\s+){" (vNum-1) "}(?<Item>\w+\b)", vMatch)
MsgBox, % vMatchItem

;initial attempt at using a comma-separated list instead
vNum := 3
RegExMatch("red,yellow,green,blue", "(?:[^,]+,+){" (vNum-1) "}(?<Item>[^,]+)", vMatch)
MsgBox, % vMatch

;==================================================

;LOOK UP ITEMS IN A TABLE

;lookup list:
;e.g. RGB values

;uses look-ahead (?=...) and look-behind (?<=...) assertions, see:
;https://autohotkey.com/docs/misc/RegEx-QuickRef.htm#UCP

vNeedles := "red,yellow,green,blue,orange"
vList := "red:FF0000,yellow:FFFF00,green:00FF00,blue:0000FF"
Loop, Parse, vNeedles, `,
{
	vNeedle := A_LoopField
	;RegExMatch("," vList ",", "(?<=" vNeedle ":).*?(?=,)", vMatch) ;easier to understand version
	RegExMatch(vList, "(^|,)" vNeedle ":\K.*?(?=($|,))", vMatch)
	MsgBox, % vMatch
}

vNeedles := "red,yellow,green,blue,orange"
vList := "red=FF0000`nyellow=FFFF00`ngreen=00FF00`nblue=0000FF"
Loop, Parse, vNeedles, `,
{
	vNeedle := A_LoopField
	;RegExMatch("`n" vList "`n", "(?<=" vNeedle "=).*?(?=`n)", vMatch) ;easier to understand version
	RegExMatch(vList, "(^|`n)" vNeedle "=\K.*?(?=($|`n))", vMatch)
	MsgBox, % vMatch
}

;==================================================

;IF VAR IN LIST
;IF VAR CONTAINS(/STARTS/ENDS) LIST

;if string is in list (if var in)
MsgBox, % RegExMatch(vText, "^(red|yellow|green|blue)$")
MsgBox, % RegExMatch(vText, "^(Sun|Mon|Tues|Wednes|Thurs|Fri|Satur)day$")
MsgBox, % RegExMatch(vMonth, "^(4|6|9|11)$")

;if string starts with string (if var starts)
MsgBox, % RegExMatch(vText, "^http")
;if strings starts with one of items in list
MsgBox, % RegExMatch(vText, "^(re|un)")
MsgBox, % RegExMatch(vText, "^(http|www)")
;if string starts with one of characters in list
MsgBox, % RegExMatch(vText, "^[aeiou]")

;if string ends with string (if var ends)
MsgBox, % RegExMatch(vText, "day$")
;if strings ends with one of items in list
MsgBox, % RegExMatch(vText, "(s|ing|ed)$")
MsgBox, % RegExMatch(vText, "(bmp|gif|jpg|png)$")
;if string ends with one of characters in list
MsgBox, % RegExMatch(vText, "[aeiou]$")

;if string contains (at least) one of items in list (if var contains)
MsgBox, % RegExMatch(vText, "aa|bb|cc") ;case sensitive
MsgBox, % RegExMatch(vText, "i)aa|bb|cc") ;case insensitive

;if string contains every item in list (multiple if var contains)
vText := "zzAAzzBBzzCC"
MsgBox, % RegExMatch(vText, "(?=.*aa)(?=.*bb)(?=.*cc)") ;case sensitive
MsgBox, % RegExMatch(vText, "i)(?=.*aa)(?=.*bb)(?=.*cc)") ;case insensitive

;==================================================

;TRIM LEADING/MULTIPLE/TRAILING CHARACTERS

;trim leading/multiple/trailing whitespace
vText := RegExReplace(vText, "m)^[ `t]+")
vText := RegExReplace(vText, "[ `t]{2,}", " ") ;all multiple whitespace to spaces
vText := RegExReplace(vText, "[ `t]{2,}", "`t") ;all multiple whitespace to tabs
vText := RegExReplace(vText, " [ `t]+", " ") ;whitespace starting with space to spaces
vText := RegExReplace(vText, "`t[ `t]+", "`t") ;whitespace starting with tabs to tabs
vText := RegExReplace(vText, "m)[ `t]+$")

;trim leading/multiple/trailing spaces
vText := RegExReplace(vText, "m)^ +")
vText := RegExReplace(vText, " {2,}", " ")
vText := RegExReplace(vText, "m) +$")

;trim leading/multiple/trailing tabs
vText := RegExReplace(vText, "m)^`t+")
vText := RegExReplace(vText, "`t{2,}", "`t")
vText := RegExReplace(vText, "m)`t+$")

;trim leading/multiple/trailing CRLFs (trim enters)
;(note: multiple will remove blank lines,
;although it will leave leading/trailing blank lines)
vText := RegExReplace(vText, "^(`r`n)+")
vText := RegExReplace(vText, "(`r`n){2,}", "`r`n")
vText := RegExReplace(vText, "(`r`n)+$")

;multiple blank lines to single blank lines (trim blank lines)
;(note: this will replace multiple blank lines with single blank lines,
;although it will leave leading/trailing double blank lines)
vText := RegExReplace(vText, "(`r`n){3,}", "`r`n`r`n")

;==================================================

;RECREATING AUTOHOTKEY'S TRIM/LTRIM/RTRIM FUNCTIONS

;Trim/LTrim/RTrim via RegExReplace. Note: the original functions and these also, are case sensitive.

Trim(vText, vOmitChars=" `t")
{
	vOmitChars := RegExReplace(vOmitChars, "[\Q^-]\\E]", "\$0") ;make 4 chars literal: ^-]\
	return RegExReplace(vText, "^[" vOmitChars "]*|[" vOmitChars "]*$")
}
LTrim(vText, vOmitChars=" `t")
{
	vOmitChars := RegExReplace(vOmitChars, "[\Q^-]\\E]", "\$0") ;make 4 chars literal: ^-]\
	return RegExReplace(vText, "^[" vOmitChars "]*")
}
RTrim(vText, vOmitChars=" `t")
{
	vOmitChars := RegExReplace(vOmitChars, "[\Q^-]\\E]", "\$0") ;make 4 chars literal: ^-]\
	return RegExReplace(vText, "[" vOmitChars "]*$")
}

;==================================================

;SEPARATE LEADING WHITESPACE / CODE / COMMENTS

;LEADING WHITESPACE / CODE
;if there are 5 spaces I want the number 6
;if there are 0 spaces I want the number 1 (even if the line is blank)
;in order to do this:
;vWhitespace := SubStr(vText, 1, vPos-1)
;vCode := SubStr(vText, vPos)

vText := A_Space A_Space A_Space A_Space A_Space
MsgBox, % vPos := RegExMatch(vText, "[ `t]*\K")
vText := ""
MsgBox, % vPos := RegExMatch(vText, "[ `t]*\K")

;CODE / COMMENTS
;AutoHotkey sees comments as a semicolon preceded by a space or tab
;get start of comments on a line
;vPos := RegExMatch(vText, "[ `t]+;")
;remove comments from a line
;vText := RegExReplace(vText, "[ `t]+;.*")

;==================================================

;PUT STRINGS BEFORE/AFTER OCCURRENCES OF NEEDLE

;put strings before/after datestamps (datestamp is anywhere)
vText := RegExReplace(vText, "\d\d:\d\d \d\d/\d\d/\d\d\d\d", vPrefix "$0" vSuffix)

;put strings before/after datestamps (datestamp is the entire line)
vText := RegExReplace(vText, "m)^\d\d:\d\d \d\d/\d\d/\d\d\d\d$", vPrefix "$0" vSuffix)

;enclose pagestamps (that occupy an entire line) in square brackets e.g. 'p.1' to '[p.1]'
vText := RegExReplace(vText, "m)^p\.\d+$", "[$0]")

;put parentheses (round brackets) around first item
vText1 := "abc,def,ghi"
vText2 := "abc,def"
vText3 := "abc"
MsgBox, % "(" RegExReplace(vText1, "^[^,]*(?=,|$)", "$0)")
MsgBox, % "(" RegExReplace(vText2, "^[^,]*.(?=,|$)", "$0)")
MsgBox, % "(" RegExReplace(vText3, "^[^,]*.(?=,|$)", "$0)")

;put parentheses (round brackets) around last item
vText1 := "abc,def,ghi"
vText2 := "abc,def"
vText3 := "abc"
MsgBox, % RegExReplace(vText1, "(?<=^|,).(?!.*,)", "($0") ")"
MsgBox, % RegExReplace(vText2, "(?<=^|,).(?!.*,)", "($0") ")"
MsgBox, % RegExReplace(vText3, "(?<=^|,).(?!.*,)", "($0") ")"

;==================================================

;SLICE STRING / PAD STRING

vText := "abcdefghij"
MsgBox, % RegExReplace(vText, "", "_") ;Left/middle/Right ;_a_b_c_d_e_f_g_h_i_j_
MsgBox, % RegExReplace(vText, "(?<=.)(?=.)", "_") ;middle ;a_b_c_d_e_f_g_h_i_j
MsgBox, % RegExReplace(vText, "(?=.)", "_") ;Left/middle ;_a_b_c_d_e_f_g_h_i_j
MsgBox, % RegExReplace(vText, "(?<=.)", "_") ;middle/Right ;a_b_c_d_e_f_g_h_i_j_

vText := "abcdefghijklmnopqrstuvwxyz"
MsgBox, % Trim(RegExReplace(vText, ".{3}", "$0_"), "_") ;abc_def_ghi_jkl_mno_pqr_stu_vwx_yz

vText := "abcdefghijklmnopqrstuvwxyz"
MsgBox, % Trim(RegExReplace("_" vText, ".{3}", "$0_"), "_") ;ab_cde_fgh_ijk_lmn_opq_rst_uvw_xyz

vText := "abcdefghijklmnopqrstuvwxyz"
MsgBox, % Trim(RegExReplace("__" vText, ".{3}", "$0_"), "_") ;a_bcd_efg_hij_klm_nop_qrs_tuv_wxy_z

vText := "abcdefghijklmnopqrstuvwxyz"
vOutput := ""
Loop, 26
	vOutput .= Trim(RegExReplace(vText, ".{" A_Index "}", "$0 ")) "`r`n"
MsgBox, % SubStr(vOutput, 1, -2)

;==================================================

;WHOLE WORD MATCH/REPLACE

;whole word match
if RegExMatch(vText, "\b\Q" A_LoopField "\E\b")

;whole word replace (e.g. change variable names)
vText := RegExReplace(vText, "\bname_no_ext\b", "vNameNoExt", 0, -1, 1)

;==================================================

;UPPERCASE / LOWERCASE / TITLE CASE

vText := "The quick brown fox jumps over the lazy dog."
MsgBox, % RegExReplace(vText, ".*", "$U0")

vText := "The quick brown fox jumps over the lazy dog."
MsgBox, % RegExReplace(vText, ".*", "$L0")

vText := "The quick brown fox jumps over the lazy dog."
MsgBox, % RegExReplace(vText, ".*", "$T0")

vText := "HeLLO HeLLo HeLLo"
MsgBox, % RegExReplace(vText, "([^ ]*) ([^ ]*) ([^ ]*)", "$U1 $T2 $L3")

;there are many different variants of 'title case',
;even MS Excel and MS Word differ on how they convert to title case,
;here is some code for converting to title case which you may want to tweak:

vText := "The quick brown fox jumps over the lazy dog."
MsgBox, % RegExReplace(vText, "(\b[a-z])", "$U1")

vText := "The-quick-brown-fox-jumps-over-the-lazy-dog."
MsgBox, % RegExReplace(vText, "(\b[a-z])", "$U1")

;invert case:
vText := "Hello World"
MsgBox, % RegExReplace(vText, "([A-Z])|([a-z])", "$L1$U2")

;get string but only when it's *not* lowercase
vText := "_aaa_Aaa_AAA_aaa_Aaa_AAA_"
vPos := 1
vOutput := ""
;note: uses look behind
while vPos := RegExMatch(vText, "i)aaa(?-i)(?<!aaa)", "", vPos)
	vOutput .= SubStr(vText, vPos, 3) "`r`n", vPos += 3
MsgBox, % SubStr(vOutput, 1, -2)

;get string but only when it's *not* lower/title/upper case
vText := "_aaa_Aaa_aAA_AAA_aaa_Aaa_AAA_aAA_"
vPos := 1
vOutput := ""
;note: uses look behind
while vPos := RegExMatch(vText, "i)aaa(?-i)(?<!(aaa|Aaa|AAA))", "", vPos)
	vOutput .= SubStr(vText, vPos, 3) "`r`n", vPos += 3
MsgBox, % SubStr(vOutput, 1, -2)

;==================================================

;REMOVE URLS FROM STRING

;remove urls (e.g. prior to spellcheck)
;(there may be more advanced ways of doing this)
vListUrl := ""
VarSetCapacity(vListUrl, StrLen(vText)*2)
Loop
{
	if !RegExMatch(vText, "\bhttp.*?\b", vUrl, 1)
		break
	vText := RegExReplace(vText, "\bhttp.*?\b", "", 0, 1, 1)
	vListUrl .= vUrl "`r`n"
}
Loop
{
	if !RegExMatch(vText, "\bwww\.+?\b", vUrl, 1)
		break
	vText := RegExReplace(vText, "\bwww\.+?\b", "", 0, 1, 1)
	vListUrl .= vUrl "`r`n"
}

;==================================================

;SPLIT PATH

;there are many techniques for splitting a path into dir/name/name no ext/ext etc
;here are some of them:

vPath := "C:\Program Files\AutoHotkey\AutoHotkey.exe"
;vPath := "C:\Program Files\AutoHotkey\MyNoExtFile"
SplitPath, vPath, vName, vDir, vExt, vNameNoExt, vDrive
MsgBox, % vName "`r`n" vDir "`r`n" vExt "`r`n" vNameNoExt "`r`n" vDrive

;path/name to name
vOutput := "name:`r`n" vName
vOutput .= "`r`n" RegExReplace(vPath, ".*\\")
;vOutput .= "`r`n" SubStr(vPath, InStr(vPath, "\", 0, 0)+1) ;AHK v1
vOutput .= "`r`n" SubStr(vPath, InStr(vPath, "\", 0, -1)+1) ;AHK v2
MsgBox, % vOutput

;path to directory
vOutput := "dir:`r`n" vDir
vOutput .= "`r`n" RegExReplace(vPath, "\\(?!.*\\).*$")
vOutput .= "`r`n" RegExReplace(vPath, "\\[^\\]*$")
vOutput .= "`r`n" RegExReplace(vPath, ".*\K\\.*")
;vOutput .= "`r`n" SubStr(vPath, 1, InStr(vPath, "\", 0, 0)-1) ;AHK v1
vOutput .= "`r`n" SubStr(vPath, 1, InStr(vPath, "\", 0, -1)-1) ;AHK v2
MsgBox, % vOutput

;path to directory (with trailing backslash)
vOutput := "dir\:`r`n" vDir "\"
vOutput .= "`r`n" RegExReplace(vPath, "(?!.*\\).*$")
vOutput .= "`r`n" RegExReplace(vPath, "[^\\]*$")
vOutput .= "`r`n" RegExReplace(vPath, ".*\\\K.*")
;vOutput .= "`r`n" SubStr(vPath, 1, InStr(vPath, "\", 0, 0)) ;AHK v1
vOutput .= "`r`n" SubStr(vPath, 1, InStr(vPath, "\", 0, -1)) ;AHK v2
MsgBox, % vOutput

;path/name to extension
vOutput := "ext:`r`n" vExt
;vOutput .= "`r`n" RegExReplace(vPath, ".*(\.|$)") ;doesn't work
vOutput .= "`r`n" RegExReplace(vPath, "^.*?((\.(?!.*\\)(?!.*\.))|$)")
MsgBox, % vOutput

;path/name to name no extension
vOutput := "name no ext:`r`n" vNameNoExt
vOutput .= "`r`n" RegExReplace(vPath, ".*\\|\.[^.]*$")
MsgBox, % vOutput

;path to drive
vOutput := "drive:`r`n" vDrive
vOutput .= "`r`n" RegExReplace(vPath, ".*?:\K.*")
MsgBox, % vOutput

;also:
vPath := "C:\abc.def\ghi.jkl"
;vPath := "C:\abc.def\ghi"
;vPath := "ghi.jkl"
;vPath := "ghi"
vName := vPath

;remove extension (path to path no extension) (name to name no extension)
MsgBox, % RegExReplace(vPath, "\.[^.\\]*$")

;remove extension (name to name no extension)
;(note: not reliable for 'path to path no extension', e.g. if the directory contains '.' but the name doesn't)
MsgBox, % RegExReplace(vName, "\.[^.]*$")

;==================================================

;DATES

;alternatives to AutoHotkey's FormatTime function
;where A_Now is of the form 'yyyyMMddHHmmss'
MsgBox, % vDate := RegExReplace(A_Now, "(....)(..)(..).{6}", "$1-$2-$3")
MsgBox, % vDate := RegExReplace(A_Now, ".{8}(..)(..)(..)", "$1-$2-$3")
MsgBox, % vDate := RegExReplace(A_Now, "(....)(..)(..)(..)(..)(..)", "$1-$2-$3 $4-$5-$6")
MsgBox, % vDate := RegExReplace(A_Now, "(?<=..)..(?=.)", "$0|") ;e.g. 20060504030201 -> 2006|05|04|03|02|01
MsgBox, % vDate := RegExReplace(A_Now, "(?<=..)..(?=.)", "$0 ") ;e.g. 20060504030201 -> 2006 05 04 03 02 01

;from:
;[handy FormatTime one-liners]
;combining date variables is unreliable - AutoHotkey Community
;https://autohotkey.com/boards/viewtopic.php?f=5&t=36338

;==================================================

;BACKREFERENCES

;RegExMatch, brackets within brackets

vText := "abc123xyz"
RegExMatch(vText, "(abc)123(xyz)", v)
MsgBox, % v1 " " v2
RegExMatch(vText, "(abc(123)xyz)", v)
MsgBox, % v1 " " v2

RegExMatch(A_Now, "^(?P<Year>\d{4})(?P<Month>\d{2})(?P<Day>\d{2})", v)
MsgBox, % Format("{} {} {}", vYear, vMonth, vDay)

RegExMatch(A_Now, "O)^(?P<Year>\d{4})(?P<Month>\d{2})(?P<Day>\d{2})", o)
MsgBox, % Format("{} {} {}", o.Year, o.Month, o.Day)

;==================================================

;BINARY SEARCH
;binary search (get offset of binary needle relative to start of variable)

;https://autohotkey.com/docs/misc/RegEx-QuickRef.htm
;Escape sequences in the form \xhh are also supported,
;in which hh is the hex code of any ANSI character between 00 and FF.

;e.g. the string 'abcd' as a haystack (UTF-16 LE) (4 characters, 8 bytes)
;bytes in order (in hex): 61,00,62,00,63,00,64,00
vText := "abcd"
MsgBox, % (RegExMatch(vText, "\x{0061}\x{0062}") - 1) * 2
MsgBox, % (RegExMatch(vText, "\x{0063}\x{0064}") - 1) * 2

;e.g. the square root sign as a needle (Chr(8730)) (UTF-16 LE) (1 character, 2 bytes)
;bytes in order (in hex): 1A,22
vText := "aaa" Chr(8730)
MsgBox, % (RegExMatch(vText, "\x{221A}") - 1) * 2

;e.g. the number 0x1020304000000000 as an Int64 in an 8-byte variable as a haystack
;bytes in order (in hex): 00,00,00,00,40,30,20,10
VarSetCapacity(vData, 8, 1)
NumPut(0x1020304000000000, vData, 0, "Int64")
MsgBox, % (RegExMatch(vData, "\x{3040}\x{1020}") - 1) * 2

;I recommend wOxxOm's InBuf function for binary searching:
;Machine code binary buffer searching regardless of NULL - Scripts and Functions - AutoHotkey Community
;https://autohotkey.com/board/topic/23627-machine-code-binary-buffer-searching-regardless-of-null/

;==================================================

;REGULAR EXPRESSION CALLOUTS (GET ALL MATCHES/OCCURRENCES)
;(Perform RegExMatch multiple times, a function retrieves the results one by one.)

;https://autohotkey.com/docs/misc/RegExCallout.htm
;Callouts provide a means of temporarily passing control to the script in the middle of regular expression pattern matching.

;e.g. datestamps and text, get list of datestamps and first line
vText = ;continuation section
(Join`r`n
01:00 01/01/2001
S1 L1
S1 L2

02:00 01/01/2001
S2 L1
S2 L2
)

vOutput := ""
RegExMatch(vText, "(?:^|`r`n)\K(\d\d:\d\d \d\d/\d\d/\d\d\d\d)`r`n(.*?)(?=`r`n|$)(?CCallout)")
MsgBox, % vOutput
return

Callout(m)
{
	global vOutput
	MsgBox, m=%m%`r`nm1=%m1%`r`nm2=%m2%
	vOutput .= m1 "`t" m2 "`r`n"
	return 1
}

;Note: if we replaced '(?CCallout)' with '(?C10:Callout)'.
;and if we replaced 'Callout(m)' with 'Callout(m, n)'
;then n would contain the number '10'.

;==================================================

;GET ALL MATCHES

;to count occurrences:
vText := "ABCabcd12345"
MsgBox, % RegExReplace(vText, "[A-Z]", "", vCountU)
MsgBox, % RegExReplace(vText, "[a-z]", "", vCountL)
MsgBox, % RegExReplace(vText, "\d", "", vCountN)
MsgBox, % Format("{} {} {}", vCountU, vCountL, vCountN)

;note: RegExMatch does not have a way to get all matches and store them in an object

;get multiple matches via a while loop
vText := "abc 123 def 456 ghi 789"
vOutput := "", vPos := 1
while vPos := RegExMatch(vText, "O)[A-Za-z]+", o, vPos)
	vOutput .= o.0 "`r`n", vPos += StrLen(o.0)
MsgBox, % vOutput

;get multiple matches by repeating the needle
;you can use RegExReplace to work out how many times to repeat a needle
;note: if an item appears more times than the repeated needle, the approach will still work
;note: if an item appears fewer times than the repeated needle, the approach will fail
;note: you need to pick appropriate RegEx needles and padding
vText := "abc 123 def 456 ghi 789"
vNeedle := "[A-Za-z]+"
vNeedlePad := ".*?"
RegExReplace(vText, vNeedle, "", vCount)
;MsgBox, % vCount
vNeedleMult := ""
Loop, % vCount-1
	vNeedleMult .= "(" vNeedle ")" vNeedlePad
vNeedleMult .= "(" vNeedle ")"
MsgBox, % vNeedleMult
RegExMatch(vText, "O)" vNeedleMult, o)
vOutput := ""
Loop, % o.Count()
	vOutput .= o[A_Index] "`r`n"
MsgBox, % vOutput

;see also: the section on callouts above

;see also:
;extracting items from a list using RegEx (various methods) (get all matches) - AutoHotkey Community
;https://autohotkey.com/boards/viewtopic.php?f=5&t=30448
;RegEx issue. Of course.... - AutoHotkey Community
;https://autohotkey.com/boards/viewtopic.php?f=5&t=43975&p=199745#p199745

;==================================================

;SYNTAX SPECIFIC TO AUTOHOTKEY

;AutoHotkey accepts various options
;placed before a close bracket
;e.g. object mode: 'O)'

;AHK v1:
;O: object mode, P: position mode
;"" literal double quote

;AHK v2 alpha:
;`" literal double quote

;==================================================

;QUERIES

;is '[a-zA-Z0-9]' preferable to '[A-Za-z0-9]'?
;(in some tests it seemed to make no difference to the speed)
;(presumably lowercase letters appear more often than uppercase letters,
;so better to check for them first when looking for
;a character class that includes/excludes letters,
;so that on average, fewer characters are searched for)

;possible to add numbers to each line?
;e.g. add number n and a tab to the start of line n
vText := Clipboard
vOutput := ""
VarSetCapacity(vOutput, StrLen(vText)*2*2)
vText := StrReplace(vText, "`r`n", "`n")
Loop, Parse, vText, `n
	vOutput .= A_Index "`t" A_LoopField "`r`n"
Clipboard := vOutput

;look up list item, RegEx not working (that in theory should work):
vList := "red:FF0000,yellow:FFFF00,green:00FF00,blue:0000FF"
;vNeedle := "red"
vNeedle := "yellow"
MsgBox, % RegExMatch(vList, "(?<=," vNeedle ":).*?(?=($|,))", vMatch) ;works except for first word in the list
MsgBox, % RegExMatch(vList, "(?<=(^|,)" vNeedle ":).*?(?=($|,))", vMatch) ;didn't work (but looks like it should)
MsgBox, % RegExMatch(vList, "(^|,)" vNeedle ":\K.*?(?=($|,))", vMatch) ;works
MsgBox, % vMatch
;https://autohotkey.com/docs/misc/RegEx-QuickRef.htm#UCP
;is this the explanation?
;Look-behinds are more limited than look-aheads because they do not support quantifiers of varying size such as *, ?, and +.

;\Q and \E are not guaranteed to work if the string in-between also contains \Q and \E, Right?

;Is it possible to achieve the AutoHotkey RegEx 'options',
;by putting text in the needle proper? (i.e. if you use RegEx outside of AutoHotkey)
;e.g. i m s U (case-insensitive matching, multiline, DotAll, ungreedy) [see: Change options on-the-fly][https://autohotkey.com/docs/misc/RegEx-QuickRef.htm]
;e.g. `n `r `a [unresolved]
;see: https://autohotkey.com/docs/misc/RegEx-QuickRef.htm#Options

;I would be interested in RegExMatch versions
;of AutoHotkey's 'if var is type',
;if anyone has already prepared such RegEx needles.
;See script.cpp, for the source code:
;search for 'case ACT_IFIS:', the second occurrence.
;See also:
;If var is [not] type
;https://autohotkey.com/docs/commands/IfIs.htm

;is it possible to repeat a string n times using RegEx?

;unresolved:
;key things in RegEx I've not been able to do
;repeat a string n times
;reverse a string
;replace A1 with A2, B1 with B2 etc
;output 1 if matches A, 2 if matches B, etc

;==================================================