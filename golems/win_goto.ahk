; JUMP LISTS ___________________________________________________________________

 JumpList_AutoExecution:
  
  File_Dict := { "f"  : "golems\_functions.ahk"                                 ; options for edit file jump list
               , "t"  : "golems\test.ahk"  
               , "g"  : "golems\win_goto.ahk"
               , "p"  : "golems\Python.ahk"
               , "r"  : "golems\R.ahk"
               , "t"  : "golems\win_text_navigation.ahk"
               , "w"  : "golems\win_sys.ahk"
               , "ms" : "golems\win_mem_system.ahk"
               , "wg" : "WinGolems.ahk"
               , "b"  : UProfile """\Google Drive\secure\bing.ahk"""            ; example of file path with spaces in directory name i.e., "Google Drive"
               , "aq" : UProfile "\Google Drive\1-Jobs\2_Monzo\AQ_1_1.docm"
               , "i"  : """" config_path """"                                   ; example of file path variable with spaces in directory name
               , "h"  : "golems\Hotkey_Help.ahk" }
  
  
  Folder_Dict := { "m"   : A_ScriptDir                                          ; options for open folder jump list
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
 
  command_dict := { "b"    : "BluetoothSettings"                                ; options for run system command jump list
                  , "d"    : "DisplaySettings"              
                  , "s"    : "SoundSettings"                
                  , "n"    : "NotificationWindow"           
                  , "r"    : "RunProgWindow"                
                  , "x"    : "StartContextMenu"             
                  , "a"    : "AlarmClock"           
                  , "arp"  : "AddRemovePrograms"           
                  , "c"    : "QuickConnectWindow"           
                  , "lon"  : "WinLLockTrue"           
                  , "loff" : "WinLLockFalse"           
                  , "i"    : "WindowsSettings"              
                  , "?"    : "EditHotkeyList"              
                  , "kh"   : "KeyHistory"              
                  , "ws"   : "WindowSpy"              
                  , "p"    : "PresentationDisplayMode"
                  , "cap"  : "CloseAllPrograms"
                  , "ss"   : "CloudSyncON"
                  , "cs"   : "CloudSyncOFF" }   
 
  TOC_dict     := { "b"    : "cfg:`tOpenBluetoothSettings"                      ; table of contents for run system command jump list
                  , "d"    : "cfg:`tOpenDisplaySettings"              
                  , "s"    : "cfg:`tOpenSoundSettings"                
                  , "n"    : "cfg:`tOpen Notifications"           
                  , "x"    : "cfg:`tOpenStartContextMenu"             
                  , "c"    : "cfg:`tOpenQuickConnectWindow"           
                  , "i"    : "cfg:`tOpenWindowsSettings"              
                  , "p"    : "cfg:`tSet presentation display mode"
                  , "p"    : "cfg:`tSet presentation display mode"
                  , "lon"  : "cfg:`tTurn ON Win + L Lock Computer Shortcut"           
                  , "loff" : "cfg:`tTurn OFF Win + L Lock Computer Shortcut"           
                  , "gh~~" : "ahk:`tGenerate a new list of shortcuts from all running scripts"       
                  , "?"    : "ahk:`tOpen last generated list of shortcuts"              
                  , "kh"   : "ahk:`tOpen Key History"              
                  , "ws"   : "ahk:`tOpen Window Spy"     
                  , "arp"  : "app:`tAddRemovePrograms"           
                  , "r"    : "app:`tOpen Run Dialog Box"                
                  , "a"    : "app:`tOpenAlarmClock"           
                  , "cap"  : "app:`tCloseAllPrograms"         
                  , "ss"   : "bup:`tStart Cloud Sync"
                  , "cs"   : "bup:`tClose Cloud Sync" }  
 
   thm := new TapHoldManager(250,,maxTaps = 3,"$","")                           ; 300 ms is the detection interval for double tab triggered commands
   thm.Add("rctrl",       Func("FileJumpList"))                                 ; press right ctrl twice to activate file Jump List
   thm.Add("ralt",        Func("FolderJumpList"))                               ; press right alt twice to activate folder Jump List
   thm.Add("printscreen", Func("WinJumpList"))                                  ; press right alt twice to activate system command Jump List
 
 return 

 #sc01a::      RunInputCommand("EditFile", File_Dict, "EDIT FILE")              ;<JL> opens edit file jump list
 #sc01b::      RunInputCommand(ActivateExplorer, Folder_Dict, "OPEN FOLDER")    ;<JL> opens goto folder jump list
 #sc02b::      RunInputCommand(, command_dict, "RUN SYS COMMAND", TOC_dict)     ;<JL> opens run sys command jump list

; TITLE MATCH __________________________________________________________________
 ; hotkey to activate window with match string anywhere in the title
 
 SetTitleMatchMode, 2
 
 <^space::                                                                      ;<TM> activate udemy window, 
    ReleaseModifiers()                                                          ;     note: VLC windows can't distinguish between lctrl vs rctrl
    ActivateWindow("Udemy")                                                               
    return

 >^space::                                                                      ;<TM> Jupyter window
    ReleaseModifiers()                                                          ;     window search will stop after the first successful activation
    ActivateWindow("Home Page - Select or create a notebook - Google Chrome")      
    ActivateWindow("1_DAG")
    ActivateWindow("Jupyter Notebook")
    return


 #y:: ActivateWindow("VLC media player")                                        ;<TM> VLC

; EDIT FILE ____________________________________________________________________
 ; edit file from anywhere in windows; if already open but not active, hotkey will activate file window
 
 ^#g::              EditFile("golems\test.ahk")                                 ;<EF> test.ahk
 PrintScreen & g::  EditFile("golems\win_goto.ahk")                             ;<EF> win_goto.ahk
 PrintScreen & t::  EditFile("golems\win_text_navigation.ahk")                  ;<EF> win_text_navigation.ahk
 PrintScreen & w::  EditFile("golems\win_sys.ahk")                              ;<EF> win_sys.ahk
 PrintScreen & f::  EditFile("golems\_functions.ahk")                           ;<EF> _functions.ahk


 
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
 ^#!m::     ActivateMail()                                                      ;<A> Mail
 +#c::      ActivateCalc()                                                      ;<A> Calculator
 