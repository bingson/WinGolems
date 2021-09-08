
; COMMAND BOX __________________________________________________________________

#IF WinActive("ahk_id " CB_hwnd)                                              ; If command Box active
  
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
!space::                                                                      ;CB| submit GUI input   
#space::           GUISubmit()                                                ;CB| submit GUI input 
$!x::              ToggleDisplay()                                            ;CB| toggle Command Box display|minimalist mode
!r::               GUIRecall()                                                ;CB| reenter last command

#IF WinExist("ahk_id " CB_hwnd) 

$<^space::                                                                    ;CB| activate already open CB and move focus to inputbox 
$>^space::         ActivateWin("ahk_id " CB_hwnd), GUIFocusInput()            ;CB| activate already open CB and move focus to inputbox

#IF WinActive("ahk_id " CB_hwnd) and GC("T_adv",0)                            ; If command Box active
+!a::              MoveWin("LS")                                              ;CB: move CB window to left side small
+!d::              MoveWin("RS")                                              ;CB: move CB window to right side small
+!w::              MoveWin("TS")                                              ;CB: move CB window to top half small
+!s::              MoveWin("BS")                                              ;CB: move CB window to bottom half small
+!q::              MoveWin("L1")                                              ;CB: move CB window to top left small
+!e::              MoveWin("R1")                                              ;CB: move CB window to top right small
+!z::              MoveWin("L4")                                              ;CB: move CB window to bottom left small
+!c::              MoveWin("R4")                                              ;CB: move CB window to bottom right small

#IF                                                                           ; end context dependent assignments  