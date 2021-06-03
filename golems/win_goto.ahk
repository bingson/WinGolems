#IfWinActive
; JUMP LISTS ___________________________________________________________________

 JumpList_AutoExecution:
  
  File_DICT :=    { "f"  : "golems\_functions.ahk"                              
                  , "t"  : "golems\test.ahk"  
                  , "g"  : "golems\win_goto.ahk"
                  , "p"  : "golems\Python.ahk"
                  , "r"  : "golems\R.ahk"
                  , "t"  : "golems\win_text_navigation.ahk"
                  , "w"  : "golems\win_sys.ahk"
                  , "ms" : "golems\win_mem_system.ahk"
                  , "wg" : "WinGolems.ahk"
                  , "i"  : """" config_path """"                                ; example of file path variable
                  ; , "b"  : UProfile """\Google Drive\example.ahk"""           ; example of file path with spaces in directory name; syntax difference with different file types is quirk of ahk
                  ; , "aq" : UProfile "\Google Drive\eg_folder\example.doc"     ; example of file path with spaces in directory name and MS office .doc file
                  , "h"  : "golems\Hotkey_Help.ahk" }
  
  Folder_DICT :=  { "m"   : A_ScriptDir                                          ; options for open folder jump list
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
                  , "ss"   : "SoundSettings"                
                  , "s"   :  "StartMenu"                
                  , "n"    : "NotificationWindow"           
                  , "r"    : "RunProgWindow"                
                  , "x"    : "StartContextMenu"             
                  , "a"    : "AlarmClock"           
                  , "arp"  : "AddRemovePrograms"           
                  , "k"    : "QuickConnectWindow"           
                  , "Lon"  : "WinLLockTrue"           
                  , "Loff" : "WinLLockFalse"           
                  , "i"    : "WindowsSettings"              
                  , "?"    : "EditHotkeyList"              
                  , "kh"   : "KeyHistory"              
                  , "ws"   : "WindowSpy"              
                  , "p"    : "PresentationDisplayMode"
                  , "cap"  : "CloseAllPrograms"
                  , "scs"  : "CloudSyncON"
                  , "ccs"  : "CloudSyncOFF" }   
 
  command_TOC  := { "b"    : "cfg:`tOpen Bluetooth Settings"                    ; table of contents for run system command jump list
                  , "d"    : "cfg:`tOpen Display Settings"                        
                  , "ss"   : "cfg:`tOpen Sound Settings"                
                  , "n"    : "cfg:`tOpen Notifications"           
                  , "x"    : "cfg:`tOpen Start Context Menu"             
                  , "k"    : "cfg:`tOpen Quick Connect Window"           
                  , "i"    : "cfg:`tOpen Windows Settings"       
                  , "p"    : "cfg:`tSet presentation display mode"
                  , "p"    : "cfg:`tSet presentation display mode"
                  , "Lon"  : "cfg:`tTurn ON Win + L Lock Computer Shortcut"           
                  , "Loff" : "cfg:`tTurn OFF Win + L Lock Computer Shortcut"           
                  , "gh~~" : "hlp:`tGenerate a new list of shortcuts from all running scripts"       
                  , "?"    : "hlp:`tOpen last generated list of shortcuts"              
                  , "kh"   : "ahk:`tOpen Key History"              
                  , "ws"   : "ahk:`tOpen Window Spy"     
                  , "s"    : "win:`tStart Menu"                
                  , "arp"  : "win:`tAdd Remove Programs"           
                  , "r"    : "win:`tOpen Run Dialog Box"                
                  , "a"    : "win:`tOpen Alarm Clock"           
                  , "cap"  : "win:`tClose All Programs"         
                  , "scs"  : "bup:`tStart Cloud Sync"
                  , "ccs"  : "bup:`tClose Cloud Sync" }  

  URL_DICT   :=   { "gm"   : "mail.google.com"
                  , "gc"   : "www.google.com/calendar"
                  , "gk"   : "keep.google.com"
                  , "gn"   : "news.google.com"
                  , "cal"  : "calendar.sharats.me/"
                  , "w"    : "www.accuweather.com"
                  , "t"    : "twitter.com/"
                  , "n"    : "netflix.com" }
    
  URL_TOC:=       { "gc"   : "utl`tGoogle Calendar"                             
                  , "gk"   : "utl`tGoogle Keepcom"
                  , "gn"   : "utl`tGoogle News"
                  , "w"    : "utl`tWeather"
                  , "cal"  : "utl`tCalendar"
                  , "f"    : "fin`tFinance.yahoo"
                  , "t"    : "sm`tTwitter"
                  , "n"    : "sm`tNetflix" }
 
   thm := new TapHoldManager(275,,maxTaps = 3,"$","")                           ; 275 ms is the detection interval for double tab triggered commands
   thm.Add("ralt",        Func("FileJumpList"))                                 ; press right ctrl twice to activate file Jump List
   thm.Add("rctrl",       Func("FolderJumpList"))                               ; press right alt twice to activate folder Jump List
   thm.Add("printscreen", Func("WinJumpList"))                                  ; press right printscreen twice to activate system command Jump List
 
 return 

 #sc01a::      RunInputCommand("EditFile", File_Dict, "EDIT FILE")              ;<JL> edit file jump list
 #sc01b::      RunInputCommand(ActivateExplorer, Folder_Dict, "OPEN FOLDER")    ;<JL> open folder jump list
 #sc02b::      RunInputCommand(, Command_DICT, "RUN SYS COMMAND", Command_TOC)  ;<JL> run sys command jump list
 #sc033::      RunInputCommand("LoadURL", URL_DICT, "LOAD URL", URL_TOC)        ;<JL> url jump list

; TITLE MATCH __________________________________________________________________
 ; hotkey to activate window with match string anywhere in the title
 
 SetTitleMatchMode, 2
 
 <^space::                                                                      ;<TM> activate udemy window, 
    ReleaseModifiers()                                                          ;     note: VLC windows can't distinguish between lctrl vs rctrl
    ActivateWindow("Google Chrome")                                                               
    return

 >^space::                                                                      ;<TM> Jupyter window
    ReleaseModifiers()                                                          ;     window search will stop after the first successful activation
    ActivateWindow("WinGolems")      
    return

; EDIT FILE ____________________________________________________________________
 ; edit file from anywhere in windows; if already open but not active, hotkey will activate file window
 
 ^#g::              EditFile("golems\test.ahk")                                 ;<EF> test.ahk
 PrintScreen & g::  EditFile("golems\win_goto.ahk")                             ;<EF> win_goto.ahk
 PrintScreen & t::  EditFile("golems\win_text_navigation.ahk")                  ;<EF> win_text_navigation.ahk
 PrintScreen & w::  EditFile("golems\win_sys.ahk")                              ;<EF> win_sys.ahk
 PrintScreen & f::  EditFile("golems\_functions.ahk")                           ;<EF> _functions.ahk
 ; PrintScreen & f::  EditFile("path\example.doc")                              ;     MS office doc example (EditFile also accepts txt, ppt, xls, pdf file types)


 
; GOTO FOLDER ________________________________________________________________
 
 printscreen & m::                                                              ;<F> open mem_cache folder from anywhere in windows (new explorer instance)                                                                           
 #m::      ActivateApp("explorer.exe", A_ScriptDir "\mem_cache")                ;<F> open mem_cache folder from anywhere in windows (new explorer instance)                                                                           
  
 
 SetTitleMatchMode, 2
 #IfWinActive ahk_group FileListers                                             ;    ChangeFolders works in file explorer and open file + save as dialogue boxes
 
 >+sc029::  ChangeFolder(A_ScriptDir)                                           ;<F> AHK folder
 :*:golems>::                                                                   ;<F> AHK golems folder
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
 #a::       ActivateApp("xls_path")                                             ;<A> Excel
 #q::       ActivateApp("ppt_path")                                             ;<A> Powerpoint
 #r::       ActivateApp("pdf_path")                                             ;<A> pdf-xchange
 #t::       ActivateApp("cmd.exe")                                              ;<A> Command Window
 PrintScreen & b::                                                              ;<A> File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
 #b::       ActivateApp("explorer.exe", "buffer_path", True)                    ;<A> File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
 +#m::      ActivateMail()                                                      ;<A> Mail
 +#c::      ActivateCalc()                                                      ;<A> Calculator
 