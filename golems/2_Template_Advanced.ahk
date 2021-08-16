

; TOGGLE WINGOLEMS OPTIONS _____________________________________________________

  :X:ta~win::    
    CC("T_adv_opt","!")
    PopUp("Advanced shortcuts: " GC("T_adv_opt"))                               ;Toggle: advanced hotkeys (2_Template_Advanced.ahk)
    return

; CONVENIENCE___________________________________________________________________

  #IF GC("T_adv_opt",0)                                                         ; if T_adv_opt = 1 advanced hotkeys are active, if not value for T_adv_opt, default = 0
  
  capslock::del                                                                 ;C: makes capslock key function as a delete key. (old capslock functionality: ctrl + capslock)
  ^capslock::                     Send {blind}{capslock}                        ;C: toggle capslock
  ^#Backspace::                   ReplaceBackspaceWithSpaces()                  ;C: Delete and replace selected text with blank spaces 
  ^#v::                           PasteOverwrite()                              ;C: paste and overwrite the same number of spaces (aka. overtype paste)
  +^u::                           ConvertUpper()                                ;C: capitalization: capitalize selected text
  +!u::                           ConvertLower()                                ;C: capitalization: convert selected text to lower case
  ^!u::                           Capitalize1stLetter()                         ;C: capitalization: First letter capitalized
  ^!+u::                          Capitalize1stLetter(,,0)                      ;C: capitalization: Every First Letter Capitalized
  !#space::                       ReplaceAwithB(" ")                            ;C: remove all spaces from selected text
  ^#space::                       ReplaceAwithB()                               ;C: replace multiple consecutive spaces w/ one space in selected text
  !#enter::                       RemoveBlankLines()                            ;C: remove empty lines starting from selected text
  ^#sc027::                       Send {lwin down}d{lwin up}                    ;C: show desktop
  !Backspace:: SendInput {End}{ShiftDown}{Home 2}{Left}{ShiftUp}{Delete}{Right} ;C: Delete current line of text
  !sc033::     FunctionBox("MoveWin", MoveWin_DICT,C.bwhite,,MoveWin_DICT,0)    ;C: Move window to preset locations


; MOUSE (CURSOR) FUNCTIONS______________________________________________________
  ; mouse functions with keyboard shortcuts  
  
  
  *#i::                           SaveMousPos("i",1)                            ;MF: Left click and save mouse position
  *^#i::                          RecallMousePosClick("i")                      ;MF: Move to saved mouse position and left click
  !i::                            Click, middle                                 ;MF: mouse middle click
  PrintScreen & sc028::                                                         ;MF: mouse Right click
  #sc028::                        Click, Right                                  ;MF: mouse Right click

  ^!Lbutton::                     Clicks(2), s("^v")                            ;MF: click twice, paste clipboard
  +^Lbutton::                     Clicks(3), s("^v")                            ;MF: click thrice, paste clipboard
  
  $^!j::                          Sendinput ^{sc00D}                            ;MF: zoom in
  $^!k::                          Sendinput ^{sc00C}                            ;MF: zoom out
  
  #j::                            Sendinput {Blind}{WheelDown 2}                ;MF: scroll wheel down
  #k::                            Sendinput {Blind}{WheelUp 2}                  ;MF: scroll wheel Up
  
  $#>!h::                         Sendinput {Blind}{Wheelleft 6}                ;MF: scroll wheel left
  $#>!l::                         Sendinput {Blind}{WheelRight 6}               ;MF: scroll wheel right
  
  ~rctrl & ~lctrl::               CursorJump("TL")                              ;MF: move mouse cursor to TOP LEFT of active app
  ~lctrl & ~rctrl::               CursorJump("TR")                              ;MF: move mouse cursor to TOP RIGHT of active app
  ralt & lalt::                   CursorJump("BL")                              ;MF: move mouse cursor to BOTTOM LEFT of active app
  lalt & ralt::                   CursorJump("BR")                              ;MF: move mouse cursor to BOTTOM RIGHT of active app
  
  $!#k::                          CursorJump("T")                               ;MF: move mouse cursor to top edge
  $!#j::                          CursorJump("B",,"-20")                        ;MF: move mouse cursor to bottom edge
  $!#h::                          CursorJump("L","20")                          ;MF: move mouse cursor to Left edge
  $!#l::                          CursorJump("R","-40")                         ;MF: move mouse cursor to Right edge
      

; TEXT SELECTION AND NAVIGATION ________________________________________________

  ; SELECT TEXT-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
  $!f::         SelectWord()                                                     ;ST: select word at text cursor position
  $+!f::        SelectLine()                                                     ;ST: select current line starting from begining of line
  $^!f::        Sendinput {end}+{home}                                           ;ST: select line starting from end of line
   
  $^#h::        sendinput +{Home}                                                ;ST: select to beginning of line
  $^#l::        sendinput +{End}                                                 ;ST: select to end of line
  $+^j::        Sendinput +{down}                                                ;ST: select to next line
  $+^k::        Sendinput +{up}                                                  ;ST: select to line above
   
  $^#j::        sendinput ^+{end}                                                ;ST: select all below
  $^#k::        sendinput ^+{home}                                               ;ST: select all above
   
  $+#h::        Sendinput +^{Left}                                               ;ST: extend selection Left  1 word
  $+#l::        Sendinput +^{Right}                                              ;ST: extend selection Right 1 word
   
  $+!l::        Sendinput +{Right}                                               ;ST: extend selection Right 1 character
  $+!h::        Sendinput +{Left}                                                ;ST: extend selection Left  1 character
  $+#k::                                                                         ;ST: extend selection up    1 row
  +!k::         sendinput +{up}                                                  ;ST: extend selection up    1 row
  $+#j::                                                                         ;ST: extend selection down  1 row
  +!j::         sendinput +{down}                                                ;ST: extend selection down  1 row
  
  ; NAVIGATE TEXT-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
  $#h::         send ^{Left}                                                    ;NT: jump to next word; simulate ctrl+Left
  $#l::         send ^{Right}                                                   ;NT: jump to next word; simulate ctrl+Right (must first disable win+L lock key combo with CB key "lf")
  $!h::         send {Left}                                                     ;NT: Left
  $!l::         send {Right}                                                    ;NT: Right
  *$!k::        send {Up}                                                       ;NT: Up
  *$!j::        send {Down}                                                     ;NT: Down

; FILE EXPLORER HOTKEYS & FOLDER BOOKMARKS _____________________________________

  SetTitleMatchMode, 2
  #If WinActive("ahk_group FileListers") and GC("T_adv_opt",0)

  >+sc029::     ChangeFolder(A_ScriptDir)                                       ;CF: AHK folder
  >+m::         ChangeFolder(A_ScriptDir "\mem_cache\")                         ;CF: mem_cache
  >+u::         ChangeFolder(UProfile)                                          ;CF: %UserProfile%
  >+j::         ChangeFolder(UProfile "\Downloads")                             ;CF: Downloads
  >+o::         ChangeFolder(A_ProgramFiles)                                    ;CF: C:\Program Files
  >+!o::        ChangeFolder(PF_x86)                                            ;CF: C:\Program Files(x86)
  >+p::         ChangeFolder(UProfile "\Pictures\")                             ;CF: Pictures
  >+d::         ChangeFolder(UProfile "\Documents")                             ;CF: Documents
  >+c::         ChangeFolder(hdrive)                                            ;CF: %Homedrive% (C:)
  >+t::         ChangeFolder("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}")      ;CF: This PC / My Computer (file explorer only)

  !z::          Send !vn{enter}                                                 ;FE panes: toggle navigation pane
  ^p::          Send {alt down}p{alt up}                                        ;FE panes: toggle preview plane
  <!space::     ControlFocus, SysTreeView321, ahk_class CabinetWClass           ;FE panes: move focus to navigation pane
  >!space::     ControlFocus, DirectUIHWND2, ahk_class CabinetWClass            ;FE panes: move focus to current folder pane
  ^o::          Send !vg{down 2}{enter}                                         ;FE groups: group by file type
  ^i::          Send !vg{down 1}{enter}                                         ;FE groups: group by date
  <^j::         SortByName()                                                    ;FE view: sort by name
  <^k::         SortByDate()                                                    ;FE view: sort by date modified
  >^j::         SortByType()                                                    ;FE view: sort by type
  >^k::         SortBySize()                                                    ;FE view: sort by size
  !SC027::      DetailedView()                                                  ;FE view: detailed file info with resized columnsnmn       
  ^h::          ToggleInvisible()                                               ;FE view: toggle hide/unhide invisible files
  $+!c::        clipboard := Explorer_GetSelection()                            ;FE: store file path(s) of selected file(s) in clipboard
  ^s::          SelectByRegEx()                                                 ;FE: select files by regex

#IfWinActive




