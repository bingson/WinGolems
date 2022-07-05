; CONVENIENCE/TEXT MANIPULATION ________________________________________________
  
  !Backspace::       delLine()                                                  ;Convenience: delete current line of text
  ^#Backspace::      ReplaceBackspaceWithSpaces()                               ;Convenience| Delete and replace selected text with blank spaces
  !v::               PasteWithoutBreaks()                                       ;Convenience| replace multiple paragraph breaks w/ 1 break in selected text
  +!v::              PasteWithoutBreaks(True)                                   ;Convenience| replace multiple paragraph breaks with space (remove paragraphs breaks)
  ^#v::              PasteOverwrite()                                           ;Convenience| Paste and overwrite the same number of spaces (aka. overtype paste)
  +^u::              w("ls","lc"),ConvertUpper()                                ;Convenience* capitalize selected text
  +!u::              w("ls","la"),ConvertLower()                                ;Convenience* make selected text to lower case
  ^!u::              w("la","lc"),Capitalize1stLetter()                         ;Convenience; First Letter Capitalized
  ^!+u::             w("ls","lc","la"),Capitalize1stLetter(,,0)                 ;Convenience; Every First Letter Capitalized
  !#s::              ReplaceAwithB(" ")                                         ;Convenience! remove all spaces from selected text
  !#enter::          RemoveBlankLines()                                         ;Convenience! remove empty lines starting from selected text
  +!9::              Clip("(" Clip() ")")                                       ;Convenience: enclose selected text with ( )
  $+!SC01A::         Clip("{" Clip() "}")                                       ;Convenience: enclose selected text with { }
  !SC01A::           Clip("[" Clip() "]")                                       ;Convenience: enclose selected text with [ ]
  +^SC028::          Clip("'" Clip() "'")                                       ;Convenience: enclose selected text with ' '
  +!SC028::          Clip("""" Clip() """")                                     ;Convenience: enclose selected text with " "
  <!>+5::                                                                       ;Convenience: enclose selected text with % %
  >!<+5::            Clip("%" Clip() "%")                                       ;Convenience: enclose selected text with % %
  <!>+4::                                                                       ;Convenience: enclose selected text with $ $
  >!<+4::            Clip("$" Clip() "$")                                       ;Convenience: enclose selected text with $ $
  !sc029::           Clip("``" Clip() "``")                                     ;Convenience: enclose selected text with ` `
  +!sc029::          Clip("`````` " Clip() " ``````")                           ;Convenience: enclose selected text with ``` ```
  #backspace::       Send ^{backspace}                                          ;Convenience: ^backspace (delete word from last character)
  #!sc028::          s("{blind}"), ReplaceAwithB("""", "")                      ;Convenience replace "_" with " " Ain selected text
  #!sc00C::          s("{blind}"), ReplaceAwithB("-", " ")                      ;Convenience replace "_" with " " Ain selected text
  ^#sc00C::          s("{blind}"), ReplaceAwithB(" ", "-")                      ;Convenience replace " " with "_" in selected text
  #!SC034::          s("{blind}"), ReplaceAwithB(".", " ")                      ;Convenience replace "." with " " in selected text
  ^#SC034::          s("{blind}"), ReplaceAwithB(" ", ".")                      ;Convenience replace "." with " " in selected text
  ^#SC00D::          s("{blind}"), ReplaceAwithB(" ", "+")                      ;Convenience replace " " with "+" in selected text
  #!sc033::          s("{blind}"), ReplaceAwithB(",", " ")                      ;Convenience replace "_" with " " Ain selected text
  ^#SC033::          s("{blind}"), ReplaceAwithB(" ", ",")                      ;Convenience replace " " with "," in selected text
  #!SC00D::          s("{blind}"), ReplaceAwithB(",", "+")                      ;Convenience replace "," with "+" in selected text


  #IF IsCMODE()
  backspace::        ReplaceAwithB(" ")                                         ; remove all spaces               
  SC00D::            ReplaceAwithB()                                            ; replaces multiple consecutive spaces with character length 1 space 
  #IF  

  #If !WinActive("ahk_exe Code.exe") && GC("T_TM",0)                            ; conditional: ignore this shortcut if vs code active            
  ^!d::              SelectLine(), txt := clip(), s("right"), clip(txt)         ;Convenience: duplicate current line
  #IF GC("T_TM",0)


 
; TEXT NAVIGATION & SELECTION __________________________________________________
  
    $#h::              Sendinput ^{Left}                                        ;Navigation: jump to next word; simulate ctrl+Left
    $#l::              Sendinput ^{Right}                                       ;Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
    $#>!h::            Sendinput ^{Left 4}                                      ;Navigation: jump to next word; simulate ctrl+Left
    $#>!l::            Sendinput ^{Right 4}                                     ;Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
    $#>!j::            Sendinput {down 4}                                       ;Navigation: jump to next word; simulate ctrl+Left
    $#>!k::            Sendinput {up 4}                                         ;Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
    $<^>!h::           Sendinput ^{Left 4}                                      ;Navigation: jump to next word; simulate ctrl+Left
    $<^>!l::           Sendinput ^{Right 4}                                     ;Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
    !h::               Sendinput {Left}                                         ;Navigation| Left
    !l::               Sendinput {Right}                                        ;Navigation| Right
    !j::               Sendinput {down}                                         ;Navigation| Up
    !k::               Sendinput {up}                                           ;Navigation| Down
    ^!h::              Sendinput {home}                                         ;Navigation: Home
    ^!l::              Sendinput {end}                                          ;Navigation: End
    #e::               W("lw"),SI("^{home}")                                    ;Navigation: ^home                        
    +#e up::           W("lw","ls"),SI("^{end}")                                ;Navigation: ^end
    ;>^K::              W("rc"),SI("^{home}")                                    ;Navigation: ^home
    ;>^J::              W("rc"),SI("^{end}")                                     ;Navigation: ^end

    #IF GC("T_rshift",1) ;-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    >+l::              Sendinput {Right 4}                                      ;Navigation: extend selection Right 4 character
    >+h::              Sendinput {Left 4}                                       ;Navigation: extend selection Left  4 character
    >+j::              Sendinput {down 4}                                       ;Navigation: extend selection Right 4 character
    >+k::              Sendinput {up 4}                                         ;Navigation: extend selection Left  4 character

    #IF IsCMODE() ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    n::                Sendinput {down}                                         ;Navigation| Up
    b::                Sendinput {up}                                           ;Navigation| Down

    rshift & l::       Sendinput {Right 10}                                     ;Navigation: extend selection Right 2 character
    rshift & h::       Sendinput {Left 12}                                      ;Navigation: extend selection Left  2 character
    rshift & j::       Sendinput {down 12}                                      ;Navigation: extend selection Right 2 character
    rshift & k::       Sendinput {up 10}                                        ;Navigation: extend selection Left  2 character
    h::                Sendinput {home}                                         ;Navigation: home
    l::                Sendinput {end}                                          ;Navigation: end
    #IF  

    $<!f::             SelectWord()                                             ;Selection: select word at text cursor position
    $+!f up::          SelectLine()                                             ;Selection: select current line starting from begining of line
    $^!f::             Sendinput {end}+{home}                                   ;Selection: select line starting from end of line
    $^#h::             Sendinput +{Home}                                        ;Selection: select to beginning of line (press win before ctrl)
    $^#l::             Sendinput +{End}                                         ;Selection: select to end of line (press win before ctrl)
    $+^j::             Sendinput +{down}                                        ;Selection: select to next line
    $+^k::             Sendinput +{up}                                          ;Selection: select to line above
    $^#j::             Sendinput +^{end}                                        ;Selection: select all below
    $^#k::             Sendinput +^{home}                                       ;Selection: sejlect all above
    $+^h::             Sendinput +^{Left}                                       ;Selection: extend selection Left  1 words
    $+^l::             Sendinput +^{Right}                                      ;Selection: extend selection Right 1 words
    $+#h::             Sendinput +^{Left}                                       ;Selection: extend selection Left  1 words
    $+#l::             Sendinput +^{Right}                                      ;Selection: extend selection Right 1 words
    $+#>!h::           Sendinput +^{Left 2}                                     ;Selection: extend selection Left  2 words
    $+#>!l::           Sendinput +^{Right 2}                                    ;Selection: extend selection Right 2 words
    $+#>!j::           Sendinput +^{down 4}                                     ;Selection: extend selection Left  2 words
    $+#>!k::           Sendinput +^{up 4}                                       ;Selection: extend selection Right 2 words
    $+<!l::            Sendinput +{Right}                                       ;Selection: extend selection Right 1 characters
    $+<!h::            Sendinput +{Left}                                        ;Selection: extend selection Left  1 characters
    $+#k::                                                                      ;Selection: extend selection up    1 rows
    +!k::              Sendinput +{up}                                          ;Selection: extend selection up    1 rows
    $+#j::                                                                      ;Selection: extend selection down  1 rows
    +!j::              Sendinput +{down}                                        ;Selection: extend selection down  1 rows
    $>+<!l::                                                                    ;Selection: extend selection Right 4 characters 
    $<+>!l::           Sendinput +{Right 4}                                     ;Selection: extend selection Right 4 characters
    $>+<!h::                                                                    ;Selection: extend selection Left 4 characters 
    $<+>!h::           Sendinput +{Left 4}                                      ;Selection: extend selection Left 4 characters
    >+<!k::                                                                     ;Selection: extend selection up    4 rows 
    <+>!k::            Sendinput +{up 4}                                        ;Selection: extend selection up    4 rows
    >+<!j::                                                                     ;Selection: extend selection down  4 rows 
    <+>!j::            Sendinput +{down 4}                                      ;Selection: extend selection down  4 rows
    $<+>+!l::          Sendinput +{Right 10}                                    ;Selection: extend selection Right 10 characters
    $<+>+!h::          Sendinput +{Left 10}                                     ;Selection: extend selection Left  10 characters
    <+>+!k::           Sendinput +{up 8}                                        ;Selection: extend selection up    8 rows
    <+>+!j::           Sendinput +{down 8}                                      ;Selection: extend selection down  8 rows
    <+>+#h::           Sendinput +^{left 4}                                     ;Selection: extend selection up    4 rows
    <+>+#l::           Sendinput +^{right 4}                                    ;Selection: extend selection down  4 rows
    >+!l::             Sendinput +{Right 8}                                     ;Selection: extend selection Right 8 rows
    >+!h::             Sendinput +{Left 8}                                      ;Selection: extend selection Left  8 rows
    <+>+l::            Sendinput +{Right 5}                                     ;Selection: extend selection Right 5 rows
    <+>+h::            Sendinput +{Left 5}                                      ;Selection: extend selection Left  5 rows
    <+>+k::            Sendinput +{up 4}                                        ;Selection: extend selection up    4 rows
    <+>+j::            Sendinput +{down 4}                                      ;Selection: extend selection down  4 rows

  
; MOUSE FUNCTION _______________________________________________________________
    
    *#i::                                                                       ;MouseFn: return to saved mouse position and click (left click if no saved position found)
    *#d::             CursorRecall(substr(A_ThisHotkey,0), 1,,0)                ;MouseFn: return to saved mouse position and click (left click if no saved position found) chng 4th parameter to 1 stay at saved clicked position
    F12 & i::                                                                   ;MouseFn: Left click and save mouse position
    F12 & d::         SaveMousPos(substr(A_ThisHotkey,0),1)                     ;MouseFn: Left click and save mouse position
    :X:+i~win::       SaveMousPos("i",1)                                        ;MouseFn: Left click and save mouse position
    :X:+p~win::       SaveMousPos("p",1)                                        ;MouseFn: Left click and save mouse position
    end & i::                                                                   ;MouseFn: reset saved mouse coordinates 
    end & d::                                                                   ;MouseFn: reset saved mouse coordinates 
                      DC("MPos_" getCurrentDesktop() "_" substr(A_ThisHotkey,0))
                      PU("Click reset")                                         ;MouseFn: erase saved curor position
                      return
    #>^j::            Sendinput {WheelDown 10}                                  ;MouseFn: scroll wheel down 15 clicks
    #>^k::            Sendinput {WheelUp 10}                                    ;MouseFn: scroll wheel Up 15 clicks
    printscreen & j:: Sendinput {WheelDown 4}                                   ;MouseFn: scroll wheel down 15 clicks
    printscreen & k:: Sendinput {WheelUp 4}                                     ;MouseFn: scroll wheel Up 15 clicks

    $#k::             Sendinput {WheelUp 3}                                     ;Navigation: mouse scroll down 6 lines
    $#j::             Sendinput {WheelDown 3}                                   ;Navigation: mouse scroll down 6 lines
    $#>+h::           Sendinput {Wheelleft 1}                                   ;Navigation: mouse scroll left
    $#>+l::           Sendinput {WheelRight 1}                                  ;Navigation: mouse scroll right
    $#n::             CursorJump("C")                                           ;MouseFn: move mouse cursor to center of active application window

    #f::              Clicks(2)                                                 ;MouseFn: 2 Left clicks (select word)
    ^#f::             Clicks(3)                                                 ;MouseFn: 3 Left clicks (select line)
    >+>!j up::        Send ^{sc00D}                                             ;MouseFn: zoom in
    >+>!k up::        Send ^{sc00C}                                             ;MouseFn: zoom out
    #o up::           Click, middle                                             ;MouseFn: mouse middle click
    PrintScreen & sc028::                                                       ;MouseFn: mouse Right click
    #sc028::          Click, Right                                              ;MouseFn: mouse Right click

  #If IsCMODE()                                                                 ; capslocks used as modifier for following functions
            
    sc028::         Click, Right                                                ;MouseFn: mouse Right click
    k::             Sendinput {WheelUp 2}                                       ;MouseFn: mouse scroll down 2 lines
    j::             Sendinput {WheelDown 2}                                     ;MouseFn: mouse sckkroll down 2 lines
    left::          Sendinput {Wheelleft 1}                                     ;MouseFn: mouse scroll left
    right::         Sendinput {WheelRight 1}                                    ;MouseFn: mouse scroll right
    space::         CursorJump()                                                ;MouseFn: center cursor
    w::             CursorJump("T",,100)                                        ;MouseFn: move mouse cursor to top edge
    s::             CursorJump("B",,-70)                                        ;MouseFn: move mouse cursor to bottom edge
    a::             CursorJump("L",70)                                          ;MouseFn: move mouse cursor to Left edge
    d::             CursorJump("R",-70)                                         ;MouseFn: move mouse cursor to Right edge
    u::             CursorJump("TL",150,150)                                    ;MouseFn: move mouse cursor to TOP LEFT of active app
    q::             CursorJump("TL",150,150)                                    ;MouseFn: move mouse cursor to TOP LEFT of active app
    i::             CursorJump("TR",-150,150)                                   ;MouseFn: move mouse cursor to TOP RIGHT of active app
    e::             CursorJump("TR",-150,150)                                   ;MouseFn: move mouse cursor to TOP RIGHT of active app
    lshift::        CursorJump("BL",150,-150)                                   ;MouseFn: move mouse cursowr to BOTTOM LEFT of active app
    z::             CursorJump("BL",150,-150)                                   ;MouseFn: move mouse cursowr to BOTTOM LEFT of active app
    c::             CursorJump("BR",-150,-150)                                  ;MouseFn: move mouse cursor to BOTTOM RIGHT of active app
  
#IF

