; COMMAND BOX __________________________________________________________________ 

; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- c3
; Valid anywhere in windows
 
  #If GetKeyState("lshift", "P")                                                  
  lwin & space::                                                                ;CB. (+Lshift) opens command box that runs ~win suffix CB keys
  #If 
  lwin & space::    CB("~win")                                                  ;CB. opens command box that runs ~win suffix CB keys
  
  rshift & enter::  RunCmd(,GC("win_S","~win")) 
  Lwin & enter::    RunCmd(,GC("win_S","~win"))                                 ;CB.. selects word at text cursor position and run as CB "~win" key
 
  +<!space::                                                                    ;CB.. (V command) simulates ctrl+shift+left to select last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., 1 = 1.txt).
  <!space::         RunCmd(GC("win_P","V"))                                     ;CB.. (V command) simulates ctrl+shift+left to select last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., 1 = 1.txt).
 
; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
; Hotkeys below are active if a Command or Function Box is the active window
  #IF WinActive("ahk_id " CB_hwnd)   
  ralt & space::     RunCmd("V")                                                ;CB: paste mem_cache file
  esc::                                                                         ;CB: close command box
  ralt & SC027::     send {esc}                                                 ;CB: close command box
  $^!k::                                                                        ;CB: Font size decrease
  ^SC00C::           goto, CBzoomOut                                            ;CB: Font size decrease
  ^SC00D::                                                                      ;CB: Font size increase
  $^!j::             goto, CBzoomIn                                             ;CB: Font size increase
  !n::               send !n                                                    ;CB: highlight next match of text in the CB display window with text entered in the input box
  +!n::              send !p                                                    ;CB: highlight previous match of text in the CB display window with text entered in the input box
  !q::               MoveWin("TL")                                              ;CB: move CB window to top left
  !e::               MoveWin("TR")                                              ;CB: move CB window to top right
  !z::               MoveWin("BL")                                              ;CB: move CB window to bottom left
  !c::               MoveWin("BR")                                              ;CB: move CB window to bottom right
  !w::               MoveWin("T")                                               ;CB: move CB window to top half
  !s::               MoveWin("B")                                               ;CB: move CB window to bottom half
  #left::                                                                       ;CB: move CB window to left half
  !a::               MoveWin("L")                                               ;CB: move CB window to left half
  #right::                                                                      ;CB: move CB window to right half
  !d::               MoveWin("R")                                               ;CB: move CB window to right half
  +!a::              MoveWin("LS")                                              ;CB: move CB window to left side small
  +!d::              MoveWin("RS")                                              ;CB: move CB window to right side small
  +!w::              MoveWin("TS")                                              ;CB: move CB window to top half small
  +!s::              MoveWin("BS")                                              ;CB: move CB window to bottom half small
  +!q::              MoveWin("L1")                                              ;CB: move CB window to top left small (portrait)
  +!e::              MoveWin("R1")                                              ;CB: move CB window to top right small (portrait)
  +!z::              MoveWin("L4")                                              ;CB: move CB window to bottom left small (portrait)
  +!c::              MoveWin("R4")                                              ;CB: move CB window to bottom right small (portrait)
  >+!e::                                                                        ;CB: move CB window to top right small (landscape)
  +>!e::             MoveWin("R1a")                                             ;CB: move CB window to top right small (landscape)
  >+!q::                                                                        ;CB: move CB window to top left small (landscape)
  +>!q::             MoveWin("L1a")                                             ;CB: move CB window to top left small (landscape)
  >+!z::                                                                        ;CB: move CB window to bottom left small (landscape)
  +>!z::             MoveWin("L4a")                                             ;CB: move CB window to bottom left small (landscape)
  >+!c::                                                                        ;CB: move CB window to bottom right small (landscape)
  +>!c::             MoveWin("R4a")                                             ;CB: move CB window to bottom right small (landscape)
  #space::           GUISubmit()                                                ;CB| submit user input
  rshift & space::   GUISubmit("rshift")                                        ;CB| Capitalize first letter of user input, then submit
  $!b::              ToggleDisplay()                                            ;CB| toggle Command Box display|minimalist mode
  $!x::              ToggleDisplay()                                            ;CB| toggle Command Box display|minimalist mode
  !r::               GUIRecall()                                                ;CB| reenter last command

; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
; Hotkeys below are active if a Command or Function Box exists but it not the active window

#IF WinExist("ahk_id " CB_hwnd) and !WinActive("ahk_id " CB_hwnd)                                                
  rctrl & space::  GUIFocusInput("CB"), GC("CB_appActive", 0) ? s("{tab}") : "" ;CB| activate already open Command Box and move focus to inputbox    

#IF WinExist("ahk_id " FB_hwnd)                                                 ;Function Box must exist for the below two lines to be valid
  $>^space::       GUIFocusInput("FB")                                          ;FB: activate already open Function Box and move focus to inputbox                                    

#IF                                                                             ; end context dependent assignments