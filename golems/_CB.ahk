; COMMAND BOX __________________________________________________________________

#enter::                                                                        ;CB: opens command box that runs ~win suffix CB keys; enter "?" for help
+#space::                                                                       ;CB: opens command box that runs ~win suffix CB keys; enter "?" for help
#space::           CB("~win")                                                   ;CB: opens command box that runs ~win suffix CB keys; enter "?" for help
:X:tt~win::        TC("T_TM","Text_Manipulation: ")                             ;CB: Toggle Text_Manipulation template ON|OFF by typing "tt" in a Command Box or "tt~win" anywhere in windows           
:X:tf~win::        TC("T_FM","File_Management: ")                               ;CB: Toggle File_Navigation template ON|OFF

#IF WinActive("ahk_id " CB_hwnd)                                                ; If Command or Function Box active

$^!k::                                                                          ;CB: Font size decrease
^SC00C::           goto, CBzoomOut                                              ;CB: Font size decrease
^SC00D::                                                                        ;CB: Font size increase
$^!j::             goto, CBzoomIn                                               ;CB: Font size increase
!n::               send !n                                                      ;CB: highlight next match of text in the CB display window with text entered in the input box
!b::               send !p                                                      ;CB: highlight previous match of text in the CB display window with text entered in the input box
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
>!space::          GUISubmit(">!space")                                         ;CB| Capitalize first letter of user input and submit GUI
<!space::                                                                       ;CB| submit GUI input
#space::           GUISubmit()                                                  ;CB| submit GUI input
$!x::              ToggleDisplay()                                              ;CB| toggle Command Box display|minimalist mode
!r::               GUIRecall()                                                  ;CB| reenter last command

#IF WinExist("ahk_id " CB_hwnd)                                                 ; Command Box
$<^space::                                                                      ;CB| activate already open CB and move focus to inputbox
$>^space::         ActivateWin("ahk_id " CB_hwnd), GUIFocusInput()              ;CB| activate already open CB and move focus to inputbox

#IF WinActive("ahk_id " CB_hwnd)                                                ; If command Box active
+!a::              MoveWin("LS")                                                ;CB: move CB window to left side small
+!d::              MoveWin("RS")                                                ;CB: move CB window to right side small
+!w::              MoveWin("TS")                                                ;CB: move CB window to top half small
+!s::              MoveWin("BS")                                                ;CB: move CB window to bottom half small
+!q::              MoveWin("L1")                                                ;CB: move CB window to top left small
+!e::              MoveWin("R1")                                                ;CB: move CB window to top right small
+!z::              MoveWin("L4")                                                ;CB: move CB window to bottom left small
+!c::              MoveWin("R4")                                                ;CB: move CB window to bottom right small

#IF WinExist("ahk_id " FB_hwnd)                                                 ;Function Box must exist for the below two lines to be valid
$<^space::                                                                      ;FB: activate already open Function Box and move focus to inputbox
$>^space::         ActivateWin("ahk_id " FB_hwnd)                               ;FB: activate already open Function Box and move focus to inputbox


#IF                                                                             ; end context dependent assignments