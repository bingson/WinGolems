; MANIPULATE TEXT ______________________________________________________________
  #IfWinActive 
  !Backspace::  Send {Backspace}{End}{shift down}{Up}{End}{shift up}{Backspace} ;[TM] edit: Delete line with backspace starting from end of line
  ^#Backspace:: ReplaceBackspaceWithSpaces()                                    ;[TM] edit: Delete selected text and replace with blank spaces 
  
  #x::          TrimText(True)                                                  ;[TM] cut and trim whitespace around selected text
  #c::          TrimText()                                                      ;[TM] copy and trim whitespace around selected text
  :X:ft~win::   FormatTranscript()                                              ;[TM] remove time index starting from selected transcript
  !#enter::     RemoveBlankLines()                                              ;[TM] remove empty lines starting from selected text
  ^#v::         PasteOverwrite()                                                ;[TM] paste, then delete same number of spaces (aka. overtype paste)
  !v::          PasteWithoutBreaks()                                            ;[TM] replace multiple paragraph breaks w/ 1 break in selected text
  +!v::         PasteWithoutBreaks(True)                                        ;[TM] replace multiple paragraph breaks with space (remove paragraphs breaks)
  ^#sc028::     addQuotesAroundCommaSeparatedElements()                         ;[TM] surround each element of comma separated list with quotation marks
  #!sc028::     ReplaceAwithB("""")                                             ;[TM] replace " " (double quotation marks) with spaces in selected text
  !#space::     ReplaceAwithB(" ")                                              ;[TM] remove all spaces starting from selected text
  ^#space::     ReplaceAwithB()                                                 ;[TM] replace multiple consecutive spaces w/  1 in selected text
  #!sc00C::     ReplaceAwithB("_", " ")                                         ;[TM] replace "_" with " " in selected text
  ^#sc00C::     ReplaceAwithB(" ", "_")                                         ;[TM] replace " " with "_" in selected text
  #!SC034::     ReplaceAwithB(".", " ")                                         ;[TM] replace "." with " " in selected text;
  ^#SC00D::     ReplaceAwithB(" ", "+")                                         ;[TM] replace " " with "+" in selected text;
  ^#SC033::     ReplaceAwithB(" ", ",")                                         ;[TM] replace " " with "," in selected text;
  #!SC00D::     ReplaceAwithB(",", "+")                                         ;[TM] replace "," with "+" in selected text;
  #!SC033::     ReplaceAwithB("+", ",")                                         ;[TM] replace "+" with "," in selected text;

  ; CHANGE CASE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

  +^u::         ConvertUpper()                                                  ;[TM] case: capitalize selected text
  +!u::         ConvertLower()                                                  ;[TM] case: convert selected text to lower case
  ^!u::         Capitalize1stLetter()                                           ;[TM] case: First letter capitalized
  ^!+u::        Capitalize1stLetter(,,0)                                        ;[TM] case: Every First Letter Capitalized

  ; BRACKETS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

  +!9::                                                                         ;[TB] enclose selected text with ( )
  !9::               Clip("(" Clip() ")")                                       ;[TB] enclose selected text with ( )
  $+!SC01A::         Clip("{" Clip() "}")                                       ;[TB] enclose selected text with { }
  !SC01A::           Clip("[" Clip() "]")                                       ;[TB] enclose selected text with [ ]
  ^SC028::           Clip("'" Clip() "'")                                       ;[TB] enclose selected text with ' '
  +!SC028::          Clip("""" Clip() """")                                     ;[TB] enclose selected text with " "
  !5::
  <+>!n::            Clip("%" Clip() "%")                                       ;[TB] enclose selected text with % %
  !4::
  <+>!m::            Clip("$" Clip() "$")                                       ;[TB] enclose selected text with $ $
  !sc029::           Clip("`` " Clip() " ``")                                   ;[TB] enclose selected text with $ $
  +!sc029::          Clip("`````` " Clip() " ``````")                           ;[TB] enclose selected text with $ $
  +!sc027::          send {{}                                                   ;[TB] open curly braces
  ^!sc027::          send {}}                                                   ;[TB] close curly braces

; SELECT TEXT __________________________________________________________________

  $!f::       SelectWord()                                                      ;[ST] select word at text cursor
  $+!f::      SelectLine()                                                      ;[ST] select current line starting from begining of line
  $^!f::      Sendinput {end}+{home}                                            ;[ST] select line starting from end of line
  
  $^#Left::                                                                     ;[ST] select to beginning of line 
  $^#h::      sendinput +{Home}                                                 ;[ST] select to beginning of line
  $^#Right::                                                                    ;[ST] select to end of line
  $^#l::      sendinput +{End}                                                  ;[ST] select to end of line
  $+^j::                                                                        ;[ST] select to next line
  $<+<#j::    Sendinput +{down}                                                 ;[ST] select to next line
  $+^k::                                                                        ;[ST] select to line above
  $<+<#k::    Sendinput +{up}                                                   ;[ST] select to line above
 
  $^#j::      sendinput ^+{end}                                                 ;[ST] select all below
  $^#k::      sendinput ^+{home}                                                ;[ST] select all above
  
  
  $+#h::      Sendinput +^{Left}                                                ;[ST] extend selection Left  1 word
  $+#l::      Sendinput +^{Right}                                               ;[ST] extend selection Right 1 word
  
  #If GetKeyState("shift", "P")
  PrintScreen & h::      Sendinput +^{Left 2}                                   ;[ST] extend selection Left  1 word
  PrintScreen & l::      Sendinput +^{Right 2}                                  ;[ST] extend selection Right 1 word
  #If 
 
  +^h::       Sendinput {shift down}{ctrl down}{left 2}{ctrl up}{shift up}      ;[ST] extend selection left 2 words
  +^l::       Sendinput {shift down}{ctrl down}{Right 2}{ctrl up}{shift up}     ;[ST] extend selection Right 2 words
  
  $+!l::      Sendinput +{Right}                                                ;[ST] extend selection Right 1 character
  $+!h::      Sendinput +{Left}                                                 ;[ST] extend selection Left  1 character
  +!j::       sendinput +{down}                                                 ;[ST] extend selection down  1 row
  +!k::       sendinput +{up}                                                   ;[ST] extend selection up    1 row
  $+^!l::     Sendinput +{Right 4}                                              ;[ST] extend selection Right 4 character lengths
  $+^!h::     Sendinput +{Left 4}                                               ;[ST] extend selection Left  4 character lengths
 

; NAVIGATE TEXT ________________________________________________________________
 
  $#h::             sendinput ^{Left}                                           ;[NT] jump to next word = simulate ctrl+Left
  $#l::             sendinput ^{Right}                                          ;[NT] jump to next word = simulate ctrl+Right
  PrintScreen & h:: sendinput ^{Left 4}
  PrintScreen & l:: sendinput ^{Right 4}
 
 
  home::home 
  
  !^Left::                                                                      ;[NT] Home
  ^!h::             sendinput {home}                                            ;[NT] Home
  
  !^Right::                                                                     ;[NT] End
  ^!l::             sendinput {end}                                             ;[NT] End
 
  $!h::             sendinput {Left}                                            ;[NT] Left
  $!l::             sendinput {Right}                                           ;[NT] Right
  *$!k::            sendinput {Up}                                              ;[NT] Up
  *$!j::            sendinput {Down}                                            ;[NT] Down
 
  #p::
  printscreen & p::
  #e::              sendinput ^{home}                                           ;[NT] Ctrl + Home
  
  #sc01a::
  PrintScreen & sc01a::                                                         ;[NT] Ctrl + End
  +#e::             sendinput ^{end}                                            ;[NT] Ctrl + End
 
; CONVENIENCE __________________________________________________________________
 
  #F1::  Send #1                                                                ; activate first app in task bar 
  #F2::  Send #2                                                                 
  #F3::  Send #3                                                                 
  #F4::  Send #4
  #F5::  Send #5
  #F6::  Send #6
  #F7::  Send #7
  #F8::  Send #8
  #F9::  Send #9
  #F10:: Send #0
  
  ^SC027::          Send {AppsKey}                                              ;[C] appkey press
  ^m::              Send ^c                                                     ;[C] Right-handed copy (ctrl-c)
  $!SC027::         Send {esc}                                                  ;[C] esc key
  +CapsLock::       Send {Backspace down}                                       ;[C] Backspace
  $CapsLock::       Send {Delete}                                               ;[C] Delete 
  ^CapsLock::       CapsLock                                                    ;[C] Toggle capslock
 
  
  *LWin::       Send {Blind}{LWin Down}                                         ;[C] makes left windows key a modifier key for AHK keyboard shorcuts (use ^#enter or lwin + left mouse click to access start menu)
  LWin Up::    Send {Blind}{vk00}{LWin Up}                                      ;[C] makes left windows key a modifier key for AHK keyboard shorcuts (use ^#enter or lwin + left mouse click to access start menu)
                                                                                ; https://autohotkey.com/board/topic/29443-disable-opening-the-start-menu/

  PrintScreen::     return                                                      ;[C] modifier key no action otherwise
 
  !b:: send ^{PgUp}                                                             ;[C] navigate to right tab
  !space::                                                                      ;[C] navigate to left tab
    send {Blind}
    send ^{PgDn}                                                                
    return
 
  :*:date*::                                                                    ;[C] current date
    FormatTime, CurrentDateTime,, MMMM dd, yyyy
    clip(CurrentDateTime)
    return 

  +!sc00C::     Send, {ASC 0150}                                                ;[C] en dash (–)
  !sc00C::      Send, {ASC 0151}                                                ;[C] em dash (—)
 
  
  ; $#LButton::  PasteClipboardAtMouseCursor()                                  ;[C] double click, trim(clipboard), paste 
 
; MOUSE (CURSOR) FUNCTIONS _____________________________________________________
 ; mouse functions with keyboard shortcuts  

  ^!Lbutton::                                                                   ;[MF] click twice, paste clipboard
    Clicks(2)
    send ^v
    return

  +^Lbutton::                                                                   ;[MF] click thrice, paste clipboard
    Clicks(3)
    send ^v
    return
  
   $^!j::                         Sendinput ^{sc00D}                            ;[MF] zoom in
   $^!k::                         Sendinput ^{sc00C}                            ;[MF] zoom out
  
  *$#j::                          Sendinput {WheelDown 2}                       ;[MF] scroll wheel down
  *$#k::                          Sendinput {WheelUp 2}                         ;[MF] scroll wheel Up
 
  printscreen & j::               Sendinput {WheelDown 5}                       ;[MF] scroll wheel down                                               
  printscreen & k::               Sendinput {WheelUp 5}                         ;[MF] scroll wheel Up                                               
 
  $<^>!h::                        Sendinput {Wheelleft 6}                       ;[MF] scroll wheel down
  $<^>!j::                        Sendinput {WheelDown 6}                       ;[MF] scroll wheel down
  $<^>!k::                        Sendinput {WheelUp 6}                         ;[MF] scroll wheel up
  $<^>!l::                        Sendinput {WheelRight 6}                      ;[MF] scroll wheel up
 
  PrintScreen & i::                                                             ;[MF] Left click and save mouse position
  *#i::                           SaveMousPos("A",1)                            ;[MF] Left click and save mouse position
  *#d::                           SaveMousPos("B",1)                            ;[MF] Left click and save mouse position
  *^#i::                          RecallMousePosClick("A")                      ;[MF] Move to saved mouse position and left click
  *^#d::                          RecallMousePosClick("B")                      ;[MF] Move to saved mouse position and left click
 
  #f::                            Clicks(2)                                     ;[MF] 2 Left clicks (select word)
  ^#f::                           Clicks(3)                                     ;[MF] 3 Left clicks (select line)
  PrintScreen & o::                                                             ;[MF] mouse middle click
  #o::                            Click, middle                                 ;[MF] mouse middle click 
  PrintScreen & sc028::                                                         ;[MF] mouse Right click
  #sc028::                        Click, Right                                  ;[MF] mouse Right click
  
  #If GetKeyState("lctrl", "P") 
     lalt & rshift::                                                            ;[MF] (+lctrl) move mouse cursor to center
  #If
  ~lwin & ~rshift::               CursorJump("C")                               ;[MF] move mouse cursor to center
  
  ~rctrl & ~lctrl::               CursorJump("TL")                              ;[MF] move mouse cursor to TOP    LEFT   of active app
  ~lctrl & ~rctrl::               CursorJump("TR")                              ;[MF] move mouse cursor to TOP    RIGHT  of active app
  ralt & lalt::                   CursorJump("BL")                              ;[MF] move mouse cursor to BOTTOM LEFT   of active app
  lalt & ralt::                   CursorJump("BR")                              ;[MF] move mouse cursor to BOTTOM RIGHT  of active app
 
  #If GetKeyState("ralt", "P")
  PrintScreen & k::               CursorJump("T")                               ;[MF] move mouse cursor to top edge
  PrintScreen & j::               CursorJump("B",,"-20")                        ;[MF] move mouse cursor to bottom edge 
  PrintScreen & h::               CursorJump("L","20")                          ;[MF] move mouse cursor to Left edge
  PrintScreen & l::               CursorJump("R","-40")                         ;[MF] move mouse cursor to Right edge
  #If
 
  $!#k::                          CursorJump("T")                               ;[MF] move mouse cursor to top edge
  $!#j::                          CursorJump("B",,"-20")                        ;[MF] move mouse cursor to bottom edge 
  $!#h::                          CursorJump("L","20")                          ;[MF] move mouse cursor to Left edge
  $!#l::                          CursorJump("R","-40")                         ;[MF] move mouse cursor to Right edge
 

 
 