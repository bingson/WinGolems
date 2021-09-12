#IF GC("T_TM",0)                                                                ;lines below are valid anywhere in windows if "T_TM" variable in config.ini = 1
; CONVENIENCE __________________________________________________________________
  
  +capslock::            backspace                                              ;Convenience: backspace (toggle capslock: ctrl + capslock)
  capslock::             del                                                    ;Convenience: delete (toggle capslock: ctrl + capslock)
  ^capslock::            Send {blind}{capslock}                                 ;Convenience: toggle capslock
  +!sc00C::              Send, {ASC 0150}                                       ;Convenience- en dash (–)
  !sc00C::               Send, {ASC 0151}                                       ;Convenience- em dash (—)
  ^#Backspace::          ReplaceBackspaceWithSpaces()                           ;Convenience| Delete and replace selected text with blank spaces 
  !v::                   PasteWithoutBreaks()                                   ;Convenience| replace multiple paragraph breaks w/ 1 break in selected text
  +!v::                  PasteWithoutBreaks(True)                               ;Convenience| replace multiple paragraph breaks with space (remove paragraphs breaks)
  ^#v::                  PasteOverwrite()                                       ;Convenience| Paste and overwrite the same number of spaces (aka. overtype paste)
  +^u::                  ConvertUpper()                                         ;Convenience* capitalize selected text
  +!u::                  ConvertLower()                                         ;Convenience* make selected text to lower case
  ^!u::                  Capitalize1stLetter()                                  ;Convenience; First letter capitalized
  ^!+u::                 Capitalize1stLetter(,,0)                               ;Convenience; Every First Letter Capitalized
  !#space::              ReplaceAwithB(" ")                                     ;Convenience! remove all spaces from selected text
  ^#space::              ReplaceAwithB()                                        ;Convenience! replace multiple consecutive spaces w/ one space in selected text
  !#enter::              RemoveBlankLines()                                     ;Convenience! remove empty lines starting from selected text
  +!9::                  Clip("(" Clip() ")")                                   ;Convenience: enclose selected text with ( )
  $+!SC01A::             Clip("{" Clip() "}")                                   ;Convenience: enclose selected text with { }
  !SC01A::               Clip("[" Clip() "]")                                   ;Convenience: enclose selected text with [ ]
  ^SC028::               Clip("'" Clip() "'")                                   ;Convenience: enclose selected text with ' '
  +!SC028::              Clip("""" Clip() """")                                 ;Convenience: enclose selected text with " "
  >!+5::                 Clip("%" Clip() "%")                                   ;Convenience: enclose selected text with % %
  >!+4::                 Clip("$" Clip() "$")                                   ;Convenience: enclose selected text with $ $
  !sc029::               Clip("``" Clip() "``")                                 ;Convenience: enclose selected text with ` `
  +!sc029::              Clip("`````` " Clip() " ``````")                       ;Convenience: enclose selected text with ``` ```
  #backspace::           send ^{backspace}                                      ;Convenience: ^backspace (delete word from last character)
  ^!sc027::              send {{}                                               ;Convenience: left bracket
  ^!sc028::              send {}}                                               ;Convenience: right bracket
  ^!d::                  SelectLine(), txt := clip(), s("right"), clip(txt)     ;Convenience: duplicate current line

; SELECTION ____________________________________________________________________
  
  $!f::                  SelectWord()                                           ;Selection: select word at text cursor position
  $+!f::                 SelectLine()                                           ;Selection: select current line starting from begining of line
  $^!f::                 Sendinput {end}+{home}                                 ;Selection: select line starting from end of line
  $^#h::                 sendinput +{Home}                                      ;Selection: select to beginning of line (press win before ctrl)
  $^#l::                 sendinput +{End}                                       ;Selection: select to end of line (press win before ctrl)
  $+^j::                 Sendinput +{down}                                      ;Selection: select to next line
  $+^k::                 Sendinput +{up}                                        ;Selection: select to line above
  $^#j::                 sendinput ^+{end}                                      ;Selection: select all below
  $^#k::                 sendinput ^+{home}                                     ;Selection: select all above
  $+#h::                 Sendinput +^{Left}                                     ;Selection: extend selection Left  1 word
  $+#l::                 Sendinput +^{Right}                                    ;Selection: extend selection Right 1 word
  $+#!h::                Sendinput +^{Left 2}                                   ;Selection: extend selection Left  2 words
  $+#!l::                Sendinput +^{Right 2}                                  ;Selection: extend selection Right 2 words
  $+^#h::                Sendinput +^{Left 3}                                   ;Selection: extend selection Left  3 words
  $+^#l::                Sendinput +^{Right 3}                                  ;Selection: extend selection Right 3 words
  $+!l::                 Sendinput +{Right}                                     ;Selection: extend selection Right 1 character
  $+!h::                 Sendinput +{Left}                                      ;Selection: extend selection Left  1 character
  $+#k::                                                                        ;Selection: extend selection up    1 row
  +!k::                  sendinput +{up}                                        ;Selection: extend selection up    1 row
  $+#j::                                                                        ;Selection: extend selection down  1 row
  +!j::                  sendinput +{down}                                      ;Selection: extend selection down  1 row
  
; NAVIGATION ___________________________________________________________________

  #e::                   send ^{home}                                           ;Navigation: ^home
  #+e::                  send ^{end}                                            ;Navigation: ^end
  $#h::                  sendinput ^{Left}                                      ;Navigation: jump to next word; simulate ctrl+Left
  $#l::                  sendinput ^{Right}                                     ;Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
  $!h::                  sendinput {Left}                                       ;Navigation| Left
  $!l::                  sendinput {Right}                                      ;Navigation| Right
  *!j::                  send {down}                                            ;Navigation| Up
  *!k::                  send {up}                                              ;Navigation| Down  

; MOUSE FUNCTION _______________________________________________________________
  *#d::                  SaveMousPos("r",1)                                     ;MouseFn: Left click and save mouse position
  *^#d::                 RecallMousePosClick("r", 0)                            ;MouseFn: return to saved mouse position (change 0 to number of clicks) 
  #f::                   Clicks(2)                                              ;MouseFn: 2 Left clicks (select word)
  ^#f::                  Clicks(3)                                              ;MouseFn: 3 Left clicks (select line)
  ^!Lbutton::            s("{blind}"),Clicks(2), s("^v")                        ;MouseFn: click twice, paste clipboard        
  +^Lbutton::            s("{blind}"),Clicks(3), s("^v")                        ;MouseFn: click thrice, paste clipboard                   
  $^!j::                 Sendinput ^{sc00D}                                     ;MouseFn: zoom in
  $^!k::                 Sendinput ^{sc00C}                                     ;MouseFn: zoom out
  ~rctrl & ~lctrl::      CursorJump("TL")                                       ;MouseFn: move mouse cursor to TOP LEFT of active app
  ~lctrl & ~rctrl::      CursorJump("TR")                                       ;MouseFn: move mouse cursor to TOP RIGHT of active app
  ralt & lalt::          CursorJump("BL")                                       ;MouseFn: move mouse cursor to BOTTOM LEFT of active app
  lalt & ralt::          CursorJump("BR")                                       ;MouseFn: move mouse cursor to BOTTOM RIGHT of active app
  $!#k::                 CursorJump("T")                                        ;MouseFn: move mouse cursor to top edge
  $!#j::                 CursorJump("B",,"-20")                                 ;MouseFn: move mouse cursor to bottom edge
  $!#h::                 CursorJump("L","20")                                   ;MouseFn: move mouse cursor to Left edge
  $!#l::                 CursorJump("R","-40")                                  ;MouseFn: move mouse cursor to Right edge

#IF

