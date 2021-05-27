; FORMAT CODE __________________________________________________________________
 WinTextNav_Autoexecution:
 
  c := ";"
  h := "40" 
  f := "80"
 
 return                                                                         
 
 #If WinActive("ahk_exe Code.exe") and TabCondition(".notes")
  PrintScreen & 1::        AddBorder(f, "_"  , "")                              ;[FC] Add lvl 1 Border .notes files 
  PrintScreen & 2::        AddBorder(f, "-- ", "#")                             ;[FC] Add lvl 2 Border .notes files
  PrintScreen & 3::        AddBorder(f, "... " , "##")                          ;[FC] Add lvl 3 Border .notes files

 #If WinActive("ahk_exe Chrome.exe") and TabCondition("Jupyter Notebook")        
  PrintScreen & capslock:: AddSpaceBeforeComment("50")                          ;[FC] Add Space Before Comment .ipynb files               
  PrintScreen & tab::      AddSpaceBeforeComment(h)                             ;[FC] Add Space Before Comment .ipynb files
  PrintScreen & 1::        AddBorder(h, "_"  , c)                               ;[FC] Add lvl 1 Border .ipynb files
  PrintScreen & 2::        AddBorder(h, "-- ", c)                               ;[FC] Add lvl 2 Border .ipynb files
  PrintScreen & 3::        AddBorder(h, "... " , c)                             ;[FC] Add lvl 3 Border .ipynb files


 #If WinActive("ahk_exe Code.exe") or WinActive("ahk_exe notepad++.exe")
  PrintScreen & tab::      AddSpaceBeforeComment(f)                             ;[FC] Add Space Before Comment (default)                       
  PrintScreen & 1::        AddBorder(f, "_"  , c)                               ;[FC] Add lvl 1 Border (default)                        
  PrintScreen & 2::        AddBorder(f, "-- ", c)                               ;[FC] Add lvl 2 Border (default)                         
  PrintScreen & 3::        AddBorder(f, "... " , c)                             ;[FC] Add lvl 3 Border (default)
  
  #If WinActive("ahk_exe Code.exe") or WinActive("ahk_exe notepad++.exe") or
 (WinActive("ahk_exe Chrome.exe") and TabCondition("Jupyter Notebook"))
  del & ins::                                                                   ;[FC] format code by adding spaces between math operators, before commas, ... (selected text)
  :X:c<::                  FormatCode()                                         ;[FC] format code add spaces between math operators, before commas, ... (any text to the Left of c<)
  <+^Backspace::           Send {BackSpace 4}                                   ;[FC] Send {BackSpace 4}
  <+^Space::               Send {Space 4}                                       ;[FC] Send {Space 4}   
 
 

 ins & c::                                                                      ;[FC] convert selected snake_case or space delimited text to CamelCase
    ReplaceUnderscoreWithSpace()                                                
    EveryFirstLetterCapitalized()                                               
    RemoveAllSpaces()                                                           
    return
 
 del & c::                                                                      ;[FC] convert selected CamelCase text to snake_case
    AddSpaceBtnCaseChange()
    ReplaceSpaceWithUnderscore()
    return

 $+^q:: send {shift down}{home}{shift up}{Left}{sc027}{space}{end}              ;[FC] comment line while preserving leading whitespace         
    
 #IfWinActive 
 
; TEXT MANIPULATION ____________________________________________________________
 !Backspace::  Send {Backspace}{End}{Shift Down}{Up}{End}{Shift Up}{Backspace}  ;[TM] edit: Delete line with backspace from end of line
 ^Capslock::   Send {del}{home}{shift down}{down}{shift up}{del}                ;[TM] edit: Delete line
 +^u::         ConvertUpper()                                                   ;[TM] case: capitalize selected text
 +!u::         ConvertLower()                                                   ;[TM] case: convert selected text to lower case
 ^!u::         FirstLetterCapitalized()                                         ;[TM] case: every FirstLetterCapitalized
 ^!+u::        EveryFirstLetterCapitalized()                                    ;[TM] case: convert selected text
 #^x::                                                                          ;[TM] cut and trim whitespace around selected text
 #x::          TrimText(True)                                                   ;[TM] cut and trim whitespace around selected text
 #^c::                                                                          ;[TM] cut and trim whitespace around selected text
 #c::          TrimText()                                                       ;[TM] cut and trim whitespace around selected text
 ^!v::         FormatTranscript()                                               ;[TM] remove time index from selected text
 !#enter::     RemoveBlankLines()                                               ;[TM] remove empty lines from selected text
 del & s::     RemoveAllSpaces()                                                ;[TM] remove all spaces from selected text
 !v::          PasteWithoutBreaks()                                             ;[TM] replace multiple paragraph breaks in selected text
 +!v::         PasteWithoutBreaks(True)                                         ;[TM] replace multiple paragraph breaks, reselect text = True
 #!sc00C::     ReplaceUnderscoreWithSpace()                                     ;[TM] replace "_" with " " in selected text
 ^#sc00C::     ReplaceSpaceWithUnderscore()                                     ;[TM] replace " " with "_" in selected text
 ^#backspace::                                                                  ;[TM] replace "+" or "," with " " in selected text
     var := clip()       
     var := StrReplace(var, ",", A_Space)
     var := StrReplace(var, "+", A_Space)
     var := RegExReplace(var, "S) +", A_Space)                                  
     clip(var, True)
     return

 del & space::                                                                  ;[TM] replace multiple consecutive spaces w/ one in selected text
     var := clip()
     var := RegExReplace(var, "S) +", A_space) 
     clip(var)
     return  

 #!SC034::                                                                      ;[TM] replace "." with " " in selected text
     var := clip()
     var := StrReplace(var, "."," ")
     clip(var, True)
     return

 del & sc00D::                                                                  ;[TM] replace "=" with " " in selected text
     var := clip()
     var := StrReplace(var, "="," ")
     clip(var)
     return

 End & sc00C::                                                                  ;[TM] replace "=" with "_" in selected text
     var := clip()
     var := StrReplace(var, "=","_")
     clip(var)
     return
 
 #!sc028::                                                                      ;[TM] replace """ with " " in selected text
     var := clip()
     var := StrReplace(var, """","")
     clip(var, True)
     return  

 End & sc02b::                                                                  ;[TM] replace "," with "", "" in selected text
 ^#sc028:: addQuotesAroundCommaSeparatedElements()                              ;[TM] replace "," with "", "" in selected text

 ins & SC00D::                                                                  ;[TM] replace " " with "+" in selected text
 ^#SC00D::                                                                      ;[TM] replace " " with "+" in selected text
     var := clip()
     var := RegExReplace(var, "S) +", A_Space)                                  
     var := RegExReplace(var, A_Space, " + ") 
     clip(var)
     return
     
 ins & sc00C::                                                                  ;[TM] replace " " with "+" in selected text
     var := clip()
     var := RegExReplace(var, "S) +", A_Space)                                  
     var := RegExReplace(var, A_Space, " + ") 
     clip(var)
     return
 ins & SC033::                                                                  ;[TM] replace " " with "," in selected text
 ^#SC033::                                                                      ;[TM] replace " " with "," in selected text
     var := clip()
     var := RegExReplace(var, "S) +", A_Space)                                 
     var := RegExReplace(var, A_Space, ", ") 
     clip(var, True)
     return
 End & SC00D::                                                                  ;[TM] replace "," with "+" in selected text
 #!SC00D::                                                                      ;[TM] replace "," with "+" in selected text
     var := clip()
     var := StrReplace(var, A_Space,"")                                          
     var := StrReplace(var, ",", " + ")
     clip(var, True)
     return
 End & SC033::                                                                  ;[TM] replace "+" with "," in selected text
 #!SC033::                                                                      ;[TM] replace "+" with "," in selected text
    var := clip()       
    var := StrReplace(var, A_Space,"")
    var := StrReplace(var, "+", ", ")
    clip(var, True)
    return


 
 ins & SC02B::                                                                  ;[TM] replace " " with "|" in selected text 
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
 ^+!l::                                                                         ;[TS] select to end of line
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
 +^sc027::  Send {shift down}{Right}{shift up}                                  ;[TS] extend selection Right one space
 +^h::      Send {shift down}{ctrl down}{Left}{shift up}{ctrl up}               ;[TS] extend selection Left one word
 +^b::      Send {shift down}{Left}{ctrl up}                                    ;[TS] extend selection Left one space
 +^j::                                                                          ;[TS] select to next line
 +^!j::     Send {shift down}{down}{shift up}                                   ;[TS] select to next line
 +^k::                                                                          ;[TS] select to line above
 +^!k::     Send {shift down}{up}{shift up}                                     ;[TS] select to line above
 +^!h::     Send {shift down}{home}{shift up}                                   ;[TS] select to beg of current line

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
 ins & enter::     send {Insert}                                                ;[NKR] insert key
 del & BackSpace:: send {del}                                                   ;[NKR] del key
 
 lwin::            return                                                       ;[NKR] modifier key, use ctrl+esc to access start menu 
 Insert::          return                                                       ;[NKR] modifier key no action otherwise
 home::            return                                                       ;[NKR] modifier key no action otherwise
 end::             return                                                       ;[NKR] modifier key no action otherwise
 del::             return                                                       ;[NKR] modifier key no action otherwise
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
 :?*:;;::{{}                                                                    ;[TB] open curly braces
 :?*:;'::{}}                                                                    ;[TB] close curly braces

; CONVENIENCE __________________________________________________________________
 
 :*:r>::return                                                                  ;[C] return 
 :*:date*::                                                                     ;[C] current date
     FormatTime, CurrentDateTime,, MMMM dd, yyyy
     clip(CurrentDateTime)
     return 
 
 +!sc00C::     Send, {ASC 0150}                                                 ;[C] en dash (–)
 !sc00C::      Send, {ASC 0151}                                                 ;[C] em dash (—)
 
; TABS _________________________________________________________________________
 ; system wide shortcut for changing tabs
 !b:: send ^{PgUp}                                                              ;[T] move to right tab
 >!space::                                                                      ;[T] move to left tab
 <!space::                                                                      ;[T] move to left tab
    keywait space 
    send ^{PgDn}                                                                
    return
 

; MOUSE FUNCTIONS ______________________________________________________________
 ; simulate mouse functions with keyboard shortcuts

 PrintScreen & j::                                                              ;[MF] scroll wheel down
 #j:: Click, WheelDown 4                                                        ;[MF] scroll wheel down
 PrintScreen & k::                                                              ;[MF] scroll wheel up
 #k:: Click, WheelUp 4                                                          ;[MF] scroll wheel up 
 PrintScreen & i::                                                              ;[MF] 1 Left click
 ; *#d::                                                                        ;[MF] 1 Left click
 *#i:: click                                                                    ;[MF] 1 Left click 

 #f::                                                                           ;[MF] 2 Left clicks
    Click
    sleep, short
    Click
    return
 
 ^#f::                                                                          ;[MF] 3 Left clicks
    Click
    sleep, short
    Click
    sleep, short
    Click
    return

  PrintScreen & o::                                                             ;[MF] mouse middle click
  #o::                            Click, middle                                 ;[MF] mouse middle click
  
  PrintScreen & sc028::                                                         ;[MF] mouse Right click
  #sc028::                        Click, Right                                  ;[MF] mouse Right click
  
  #u::                                                                          ;[MF] move mouse cursor to top edge
  !#k::                           JumpTopEdge()                                 ;[MF] move mouse cursor to top edge
  
  !#j::                                                                         ;[MF] move mouse cursor to bottom edge
  #If GetKeyState("shift", "P")
  PrintScreen & j::               JumpBottomEdge()                              ;[MF] move mouse cursor to bottom edge
  #IF
  
  !#h::                                                                         ;[MF] move mouse cursor to Left edge
  #If GetKeyState("alt", "P")
  PrintScreen & h::               JumpLeftEdge()                                ;[MF] move mouse cursor to Left edge
  #IF

  !#l::                                                                         ;[MF] move mouse cursor to Right edge
  #If GetKeyState("alt", "P")
  PrintScreen & l::               JumpRightEdge()                               ;[MF] move mouse cursor to Right edge
  #IF
  
  LAlt & RAlt::                                                                 ;[MF] move mouse cursor to middle
  PrintScreen & rctrl::           JumpMiddle()                                  ;[MF] move mouse cursor to middle
