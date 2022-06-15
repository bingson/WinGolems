; COMMAND BOX __________________________________________________________________ 

; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
; Valid anywhere in windows
  #IF isCMODE()
  f::             CB("~win")                                                    ;CB.. opens command box that runs ~win suffix CB keys (+capslock) 
  #IF 
  
  #space up::     CB("~win")                                                    ;CB.. opens command box that runs ~win suffix CB keys
  #enter up::     RunCmd(,"~win")                                               ;CB.. selects word at text cursor position and run as CB "~win" key  
  
  ^#r up::        ProcessCommand(GC("last_user_input"),GC("CB_sfx")), s("{esc}")  ;CB.. rerun last CB submission                    
  esc & SC033::   DC("LaltSpaceCommand"), PU("LaltSpaceCommand reset to V") 
  esc & SC034::   DC("RaltSpaceCommand"), PU("RaltSpaceCommand reset to V")
    
                     
; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
; Hotkeys below are active if a Command or Function Box is the active window
  #IF WinActive("ahk_id " CB_hwnd)   
  <!space::     W("a"),RunCmd(GC("LaltSpaceCommand","V"))                           ;CB: paste mem_cache file m
  >!space::     W("a"),RunCmd(GC("RaltSpaceCommand","V"))                           ;CB: paste mem_cache file                         
  esc::                                                                         ;CB: close command box
  ralt & SC027::     W("a"),s("{esc}")                                                 ;CB: close command box
  +^k up::                                                                      ;CB: Font size decrease 
  ^SC00C::           goto, CBzoomOut                                            ;CB: Font size decrease
  +^j up::                                                                      ;CB: Font size increase 
  ^SC00D::           goto, CBzoomIn                                             ;CB: Font size increase
  !n::               Send !n                                                    ;CB: highlight next match of text in the CB display window with text entered in the input box
  +!n::              Send !p                                                    ;CB: highlight previous match of text in the CB display window with text entered in the input box
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
  +!q::              MoveWin("L1")                                             ;CB: move CB window to top left small (portrait)
  +!e::              MoveWin("R1")                                             ;CB: move CB window to top right small (portrait)
  +!z::              MoveWin("L4")                                             ;CB: move CB window to bottom left small (portrait)
  +!c::              MoveWin("R4")                                             ;CB: move CB window to bottom right small (portrait)
  >+!e::                                                                        ;CB: move CB window to top right small (landscape)
  +>!e::             MoveWin("R1v")                                              ;CB: move CB window to top right small (landscape)
  >+!q::                                                                        ;CB: move CB window to top left small (landscape)
  +>!q::             MoveWin("L1v")                                              ;CB: move CB window to top left small (landscape)
  >+!z::                                                                        ;CB: move CB window to bottom left small (landscape)
  +>!z::             MoveWin("L4v")                                              ;CB: move CB window to bottom left small (landscape)
  >+!c::                                                                        ;CB: move CB window to bottom right small (landscape)
  +>!c::             MoveWin("R4v")                                              ;CB: move CB window to bottom right small (landscape)
  #space::           GUISubmit()                                                ;CB| submit user input
  rshift & enter::   GUISubmit("rshift")                                        ;CB| Capitalize first letter of user input, then submit
  $!b::              ToggleDisplay()                                            ;CB| toggle Command Box display|minimalist mode
  $!x::              ToggleDisplay()                                            ;CB| toggle Command Box display|minimalist mode
  !r::               GUIRecall()                                                ;CB| reenter last command

; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
; Hotkeys below are active if a Command or Function Box exists but it not the active window

#IF WinExist("ahk_id " CB_hwnd) and !WinActive("ahk_id " CB_hwnd)                                                
;   rctrl & space::  GUIFocusInput("CB"), GC("CB_appActive", 0) ? s("{tab}") : "" ;CB| activate already open Command Box and move focus to inputbox    
  >^space::  GUIFocusInput("CB")                                          ;CB| activate already open Command Box and move focus to inputbox 

#IF WinExist("ahk_id " FB_hwnd)                                                 ;Function Box must exist for the below two lines to be valid
  $>^space up::       GUIFocusInput("FB")                                          ;FB: activate already open Function Box and move focus to inputbox                                    

#IF                                                                             ; end context dependent assignments