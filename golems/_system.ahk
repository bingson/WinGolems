#IfWinActive
  
  #space:: CB("~win")                                                           ; opens command box that runs ~win suffix CB keys

; CB hotkey assignment _________________________________________________________; shared by all Command Boxes 

  #IF WinActive("ahk_id " ghwnd) or TitleTest("(-_-)")                          ; If command Box active

  !q::          MoveWin("TL")                                                   ; move CB window to top left
  !e::          MoveWin("TR")                                                   ; move CB window to top right
  !z::          MoveWin("BL")                                                   ; move CB window to bottom left
  !c::          MoveWin("BR")                                                   ; move CB window to bottom right
  !w::          MoveWin("T")                                                    ; move CB window to top half
  !s::          MoveWin("B")                                                    ; move CB window to bottom half
  #left::                                                                       ; move CB window to left half
  !a::          MoveWin("L")                                                    ; move CB window to left half
  #right::                                                                      ; move CB window to right half
  !d::          MoveWin("R")                                                    ; move CB window to right half
  #space::      GUISubmit()                                                     ; submit GUI input 
  $!x::         ToggleDisplay()                                                 ; toggle Command Box display/minimalist mode
  !r::          GUIRecall()                                                     ; reenter last command

  #IF WinExist("ahk_id " ghwnd) and !WinActive("ahk_id " ghwnd)                 ; If command Box exists
  
  $<^space::                                                                    ; activate CB if exists and move focus to inputbox
  $>^space:: ActivateWin("ahk_id " ghwnd)                                       ; activate CB if exists and move focus to inputbox

  #IF                                                                           ; end context specific assignments

; CB key assignment: System Commands ___________________________________________

  :X:b~win::    BluetoothSettings()                                             ;[SC] bluetooth settings
  :X:d~win::    DisplaySettings()                                               ;[SC] display settings
  :X:n~win::    NotificationWindow()                                            ;[SC] notification window
  :X:v~win::    SoundSettings()                                                 ;[SC] sound settings
  :X:r~win::    RunProgWindow()                                                 ;[SC] run program
  :X:x~win::    StartContextMenu()                                              ;[SC] context menu for the Start button
  :X:k~win::    QuickConnectWindow()                                            ;[SC] quick connect window
  :X:i~win::    WindowsSettings()                                               ;[SC] windows settings
  :X:p~win::    PresentationDisplayMode()                                       ;[SC] presentation display mode
  :X:s~~win::   PowerOptions("sleep")                                           ;[SC] enter sleep mode
  :X:h~~win::   PowerOptions("hybernate")                                       ;[SC] enter hybernate mode
  :X:sd~~win::  PowerOptions("shutdown")                                        ;[SC] shutdown + power down 
  :X:rs~~win::  PowerOptions("restart")                                         ;[SC] restart the computer
  :X:a~win::    Run assets\win\Alarms & Clock.lnk                               ;[SC] alarm clock
  :X:m~win::    sendEmail()                                                     ;[SC] send mail
  :X:ce~~win::  CloseAllPrograms()                                              ;[SC] close all open programs 
  :X:ss~win::   CloudSync("ON")                                                 ;[SC] turn on cloud sync 
  :X:qs~win::   CloudSync("OFF")                                                ;[SC] turn off cloud sync
  :X:lt~win::   WinLLock(True)                                                  ;[SC] turn on win+L locks computer
  :X:lf~win::   WinLLock(False)                                                 ;[SC] turn off win+L locks computer
  :X:ap~win::   Run assets\win\Add Remove Programs.lnk                          ;[SC] open add remove programs 
   #Lbutton::
   $^#Enter::                                                                   ;[SC] open start menu (alt: Ctrl+Esc)
  :X:s~win::    send ^{esc}                                                     ;[SC] open start menu (alt: Ctrl+Esc)
  :X:mod~win::  MoveWindowToOtherDesktop()                                      ;[SC] Move window to other desktop
  :X:de~win::   send #{tab}                                                     ;[SC] desktop environment overview

; CB keys assignment: AHK UTILITIES ____________________________________________  

  :X:ec~win::   OpenFolder("mem_cache\")                                        ;[AHK] open cache folder in file explorer
  :X:kh~win::   KeyHistory                                                      ;[AHK] open key history
  :X:ws~win::   run, C:\Program Files\AutoHotkey\WindowSpy.ahk                  ;[AHK] open windows spy
  :X:ci~win::   EditFile("""" config_path """")                                 ;[AHK] edit config.ini file
  :X:tut~win::  loadURL("autohotkey.com/docs/Tutorial.htm")                     ;[AHK] AHK beginner tutorial
  :X:cf~win::   TglSetting("cursor_follow", "Cursor follows active window: ")   ;[AHK] toggle mouse cursor follows active window
  ~+#left::                                                                     ;[AHK] cursor follows active window when moving apps btn monitors (if turned on)
  ~!tab::       CursorFollowWin()                                               ;[AHK] cursor follows active window when switch apps with alt+tab (if turned on)
  :X:clp~win::  WriteToINI(A_ComputerName, "CL_prfx")                           ;[AHK] store selected text as label prefix
  :X:cls~win::  WriteToINI(A_ComputerName, "CL_sffx")                           ;[AHK] store selected text as label suffix
  :X:cl~win::   CreateLabel("CL_prfx", "CL_sffx")                               ;[AHK] create hotstring label with execution option
  :X:!cl~win::  CreateLabel("!", "CL_sffx")                                     ;[AHK] create normal label
  :X:gl~win::   GenerateHotkeyList()                                            ;[AHK] generate a list of hotkeys in working directory.
  :X:ls~win::   EditFile("HotKey_List.txt")                                     ;[AHK] open last generated list of hotstrings and hotkeys
  :X:q~~win::                                                                   ;[AHK] quit ahk script
  +^#q::        ExitApp                                                         ;[AHK] quit ahk script
                                                                     
  lshift & rshift::                                                             ;[AHK] reload ahk script
  rshift & lshift::                                                             ;[AHK] reload ahk script
  :X:r~~win::   Reload                                                          ;[AHK] reload ahk script

; developer options ____________________________________________________________
  
  :X:td~win::                                                                   ;[T] toggle text navigation and selection hotkeys
    CC("T_d","!")
    ShowPopup("Developer options on: " GC("T_d"))
    return

  #IF GC("T_d",0) and WinActive("ahk_exe " exe["editor"])
                           
  :X:c~~coding::       Send +^!g                                                ;[VSC] git commit all
  :X:m>:: clip("msgbox % ")
  printscreen & tab::      AddSpaceBeforeComment("80")                          ;[FC] Add Space Before Comment (default)
  printscreen & capslock:: AddSpaceBeforeComment("80"), s("down")               ;[FC] Add Space Before Comment and move down 1 line (default)
  
  :X:it~coding::           send ^!+{F11}{4}{enter}                              ;[FC] indent using tabs
  :X:is~coding::           send ^!+{F12}{4}{enter}                              ;[FC] indent using spaces
 
  :X:L1~coding::           AddBorder("80", "_"  )                          ;[FC] Add lvl 1 Border (default)
  :X:L2~coding::           AddBorder("80", "-- ")                          ;[FC] Add lvl 2 Border (default)
  :X:L3~coding::           AddBorder("80", "... ")                        ;[FC] Add lvl 3 Border (default)

  $+#space::                                                                     ; CB("~coding", lgreen)
  ~*$#enter::
  #space::             CB("~coding", C.lgreen)                                   ; CB("~coding", lgreen)
  
  $+^sc028::           FocusResults()                                            ; move focus to search results
  :X:sa~coding::       Send +^!s                                                 ; save as
  $^+sc027::           send +!^c                                                 ; collapse search results
  $<+Space::                                                                     ; indent 1 space to left
     send +{right}
     send +{space}{left}
     return
  $>+Space::           Send ^!+i                                                 ; indent 1 space to right
  
  :X:cfg~coding::      send {F9}                                                 ;[VSC] settings.json
  ^tab::               Send % (toggle := !toggle) ? "^1" : "^2"                  ;[VSC] fold/unfold all regions toggle
  !s::                 send ^{F3}                                                ;[VSC] move to next instance of selected text 
  +^y::                +^u                                                       ;[VSC] output console
  +^!r::               send {F2}                                                 ;[VSC] rename (F2)
  
  +>!j::
  +!^j::               send +!^{down}                                            ;[VSC] create multicursor instance below
  +>!k::
  +!^k::               send +!^{up}                                              ;[VSC] create multicursor instance above
  
  !o::                 send !0                                                   ;[VSC] open last editor in group
  +!Right::            send !t                                                   ;[VSC] move to group 1
  +!Left::             send +!1                                                  ;[VSC] move to group 2
  >^m::                send ^c                                                   ;[VSC] toggle tab moves focus
  <^m::                send ^m                                                   ;[VSC] toggle tab moves focus
  +^!o::               send +^u                                                  ;[VSC] toggle output window
  !d::                 send +^k                                                  ;[VSC] delete line
  ^!d::                send +!{down}                                             ;[VSC] duplicate line
  +^d::                send +^l                                                  ;[VSC] Select all occurrences of current selection
  ^!sc01a::            Send % (toggle := !toggle) ? "^k^9" : "^k^8"              ;[VSC] fold/unfold all regions toggle
  >^f::                                                                          ;NAV| search all files in folder
  :X:f~coding::        send +^f                                                  ;NAV| search all files in folder
  :X:h~coding::                                                                  ;NAV| search & replace all files in folder (+subdirectories)
  +^!f::               Send +^h                                                  ;NAV| search & replace all files in folder
  $>!f::                                                                         ;[VSC] move focus to search results
                       send +^f
                       sleep med
                       send ^{down 3}
                       return
  ^!sc035::            Send % (toggle := !toggle) ? "^k^0" : "^k^j"              ;[VSC] fold/unfold all code toggle
  ^q::                 Send ^{sc035}                                             ;[VSC] toggle comment
  ^sc035::             send +^{[}                                                ;[VSC] fold current code level
  !sc035::             send +^{]}                                                ;[VSC] unfold current code level
  +^sc035::            send ^k^[                                                 ;[VSC] fold recursively 
  +!sc035::            send ^k^]                                                 ;[VSC] unfold recursively
  >+^enter::           send ^kz                                                  ;[VSC] zen mode
  !p::                 send ^w                                                   ;[VSC] close tab
  !g::                 send +!{Right}                                            ;[VSC] select all text in between brackets
  :X:c~~coding::       Send +^!g                                                 ;[VSC] git commit all
 
  :X:nb~coding::
  :X:ca~coding::
     send +^!p                                                 
     send ^!k
     ShowPopUp("Clear bookmarks`nAdd bookmark",C.lgreen)
     return
     
  :X:ab~coding::       
  :X:b~coding::       
     send ^!k
     ShowPopUp("Add/remove bookmark",C.lgreen)
     return
  cb~coding:
  F1 & k::                                                                       ;[VSC] clear all bookmarks
     send +^!p                                                 
     ShowPopUp("Clear bookmarks",C.lblue)
     return
  +^g::                                                                      ;[VSC] source control 
     ;ReleaseModifiers()
     send +^g
     send g
     return
 
  +!0::                                                                          ;[VSC] fold code to level 0
  +!1::                                                                          ;[VSC] fold code to level 1
  +!2::                                                                          ;[VSC] fold code to level 2
  +!3::                                                                          ;[VSC] fold code to level 3
  +!4::                                                                          ;[VSC] fold code to level 4
  +!5::                                                                          ;[VSC] fold code to level 5
  +!6::                                                                          ;[VSC] fold code to level 6
  codefolding() {
     send ^k
     send {ctrl down}
     send % substr(A_ThisHotkey, 0)                                              
     send {ctrl up}
     return
  }
 
  ; swap ^ for !... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... 
   ^1::                                                                           
   ^2::                                                                           
   ^3::                                                                           
   ^4::                                                                           
   ^5::                                                                           
   ^6::                                                                           
   ^7::                                                                           
   ^8::                                                                           
   ^9::                                                                           
   ^0:: send % "!" . substr(A_ThisHotkey, 0)                                     ;[FC] activate tab # 
   
   !1::                                                                           
   !2::                                                                           
   !3:: send % "^" . substr(A_ThisHotkey, 0)                                     ;[FC] activate editor group #
