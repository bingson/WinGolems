#IfWinActive 
; TEXT MANIPULATION ____________________________________________________________
 !Backspace::  Send {Backspace}{End}{Shift Down}{Up}{End}{Shift Up}{Backspace}  ;[TM] edit: Delete line with backspace from end of line
 ^#Backspace:: replaceDeletedCharWithSpaces()                                   ;[TM] edit: Delete selected text and replace with blank spaces 
 ^Capslock::   Send {del}{home}{shift down}{down}{shift up}{del}                ;[TM] edit: Delete line
 +^u::         ConvertUpper()                                                   ;[TM] case: capitalize selected text
 +!u::         ConvertLower()                                                   ;[TM] case: convert selected text to lower case
 ^!u::         FirstLetterCapitalized()                                         ;[TM] case: First letter capitalized
 ^!+u::        EveryFirstLetterCapitalized()                                    ;[TM] case: Every First Letter Capitalized
 #x::          TrimText(True)                                                   ;[TM] cut and trim whitespace around selected text
 #c::          TrimText()                                                       ;[TM] copy and trim whitespace around selected text
 ^#t::         FormatTranscript()                                               ;[TM] remove time index from selected transcript
 !#enter::     RemoveBlankLines()                                               ;[TM] remove empty lines from selected text
 +#v::                                                                          ;[TM] paste, then delete same number of spaces (aka. overtype paste)
 ^#v::         PasteDelExtraSpaces()                                            ;[TM] paste, then delete same number of spaces (aka. overtype paste)
 !v::          PasteWithoutBreaks()                                             ;[TM] replace multiple paragraph breaks in selected text
 +!v::         PasteWithoutBreaks(True)                                         ;[TM] replace multiple paragraph breaks, reselect text = True
 ^#sc028::     addQuotesAroundCommaSeparatedElements()                          ;[TM] surround each element of comma separated list with quotation marks
 #!sc028::     ReplaceQuotesWithSpaces()                                        ;[TM] replace double quotation marks with spaces in selected text
 !#space::     RemoveAllSpaces()                                                ;[TM] remove all spaces from selected text
 ^#space::     ReplaceManySpaceWith1Space()                                     ;[TM] replace multiple consecutive spaces w/ one in selected text
 ^#del::       ReplacePlusOrCommaWithSpace()                                    ;[TM] replace "+" or "," with " " in selected text
 #!sc00C::     ReplaceUnderscoreWithSpace()                                     ;[TM] replace "_" with " " in selected text
 ^#sc00C::     ReplaceSpaceWithUnderscore()                                     ;[TM] replace " " with "_" in selected text
 #!SC034::     ReplacePeriodWithSpace()                                         ;[TM] replace "." with " " in selected text
 ^#SC00D::     ReplaceSpacesWithPluses()                                        ;[TM] replace " " with "+" in selected text
 ^#SC033::     ReplaceSpacesWithCommas()                                        ;[TM] replace " " with "," in selected text
 #!SC00D::     ReplaceCommasWithPluses()                                        ;[TM] replace "," with "+" in selected text
 #!SC033::     ReplacePlusesWithCommas()                                        ;[TM] replace "+" with "," in selected text
 ^#SC02B::     ReplaceSpacesWithPipe()                                          ;[TM] replace " " with "|" in selected text
 #!d::         ReplaceDashWithSpaces()                                          ;[TM] replace "-" with " " in selected text
 ^#d::         ReplaceSpacesWithDash()                                          ;[TM] replace " " with "-" in selected text
 <!#e::        ReplaceEqualWithSpace()                                          ;[TM] replace "=" with " " in selected text
 #If GetKeyState("PrintScreen", "P")
 ralt & e::    ReplaceEqualWithUnderscore()                                     ;[TM] replace "=" with "_" in selected text (requires printscreen key pressed as well)
 #If

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
 !^Left::                                                                       ;[NKR] Home
 PrintScreen & h:: send {home}                                                  ;[NKR] Home
 #l::                                                                           ;[NKR] End
 ^!l::                                                                          ;[NKR] End
 !^Right::                                                                      ;[NKR] End
 PrintScreen & l:: send {end}                                                   ;[NKR] End

 $!h:: send {Left}                                                              ;[NKR] Left
 $!l:: send {Right}                                                             ;[NKR] Right
 $!k:: send {Up}                                                                ;[NKR] Up
 $!j:: send {Down}                                                              ;[NKR] Down

 #e::  send {ctrl down}{home}{ctrl up}                                          ;[NKR] Ctrl + Home
 +#e::  send {ctrl down}{end}{ctrl up}                                          ;[NKR] Ctrl + End
 
 ^SC027::          Send {AppsKey}                                               ;[NKR] appkey press
 ^m::              Send ^c                                                      ;[NKR] Right-handed copy (ctrl-c)
 $!SC027::         Send {esc}                                                   ;[NKR] esc key
 +CapsLock::       Send {Backspace down}                                        ;[NKR] Backspace
 CapsLock::        Send {Delete}                                                ;[NKR] Delete 
 !CapsLock::       CapsLock                                                     ;[NKR] Toggle capslock

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

 PrintScreen & j::                                                              ;[MF] scroll wheel down
 #j::                            Click, WheelDown 3                             ;[MF] scroll wheel down
 PrintScreen & k::                                                              ;[MF] scroll wheel up
 #k::                            Click, WheelUp 3                               ;[MF] scroll wheel up 
 PrintScreen & i::                                                              ;[MF] 1 Left click
 *#d::                                                                          ;[MF] 1 Left click 
 *#i::                           click                                          ;[MF] 1 Left click 
 #f::                            MouseClicks(2)                                 ;[MF] 2 Left clicks
 ^#f::                           MouseClicks(3)                                 ;[MF] 3 Left clicks (select line)
 PrintScreen & o::                                                              ;[MF] mouse middle click
 #o::                            Click, middle                                  ;[MF] mouse middle click 
 PrintScreen & sc028::                                                          ;[MF] mouse Right click
 #sc028::                        Click, Right                                   ;[MF] mouse Right click
 ~lwin & rshift::                                                               ;[MF] move mouse cursor to middle
 PrintScreen & rctrl::           JumpMiddle()                                   ;[MF] move mouse cursor to middle
 +#k::                           JumpTopEdge()                                  ;[MF] move mouse cursor to top edge
 +#j::                           JumpBottomEdge()                               ;[MF] move mouse cursor to bottom edge 
 +#h::                           JumpLeftEdge()                                 ;[MF] move mouse cursor to Left edge
 +#l::                           JumpRightEdge()                                ;[MF] move mouse cursor to Right edge

 +#n::                                                                          ;[MF] move mouse cursor to bottom left corner and left click 
    JumpBottomEdge()  
    JumpLeftEdge()    
    click
    return
 