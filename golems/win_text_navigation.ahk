 #IfWinActive 
 
; TEXT MANIPULATION ____________________________________________________________
 !Backspace::  Send {Backspace}{End}{Shift Down}{Up}{End}{Shift Up}{Backspace}  ;[TM] edit: Delete line with backspace from end of line
 ^#Backspace::  replaceDeletedCharWithSpaces() 
 ^Capslock::   Send {del}{home}{shift down}{down}{shift up}{del}                ;[TM] edit: Delete line
 +^u::         ConvertUpper()                                                   ;[TM] case: capitalize selected text
 +!u::         ConvertLower()                                                   ;[TM] case: convert selected text to lower case
 ^!u::         FirstLetterCapitalized()                                         ;[TM] case: every FirstLetterCapitalized
 ^!+u::        EveryFirstLetterCapitalized()                                    ;[TM] case: convert selected text
 #x::          TrimText(True)                                                   ;[TM] cut and trim whitespace around selected text
 #c::          TrimText()                                                       ;[TM] cut and trim whitespace around selected text
 ^!v::         FormatTranscript()                                               ;[TM] remove time index from selected text
 !#enter::     RemoveBlankLines()                                               ;[TM] remove empty lines from selected text
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
 F1 & space::  ReplaceEqualWithSpace()                                          ;[TM] replace "=" with " " in selected text
 F1 & sc00C::                                                                   ;[TM] replace "=" with "_" in selected text
     var := clip()
     var := StrReplace(var, "=","_")
     clip(var)
     return
 
 
 ^#SC00D::                                                                      ;[TM] replace " " with "+" in selected text
     var := clip()
     var := RegExReplace(var, "S) +", A_Space)                                  
     var := RegExReplace(var, A_Space, " + ") 
     clip(var)
     return
 
 ^#SC033::                                                                      ;[TM] replace " " with "," in selected text
     var := clip()
     var := RegExReplace(var, "S) +", A_Space)                                 
     var := RegExReplace(var, A_Space, ", ") 
     clip(var, True)
     return
 #!SC00D::                                                                      ;[TM] replace "," with "+" in selected text
     var := clip()
     var := StrReplace(var, A_Space,"")                                          
     var := StrReplace(var, ",", " + ")
     clip(var, True)
     return

     
 #!SC033::                                                                      ;[TM] replace "+" with "," in selected text
    var := clip()       
    var := StrReplace(var, A_Space,"")
    var := StrReplace(var, "+", ", ")
    clip(var, True)
    return


 
 F1 & SC02B::                                                                   ;[TM] replace " " with "|" in selected text
     var := clip()
     var := RegExReplace(var, "S) +", A_Space) 
     var := RegExReplace(var, A_Space, "|") 
     clip(var, True)
     return 
  

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
 !f::       SelectWord()                                                        ;[TS] select word at cursor
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
 #d:: send {ctrl down}{end}{ctrl up}                                            ;[NKR] Ctrl + End
 
 ^SC027::          Send {AppsKey}                                               ;[NKR] appkey press
 ^m::              Send ^c                                                      ;[NKR] Right-handed copy (ctrl-c)
 $!SC027::                                                                      ;[NKR] esc key
 $!<space::        Send {esc}                                                   ;[NKR] esc key
 +CapsLock::       Send {Backspace down}                                        ;[NKR] Backspace
 CapsLock::        Send {Delete}                                                ;[NKR] Delete 
 !CapsLock::       CapsLock                                                     ;[NKR] Toggle capslock
 
 #f1::      send {f1}                                                           ;[NKR] f1          
 #f2::      send {f2}                                                           ;[NKR] f2        
 #f3::      send {f3}                                                           ;[NKR] f3        
 #f4::      send {f4}                                                           ;[NKR] f4        
 #f5::      send {f5}                                                           ;[NKR] f5        
 #f6::      send {f6}                                                           ;[NKR] f6        
 #f7::      send {f7}                                                           ;[NKR] f7        
 #f8::      send {f8}                                                           ;[NKR] f8        
 #f9::      send {f9}                                                           ;[NKR] f9        
 #f10::     send {f10}                                                          ;[NKR] f10          
 #f11::     send {f11}                                                          ;[NKR] f11          
 #f12::     send {f12}                                                          ;[NKR] f12          
 
;  f1::       return                                                              ;[NKR] modifier key no action otherwise
;  f2::       return                                                              ;[NKR] modifier key no action otherwise
;  f3::       return                                                              ;[NKR] modifier key no action otherwise
;  f4::       return                                                              ;[NKR] modifier key no action otherwise
;  f5::       return                                                              ;[NKR] modifier key no action otherwise
;  f6::       return                                                              ;[NKR] modifier key no action otherwise
;  f7::       return                                                              ;[NKR] modifier key no action otherwise
;  f8::       return                                                              ;[NKR] modifier key no action otherwise
;  f9::       return                                                              ;[NKR] modifier key no action otherwise
;  f10::      return                                                              ;[NKR] modifier key no action otherwise
;  f11::      return                                                              ;[NKR] modifier key no action otherwise
;  f12::      return                                                              ;[NKR] modifier key no action otherwise                                                              

 lwin::            return                                                       ;[NKR] modifier key, use ctrl+esc to access start menu 
 home::            return                                                       ;[NKR] modifier key no action otherwise
 end::             return                                                       ;[NKR] modifier key no action otherwise
 PrintScreen::     return                                                       ;[NKR] modifier key no action otherwise
 RemoveToolTip:
 ToolTip
 return

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
 
 :*:r>::return                                                                  ;[C] return 
 :*:date*::                                                                     ;[C] current date
     FormatTime, CurrentDateTime,, MMMM dd, yyyy
     clip(CurrentDateTime)
     return 
 
 +!sc00C::     Send, {ASC 0150}                                                 ;[C] en dash (–)
 !sc00C::      Send, {ASC 0151}                                                 ;[C] em dash (—)

 
 $^!LButton::                                                                   ;[C] double click, trim(clipboard), paste 
    ReleaseModifiers()
    DoubleClick()
    sleep, short * 2
    var := Clipboard
    var := trim(var, "`r`n`t")
    Clipboard := var
    sleep, short
    send ^v
    return
 
; TABS _________________________________________________________________________
 ; system wide shortcut for changing tabs
 !b:: send ^{PgUp}                                                              ;[T] move to right tab
 >!space::                                                                      ;[T] move to left tab
 <!space::                                                                      ;[T] move to left tab
    keywait space 
    send ^{PgDn}                                                                
    return
 


