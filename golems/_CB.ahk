; COMMAND BOX __________________________________________________________________ 
; ACTIVE SYSTEM WIDE ______________________________________________________________
    #IF 
    lwin & space::        CB("~win")                                            ;CB.. opens command box that runs ~win suffix CB keys
    printscreen & space:: CB("~win")                                            ;CB.. opens command box that runs ~win suffix CB keys
    #enter::              RunCmd(,"~win")                                       ;CB.. selects word at text cursor position and run as CB "~win" key
                                                                                

    
    ^#r:: ProcessCommand(GC("last_user_input"),GC("CB_sfx"),GC("CB_clr"))       ;rerun last CB submission                    
    ^#e:: runLastLinkFn()                                                       ;rerun last link operation submission
    
    esc & space:: resetGUIposition()                                            ;reset gui position to default
    >^m::         ActivateApp(GC("CB_tgtExe")),CursorJump()                     ;CB| activate already open Command Box and move focus to inputbox
                                                                                
    >!SC027::                                                                   ;close CommandBox
        Sendinput {esc}
        GUI, 2: cancel                  
        return
                        
; ACTIVE IF COMMANDBOX IS THE ACTIVE WINDOW ____________________________________
  #IF WinActive("ahk_id " CB_hwnd) 


    <!space::      W("ra"),RunCmd("V" GC("CommaAlias",""))                      ;CB: paste mem_cache file
    >!space::      W("ra"),RunCmd("V" GC("PeriodAlias",""))                     ;CB: paste mem_cache file
    ~*esc::        GUI, 2: cancel                                               ;CB: close command box
    lalt & SC027:: GUI, 2: cancel                                               ;CB: close command box
    +^k up::                                                                    ;CB: Font size decrease
    ^SC00C::       goto, CBzoomOut                                              ;CB: Font size decrease
    +^j up::                                                                    ;CB: Font size increase
    ^SC00D::       goto, CBzoomIn                                               ;CB: Font size increase
    ^g::                                                                        ;CB: highlight next match of text in the CB display window with text entered in the input box
    !n::           Send !n                                                      ;CB: highlight next match of text in the CB display window with text entered in the input box
    +^g::                                                                       ;CB: highlight previous match of text in the CB display window with text entered in the input box
    +!n::          Send !p                                                      ;CB: highlight previous match of text in the CB display window with text entered in the input box
    ~^!space::     UpdateGUIRowHeight()                                         ; maximize CB Window
    
  ; gui/move size -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    <!q::                 MoveWin("TL")                                         ;CB: move CB window to top left
    !w::                  MoveWin("T")                                          ;CB: move CB window to top half
    <!e::                 MoveWin("TR")                                         ;CB: move CB window to top right
                                                                                
    <!z::                 MoveWin("BL")                                         ;CB: move CB window to bottom right
    <!s::                 MoveWin("B")                                          ;CB: move CB window to bottom half
    <!x::                 MoveWin("BR")                                         ;CB: move CB window to bottom left
                                                                                
    +!w::                 MoveWin("TS")                                         ;CB: move CB window to top half small
    +!s::                 MoveWin("BS")                                         ;CB: move CB window to bottom half small
                                                                                
    printscreen & left::                                                        ;CB: move CB window to left half
    lalt & a::                                                                  ;CB: move CB window to left half
    #left::               MoveWin("L")                                          ;CB: move CB window to left half
                                                                                
    printscreen & right::                                                       ;CB: move CB window to right half
    lalt & d::                                                                  ;CB: move CB window to right half
    #right::              MoveWin("R")                                          ;CB: move CB window to right half
                                                                                
    >!x::                 MoveWin("RL")                                         ;CB: move CB window to right side small
                                                                                
    #IF WinActive("ahk_id " CB_hwnd) && GetKeyState("lalt", "P")                ;
    shift & a::           MoveWin("LS")                                         ;CB: move CB window to left side small
    shift & d::           MoveWin("RS")                                         ;CB: move CB window to right side small
                                                                                
    #IF WinActive("ahk_id " CB_hwnd)                                            ;
    <+!q::                MoveWin("L1")                                         ;CB: move CB window to top left f (portrait)
    >+!q::                MoveWin("L1v")                                        ;CB: move CB window to top left small (landscape)
    ^!q::                 MoveWin("L1s")                                        ;CB: move CB window to top left smallest
                                                                                
    <+!e::                MoveWin("R1")                                         ;CB: move CB window to top right small (portrait)
    >+!e::                MoveWin("R1v")                                        ;CB: move CB window to top right small (landscape)
    ^!e::                 MoveWin("R1s")                                        ;CB: move CB window to top right smallest
                                                                                
    <+!x::                MoveWin("R4")                                         ;CB: move CB window to bottom right small (portrait)
    >+!x::                MoveWin("R4v")                                        ;CB: move CB window to bottom right small (landscape)
    ^!x::                 MoveWin("R4s")                                        ;CB: move CB window to bottom right smallest
                                                                                
    <+!z::                MoveWin("L4")                                         ;CB: move CB window to bottom left small (portrait)
    >+!z::                MoveWin("L4v")                                        ;CB: move CB window to bottom left small (landscape)
    ^!z::                 MoveWin("L4s")                                        ;CB: move CB window to bottom left smallest
                                                                                
    lwin & space::        CB(GC("CB_sfx"),GC("CB_clr"))                         ;CB| Open CB
    shift & enter::       W("rs"),Capitalize1stSubmit("shift")                  ;CB| Capitalize first letter of user input, then submit
    $!b::                 ToggleDisplay()                                       ;CB| toggle Command Box display|minimalist mode
    !r::                  GUIRecall()                                           ;CB| reenter last command
    !up::                 SeePastEntries("U")                                   ; cycle through past CB submissions
    !down::               SeePastEntries("D")                                   ; cycle through past CB submissions
                                                                                

  ; quick submit -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    ^space:: W("c"),SubmitLinkCommand(1)                                        ; Shortcut for executing mode/link commands, close CB after
    ^enter:: W("c"),SubmitLinkCommand()                                         ; Shortcut for executing mode/link commands
    +^L::    SubmitIB("L.")                                                     ; prepend "L" to current contents of input box and submit
    ^L::     SubmitIB("L")                                                      ; prepend "L" to current contents of input box and submit
    ^H::     SubmitIB("H",,1)                                                   ; prepend "H" to current contents of input box and submit
    >^A::    SubmitIB("A")                                                      ; prepend "A" to current contents of input box and submit
    +^A::    SubmitIB("A>")                                                     ; prepend "A>" to current contents of input box and submit
    ^P::     SubmitIB("P")                                                      ; prepend "P" to current contents of input box and submit
    +^P::    SubmitIB("P>")                                                     ; prepend "P>" to current contents of input box and submit
    ^O::     SubmitIB("O")                                                      ; prepend "O" to current contents of input box and submit
    +^O::    SubmitIB("O>")                                                     ; prepend "O>" to current contents of input box and submit
    <^E::    SubmitIB("E")                                                      ; prepend "E" to current contents of input box and submit
    >^E::    SubmitIB("E~")                                                     ; prepend "E~" to current contents of input box and submit
    ^D::     SubmitIB("D")                                                      ; prepend "D" to current contents of input box and submit
    ^S::     SubmitIB("S")                                                      ; prepend "S" to current contents of input box and submit
    ^R::     SubmitIB("R")                                                      ; prepend "R" to current contents of input box and submit
    +!R::    SubmitIB("F")                                                      ; prepend "F" to current contents of input box and submit
    ^u::     GotoLink(,,clip()),closeCB()                                       ; prepend "H" to current contents of input box and submit
                                                                                
  ; display file -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    ^0::                                                                        ; display corresponding mem file
    ^9::                                                                        ; display corresponding mem file
    ^8::                                                                        ; display corresponding mem file
    ^7::                                                                        ; display corresponding mem file
    ^6::                                                                        ; display corresponding mem file
    ^5::                                                                        ; display corresponding mem file
    ^4::                                                                        ; display corresponding mem file
    ^3::                                                                        ; display corresponding mem file
    ^2::                                                                        ; display corresponding mem file
    ^1:: ProcessCommand(substr(A_ThisHotkey,0)), ActivateWin("ahk_id " CB_hwnd) ; display corresponding mem file
                                                                                
    ctrl & sc029:: ProcessCommand("L#",GC("CB_sfx"),GC("CB_clr"))               ; number file overview
    ctrl & SC035:: ProcessCommand("?",GC("CB_sfx"),GC("CB_clr"))                ; help
  ; persistent, Appactive Ontop, Wrap -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    ^home::    ProcessCommand("Tp",GC("CB_sfx"),GC("CB_clr"))                   ;persistent
    ^del::     ProcessCommand("Tot",GC("CB_sfx"),GC("CB_clr"))                  ;always on top
    ^end::     ProcessCommand("Ta",GC("CB_sfx"),GC("CB_clr"))                   ;app active after CB submission
    ^insert::  ProcessCommand("Tw",GC("CB_sfx"),GC("CB_clr"))                   ;text wrap
    alt & F4:: Gui, 2: destroy                                                  ;destroy CB GUI
                                                                                

; ACTIVE IF USERINPUT BOX HAS FOCUS ____________________________________________
    #IF IsCMODE() AND (GetGUIFocus() == "UserInput")
    n::                                                                         ; send pgdn to CB display box
    down:: SendToCBdisplay("{pgdn}")                                            ; send pgdn to CB display box
    o::                                                                         ; send pgup to CB display box         
    up::   SendToCBdisplay("{pgup}")                                            ; send pgup to CB display box
                                                                                
    #IF (GetGUIFocus() == "UserInput") AND GetKeyState("lctrl", "P") 
    lalt & J:: SendToCBdisplay("^{end}")                                        ;Navigation: ctrl + home
    lalt & K:: SendToCBdisplay("^{home}")                                       ;Navigation: ctrl + end
                                                                                


; ACTIVE IF COMMAND BOX INSTANCE EXISTS ________________________________________
  ; CB paste, update CB display -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #IF WinExist("ahk_id " CB_hwnd)
    +^V::      SubmitIB("V",1)                                                  ; paste file currently entered in userinput box
    ~lbutton:: UpdateCBsfx()                                                    ; update CB suffix 
    ~<^c::     updateClipboardCBDisplay()                                       ;update clipboard contents if command box display
                                                                                
  ; display file -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

    #IF WinExist("ahk_id " CB_hwnd) && GetKeyState("lctrl", "P")
    lalt & SC034:: ProcessCommand("L|" GC("periodAlias",""),GC("CB_sfx"),GC("CB_clr")) ; 1st lines of alias folder files
    lalt & SC033:: ProcessCommand("L|" GC("commaAlias",""),GC("CB_sfx"),GC("CB_clr"))  ; 1st lines of alias folder files
                                                                                       
    #IF WinExist("ahk_id " CB_hwnd) && IsCmode()
    d:: ProcessCommand("L",GC("CB_sfx"),GC("CB_clr"))                           ; contents of number file & 1 char length text file names  
    s:: ProcessCommand("L@",GC("CB_sfx"),GC("CB_clr"))                          ; contents of number file & 1 char length text file names  
    a:: UpdateGUI(clipboard,"Clipboard Contents")                               ; clipboard contents

    #IF WinExist("ahk_id " CB_hwnd)
    <^>^0::                                                                     ; display corresponding mem file
    <^>^9::                                                                     ; display corresponding mem file
    <^>^8::                                                                     ; display corresponding mem file
    <^>^7::                                                                     ; display corresponding mem file
    <^>^6::                                                                     ; display corresponding mem file
    <^>^5::                                                                     ; display corresponding mem file
    <^>^4::                                                                     ; display corresponding mem file
    <^>^3::                                                                     ; display corresponding mem file
    <^>^2::                                                                     ; display corresponding mem file
    <^>^1::                                                                     ; display corresponding mem file
    <+>+0::                                                                     ; display corresponding mem file
    <+>+9::                                                                     ; display corresponding mem file
    <+>+8::                                                                     ; display corresponding mem file
    <+>+7::                                                                     ; display corresponding mem file
    <+>+6::                                                                     ; display corresponding mem file
    <+>+5::                                                                     ; display corresponding mem file
    <+>+4::                                                                     ; display corresponding mem file
    <+>+3::                                                                     ; display corresponding mem file
    <+>+2::                                                                     ; display corresponding mem file
    <+>+1::                                                                     ; display corresponding mem file
            ProcessCommand(substr(A_ThisHotkey,0),GC("CB_sfx"),GC("CB_clr"))    ; display corresponding mem file (will activate target app after)
            ActivateApp("Ahk_exe " GC("CB_tgtExe"))
            return

    #IF WinExist("ahk_id " CB_hwnd)
    
  ; activate hotkeys -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    >^k:: ChgFocus("DB"),CursorJump()                                           ;CB| activate already open Command Box and move focus to display box
    ^f::                                                                        ;CB| activate already open Command Box and move focus to input box
    >^j:: ChgFocus("IB"),SI("^a")                                               ;CB| activate already open Command Box and move focus to input box
                                                                                
                                                                                
    
  
#IF                                                                             ; end context dependent assignments