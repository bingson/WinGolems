#IfWinActive

; #v:: msgbox % winpath "\system32"

; CB hotkey assignment _________________________________________________________; shared by all Command Boxes 

  #IF WinActive("ahk_id " ghwnd) or TitleTest("(-_-)")                          ; If command Box active

  !q::          MoveWin("TL")                                                   ;MW: move CB window to top left
  !e::          MoveWin("TR")                                                   ;MW: move CB window to top right
  !z::          MoveWin("BL")                                                   ;MW: move CB window to bottom left
  !c::          MoveWin("BR")                                                   ;MW: move CB window to bottom right
  !w::          MoveWin("T")                                                    ;MW: move CB window to top half
  !s::          MoveWin("B")                                                    ;MW: move CB window to bottom half
  #left::                                                                       ;MW: move CB window to left half
  !a::          MoveWin("L")                                                    ;MW: move CB window to left half
  #right::                                                                      ;MW: move CB window to right half
  !d::          MoveWin("R")                                                    ;MW: move CB window to right half
  #space::      GUISubmit()                                                     ;MW: submit GUI input 
  $!x::         ToggleDisplay()                                                 ;MW: toggle Command Box display/minimalist mode
  !r::          GUIRecall()                                                     ;MW: reenter last command

  #IF WinExist("ahk_id " ghwnd) and !WinActive("ahk_id " ghwnd)                 ; If command Box exists
  
  $<^space::                                                                    ; activate CB if exists and move focus to inputbox
  $>^space:: ActivateWin("ahk_id " ghwnd)                                       ; activate CB if exists and move focus to inputbox

  #IF                                                                           ; end context specific assignments

; CB key assignment: System Commands ___________________________________________
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
   #Lbutton::                                                                   ;SC: open start menu (alt: Ctrl+Esc)
   $^#Enter::                                                                   ;SC: open start menu (alt: Ctrl+Esc)
  :X:s~win::    send ^{esc}                                                     ;SC: open start menu (alt: Ctrl+Esc)
  :X:mod~win::  MoveWindowToOtherDesktop()                                      ;SC: Move window to other desktop
  :X:de~win::   send #{tab}                                                     ;SC: desktop environment overview

; CB keys assignment: AHK UTILITIES ____________________________________________  

  :X:oc~win::   OpenFolder("mem_cache\")                                        ;AHK: open cache folder in file explorer
  :X:kh~win::   KeyHistory                                                      ;AHK: open key history
  :X:ws~win::   run, C:\Program Files\AutoHotkey\WindowSpy.ahk                  ;AHK: open windows spy
  :X:ec~win::   EditFile("""" config_path """")                                 ;AHK: edit config.ini file
  :X:tut~win::  loadURL("autohotkey.com/docs/Tutorial.htm")                     ;AHK: AHK beginner tutorial
  :X:tcf~win::   TglSetting("cursor_follow", "Cursor follows active window: ")  ;AHK: toggle mouse cursor follows active window
  ~+#left::                                                                     ;AHK: cursor follows active window when moving apps btn monitors (if turned on)
  ~+#right::                                                                    ;AHK: cursor follows active window when moving apps btn monitors (if turned on)
  ~!tab::       CursorFollowWin()                                               ;AHK: cursor follows active window when switch apps with alt+tab (if turned on)
  :X:clp~win::  WriteToINI(A_ComputerName, "CL_prfx")                           ;AHK: store selected text as label prefix
  :X:cls~win::  WriteToINI(A_ComputerName, "CL_sffx")                           ;AHK: store selected text as label suffix
  :X:cl~win::   CreateLabel("CL_prfx", "CL_sffx")                               ;AHK: create hotstring label with execution option
  :X:!cl~win::  CreateLabel("!", "CL_sffx")                                     ;AHK: create normal label
  
  :X:gl~win::   GenerateHotkeyList()                                           ;AHK: generate a list of hotkeys in working directory.
  
  :X:q~~win::                                                                   ;AHK: quit ahk script
  +^#q::        ExitApp                                                         ;AHK: quit ahk script
  lshift & rshift::                                                             ;AHK: reload ahk script
  rshift & lshift::                                                             ;AHK: reload ahk script
  :X:r~~win::   Reload                                                          ;AHK: reload ahk script

; developer options ____________________________________________________________
  
  :X:td~win::                                                                   ;[T] toggle developer optns
    CC("T_d","!")
    CC("buffer_path","Z:\buffer")
    CC("hypersnap_path","C:\Users\bings\Downloads\Programs\HyperSnap 7\HprSnap7.exe")
    PopUp("Developer options on: " GC("T_d"))
    return

  printscreen & b::  ActivateApp("explorer.exe", "buffer_path", True)                   ;AA: File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
    
  

  #IF GC("T_d",0) ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    printscreen & b:: activateapp("explorer.exe")
    printscreen & SC035::           search()                                    ;C: google search selected text
    #n::AA("editor_path")
    #e::send ^{home}
    #+e::send ^{end}
    PrintScreen & h:: sendinput ^{Left 4}
    PrintScreen & l:: sendinput ^{Right 4}
    PrintScreen & SC027::       WinMinimize,A                                   ;C: minimize window
  

    ; MOUSE (CURSOR) FUNCTIONS... ... ... ... ... ... ... ... ... ... ... ... ... 
    ; mouse functions with keyboard shortcuts  

    ^!Lbutton:: Clicks(2), s("^v")                                          ;MF: click twice, paste clipboard
    +^Lbutton:: Clicks(3), s("^v")                                          ;MF: click thrice, paste clipboard
    
    $^!j::                          Sendinput ^{sc00D}                      ;MF: zoom in
    $^!k::                          Sendinput ^{sc00C}                      ;MF: zoom out
    
    #j::                            Sendinput {Blind}{WheelDown 2}          ;MF: scroll wheel down
    #k::                            Sendinput {Blind}{WheelUp 2}            ;MF: scroll wheel Up
    printscreen & j::               Sendinput {Blind}{WheelDown 5}          ;MF: scroll wheel down
    printscreen & k::               Sendinput {Blind}{WheelUp 5}            ;MF: scroll wheel Up
    
    $#>!h::                         Sendinput {Blind}{Wheelleft 6}          ;MF: scroll wheel left
    $#>!l::                         Sendinput {Blind}{WheelRight 6}         ;MF: scroll wheel right
    
    #f::                            Clicks(2)                               ;MF: 2 Left clicks (select word)
    ^#f::                           Clicks(3)                               ;MF: 3 Left clicks (select line)
    PrintScreen & o::                                                       ;MF: mouse middle click
    #o::                            Click, middle                           ;MF: mouse middle click
    ; PrintScreen & sc028::                                                   ;MF: mouse Right click
    ; #sc028::                        Click, Right                            ;MF: mouse Right click
    
    #If GetKeyState("lctrl", "P") 
    lalt & rshift::                                                         ;MF: (+lctrl) move mouse cursor to center
    #If

    ~rctrl & ~lctrl::               CursorJump("TL")                        ;MF: move mouse cursor to TOP    LEFT   of active app
    ~lctrl & ~rctrl::               CursorJump("TR")                        ;MF: move mouse cursor to TOP    RIGHT  of active app
    ralt & lalt::                   CursorJump("BL")                        ;MF: move mouse cursor to BOTTOM LEFT   of active app
    lalt & ralt::                   CursorJump("BR")                        ;MF: move mouse cursor to BOTTOM RIGHT  of active app
    
    #If GetKeyState("ralt", "P")
    PrintScreen & k::               CursorJump("T")                         ;MF: move mouse cursor to top edge
    PrintScreen & j::               CursorJump("B",,"-20")                  ;MF: move mouse cursor to bottom edge
    PrintScreen & h::               CursorJump("L","20")                    ;MF: move mouse cursor to Left edge
    PrintScreen & l::               CursorJump("R","-40")                   ;MF: move mouse cursor to Right edge
    #If
    
    $!#k::                          CursorJump("T")                         ;MF: move mouse cursor to top edge
    $!#j::                          CursorJump("B",,"-20")                  ;MF: move mouse cursor to bottom edge
    $!#h::                          CursorJump("L","20")                    ;MF: move mouse cursor to Left edge
    $!#l::                          CursorJump("R","-40")                   ;MF: move mouse cursor to Right edge
        
  #IF GC("T_d",0) and WinActive("ahk_exe " exe["editor"]) ;-- -- -- -- -- -- -- 
                           
    :X:c~~coding::       Send +^!g                                              ;V: git commit all
    :X:m>:: clip("msgbox % ")
    printscreen & tab::      AddSpaceBeforeComment("80")                        ;v: Add Space Before Comment (default)
    printscreen & capslock:: AddSpaceBeforeComment("80"), s("down")             ;v: Add Space Before Comment and move down 1 line (default)
    
    :X:it~coding::       send ^!+{F11}{4}{enter}                                ;v: indent using tabs
    :X:is~coding::       send ^!+{F12}{4}{enter}                                ;v: indent using spaces
    
    :X:L1~coding::       AddBorder("80", "_"  )                                 ;v: Add lvl 1 Border (default)
    :X:L2~coding::       AddBorder("80", "-- ")                                 ;v: Add lvl 2 Border (default)
    :X:L3~coding::       AddBorder("80", "... ")                                ;v: Add lvl 3 Border (default)  

    $+#space::                                                                  ; CB("~coding", lgreen)
    ~*$#enter::
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
    
    !o::                 send !0                                                ;V: open last editor in group
    +!Right::            send !t                                                ;V: move to group 1
    +!Left::             send +!1                                               ;V: move to group 2
    >^m::                send ^c                                                ;V: toggle tab moves focus
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

