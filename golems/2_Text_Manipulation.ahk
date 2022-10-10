; CONVENIENCE/TEXT MANIPULATION ________________________________________________
  <!capslock::      Sendinput {del}                                             ;TEXT MANIPULATION: del 
  lalt & capslock:: Sendinput {del}                                             ;TEXT MANIPULATION: del                                                                                           
  >!capslock::      Sendinput {del 5}                                           ;TEXT MANIPULATION: del 5 spaces                                                                                              
  <+^del::          Sendinput {del 5}                                           ;TEXT MANIPULATION: del 5 spaces                                                                                              
  <!Backspace::     delLine()                                                   ;TEXT MANIPULATION: delete current line of text
  ^#Backspace::     ReplaceBackspaceWithSpaces()                                ;TEXT MANIPULATION: Delete and replace selected text with blank spaces
  #backspace::      Send ^{backspace}                                           ;TEXT MANIPULATION: ^backspace (delete word from last character)
  <+^Backspace::    Sendinput {BackSpace 5}                                     ;TEXT MANIPULATION: Send {BackSpace 5}
  <+^Space::        FillChar(5, " ", 0)                                         ;TEXT MANIPULATION: Send {Space 5}     
  !v::              PasteWithoutBreaks()                                        ;TEXT MANIPULATION| replace multiple paragraph breaks w/ 1 break in selected text
  +!v::             PasteWithoutBreaks(True)                                    ;TEXT MANIPULATION| replace multiple paragraph breaks with space (remove paragraphs breaks)
  ^#v::             PasteOverwrite()                                            ;TEXT MANIPULATION| Paste and overwrite the same number of spaces (aka. overtype paste)
  +^u::             w("ls","lc"),ConvertUpper()                                 ;TEXT MANIPULATION* capitalize selected text
  +!u::             w("ls","la"),ConvertLower()                                 ;TEXT MANIPULATION* make selected text to lower case
  ^!u::             w("la","lc"),Capitalize1stLetter()                          ;TEXT MANIPULATION^ First Letter Capitalized
  ^!+u::            w("ls","lc","la"),Capitalize1stLetter(,,0)                  ;TEXT MANIPULATION^ Every First Letter Capitalized
  !#s::             ReplaceAwithB(" ")                                          ;TEXT MANIPULATION! remove all spaces from selected text
  !#enter::         RemoveBlankLines()                                          ;TEXT MANIPULATION! remove empty lines starting from selected text
  +!9::             Clip("(" Clip() ")")                                        ;TEXT MANIPULATION: enclose selected text with ( )
  $+!SC01A::        Clip("{" Clip() "}")                                        ;TEXT MANIPULATION: enclose selected text with { }
  !SC01A::          Clip("[" Clip() "]")                                        ;TEXT MANIPULATION: enclose selected text with [ ]
  +^SC028::         Clip("'" Clip() "'")                                        ;TEXT MANIPULATION: enclose selected text with ' '
  +!SC028::         Clip("""" Clip() """")                                      ;TEXT MANIPULATION: enclose selected text with " "
  <!>+5::                                                                       ;TEXT MANIPULATION: enclose selected text with % %
  >!<+5::           Clip("%" Clip() "%")                                        ;TEXT MANIPULATION: enclose selected text with % %
  <!>+4::                                                                       ;TEXT MANIPULATION: enclose selected text with $ $
  >!<+4::           Clip("$" Clip() "$")                                        ;TEXT MANIPULATION: enclose selected text with $ $
  !sc029::          Clip("``" Clip() "``")                                      ;TEXT MANIPULATION: enclose selected text with ` `
  +!sc029::         Clip("`````` " Clip() " ``````")                            ;TEXT MANIPULATION: enclose selected text with ``` ```
  #!sc028::         s("{blind}"), ReplaceAwithB("""", "")                       ;TEXT MANIPULATION remove double quotes from selected text
  #!sc00C::         s("{blind}"), ReplaceAwithB("-", " ")                       ;TEXT MANIPULATION replace "-" with " " in selected text
  ^#sc00C::         s("{blind}"), ReplaceAwithB(" ", "-")                       ;TEXT MANIPULATION replace " " with "_" in selected text
  #!SC034::         s("{blind}"), ReplaceAwithB(".", " ")                       ;TEXT MANIPULATION replace "." with " " in selected text
  ^#SC034::         s("{blind}"), ReplaceAwithB(" ", ".")                       ;TEXT MANIPULATION replace "." with " " in selected text
  ^#SC00D::         s("{blind}"), ReplaceAwithB(" ", "+")                       ;TEXT MANIPULATION replace " " with "+" in selected text
  #!sc033::         s("{blind}"), ReplaceAwithB(",", " ")                       ;TEXT MANIPULATION replace "_" with " " in selected text
  ^#SC033::         s("{blind}"), ReplaceAwithB(" ", ",")                       ;TEXT MANIPULATION replace " " with "," in selected text
  #If GetKeyState("esc", "P")                                                   ;
  SC00D::           s("{blind}"), ReplaceAwithB(" ", "+")                       ;TEXT MANIPULATION replace " " with "+" in selected text
  +SC00D::          s("{blind}"), ReplaceAwithB(",", "+")                       ;TEXT MANIPULATION replace "," with "+" in selected text
  sc00C::           s("{blind}"), clip(CS(clip(), {"_":" "}))                   ;C.TM: replace "_" with " " Ain selected text
  +sc00C::          s("{blind}"), clip(CS(clip(), {"_":" ","-":" "}))           ;C.TM: replace "_" with " " Ain selected text
  F1 & SC033::      s("{blind}"), ReplaceAwithB("+", ",")                       ;C.TM: replace "+" with "," in selected text
  #IF IsCMODE()                                                                 ;
  lalt::            Sendinput {backspace}                                       ;TEXT MANIPULATION: backspace                                                                                               
  sc00C::           s("{blind}"), ReplaceAwithB(" ", "_")                       ;C.TM: replace " " with "_" in selected text
  >+s::             SortSelectedText()                                          ;TEXT MANIPULATION Sort Selected Text
  >+d::             SortSelectedText("R")                                       ;TEXT MANIPULATION Sort Selected Text
  backspace::       ReplaceAwithB(" ")                                          ;TEXT MANIPULATION remove all spaces               
  SC00D::           ReplaceAwithB()                                             ;TEXT MANIPULATION replaces multiple consecutive spaces with character length 1 space 

  #If !WinActive("ahk_exe Code.exe")                                            ; ignore this shortcut if vs code active            
   
  #IF             


 
; TEXT NAVIGATION  _____________________________________________________________
    #IF                                                                         
    *#h::      Sendinput ^{Left}                                                ;Navigation: jump to next word: simulate ctrl+Left
    *#l::      Sendinput ^{Right}                                               ;Navigation: jump to next word: simulate ctrl+Right (disable win+L lock w/ "lf")
    *#>!h::    Sendinput ^{Left 4}                                              ;Navigation: jump to next word: simulate ctrl+Left
    *#>!l::    Sendinput ^{Right 4}                                             ;Navigation: jump to next word: simulate ctrl+Right (disable win+L lock w/ "lf")jj
    *#>!j::    Sendinput {down 4}                                               ;Navigation: jump to next word: simulate ctrl+Left
    *#>!k::    Sendinput {up 4}                                                 ;Navigation: jump to next word: simulate cjtrl+Right (disable win+L lock w/ "lf")
    *<^>!h::   Sendinput ^{Left 4}                                              ;Navigation: jump to next word: simulate ctrl+Left
    *<^>!l::   Sendinput ^{Right 4}                                             ;Navigation: jump to next word: simulate ctrl+Right (disable win+L lock w/ "lf")
    #e::       Sendinput ^{home}                                                ;Navigation| ctrl + home
    ^!h::      Sendinput {home}                                                 ;Navigation: home
    ^!l::      Sendinput {end}                                                  ;Navigation: end
    ^!j::      Sendinput ^{end}                                                 ;Navigation: ctrl + home
    ^!k::      Sendinput ^{home}                                                ;Navigation: ctrl + end
    !l::       Sendinput {Right}                                                ;Navigation| Right
    !h::       Sendinput {Left}                                                 ;Navigation| Left
    !j::       Sendinput {down}                                                 ;Navigation| Up
    !k::       Sendinput {up}                                                   ;Navigation| Down
    #IF GetKeyState("lctrl", "P")                                               
    lalt & h:: Sendinput {home}                                                 ;Navigation: home
    lalt & l:: Sendinput {end}                                                  ;Navigation: end
    lalt & j:: Sendinput ^{end}                                                 ;Navigation: ctrl + home
    lalt & k:: Sendinput ^{home}                                                ;Navigation: ctrl + end
    #IF GetKeyState("rctrl", "P")                                               
    ralt & j:: Sendinput ^{end}                                                 ;Navigation: ctrl + home
    ralt & k:: Sendinput ^{home}                                                ;Navigation: ctrl + end
                                                                                
                                                                                
                                                                                 
  #IF IsCMODE() ; 4 char nav -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
    *l::        Sendinput {Right 5}                                             ;Navigation: extend selection Right 5 character
    *h::        Sendinput {Left 5}                                              ;Navigation: extend selection Left  5 character
    *j::        Sendinput {down 3}                                              ;Navigation: extend selection Right 5 character
    *k::        Sendinput {up 3}                                                ;Navigation: extend selection Left  5 character
    shift & l:: Sendinput {Right 30}                                            ;Selection: extend selection Right 5 characters
    shift & h:: Sendinput {Left 30}                                             ;Selection: extend selection Left  5 characters
    shift & j:: Sendinput {down 10}                                             ;Navigation: extend selection Right 2 character
    shift & k:: Sendinput {up 10}                                               ;Navigation: extend selection Left  2 character
                                                                                

; TEXT SELECTION _______________________________________________________________
  #IF  
  
  <!f::    SelectWord(),W("la")                                                 ;Selection: select word at text cursor position
  +!f::    SelectLine(),W("ls","la")                                            ;Selection: select current line starting from begining of line
  ^!f::    SendInput {end}+{home}                                               ;Selection: select line starting from end of line
                                                                                
  ^#h::    SendInput +{Home}                                                    ;Selection: select to beginning of line (press win before ctrl)
  ^#l::    SendInput +{End}                                                     ;Selection: select to end of line (press win before ctrl)
  ^#j::    SendInput +^{end}                                                    ;Selection: select all below
  ^#k::    SendInput +^{home}                                                   ;Selection: sejlect all above
                                                                                
  +#h::    SendInput +^{Left}                                                   ;Selection: extend selection Left  1 words
  +#l::    SendInput +^{Right}                                                  ;Selection: extend selection Right 1 words
                                                                                
  +#k::    SendInput +{up}                                                      ;Selection: extend selection up    1 rows
  +#j::    SendInput +{down}                                                    ;Selection: extend selection down  1 rows          
  >+#h::   SendInput +^{Left 2}                                                 ;Selection: extend selection Left  2 words
  >+#l::   SendInput +^{Right 2}                                                ;Selection: extend selection Right 2 words
  +!k::    SendInput +{up}                                                      ;Selection: extend selection up    1 rows 
  +!j::    SendInput +{down}                                                    ;Selection: extend selection down  1 rows 
                                                                                
  >+>!j::  SendInput +{down}                                                    ;Selection: extend selection down  1 rows
  >+<!k::                                                                       ;Selection: extend selection up    2 rows
  <+>!k::  SendInput +{up 2}                                                    ;Selection: extend selection up    2 rows
  >+<!j::                                                                       ;Selection: extend selection down  2 rows
  <+>!j::  SendInput +{down 2}                                                  ;Selection: extend selection down  2 rows
                                                                                
  <+>+k::  SendInput +{up 5}                                                    ;Selection: extend selection up    10 rows
  <+>+j::  SendInput +{down 5}                                                  ;Selection: extend selection down  10 rows
  +>!<!k:: SendInput +{up 10}                                                   ;Selection: extend selection up    4 rows
  +>!<!j:: SendInput +{down 10}                                                 ;Selection: extend selection down  4 rows
  <+>+!k:: SendInput +{up 20}                                                   ;Selection: extend selection up    20 rows
  <+>+!j:: SendInput +{down 20}                                                 ;Selection: extend selection down  20 rows
                                                                                
  +<!l::   SendInput +{Right}                                                   ;Selection: extend selection Right 1 characters
  +<!h::   SendInput +{Left}                                                    ;Selection: extend selection Left  1 characters
  >+<!l::                                                                       ;Selection: extend selection Right 4 characters
  <+>!l::  SendInput +{Right 5}                                                 ;Selection: extend selection Right 4 characters
  >+<!h::                                                                       ;Selection: extend selection Left  4 characters
  <+>!h::  SendInput +{Left 5}                                                  ;Selection: extend selection Left  4 characters
  <+>+l::  SendInput +{Right 10}                                                ;Selection: extend selection Right # characters
  <+>+h::  SendInput +{Left 10}                                                 ;Selection: extend selection Left  # characters
  <+>+!l:: SendInput +{Right 20}                                                ;Selection: extend selection Right # characters
  <+>+!h:: SendInput +{Left 20}                                                 ;Selection: extend selection Left  # characters
  #If GetKeyState("lctrl", "P")
  lwin & j::    SendInput +^{end}                                                    ;Selection: select all below
  lwin & k::    SendInput +^{home}                                                   ;Selection: sejlect all above

  #IF IsCMODE() 
  shift & n:: Sendinput +{pgdn}                                                 ; page dn + selection
  shift & o:: Sendinput +{pgup}                                                 ; page up + selection

; MOUSE FUNCTION _______________________________________________________________
  ; scrolling -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #IF                                                                         
    #>^j::                Sendinput {WheelDown 10}                              ;MouseFn: scroll wheel down 15 clicks
    #>^k::                Sendinput {WheelUp 10}                                ;MouseFn: scroll wheel Up 15 clicks
    printscreen & j::     Sendinput {WheelDown 4}                               ;MouseFn: scroll wheel down 15 clicks
    printscreen & k::     Sendinput {WheelUp 4}                                 ;MouseFn: scroll wheel Up 15 clicks
    lwin & k::            Sendinput {blind}{WheelUp 2}                          ;MouseFn: mouse scroll down 6 lines
    lwin & j::            Sendinput {blind}{WheelDown 2}                        ;MouseFn: mouse scroll down 6 lines
                                                                                
    #If GetKeyState("rshift", "P")                                              
    lwin & k::            Sendinput {blind}{WheelUp 6}                          ;MouseFn: mouse scroll down 6 lines
    lwin & j::            Sendinput {blind}{WheelDown 6}                        ;MouseFn: mouse scroll down 6 lines
    #IF                                                                         
    <^+h::                Sendinput {Wheelleft 1}                               ;MouseFn: mouse scroll left 1
    <^+l::                Sendinput {WheelRight 1}                              ;MouseFn: mouse scroll right 1
    >+#j::                Sendinput {WheelDown 6}                               ;MouseFn: mouse scroll wheel down 6
    >+#k::                Sendinput {Wheelup 6}                                 ;MouseFn: mouse scroll wheel up 6
                                                                                
    #f::                  Clicks(2)                                             ;MouseFn: 2 Left clicks (select word)
    ^#f::                 Clicks(3)                                             ;MouseFn: 3 Left clicks (select line)
    #o up::               Click, middle                                         ;MouseFn: mouse middle click
    ;PrintScreen & sc028::                                                      ;MouseFn: mouse Right click
    #SC027::              Click, Right                                          ;MouseFn: mouse Right click
    ~>+space::            CursorJump(,500,300)                                  ;MouseFn: center cursor
  ; saved click points  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #IF
    *#i::                                                                       ;MouseFn: return to saved mouse position and click (left click if no saved position found)
    *#d:: CursorRecall(substr(A_ThisHotkey,0), 1,,0)                            ;MouseFn: return to saved mouse position and click (left click if no saved position found) chng 4th parameter to 1 stay at saved clicked position
                                                                                
    #If GetKeyState("PrintScreen", "P")
    i:: CursorRecall(substr(A_ThisHotkey,0), 1,,0)                              ;MouseFn: return to saved mouse position and click (left click if no saved position found)
    #If
    F12 & i::                                                                   ;MouseFn: Left click and save mouse position
    F12 & d:: SaveMousPos(substr(A_ThisHotkey,0),1)                             ;MouseFn: Left click and save mouse position
                                                                                
    #If GetKeyState("shift", "P")
    F12 & i::                                                                   ;MouseFn: Left click and save mouse position
    F12 & d:: resetMousPos(substr(A_ThisHotkey,0))                              ;MouseFn: Left click and save mouse position
                                                                                
    #IF
    :X:i!~win::                                                                 ;MouseFn: Left click and save mouse position
    :X:!i~win:: resetMousPos("i")                                               ;MouseFn: Left click and save mouse position
    :X:d!~win::                                                                 ;MouseFn: Left click and save mouse position
    :X:+i~win:: SaveMousPos("i",1)                                              ;MouseFn: Left click and save mouse position
    :X:+d~win:: SaveMousPos("d",1)                                              ;MouseFn: Left click and save mouse position
    :X:!i~win:: resetMousPos("i")                                               ;MouseFn: Left click and save mouse position
    :X:!d~win:: resetMousPos("d")                                               ;MouseFn: Left click and save mouse position
                                                                                
  ; move cursor -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #If IsCMODE()                                                               ;capslocks used as modifier for following functions
    left::   Sendinput {Wheelleft 1}                                            ;MouseFn: mouse scroll left
    right::  Sendinput {WheelRight 1}                                           ;MouseFn: mouse scroll right
    space::  CursorJump()                                                       ;MouseFn: center cursor
    q::      CursorJump("TL",150,150)                                           ;MouseFn: move mouse cursor to top edge
    e::      CursorJump("TR",-150,150)                                          ;MouseFn: move mouse cursor to top edge
    w::      CursorJump("T",,150)                                               ;MouseFn: move mouse cursor to top edge
    s::      CursorJump("B",,-150)                                              ;MouseFn: move mouse cursor to bottom edge
    a::      CursorJump("L",150)                                                ;MouseFn: move mouse cursor to Left edge
    d::      CursorJump("R",-150)                                               ;MouseFn: move mouse cursor to Right edge
    lshift:: CursorJump("BL",150,-150)                                          ;MouseFn: move mouse cursowr to BOTTOM LEFT of active app
                                                                                
    #IF
; SPECIAL CHARACTERS____________________________________________________________
    :C*?:''E:: {U+00C9}                                                         ; ' followed by E => É
    :C*?:''e:: {U+00E9}                                                         ; ' followed by e => é
                                                                                
; CHORD COMMAND ________________________________________________________________
    
    #SC034::     
    ^SC034::     
    ChordTextManipulation(options := "L1 M T10", escape := "{esc}{ralt}") {
        global reChordMenuPattern, C
        
        ;pop up website menu
        menu := rtrim(AccessCache("zb\ChordTextMenu",,0),"`n")
        PU(menu,C.lblue,,,,90000,12,700,"Lucida Sans Typewriter",1)
        
        keysPressed :=  KeyWaitHook("L1 M T10",escape)
        input := (Instr(keysPressed,"<+") ? clipboard : (Instr(keysPressed,">+") ? clip() : ""))
        Gui, PopUp: cancel
        Switch % keysPressed
        {
            Case "v":           PasteWithoutBreaks()                                                ;TEXT MANIPULATION| replace multiple paragraph breaks w/ 1 break in selected text
            Case "<+v",">+v":   PasteWithoutBreaks(True)                                            ;TEXT MANIPULATION| replace multiple paragraph breaks with space (remove paragraphs breaks)
            Case "l":           RemoveBlankLines()                                                  ;TEXT MANIPULATION! remove empty lines starting from selected text
            Case "+":           ReplaceAwithB(",", "+")                                             ;TEXT MANIPULATION replace "," with "+" in selected text
            Case ",":           ReplaceAwithB("+", ",")                                             ;C.TM: replace "+" with "," in selected text
            Case "-":           clip(CS(clip(), {"_":" ","-":" "}))                                 ;C.TM: replace "_" with " " in selected text
            Case "a":           SortSelectedText()                                                  ;TEXT MANIPULATION Sort Selected Text
            Case "<+a",">+a":   SortSelectedText("R")                                               ;TEXT MANIPULATION Sort Selected Text
            Case "s":           ReplaceAwithB()                                                     ;TEXT MANIPULATION replaces multiple consecutive spaces with character length 1 space
            Case "<+s",">+s":   ReplaceAwithB(" ")                                                  ;TEXT MANIPULATION! remove all spaces from selected text
            Case "2":           SelectLine(), txt := clip(), s("{right}{enter}"), clip(txt)         ;TEXT MANIPULATION: duplicate current line
            Case "m":           ReplaceAwithB("_"," "),Capitalize1stLetter(,,0),,ReplaceAwithB(" ") ;CamelCase
            Case "n":           AddSpaceBtnCaseChange(), ReplaceAwithB(" ","_")                     ;snake_case
            Case "i":           SaveMousPos("i",1)                                                  ;save mouse position for #i
            Case "<+i",">+i":   resetMousPos("i")                                                   ;reset mouse position for #i
            Case "d":           SaveMousPos("d",1)                                                  ;save mouse position for #d
            Case "<+d",">+d":   resetMousPos("d")                                                   ;reset mouse position for #d 
            Case "e":           SI("#{SC034}")                                                      ;emojis
            Case "c":           SI("+#c")                                                           ;color picker

            default:
                ; msgbox % "Nothing assigned to " keysPressed " which was pressed"
                sleep,0
        }
        return 
    }
        
#IF