#IfWinActive
; JUMP LISTS ___________________________________________________________________

 JL_AutoExecution:

  File_DICT :=    { "f"    : "golems\_functions.ahk"                            ; options for edit file jump list
                  , "t"    : "golems\test.ahk"  
                  , "g"    : "golems\win_goto.ahk"
                  , "p"    : "golems\Python.ahk"
                  , "tn"   : "golems\win_text_navigation.ahk"
                  , "w"    : "golems\win_sys.ahk"
                  , "ms"   : "golems\win_mem_system.ahk"
                  , "r"    : "golems\R.ahk"
                  , "wg"   : "WinGolems.ahk"
                  , "i"    : """" config_path """"
                  , "h"    : "golems\Hotkey_Help.ahk" }                              
                  
                  ; , "b"  : UProfile """\Google Drive\example.ahk"""           ; example of Editfile compatible path with spaces in the directory name; 
                  ; , "aq" : UProfile "\Google Drive\eg_folder\example.doc"     ; example of file path with spaces in directory name and MS office .doc file
                                                                                ; syntax difference with different file types is quirk of AHK
  
  Folder_DICT :=  { "m"   : A_ScriptDir                                         ; options for open folder jump list
                  , "g"   : A_ScriptDir "\golems"
                  , "c"   : hdrive
                  , "p"   : A_ProgramFiles
                  , "o"   : PF_x86
                  , "u"   : UProfile
                  , "pic" : UProfile "\Pictures"
                  , "d"   : UProfile "\Google Drive"
                  , "j"   : UProfile "\Downloads"
                  , "md"  : UProfile "\Documents"
                  , "mem" : A_ScriptDir "\mem_cache"
                  , "b"   : "buffer_path" }
 
  Command_DICT := { "b"    : "BluetoothSettings"                                ; options for run system command jump list
                  , "d"    : "DisplaySettings"
                  , "v"    : "SoundSettings"
                  , "s"    : "StartMenu"
                  , "n"    : "NotificationWindow"
                  , "r"    : "RunProgWindow"
                  , "x"    : "StartContextMenu"
                  , "a"    : "AlarmClock"
                  , "ap"   : "AddRemovePrograms"
                  , "k"    : "QuickConnectWindow"
                  , "Lon"  : "WinLLockTrue"
                  , "Loff" : "WinLLockFalse"
                  , "i"    : "WindowsSettings"
                  , "?"    : "EditHotkeyList"
                  , "hs?"  : "OpenHotStringLog"
                  , "rw"   : "ReloadAHK"
                  , "qw"   : "ExitAHK"
                  , "kh"   : "KeyHistory"
                  , "ws"   : "WindowSpy"
                  , "p"    : "PresentationDisplayMode"
                  , "ce"   : "CloseAllPrograms"
                  , "ss"   : "CloudSyncON"
                  , "qs"   : "CloudSyncOFF" }

  Command_TOC  := { "b"    : "CFG`tBluetooth"                                   ; table of contents for run system command jump list
                  , "d"    : "CFG`tDisplay"                                     ; sorted by values. With a break between each user entered group prefix
                  , "v"    : "CFG`tSound"
                  , "n"    : "CFG`tNotifications"
                  , "k"    : "CFG`tQuick Connect"
                  , "i"    : "CFG`tWindows Settings"
                  , "p"    : "CFG`tPresentation mode"
                  , "Lon"  : "LCK`tTurn ON Win + L Lock Computer Shortcut"
                  , "Loff" : "LCK`tTurn OFF Win + L Lock Computer Shortcut"
                  , "g?~~" : "HLP`tGenerate a new shortcuts list from all running AHK scripts"
                  , "hs"   : "HLP`tOpen log of user created hotstrings"
                  , "?"    : "HLP`tOpen last generated list of shortcuts"
                  , "kh"   : "AHK`tOpen Key History (#KeyHistory > 0 required)"
                  , "ws"   : "AHK`tOpen Window Spy"
                  , "rw"   : "AHK`tReload WinGolems (Ctrl+Win+R)"
                  , "qw"   : "AHK`tQuit WinGolems"
                  , "ws"   : "AHK`tOpen Window Spy"
                  , "x"    : "WIN`tStart Context Menu"
                  , "s"    : "WIN`tStart Menu"
                  , "ap"   : "WIN`tAdd Remove Programs"
                  , "r"    : "WIN`tOpen Run Dialog Box"
                  , "ce"   : "WIN`tClose All Programs"
                  , "a"    : "WIN`tAlarm Clock"
                  , "ss"   : "B/U`tStart Sync"
                  , "qs"   : "B/U`tQuit Sync" }


  URL_DICT :=     { "gm"   : "mail.google.com"
                  , "gc"   : "www.google.com/calendar"
                  , "gk"   : "keep.google.com"
                  , "gn"   : "news.google.com"
                  , "f"    : "ca.finance.yahoo.com/portfolio/pf_1/view/v1"
                  , "w"    : "www.accuweather.com/en/ca/kanata-lakes/k2l/weather-forecast/3385448"
                  , "cal"  : "calendar.sharats.me/"
                  , "i"    : "www.inoreader.com"
                  , "t"    : "twitter.com/"
                  , "n"    : "netflix.com" 
                  , "p"    : "getpocket.com/a/queue/"}
  
  URL_TOC :=      { "gm"   : "utl`tGoogle Mail"
                  , "gc"   : "utl`tGoogle Calendar"
                  , "gk"   : "utl`tGoogle Keepcom"
                  , "gn"   : "utl`tGoogle News"
                  , "f"    : "utl`tca.finance.yahoo"
                  , "w"    : "utl`tweather"
                  , "cal"  : "utl`tcalendar"
                  , "i"    : "ent`tinoreader"
                  , "t"    : "ent`ttwitter"
                  , "n"    : "ent`tnetflix"
                  , "p"    : "ent`tpocket"} 

 return 

 ; Opens various input box menues to edit different file types, open and folders.
 ; RunInputCommand(func="", dest_dict="", title_prompt="", name_dict = "",color_code ="f6f7f1")
 ^#b::    RunInputCommand("EditFile", File_DICT, "EDIT FILE",, lg)              ;[JL] opens edit file jump list
 +#b::    RunInputCommand(ActivateExplorer, Folder_DICT, "OPEN FOLDER",,lb)     ;[JL] opens goto folder jump list
 #sc034:: RunInputCommand(, Command_DICT, "RUN SYS COMMAND", Command_TOC, ly)   ;[JL] opens run sys command jump list
 #sc033:: RunInputCommand("LoadURL", URL_DICT, "LOAD URL", URL_TOC, lp)         ;[JL] opens webpage jump list

; ACTIVATE SAVED WINDOWS ________________________________________________________
 ; hotkey to activate window with match string anywhere in the title
 
 #If, GetKeyState("alt", "P")
 printscreen & q::   SaveWinID("Q")                                             ;[ASW] (+ RAlt) Saves ID of window for subsequent activation w/ printscreen & q 
 printscreen & s::   SaveWinID("S")                                             ;[ASW] (+ RAlt) Saves ID of window for subsequent activation w/ printscreen & s 
 printscreen & a::   SaveWinID("A")                                             ;[ASW] (+ RAlt) Saves ID of window for subsequent activation w/ printscreen & a 
 printscreen & z::   SaveWinID("Z")                                             ;[ASW] (+ RAlt) Saves ID of window for subsequent activation w/ printscreen & z 
 printscreen & x::   SaveWinID("X")                                             ;[ASW] (+ RAlt) Saves ID of window for subsequent activation w/ printscreen & x 
 #If
 
 printscreen & s::   ActivateWinID("S")                                         ;[ASW] activates Window ID saved w/ Ralt + Printscreen + S
 printscreen & q::   ActivateWinID("Q")                                         ;[ASW] activates Window ID saved w/ Ralt + Printscreen + Q
 printscreen & a::   ActivateWinID("A")                                         ;[ASW] activates Window ID saved w/ Ralt + Printscreen + A
 printscreen & z::   ActivateWinID("Z")                                         ;[ASW] activates Window ID saved w/ Ralt + Printscreen + Z
 printscreen & x::   ActivateWinID("X")                                         ;[ASW] activates Window ID saved w/ Ralt + Printscreen + X

 #PgUp::   SaveWinID("L")                                                       ;[ASW] Saves ID of selected window for later activation with LCtrl + space 
 #PgDn::   SaveWinID("R")                                                       ;[ASW] Saves ID of selected window for later activation with RCtrl + space 
 <^space:: ActivateWinID("L")                                                   ;[ASW] activates Window ID saved w/ Win + PgUp
 >^space:: ActivateWinID("R")                                                   ;[ASW] activates Window ID saved w/ Win + PgDn
 

 #y:: ActivateWindow("VLC media player")                                        ;[ASW] activates VLC 

; EDIT FILE ____________________________________________________________________
 ; edit file from anywhere in windows
 
 ^#g::              EditFile("golems\test.ahk")                                 ;<EF> test.ahk
 PrintScreen & g::  EditFile("golems\win_goto.ahk")                             ;<EF> win_goto.ahk
 PrintScreen & t::  EditFile("golems\win_text_navigation.ahk")                  ;<EF> win_text_navigation.ahk
 PrintScreen & r::  EditFile("golems\win_sys.ahk")                              ;<EF> win_sys.ahk
 PrintScreen & f::  EditFile("golems\_functions.ahk")                           ;<EF> _functions.ahk
 ; PrintScreen & f::  EditFile("path\example.doc")                              ;     MS office doc example (EditFile also accepts txt, ppt, xls, pdf file types)


 
; GOTO FOLDER __________________________________________________________________
 
 #m::      ActivateApp("explorer.exe", A_ScriptDir "\mem_cache")                ;<F> open mem_cache folder from anywhere in windows (new explorer instance)                                                                           
 
 SetTitleMatchMode, 2
 #IfWinActive ahk_group FileListers                                             ;    ChangeFolders works in file explorer and open file + save as dialogue boxes
 
 :*:wg>::                                                                       ;<F> AHK folder
 >+sc029::  ChangeFolder(A_ScriptDir)                                           ;<F> AHK folder
 >+1::      ChangeFolder(A_ScriptDir "\golems\")                                ;<F> AHK golems folder
 >+2::      ChangeFolder(A_ScriptDir "\lib\")                                   ;<F> AHK libs folder    
 >+m::      ChangeFolder(A_ScriptDir "\mem_cache\")                             ;<F> mem_cache
 >+c::      ChangeFolder(hdrive)                                                ;<F> %Homedrive% (C:)
 >+o::      ChangeFolder(A_ProgramFiles)                                        ;<F> C:\Program Files
 >!o::      ChangeFolder(PF_x86)                                                ;<F> C:\Program Files(x86)
 >+u::      ChangeFolder(UProfile)                                              ;<F> %UserProfile% 
 >+p::      ChangeFolder(UProfile "\Pictures\")                                 ;<F> Pictures
 >+g::      ChangeFolder(UProfile "\Google Drive")                              ;<F> Pictures
 >+j::      ChangeFolder(UProfile "\Downloads")                                 ;<F> Downloads
 >+d::      ChangeFolder(UProfile "\Documents")                                 ;<F> Documents
 >+r::      ChangeFolder("`:`:{645FF040-5081-101B-9F08-00AA002F954E}")          ;<F> Recycle bin (doesn't work for save as diag)
 >+t::      ChangeFolder("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}")          ;<F> This PC / My Computer
                                                                                ;    https://www.autohotkey.com/docs/misc/CLSID-List.htm
 #IfWinActive
 
; APPS _________________________________________________________________________
 ;shorcuts to launch/reactivate applications with the same key
 
 PrintScreen & n::                                                              ;<A> VS Code 
 #n::       ActivateApp("editor_path")                                          ;<A> VS Code
 #s::       ActivateApp("html_path")                                            ;<A> Chrome
 #w::       ActivateApp("doc_path")                                             ;<A> Word
 #q::       ActivateApp("xls_path")                                             ;<A> Excel
 #r::       ActivateApp("ppt_path")                                             ;<A> Powerpoint
 #a::       ActivateApp("pdf_path")                                             ;<A> pdf-xchange
 #t::       ActivateApp("cmd.exe")                                              ;<A> Command Window
 #b::       ActivateApp("explorer.exe", "buffer_path", True)                    ;<A> File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
 +#m::      ActivateMail()                                                      ;<A> Mail
 +#c::      ActivateCalc()                                                      ;<A> Calculator
 
 