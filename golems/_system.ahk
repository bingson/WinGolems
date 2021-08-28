#IF
; CB SYSTEM COMMANDS ___________________________________________________________
  :X:b~win::    BluetoothSettings()                                             ;SC: bluetooth settings
  :X:d~win::    DisplaySettings()                                               ;SC: display settings
  :X:n~win::    NotificationWindow()                                            ;SC: notification window
  :X:v~win::    SoundSettings()                                                 ;SC: sound settings
  :X:r~win::    RunProgWindow()                                                 ;SC: run program
  :X:x~win::    StartContextMenu()                                              ;SC: context menu for the Start button
  :X:k~win::    QuickConnectWindow()                                            ;SC: quick connect window
  :X:i~win::    WindowsSettings()                                               ;SC: windows settings
  :X:p~win::    PresentationDisplayMode()                                       ;SC: presentation display mode
  :X:s~~win::   PowerOptions("sleep")                                           ;SC: enter sleep mode
  :X:h~~win::   PowerOptions("hybernate")                                       ;SC: enter hybernate mode
  :X:sd~~win::  PowerOptions("shutdown")                                        ;SC: shutdown + power down 
  :X:rs~~win::  PowerOptions("restart")                                         ;SC: restart the computer
  :X:a~win::    Run assets\win\Alarms & Clock.lnk                               ;SC: alarm clock
  :X:m~win::    sendEmail()                                                     ;SC: send mail
  :X:ce~~win::  CloseAllPrograms()                                              ;SC: close all open programs 
  :X:ss~win::   CloudSync("ON")                                                 ;SC: turn on cloud sync 
  :X:qs~win::   CloudSync("OFF")                                                ;SC: turn off cloud sync
  :X:lt~win::   WinLLock(True)                                                  ;SC: turn on win+L locks computer
  :X:lf~win::   WinLLock(False)                                                 ;SC: turn off win+L locks computer
  :X:ap~win::   Run assets\win\Add Remove Programs.lnk                          ;SC: open add remove programs 
  :X:s~win::    send ^{esc}                                                     ;SC: open start menu (alt: Ctrl+Esc)
  :X:mod~win::  MoveWindowToOtherDesktop()                                      ;SC: Move window to other desktop
  :X:de~win::   send #{tab}                                                     ;SC: desktop environment overview

; CB AHK UTILITIES _____________________________________________________________
  :X:wg~win::   LoadURL("https://github.com/bingson/wingolems")                 ;AHK: Load WinGolems GitHub Page
  :X:oc~win::   OpenFolder("mem_cache\")                                        ;AHK: open cache folder in file explorer
  :X:kh~win::   KeyHistory                                                      ;AHK: open key history
  :X:ws~win::   run, C:\Program Files\AutoHotkey\WindowSpy.ahk                  ;AHK: open windows spy
  :X:ec~win::   EditFile("""" config_path """")                                 ;AHK: edit config.ini file
  :X:tut~win::  loadURL("autohotkey.com/docs/Tutorial.htm")                     ;AHK: AHK beginner tutorial
  :X:tcf~win::  TglSetting("cursor_follow", "Cursor follows active window: ")   ;AHK: toggle mouse cursor follows active window
  ~+#left::                                                                     ;AHK: cursor follows active window when moving apps btn monitors (if turned on)
  ~+#right::                                                                    ;AHK: cursor follows active window when moving apps btn monitors (if turned on)
  ~!tab::       CursorFollowWin()                                               ;AHK: cursor follows active window when switch apps with alt+tab (if turned on)
  :X:clp~win::  WriteToINI(A_ComputerName, "CL_pfx")                            ;AHK: store selected text as label prefix
  :X:cls~win::  WriteToINI(A_ComputerName, "CL_sfx")                            ;AHK: store selected text as label suffix
  :X:cl~win::   CreateLabel("CL_pfx", "CL_sfx")                                 ;AHK: create hotstring label with execution option
  :X:!cl~win::  CreateLabel("!", "CL_sfx")                                      ;AHK: create normal label
  
  :X:gl~win::   GenerateHotkeyList()                                            ;AHK: generate a list of hotkeys in working directory.
  
  :X:q~~win::                                                                   ;AHK: quit ahk script
  +^#q::        ExitApp                                                         ;AHK: quit ahk script
  :X:r~~win::   Reload                                                          ;AHK: reload ahk script

  #^s::return                                                                   ;AHK: prevent windows speech recognition from popping up

; DEVELOPER OPTIONS ____________________________________________________________

  :X:td~win::                                                                   ;[T] toggle developer optns
    CC("T_d","!")
    CC("buffer_path","Z:\buffer")
    CC("hypersnap_path","C:\Users\bings\Downloads\Programs\HyperSnap 7\HprSnap7.exe")
    PopUp("Developer options on: " GC("T_d"))
    return
  

  #IF GC("T_d",0) ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    :*:date*::                                                                    ;Convenience: output current date
        FormatTime, CurrentDateTime,, MMMM dd, yyyy
        clip(CurrentDateTime)
        return 

    lwin & rctrl::                  ActivateWinID("Rctrl")                      ;SAW: activate saved Window ID
    #f::                            Clicks(2)                                   ;MF: 2 Left clicks (select word)
    ^#f::                           Clicks(3)                                   ;MF: 3 Left clicks (select line)
    #n::AA("editor_path")    
    #e::send ^{home}    
    #+e::send ^{end}    
    ralt & down::                   s("{blind}"), s("{F11}")                    ;Convenience: full screen {F11}

  #IF !WinActive("ahk_exe " exe["editor"]) and GC("T_d",0)                              ; If command Box active

  ^!d::             SelectLine(), s("^c"), s("right"), s("enter"), s("^v")      ;Convenience: duplicate line

  #IF WinActive("ahk_id " CB_hwnd) and GC("T_d",0)                              ; If command Box active
    printscreen & space::           GUISubmit()                                 ;CB: submit GUI input
  #If GetKeyState("ralt", "P") and GC("T_d",0)
    PrintScreen & k::               CursorJump("T")                             ;MF: move mouse cursor to top edge
    PrintScreen & j::               CursorJump("B",,"-20")                      ;MF: move mouse cursor to bottom edge
    PrintScreen & h::               CursorJump("L","20")                        ;MF: move mouse cursor to Left edge
    PrintScreen & l::               CursorJump("R","-40")                       ;MF: move mouse cursor to Right edge
   
  #If GetKeyState("PrintScreen", "P") and GC("T_d",0)

    !r:: RunProgWindow()                                                          ; run programs alternate shortcut
    ralt::          ActivateWinID("Lctrl")                                         ;SAW: activate saved Window ID
    rctrl::         ActivateWinID("Rctrl")                                         ;SAW: activate saved Window ID

    alt & lctrl::   SaveWinID("Lctrl")                                             ;SAW: (+ Alt) Save window ID for later activation 
    alt & rctrl::   SaveWinID("Rctrl")                                             ;SAW: (+ Alt) Save window ID for later activation 
    alt & q::       SaveWinID("Q")                                                 ;SAW: (+ Alt) Save window ID for later activation w/ alt & q
    alt & w::       SaveWinID("W")                                                 ;SAW: (+ Alt) Save window ID for later activation w/ alt & q
    alt & a::       SaveWinID("A")                                                 ;SAW: (+ Alt) Save window ID for later activation w/ alt & a
    alt & s::       SaveWinID("S")                                                 ;SAW: (+ Alt) Save window ID for later activation w/ alt & s
    alt & z::       SaveWinID("Z")                                                 ;SAW: (+ Alt) Save window ID for later activation w/ alt & z
    alt & x::       SaveWinID("X")                                                 ;SAW: (+ Alt) Save window ID for later activation w/ alt & x
    q::             ActivateWinID("Q")                                             ;SAW: activate saved Window ID
    w::             ActivateWinID("W")                                             ;SAW: activate saved Window ID
    a::             ActivateWinID("A")                                             ;SAW: activate saved Window ID
    s::             ActivateWinID("S")                                             ;SAW: activate saved Window ID
    z::             ActivateWinID("Z")                                             ;SAW: activate saved Window ID
    x::             ActivateWinID("X")                                             ;SAW: activate saved Window ID
   
    ralt & k::                      CursorJump("T")                             ;MF: move mouse cursor to top edge
    ralt & j::                      CursorJump("B",,"-20")                      ;MF: move mouse cursor to bottom edge
    ralt & h::                      CursorJump("L","20")                        ;MF: move mouse cursor to Left edge
    ralt & l::                      CursorJump("R","-40")                       ;MF: move mouse cursor to Right edge
    SC035::                         search()                                    ;C: google search selected text
    o::                             send ^{home}
    p::                             send ^{end}
    sc028::                         Click, Right                                ;MF: mouse Right click
    h::                             sendinput ^{Left 4}
    l::                             sendinput ^{Right 4}
    SC027::                         WinMinimize,A                               ;C: minimize window
    i::                             SaveMousPos("i",1)                          ;MF: Left click and save mouse position
    j::                             Sendinput {Blind}{WheelDown 5}              ;MF: scroll wheel down
    k::                             Sendinput {Blind}{WheelUp 5}                ;MF: scroll wheel Up
    b::  ActivateApp("explorer.exe", "buffer_path", True)                       ;AA: File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)


#IF
  /* 
    #IF GC("T_d",0) and WinActive("ahk_exe " exe["editor"]) ;-- -- -- -- -- -- -- 
    $^PgDn::             send +^!0                                              ; indent 1 space to left
    $^PgUp::             send +^!9                                              ; indent 1 space to right
 
                           
    :X:g~coding::        Send +^!g                                              ;V: git commit all
    :X:m>:: clip("msgbox % ")
    printscreen & tab::      AddSpaceBeforeComment("80")                        ;v: Add Space Before Comment (default)
    printscreen & capslock:: AddSpaceBeforeComment("80"), s("down")             ;v: Add Space Before Comment and move down 1 line (default)
    
    :X:it~coding::       send ^!+{F11}{4}{enter}                                ;v: indent using tabs
    :X:is~coding::       send ^!+{F12}{4}{enter}                                ;v: indent using spaces
    
    :X:L1~coding::       AddBorder("80", "_"  )                                 ;v: Add lvl 1 Border (default)
    :X:L2~coding::       AddBorder("80", "-- ")                                 ;v: Add lvl 2 Border (default)
    :X:L3~coding::       AddBorder("80", "... ")                                ;v: Add lvl 3 Border (default)  

    printscreen & space::
    #space::             CB("~coding", C.lgreen)                                ; CB("~coding", lgreen)
    
    $+^sc028::           FocusResults()                                         ; move focus to search results
    :X:sa~coding::       Send +^!s                                              ; save as
    $^+sc027::           send +!^c                                              ; collapse search results
    $<+Space::                                                                  ; indent 1 space to left
       send +{right}
       send +{space}{left}
       return
    $>+Space::           Send ^!+i                                              ; indent 1 space to right
    
    :X:cfg~coding::      send {F9}                                              ;V: settings.json
    ^tab::               Send % (toggle := !toggle) ? "^1" : "^2"               ;V: fold/unfold all regions toggle
    !s::                 send ^{F3}                                             ;V: move to next instance of selected text 
    +^y::                +^u                                                    ;V: output console
    +^!r::               send {F2}                                              ;V: rename (F2)
    
    +>!j::
    +!^j::               send +!^{down}                                         ;V: create multicursor instance below
    +>!k::
    +!^k::               send +!^{up}                                           ;V: create multicursor instance above
    
    +!Right::            send !t                                                ;V: move to group 1
    +!Left::             send +!1                                               ;V: move to group 2
    >^m::                send ^c                                                ;V: right handed copy
    <^m::                send ^m                                                ;V: toggle tab moves focus
    +^!o::               send +^u                                               ;V: toggle output window
    !d::                 send +^k                                               ;V: delete line
    ^!d::                send +!{down}                                          ;V: duplicate line
    +^d::                send +^l                                               ;V: Select all occurrences of current selection
    ^!sc01a::            Send % (toggle := !toggle) ? "^k^9" : "^k^8"           ;V: fold/unfold all regions toggle
    >^f::                                                                       ;NAV: search all files in folder
    :X:f~coding::        send +^f                                               ;NAV: search all files in folder
    :X:h~coding::                                                               ;NAV: search & replace all files in folder (+subdirectories)
    +^!f::               Send +^h                                               ;NAV: search & replace all files in folder
    $>!f::                                                                      ;V: move focus to search results
                         send +^f
                         sleep med
                         send ^{down 3}
                         return  

    ^!sc035::            Send % (toggle := !toggle) ? "^k^0" : "^k^j"           ;V: fold/unfold all code toggle
    ^q::                 Send ^{sc035}                                          ;V: toggle comment
    ^sc035::             send +^{[}                                             ;V: fold current code level
    !sc035::             send +^{]}                                             ;V: unfold current code level
    +^sc035::            send ^k^[                                              ;V: fold recursively 
    +!sc035::            send ^k^]                                              ;V: unfold recursively
    >+^enter::           send ^kz                                               ;V: zen mode
    !p::                 send ^w                                                ;V: close tab
    !g::                 send +!{Right}                                         ;V: select all text in between brackets
    :X:c~~coding::       Send +^!g                                              ;V: git commit all
   
    :X:nb~coding::
    :X:ca~coding::
                         send +^!p                                                 
                         send ^!k
                         PopUp("Clear bookmarks`nAdd bookmark",C.lgreen)
                         return
      
    :X:ab~coding::       
    :X:b~coding::       
                         send ^!k
                         PopUp("Add/remove bookmark",C.lgreen)
                         return
    cb~coding:
    F1 & k::                                                                    ;V: clear all bookmarks
                         send +^!p                                                 
                         PopUp("Clear bookmarks",C.lblue)
                         return
    +^g::                                                                       ;V: source control 
                          ;ReleaseModifiers()
                         send +^g
                         send g
                         return
   
    +!0::                                                                       ;V: fold code to level 0
    +!1::                                                                       ;V: fold code to level 1
    +!2::                                                                       ;V: fold code to level 2
    +!3::                                                                       ;V: fold code to level 3
    +!4::                                                                       ;V: fold code to level 4
    +!5::                                                                       ;V: fold code to level 5
    +!6::                                                                       ;V: fold code to level 6
    codefolding() {
       send ^k
       send {ctrl down}
       send % substr(A_ThisHotkey, 0)                                              
       send {ctrl up}
       return
    }
   
    ; swap ^ for !
    ^1::                                                                           
    ^2::                                                                           
    ^3::                                                                           
    ^4::                                                                           
    ^5::                                                                           
    ^6::                                                                           
    ^7::                                                                           
    ^8::                                                                           
    ^9::                                                                           
    ^0:: send % "!" . substr(A_ThisHotkey, 0)                                   ;v: activate tab # 
    
    !1::                                                                           
    !2::                                                                           
    !3:: send % "^" . substr(A_ThisHotkey, 0)   
 */
