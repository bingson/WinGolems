#IfWinActive
  
  #space:: CB("~win")                                                           ; opens command box that runs ~win suffix CB keys

; CB hotkey assignment _________________________________________________________; shared by all Command Boxes 

  #IF WinActive("ahk_id " ghwnd) or TitleTest("(-_-)")                          ; If command Box active

  !q::          MoveWin("TL")                                                   ;mw: move CB window to top left
  !e::          MoveWin("TR")                                                   ;mw: move CB window to top right
  !z::          MoveWin("BL")                                                   ;mw: move CB window to bottom left
  !c::          MoveWin("BR")                                                   ;mw: move CB window to bottom right
  !w::          MoveWin("T")                                                    ;mw: move CB window to top half
  !s::          MoveWin("B")                                                    ;mw: move CB window to bottom half
  #left::                                                                       ;mw: move CB window to left half
  !a::          MoveWin("L")                                                    ;mw: move CB window to left half
  #right::                                                                      ;mw: move CB window to right half
  !d::          MoveWin("R")                                                    ;mw: move CB window to right half
  #space::      GUISubmit()                                                     ;mw: submit GUI input 
  $!x::         ToggleDisplay()                                                 ;mw: toggle Command Box display/minimalist mode
  !r::          GUIRecall()                                                     ;mw: reenter last command

  #IF WinExist("ahk_id " ghwnd) and !WinActive("ahk_id " ghwnd)                 ; If command Box exists
  
  $<^space::                                                                    ; activate CB if exists and move focus to inputbox
  $>^space:: ActivateWin("ahk_id " ghwnd)                                       ; activate CB if exists and move focus to inputbox

  #IF                                                                           ; end context specific assignments

; CB key assignment: System Commands ___________________________________________

  :X:b~win::    BluetoothSettings()                                             ;sc: bluetooth settings
  :X:d~win::    DisplaySettings()                                               ;sc: display settings
  :X:n~win::    NotificationWindow()                                            ;sc: notification window
  :X:v~win::    SoundSettings()                                                 ;sc: sound settings
  :X:r~win::    RunProgWindow()                                                 ;sc: run program
  :X:x~win::    StartContextMenu()                                              ;sc: context menu for the Start button
  :X:k~win::    QuickConnectWindow()                                            ;sc: quick connect window
  :X:i~win::    WindowsSettings()                                               ;sc: windows settings
  :X:p~win::    PresentationDisplayMode()                                       ;sc: presentation display mode
  :X:s~~win::   PowerOptions("sleep")                                           ;sc: enter sleep mode
  :X:h~~win::   PowerOptions("hybernate")                                       ;sc: enter hybernate mode
  :X:sd~~win::  PowerOptions("shutdown")                                        ;sc: shutdown + power down 
  :X:rs~~win::  PowerOptions("restart")                                         ;sc: restart the computer
  :X:a~win::    Run assets\win\Alarms & Clock.lnk                               ;sc: alarm clock
  :X:m~win::    sendEmail()                                                     ;sc: send mail
  :X:ce~~win::  CloseAllPrograms()                                              ;sc: close all open programs 
  :X:ss~win::   CloudSync("ON")                                                 ;sc: turn on cloud sync 
  :X:qs~win::   CloudSync("OFF")                                                ;sc: turn off cloud sync
  :X:lt~win::   WinLLock(True)                                                  ;sc: turn on win+L locks computer
  :X:lf~win::   WinLLock(False)                                                 ;sc: turn off win+L locks computer
  :X:ap~win::   Run assets\win\Add Remove Programs.lnk                          ;sc: open add remove programs 
   #Lbutton::                                                                   ;sc: open start menu (alt: Ctrl+Esc)
   $^#Enter::                                                                   ;sc: open start menu (alt: Ctrl+Esc)
  :X:s~win::    send ^{esc}                                                     ;sc: open start menu (alt: Ctrl+Esc)
  :X:mod~win::  MoveWindowToOtherDesktop()                                      ;sc: Move window to other desktop
  :X:de~win::   send #{tab}                                                     ;sc: desktop environment overview

; CB keys assignment: AHK UTILITIES ____________________________________________  

  :X:oc~win::   OpenFolder("mem_cache\")                                        ;ahk: open cache folder in file explorer
  :X:kh~win::   KeyHistory                                                      ;ahk: open key history
  :X:ws~win::   run, C:\Program Files\AutoHotkey\WindowSpy.ahk                  ;ahk: open windows spy
  :X:ec~win::   EditFile("""" config_path """")                                 ;ahk: edit config.ini file
  :X:tut~win::  loadURL("autohotkey.com/docs/Tutorial.htm")                     ;ahk: AHK beginner tutorial
  :X:tcf~win::   TglSetting("cursor_follow", "Cursor follows active window: ")  ;ahk: toggle mouse cursor follows active window
  ~+#left::                                                                     ;ahk: cursor follows active window when moving apps btn monitors (if turned on)
  ~!tab::       CursorFollowWin()                                               ;ahk: cursor follows active window when switch apps with alt+tab (if turned on)
  :X:clp~win::  WriteToINI(A_ComputerName, "CL_prfx")                           ;ahk: store selected text as label prefix
  :X:cls~win::  WriteToINI(A_ComputerName, "CL_sffx")                           ;ahk: store selected text as label suffix
  :X:cl~win::   CreateLabel("CL_prfx", "CL_sffx")                               ;ahk: create hotstring label with execution option
  :X:!cl~win::  CreateLabel("!", "CL_sffx")                                     ;ahk: create normal label
  
  :X:gl~win::   GenerateHotkeyList()                                            ;ahk: generate a list of hotkeys in working directory.
  
  :X:q~~win::                                                                   ;ahk: quit ahk script
  +^#q::        ExitApp                                                         ;ahk: quit ahk script
  lshift & rshift::                                                             ;ahk: reload ahk script
  rshift & lshift::                                                             ;ahk: reload ahk script
  :X:r~~win::   Reload                                                          ;ahk: reload ahk script

; developer options ____________________________________________________________
  
  :X:td~win::                                                                   ;[T] toggle developer optns
    CC("T_d","!")
    PopUp("Developer options on: " GC("T_d"))
    return

  #IF GC("T_d",0) ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
    printscreen & j::               Sendinput {WheelDown 5}                     ;m: scroll wheel down                                               
    printscreen & k::               Sendinput {WheelUp 5}                       ;m: scroll wheel Up    
      
    #z::                                                                           ;<TMA> Tabs Outliner and pinned webpages
      SetTitleMatchMode, 2
      If WinExist("Tabs Outliner")                                                
      || WinExist("My PTF")                                                       
      || WinExist("Playlists")
      || WinExist("Play Later")
      || WinExist("All")
      || WinExist("Player FM")
      || WinExist("Track order")
      || WinExist("Google Keep")
      || WinExist("WebBroker")
      ; || WinExist("Inbox")
      ; || WinExist("gmail")
      ; || WinExist("Twitter")
      ; || WinExist("Inoreader")
      {
         ;  ReleaseModifiers("10")
          WinActivate
      }   
      else 
      {
          ActivateApp("html_path")
          sleep, long
          Send ^n
          sleep, med
          send ^.                                                                ; chrome shortcut to activate tabsoutliner
          sleep, med
          Send ^w
          sleep, med
          Send w
          sleep, med
          Send {alt down}{sc033}{alt up}
      }
      CursorFollowWin()
      return

    
  #IF GC("T_d",0) and WinActive("ahk_exe " exe["editor"]) ;-- -- -- -- -- -- -- 
                           
    :X:c~~coding::       Send +^!g                                                ;V: git commit all
    :X:m>:: clip("msgbox % ")
    printscreen & tab::      AddSpaceBeforeComment("80")                          ;v: Add Space Before Comment (default)
    printscreen & capslock:: AddSpaceBeforeComment("80"), s("down")               ;v: Add Space Before Comment and move down 1 line (default)
    
    :X:it~coding::       send ^!+{F11}{4}{enter}                                  ;v: indent using tabs
    :X:is~coding::       send ^!+{F12}{4}{enter}                                  ;v: indent using spaces
    
    :X:L1~coding::       AddBorder("80", "_"  )                                   ;v: Add lvl 1 Border (default)
    :X:L2~coding::       AddBorder("80", "-- ")                                   ;v: Add lvl 2 Border (default)
    :X:L3~coding::       AddBorder("80", "... ")                                  ;v: Add lvl 3 Border (default)  

    $+#space::                                                                    ; CB("~coding", lgreen)
    ~*$#enter::
    #space::             CB("~coding", C.lgreen)                                  ; CB("~coding", lgreen)
    
    $+^sc028::           FocusResults()                                           ; move focus to search results
    :X:sa~coding::       Send +^!s                                                ; save as
    $^+sc027::           send +!^c                                                ; collapse search results
    $<+Space::                                                                    ; indent 1 space to left
       send +{right}
       send +{space}{left}
       return
    $>+Space::           Send ^!+i                                                ; indent 1 space to right
    
    :X:cfg~coding::      send {F9}                                                ;V: settings.json
    ^tab::               Send % (toggle := !toggle) ? "^1" : "^2"                 ;V: fold/unfold all regions toggle
    !s::                 send ^{F3}                                               ;V: move to next instance of selected text 
    +^y::                +^u                                                      ;V: output console
    +^!r::               send {F2}                                                ;V: rename (F2)
    
    +>!j::
    +!^j::               send +!^{down}                                           ;V: create multicursor instance below
    +>!k::
    +!^k::               send +!^{up}                                             ;V: create multicursor instance above
    
    !o::                 send !0                                                  ;V: open last editor in group
    +!Right::            send !t                                                  ;V: move to group 1
    +!Left::             send +!1                                                 ;V: move to group 2
    >^m::                send ^c                                                  ;V: toggle tab moves focus
    <^m::                send ^m                                                  ;V: toggle tab moves focus
    +^!o::               send +^u                                                 ;V: toggle output window
    !d::                 send +^k                                                 ;V: delete line
    ^!d::                send +!{down}                                            ;V: duplicate line
    +^d::                send +^l                                                 ;V: Select all occurrences of current selection
    ^!sc01a::            Send % (toggle := !toggle) ? "^k^9" : "^k^8"             ;V: fold/unfold all regions toggle
    >^f::                                                                         ;NAV: search all files in folder
    :X:f~coding::        send +^f                                                 ;NAV: search all files in folder
    :X:h~coding::                                                                 ;NAV: search & replace all files in folder (+subdirectories)
    +^!f::               Send +^h                                                 ;NAV: search & replace all files in folder
    $>!f::                                                                        ;V: move focus to search results
                         send +^f
                         sleep med
                         send ^{down 3}
                         return  

    ^!sc035::            Send % (toggle := !toggle) ? "^k^0" : "^k^j"             ;V: fold/unfold all code toggle
    ^q::                 Send ^{sc035}                                            ;V: toggle comment
    ^sc035::             send +^{[}                                               ;V: fold current code level
    !sc035::             send +^{]}                                               ;V: unfold current code level
    +^sc035::            send ^k^[                                                ;V: fold recursively 
    +!sc035::            send ^k^]                                                ;V: unfold recursively
    >+^enter::           send ^kz                                                 ;V: zen mode
    !p::                 send ^w                                                  ;V: close tab
    !g::                 send +!{Right}                                           ;V: select all text in between brackets
    :X:c~~coding::       Send +^!g                                                ;V: git commit all
   
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
    F1 & k::                                                                      ;V: clear all bookmarks
                         send +^!p                                                 
                         PopUp("Clear bookmarks",C.lblue)
                         return
    +^g::                                                                         ;V: source control 
                          ;ReleaseModifiers()
                         send +^g
                         send g
                         return
   
    +!0::                                                                         ;V: fold code to level 0
    +!1::                                                                         ;V: fold code to level 1
    +!2::                                                                         ;V: fold code to level 2
    +!3::                                                                         ;V: fold code to level 3
    +!4::                                                                         ;V: fold code to level 4
    +!5::                                                                         ;V: fold code to level 5
    +!6::                                                                         ;V: fold code to level 6
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
    ^0:: send % "!" . substr(A_ThisHotkey, 0)                                    ;v: activate tab # 
    
    !1::                                                                           
    !2::                                                                           
    !3:: send % "^" . substr(A_ThisHotkey, 0)                                    ;v: activate editor group #

  #IF GC("T_d",0) and WinActive("ahk_exe " exe["html"]) ;-- -- -- -- -- -- -- --
  
    ; CB / URLS ____________________________________________________________________
         
     $#enter::
     printscreen & space::
     #space:: CommandBox("~html", C.pink) ; "URL_TOC"              ;<JL> opens edit file jump list
    
     :X:sr~html:: loadurl("https://elevanth.org/blog/2021/06/21/regression-fire-and-dangerous-things-2-3/")
     :X:gm>~win::
     gm~html:
     $!1::             LoadURL("mail.google.com")
     i~html:
     :X:i>~win::
     $!2::             LoadURL("www.inoreader.com")
     :X:t>~win::
     t~html:
     $!3::             LoadURL("twitter.com")
     
     
     :X:u~html::     LoadURL("www.udemy.com/course/causal-data-science/")       
     :X:sr~html::    LoadURL("www.youtube.com/playlist?list=PLDcUM9US4XdM9_N6XUUFrhghGJ4K25bFc")      
     
     :X:p~html::
     :X:p>~win::
     $!7::             LoadURL("getpocket.com/a/queue/")
    
     $+!8::            LoadURL("player.fm/player413982046/play-later")
     :X:fm~html::
     :X:pod~html::
     $!8::             LoadURL("player.fm/player413982046/subs/all")
         
     $!0::             LoadURL("www.youtube.com/")
     $!^0::            LoadURL("www.youtube.com/feed/subscriptions")
     $+!0::            LoadURL("www.youtube.com/playlist?list=WL")
     $+^0::            LoadURL("www.youtube.com/feed/history")
     :X:v>~win::
     :X:v~html::     LoadURL("main.dailyflix.one/")                                  ; !5 reserved for %%
     :X:b>~win::
     :X:b~html::     LoadURL("movies7.to/tv-series") 
     :X:n~html::     LoadURL("netflix.com")
     :X:pymc~html::  LoadURL("docs.pymc.io/notebooks/api_quickstart.html")      
     :X:c~html::     LoadURL("https://coolors.co/generate")
     :X:cw~html::    LoadURL("https://colorswall.com/palette/62609/")
     :X:gc~html::    LoadURL("www.google.com/calendar")
     :X:gk>~win::
     :X:gk~html::    LoadURL("keep.google.com")
     :X:gn~html::    LoadURL("news.google.com")
     :X:f>~win::
     :X:f~html::     LoadURL("ca.finance.yahoo.com/portfolio/pf_1/view/v1")
     :X:w>~win::
     :X:w~html::     LoadURL("www.accuweather.com/en/ca/kanata-lakes/k2l/weather-forecast/3385448")
     :X:wb~html::    LoadURL("webbroker.td.com/waw/idp/login.htm?execution=e1s1")
     :X:td~html::    LoadURL("authentication.td.com/uap-ui/index.html?consumer=easyweb&locale=en_CA#/login/easyweb-getting-started")
     :X:ub~html::    LoadURL("chrome-extension://cjpalhdlnbpafiamejdnhcphjbkeiagm/dashboard.html#1p-filters.html")
     :X:cal~html::   LoadURL("calendar.sharats.me/")
     :X:tv~html::    LoadURL("www.tvguide.com/new-tonight/")
     :X:wg~html::    LoadURL("github.com/bingson/wingolems")
     
     :X:ks~html::    ChromeConfig("chrome://extensions/shortcuts/")
     xt~html:
     :X:ext~html::   ChromeConfig("chrome://extensions/")
     +^!r::                                                                      ; restart browser
     :X:rs~html::    ChromeConfig("chrome://restart")
     settings~html:
     config~html:
     :X:cfg~html::   ChromeConfig("chrome://settings")
     handlers~html:
     :X:hdlrs~html:: ChromeConfig("chrome://settings/handlers")
    
    ; CONVENIENCE / EXTENSIONS _____________________________________________________
     #If WinActive("ahk_exe chrome.exe") 
    
     #If GetKeyState("shift", "P")
        printscreen & n::
     #If 
     +#n::   CursorJump("B",,"-20"), CursorJump("L","20"), clicks(1)               ;[MF] click to open downloaded file
     
     :X:.~html:: send !{sc033}
    
     ;  $+!sc034:: send {sc01b 2}                                                   ?
     $^space:: send {enter}   
     
     !pgup::                send ^r
     :X:url~html:: send +!i
     ~^w:: Send ^w                                                                  ; close tab
     !p:: Send ^w                                                                   ; close tab
     ^SC034::               send +^{SC034}                                          ; move tab to first position
     ^SC033::               send +^{SC033}                                          ; move tab to last position
     $!i::                  Send ^{Numpad1}                                         ; select 1st tab
     $!o::                  Send ^{Numpad9}                                         ; select last tab
     $+^!w::Send +^q                                                                ; save and close all browser windows
    
    ; GOOGLE DRIVE _________________________________________________________________
        
        $+!^1:: OpenGoogleDrive(1)
        $+!^2:: OpenGoogleDrive(2)
        $+!^3:: OpenGoogleDrive(3)
        $+!^4:: OpenGoogleDrive(4)
    
    ; TABS OUTLINER ________________________________________________________________
        SetTitleMatchMode, 2
        #If WinActive("ahk_exe chrome`.exe") && TitleTest("Tabs Outliner")
        
        ; #If WinActive("Tabs Outliner") 
        ; ## TABS OUTLINER SHORTCUTS
        ; +^a:: Save and Close all open windows
        ; +!w:: Save and Close current tab
        ; +^w:: Save and Close current window
        ; ^!Space = takes current tab in tree and makes a new tree
        
        $^SC035:: 
        $!SC035:: Send {SC00D}   ;SC035 = /
        
        $^s::Send {backspace}
        ; $enter::Send {space}
        !n::
        !r::
        ^r::Send {F2}

  