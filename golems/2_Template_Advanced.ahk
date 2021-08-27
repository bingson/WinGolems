; TOGGLE WINGOLEMS OPTIONS _____________________________________________________

  :X:ta~win::    
    CC("T_adv_opt","!")
    PopUp("Advanced shortcuts: " GC("T_adv_opt"))                               ;Toggle: advanced hotkeys ON|OFF
    return

; CONVENIENCE___________________________________________________________________

  #IF GC("T_adv_opt",0)                                                         ; if T_adv_opt = 1 advanced hotkeys are active, if no value for T_adv_opt, default = 0
  ^!d::             SelectLine(), s("^c"), s("right"), s("enter"), s("^v")      ;Convenience: duplicate line
  :*:date*::                                                                    ;Convenience: output current date
    FormatTime, CurrentDateTime,, MMMM dd, yyyy
    clip(CurrentDateTime)
    return 
  
  +!sc00C::                       Send, {ASC 0150}                              ;Convenience: en dash (–)
  !sc00C::                        Send, {ASC 0151}                              ;Convenience: em dash (—)
  capslock::                      del                                           ;Convenience:1 makes capslock key function as a delete key. (old capslock functionality: ctrl + capslock)
  ^capslock::                     Send {blind}{capslock}                        ;Convenience:1 toggle capslock
  ^#Backspace::                   ReplaceBackspaceWithSpaces()                  ;Convenience: Delete and replace selected text with blank spaces 
  ^#v::                           PasteOverwrite()                              ;Convenience: Paste and overwrite the same number of spaces (aka. overtype paste)
  +^u::                           ConvertUpper()                                ;Convenience:2 capitalize selected text
  +!u::                           ConvertLower()                                ;Convenience:2 convert selected text to lower case
  ^!u::                           Capitalize1stLetter()                         ;Convenience:2 First letter capitalized
  ^!+u::                          Capitalize1stLetter(,,0)                      ;Convenience:2 Every First Letter Capitalized
  !#space::                       ReplaceAwithB(" ")                            ;Convenience: remove all spaces from selected text
  ^#space::                       ReplaceAwithB()                               ;Convenience: replace multiple consecutive spaces w/ one space in selected text
  !#enter::                       RemoveBlankLines()                            ;Convenience: remove empty lines starting from selected text
  ^#sc027::                       Send {lwin down}d{lwin up}                    ;Convenience: show desktop
  !sc033::     FunctionBox("MoveWin", MoveWin_DICT,C.bwhite,,MoveWin_DICT,0)    ;Convenience: Move window to preset locations

; MOUSE (CURSOR) FUNCTIONS______________________________________________________
  ; mouse functions with keyboard shortcuts  
  
  *#d::                           SaveMousPos("r",1)                            ;C: Left click and save mouse position
  *^#d::                          RecallMousePosClick("r")                      ;MF: Move to saved mouse position and left click
  *#i::                           SaveMousPos("i",1)                            ;MouseFn: Left click and save mouse position
  *^#i::                          RecallMousePosClick("i")                      ;MouseFn: Move to saved mouse position and left click
  !i::                            Click, middle                                 ;MouseFn: mouse middle click
  PrintScreen & sc028::                                                         ;MouseFn: mouse Right click
  #sc028::                        Click, Right                                  ;MouseFn: mouse Right click

  ^!Lbutton::                     Clicks(2), s("^v")                            ;MouseFn: click twice, paste clipboard
  +^Lbutton::                     Clicks(3), s("^v")                            ;MouseFn: click thrice, paste clipboard
  
  $^!j::                          Sendinput ^{sc00D}                            ;MouseFn: zoom in
  $^!k::                          Sendinput ^{sc00C}                            ;MouseFn: zoom out
  
  #j::                            Sendinput {Blind}{WheelDown 2}                ;MouseFn: scroll wheel down
  #k::                            Sendinput {Blind}{WheelUp 2}                  ;MouseFn: scroll wheel Up
  
  $#>!h::                         Sendinput {Blind}{Wheelleft 6}                ;MouseFn: scroll wheel left
  $#>!l::                         Sendinput {Blind}{WheelRight 6}               ;MouseFn: scroll wheel right
  
  ~rctrl & ~lctrl::               CursorJump("TL")                              ;MouseFn: move mouse cursor to TOP LEFT of active app
  ~lctrl & ~rctrl::               CursorJump("TR")                              ;MouseFn: move mouse cursor to TOP RIGHT of active app
  ralt & lalt::                   CursorJump("BL")                              ;MouseFn: move mouse cursor to BOTTOM LEFT of active app
  lalt & ralt::                   CursorJump("BR")                              ;MouseFn: move mouse cursor to BOTTOM RIGHT of active app
  
  $!#k::                          CursorJump("T")                               ;MouseFn: move mouse cursor to top edge
  $!#j::                          CursorJump("B",,"-20")                        ;MouseFn: move mouse cursor to bottom edge
  $!#h::                          CursorJump("L","20")                          ;MouseFn: move mouse cursor to Left edge
  $!#l::                          CursorJump("R","-40")                         ;MouseFn: move mouse cursor to Right edge
      

; TEXT SELECTION AND NAVIGATION ________________________________________________

  ; SELECT TEXT-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
  $!f::         SelectWord()                                                    ;SelectText: select word at text cursor position
  $+!f::        SelectLine()                                                    ;SelectText: select current line starting from begining of line
  $^!f::        Sendinput {end}+{home}                                          ;SelectText: select line starting from end of line
   
  $^#h::        sendinput +{Home}                                               ;SelectText: select to beginning of line
  $^#l::        sendinput +{End}                                                ;SelectText: select to end of line
  $+^j::        Sendinput +{down}                                               ;SelectText: select to next line
  $+^k::        Sendinput +{up}                                                 ;SelectText: select to line above
   
  $^#j::        sendinput ^+{end}                                               ;SelectText: select all below
  $^#k::        sendinput ^+{home}                                              ;SelectText: select all above
   
  $+#h::        Sendinput +^{Left}                                              ;SelectText: extend selection Left  1 word
  $+#l::        Sendinput +^{Right}                                             ;SelectText: extend selection Right 1 word
  $+#!h::       Sendinput +^{Left 2}                                            ;SelectText: extend selection Left  2 words
  $+#!l::       Sendinput +^{Right 2}                                           ;SelectText: extend selection Right 2 words
  $+^#h::       Sendinput +^{Left 3}                                            ;SelectText: extend selection Left  3 words
  $+^#l::       Sendinput +^{Right 3}                                           ;SelectText: extend selection Right 3 words
   
  $+!l::        Sendinput +{Right}                                              ;SelectText: extend selection Right 1 character
  $+!h::        Sendinput +{Left}                                               ;SelectText: extend selection Left  1 character
  $+#k::                                                                        ;SelectText: extend selection up    1 row
  +!k::         sendinput +{up}                                                 ;SelectText: extend selection up    1 row
  $+#j::                                                                        ;SelectText: extend selection down  1 row
  +!j::         sendinput +{down}                                               ;SelectText: extend selection down  1 row
  
  ; NAVIGATE TEXT-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
  $#h::         send ^{Left}                                                    ;NavigateText: jump to next word; simulate ctrl+Left
  $#l::         send ^{Right}                                                   ;NavigateText: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
  $!h::         send {Left}                                                     ;NavigateText:| Left
  $!l::         send {Right}                                                    ;NavigateText:| Right
  *$!k::        send {Up}                                                       ;NavigateText:| Up
  *$!j::        send {Down}                                                     ;NavigateText:| Down

; FILE EXPLORER HOTKEYS & FOLDER BOOKMARKS _____________________________________

  SetTitleMatchMode, 2
  #If WinActive("ahk_group FileListers") and GC("T_adv_opt",0)

  >+sc029::     ChangeFolder(A_ScriptDir)                                       ;ChgFolder: AHK folder
  >+m::         ChangeFolder(A_ScriptDir "\mem_cache\")                         ;ChgFolder: mem_cache
  >+u::         ChangeFolder(UProfile)                                          ;ChgFolder: %UserProfile%
  >+j::         ChangeFolder(UProfile "\Downloads")                             ;ChgFolder: Downloads
  >+o::         ChangeFolder(A_ProgramFiles)                                    ;ChgFolder: C:\Program Files
  >+!o::        ChangeFolder(PF_x86)                                            ;ChgFolder: C:\Program Files(x86)
  >+p::         ChangeFolder(UProfile "\Pictures\")                             ;ChgFolder: Pictures
  >+d::         ChangeFolder(UProfile "\Documents")                             ;ChgFolder: Documents
  >+c::         ChangeFolder(hdrive)                                            ;ChgFolder: %Homedrive% (C:)
  >+t::         ChangeFolder("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}")      ;ChgFolder: This PC / My Computer (file explorer only)

  !b::          send !{left}                                                    ;FileExplorer: prev folder
  !n::          send !{right}                                                   ;FileExplorer: forward folder
  !u::          send !{up}                                                      ;FileExplorer: up one directory level
  !z::          Send !vn{enter}                                                 ;FileExplorer: toggle navigation pane
  ^p::          Send {alt down}p{alt up}                                        ;FileExplorer: toggle preview plane
  <!space::     ControlFocus, SysTreeView321, ahk_class CabinetWClass           ;FileExplorer: move focus to navigation pane
  >!space::     ControlFocus, DirectUIHWND2, ahk_class CabinetWClass            ;FileExplorer: move focus to current folder pane
  ^o::          Send !vg{down 2}{enter}                                         ;FileExplorer: group by file type
  ^i::          Send !vg{down 1}{enter}                                         ;FileExplorer: group by date
  <^j::         SortByName()                                                    ;FileExplorer: sort by name
  <^k::         SortByDate()                                                    ;FileExplorer: sort by date modified
  >^j::         SortByType()                                                    ;FileExplorer: sort by type
  >^k::         SortBySize()                                                    ;FileExplorer: sort by size
  !SC027::      DetailedView()                                                  ;FileExplorer:1 detailed file info with resized columnsnmn       
  ^h::          ToggleInvisible()                                               ;FileExplorer:1 toggle hide/unhide invisible files
  $+!c::        clipboard := Explorer_GetSelection()                            ;FileExplorer:1 store file path(s) of selected file(s) in clipboard
  ^s::          SelectByRegEx()                                                 ;FileExplorer:1 select files by regex

; COMMAND BOX __________________________________________________________________
  #IF WinActive("ahk_id " CB_hwnd) and GC("T_adv_opt",0)                        ; If command Box active
  +!a::     MoveWin("LS")                                                       ;CommandBox: move CB window to left side small
  +!d::     MoveWin("RS")                                                       ;CommandBox: move CB window to right side small
  +!w::     MoveWin("TS")                                                       ;CommandBox: move CB window to top half small
  +!s::     MoveWin("BS")                                                       ;CommandBox: move CB window to bottom half small
  +!q::     MoveWin("L1")                                                       ;CommandBox: move CB window to top left small
  +!e::     MoveWin("R1")                                                       ;CommandBox: move CB window to top right small
  +!z::     MoveWin("L4")                                                       ;CommandBox: move CB window to bottom left small
  +!c::     MoveWin("R4")                                                       ;CommandBox: move CB window to bottom right small

  #If