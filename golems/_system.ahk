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
  :X:de~win::   send #{tab}                                                     ;SC: desktop environment overview

  :X:tm~win::                                                                   ;MAW: open task manager with hotstring combines with max + cursor follows task manager window
                send +^{esc}                                                    ;     TskMgrExt() will be executed after
  ~+^esc::      TskMgrExt()                                                     ;MAW: maximize + mouse cursor follows window after task manager opens


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

  :X:td~win:: CC("T_d","!"), PU("Developer options on: " GC("T_d"))                                                                  ;[T] toggle developer optns
  
  #IF GC("T_d",0) ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    *#d::                           SaveMousPos("r",1)                          ;MouseFn: Left click and save mouse position
    *^#d::                          RecallMousePosClick("r")                    ;MouseFn: Move to saved mouse position and left click
    *#i::                           SaveMousPos("i",1)                          ;MouseFn: Left click and save mouse position
    *^#i::                          RecallMousePosClick("i")                    ;MouseFn: Move to saved mouse position and left click
    #o::                            Click, middle                               ;MouseFn: mouse middle click
    PrintScreen & sc028::                                                       ;MouseFn: mouse Right click
    #sc028::                        Click, Right                                ;MouseFn: mouse Right click
    ^!Lbutton::                     Clicks(2), s("^v")                          ;MouseFn: click twice, paste clipboard
    +^Lbutton::                     Clicks(3), s("^v")                          ;MouseFn: click thrice, paste clipboard
    >+esc::                         EditFile("golems\_system.ahk")              ;Convenience: open _system.ahk
    ^#w::                           WinClose,A                                  ;Convenience: close active window
    ^#q::                           CloseClass()                                ;Convenience: close all instances of the active program
    *printscreen::                  Send {Blind}{LWin Down}                     ;Convenience:1 makes windows key inert so it can act as a modifier key
    printscreen Up::                Send {Blind}{vk00}{LWin Up}                 ;Convenience:1 makes windows key inert so it can act as a modifier key
    lwin & rctrl::                  ActivateWinID("Rctrl")                      ;ActvateApp: activate saved Window ID
    #f::                            Clicks(2)                                   ;MouseFunctions: 2 Left clicks (select word)
    ^#f::                           Clicks(3)                                   ;MouseFunctions: 3 Left clicks (select line)
    #n::                            AA("editor_path")                           ;Convenience: 
    #e::                            send ^{home}    
    #+e::                           send ^{end}    
    ralt & right::                  s("{blind}"), s("{F11}")                    ;Convenience: full screen {F11}
    >+>!o::
    :X:mod~win::  MoveWindowToOtherDesktop()                                    ;SC: Move window to other desktop
  #IF !WinActive("ahk_exe " exe["editor"]) and GC("T_d",0) ; -- -- -- -- -- -- -; EDITOR ACTIVE
    ^!d::             SelectLine(), s("^c"), s("right"), s("enter"), s("^v")    ;Convenience: duplicate line
  #IF WinActive("ahk_id " CB_hwnd) and GC("T_d",0)                              ; If command Box active
    printscreen & space::           GUISubmit()                                 ;CB: submit user input
  #If GetKeyState("ralt", "P") and GC("T_d",0)
    PrintScreen & k::               CursorJump("T")                             ;MouseFunctions: move mouse cursor to top edge
    PrintScreen & j::               CursorJump("B",,"-20")                      ;MouseFunctions: move mouse cursor to bottom edge
    PrintScreen & h::               CursorJump("L","20")                        ;MouseFunctions: move mouse cursor to Left edge
    PrintScreen & l::               CursorJump("R","-40")                       ;MouseFunctions: move mouse cursor to Right edge
  #If GC("T_d",0)
    printscreen & 0::                                                           ;Memory (+rshift): add selected text to the bottom of 0.txt (press rshift before ralt => no cursor centering)
    printscreen & 9::                                                           ;Memory (+rshift): add selected text to the bottom of 9.txt
    printscreen & 8::                                                           ;Memory (+rshift): add selected text to the bottom of 8.txt
    printscreen & 7::                                                           ;Memory (+rshift): add selected text to the bottom of 7.txt
    printscreen & 6::                                                           ;Memory (+rshift): add selected text to the bottom of 6.txt
    printscreen & 5::                                                           ;Memory (+rshift): add selected text to the bottom of 5.txt
    printscreen & 4::                                                           ;Memory (+rshift): add selected text to the bottom of 4.txt
    printscreen & 3::                                                           ;Memory (+rshift): add selected text to the bottom of 3.txt
    printscreen & 2::                                                           ;Memory (+rshift): add selected text to the bottom of 2.txt
    printscreen & 1::                      AddToMemory()                        ;Memory (+rshift): add selected text to the bottom of 1.txt
  #If GetKeyState("PrintScreen", "P") and GC("T_d",0)
    lctrl::                                                                     ;ActvateApp: activate saved Window ID
    ralt::                          ActivateWinID("Lctrl")                      ;ActvateApp: activate saved Window ID
    rctrl::                         ActivateWinID("Rctrl")                      ;ActvateApp: activate saved Window ID
    alt & lctrl::                   SaveWinID("Lctrl")                          ;ActvateApp (+ Alt): Save window ID for later activation 
    alt & rctrl::                   SaveWinID("Rctrl")                          ;ActvateApp (+ Alt): Save window ID for later activation 
    alt & q::                       SaveWinID("Q")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & q
    alt & w::                       SaveWinID("W")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & q
    alt & a::                       SaveWinID("A")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & a
    alt & s::                       SaveWinID("S")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & s
    alt & z::                       SaveWinID("Z")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & z
    alt & x::                       SaveWinID("X")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & x
    q::                             ActivateWinID("Q")                          ;ActvateApp: activate saved Window ID
    w::                             ActivateWinID("W")                          ;ActvateApp: activate saved Window ID
    a::                             ActivateWinID("A")                          ;ActvateApp: activate saved Window ID
    s::                             ActivateWinID("S")                          ;ActvateApp: activate saved Window ID
    z::                             ActivateWinID("Z")                          ;ActvateApp: activate saved Window ID
    x::                             ActivateWinID("X")                          ;ActvateApp: activate saved Window ID
    ralt & k::                      CursorJump("T")                             ;MouseFunctions: move mouse cursor to top edge
    ralt & j::                      CursorJump("B",,"-20")                      ;MouseFunctions: move mouse cursor to bottom edge
    ralt & h::                      CursorJump("L","20")                        ;MouseFunctions: move mouse cursor to Left edge
    ralt & l::                      CursorJump("R","-40")                       ;MouseFunctions: move mouse cursor to Right edge
    sc028::                         Click, Right                                ;MouseFunctions: mouse Right click
    !r::                            RunProgWindow()                             ;convenience: run programs alternate shortcut
    SC035::                         search()                                    ;Convenience: google search selected text
    o::                             send ^{home}                                ;Convenience: ctrl+home
    p::                             send ^{end}                                 ;Convenience: ctrl+end
    SC027::                         WinMinimize,A                               ;Convenience: minimize window
    h::                             sendinput ^{Left 4}                         ;TextNavigation: jump left 4 words (ctrl+left x 4)
    l::                             sendinput ^{Right 4}                        ;TextNavigation: jump right 4 words (ctrl+right x 4)
    i::                             SaveMousPos("i",1)                          ;MouseFunctions: Left click and save mouse position
    j::                             Sendinput {Blind}{WheelDown 5}              ;MouseFunctions: scroll wheel down
    k::                             Sendinput {Blind}{WheelUp 5}                ;MouseFunctions: scroll wheel Up
    b::                             AA("explorer.exe", "buffer_path", True)     ;AA: File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
#IF
  