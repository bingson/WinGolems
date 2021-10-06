; COMMAND BOX __________________________________________________________________

+#space::                                                                       ;CB: opens command box that runs ~win suffix CB keys; enter "?" for help                                                                   
#space::           CB("~win")                                                   ;CB: opens command box that runs ~win suffix CB keys; enter "?" for help                            
Lwin & enter::     RunCB("V")                                                   ;CB: (V command) overwrite selected text w/ corresponding mem_cache .txt file. E.g., with "1" selected, pressing win + enter will paste contents of 1.txt.                                            

#If GetKeyState("shift", "P")
  Lwin & enter::   RunCB(,"~win")                                               ;CB: (win+enter+shift) run command keys entered in any text field in windows (word at cursor will be consumed) 
#If

#IF WinActive("ahk_id " CB_hwnd)                                                ; If Command or Function Box active
$^!k::                                                                          ;CB: Font size decrease
^SC00C::           goto, CBzoomOut                                              ;CB: Font size decrease
^SC00D::                                                                        ;CB: Font size increase
$^!j::             goto, CBzoomIn                                               ;CB: Font size increase
!n::               send !n                                                      ;CB: highlight next match of text in the CB display window with text entered in the input box
+!n::              send !p                                                      ;CB: highlight previous match of text in the CB display window with text entered in the input box
!q::               MoveWin("TL")                                                ;CB: move CB window to top left
!e::               MoveWin("TR")                                                ;CB: move CB window to top right
!z::               MoveWin("BL")                                                ;CB: move CB window to bottom left
!c::               MoveWin("BR")                                                ;CB: move CB window to bottom right
!w::               MoveWin("T")                                                 ;CB: move CB window to top half
!s::               MoveWin("B")                                                 ;CB: move CB window to bottom half
#left::                                                                         ;CB: move CB window to left half
!a::               MoveWin("L")                                                 ;CB: move CB window to left half
#right::                                                                        ;CB: move CB window to right half
!d::               MoveWin("R")                                                 ;CB: move CB window to right half
+!a::              MoveWin("LS")                                                ;CB: move CB window to left side small
+!d::              MoveWin("RS")                                                ;CB: move CB window to right side small
+!w::              MoveWin("TS")                                                ;CB: move CB window to top half small
+!s::              MoveWin("BS")                                                ;CB: move CB window to bottom half small
+!q::              MoveWin("L1")                                                ;CB: move CB window to top left small (portrait)
+!e::              MoveWin("R1")                                                ;CB: move CB window to top right small (portrait)
+!z::              MoveWin("L4")                                                ;CB: move CB window to bottom left small (portrait)
+!c::              MoveWin("R4")                                                ;CB: move CB window to bottom right small (portrait)
>+!e::                                                                          ;CB: move CB window to top right small (landscape) 
+>!e::             MoveWin("R1a")                                               ;CB: move CB window to top right small (landscape)
>+!q::                                                                          ;CB: move CB window to top left small (landscape) 
+>!q::             MoveWin("L1a")                                               ;CB: move CB window to top left small (landscape)
>+!z::                                                                          ;CB: move CB window to bottom left small (landscape)
+>!z::             MoveWin("L4a")                                               ;CB: move CB window to bottom left small (landscape)
>+!c::                                                                          ;CB: move CB window to bottom right small (landscape)
+>!c::             MoveWin("R4a")                                               ;CB: move CB window to bottom right small (landscape)
>!space::          GUISubmit(">!space")                                         ;CB| Capitalize first letter of user input and submit GUI
<!space::                                                                       ;CB| submit GUI input
#space::           GUISubmit()                                                  ;CB| submit GUI input
$!b::              ToggleDisplay()                                              ;CB| toggle Command Box display|minimalist mode
$!x::              ToggleDisplay()                                              ;CB| toggle Command Box display|minimalist mode
!r::               GUIRecall()                                                  ;CB| reenter last command

#IF WinExist("ahk_id " CB_hwnd)                                                 
$<^space::                                                                      ;CB| activate already open Command Box and move focus to inputbox
$>^space::         GUIFocusInput()                                              ;CB| activate already open Command Box and move focus to inputbox           

#IF WinExist("ahk_id " FB_hwnd)                                                 ;Function Box must exist for the below two lines to be valid
$<^space::                                                                      ;FB: activate already open Function Box and move focus to inputbox
$>^space::         GUIFocusInput("FB")                                          ;FB: activate already open Function Box and move focus to inputbox           

#IF                                                                             ; end context dependent assignments