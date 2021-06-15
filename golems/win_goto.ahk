#IfWinActive
; JUMP LISTS ___________________________________________________________________

 JL_AutoExecution:

  File_DICT    := { "f"    : "golems\_functions.ahk"                            ; options for edit file jump list
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
  
  Folder_DICT  := { "m"   : A_ScriptDir                                         ; options for open folder jump list
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
 
  Sys_DICT     := { "b"    : "BluetoothSettings"                                ; options for run system command jump list
                  , "d"    : "DisplaySettings"
                  , "v"    : "SoundSettings"
                  , "cf"   : "TglCursorFollowWin"
                  , "s"    : "StartMenu"
                  , "n"    : "NotificationWindow"
                  , "tut"  : "AHKBeginnerTutorial"
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
                  , "ac"   : "AHKconfig"
                  , "kh"   : "KeyHistory"
                  , "ws"   : "WindowSpy"
                  , "p"    : "PresentationDisplayMode"
                  , "ce"   : "CloseAllPrograms"
                  , "ss"   : "CloudSyncON"
                  , "qs"   : "CloudSyncOFF" }

  Sys_TOC      := { "b"    : "cfg`tBluetooth"                                   ; table of contents for run system command jump list
                  , "d"    : "cfg`tDisplay"                                     ; sorted by values. With a break between each user entered group prefix
                  , "v"    : "cfg`tSound"
                  , "n"    : "cfg`tNotifications"
                  , "k"    : "cfg`tQuick Connect"
                  , "i"    : "cfg`tWindows Settings"
                  , "p"    : "cfg`tPresentation mode"
                  , "Lon"  : "tgl`tTurn ON:`tWin + L Locks Computer"
                  , "Loff" : "tgl`tTurn OFF:`tWin + L Locks Computer"
                  , "cf"   : "tgl`tToggle ON/OFF: cursor follows active window"
                  , "g?~~" : "ahk`tGenerate a new shortcuts list from all running AHK scripts"
                  , "hs"   : "ahk`tOpen log of user created hotstrings"
                  , "?"    : "ahk`tOpen last generated list of shortcuts"
                  , "kh"   : "ahk`tOpen Key History (#KeyHistory > 0 required)"
                  , "ac"   : "ahk`tAHK config.ini"
                  , "b"    : "ahk`tAHK Beginner Tutorial"
                  , "tut"  : "ahk`tAHK Beginner Tutorial"
                  , "ws"   : "ahk`tOpen Window Spy"
                  , "rw"   : "ahk`tReload WinGolems (Ctrl+Win+R)"
                  , "qw"   : "ahk`tQuit WinGolems"
                  , "ws"   : "ahk`tOpen Window Spy"
                  , "x"    : "win`tStart Context Menu"
                  , "s"    : "win`tStart Menu"
                  , "ap"   : "win`tAdd Remove Programs"
                  , "r"    : "win`tOpen Run Dialog Box"
                  , "ce"   : "win`tClose All Programs"
                  , "a"    : "win`tAlarm Clock"
                  , "ss"   : "tgl`tStart Sync"
                  , "qs"   : "tgl`tQuit Sync" }


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
  
  URL_TOC :=      { "gm"   : "google`tmail"
                  , "gc"   : "google`tcalendar"
                  , "gk"   : "google`tkeep"
                  , "gn"   : "google`tnews"
                  , "f"    : "utl`tca.finance.yahoo"
                  , "w"    : "utl`tweather"
                  , "cal"  : "utl`tcalendar"
                  , "i"    : "ent`tinoreader"
                  , "t"    : "ent`ttwitter"
                  , "n"    : "ent`tnetflix"
                  , "p"    : "ent`tpocket"} 

 return 

 #n::     RunInputCommand("EditFile", File_DICT, "EDIT FILE",, lg)              ;[JL] opens file jump list
 #m::     RunInputCommand(ActivateExplorer, Folder_DICT, "OPEN FOLDER",,lb)     ;[JL] opens folder jump list
 #sc033:: RunInputCommand("LoadURL", URL_DICT, "LOAD URL", URL_TOC, lp)         ;[JL] opens webpage jump list
 #sc034:: RunInputCommand(, Sys_DICT, "RUN SYS COMMAND", Sys_TOC, ly)           ;[JL] opens sys command jump list

; ACTIVATE SAVED WINDOWS ________________________________________________________
 ; hotkey to activate window with match string anywhere in the title
 
 #F1::               SaveWinID("F1")                                            ;[ASW] (+ Alt) Saves ID of window for subsequent activation w/ LCtrl + space
 #F2::               SaveWinID("F2")                                            ;[ASW] (+ Alt) Saves ID of window for subsequent activation w/ RCtrl + space
 #F3::               SaveWinID("F3")                                            ;[ASW] (+ Alt) Saves ID of window for subsequent activation w/ #f
 #F4::               SaveWinID("F4")                                            ;[ASW] (+ Alt) Saves ID of window for subsequent activation w/ #g
 
 <^space::           ActivateWinID("F1")                                        ;[ASW] activates Window ID saved w/ #F1
 >^space::           ActivateWinID("F2")                                        ;[ASW] activates Window ID saved w/ #F2
 #f::                ActivateWinID("F3")                                        ;[ASW] activates Window ID saved w/ #F3
 #g::                ActivateWinID("F4")                                        ;[ASW] activates Window ID saved w/ #F4

; EDIT FILE ____________________________________________________________________
 ; edit file from anywhere in windows
 
 ^#g::              EditFile("golems\test.ahk")                                 ;<EF> test.ahk
 PrintScreen & g::  EditFile("golems\win_goto.ahk")                             ;<EF> win_goto.ahk
 PrintScreen & t::  EditFile("golems\win_text_navigation.ahk")                  ;<EF> win_text_navigation.ahk
 PrintScreen & r::  EditFile("golems\win_sys.ahk")                              ;<EF> win_sys.ahk
 PrintScreen & f::  EditFile("golems\_functions.ahk")                           ;<EF> _functions.ahk
 ; PrintScreen & f::  EditFile("path\example.doc")                              ;     MS office doc example; EditFile also accepts txt, ppt, xls, pdf file types


 
; GOTO FOLDER __________________________________________________________________
 
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
 #a::       ActivateApp("editor_path")                                          ;<A> VS Code
 #s::       ActivateApp("html_path")                                            ;<A> Chrome
 #w::       ActivateApp("doc_path")                                             ;<A> Word
 #e::       ActivateApp("xls_path")                                             ;<A> Excel
 #q::       ActivateApp("ppt_path")                                             ;<A> Powerpoint
 #d::       ActivateApp("pdf_path")                                             ;<A> pdf-xchange
 #t::       ActivateApp("cmd.exe")                                              ;<A> Command Window
 #b::       ActivateApp("explorer.exe", "buffer_path", True)                    ;<A> File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
 +#m::      ActivateMail()                                                      ;<A> Mail
 +#c::      ActivateCalc()                                                      ;<A> Calculator
 
 