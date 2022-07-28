; COMMAND BOX __________________________________________________________________ 

; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
; Valid anywhere in windows
  #IF isCMODE()
  f::                   CB("~win")                                              ;CB.. opens command box that runs ~win suffix CB keys (+capslock)
  #IF 
  lwin & space::        CB("~win")                                              ;CB.. opens command box that runs ~win suffix CB keys
  printscreen & space:: CB("~win")                                              ;CB.. opens command box that runs ~win suffix CB keys
  #enter::              RunCmd(,"~win")                                         ;CB.. selects word at text cursor position and run as CB "~win" key

  
  ^#r up::        w("lw","c"),ProcessCommand(GC("last_user_input"),GC("CB_sfx")), s("{esc}")  ;CB.. rerun last CB submission                    
  esc & SC033::   DC("CommaAlias"), PU("CommaAlias reset to V") 
  esc & SC034::   DC("PeriodAlias"), PU("PeriodAlias reset to V")
    
                     
; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
; Hotkeys below are active if a Command or Function Box is the active window
    #IF WinActive("ahk_id " CB_hwnd)   
    <!space::     W("a"),RunCmd(GC("CommaAlias","V"))                           ;CB: paste mem_cache file m
    >!space::     W("a"),RunCmd(GC("PeriodAlias","V"))                          ;CB: paste mem_cache file                         
    esc::                                                                       ;CB: close command box
    ralt & SC027::     W("a"),s("{esc}")                                        ;CB: close command box
    +^k up::                                                                    ;CB: Font size decrease 
    ^SC00C::           goto, CBzoomOut                                          ;CB: Font size decrease
    +^j up::                                                                    ;CB: Font size increase 
    ^SC00D::           goto, CBzoomIn                                           ;CB: Font size increase
    !n::               Send !n                                                  ;CB: highlight next match of text in the CB display window with text entered in the input box
    +!n::              Send !p                                                  ;CB: highlight previous match of text in the CB display window with text entered in the input box
    !q::               MoveWin("TL")                                            ;CB: move CB window to top left
    !e::               MoveWin("TR")                                            ;CB: move CB window to top right
    !z::               MoveWin("BL")                                            ;CB: move CB window to bottom left
    !c::               MoveWin("BR")                                            ;CB: move CB window to bottom right
    !w::               MoveWin("T")                                             ;CB: move CB window to top half
    !s::               MoveWin("B")                                             ;CB: move CB window to bottom half
    #left::                                                                     ;CB: move CB window to left half
    !a::               MoveWin("L")                                             ;CB: move CB window to left half
    #right::                                                                    ;CB: move CB window to right half
    !d::               MoveWin("R")                                             ;CB: move CB window to right half
    +!a::              MoveWin("LS")                                            ;CB: move CB window to left side small
    +!d::              MoveWin("RS")                                            ;CB: move CB window to right side small
    +!w::              MoveWin("TS")                                            ;CB: move CB window to top half small
    +!s::              MoveWin("BS")                                            ;CB: move CB window to bottom half small
    <+!q::             MoveWin("L1")                                            ;CB: move CB window to top left f (portrait)
    >+!q::             MoveWin("L1v")                                           ;CB: move CB window to top left small (landscape)
    <+!e::             MoveWin("R1")                                            ;CB: move CB window to top right small (portrait)
    >+!e::             MoveWin("R1v")                                           ;CB: move CB window to top right small (landscape)
    <+!z::             MoveWin("L4")                                            ;CB: move CB window to bottom left small (portrait)
    >+!z::             MoveWin("L4v")                                           ;CB: move CB window to bottom left small (landscape)
    <+!c::             MoveWin("R4")                                            ;CB: move CB window to bottom right small (portrait)
    >+!c::             MoveWin("R4v")                                           ;CB: move CB window to bottom right small (landscape)
    ^!e::              MoveWin("R1s")                                           ;CB: move CB window to top right smallest 
    ^!q::              MoveWin("L1s")                                           ;CB: move CB window to top left smallest 
    ^!z::              MoveWin("L4s")                                           ;CB: move CB window to bottom left smallest
    ^!c::              MoveWin("R4s")                                           ;CB: move CB window to bottom right smallest
    lwin & space::     CB(GC("CB_sfx"),GC("CBw_color"))                         ;CB| submit user input
    rshift & enter::   W("rs"),Capitalize1stSubmit("rshift")                    ;CB| Capitalize first letter of user input, then submit
    $!b::              ToggleDisplay()                                          ;CB| toggle Command Box display|minimalist mode
    $!x::              ToggleDisplay()                                          ;CB| toggle Command Box display|minimalist mode
    !r::               GUIRecall()                                              ;CB| reenter last command
    !up::              SeePastEntries("U")
    !down::            SeePastEntries("D")
    ^enter::           AutoLinkLetter()                                         ;Shortcut for executing Link commands (auto insert capital U,W,B)
    ^1:: ProcessCommand("W",GC("CB_sfx"),GC("CBw_color"))
    ^2:: ProcessCommand("B",GC("CB_sfx"),GC("CBw_color"))
    ^3:: ProcessCommand("U",GC("CB_sfx"),GC("CBw_color"))

; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
; Hotkeys below are active if a Command Box exists

    #IF WinExist("ahk_id " CB_hwnd) 
    ;   rctrl & space::  GUIFocusInput("CB"), GC("CB_appActive", 0) ? s("{tab}"): "" ;CB| activate already open Command Box and move focus to inputbox    
    >^j::  GUIFocusInput("CB"),SI("^a")                                         ;CB| activate already open Command Box and move focus to inputbox 
  
#IF                                                                             ; end context dependent assignments