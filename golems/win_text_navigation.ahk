#IfWinActive 
; TEXT MANIPULATION ____________________________________________________________
 !Backspace::  Send {Backspace}{End}{Shift Down}{Up}{End}{Shift Up}{Backspace}  ;[TM] Delete line with backspace from end of line
 ^#Backspace:: replaceDeletedCharWithSpaces()                                   ;[TM] Delete selected text and replace with blank spaces 

 +^u::         ConvertUpper()                                                   ;[TM] case: capitalize selected text
 +!u::         ConvertLower()                                                   ;[TM] case: convert selected text to lower case
 ^!u::         FirstLetterCapitalized()                                         ;[TM] case: First letter capitalized
 ^!+u::        EveryFirstLetterCapitalized()                                    ;[TM] case: Every First Letter Capitalized
 
 #x::          TrimText(True)                                                   ;[TM] cut and trim whitespace around selected text
 #c::          TrimText()                                                       ;[TM] copy and trim whitespace around selected text
 !#enter::     RemoveBlankLines()                                               ;[TM] remove empty lines from selected text
 !v::          PasteWithoutBreaks()                                             ;[TM] replace multiple paragraph breaks in selected text
 ^#sc028::     addQuotesAroundCommaSeparatedElements()                          ;[TM] surround each element of comma separated list with quotation marks
 #!sc028::     ReplaceQuotesWithSpaces()                                        ;[TM] replace double quotation marks with spaces in selected text
 !#space::     RemoveAllSpaces()                                                ;[TM] remove all spaces from selected text
 ^#space::     ReplaceManySpaceWith1Space()                                     ;[TM] replace multiple consecutive spaces w/ one in selected text
 ^#del::       ReplacePlusOrCommaWithSpace()                                    ;[TM] replace "+" or "," with " " in selected text

; TEXT SELECTION _______________________________________________________________

 +!h::      send {ctrl down}{Left}{ctrl up}                                     ;[TS] jump to next word = simulate ctrl+Left
 +!l::      send {ctrl down}{Right}{ctrl up}                                    ;[TS] jump to next word = simulate ctrl+Right
 ^#Left::                                                                       ;[TS] select to beginning of line 
 ^#h::      send {Shift Down}{Home}{Shift Up}                                   ;[TS] select to beginning of line
 ^#Right::                                                                      ;[TS] select to end of line
 ^#l::      send {Shift Down}{End}{Shift Up}                                    ;[TS] select to end of line
 ^#j::                                                                          ;[TS] select all below
 +^#l::     send {ctrl down}{shift down}{end}{ctrl up}{shift up}                ;[TS] select all below
 ^#k::                                                                          ;[TS] select all above
 +^#h::     send {ctrl down}{shift down}{home}{ctrl up}{shift up}               ;[TS] select all above
 !f::       SelectWord()                                                        ;[TS] select word at text cursor
 +!f::      SelectLine()                                                        ;[TS] select current line from begining of line
 ^!f::      Send {end}{shift down}{home}{shift up}                              ;[TS] select current line from end of line
 +^l::      Send {shift down}{ctrl down}{Right}{shift up}{ctrl up}              ;[TS] extend selection Right one word
 ^+!l::     Send {shift down}{Right}{shift up}                                  ;[TS] extend selection Right one space
 +^!h::     Send {shift down}{Left}{ctrl up}                                    ;[TS] extend selection Left one space
 +^h::      Send {shift down}{ctrl down}{Left}{shift up}{ctrl up}               ;[TS] extend selection Left one word
 +^j::                                                                          ;[TS] select to next line
 +^!j::     Send {shift down}{down}{shift up}                                   ;[TS] select to next line
 +^k::                                                                          ;[TS] select to line above
 +^!k::     Send {shift down}{up}{shift up}                                     ;[TS] select to line above


; NAVIGATION & KEY REPLACEMENT__________________________________________________
 
 #h::                                                                           ;[NKR] Home
 ^!h::                                                                          ;[NKR] Home
 !^Left::          send {home}                                                  ;[NKR] Home
 #l::                                                                           ;[NKR] End
 ^!l::                                                                          ;[NKR] End
 !^Right::         send {end}                                                   ;[NKR] End

 $!h::             send {Left}                                                  ;[NKR] Left
 $!l::             send {Right}                                                 ;[NKR] Right
 $!k::             send {Up}                                                    ;[NKR] Up
 $!j::             send {Down}                                                  ;[NKR] Down 

 ^SC027::          Send {AppsKey}                                               ;[NKR] appkey press
 $!SC027::         Send {esc}                                                   ;[NKR] esc key
 +CapsLock::       CapsLock                                                     ;[NKR] Backspace
 ;CapsLock::        Send {Delete}                                               ;[NKR] Delete 
 ^CapsLock::       CapsLock                                                     ;[NKR] Toggle capslock

 rwin::                                                                         ;[NKR] modifier key (use ctrl+esc or windows key + left mouse click to access start menu) 
 lwin::            return                                                       ;[NKR] modifier key (use ctrl+esc or windows key + left mouse click to access start menu) 
 PrintScreen::     return                                                       ;[NKR] modifier key no action otherwise

; TEXT BRACKETS ________________________________________________________________

 +!9::                                                                          ;[TB] enclose selected text with ( )
 !9::               Clip("(" Clip() ")")                                        ;[TB] enclose selected text with ( )
 $+!SC01A::         Clip("{" Clip() "}")                                        ;[TB] enclose selected text with { }
 !SC01A::           Clip("[" Clip() "]")                                        ;[TB] enclose selected text with [ ]
 ^SC028::           Clip("'" Clip() "'")                                        ;[TB] enclose selected text with ' '
 +!SC028::          Clip("""" Clip() """")                                      ;[TB] enclose selected text with " "
 !5::               Clip("%" Clip() "%")                                        ;[TB] enclose selected text with % %
 !4::               Clip("$" Clip() "$")                                        ;[TB] enclose selected text with $ $
 ^!sc027::          send {{}                                                    ;[TB] open curly braces
 ^!sc028::          send {}}                                                    ;[TB] close curly braces

; CONVENIENCE __________________________________________________________________

 :*:date*::                                                                     ;[C] current date
     FormatTime, CurrentDateTime,, MMMM dd, yyyy
     clip(CurrentDateTime)
     return 
 
 +!sc00C::     Send, {ASC 0150}                                                 ;[C] en dash (–)
 !sc00C::      Send, {ASC 0151}                                                 ;[C] em dash (—)

 
 $#LButton::  PasteClipboardAtMouseCursor()                                     ;[C] double click, trim(clipboard), paste 
 $^!LButton:: send ^{esc}                                                       ;[C] open start menu (alt: Ctrl+Esc)

 ; TABS _________________________________________________________________________
 ; system wide shortcuts for navigating between tabs
 !b:: send ^{PgUp}                                                              ;[T] move to right tab
 >!space::                                                                      ;[T] move to left tab
 <!space::                                                                      ;[T] move to left tab
    keywait space 
    send ^{PgDn}                                                                
    return
 
; MOUSE FUNCTIONS ______________________________________________________________
 ; mouse functions with keyboard shortcuts 

 #j::                            Click, WheelDown 2                             ;[MF] scroll wheel down
 #k::                            Click, WheelUp 2                               ;[MF] scroll wheel up 
 
 *#i::                           click                                          ;[MF] 1 Left click 
 ^#f::                           MouseClicks(3)                                 ;[MF] 3 Left clicks (select line)

 ~lwin & rshift::                JumpMiddle()                                   ;[MF] move mouse cursor to middle
 +#k::                           JumpTopEdge()                                  ;[MF] move mouse cursor to top edge
 +#j::                           JumpBottomEdge()                               ;[MF] move mouse cursor to bottom edge 
 +#h::                           JumpLeftEdge()                                 ;[MF] move mouse cursor to Left edge
 +#l::                           JumpRightEdge()                                ;[MF] move mouse cursor to Right edge

 